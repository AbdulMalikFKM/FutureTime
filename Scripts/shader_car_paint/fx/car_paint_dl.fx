//
// car_paint_dl.fx
//

//------------------------------------------------------------------------------------------
// Settings
//------------------------------------------------------------------------------------------
texture sTextureRef;
float2 sRefIntensity = float2(0.15,0.8);
float2 sEffectFade = float2(50, 40);

//------------------------------------------------------------------------------------------
// Settings
//------------------------------------------------------------------------------------------
texture colorRT < string renderTarget = "yes"; >;
texture normalRT < string renderTarget = "yes"; >;

//------------------------------------------------------------------------------------------
// Include some common stuff
//------------------------------------------------------------------------------------------
#define GENERATE_NORMALS
static const float pi = 3.141592653589793f;
float4 gBlendFactor < string renderState="BLENDFACTOR"; >;
int gZWriteEnable < string renderState="ZWRITEENABLE"; >;
int gCullMode < string renderState="CULLMODE"; >;  
int gStage1ColorOp < string stageState="1,COLOROP"; >;
float4 gTextureFactor < string renderState="TEXTUREFACTOR"; >;
float4x4 gTransformTexture0 < string transformState="TEXTURE0"; >; 
float4x4 gTransformTexture1 < string transformState="TEXTURE1"; >; 
int gDeclTexCoord1 < string vertexDeclState="TexCoord1"; >;
#include "mta-helper.fx"

//------------------------------------------------------------------------------------------
// Sampler for the main texture
//------------------------------------------------------------------------------------------
sampler Sampler0 = sampler_state
{
    Texture = (gTexture0);
};

sampler Sampler1 = sampler_state
{
    Texture = (gTexture1);
};

sampler2D SamplerRef = sampler_state
{
    Texture = (sTextureRef);	
    AddressU = Mirror;
    AddressV = Mirror;
    MinFilter = Linear;
    MagFilter = Linear;
    MipFilter = Linear;
    SRGBTexture = false;
    MaxMipLevel = 0;
    MipMapLodBias = 0;
};

//------------------------------------------------------------------------------------------
// Structure of data sent to the vertex shader
//------------------------------------------------------------------------------------------
struct VSInput
{
  float3 Position : POSITION0;
  float3 Normal : NORMAL0;
  float4 Diffuse : COLOR0;
  float2 TexCoord : TEXCOORD0;
  float2 TexCoord1 : TEXCOORD1;
};

//------------------------------------------------------------------------------------------
// Structure of data sent to the pixel shader ( from the vertex shader )
//------------------------------------------------------------------------------------------
struct PSInput
{
  float4 Position : POSITION0;
  float4 Diffuse : COLOR0;
  float2 TexCoord : TEXCOORD0;
  float3 TexCoord1 : TEXCOORD1;
  float2 Depth : TEXCOORD2;
  float4 PNormal : TEXCOORD3;
  float4 vPosition : TEXCOORD4;
  float3 Normal : TEXCOORD5;
};

//------------------------------------------------------------------------------------------
// getReflectionCoords1
//------------------------------------------------------------------------------------------
float2 getReflectionCoords1(float3 dir)
{
    float m = 2.0 * sqrt(pow( dir.x, 2.0 ) + pow( dir.y, 2.0 ) + pow( dir.z + 1.0, 2.0 ));
    return dir.xy / m + 0.5;	
}
    
//------------------------------------------------------------------------------------------
// VertexShaderFunction
//------------------------------------------------------------------------------------------
PSInput VertexShaderFunction(VSInput VS)
{
    PSInput PS = (PSInput)0;

    // Make sure normal is valid
    MTAFixUpNormal( VS.Normal );

    // Calculate screen pos of vertex	
    float4 worldPos = mul( float4(VS.Position.xyz,1) , gWorld );	
    float4 viewPos = mul( worldPos , gView );
    float4 projPos = mul( viewPos, gProjection);
    PS.Position = projPos;
    PS.vPosition = projPos;
	
    // Set information to do specular calculation
    float3 Normal = mul(VS.Normal, (float3x3)gWorld);
    float3 ViewNormal = mul(VS.Normal, (float3x3)gWorldView);
    Normal = normalize(Normal);
    PS.Normal = Normal;
    ViewNormal = normalize(ViewNormal);
	
    // WVP Normal
    PS.PNormal.xyz = normalize(mul(VS.Normal.xyz, (float3x3)gWorldViewProjection));
	
    float refMask = pow(1.5 * dot(Normal, normalize(gCameraPosition - worldPos.xyz)), 3);
    PS.PNormal.w = saturate(1 - refMask) * ((ViewNormal.z >= 0) ? 0 : 1) ;
	
    // Distance fade calculation
    float DistanceFromCamera = distance(gCameraPosition, worldPos.xyz);
    PS.PNormal.w *= saturate(1 - ((DistanceFromCamera - sEffectFade.y) / (sEffectFade.x - sEffectFade.y)));	
    // Pass through tex coord
    PS.TexCoord = VS.TexCoord;
	
    PS.TexCoord1 = 0;
    if (gStage1ColorOp == 25) PS.TexCoord1 = mul(ViewNormal.xyz, (float3x3)gTransformTexture1);
    if (gStage1ColorOp == 14) PS.TexCoord1 = mul(float3(VS.TexCoord1.xy, 1), (float3x3)gTransformTexture1);
	
    // Pass depth
    PS.Depth = float2(viewPos.z, viewPos.w);

    // Calculate GTA lighting for Vehicles
    PS.Diffuse = MTACalcGTACompleteDiffuse(Normal, VS.Diffuse);
	
    return PS;
}

