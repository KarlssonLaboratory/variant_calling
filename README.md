[![Build and Release Docker Container](https://github.com/KarlssonLaboratory/variant_calling/actions/workflows/build-release.yml/badge.svg)](https://github.com/KarlssonLaboratory/variant_calling/actions/workflows/build-release.yml)

A rocker/r-ver:4.4.0 container with [vcfR](https://github.com/knausb/vcfR) R-package (and some dependencies). Mainly used for variant calling analysis.

<details>
  <summary>Included softwares</summary>

+ vcfR
+ tidyverse
+ patchwork
+ data.table
+ clinfun
+ R.utils
+ git
+ less
+ procps (useful inside Nextflow pipelines)
</details>

## Pull the container

```sh
# As docker
docker pull ghcr.io/karlssonlaboratory/variant_calling:f23646d

# As apptainer
apptainer pull docker://ghcr.io/karlssonlaboratory/variant_calling:f23646d

# As singularity
singularity pull docker://ghcr.io/karlssonlaboratory/variant_calling:f23646d
```

## Run interactively

```sh
docker run -it --rm -v $(pwd):/data ghcr.io/karlssonlaboratory/variant_calling:f23646d
```

## Build locally

```sh
git clone https://github.com/karlssonlaboratory/variant_calling:f23646d.git
cd variant_calling
docker build -t variant_calling .
```

<details>
  <summary>As nextflow process</summary>

```groovy
process PROCESS_NAME {
	
	. . .

	container "${workflow.containerEngine == 'singularity' ?
    'docker://ghcr.io/karlssonlaboratory/variant_calling:f23646d' :
    'ghcr.io/karlssonlaboratory/variant_calling:f23646d'}"

  . . .
}
```

The container definition uses an [elvis operator](https://www.nextflow.io/docs/latest/reference/syntax.html#unary-expressions) = `<statement> ? <TRUE> : <FALSE>`
</details>

## Dockerfile details

`Dockerfile` runs the content inside `install.R`, which holds all R-packages. Edit this file in order to add more packages

```yml
# Dockerfile
COPY install.R /tmp/install.R
RUN Rscript /tmp/install.R
```

```r
# install.R
pkgs_CRAN <- c(
  "data.table",
  "tidyverse"
  "patchwork",
  "vcfR",
  "clinfun",
  "R.utils"
)

install.packages(
  pkgs_CRAN,
  repos = getOption("repos"),
  Ncpus = parallel::detectCores()
)
```
