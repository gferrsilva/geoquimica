
# geoquimica v0.1.1: exploration data analysis with geochemistry data.

<!-- badges: start -->
<!-- badges: end -->

This is 'geoquimica', an open-source R package that gathers functions for assist on the exploration data analysis of geochemistry data. This package was built by researchers of the Geological Survey of Brazil.
This package helps to deal with the geochemistry data processing
of a typical routine after the analysis. It read a default flat file of the GEOSOL/SGS report, storing the metadata into an object, and skipping header and footer lines. Also, it is able to filter the elements by the number of non-censured data, replaces the censured data to default values, transform the data into minmax or centered log-ratio distribution, and more. Written to be used by the Geochemistry Division Team of the Geological Survey of Brazil.

## Installation

You can install this package with using
``` r
remotes::install_github("gferrsilva/geoquimica")
```

OR

``` r
devtools::install_github(""gferrsilva/geoquimica")
```

## Dependencies:

    dplyr,
    purrr,
    tidyr,
    compositions


## Author:

* [Guilherme Ferreira da Silva](http://buscatextual.cnpq.br/buscatextual/visualizacv.do?id=K4452179T4&idiomaExibicao=2), (E-mail: guilherme.ferreira@cprm.gov.br)

## Copryright and  License:

The source code for Qmin is licensed under the GPL-2 License, see [LICENSE](LICENSE.md).