//------------------------------------------------------------------------------------------
// MTAApplyFog
//------------------------------------------------------------------------------------------
int gFogEnable                     < string renderState="FOGENABLE"; >;
float4 gFogColor                   < string renderState="FOGCOLOR"; >;
float gFogStart                    < string renderState="FOGSTART"; >;
float gFogEnd                      < string renderState="FOGEND"; >;

float3 MTAApplyFog( float3 texel, float distFromCam )
{
    if ( !gFogEnable )
        return texel;
    float FogAmount = ( distFromCam - gFogStart )/( gFogEnd - gFogStart );
    texel.rgb = lerp(texel.rgb, gFogColor.rgb, saturate( FogAmount) );
    return texel;
}

//------------------------------------------------------------------------------------------
// Structure of color data sent to the renderer ( from the pixel shader  )
//------------------------------------------------------------------------------------------
struct Pixel
{
    float4 World : COLOR0;      // Render target #0
    float4 Color : COLOR1;      // Render target #1
    float4 Normal : COLOR2;      // Render target #2
};

//------------------------------------------------------------------------------------------
// PixelShaderFunction
//------------------------------------------------------------------------------------------
Pixel PixelShaderFunction(PSInput PS)
{
    Pixel output;
	
    // Reflection
    float3 pNormal = normalize(PS.PNormal.xyz);
    float3 WNormal = normalize(PS.Normal);
	
    float2 refluv =(PS.vPosition.xy / PS.vPosition.w) * float2(0.5, -0.5) + 0.5;
    float3 refl = reflect(normalize(-PS.vPosition.xyz), pNormal);	
    refluv += (refl.xy * float2(-1.0, 1.0) * 0.5);
	
    // Sample environment map using this reflection vector:
    float4 envMap = tex2D(SamplerRef, refluv.xy);
	
    // Get texture pixel
    float4 texel = tex2D(Sampler0, PS.TexCoord.xy);

    // Apply diffuse lighting
    float4 finalColor = texel * PS.Diffuse;

    // Apply env reflection
    // BlendFactorAlpha = 14,
    if (gStage1ColorOp == 14) {
        float4 envTexel = tex2D(Sampler1, PS.TexCoord1.xy);
        finalColor.rgb = finalColor.rgb * (1 - gTextureFactor.a) + envTexel.rgb * gTextureFactor.a;
    }

    // Apply spherical reflection
    // MultiplyAdd = 25
    if (gStage1ColorOp == 25) {
        float4 sphTexel = tex2D(Sampler1, PS.TexCoord1.xy/PS.TexCoord1.z);
        finalColor.rgb += sphTexel.rgb * gTextureFactor.r;
    }

    // Apply specular
    if (gMaterialSpecPower != 0) finalColor.rgb += gMaterialSpecular.rgb * MTACalculateSpecular( gCameraDirection, gLight1Direction, WNormal, min(127, gMaterialSpecPower)) * gLight1Specular.rgb;	
	
    // Apply screen space reflection
    if ((gMaterialDiffuse.a <= 0.9) || (gStage1ColorOp != 1)) 
        if (gMaterialDiffuse.a > 0.9) finalColor.rgb = lerp(finalColor.rgb, envMap.rgb, saturate(sRefIntensity.x * PS.PNormal.w));
            else finalColor.rgb = lerp(finalColor.rgb, envMap.rgb, saturate(sRefIntensity.y * PS.PNormal.w)); 
	
    finalColor = saturate(finalColor);

    finalColor.rgb = MTAApplyFog(finalColor.rgb, PS.Depth.x / PS.Depth.y);
    output.World = saturate(finalColor);
	
    // Color render target
    output.Color.rgb = finalColor.rgb * 0.85 + 0.15;
    output.Color.a = texel.a * PS.Diffuse.a;
		
    // Normal render target
    float3 Normal = normalize(PS.Normal);
    Normal = float3((Normal.xy * 0.5) + 0.5, Normal.z <0 ? 0.811 : 0.989);
    output.Normal = float4(Normal, 1);

    return output;
}

//------------------------------------------------------------------------------------------
// Techniques
//------------------------------------------------------------------------------------------
technique car_paint_dl
{
    pass P0
    {
        CullMode = ((gMaterialDiffuse.a < 0.9) && (gBlendFactor.a == 0)) ? 1 : gCullMode;
        ZWriteEnable = (gMaterialDiffuse.a < 0.9) ? 0 : gZWriteEnable;
        SRGBWriteEnable = false;
        VertexShader = compile vs_3_0 VertexShaderFunction();
        PixelShader = compile ps_3_0 PixelShaderFunction();
    }
}

// Fallback
technique fallback
{
    pass P0
    {
        // Just draw normally
    }
}