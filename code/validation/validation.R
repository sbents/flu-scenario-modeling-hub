library(SMHvalidation)
library(gh)

# check if submissions file
pr_files <- gh::gh(paste0("GET /repos/", 
                          "midas-network/flu-scenario-modeling-hub/", "pulls/",
                          Sys.getenv("GH_PR_NUMBER"),"/files"))

pr_files_name <- purrr::map(pr_files, "filename")
pr_sub_files <- grep(
  "data-processed/.*/\\d{4}-\\d{2}-\\d{2}(.+)?(|_).+(.csv|.zip|.gz|.pqt|.parquet)", pr_files_name,
  value = TRUE)
pop_path <- "data-locations/locations.csv"
js_def_file <- "hub-config/tasks.json"
lst_gs <- NULL

# Run validation on file corresponding to the submission file format
if (length(pr_sub_files) > 0) {  
  team_name <- unique(basename(dirname(pr_sub_files)))
  sub_file_date <- unique(stringr::str_extract(basename(pr_sub_files),
                                               "\\d{4}-\\d{2}-\\d{2}"))
  group_files <- paste0(sub_file_date, "-", team_name)

  test_tot <- lapply(group_files, function(y) {
    # select submission files
    pr_sub_files_group <- grep(y, pr_sub_files, value = TRUE)
    pr_sub_files_lst <- pr_files[purrr::map(pr_files, "filename") %in%
                                   pr_sub_files_group]
    if (length(pr_sub_files_lst) > 0) {
      test_tot <- lapply(seq_len(length(pr_sub_files_lst)), function(x) {
        # submission file
        url_link <- URLdecode(pr_sub_files_lst[[x]]$raw_url)
        # Download for Parquet and compressed file format
        if (grepl(".zip$|.gz$|.parquet$|.pqt$", url_link)) 
          download.file(url_link, basename(url_link))
      })
      # run validation
      test <- capture.output(try(
        validate_submission(basename(pr_sub_files_group), js_def = js_def_file,
                            lst_gs = lst_gs, pop_path = pop_path)))
      if (length(grep("Run validation on fil", test, invert = TRUE)) == 0) {
        test <- try(
          validate_submission(basename(pr_sub_files_group), js_def = js_def_file,
                              lst_gs = lst_gs, pop_path = pop_path))
        test <- test[1]
      }
      # list of the validation results
      test_tot <- list(valid = test)
    } else {
      test_tot <-  list(
        valid = paste0(
          "No projection submission file in the standard SMH file ",
          "format found in the Pull-Request for: ", y))
    }
    # returns all output
    return(test_tot)
  })
} else {
    test_tot <-  list(list(
      valid = paste0(
        "No projection submission file in the standard SMH file ",
        "format found in the Pull-Request. No validation was run.")
      ))
}
 
# Post validation results as comment on the open PR
test_valid <- purrr::map(test_tot, "valid")
message <- purrr::map(test_valid, paste, collapse = "\n")

lapply(seq_len(length(message)), function(x) {
  gh::gh(paste0("POST /repos/", "midas-network/flu-scenario-modeling-hub/", 
                "issues/", Sys.getenv("GH_PR_NUMBER"),"/comments"),
         body = message[[x]],
         .token = Sys.getenv("GH_TOKEN"))
})

# Post visualization results as comment on the open PR
#test_viz <- purrr::map(test_tot, "viz")
#if (any(!is.na(test_viz))) {
#  message_plot <- paste0(
#    "If the submission contains a projection file, a pdf containing the ",
#    "visualization plots of the submission is available and downloadable ",
#    "in the GitHub actions. Please click on 'details' on the right of the ",
#    "'Validate submission' checks. The pdf is available in a ZIP file as ",
#    "an artifact of the GH Actions. For more information, please see ",
#    "[here](https://docs.github.com/en/actions/managing-workflow-runs/downloading-workflow-artifacts)")
#
#  if (any(unlist(purrr::map(test_viz, class)) == "try-error")) {
#    message_plot <- capture.output(
#      cat(paste0(message_plot, "\n\n\U000274c Error: ",
#      "The visualization encounters an issue and might not be available,",
#      " if the validation does not return any error, please feel free to ",
#      "tag `@LucieContamin` for any question.")))
#  }
#
#  gh::gh(paste0("POST /repos/", "midas-network/flu-scenario-modeling-hub/", 
#                "issues/", Sys.getenv("GH_PR_NUMBER"),"/comments"),
#         body = message_plot,
#         .token = Sys.getenv("GH_TOKEN"))
#}

# Validate or stop the github actions
if (any(grepl("(\U000274c )?Error", test_valid))) {
  stop("The submission contains one or multiple issues")
} else if (any(grepl("Warning", test_valid))) {
  warning(" The submission is accepted but contains some warnings")
}
