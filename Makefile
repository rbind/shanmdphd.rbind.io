build:
	Rscript -e "blogdown::hugo_build(local = FALSE)"

serve:
	Rscript -e "blogdown::serve_site()"



