![CI](https://github.com/yasuo-ozu/satysfi-xpath/actions/workflows/ci.yml/badge.svg)
[Document](https://github.com/yasuo-ozu/satysfi-xpath/blob/main/doc/xpath-doc.pdf)
[Satyrographos Package Index](https://satyrographos-packages.netlify.app/packages/xpath)

<hr>

# SATySFi-XPath

SATySFi-XPathは高度なパス操作を実現するライブラリです。

## Install

```bash
$ opam install satysfi-xpath
$ satyrographos install
```

## Example

```ml
XPath.(
    start-path (0cm, 0cm)
        |> bezier-to (0cm, 1.1cm) (-2cm, 1.1cm) (-2cm, 0cm)
        |> line-to (0cm, -2cm) |> line-to (2cm, 0cm)
        |> close-with-bezier (2cm, 1.1cm) (0cm, 1.1cm)
        |> stroke 3pt (Color.red)
)
```

[Output](https://github.com/yasuo-ozu/satysfi-xpath/blob/main/image-tests-ans/heart.pdf)

