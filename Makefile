build:
	Rscript -e "blogdown::hugo_build(local = TRUE)"

serve:
	Rscript -e "blogdown::serve_site()"

src:
	cd ./themes/even/src/ ;\
	npm install ;\
	npm start ;\
	cd ../../../

color:
	vim ./themes/even/src/css/_variables.scss
