-- Add a page break before each level 1 header in the document
function Header(elem)
  if elem.level == 1 then
    -- Create a RawBlock with a page break for Word
    local break_block = pandoc.RawBlock('openxml', '<w:p><w:r><w:br w:type="page"/></w:r></w:p>')
    -- Return a list with the header and the page break block
    return {break_block, elem}
  end
end
