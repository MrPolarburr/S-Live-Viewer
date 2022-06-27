Shader "MCRS/Stage/Trans_Fakelit" {
	Properties {
		_MainTex ("DiffuseTex", 2D) = "white" {}
		_AlphaTex ("AlphaTex", 2D) = "white" {}
		_Color ("Main Color", Vector) = (1,1,1,1)
	}
SubShader
	{
		Tags { "Queue"="Transparent" "RenderType"="Geometry" "LightMode" = "Vertex" }
		Blend SrcAlpha OneMinusSrcAlpha
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
				float4 color : COLOR; 
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
				float4 color : COLOR;
            };

			sampler2D _MainTex;
			sampler2D _AlphaTex;
			float4 _Color;
			float4 _MainTex_ST;
			float4 _AlphaTex_ST;

			v2f vert(appdata v)
			{
				v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.color = v.color
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
			}

			float4 frag(v2f i) : COLOR
			{
				float4 tex = tex2D(_MainTex, i.uv) * i.color;
				tex.a = tex2D(_AlphaTex, i.uv);
				return tex * _Color;
			}
			ENDCG
		}
	}
}