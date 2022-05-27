Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FEA535770
	for <lists+dmaengine@lfdr.de>; Fri, 27 May 2022 04:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbiE0CDa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 May 2022 22:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiE0CD2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 26 May 2022 22:03:28 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20047.outbound.protection.outlook.com [40.107.2.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A25C03A8;
        Thu, 26 May 2022 19:03:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdUtSvQZFZ6voKq4l6Xwq3IR4EEs6U7wVsVjtvamI6SGYzA2n1eNCCtX/FSxCKAgaF2PIYJ0SlDdZeVeF4KzpHH58q9zG1U/XgYA6E34uddZTqIBY6fwfN9ACjdXeoHJi1nevep7EaoI2neM03Mu4EZM5LzKRw2SWmto92fOVh764bTNf57KQ+Iyjkkf9Y8oIm8XKxEyRfBUalYMzVLIovZernNuSoOqiNWo6rueKYkFGnq/YFQU+Pddiw+T3mf/pZusL56XytAjn0FDzFWKb7ICQoG5pfTRuwuZ6qWYVdBdPP44SBW/e62uHg7tEtoqhXb2SAR51SUxOLaQnFs3jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTJJ4fvKxay9VZ4PezBfi4Zb5MYpoS2toCyrHkQeAnM=;
 b=W++nQdv137YEkIUiWWc0mHaK0Cb3BG+yT8ysUKfIkDxPth1em3TV23uDbo4LtMj7Efy3w+50CUKDnmYnGlV1KixteaiACqEcuo9SH95pYNE8uykpEF/+UMWB2Zgmd4A6zBElwDeZPjfZbYeuwuB+Ij0pVdnfi+YxVWfir5wERzI/lCVl/HtsdL9KTqpXLyIaM1gTilKR+IU6YhUOGNyvrG+6OEdUn3qry+qdiExWbTQo6emAg/s0b+bXkyeZ1YsILQ+UjlH40rvCSgycAj8MBwzhiRGWUElSV5mQKbV8AcvmzPV9Wx5V9fMK4N/SA+j1xCjjWkLKEdVf3IdcNyZxKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTJJ4fvKxay9VZ4PezBfi4Zb5MYpoS2toCyrHkQeAnM=;
 b=MdWMs5LgEPa0scjtmI5PneglyfaC6bZEPUAMfx1+Hr8pv6JAMGGEcOLd89+Ydkd1JzTrDqNkAvrrmgizxBk9nfl0noRBWnEmEELNv57zFaUJBN7g4HETbqtN8QWOOcsgfRLmnBYrYnjPudV7uSTCTNjMNBMKFPi/NdVKyV/2rsY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBAPR04MB7237.eurprd04.prod.outlook.com (2603:10a6:10:1a4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 02:03:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5293.013; Fri, 27 May 2022
 02:03:22 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     vkoul@kernel.org, dmaengine@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, joy.zou@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3] dt-bindings: dma: fsl-edma: Convert to DT schema
Date:   Fri, 27 May 2022 10:05:07 +0800
Message-Id: <20220527020507.392765-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8332a30-ec00-4f91-f9dd-08da3f8513ca
X-MS-TrafficTypeDiagnostic: DBAPR04MB7237:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DBAPR04MB72375BA68EE088D598A89246C9D89@DBAPR04MB7237.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GVrq+p+nRtEW/C/fdrgUM5PDmhE+8jV+x4rstNrYZ9VapW4/Apx9jSpqW4gkip7KZneHFJ4P0n5Rqn9b0Q8AMWZd9DMMES40zUViNLTa05ukvic251RJeyE21E0t6nJQ89TUBrV/VcVTK4d14APptsyXmwc70SIE0/vsGQSiF0RfldZHlipjlIHTqq0EEa27qVlFHRj9iKpE6speo9iu5W8B69jZnQ4X7xg0UDaD5xR7EvykU3y4yK+0r1Vcefmqm11K4hL+WdsIPC5DAU1bGyyJ/YwlqVd8Iot0tnOVmTxcyoj+BS3BXjmp7np5Lx0rmftVmxIl6j6DN4JHiL7nuEoYrrBhyH949xTtV4F6cQwTRRat/m2nTGZPYd+uQqLxZ5kv5He5xG/0T/zweyKWe8AabC/GO0cD1h1dgbAjpQPoUZGB92prMH3a0WCsxJ1u+VcKb+58AtCA6kSlD62muiMENp8BmonwviW6iF5D3Om6uJvZG75XAnETjYxGiogpSQn2t0J7nZHV5nGXwKXW94a4r3oFV1iHEgK6U48Jm38Z7I3MioOdb5I+besjxnQ5zXX1oPZcwwTWkHYYveOv50Jrfb7iof7C0seWW1qx21u+canSqC/oIwtf1cy2rCSe/+L9G7pt8NGhYG8pXgcZ/PMbB9JKzlXyFDR/W5SOZVI/45FSbYgdwR6AKXQTBhX20bMVN2d8vKZ3CMGaHc8z2eq/SbuNZwgkdNYiX0/zhXrAC3kd8oSNs6Hp9Ic/fuibDuF6QngLGfOoYben00QL5snri0TdEbmR3rXmlC4e4dlcj3vp7stxc5t9sOqcGBK/oBSGgRVa9kPJ1HfDUBs46Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(508600001)(6512007)(26005)(966005)(8936002)(186003)(2616005)(1076003)(316002)(86362001)(6666004)(66476007)(6506007)(8676002)(4326008)(66556008)(83380400001)(66946007)(38350700002)(38100700002)(2906002)(5660300002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DWVqsatBFpYpUd3mMCTazYSvo4UHk4SGZP+icWAJ2yO+sByaJCt1Ql4OgMuS?=
 =?us-ascii?Q?2KFsSO1j50zdUrg67XX0JeaocKI3CMwlJkSVesh/GRoFdX/rT4sIBdgMjMYK?=
 =?us-ascii?Q?IAljUdqACodCgFgugmtcmaNx4Ek6/JA/ckNMPTbT8jzBhJnLTexsPpJ8/yAP?=
 =?us-ascii?Q?N8bBmguW0IiyVpJOUwe8Msw6YBDr+KyH+DIcxan1POYU1zFYIzXhKgWi+dlH?=
 =?us-ascii?Q?MFJqTgLLcbpyVl0lPdzCr/B/DmAG2jzyUk9wHeCfiS3TYaGPRS+/f/J0uTqw?=
 =?us-ascii?Q?Mh2jlZkOiqZ1usZf2cbxz5EI3pUByb89JGhbC94h4uVMuGH1cWZx70udzCZG?=
 =?us-ascii?Q?RFCSg6dPknoL9bPFR0vpn6gvojS/LEzoKTO4+MHuye7MFhAqw29bopbRO+VF?=
 =?us-ascii?Q?fIHXoHRIBtx/sVN7FiQ6y17gzAJsnKgN1kOIdjzkR6EvX9CqYntxtlM/z4/u?=
 =?us-ascii?Q?jW/jh+OTfs+7A0GNwv23NgK2fxMOjmZSP0zt8mxasl943Ft7u9Vn0sPLxNuX?=
 =?us-ascii?Q?6Mevn1bRoPORiQJaf4AE9jAeKsT2vY2qNmC8zdL6HhJJI03EBMFtiYdzpNb2?=
 =?us-ascii?Q?zUhixq0AwA7L68Mrv00X9GUj3WCxpOysAXs8eZSOdTCeitl68o8ZPX/o3YZM?=
 =?us-ascii?Q?B/2YERIT+gYU1+fP3HQvHdWxQn2NTkt2qI1Te+2QMDTxzVKHgmjzca7vMUT4?=
 =?us-ascii?Q?+2w3+ozAhRHMMXM3SZlnBQv0NBTdAP4HhG2pkIImWy6q90RY7MA3r7ZStVhk?=
 =?us-ascii?Q?zrwbLInEZigqRfOzsG8VVFRG20mWeHX9sQCbtWJ7HmeC0YXg6Kx7RzdqDOY5?=
 =?us-ascii?Q?I9UXugK4QbNdsoXnhfwPUuUBlH5rdg1EMYxGAXGyJLBzzlaD33zOuvA3IDgU?=
 =?us-ascii?Q?rqTqzJ/GpV5FO2e/1B3hlaNhl9e9yQRBntEbY6k8A3fpGt2vYA7nblm3b2xj?=
 =?us-ascii?Q?nFV3rPA9JhQZ4qDkhqFW8/fPEmVbpKHO4vJcLeBr97t8hbMV0edOabKPXwud?=
 =?us-ascii?Q?z6ujZwQ+u8IzV9gzdwHiouaDMjYLxqVCh8x2sL78jTrM8/ITRjheGv4maw0z?=
 =?us-ascii?Q?e/CEruJKX69GhDK3rAsYgxuo8CJ5ySvE4Ei4IKecKU9xAEhxrXdV7MJieiho?=
 =?us-ascii?Q?sYNNjaHvPh0p8mPfkyFfeRDKwCNL5QLyPu/3buSBgR7oftNmfjs3RVVlQPEp?=
 =?us-ascii?Q?/YQ0a0x9CnO/DK/vbbMlliPYrD7z7V2ND6UQcU02oMSeE4rFaUWf7G9HMJrY?=
 =?us-ascii?Q?DmUCJw0Ch154/z05Pd7xKz70g6JnN05akwPrJtlAgEe6krCjiCxkqJFEqMe4?=
 =?us-ascii?Q?u4TEJxQsszysCh3/5sAb3bZheYiRDRVf2clQg7y3/Kgz3IXsY1JKBnX/XdAo?=
 =?us-ascii?Q?/eAZqsbqkQXh3DecgEZ2mz58OfsK/AE5Ivc36bjOHlGRJOgnvLvdNocYK/FQ?=
 =?us-ascii?Q?qReBzLX8eVPvyUwDsejzjspGXaY7hREcGqT4Y7VftVHpUTfeCQ+srnwgZkqx?=
 =?us-ascii?Q?em/KUpMWvHGUG3ra/7WROjVvTAOQtNagp222otFkKYfc1IRhxGg8TpMyUmqf?=
 =?us-ascii?Q?VpJwq0J2JSGzphUA66U0COVDgK0E28TbHo4IejbAjttN5iFzR3dixHAl5Ft0?=
 =?us-ascii?Q?MDjBuJa08UA29OuGxlDURIbowXeYXrgDz1TZj/RHlmfjEDt05c8Of+u4Ia91?=
 =?us-ascii?Q?5OlP8nmj4zFS/2gQzIZ9X5lBRIPIvJx8K0XR+OnAURkzZMdzKOyz4koQ322x?=
 =?us-ascii?Q?1l44dqqL6A=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8332a30-ec00-4f91-f9dd-08da3f8513ca
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2022 02:03:22.6132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EnGVRDVuekEAX2LcoV8Rkrbdz0MOCtgYtBpm89MYLVQTE8XBLwerYUTelvtQfvc2GF7wSvJce92KWgxrkJgohA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7237
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
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

V3:
  Address Krzysztof's comments, for reg/interrupts/clock-names

V2:
  Typo fix
  Correct interrupts/interrupt-names/AllOf


 .../devicetree/bindings/dma/fsl,edma.yaml     | 155 ++++++++++++++++++
 .../devicetree/bindings/dma/fsl-edma.txt      | 111 -------------
 arch/arm64/boot/dts/freescale/imx93.dtsi      |   2 +-
 3 files changed, 156 insertions(+), 112 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/fsl,edma.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/fsl-edma.txt

diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
new file mode 100644
index 000000000000..050e6cd57727
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
@@ -0,0 +1,155 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale enhanced Direct Memory Access(eDMA) Controller
+
+description: |
+  The eDMA channels have multiplex capability by programmable
+  memory-mapped registers. channels are split into two groups, called
+  DMAMUX0 and DMAMUX1, specific DMA request source can only be multiplexed
+  by any channel of certain group, DMAMUX0 or DMAMUX1, but not both.
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - fsl,vf610-edma
+          - fsl,imx7ulp-edma
+      - items:
+          - const: fsl,ls1028a-edma
+          - const: fsl,vf610-edma
+
+  reg:
+    minItems: 2
+    maxItems: 3
+
+  interrupts:
+    minItems: 2
+    maxItems: 17
+
+  interrupt-names:
+    minItems: 2
+    maxItems: 17
+
+  "#dma-cells":
+    const: 2
+
+  dma-channels:
+    const: 32
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    maxItems: 2
+
+  big-endian:
+    description: |
+      If present registers and hardware scatter/gather descriptors of the
+      eDMA are implemented in big endian mode, otherwise in little mode.
+    type: boolean
+
+required:
+  - "#dma-cells"
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - dma-channels
+
+allOf:
+  - $ref: "dma-controller.yaml#"
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,vf610-edma
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: dmamux0
+            - const: dmamux1
+        interrupts:
+          maxItems: 2
+        interrupt-names:
+          items:
+            - const: edma-tx
+            - const: edma-err
+        reg:
+          maxItems: 3
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx7ulp-edma
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: dma
+            - const: dmamux0
+        interrupts:
+          maxItems: 17
+        reg:
+          maxItems: 2
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
diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 493d4be710e7..25a1430fe5a9 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -349,7 +349,7 @@ gpio1: gpio@47400080 {
 			gpio-ranges = <&iomuxc 0 0 32>;
 		};
 
-		media_blk_ctrl: power-controller@4ac10000 {
+		media_blk_ctrl: system-controller@4ac10000 {
 			compatible = "fsl,imx93-media-blk-ctrl", "syscon";
 			reg = <0x4ac10000 0x10000>;
 			power-domains = <&mediamix>;
-- 
2.25.1

