using Dates, StringEncodings, CSV, DataFrames
include("artifacts.jl")

"""
    load_holidaydf()

祝日情報をDataFrameで取得する
# Example
```jldoctest
julia> load_holidaydf()[1, 1]
1955-01-01
```
"""
function load_holidaydf()
    df = CSV.File(open(syukujitsucsv_path(), enc"shift-jis")) |> DataFrame
    transform!(df, 1 => ByRow(x -> Date(x, dateformat"yyyy/mm/dd")); renamecols=false)
end

"""
    isbday(dt, holidates)
    isbday(dt)

営業日かどうか判定する
# Example
```jldoctest
julia> isbday(Date(2000))
false
```
"""
function isbday(dt, holidates)
    w = dayofweek(dt)
    w ∉ [Saturday, Sunday] && dt ∉ holidates
end
isbday(dt) = isbday(dt, load_holidaydf()[!, 1])

"""
    tobnext(dt, holidates)
    tobnext(dt)

次の営業日を返す
# Example
```jldoctest
julia> tobnext(Date(2000))
2000-01-03
```
"""
tobnext(dt, holidates) = tonext(d -> isbday(d, holidates), dt)
tobnext(dt) = tobnext(dt, load_holidaydf()[!, 1])

"""
    tobprev(dt, holidates)
    tobprev(dt)

前の営業日を返す
# Example
```jldoctest
julia> tobprev(Date(2000))
1999-12-31
```
"""
tobprev(dt, holidates) = toprev(d -> isbday(d, holidates), dt)
tobprev(dt) = tobprev(dt, load_holidaydf()[!, 1])

"""
    btoday(holidates)
    btoday()

今日が営業日であればそのまま返し、祝日であれば次の営業日を返す。
"""
function btoday(holidates)
    day = today()
    if isbday(day, holidates)
        day
    else
        tobnext(day, holidates)
    end
end
btoday() = btoday(load_holidaydf()[!, 1])