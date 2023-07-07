Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5FF74B6D0
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jul 2023 21:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbjGGTC6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Jul 2023 15:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbjGGTCw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Jul 2023 15:02:52 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2074.outbound.protection.outlook.com [40.107.104.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A5626B0;
        Fri,  7 Jul 2023 12:02:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=meB2FAmtv8MtEU1cparmmkR5Je2b9PInQSJ2jDEZKvJ9iXYZViJ8qedk66DszrJ6BH2C+VOQ7iBdNX+XPfVI9Fr77FcOQWuauM2MBAYO1bxuv+3yzr0hucd4kdEGu1iHbRylp05oroDK2teBCNymp8BjWBd06xRc0bGsqWriJ7fKgr/2uL/hjEoKkWgMwEoEr76isIqQuULsoAaX3PItdpzsK3b7qFwiRVSqx9SLJ8uJ005LR0aVgDGwf3xCJlpJA37awXzeyRRhLNiYY6IMMNinigMRHkZc0+9Y3t5OR58SJA0R5yrQCgpk4zWjpkNpuUvYvMHuI6KpmkA/ZqgcZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xq4Iw/E/mh3cyEFC2hAms1m6XpyOfkMliNlCzrEMfG8=;
 b=YYt6l4kzZqTAFDR8hOFs0J9PncKRSOm1jFBcBqcsrvffII9WtspuIyHHV9zH8woGWoz4euohlcCTtbkk4+PMGH8/qCJ4MDCJC66Gdebcs2ZerSvmSrnzqXODwHbtCDaOfaiE7HuLwtjerAQBN7lPC+8kvsXRgDNNUt+3tde/g+d9mds4NBZMKhxFRSbWxYp4ti6GHSlfdsJfXuV+8qlRpZ46fZFj6jd0jNBixBFbfAm8qSvsTqwGLYSLzizhMc3qTS17UauskrFoMEIFXcP9XmLDAulmQotSQdyjtboCyO8AvmfAE58H0BSF/MKkWBtNeGgdgWdlAxpH3sMpI3tnYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xq4Iw/E/mh3cyEFC2hAms1m6XpyOfkMliNlCzrEMfG8=;
 b=s/cHcFfFElE9BFMZjIZVQxFp5p4lGc6PXS0VQ5vb8ArDzj+VWLC/xde8H4y7J7PfrBrN1g1I0YfhmGmKEG3UyQzyu0MX48RectJkkbb/iOv50TTTLc6+mIl13yN9anB4HjwKp02gDA5RDi8CKm1mj33NhvraH9dGwMi/T2V+dVQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8612.eurprd04.prod.outlook.com (2603:10a6:20b:427::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 19:01:20 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 19:01:20 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, robh+dt@kernel.org, shenwei.wang@nxp.com
Subject: [PATCH v10 11/12] dt-bindings: fsl-dma: fsl-edma: add edma3 compatible string
Date:   Fri,  7 Jul 2023 15:00:28 -0400
Message-Id: <20230707190029.476005-12-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707190029.476005-1-Frank.Li@nxp.com>
References: <20230707190029.476005-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0067.namprd11.prod.outlook.com
 (2603:10b6:a03:80::44) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8612:EE_
X-MS-Office365-Filtering-Correlation-Id: 376fc933-a014-40d8-f6bd-08db7f1c8c9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l12cK/8IlIYplfZtpPFZ4lkPaIOaTuB/Bf9W/7NJV6VmlHBN2gteSxZeYlrjHYoGFyzN9u+hMQKFaMAPzlnSNz5R7wGyOGo5OeLZ66GeW8B4Mnv/TuuhGfGfXluiD4QbxxJsbsTXzp+MczNyyut4h248EsssGar0k7ePgGhD5jlaS8uELYJF59sq/cThsC34eK1FGapCThJzshPGONcEG1nE6lKoo23bPmN6jMMYFQpsj2BpcQdaMfwoauPfx+HUHAUJgYE8Fq7OAbE/cxjEkrptHjTxOHJzItZpU/Bw44ZL3DOAyqViW7ptghgNJtGknsWYW9Pc6C86Ocun+YzC/WQM8jXnCSnCuIt2QMwH+BBn7ri5kjFegY/JICZQWK7sncN7luDNVd9nN3AkT363v7Lyba3klxCPeAQ6fWm+hKnwoPSIH1jr72nGXqSAjOLrPkzqzflH76a2ZqG3l/lbTyWpDx6TxBb6e+2l5eZilwnO/HKeuyLQ42cQPBZaTInEUbLlgv6xRkegWD97tfu7Ac9m1Yr1EDtsrGIWjFbur6Z7BOBgclg2Ik95x8dTwBT/5JMf54S6gqD0re3vuDfqaZ/16vDSnpbQXbIClIahppXyhuyDxwisyucWAj5HBz7G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199021)(2906002)(5660300002)(2616005)(86362001)(66946007)(8676002)(8936002)(66556008)(26005)(1076003)(478600001)(52116002)(186003)(6512007)(38100700002)(38350700002)(83380400001)(4326008)(316002)(66476007)(6506007)(36756003)(6486002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sh5/dOQqIh9KPF7AxzrhwwwoOj3U6qvg/sQvQkwWLb0iseff+N4JrTznL9th?=
 =?us-ascii?Q?5GuBB8P0ooYRBy4Pd5+hCoVSinZf0a/kVGigsTQWMgOyVNCIdFCT8RRWpth4?=
 =?us-ascii?Q?bh1KrDL+6N7v06Eh98atR1/vvj5BEI7fCZGicFgLcYbUwBb+G6S/nuri/E1y?=
 =?us-ascii?Q?nzHKdOxiNouKBtCLFK8DR+Sx+zlrQE1DfdLdo+/0Adg3+QrnjN+U5+yjeVR2?=
 =?us-ascii?Q?HTrO+Jczl+hnu5uYoP0BsPADvOoeO7E8vKqtiQsW9g0iKNY+2ETk5al8NDpg?=
 =?us-ascii?Q?kYS9oXixdNGM0/eEXz8HNpPE/XqpW8u0U6DgaEWqyvjIP18R4iqfa3TXNPVl?=
 =?us-ascii?Q?HuoHf/hFo7qPBWECxFdy75pdPMVbW4YI6PWZZZcUQOB2GvrhTAB+EDp/wepR?=
 =?us-ascii?Q?R0DLVkiq65e53hmFm+da5jNYas7dq362IiHJNfjb88ATt4jSEGRhdLsRk/Y0?=
 =?us-ascii?Q?6Uvj78jxDD8NvBOfJHwp8kFDyfnTdYzPgUisU+Pn4r3FfxbE60I5No65NqyM?=
 =?us-ascii?Q?6LyH5yLK9/jSskOaNjsHrAsa/i8K0f9x3UNNJE7q6bAKBePF9OUqWGpok/vn?=
 =?us-ascii?Q?LOC/mhiPpY2ywPBwt5lH8tlc7qkxty83J/EGZfm4lsUh0kLERAugeCDAem4C?=
 =?us-ascii?Q?Fik/EvhXz6YQonMC4Sl5mIxM2E0HeW8PAn2X9cuicC7IjF8NgTsdbOQZWcky?=
 =?us-ascii?Q?mjoqntw1VqdR76AHfN5VpKuAD5BqQVGzmdWlwa86Z45vdlmwpluv33aNozfl?=
 =?us-ascii?Q?XnwCfJie0nzzz1aGc3GYITX3bdkX22IZJoRP9FHBE92/iz0aRRZilBi1xPeR?=
 =?us-ascii?Q?rdyxSB9Wi26tU7LShp899gLAL9go8gjub2rD8q8CTBmOJQAhtly1vVY/BQE9?=
 =?us-ascii?Q?GcGcdaUhlkdVYfmfoQSM4CgYoe9AUBnPbndHaaS4kG1LCsdHlghgBiSdLbWS?=
 =?us-ascii?Q?/g+8GOCPt1We76mwhvWDqov6Oy2M4RAiZ1QTxRbzH8jGdNjDgMYM61cz0l0t?=
 =?us-ascii?Q?qhGexKaONIN8a18Buso22YNsTufBWPygCajQI09+GYFjckX3cq0lWw69MJsL?=
 =?us-ascii?Q?Rhxb2Gkq4haKHSaPR5sZ4VnetdvNLmi6do/z4EsGtsVWugV6/NWmsNuCntv4?=
 =?us-ascii?Q?Po1CZWD+y8wILp0THq9ranTPkn4zJlc4NxFPrLUY2u5117M6Mr9WSzP0tjLj?=
 =?us-ascii?Q?HNZp6oV0CdDq6t7y7mxUugUJ0WVVyRC5t+43rVtixdg7Aga9ChYcDlVFvUx1?=
 =?us-ascii?Q?AQgnoDHyaLkhGsli4VF1HicEmXkhlmqqAccsX/HZ9OyrhQrYKaYfMFq4buVZ?=
 =?us-ascii?Q?vGIHDH2My4la9t50N/90hZDvdmiOwD7C8D2hfe0SWTnxpyLYV38GQzDyEd4h?=
 =?us-ascii?Q?ktr9nmgaswz5lCj4Kb8phYnDur6rjkaOb1ie+h3qOAWqgjTu1kAsISziP5eO?=
 =?us-ascii?Q?CtTSkVr4rhmUmEr21gjW9m+vxbUaWos4sKyEekh/70aWGgD0HwqxE0+kDE5w?=
 =?us-ascii?Q?Syx1iRjbByPVkZtMoFuxdMzuzGYh1Phc0zRTmFy+ByJ0QBTksz9TJNs90Io8?=
 =?us-ascii?Q?bdyHuA2No2xvkwdmaOg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 376fc933-a014-40d8-f6bd-08db7f1c8c9e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 19:01:20.0446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RlDcpPy68gSmVzu7EKUe/d97ijsRjpkc2Ywx7d1MSWIndPKLlALfIyfAhO0Uv8FTvHxRe5c+w/p95bAiZlP4gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8612
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Extend Freescale eDMA driver bindings to support eDMA3 IP blocks in
i.MX8QM and i.MX8QXP SoCs. In i.MX93, both eDMA3 and eDMA4 are now.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/dma/fsl,edma.yaml     | 106 ++++++++++++++++--
 1 file changed, 99 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
index 5fd8fc604261..437db0c62339 100644
--- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
@@ -21,32 +21,41 @@ properties:
       - enum:
           - fsl,vf610-edma
           - fsl,imx7ulp-edma
+          - fsl,imx8qm-adma
+          - fsl,imx8qm-edma
+          - fsl,imx93-edma3
+          - fsl,imx93-edma4
       - items:
           - const: fsl,ls1028a-edma
           - const: fsl,vf610-edma
 
   reg:
-    minItems: 2
+    minItems: 1
     maxItems: 3
 
   interrupts:
-    minItems: 2
-    maxItems: 17
+    minItems: 1
+    maxItems: 64
 
   interrupt-names:
-    minItems: 2
-    maxItems: 17
+    minItems: 1
+    maxItems: 64
 
   "#dma-cells":
-    const: 2
+    enum:
+      - 2
+      - 3
 
   dma-channels:
-    const: 32
+    minItems: 1
+    maxItems: 64
 
   clocks:
+    minItems: 1
     maxItems: 2
 
   clock-names:
+    minItems: 1
     maxItems: 2
 
   big-endian:
@@ -65,6 +74,29 @@ required:
 
 allOf:
   - $ref: dma-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8qm-adma
+              - fsl,imx8qm-edma
+              - fsl,imx93-edma3
+              - fsl,imx93-edma4
+    then:
+      properties:
+        "#dma-cells":
+          const: 3
+        # It is not necessary to write the interrupt name for each channel.
+        # instead, you can simply maintain the sequential IRQ numbers as
+        # defined for the DMA channels.
+        interrupt-names: false
+        clock-names:
+          items:
+            - const: dma
+        clocks:
+          maxItems: 1
+
   - if:
       properties:
         compatible:
@@ -72,18 +104,26 @@ allOf:
             const: fsl,vf610-edma
     then:
       properties:
+        clocks:
+          minItems: 2
         clock-names:
           items:
             - const: dmamux0
             - const: dmamux1
         interrupts:
+          minItems: 2
           maxItems: 2
         interrupt-names:
           items:
             - const: edma-tx
             - const: edma-err
         reg:
+          minItems: 2
           maxItems: 3
+        "#dma-cells":
+          const: 2
+        dma-channels:
+          const: 32
 
   - if:
       properties:
@@ -92,14 +132,22 @@ allOf:
             const: fsl,imx7ulp-edma
     then:
       properties:
+        clock:
+          minItems: 2
         clock-names:
           items:
             - const: dma
             - const: dmamux0
         interrupts:
+          minItems: 2
           maxItems: 17
         reg:
+          minItems: 2
           maxItems: 2
+        "#dma-cells":
+          const: 2
+        dma-channels:
+          const: 32
 
 unevaluatedProperties: false
 
@@ -153,3 +201,47 @@ examples:
        clock-names = "dma", "dmamux0";
        clocks = <&pcc2 IMX7ULP_CLK_DMA1>, <&pcc2 IMX7ULP_CLK_DMA_MUX1>;
     };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/imx93-clock.h>
+
+    dma-controller@44000000 {
+      compatible = "fsl,imx93-edma3";
+      reg = <0x44000000 0x200000>;
+      #dma-cells = <3>;
+      dma-channels = <31>;
+      interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clk IMX93_CLK_EDMA1_GATE>;
+        clock-names = "dma";
+    };
-- 
2.34.1

