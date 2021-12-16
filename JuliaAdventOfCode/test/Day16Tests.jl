using JuliaAdventOfCode: getinput, Day16

@testset "Day16 Tests" begin
    part1_testcases = [
        ("8A004A801A8002F478", 16), 
        ("620080001611562C8802118E34", 12),
        ("C0015000016115A2E0802F182340", 23), 
        ("A0016C880162017C3686B18A3D4780", 31)
    ]
    for (hex, expected) in part1_testcases
        bits = Day16.hex2bits(hex)
        @test Day16.part1(bits) == expected
    end

    part2_testcases = [
        ("C200B40A82", 3),
        ("04005AC33890", 54),
        ("880086C3E88112", 7),
        ("CE00C43D881120", 9),
        ("D8005AC2A8F0", 1),
        ("F600BC2D8F", 0),
        ("9C005AC2F8F0", 0),
        ("9C0141080250320F1802104A08", 1),
    ]
    for (hex, expected) in part2_testcases
        bits = Day16.hex2bits(hex)
        @test Day16.part2(bits) == expected
    end

    realinputpath = getinput("Day16", "input")
    realinput = Day16.ingest(realinputpath)
    @test Day16.part1(realinput) == 936
    @test Day16.part2(realinput) == 6_802_496_672_062
end