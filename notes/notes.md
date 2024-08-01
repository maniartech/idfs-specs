# Notes

## LaTeX as intermediate format

For complex structrue, use `LaTeX` as intermediate format.
<https://stackoverflow.com/questions/14249811/markdown-to-docx-including-complex-template>

```bash
pandoc -f markdown -t latex -o mydoc.tex mydoc.md && \
pandoc -f latex -t docx --data-dir=docs/rendering/ -o mydoc.docx mydoc.tex
```

```bash
# Single command with pipe
pandoc -t latex mydoc.md | pandoc -f latex --data-dir=docs/rendering/ -o mydoc.docx
```
