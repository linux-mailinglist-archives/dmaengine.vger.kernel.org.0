Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E299E734795
	for <lists+dmaengine@lfdr.de>; Sun, 18 Jun 2023 20:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjFRSMS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 18 Jun 2023 14:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjFRSMQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 18 Jun 2023 14:12:16 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2050.outbound.protection.outlook.com [40.107.105.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04FDE64;
        Sun, 18 Jun 2023 11:11:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdH0fGA6IXGemucvNo3U/LDd4S7wKQbgDkV4Aoid3HrpL0kIEkub10LYOTXw26BUKOGGOOYKLefz9NrY1rtnCNESx6jDVc046Z2x8mujt1vtIbLZOw3bhsrmgotjrPhuHdB/bjh8XFC86SNn2aFXulUXhSohnFwj2MIVHyNop83JSY1urPUKxfS7kpmj5+kPdtCGDUvgMvzRiUcGRqBjjZVfDZ/XeNisnkVnlc3m53Hy5i3yWQbRfGLLLy8zi9NJp8MeefyFh2hwtzvgh84C4sqjEIQubkXUKKpZ4lHF3TNhAzVdWDwwhXBaQOKJKLgCC0UshGyUkkMXNEBxlI1PEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1aMJzWiiDVx+EzvQ6gIRjNjd3cakxN2zCgL6Y+LfCo=;
 b=TUaeeV3UlA5tqCmDC2D7QK2zYhK7VSK6YIAOUMta/LQDzKB4wPbaPgPi2OAKhJOPIxJ5BuKsaQyvAVwAtgH48bsUoFQv3Crc0dUWB65SFKhdbJ0Yb0BDOWaTEnXtmoWfrcme5Gj+Vl3r6jjT9mlz8+QQA0MWK7aSXCM5qZJDwpGHiR2Tp/LCvlewXh71DI9UTL+h5yCJYaeFbUIOsLYQYWcVT9wwys/+TcW//7ZvK64OOizzYP9F9rgYU8RzMp0HyPThtunIiSvX0a3A+ou/9zBUAZMNMH1HHDjeNMn1Ajfrk+ibTErX3EiBtD7Uz4ZyWVtFugmcn3Mt5FVxA0ShxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1aMJzWiiDVx+EzvQ6gIRjNjd3cakxN2zCgL6Y+LfCo=;
 b=S2HlA6JgAcZTunpHmnUUBCKlDVfnecfwfPWX9EX/essaLUHO+QqVTCkmc9OcOGcKlT+WNT3oJrjbi8BFIR1z1wEsrJLhg4yOPG/RoJsudGry5ZCxzKkLw6Onar4rZOo/WPGVaw1XL2Nw/t4tfHWTlSxyo4af8Y/0A4XLdsmsZ+4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB8PR04MB7019.eurprd04.prod.outlook.com (2603:10a6:10:12b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Sun, 18 Jun
 2023 18:10:23 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6500.031; Sun, 18 Jun 2023
 18:10:23 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com, robh+dt@kernel.org,
        shenwei.wang@nxp.com, vkoul@kernel.org
Subject: [PATCH v8 12/12] dt-bindings: fsl-dma: fsl-edma: add edma3 compatible string
Date:   Sun, 18 Jun 2023 14:09:25 -0400
Message-Id: <20230618180925.2350169-13-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230618180925.2350169-1-Frank.Li@nxp.com>
References: <20230618180925.2350169-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::23) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB8PR04MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c5a7828-747d-46d5-5e23-08db702748d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vqaiUnzQwuw1fZXIoPtJ8HhCXR3XigAG0H6r1ibMREaNdqBDW/wvFrJx+q0qwKeczdUKfTUWS4r/iEQ62NXey7eJ7WEi0XLodafaZHKvpIcaNDplXKdXAPA6lTSyusHpiyEnnLuipOxLGOjgE8mNo2FzVXjEcLTfverFgo9WvJbdNHTkHwP0Ac8mMx5a9gAA5R2sDltFAbbOIKEaIHN72LaBEJnSZTW0kKADMFeVT2xfZPblvm9SdGwZtGvqtqXWGQ74qNJ1gdQeJjrezAvCn3LQiI+aIv4wI+2PntUz/l/vZbISAHPsumUFBhnH3BupBq4I2/xVGJMNEo4Llq+5ji7SRw444ui+7nM5q3X1fqfs48Afsz5hrx4k36p0n8IFaVLwYUmYx8nzcJ0x8tkZuU1n2NDkh8Pvy+W4ffnjfBgouUZu6nW5PSx6y6WpVUcM1Y5PtekipLTciitgrKLAUm9pSM5zQRUFmZyCd3itCa9dW1MjD/hYXqZdirEMhI1AvqTV8XuVvn0YHLJ/nMboh6whKaWVXXlc+ZnAs/5Zpmj51ErFGFd91xhbtRI2+mf/azMFEpcZQf8GTQNBf8mMxMc33nIxdkiDm+CImEyHog964jeCK+D8Eq674YC6v+kS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199021)(66946007)(316002)(4326008)(478600001)(66476007)(37006003)(66556008)(86362001)(36756003)(186003)(6506007)(1076003)(83380400001)(26005)(6512007)(6486002)(34206002)(8676002)(8936002)(5660300002)(2906002)(52116002)(38100700002)(38350700002)(2616005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+HL+LNkXOzq9L7PyOpgMWECbY1zJWDMSrKC5vcMS7f7TLpD1Nv6a9N4FDNg7?=
 =?us-ascii?Q?Z1/5u3jq9Jgzim0e0U2SvHKNMoB0puV06z20zanh6SEsin7MIk1chB/xSkNH?=
 =?us-ascii?Q?a2qhwHeZ9JlsXjoCbRY7v17916FpFSe4fj3h+5czFjlrdcy9xeXdqjXFej8w?=
 =?us-ascii?Q?hARXcnkzQvA4OyzlyOlSKs4ODi/cijsOHI5HUIObKCBuX6+aOsFNtXjfyl7t?=
 =?us-ascii?Q?hKND9ZNuTLmIRKetx8PFU4uObxRNp32LRyY7QXXJIB49IK+//tKqlxKktOTe?=
 =?us-ascii?Q?3wwuXIjPX+XPz37J+fF+I9N/JxDJojsnnYsfSwFVTUuOsNP5N9DeJQRKPS97?=
 =?us-ascii?Q?0ILmU2CG/T+/2XvuaCs2SDffP02+Ohj4EzT0JK9JiYHc1H52fhxvo/fZiC4A?=
 =?us-ascii?Q?mfEmUmyeH2IvuIlH1xmkC17Tm9lfjXQl4Uib/g7LfEaWcm7Nl3IecGmcDyZ8?=
 =?us-ascii?Q?Cx8NPZkEI/O17XOQqkC3w9Rg7vOInmY2c+cK37RtCtX4XrmMsBXeiWBez9tc?=
 =?us-ascii?Q?pfIwHB5eYI37PbjKTAu4FWf7wtZj/WOzlQ2hToRDxFxyD2Fh5GYsWfBn6bEI?=
 =?us-ascii?Q?vz+ZAS61Yfffpf4wLTlFXcIve7ctKigudPktbAYDTmQ8MKYLV9dRiejohhyb?=
 =?us-ascii?Q?lqsPWLSEpz/mMRJRtISsCmCgmjyvT3bIVe3g9/O/qB0gykpqqXvOItDBD3IY?=
 =?us-ascii?Q?tJQAItijwB+fKCZVr4SnkG5tQxVWYdzWR6hxPFR8zB9HHpoPRVl0GM8/5SYx?=
 =?us-ascii?Q?SWYkHArRCQCsRVn8TE2wmHvrffBFPslp7o3ZPWNpl/YaXSjV2MKx9FM5qVXN?=
 =?us-ascii?Q?GPYdzLEgYZbP8yc19FseUsUhYb7lHcNdegqaz5biLPrdFGJesHo9WeVVeDpl?=
 =?us-ascii?Q?4ySQownIUuWqsZvb0WO64d3DUuHmQxYnSTvfoV6QdrNvMIbgDP8Fu2/OiOLB?=
 =?us-ascii?Q?Lbo2TIUCbWeuIrM8Zoj595Tc1MlXDP/c1TMyGhFiXx2+9BeQgy7AO5i4xIpr?=
 =?us-ascii?Q?xys1BkSOzj194rFY6SHd0RObgTT14mLf50GagWA6JjWMbquYX02pCm10HFs4?=
 =?us-ascii?Q?yn4u66+wImJzdtpEJ3vTEdoBFB1suNTLfIcDfd77Nm4j/hz42pgV1Nc4/mzr?=
 =?us-ascii?Q?vGsvmheN2vduvgJCF/3UDjPizEFNikrJbelpYWHWYVI+ByWBekw6EyZE3xRn?=
 =?us-ascii?Q?t/A/VAKTPVIwTQmXlsr0pM0RPNrkq7h16oNHd3aTJvtIxWVwdjaZCwtzqU+L?=
 =?us-ascii?Q?jq3wD9IyvEgUR7eAivsKsxZ6Fn91CfBb9Xkbu9Wr3lgXo84OaH8tUOC4ZaX0?=
 =?us-ascii?Q?3bshjUbQchuZZmu+l27Xpis6pMCDkJ5L6oZFrbXss9A1HUhe6DscNQe2sx7q?=
 =?us-ascii?Q?1KEj8Ex/iX6z7TANzSPsm2DfHALd+Xqopz6KT69nv/jtNP8U8opT067rklFN?=
 =?us-ascii?Q?oj0M4uxor2FU0UnyFcRL4lgEK01J/+HP8vn551JfEnpc7iB57i5L5SDAiRoS?=
 =?us-ascii?Q?/tHZzfYLvVZu3P2/RQIBJnKUbaSK5h3/QyWXECPRsSjWmd6osU7TI71RECMR?=
 =?us-ascii?Q?w0R89kyniSM4+I8S16+4pT570qF2VJsgMVILHtvN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c5a7828-747d-46d5-5e23-08db702748d6
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2023 18:10:23.2475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tcYl2+FxC05hmxEPPG5yCUdVhyy0L0BJjTSNjuoi2ATViLZKKvLWkHcALGFgM9Qt6p2QAf9x7PPmFCzeg5RtiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7019
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Extend Freescale eDMA driver bindings to support eDMA3 IP blocks in
i.MX8QM and i.MX8QXP SoCs. In i.MX93, both eDMA3 and eDMA4 are now.

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

