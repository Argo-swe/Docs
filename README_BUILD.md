# Argo docs

This repo WILL BE DELETED once documentation will have been completed.

## <a name="howto"></a>How to use the provided Dockerfile

*You must have Docker installed in your system. Check the  [official site](https://www.docker.com/products/overview) to get help with Docker's installation.*
The provided Dockerfile has been tested on:
-  Windows 10 Pro with Docker for Windows. Docker engine from version `v1.13.0`
-  Windows 10 Home with Docker Toolbox. Docker engine version `v1.12.3`
-  macOS Sierra 10.12.3 with Docker for Mac. Docker engine version `v17.03.0-ce`
-  Ubuntu 16.04 LTS. Docker engine version `v1.12.6`
-  Ubuntu 14.04 LTS. Docker engine version `v1.13.1`

### <a name="mandatoryconf">Mandatory configuration</a>

Make sure your Docker installation is configured for volume mounting.
-   [General](https://docs.docker.com/engine/tutorials/dockervolumes/)
-   [Windows 10](https://blogs.msdn.microsoft.com/stevelasker/2016/06/14/configuring-docker-for-windows-volumes/)

### <a name="instruction">Instructions</a>

1.  Run docker compose with:
    `docker compose up -d`

    Brief explanation:
    -   `-d`: detach compose up process

2. Open a bash shell inside the container:
    `docker exec -it argo-docs-latexpdfbuilder-1 bash`

Once inside the container, you can run all the [scripts](#scripts) written originally for Travis CI.

## <a name="scripts">Scripts</a>

-   <a name="bdocs">[`build-docs.sh`](build-docs.sh)</a>: builds all internal and/or external documentation of the project. This script makes use of the [`build-latex.sh`](#blatex) script and the  [`common.config`](#commonconf) file.
    **Syntax**
    `build-docs.sh {e, external | i, internal | a, all} [OPTION]`
    The first argument **must** be **one** of the following flags:
    1.  `e` or `external` flag builds all external docs as defined in [`external-docs.config`](#externaldocsconf)
    2.  `i` or `internal` flag builds all internal docs as defined in [`internal-docs.config`](#internaldocsconf)
    3.  `a` or `all` flag builds all external docs as defined in [`external-docs.config`](#externaldocsconf) **and** all internal docs as defined in [`internal-docs.config`](#internaldocsconf)

    `OPTION` is an optional argument and can be any of the following flags:
    -   `-c <custom path>` : specify the path to a custom index file.

    **Example**
    `./build-docs.sh e`

-   <a name="blatex">`build-latex.sh`</a>: builds a generic PDF using `pdflatex` and `latexmk` based on the arguments specified.
    **Syntax**
    `build-latex.sh <input path> <main doc> <output path> [<output pdf name>]`
    1.  `<input path>`: path of the directory that contains all `.tex` files used to build a LaTeX document
    2.  `<main doc>`: name of the `.tex` file that includes all other files
    3.  `<output path>`: path of the directory in which `pdflatex` will create all its auxiliary files and the PDF file
    4.  `<output pdf name>`: (**optional**) if this argument is not set, `pdflatex` will name the PDF file after the `<main doc>` file.

-   <a name="installdeps">`install-deps.sh`</a>: installs all the required dependencies to build ~~and do basic testing (of)~~ the documentation. It is called by Docker during the build image process (`Dockerfile`) and by Travis CI.
    **List of installed dependencies:**
    -   `aspell`
    -   `aspell-it`
    -   `latexmk`
    -   `latex-xcolor`
    -   `lmodern`
    -   `pgf`
    -   `texlive`
    -   `texlive-lang-english`
    -   `texlive-lang-italian`
    -   `texlive-latex-extra`
    -   `texlive-latex-recommended`

-   <a name="zipdocs">[`zip-docs.sh`](zip-docs.sh)</a>: zips the compiled PDF documents of the project. **Before using this script, execute first script ['build-latex.sh'](#blatex)**. This script makes use of the [`common.config`](#commonconf) file.
    **Syntax**
    `zip-docs.sh [OPTION]`
    `OPTION` is an optional argument and can be **one** of the following flags:
    -   `-r` or `--release` : activates a *release* profile which copy the required documents in a location specified by [`common.config`](#commonconf)
    -   `-rc` or `--release-clean` : as `-r` or `--release`. After zip is built this option deletes the directory used to zip the files.

### <a name="scripts">Scripts related files</a>
-   <a name="commonconf">[`common.config`](common.config)</a>
    Defines the following constants:
    -   `DOCUMENTSROOT`: directory that contains only the documentation.
    *Default Value* =`./LaTex/documents`
    -   `TEX`: extension of LaTeX files.
    *Default Value* =`tex`
    -   `PDFROOT`: name of root directory used by [`build-docs.sh`](#bdocs) to build LaTeX documents.
    *Default Value*=`build-output`
    -   `OUTPUT_ZIP`: name of the zip that contains the documentation.
    *Default Value*=`documentation.zip`
    -   `RELEASE`: name of root the directory used by [`zip-docs.sh`](#zipdocs) when the `release` flag is activated.
    *Default Value*=`ArgoRelease`

    Defines the following functions:
    -   `buildFiles`: builds all LaTeX files specified in a so called *index* file.
    **Syntax**
    `buildFiles <input index file path> <output directory>`
        1.  `<input index file path>`: text file containing the list of documents to build by the function.
        Format: *{document folder and name}*=*{output name}*
        Example: *NormeDiProgetto=Norme di progetto*
        2.  `<output directory>`: directory in which `pdflatex` will do its magic.
-   <a name="externaldocsconf">`external-docs.config`</a>
Index file that specifies all the external documents:
    -   **Analisi dei Requisiti**
    -   **Glossario**
    -   **Lettera di Presentazione**
    -   **Piano di Progetto**
    -   **Piano di Qualifica**
    -   **Studio di Fattibilità**
    - others incoming...

-   <a name="internaldocsconf">`internal-docs.config`</a>
Index file that specifies all the internal documents:
    -   **Norme di Progetto**
    -   **Verbali**
