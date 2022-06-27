Shader "MCRS/Diva/Opaque_Mike" {
	Properties {
		_MainTex ("DiffuseTex", 2D) = "white" {}
		_Color ("Main Color", Vector) = (1,1,1,1)
	}
SubShader
	{
		Tags { "Queue"="Geometry" "RenderType"="Geometry" "LightMode" = "Vertex" }
		ZWrite On
		Pass
		{
			CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
			#pragma multi_compile_fog

			#include "UnityCG.cginc"

			struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

			sampler2D _MainTex;
			float4 _Color;
			float4 _MainTex_ST;

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}

			float4 frag(v2f i) : COLOR
			{
				float4 tex = tex2D(_MainTex, i.uv);
				return tex * _Color;
			}
			ENDCG
		}
	}
}