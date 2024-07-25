using Pkg.Artifacts
using SHA

const csvurl = "https://www8.cao.go.jp/chosei/shukujitsu/syukujitsu.csv"
const csvfilename = splitdir(csvurl)[2]

function bind_artifacts()
    artifact_toml = joinpath(@__DIR__, "Artifacts.toml")
    csvfilepath = download(csvurl)
    sha256hex = bytes2hex(open(sha256, csvfilepath))
    hash = create_artifact() do artifact_dir
        mv(csvfilepath, joinpath(artifact_dir, csvfilename))
    end
    bind_artifact!(artifact_toml, "syukujitsu", hash; download_info=[(csvurl, sha256hex)])
end

syukujitsucsv_path() = joinpath(artifact"syukujitsu", "syukujitsu.csv")