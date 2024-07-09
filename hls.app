<project xmlns="com.autoesl.autopilot.project" name="PartitionAcceleratorHLS" top="system_top">
    <includePaths/>
    <libraryPaths/>
    <Simulation>
        <SimFlow name="csim" clean="true" csimMode="0" lastCsimMode="0"/>
    </Simulation>
    <files xmlns="">
        <file name="../test/test_system.cpp" sc="0" tb="1" cflags=" -I../include -Wno-unknown-pragmas" csimflags=" -Wno-unknown-pragmas" blackbox="false"/>
        <file name="PartitionAcceleratorHLS/src/types.cpp" sc="0" tb="false" cflags="-IPartitionAcceleratorHLS/include -Wno-unknown-pragmas" csimflags="" blackbox="false"/>
        <file name="PartitionAcceleratorHLS/src/system.cpp" sc="0" tb="false" cflags="-IPartitionAcceleratorHLS/include -Wno-unknown-pragmas" csimflags="" blackbox="false"/>
        <file name="PartitionAcceleratorHLS/src/patch_buffer.cpp" sc="0" tb="false" cflags="-IPartitionAcceleratorHLS/include -Wno-unknown-pragmas" csimflags="-IPartitionAcceleratorHLS/include -Wno-unknown-pragmas" blackbox="false"/>
        <file name="file_reader.cpp" sc="0" tb="false" cflags="-IPartitionAcceleratorHLS/include -Wno-unknown-pragmas" csimflags="" blackbox="false"/>
    </files>
    <solutions xmlns="">
        <solution name="solution1" status="active"/>
        <solution name="solution1" status="active"/>
        <solution name="solution1" status="active"/>
        <solution name="solution1" status="active"/>
    </solutions>
</project>

