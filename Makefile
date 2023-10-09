DOC_SRC_DIR  = $(addprefix , docs)
ifdef FILE
DOC_FILES = $(DOC_SRC_DIR)/$(FILE)
else
DOC_FILES ?= $(foreach sdir, $(DOC_SRC_DIR), $(wildcard $(sdir)/*.Rmd))
endif

HTML_FILES := $(patsubst %.Rmd, %.html, $(DOC_FILES))
PUBLIC_DIR := public/
DOCS_DIR   := $(addprefix ,docs/)

##DOCS_DIR := docs/

$(info ************************************)
$(info DOC Source directory:     $(DOC_SRC_DIR))
$(info DOC Source files:         $(DOC_FILES))
$(info DOC HTML files:           $(HTML_FILES))
$(info PUBLIC_DIR:              $(PUBLIC_DIR))
$(info DOCS_DIR:              $(DOCS_DIR))
$(info ************************************)

all: $(HTML_FILES)

$(HTML_FILES) : %.html : %.Rmd
	@echo "Compiling documentation for analyses"
	$(info Source = $<; Destination = $@)
	@echo $(notdir $@)
	$(eval PUBLIC_DIR = $(DOCS_DIR))
	echo "library(rmarkdown); source(\"resources/render.R\"); rmarkdown::render(\"$<\", output_format = my_html_document(template = \"../resources/tutorial_template.html\", css = \"../resources/tutorial_style.css\", theme = \"spacelab\", toc = TRUE, toc_float = TRUE, highlight = \"pygments\"))" | R --no-save --no-restore;\
	# cp $@ $(DOCS_DIR)$(notdir $@)
	# $(eval R_FILE = $(patsubst %.Rmd, %.R, $<))
	# sed -i 's/public\///g' $(DOCS_DIR)$(notdir $@); \
	# $(eval CODE = .code/)
	# $(eval R_FILE = $(patsubst %.Rmd, %.R, $<))
	# echo "library(knitr); knitr::purl(\"$<\", output=\"$(PUBLIC_DIR)$(CODE)$(notdir $(R_FILE))\")" | R --no-save --no-restore
	# sed -i 's/public\///g' $(PUBLIC_DIR)$(CODE)$(notdir $(R_FILE))
