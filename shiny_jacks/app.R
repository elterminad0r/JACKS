library(shiny)
library(jacks)

# Define UI for app that draws a histogram ----
ui <- fluidPage(

  # App title ----
  titlePanel("JACKS"),

  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    # Main panel for displaying outputs ----
    mainPanel(

      # Output: Histogram ----
      plotOutput(outputId = "distPlot")

    )
  )
)

# Define server logic required to draw a histogram ----
server <- function(input, output) {

  # Histogram of the Old Faithful Geyser Data ----
  # with requested number of bins
  # This expression that generates a histogram is wrapped in a call
  # to renderPlot to indicate that:
  #
  # 1. It is "reactive" and therefore should be automatically
  #    re-executed when inputs (input$bins) change
  # 2. Its output type is a plot
  output$distPlot <- renderPlot({
    ## ----counts, warning=FALSE, message=FALSE--------------------------------
    count_file <- system.file("extdata", "example_count_data.tab",
                              package="jacks", mustWork=TRUE)
    sample_spec_file <- system.file("extdata", "example_repmap.tab",
                                    package="jacks", mustWork=TRUE)
    lfc <- read_counts_from_spec_files(count_file, sample_spec_file,
                                       replicate_col="Replicate",
                                       sample_col="Sample",
                                       gene_spec_file=count_file, grna_col="sgRNA",
                                       gene_col="gene", count_prior=32.,
                                       normalization='median', window=800,
                                       reference_sample="CTRL")

    ## ----JACKS, warning=FALSE, message=FALSE---------------------------------
    test_genes <- c("KRAS", "RRM2", "ZNF253")
    result <- infer_jacks(lfc, test_genes)


    ## ----jacks_ref, warning=FALSE, message=FALSE-----------------------------
    result <- infer_jacks(lfc, test_genes, reference_library="yusa_v10")

    ## ----plot, fig.width=10, fig.height=10, echo=TRUE, warning=FALSE---------
    plot_jacks(result, "KRAS", do_save=FALSE)

    })

}

# Create Shiny app ----
shinyApp(ui = ui, server = server)




