Shader "MCRS/Diva/Trans_High_Alpha" {
	Properties {
		_MainTex ("DiffuseTex", 2D) = "white" {}
		_AlphaTex ("AlphaTex", 2D) = "white" {}
		_Color ("Main Color", Vector) = (1,1,1,1)
		_RimColor ("Rim Color", Vector) = (1,1,1,1)
		_RimLightPower ("RimLight Power", Float) = 1
		_RimLightSampler ("RimLight Control", 2D) = "white" {}
		_Alpha ("Alpha", Range(0, 1)) = 0
	}
SubShader
	{
		Tags {"Queue"="Transparent" "RenderType"="Transparent" "LightMode" = "Vertex"}
		Blend SrcAlpha OneMinusSrcAlpha
		Cull Off

		// extra pass that renders to depth buffer only
		Pass {
			ZWrite On
			ColorMask 0
		}

		Pass
		{
			ZWrite Off
			CGPROGRAM 
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"
			
			struct appdata
			{
				float4 vertex : POSITION;
				half3 normal : NORMAL;
				float2 uv : TEXCOORD0;
				float4 tangent : TANGENT;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
				half3 normal : NORMAL;
				float4 posWorld : TEXCOORD1;
			};

			float4 _Color;
			float4 _RimColor;
			float _RimLightPower;
			float _Alpha;
			sampler2D _MainTex;
			sampler2D _RimLightSampler;
			sampler2D _AlphaTex;
			float4 _AlphaTex_ST;
			float4 _MainTex_ST;

			v2f vert (appdata v)
			{
				v2f o = (v2f)0;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.normal = normalize( mul ( float4(v.normal, 0.0), unity_WorldToObject).xyz);	
				o.posWorld = mul(unity_ObjectToWorld, v.vertex);
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// Texture	
				fixed4 col = tex2D(_MainTex, i.uv);
				col.a = tex2D(_AlphaTex, i.uv);
				//Rimlight NEW
				
				float3 normalDir = i.normal;
				float3 viewDir = normalize( _WorldSpaceCameraPos.xyz - i.posWorld.xyz);
				float rimUV = saturate(pow(1.0 - dot(viewDir, normalDir), 1 + _RimLightPower));

				//subtex calls
				
				fixed4 Rim = tex2D(_RimLightSampler, rimUV).g * _RimColor;
				fixed4 Rimmask = tex2D(_RimLightSampler, i.uv).r;
				
				// so i don't need to make so many return calls like before
				
				col.rgb = lerp(col.rgb, col.rgb + Rim, Rimmask);
				
				//light reaction
				col.rgb *= _Color;
				col.a *= _Alpha;
				// apply fog
				UNITY_APPLY_FOG(i.fogCoord, col);
				return col;
			}
			ENDCG
		}
	}
}