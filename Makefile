# author: Aarav Mahajan
# date: 2025-03-08

all: results/horse_pop_plot_largest_sd.png \
	results/horse_pops_plot.png \
	results/horses_spread.csv \
	reports/qmd_example.html \
	reports/qmd_example.pdf \
	docs/index.html \
	docs/.nojekyll



# generate figures and objects for report
results/horse_pop_plot_largest_sd.png results/horse_pops_plot.png results/horses_spread.csv: source/generate_figures.R
	Rscript source/generate_figures.R --input_dir="data/00030067-eng.csv" \
		--out_dir="results"
		
docs:
	mkdir -p docs

# render quarto report in HTML and PDF
reports/qmd_example.html: results reports/qmd_example.qmd docs/.nojekyll
	quarto render reports/qmd_example.qmd --to html 
	cp reports/qmd_example.html docs/index.html

reports/qmd_example.pdf: results reports/qmd_example.qmd docs/.nojekyll
	quarto render reports/qmd_example.qmd --to pdf

docs/.nojekyll: docs
	touch docs/.nojekyll
	
# clean
clean:
	rm -rf results
	rm -rf reports/qmd_example.html \
		reports/qmd_example.pdf \
		reports/qmd_example_files \ 
		reports/index.html
	rm -rf reports/docs
	rm -rf docs 
	rm -rf reports/docs/qmd_example.html \
		reports/docs/qmd_example.pdf
