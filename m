Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB17534D3F
	for <lists+dmaengine@lfdr.de>; Thu, 26 May 2022 12:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbiEZKW4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 May 2022 06:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbiEZKWz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 26 May 2022 06:22:55 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2076.outbound.protection.outlook.com [40.107.20.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDEAC1EF1;
        Thu, 26 May 2022 03:22:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXa/jOgdAbwqrFQZC0qnFu5iy5UOwz8jZwTNeailfDpZA9pFdSinX0CR579htNRbTeUw91ZlHZqVv9g/CRDnW3QnLbd95smv5MLdmcIi0GiUdN7sXi//SuDBRGfLw4Jnt8ki+4IUaRrmUeM/4EFLUJgYBtnd0ZDNY0BppbfJaAEgj/kTB3qZk+IIaGgsvrlVBjDyyhV6MraUhqOvm3za49eDsIzQVvz2qwX1pa/VTEjIgmNkYX/xdAoQnVJ5xAYgXivTaHJxC3LFujt1RQhGvHz/Q9Fls+zKKqqsxag/H2rJK7LSgj02Ar/1WwQbNdLF4kWJQL3aYaB2skBUL0OTJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCoMqsV7MrO3W6toRelN+8j7bZZqqwTrnq83NlFgn7w=;
 b=XVDWPbNFHMoxBCANX02bujnuU/S+AdQ5+Mp2gvouLp6YPhHBW8xVhaRkU/gRYAst6pav1DRwEidH0JyHkfO9lxr67/zRGwl0LbWeEBRaltsFcLv/uIBKcffk9oRKI0XinsvNsRz1RH9y4njGR/VPWNPjCHeAhLZ1xcE3eca/Sis1SJmP5+nTEx4rg2udalIdtprfMbTWR90/P9iX1Us8P6j94rhy2q55GAFHRhQiFzubsi/bPqVmpqqtMVvjD9nOegBUCj6xzg3pkx129yamR/+hy7cXbxvmkdxyd1rOXuVTFG4TKicaqzwirXXu0zkfLoZgoY2NaJUncgz24m6p8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCoMqsV7MrO3W6toRelN+8j7bZZqqwTrnq83NlFgn7w=;
 b=XizVYw0/9EGGnDCZjn8/E5wzH2wxW1KF+YU5dWXbxErLmUl8zv/gH5zr+o5iCWeyFoUyxt0mIA3JtoT+b4h8q/XJ5JR8d1aLdJEgGUFlMrlhPtpNv7bn37JbQmtvrsVug5Fkoa9JXWoT+xt7ZAiFeQKISKhjH6JEXMRIfVvEfYw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB5597.eurprd04.prod.outlook.com (2603:10a6:803:dd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 10:22:49 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 10:22:49 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     vkoul@kernel.org, dmaengine@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, joy.zou@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] dt-bindings: dma: fsl-edma: Convert to DT schema
Date:   Thu, 26 May 2022 18:24:38 +0800
Message-Id: <20220526102438.184803-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a53745ae-8f6e-4cd8-b2b5-08da3f01af1f
X-MS-TrafficTypeDiagnostic: VI1PR04MB5597:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB55977E681B643A7B9DF94707C9D99@VI1PR04MB5597.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KsrBKr3EqVlL6OhmtBROQ8oJqBGkGbSbFgoizxY0ow5yGyMp3aeOgu1cWoye+J2dVxlRy905dLserzqXFO3WPOXCjlXfJ3zRVQA/QhL6QY2g4B5NIZ3G7oWBZw/sYwQ/F/oecD12Ma9GIakN+ymUdkdCTGVdpsozlPAfQfA6NRtHvZC2MTg4DOvXIv1KMk4PlxXul9s4oZprGIcqNxEWnKaqmD9M5qMEZOR7IDaVKGo6Ca0aqP97tUni5iRhJqoDS1HiyeS+RVGH+jQF7LxaEv6VbicI12fhP/3DI+6yNLIqnh6KiXY1Xk1RlKU8k3hI/Mibb6DmYLmDZ21n72Zq5/3XI+6hF4w1XfRtlTwQohAjk+skKYFgAbHrbBIEtS6vQA5Xr6sw/VX/IJjflTcJuSPN+aIU4SUPQDcnHJQzpCWwUe7LeBbyUnoakWr/Qov7yzsmMHC67QF6QgiKINZFCAFA4JfoSZYC5g5bh/Yt0ji/T7Q6lt8Q0nAOwiYCxtCAZTPwQteuvrINzFgR7yT3lGojBkn0WruUnmTc3OoJ9LPBvjfP06qk0xUliT91+xNGx4QnNM3xeA2N2IMGK2ZTIyB3GIsiXY9g+X7IcRbC+A8j/OXAFoiJ/avrMoG4OU0/9/K2j2o+/VU+d0ZR3ScMCxTCHkm8iEHOjdi+YHYQbcumrDJY7sk3TGwAuJgs9nvC59ZHNT3MHl5GH5zVeYaWkOuGhGxcoGZH07nsVyX1/+x4mwnEDu/B+agdTD3FpP18bRcUYI+yvTEl4EnZiFWL7HW/kDaE5gfxTusZzk6P0LuN3ZG9boOmcV2g9655u7g+0TkDBDP5uj56o8hIr9Xz9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(966005)(6666004)(2906002)(316002)(8936002)(86362001)(6506007)(5660300002)(4326008)(66556008)(66476007)(8676002)(66946007)(52116002)(26005)(508600001)(6512007)(2616005)(1076003)(38100700002)(38350700002)(83380400001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O87P5tDawRCXYf9reTxAWpyILhynKiuPql9+PktZXpYQHYV+Ruh2VIn5wn9Z?=
 =?us-ascii?Q?fxmXgt/u96lsP76ctHHXuJF64O0wjZXyTmBV6LXUG9J5w2LXK1gzDwUogU+G?=
 =?us-ascii?Q?edTuvQ24qTVZOzv+NF2S10Khs+XiOLHbCpQSadZT3Qy2g0hl8ZkcMY1m/lfZ?=
 =?us-ascii?Q?C9ee7VdNJ6gaACabfGUFKZjl/263apouNmPPdGSWJRAcIQasDDLzjyyECEV+?=
 =?us-ascii?Q?CqhT5DZpPkrub/G+xDhqEhiwAa4wUd7zy1P0xjh60qkehJ7k/+IG5wmXXU6M?=
 =?us-ascii?Q?2c0Ohh/417Er9ehYiqKJr+EUm0/Lh2zPLZJZRh4doFr2X0HZ9s79ADJfHBug?=
 =?us-ascii?Q?j5kW1bkja1ITnT56bcpH0JBjRed+Vsc98CAzBHEObnpvU0kgk9M1VLvhabNu?=
 =?us-ascii?Q?uOsuadyDnxa4vYCZQ0csRjk3i6DzE2LrVdUvFOeU01qDCU6WzZcz3pBmuajg?=
 =?us-ascii?Q?wcdeGJjb3jFZdk2b5FY6Pcb+ejoOlXIfpXWrNN2PTa++xq5R1T0CiUo8IXJb?=
 =?us-ascii?Q?MqYDknhPKSSaNJpmnOMzJJCaUFc/wKiFoc5vH2h0j5UKjAEMZBuZfo1stFva?=
 =?us-ascii?Q?q5sgivB0UsHOwxbWg+73/UXRFlFbwb6pUUpg5svixLIpIocr7O7MZXbZSvsp?=
 =?us-ascii?Q?ydHYwiEA9jbVjfUFJa7uUqEGSd97f+UsLFRJKVo49+sxdhCdPcvbSvIUsTRw?=
 =?us-ascii?Q?oikhXK2aYe0oZUQokv8hLbxf5s2UVGhzrMhbkzRB8iLLGhFQP5a/R8qXK/eo?=
 =?us-ascii?Q?SeizumZ/YvjzhGNrI8sh289hrzuHpF200EYk88zjcq1aoJXrovcsxursowgT?=
 =?us-ascii?Q?N3qCJF6bfu8r0a8ksLjfetBqzENvAp2fiixvxqZDWqcK3ds4KmKd3PBSFSRR?=
 =?us-ascii?Q?oMEK8Mw87zNdWJ/t4wawpwl0mLBlwjy/S1oB1/nByBD+ICJi3VcPCw8F/Pqk?=
 =?us-ascii?Q?Tazb19mHS9N4Lq83n8lQwUnXG4x0+28zyuARMCiseoruNcpVBcNKfYyp+amX?=
 =?us-ascii?Q?YxIPHfgC0RSCxaJ7M+24I3iTtkjNEExcl6P5yaSJRFtX68+7BFqclFHdw5CB?=
 =?us-ascii?Q?pJIGePl1mna76jaOCrwDech1LIY9/HflJKq+0lxTwaOX2ZIXQ3AWkJtaMOlf?=
 =?us-ascii?Q?fiQDjwU7KrFEkvGLaAefJ4PPHEOJY5p3fb0Z9iGpb2f7f6N+ujEs7YVi3bta?=
 =?us-ascii?Q?jbYvbByf29JLIFnWNR/AWT+aLwxG5hspJeLLXusJKi40I62shoHGkvrz/t4W?=
 =?us-ascii?Q?xElvU0v2NVFcgEC/q+ktvJiQ22OVd/q4yaNTzJCgsp+8fM3Py5zmjvZMGn8J?=
 =?us-ascii?Q?E6EXMAaakt0XO9sPzBpjiSCMUI82XMALwmOYF267ouFdPFn3duM7iNWHMrNw?=
 =?us-ascii?Q?OqMA0xORqqUKFkBNiB/8YecXEBwrtVJQUgFaXI6sgDvFWB5+NjGFMmYiNGvy?=
 =?us-ascii?Q?fowDzjLc32nVIlCW/Bov825mMlRhRtpbjgwcJSn5MziRcOLHlrwe58wPZrat?=
 =?us-ascii?Q?To6aFLxSJB6n+QO9VgCE0sYgSdPQL8TKP0d/lnMDBfqpabyiUJGsgVka7qT8?=
 =?us-ascii?Q?zuWepjh5nOtcQ1ri5actydmOgQ6ExGDqY+mdXPT2hO1c6z2ayPXuKy288NGe?=
 =?us-ascii?Q?Tdu9wcOIPXSWqNRpCN5Lm7xE1rV9BUe25Hvb6xuVcYSyLf2pQQ5FYR4opsQC?=
 =?us-ascii?Q?R24iUcPuQPdm/yP9e7XrODkfPrku7EFDGFKR1rjAqGYjTMjYJLPl4/sntqo/?=
 =?us-ascii?Q?3FFO0RQG4w=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a53745ae-8f6e-4cd8-b2b5-08da3f01af1f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 10:22:49.6328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PLKIgd+zXwQiblCPsGPm7ab1Kzbn7qk2ydM/3wfkZ0kgGnsmAyBAEU5tBdOQeMg1+qrKOXCLpoEiIkkUTbYY+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5597
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

V2:
 Typo fix
 Correct interrupts/interrupt-names/AllOf

 .../devicetree/bindings/dma/fsl,edma.yaml     | 140 ++++++++++++++++++
 .../devicetree/bindings/dma/fsl-edma.txt      | 111 --------------
 2 files changed, 140 insertions(+), 111 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/fsl,edma.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/fsl-edma.txt

diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
new file mode 100644
index 000000000000..0a63b0b70f98
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
@@ -0,0 +1,140 @@
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
+  "#dma-cells":
+    const: 2
+
+  dma-channels:
+    const: 32
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
-- 
2.25.1

