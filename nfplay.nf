#!/usr/bin/env nextflow

/* This nextflow script is initially based on wc.nf from https://carpentries-incubator.github.io/workflows-nextflow/aio/index.html.
It was created with some minor modifications but will diverge as more functions are added.
The initial goal of this nextflow is going to be to rename and combine some fastq files then run fastp on them.
Other functions may be added with time, e.g. kmer analysis and genomescope.
*/

// This enables DSL2 syntax. I am not sure what that means, so look it up if things are not working.
// nextflow.enable.dsl=2

/*  Usage:
       nextflow run nfplay.nf --input <input_file>
       
       where input_file should be a gzipped fastq file.
*/

/*  Workflow parameters are written as params.<parameter>
    and can be initialised using the `=` operator. */
params.input = "data/yeast/reads/ref1_1.fq.gz"

/* This workflow performs the following steps:
    1. Count and print the number of lines for a gzipped file.
*/

//  The default workflow
workflow {

    //  Input data is received through channels
    input_ch = Channel.fromPath(params.input)

    /*  The script to execute is called by its process name,
        and input is provided between brackets. */
    NUM_LINES(input_ch)

    /*  Process output is accessed using the `out` channel.
        The channel operator view() is used to print
        process output to the terminal. */
    NUM_LINES.out.view()
}

/*  A Nextflow process block
    Process names are written, by convention, in uppercase.
    This convention is used to enhance workflow readability. */
process NUM_LINES {

    input:
    path read

    output:
    stdout

    script:
    /* Triple quote syntax """, Triple-single-quoted strings may span multiple lines. The content of the string can cross line boundaries without the need to split the string in several pieces and without concatenation or newline escape characters. */
    """
    printf '${read} '
    zcat ${read} | wc -l
    """
}
