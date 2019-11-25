<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.4.6-Madeira" styleCategories="AllStyleCategories" maxScale="0" hasScaleBasedVisibilityFlag="0" minScale="1e+8">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
  </flags>
  <customproperties>
    <property value="false" key="WMSBackgroundLayer"/>
    <property value="false" key="WMSPublishDataSourceUrl"/>
    <property value="0" key="embeddedWidgets/count"/>
    <property key="variableNames"/>
    <property key="variableValues"/>
  </customproperties>
  <pipe>
    <rasterrenderer opacity="1" band="1" type="singlebandpseudocolor" classificationMin="1" alphaBand="-1" classificationMax="5">
      <rasterTransparency/>
      <minMaxOrigin>
        <limits>MinMax</limits>
        <extent>WholeRaster</extent>
        <statAccuracy>Estimated</statAccuracy>
        <cumulativeCutLower>0.02</cumulativeCutLower>
        <cumulativeCutUpper>0.98</cumulativeCutUpper>
        <stdDevFactor>2</stdDevFactor>
      </minMaxOrigin>
      <rastershader>
        <colorrampshader clip="0" classificationMode="1" colorRampType="INTERPOLATED">
          <colorramp type="gradient" name="[source]">
            <prop v="215,25,28,255" k="color1"/>
            <prop v="43,131,186,255" k="color2"/>
            <prop v="0" k="discrete"/>
            <prop v="gradient" k="rampType"/>
            <prop v="0.25;253,174,97,255:0.5;255,255,191,255:0.75;171,221,164,255" k="stops"/>
          </colorramp>
          <item alpha="255" color="#2342cd" value="1" label="1"/>
          <item alpha="255" color="#f5cc40" value="2" label="2"/>
          <item alpha="255" color="#969696" value="3" label="3"/>
          <item alpha="255" color="#09782c" value="4" label="4"/>
          <item alpha="255" color="#0ec344" value="5" label="5"/>
        </colorrampshader>
      </rastershader>
    </rasterrenderer>
    <brightnesscontrast brightness="0" contrast="0"/>
    <huesaturation colorizeGreen="128" saturation="0" colorizeRed="255" grayscaleMode="0" colorizeStrength="100" colorizeBlue="128" colorizeOn="0"/>
    <rasterresampler maxOversampling="2"/>
  </pipe>
  <blendMode>0</blendMode>
</qgis>
