Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36916782E34
	for <lists+dmaengine@lfdr.de>; Mon, 21 Aug 2023 18:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236572AbjHUQSx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Aug 2023 12:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236571AbjHUQSv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Aug 2023 12:18:51 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2055.outbound.protection.outlook.com [40.107.241.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FB4189;
        Mon, 21 Aug 2023 09:18:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPnBj98iY8SSnIOx9sgwRXPK8NikYbJgykz/m0cz/hRapmIGCSAF/uBsr6cyHcCpYnQzr5f7dtD0Qm/FVVSJHptjzoKQyhm9DVXfkbni6SMjvox7FHqA+xxkusD7q+PHluuwUjzPR+8Tl6grBlnBqjAhv1yNS+6ac0QR4cQ5oH1Y6DsR6mEPvZ6oeWlVbXJBnCNjFfUC6LAwkEo11Qx4jy9toI9UygpDqh8OKE53ok2m6+/WOXnGVMxxGoAZdlXXeSq2YHqIs6tF/JMdmH9c3/tmI3wHbLYlkXcbdqkgA46cPZWzrdLlLs8I3NWjsldlyrqw3CapnaSwU2S+3LGL+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xq4Iw/E/mh3cyEFC2hAms1m6XpyOfkMliNlCzrEMfG8=;
 b=I63p1EjQ5fqSVc764fIEiyJMoWOj5qq2byay0jVvPNt6ZO4TyF1GmJMI8noEWTvbfTQm3jt85HAtLZU7PbY9YlC4iAGmkd1iaLLQHInEYq3npyjHdPiTrv0sCGqNHQJVtk3//tDmBe7uwcNpISx0Jdpxk6oAUo1VgQPAGeAeetgmpk2yxULNRT1NetIpEzJpiA+1kENryustdBAFoebhOK/sgsTTQJGk12AN9UNU4ZEHHBzev4BK9f3aO1QVkh6qKQ42mOoGnkDOm+V6p64Y8wMFdxzlllKR437LIAHdKt31iWB4B85iZ8KhqWVjCGrOQ/96gol0HwceYFLSo1ug7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xq4Iw/E/mh3cyEFC2hAms1m6XpyOfkMliNlCzrEMfG8=;
 b=htjnejT82Qn+pI/7+djKub4HYRzDzU7pVvCET4riPAICAu3yAioS6BdjfoMzk/GCadyTMPmLhKNraFupB/dPQ+mgwlvoKr8SR8o6wlb4PBUjvLSYwt0ECf7z7r5CyL2YEILrxgrZcl8qgpFt151TFGTg4tYxVGUZD3aV562rzR4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB10042.eurprd04.prod.outlook.com (2603:10a6:20b:67e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 16:17:11 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 16:17:11 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, robh+dt@kernel.org, shenwei.wang@nxp.com
Subject: [PATCH v11 11/12] dt-bindings: fsl-dma: fsl-edma: add edma3 compatible string
Date:   Mon, 21 Aug 2023 12:16:16 -0400
Message-Id: <20230821161617.2142561-12-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821161617.2142561-1-Frank.Li@nxp.com>
References: <20230821161617.2142561-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0053.namprd05.prod.outlook.com
 (2603:10b6:a03:74::30) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS5PR04MB10042:EE_
X-MS-Office365-Filtering-Correlation-Id: b0c5b636-c826-45d1-7ad0-08dba262131f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RMRW5b053++j1NgTDuwbbLTjmv8Lw3DXV0NoJ4jtDHfOxdzsyzv7Vves1ys+Ja1c+WJkRTY3xhipJ9FW0LD0sPRtfvOUf0Ms14+PqAyADpakqSVh6/unBmWGZGCVDrhZT+MYVXRTC/kBRrrpmB2iqOgHYdOZMpUvy6vT2SdEYI1gDIj7gQFtsWA7kfkmhLmAxPSDVZnMTpDjpiY5+jEvmliJMBr4K6GGdA6j7BjV2VVm6uh0UTKsJrqMEC9JScRe5YGkmeiNitt7wXnOUJMChjSmvXZ0m5lcZuzLYHoyZzBCXcUbf95Nwo6xmllQ9xxF7TfMsZ2Pc/DYNtYOTcxv6Bjkahan7ijZo8Wv9zbegzokhv04OuvvVSyaId3FNuCRKdZEnipNwh8MepsAbHL2S14DoHYQrAmL852QXKsZZDD5LnR0VNkH4vkGo+vTgegiTvg91/zyMdrYjGwZenMU2HqiNwOlI1zVO7z0UPZNnuUu6+uLjJRylWOdaePTXk/ptIAypWx2RLsO/ZqScDxI5gsuStgt/qYZNtrXglC9oCt6vmH1p9byAiwqn/OW6LSdFBckuvjXcVnu1ExUs4JBJ/aC/1f5eLovs8NLcAzX9azmBukNsG7o74n+pSHYvoqv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199024)(1800799009)(186009)(2906002)(52116002)(38350700002)(38100700002)(6486002)(6506007)(83380400001)(5660300002)(26005)(86362001)(8676002)(2616005)(8936002)(4326008)(316002)(6512007)(66946007)(66556008)(66476007)(478600001)(36756003)(41300700001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qXSCR2LXCyqTo6EEvfoqfu+L3njoGl9YsYDOJb+ZMD+p4cZJPq9HExFsKl20?=
 =?us-ascii?Q?pJrqiIby8SvJE+kVgoZXTkmwlCpgjAby79h3QDkoSVI7b1lGotWHyP0XXGMV?=
 =?us-ascii?Q?OwQldAbVYnGGQb65gDvGl5wGbjHB3l2M3/gPy6NrN4FF0i1pQaNk0AQR018H?=
 =?us-ascii?Q?F3e7JU7v6h8GeAC1lx0pnEo2t0gdhbl7138CghR9JWw8CwhcxALnDnIhsaJt?=
 =?us-ascii?Q?zDoEOW2yhnzEVyTSxujnY9sS8BjIynUIhBbO4S6ph8Xy8zFjsZ+EBm9XeJ89?=
 =?us-ascii?Q?ivGuMkOOHTbYCnzNNDFDaGj3XXG1Hr8Ya/rfIqHL5uIHzEBHQjyxAPXiaaiA?=
 =?us-ascii?Q?0XEDxTSZgxlRKFpSaM/kMhuACTgzZnlFLvvAeN2tfri3ySKynxb7qyIzJyqT?=
 =?us-ascii?Q?tY0UdWgVHCBLNp1ECUhBzUHzBy3fH8z1RIBA+ssKx36/rpKdTI5Ey5P9Wy8f?=
 =?us-ascii?Q?zQiWpsGIwlw37vdQoMxn9KlzZg2ezOI+E1c/tbnCEyvNXWlA+1LeyU7Mwhfp?=
 =?us-ascii?Q?w6J2/rFW49ACWCzxtkL7Z5jbTC6/0PfhLkD2rkcFywCnt373IYbRZpKaXcHi?=
 =?us-ascii?Q?/S7zXJGT1KWFhbCbuYrx3033AQ/hMaiaJMrtPcnR/++cJhs/4qIhxdFHk/9j?=
 =?us-ascii?Q?1dKUMkf362Kp9ruvAmnwjrMN3SHAfD3jlBd9Xj6nydwnUqY9qHkSuuZoU0NQ?=
 =?us-ascii?Q?Q7y9V2yz0cMsnrGhXHT5o+4ZFg9nepbdpVBz3VLfB9Z9/fF5Ja8JXJKbBbA8?=
 =?us-ascii?Q?9bno9a37vbB0Fs8YzfbRI1+yA7gruwqXAqNndZJMtLnC6FHNKj2B6STvQO7V?=
 =?us-ascii?Q?5AAtpWeYw5wcjwNsWNkUjifwgKrwNCy64qEMZAjnsZV4kjDr3071aQHYbmU/?=
 =?us-ascii?Q?iIaaMOsIQphNo+iDZqMdLZnIeWD4IpEs8FX3aGE9QrGjPshY7fOVk3fw1kxw?=
 =?us-ascii?Q?QK76LFmSJVikQxUP64qNvifPrXfeNihj3zL5Q49T2O/9aB7arRkD473rDuJa?=
 =?us-ascii?Q?PJBeqyXkwMpIrh6dfCuFG/0CoNm4n+vl0jKmmGHFhPP5NHLWnNlXIkljo79u?=
 =?us-ascii?Q?dhoExm+DIGGZNC9IBMr6qfjTdtG2UMP6OpXEHQZJcdEXKkzZBKIAxO+tNcaW?=
 =?us-ascii?Q?MF/wAJGT+q2DBdKK0DNS6u66jiGr/isYfbX0ymuKOY13OPpNRd0qYMFlKXEy?=
 =?us-ascii?Q?XaEJLZyHig/vjvUIk9p2araHyG/T13zFagF4FqAPgM4liyMIbTJYT6ieQFb+?=
 =?us-ascii?Q?BbSSTvA8z7T8lMqFLdZ1cCuqIY6xaYfak4IFXgqaozDzOR9oiK5iHfTfdC4A?=
 =?us-ascii?Q?J+DgsQVkVPoeK8/vsRQE9UPRmAKIFA/mez8ZlKpbu0P772nB8ewrTwszcOOL?=
 =?us-ascii?Q?zK2NZ5H2XoTdn0rrtsxbzGCawGmswlvSXWtqKbSP0gmGfd/FQIcaol92I7YS?=
 =?us-ascii?Q?kWxazwOYaSMJSkZTfcWZlNMvzRZmGuPFD2yMTDyUpOTuCtY7FFQ+T+KHHn81?=
 =?us-ascii?Q?Hv08zgBgAuugshkZe7k9woXQLxfbyhn56dyqjPGj6NtVochwoIIzNI+elJUN?=
 =?us-ascii?Q?arjdXkrwo1UOKhrR5iwyo2ejUQGoLUwchFgWFm8f?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c5b636-c826-45d1-7ad0-08dba262131f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 16:17:11.5908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J60BEQevzZfF+s+QMBtPrjuWjDHVScGJCtnnIp1DaeJT4XJwVaHCkhyd5abGDH1SRsh/QhJEBkt3AUc8H7NZug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10042
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

