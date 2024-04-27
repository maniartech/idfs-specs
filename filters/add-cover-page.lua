-- Create a custom block for the title page
function Pandoc(doc)
  -- Create a custom block for the title page
  local title_page = pandoc.Div({
    pandoc.Para(pandoc.Strong('Your Document Title')),
    pandoc.Para('Your Name'),
    pandoc.Para('2023-01-01')
  }, {class = 'titlepage'})

  -- Insert the title page at the beginning of the document
  table.insert(doc.blocks, 1, title_page)

  -- Return the modified document
  return doc
end