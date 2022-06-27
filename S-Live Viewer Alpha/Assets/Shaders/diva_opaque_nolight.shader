Shader "MCRS/Diva/Opaque_NoLight" {
	Properties {
		_MainTex ("DiffuseTex", 2D) = "white" {}
		_Color ("Main Color", Vector) = (1,1,1,1)
	}
SubShader
	{
		Tags {"Queue"="Geometry" "RenderType"="Geometry" "LightMode" = "Vertex"}
		Cull Back
		Blend SrcAlpha OneMinusSrcAlpha
		Pass
		{
			Zwrite On
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
			sampler2D _MainTex;
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
			//Rimlight NEW
			//light reaction
			col.rgb *= _Color;
			// apply fog
			UNITY_APPLY_FOG(i.fogCoord, col);
			return col;
			}
			ENDCG
		}
	}
}