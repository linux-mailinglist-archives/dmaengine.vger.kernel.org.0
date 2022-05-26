Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92621534988
	for <lists+dmaengine@lfdr.de>; Thu, 26 May 2022 05:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344957AbiEZDyf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 May 2022 23:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344872AbiEZDye (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 May 2022 23:54:34 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2057.outbound.protection.outlook.com [40.107.104.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7330BDA27;
        Wed, 25 May 2022 20:54:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJ6o6el/OaUNK8v8ill+7ujCB1zOaS7ee16r3JtULNdwIXsRcuJwwsuRVCdBbcqn3I1xFrjnfVQGrW3GHQy5VS8ULelNJ6hoBjdqi7Caaq8qzYfXIVQladTZhPVvwKNyhWUjzwR0LciH8fgtf7x1DLFFPxgNTB8CJOmqHdUL+pL9+4YjHbCPcYRw6kEi+C49EPUG/DmnhBvuelt+uuOqmPrmMxGlvkewoXeoMy434pIN5hPd1K9sKJVnNBHbbG4zfdMfQuG2Z5Z2nMv+rHxYicuYSeqvJoV8NntcrzF+N9YKa/pgPtwl6IfCRt0+y38QDU0ClpmXsyxwMaI5qeUmlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3O0tWYs1pkeUT05i8jp8mnpmY78QFnCaC3qm3KG8RI=;
 b=XP90sBbedpCdtQMeY5fi85EjYPg6HtrHdIpNSW8cIvfGyvoIRx+Ca5VKidBI8gEmdvnLFtwcAURd3ofB/AGyndAIAzsRvqPmFT07TQvqS0Ak1F7EyfArQfHSfZLPl+XFfW3kaa3WtwTpjFh8OInoo6xHAjH8lwEuwvwt0PH1n9tgFin9aidnVilHOJ91HLteXD7GOnkG0c/O4tBa+LOKDeWBM52ieoyUUtArNJ5BSZw5Gul4Wv1L+fBtSEjcaraxmfhKNSwSBuvQiB0zTQsSQAwY/hwVOqLFXlRb+rhOJFRPifLxHNJrD878Fpo67534BxaQKx6G2wgdFuXRaRy7HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3O0tWYs1pkeUT05i8jp8mnpmY78QFnCaC3qm3KG8RI=;
 b=GAhtKb8q+SwLF9vIXNBWnX+iI6PdotKymzY6qCJCciSV2gRoMDc/SLSa2BGRRF9KjpO4nkXnzDQz+9pwvNVfoUj3fOjI+QYO/ygetCUnAsLuKyzSlNK3ANLube378TSUFDJr04yKKnmAANCPHzAN/73uh7r9Y41p7vVWIVO9skA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8222.eurprd04.prod.outlook.com (2603:10a6:102:1bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 03:54:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 03:54:30 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     vkoul@kernel.org, dmaengine@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, joy.zou@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] dt-bindings: dma: fsl-edma: Convert to DT schema
Date:   Thu, 26 May 2022 11:56:11 +0800
Message-Id: <20220526035611.4063102-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::30)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb5f1080-fef3-4c73-5163-08da3ecb6f9d
X-MS-TrafficTypeDiagnostic: PAXPR04MB8222:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <PAXPR04MB8222A0820AB42B4F4C22ECF1C9D99@PAXPR04MB8222.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n195r7sIN6qPOypivx+Q8yQf3Nu+l8ao69FuU5Qp1R4I8g2WQ4m8ophoLWTC2rT8CSNeDjblGK/RZg+WeU+M/4p+XX9q78R46gk4iv7CrbFR4GGeDZRnujvWORCxZ45NEU5i8G3Me3KMZD4buEYEM/BUHOG4mXmB8RyfhUzbM8jzQP4Tku7iwb41C8MguBUrcjjDWVOVoXG8ThpHJT6DCmnGI85vbU94m1YSplW+Kea+tOAX/Wz4ApOm+RnKcpH786GHLXUQZH4zw2o7H/zQOpE+hRxI0oYxRz6Tf0OtTj0Li54EMlhhzXhUz/tEp3jJCeoqSE6Jkcc9BkRmbdxViC6LML/sjQpUsu5cVkrSqbrVSe7gT9FJEsgWCtDWy4Vem8KVhCqk6Wyyf5g9t2EbauhjouMIwGPCg8O43IlOcrI3Agv4lSa5YruL147XZt2pumALCd9qW1XKmHQz8SIfidr0d1XvxROS8461/1r3tKsdBiGChD6DGo8E8TGjgtEEv+2LwG1+pfzunNsh/1P5vMe65+U7MXoder6VInGhAL5N64/q+U2qPmmwZHtHCZ5WDoX7uF+kEmkQdmgDjRLKvgqB20GC8v0E9CYw6Lc/da/CvpPz8q+ghQ1U50MpvU5YzxbelOQIf6LKAy0hA17jEHrSBkU7qQJkdCzCisEZLmWU6MmYL5g+8tYP6tRJiX+KHR4fHliketGEiXJ7bE994kBBXZZvY33smVgwXHQGO+ZcHBM/atljgoXSB5I+3slyY9fQEJsoMNvslQMBJErhYFkgeMDYuKnr4ZFbGMHBWPQfAoZeWYQ8XoIPhP9KSWkrX5FPJOG8DaxAd6UKFevlaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(508600001)(4326008)(6506007)(86362001)(6512007)(2906002)(38100700002)(6666004)(8936002)(8676002)(38350700002)(186003)(66556008)(1076003)(52116002)(316002)(66946007)(66476007)(2616005)(6486002)(966005)(83380400001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BCfXK9J2GPz3+GKdxGbDWms6RfsppxXRvbiIeXm18eOjbaAMlIxDN4XoogsI?=
 =?us-ascii?Q?vGT9FDtz5ubFs3RK3BfJ9QSNZyf+jIZPyridjFIcJFfjsNlhXOP7O8ETRmIA?=
 =?us-ascii?Q?u8FxaQ8jLEX1jCJ5Ecm7xOolmvy/2A0NRp5/rGNTL6SxJccDD8tA5VSKmmjI?=
 =?us-ascii?Q?XeNz4/owV3h0INnwS2XRI5CpVZNGQh293WXjEMv2gmRdTQp2MGMmkAMjgjvy?=
 =?us-ascii?Q?Ptt3z9XNy+RVI7zA83r4C2wkV+GfLb1y6YYekqSz73gaGto6sWrIeBmPDJMy?=
 =?us-ascii?Q?tR1BBNPBvFLPNeyys0KkhwSvhdMazF0eYsO8/o+QL3umQTe4rEVTTj5wiJXy?=
 =?us-ascii?Q?uX9b0gN5ZLcAy9rprNo9ESBxHZA86lkOS5C5PfbPbeSjbhoQ8MS1y3BnDfXF?=
 =?us-ascii?Q?5sBtgmCWSbYB0Uy77YikZ5oe6dlMzMN+N7rS7Aoa2Ovu9gutEV7IDVRjyn6O?=
 =?us-ascii?Q?uQzcub2R+WtwKZQ3CJw51tS3kSc8+8Fzpe6P9YWtoZX0MuyXI9RvSrCCdVMh?=
 =?us-ascii?Q?BTMDRr32jEA1aXVHnjvmdCGTvuZRDtsPzoxyvU8qkdjSxTUpoQ2x/O9O8xpR?=
 =?us-ascii?Q?hLCQsq61cgLTm5Qk0nAau9/OhAPr2nCerIQSlXdibIHkAipuuxR+GTsjmHdi?=
 =?us-ascii?Q?Hh9Ewsx9qjM5g3F7wzcxGb3sQjgOxekKIIkVINgdzXJByuHDfZllO0OwiFbq?=
 =?us-ascii?Q?mFJNx7EuLa48XCsFrcxbdCkgjd2Gek0TICimN9zubBLEeUX2tlgPZki4AKek?=
 =?us-ascii?Q?fznnVJS2Uv3h4r10crmzhFB3azcmAlxB0wptLXxI/hCs5/lI4v/4V/yCJ4Jm?=
 =?us-ascii?Q?dMSHLauGJlX0w/2mVA2zjoQ2//209b1xDLImehYjiauC5ZiaM9WseTlhXGXH?=
 =?us-ascii?Q?QUNqVQQ4cU2nJH3xHMfARH4B1Cu1Zem9KbHHZqsyA6tp93LnBfakrvt2qOS6?=
 =?us-ascii?Q?XjpEwqB3sQk43e+o71puxFo874syVseXXhbblYvHYkcJUgKJjhyciGF4Troh?=
 =?us-ascii?Q?/VO+hWCUL6hLrGF1SVgd8uuTaVPt3+GdCzxoFl3caG/zFhl1AAV55eK8sLme?=
 =?us-ascii?Q?1UFoBdKWS6XY246ifprl1g4kdj4M7Nop8NOaNZYzVxKaSkBEaRf3GycUuKaP?=
 =?us-ascii?Q?OG2jl78CjjZFN9HxbXTUCU9Glp6MIRB5tqFtE67N+gkFL/wbtJKmT0FZkfUI?=
 =?us-ascii?Q?NiG0sHXDe9Cgz6ykfjkfypgzo+P/HOzj/4ny3G/55G+V2mXYkyyIuWZQQ+WC?=
 =?us-ascii?Q?Mr0iq87YAGqBSUpjbc977DA7RdtwSY82aQob0MoZoDGKyCURAswgTyo3PU7q?=
 =?us-ascii?Q?DNYO8hmSfnbC5q3YNB8nVhf4QaD+av2MVVzfVtmCt0njCV/UxJY5Qp8wX2fQ?=
 =?us-ascii?Q?FTYdl8mx51UBb9sK+Ctw1BLmGqJOfNoDl1jdjCLe54nFf6knZaij6BVeuFPh?=
 =?us-ascii?Q?qeel/ZCp/J3K0I950hn5QujtdxGOg02ZzXZ4E4eBmqoJy7IN5OpsQfoKyeNE?=
 =?us-ascii?Q?//k1HpK2Aegha6WRsFZAG93fCuAtvHqMRp5ldhO4jQlMh1S4H7cKeyrDb6kx?=
 =?us-ascii?Q?CtewR9EjjQN1Ysuz7E/cBYZZ2i6hKyqA52Ktaotf5/VFJ3TqsfkjVc0fwLI0?=
 =?us-ascii?Q?waR0+F5n8UUmVP2ynGY2kNLJl9N8USKnUcZ15621JkL6y6ex46AvczvpBVnE?=
 =?us-ascii?Q?uPSotX1fwYSX0tUIw7S7c5zcSpTaCmygv5Oct/DAaIyaKwuN1z6mT4F3znb9?=
 =?us-ascii?Q?SePySO4YyQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5f1080-fef3-4c73-5163-08da3ecb6f9d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 03:54:30.0698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bo4Al9Q0ZqIidee5yI9XTlisYVj+a7gaKQO41T+ncgRGUx3l6iuygPYNvzDS0SurW5nv0CnAMx/T6Zkyse3XZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8222
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Convert the eDMA controller binding to DT schema.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/dma/fsl,edma.yaml     | 136 ++++++++++++++++++
 .../devicetree/bindings/dma/fsl-edma.txt      | 111 --------------
 2 files changed, 136 insertions(+), 111 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/fsl,edma.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/fsl-edma.txt

diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
new file mode 100644
index 000000000000..dbb69aca7d67
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
@@ -0,0 +1,136 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale enhanced Direct Memory Access(eDMA) Controller
+
+description: |
+  The eDMA channels have multiplex capability by programmble
+  memory-mapped registers. channels are split into two groups, called
+  DMAMUX0 and DMAMUX1, specific DMA request source can only be multiplexed
+  by any channel of certain group, DMAMUX0 or DMAMUX1, but not both.
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+allOf:
+  - $ref: "dma-controller.yaml#"
+
+properties:
+  compatible:
+    oneOf:
+      - const: fsl,vf610-edma
+      - const: fsl,imx7ulp-edma
+      - items:
+          - const: fsl,ls1028a-edma
+          - const: fsl,vf610-edma
+
+  "#dma-cells":
+    const: 2
+
+  dma-channels:
+    minItems: 32
+    maxItems: 64
+
+  reg:
+    minItems: 2
+    maxItems: 65
+
+  interrupts:
+    minItems: 2
+    maxItems: 65
+
+  clocks:
+    maxItems: 2
+
+  big-endian:
+    description: |
+      If present registers and hardware scatter/gather descriptors of the
+      eDMA are implemented in big endian mode, otherwise in little mode.
+    type: boolean
+
+  interrupt-names:
+    items:
+      - const: edma-tx
+      - const: edma-err
+
+required:
+  - "#dma-cells"
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - dma-channels
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: fsl,imx7ulp-edma
+then:
+  properties:
+    clock-names:
+      items:
+        - const: dma
+        - const: dmamux0
+else:
+  properties:
+    clock-names:
+      items:
+        - const: dmamux0
+        - const: dmamux1
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/vf610-clock.h>
+
+    edma0: dma-controller@40018000 {
+      #dma-cells = <2>;
+      compatible = "fsl,vf610-edma";
+      reg = <0x40018000 0x2000>,
+            <0x40024000 0x1000>,
+            <0x40025000 0x1000>;
+      interrupts = <0 8 IRQ_TYPE_LEVEL_HIGH>,
+                   <0 9 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-names = "edma-tx", "edma-err";
+      dma-channels = <32>;
+      clock-names = "dmamux0", "dmamux1";
+      clocks = <&clks VF610_CLK_DMAMUX0>, <&clks VF610_CLK_DMAMUX1>;
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/imx7ulp-clock.h>
+
+    edma1: dma-controller@40080000 {
+      #dma-cells = <2>;
+      compatible = "fsl,imx7ulp-edma";
+      reg = <0x40080000 0x2000>,
+            <0x40210000 0x1000>;
+      dma-channels = <32>;
+      interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
+                   /* last is eDMA2-ERR interrupt */
+                   <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+       clock-names = "dma", "dmamux0";
+       clocks = <&pcc2 IMX7ULP_CLK_DMA1>, <&pcc2 IMX7ULP_CLK_DMA_MUX1>;
+    };
diff --git a/Documentation/devicetree/bindings/dma/fsl-edma.txt b/Documentation/devicetree/bindings/dma/fsl-edma.txt
deleted file mode 100644
index ee1754739b4b..000000000000
--- a/Documentation/devicetree/bindings/dma/fsl-edma.txt
+++ /dev/null
@@ -1,111 +0,0 @@
-* Freescale enhanced Direct Memory Access(eDMA) Controller
-
-  The eDMA channels have multiplex capability by programmble memory-mapped
-registers. channels are split into two groups, called DMAMUX0 and DMAMUX1,
-specific DMA request source can only be multiplexed by any channel of certain
-group, DMAMUX0 or DMAMUX1, but not both.
-
-* eDMA Controller
-Required properties:
-- compatible :
-	- "fsl,vf610-edma" for eDMA used similar to that on Vybrid vf610 SoC
-	- "fsl,imx7ulp-edma" for eDMA2 used similar to that on i.mx7ulp
-	- "fsl,ls1028a-edma" followed by "fsl,vf610-edma" for eDMA used on the
-	  LS1028A SoC.
-- reg : Specifies base physical address(s) and size of the eDMA registers.
-	The 1st region is eDMA control register's address and size.
-	The 2nd and the 3rd regions are programmable channel multiplexing
-	control register's address and size.
-- interrupts : A list of interrupt-specifiers, one for each entry in
-	interrupt-names on vf610 similar SoC. But for i.mx7ulp per channel
-	per transmission interrupt, total 16 channel interrupt and 1
-	error interrupt(located in the last), no interrupt-names list on
-	i.mx7ulp for clean on dts.
-- #dma-cells : Must be <2>.
-	The 1st cell specifies the DMAMUX(0 for DMAMUX0 and 1 for DMAMUX1).
-	Specific request source can only be multiplexed by specific channels
-	group called DMAMUX.
-	The 2nd cell specifies the request source(slot) ID.
-	See the SoC's reference manual for all the supported request sources.
-- dma-channels : Number of channels supported by the controller
-- clock-names : A list of channel group clock names. Should contain:
-	"dmamux0" - clock name of mux0 group
-	"dmamux1" - clock name of mux1 group
-	Note: No dmamux0 on i.mx7ulp, but another 'dma' clk added on i.mx7ulp.
-- clocks : A list of phandle and clock-specifier pairs, one for each entry in
-	clock-names.
-
-Optional properties:
-- big-endian: If present registers and hardware scatter/gather descriptors
-	of the eDMA are implemented in big endian mode, otherwise in little
-	mode.
-- interrupt-names : Should contain the below on vf610 similar SoC but not used
-	on i.mx7ulp similar SoC:
-	"edma-tx" - the transmission interrupt
-	"edma-err" - the error interrupt
-
-
-Examples:
-
-edma0: dma-controller@40018000 {
-	#dma-cells = <2>;
-	compatible = "fsl,vf610-edma";
-	reg = <0x40018000 0x2000>,
-		<0x40024000 0x1000>,
-		<0x40025000 0x1000>;
-	interrupts = <0 8 IRQ_TYPE_LEVEL_HIGH>,
-		<0 9 IRQ_TYPE_LEVEL_HIGH>;
-	interrupt-names = "edma-tx", "edma-err";
-	dma-channels = <32>;
-	clock-names = "dmamux0", "dmamux1";
-	clocks = <&clks VF610_CLK_DMAMUX0>,
-		<&clks VF610_CLK_DMAMUX1>;
-}; /* vf610 */
-
-edma1: dma-controller@40080000 {
-	#dma-cells = <2>;
-	compatible = "fsl,imx7ulp-edma";
-	reg = <0x40080000 0x2000>,
-		<0x40210000 0x1000>;
-	dma-channels = <32>;
-	interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
-		     /* last is eDMA2-ERR interrupt */
-		     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
-	clock-names = "dma", "dmamux0";
-	clocks = <&pcc2 IMX7ULP_CLK_DMA1>,
-		 <&pcc2 IMX7ULP_CLK_DMA_MUX1>;
-}; /* i.mx7ulp */
-
-* DMA clients
-DMA client drivers that uses the DMA function must use the format described
-in the dma.txt file, using a two-cell specifier for each channel: the 1st
-specifies the channel group(DMAMUX) in which this request can be multiplexed,
-and the 2nd specifies the request source.
-
-Examples:
-
-sai2: sai@40031000 {
-	compatible = "fsl,vf610-sai";
-	reg = <0x40031000 0x1000>;
-	interrupts = <0 86 IRQ_TYPE_LEVEL_HIGH>;
-	clock-names = "sai";
-	clocks = <&clks VF610_CLK_SAI2>;
-	dma-names = "tx", "rx";
-	dmas = <&edma0 0 21>,
-		<&edma0 0 20>;
-};
-- 
2.25.1

