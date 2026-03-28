# Makefile for Gimmatek LaTeX Template Examples
# Usage: make          # Build all examples
#        make clean    # Remove auxiliary files
#        make help     # Show this help message

# Set TEXINPUTS to find packages
TEXINPUTS := .:./src//:
export TEXINPUTS

# Find all .tex files in examples directory
EXAMPLES := $(wildcard examples/*.tex)
PDFS := $(EXAMPLES:.tex=.pdf)

.PHONY: all examples clean distclean help test

all: examples

examples: $(PDFS)
	@echo "✓ All examples compiled successfully"

# Pattern rule for compiling .tex to .pdf
examples/%.pdf: examples/%.tex
	@echo "Compiling $< (pass 1/2)..."
	@cd examples && TEXINPUTS=.:../src//: xelatex -interaction=nonstopmode $(notdir $<) > /dev/null || (echo "❌ Compilation failed"; exit 1)
	@echo "Compiling $< (pass 2/2)..."
	@cd examples && TEXINPUTS=.:../src//: xelatex -interaction=nonstopmode $(notdir $<) > /dev/null || (echo "❌ Compilation failed"; exit 1)
	@echo "✓ Created: $@"

clean:
	@echo "Cleaning auxiliary files..."
	@cd examples && rm -f *.aux *.log *.out *.toc *.lof *.lot *.synctex.gz *.fdb_latexmk *.fls
	@echo "✓ Clean complete"

distclean: clean
	@echo "Removing PDFs..."
	@cd examples && rm -f *.pdf
	@echo "✓ Deep clean complete"

test: examples
	@echo ""
	@echo "🧪 Running compilation tests..."
	@echo "================================"
	@for pdf in $(PDFS); do \
		if [ -f "$$pdf" ]; then \
			pages=$$(pdfinfo "$$pdf" 2>/dev/null | grep Pages | awk '{print $$2}'); \
			size=$$(ls -lh "$$pdf" | awk '{print $$5}'); \
			echo "✓ $$(basename $$pdf): $$pages pages, $$size"; \
		else \
			echo "❌ $$(basename $$pdf): not found"; \
		fi \
	done
	@echo "================================"
	@echo "✓ Test complete"

help:
	@echo "Gimmatek LaTeX Template Makefile"
	@echo ""
	@echo "Available targets:"
	@echo "  make           - Build all example PDFs"
	@echo "  make examples  - Same as 'make'"
	@echo "  make clean     - Remove auxiliary files (.aux, .log, etc.)"
	@echo "  make distclean - Remove auxiliary files and PDFs"
	@echo "  make test      - Build and verify all examples"
	@echo "  make help      - Show this help message"
	@echo ""
	@echo "To compile a specific example:"
	@echo "  make examples/minimal_example.pdf"
	@echo "  make examples/standalone_example.pdf"
