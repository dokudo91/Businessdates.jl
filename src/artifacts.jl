using Pkg.Artifacts

function bind_artifacts()
    artifact_toml = joinpath(@__DIR__, "Artifacts.toml")
    hash = create_artifact() do artifact_dir
        url = "https://www8.cao.go.jp/chosei/shukujitsu/syukujitsu.csv"
        download(url, joinpath(artifact_dir, "syukujitsu.csv"))
    end
    bind_artifact!(artifact_toml, "syukujitsu", hash)
    hash
end

syukujitsucsv_path() = joinpath(artifact"syukujitsu", "syukujitsu.csv")