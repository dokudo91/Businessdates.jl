using Documenter
using Businessdates
DocMeta.setdocmeta!(Businessdates, :DocTestSetup, :(using Businessdates, Dates); recursive=true)
makedocs(
    sitename = "Businessdates",
    format = Documenter.HTML(),
    modules = [Businessdates]
)
deploydocs(
    repo = "github.com/dokudo91/Businessdates.jl.git",
)