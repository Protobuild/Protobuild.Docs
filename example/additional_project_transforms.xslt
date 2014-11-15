<xsl:if test="/Input/Properties/PrecompileProtobuf = 'True'">
  <Target Name="AfterBuild">
    <Exec>
      <xsl:attribute name="WorkingDirectory">
        <xsl:value-of select="/Input/Generation/RootPath" />
      </xsl:attribute>
      <xsl:attribute name="Command">
        <xsl:if test="/Input/Generation/Platform = 'Linux' or /Input/Generation/Platform = 'MacOS' or /Input/Generation/Platform = 'iOS'">
          <xsl:text>mono </xsl:text>
          <xsl:text>Protogame/ThirdParty/protobuf-precompile/precompile.exe </xsl:text>
        </xsl:if>
        <xsl:if test="/Input/Generation/Platform = 'Windows' or /Input/Generation/Platform = 'Android'">
          <xsl:text>Protogame\ThirdParty\protobuf-precompile\precompile.exe </xsl:text>
        </xsl:if>
        <xsl:value-of select="/Input/Properties/PrecompileProtobufInputPath" />
        <xsl:text> -o:</xsl:text>
        <xsl:value-of select="/Input/Properties/PrecompileProtobufOutputPath" />
        <xsl:text> -t:</xsl:text>
        <xsl:value-of select="/Input/Properties/PrecompileProtobufSerializerName" />
        <xsl:text> -access:Public</xsl:text>
        <xsl:if test="/Input/Generation/Platform = 'Linux'">
          <xsl:text> -f:/usr/lib/mono/4.0/</xsl:text>
        </xsl:if>
        <xsl:if test="/Input/Generation/Platform = 'MacOS' or /Input/Generation/Platform = 'iOS'">
          <xsl:text> -f:/Library/Frameworks/Mono.framework/Versions/Current/lib/mono/4.0/</xsl:text>
        </xsl:if>
        <xsl:if test="/Input/Generation/Platform = 'Android'">
          <xsl:text> -f:MonoAndroid\v1.0</xsl:text>
        </xsl:if>
      </xsl:attribute>
    </Exec>
  </Target>
</xsl:if>