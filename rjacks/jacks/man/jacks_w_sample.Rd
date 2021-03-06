% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/io.R
\name{jacks_w_sample}
\alias{jacks_w_sample}
\title{Extract JACKS output for a sample}
\usage{
jacks_w_sample(expt, sample)
}
\arguments{
\item{expt}{Output of JACKS inference - SummarizedExperiment endowed with posteriors.}

\item{sample}{Sample name to extract information for.}
}
\value{
\code{data.table} object estimated means and standard deviations of gene essentiality.
}
\description{
\code{jacks_w_sample()} takes JACKS output and sample name, and returns a \code{data.frame}
that has columns for statistics of JACKS inferred posterior for gene essentiality w - mean
and standard deviation. Each row is one gene (name in row.names).
}
