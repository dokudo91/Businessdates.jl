using Pkg.Artifacts

function update_artifacts()
    artifact_toml = joinpath(@__DIR__, "Artifacts.toml")
    hash = create_artifact() do artifact_dir
        url = "https://www8.cao.go.jp/chosei/shukujitsu/syukujitsu.csv"
        download(url, joinpath(artifact_dir, "syukujitsu.csv"))
    end
    bind_artifact!(artifact_toml, "syukujitsu", hash; force=true)
    hash
end

function syukujitsucsv_path()
    artifact_toml = joinpath(@__DIR__, "Artifacts.toml")
    hash = artifact_hash("syukujitsu", artifact_toml)
    if isnothing(hash) || !artifact_exists(hash)
        hash = update_artifacts()
    end
    joinpath(artifact"syukujitsu", "syukujitsu.csv")
end