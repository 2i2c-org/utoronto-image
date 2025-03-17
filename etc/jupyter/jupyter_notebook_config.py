from nbconvert.exporters.qtpdf import QtPDFExporter

# Disable Qt PDF exporter
QtPDFExporter.export_from_notebook = None
