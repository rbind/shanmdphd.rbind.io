build:
	Rscript -e "blogdown::hugo_build(local = TRUE)"

serve:
	Rscript -e "blogdown::serve_site()"

