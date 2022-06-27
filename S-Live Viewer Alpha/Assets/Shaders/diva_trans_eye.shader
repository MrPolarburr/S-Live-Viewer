Shader "MCRS/Diva/Trans_Eye" {
	Properties {
		_MainTex ("DiffuseTex", 2D) = "white" {}
		_AlphaTex ("AlphaTex", 2D) = "white" {}
		_Color ("Main Color", Vector) = (1,1,1,1)
	}
SubShader
    {
        Tags {"Queue"="Transparent" "RenderType"="Transparent" "LightMode" = "Vertex"}
        Blend SrcAlpha OneMinusSrcAlpha
        ZWrite On
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
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
            sampler2D _AlphaTex;
            float4 _MainTex_ST;
            float4 _AlphaTex_ST;
            float4 _Color;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                col.a = tex2D(_AlphaTex, i.uv) * _Color.a;

                col.rgb *= _Color.rgb;

                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }
    }
}