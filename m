Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A4D7375E0
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jun 2023 22:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjFTUPi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Jun 2023 16:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjFTUPD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 20 Jun 2023 16:15:03 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2056.outbound.protection.outlook.com [40.107.104.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CE3198B;
        Tue, 20 Jun 2023 13:14:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4/t0aPGuZ1L2zg98aiJF92nnagccoS/kO1Ad/6WrpA44F4hLywnK2JjHzrf8I+CSGxl5tERdkB5bRRe/WFwd57E4NyFrYVqhxepHo06+fcVE6RB7Qys+/9NQ3XZKvIE5EejPJ2s+JD8p5ZUWZp1kZK1FLOjskVe24b+zylqy+yUnaJFk5An1ugAZ6zssVMFjUkaToNCZG5jmW5WCv1ZJiZDK/Iaf9gDetTqQ2g2SfxrBIAp+0lu31QbEI/iqFZRFMcbT7jAPeFH+gR2WBOdWUPQ88u5dGARyYScmN73fJyLcWJon9YBK9udOXF1mh7sRQgJJZ2Yheva1a0lrrksqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xq4Iw/E/mh3cyEFC2hAms1m6XpyOfkMliNlCzrEMfG8=;
 b=INtcog2dUHCVj9Kd3E0SD81gCNgBAL6zMHNoRyghA288bn782HdpANGSwsfuN8Nz4UX+YoFsRN4S2X92C4O6cbSQ3zr3J3IhZbcZ2HZth12w5U7A6gMnqtKfm/NlNnbZzX5svnzQ8ZAXz4UimT/ZO+6R23TXCdK0BQRorqpxmbxn4cqxoO/6qgkaa0VcWb1OlZKEp4AaSAUzUlXztj1ub4F8HoZ96txlEZYWtTcCrqvip0oKctNGWVM2lLaPP/AAEaHC2cfZOw/kaHwt6r3pW8+5R2o86idlcAfANBc+S7LoeBj9WMM6XfsrH/OvDXcrXGGB6mFAmKu0UrEfYxaHaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xq4Iw/E/mh3cyEFC2hAms1m6XpyOfkMliNlCzrEMfG8=;
 b=MlquFqCQmgYhoG7yNf+bwSAMGtV+1XwKSmovieC5VyjwkJ49Qpo2kyJZ3ACcuF4iWkUpExRmGavWk12+hN2BTidapLRBZAkjj2d/DoJv8p34H06gG7hIPizYTC8Fd9aMeOGt0z9maavuMy3hriSWT9qFLUgVmASfhi2ogNDJvy0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB8903.eurprd04.prod.outlook.com (2603:10a6:10:2e2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 20:13:13 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 20:13:13 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v9 13/13] dt-bindings: fsl-dma: fsl-edma: add edma3 compatible string
Date:   Tue, 20 Jun 2023 16:12:21 -0400
Message-Id: <20230620201221.2580428-14-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620201221.2580428-1-Frank.Li@nxp.com>
References: <20230620201221.2580428-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0086.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::31) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU2PR04MB8903:EE_
X-MS-Office365-Filtering-Correlation-Id: e4cfeb69-81ee-4b53-610c-08db71cac6c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XX+y8EQbZ0pKO9RiqcCmY60IgE/Uxn+R1/2HIcomZ9iO6QRz1/UNZVcspNcdW8UMckOiBFMCPwdt7GR55vOVB3DL9tE1TyOCFs5jrxrFx6pUiuxgXG7E8kdL2ZWTe8hws14hqwBIXZES+N5+wKrgUlOeTCpypfN+FPA8AOHcbE6jg2u0DRWf2VSzycw0WR8ulsFTQnAJf2c8SdnxF4O/tjuqkC/kiR6QZ/gFLzQ8N82UC85zdMROpaFtMUdDA6uDAZaqosXJSgIfWvPi8eomvZwN2HwKtYolZq6W/DC1gXBLt4tffAFwAgenlzb2ch8lt6QRNjyiG4tD070MtPx5R8XLTa4MsZdsFx/K+JwPSUmPx47bRNWg6HakLfBMTZK9/YqGyE3qFT/HTQlZ++oQe3weqwqNGPn7LQdsltJvzV59TTxu2IZIdg5ukGUF8cvYqD+aeL7CC8RDleCY7tOsWoQ5sTJzDPURdCNo8/LbGs6kpp2waHMREom8l5pmD4LnIWoYja/SIrwohGAP+BcqLdKPRjLWTmz37BATBgbmhDzYGQskE2hIy3r8AIJ31OIERYFSTnFa8DwaIOzCTXaxV76HIEbSAhQTYoDRB1orNPQaYoK4S+MrwRkWpnz/Uuyw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(451199021)(83380400001)(66556008)(316002)(41300700001)(66946007)(66476007)(36756003)(1076003)(6506007)(2906002)(8676002)(8936002)(5660300002)(86362001)(38100700002)(38350700002)(921005)(2616005)(6666004)(478600001)(6512007)(26005)(186003)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Okevdtol618Mw0GtHPrJJ8lNcEtacisCuaYxMTFeC0la9vkmsYsnMqRmCxBt?=
 =?us-ascii?Q?V9th/CKrvPN/O0R0hEoKMIzcu6JUhhZo32daFSRgP4i+gGjTNZKeW+Wpi77E?=
 =?us-ascii?Q?r3G+geLdtofzNrx2u36JwfJJ2S1wsleJTL3LCEk/jsRia3cIbnn54elTQdXj?=
 =?us-ascii?Q?ghbcCJ3kq/f9OvXdhflySE86TP7ulBs/LgTWYaaho39eMK+/+LbWU4wGwCjr?=
 =?us-ascii?Q?Pk/ciJBI1YUk2G5mq469W9591XN6Cd7FFYMar5u2cTR5E9V9zzyljo9aZjAu?=
 =?us-ascii?Q?E9FJG3TWsWTmaakAC9t/74Uka70my8nilv2r5sgPffzglBYE4pRUv+4OLw1A?=
 =?us-ascii?Q?olLpNgllQebN1I0TyEjHs9W4T7hqN7uN89rg1whOVOl21EfWBDqV5wtYqOO8?=
 =?us-ascii?Q?eP22qWBT3yGDmWCDJU3VnuKggCowFv+RDfvwibhWpKDDnRJiLo7UjnRPfjKA?=
 =?us-ascii?Q?cKnrq5B36+P6NU8XG/IhMZVL0GBtkP3MINxYR0eGS9mOqTUdiyL4QlVn7pk8?=
 =?us-ascii?Q?WZVnPLLhGeBPMPRxv9Ol8T5cMyykCpsqqENL+N2goS9yior/512LkvUhw5uu?=
 =?us-ascii?Q?Lm3uRKjOI58rXsCrzSNqE25o3b3q9ydLE6eKTzu7u4OcHwU6YnZcfHMP6p8X?=
 =?us-ascii?Q?Cegt//CTp+c7XefnPmdiSQcKb4FRcz7DpzgIvYhkUFrP1EgYRtoVhJpmogzq?=
 =?us-ascii?Q?va0u+yArJJ4EQ8UvEUO5Rk029e5ekBwdNnZDBey7h45gh+D5YkMljfb2UT/A?=
 =?us-ascii?Q?9EfTlUD4weLteo10+ksUp7YN9/d7huaZyi7+1y5apLIAUXLRSof9oWf98E1y?=
 =?us-ascii?Q?Ge0YzV8zBoC071RMDz8L+W1ejZ7FM5/5z6ZZpVgBU2DsIQBHugfWCtN2P6cE?=
 =?us-ascii?Q?msI1yUWUcOfVMieB4lX4vi98WezaL25eQVba8JX/fw5Alw6EiTdqngGqZDZX?=
 =?us-ascii?Q?jSB00HSGD286sagpqP96Uxcxk+1mbDNEDvxG318OQmzuW02myltU+5r8EBOe?=
 =?us-ascii?Q?FlWF3PNea1mv2cllkrS2iOGkNnvXzX7a1wBDTVZOtPXE+fZEdChxZW5jdHq0?=
 =?us-ascii?Q?AWo7KCmer+D35SoISLGYhkGu8bZif8wIqpM6STa/q+P6QXSP3ZO/cDLp7Bvk?=
 =?us-ascii?Q?nEkf2R7yeDMBzZ60RkpSK7VPeRXkSMqCKAwzD4BS0QN1NhvDaPuUPGHVE9Ol?=
 =?us-ascii?Q?Pr9To9qhYbvTx06Aj+XBxz2y1woICRGmeYtuq4fC4E5hAVidCg863zDq9TwH?=
 =?us-ascii?Q?J1I7Tp9sS7vSaxS0K3DJ2YMABZRV8bKWN+wF4hoywRofb/mcM/zUt8MnAEHV?=
 =?us-ascii?Q?VYc10NkI61iaOM84fsCptvLIdNPOVBmbB9Zo0uZNndNa0gIIwUv7mjIzT81m?=
 =?us-ascii?Q?4JaJR4R7l39cUI+bRxumNznBCA0WTQ5knbD3TlbySu+/S7hOaQjXzBAk5u4O?=
 =?us-ascii?Q?8VJGTZC0kTK6BcrPIFuQMofW7lydfDHPbapF9yNQhu7X2awQU7e/NetOtrLb?=
 =?us-ascii?Q?yjIMzva+H53RqprhP5vUKSwKhAiNJjLrTZxJ6frTHWT6aA2UFMy+i61WP345?=
 =?us-ascii?Q?Do1u6bskoT0+DCmpIYvjmsyMzbTnoSM1PXDtW5S+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4cfeb69-81ee-4b53-610c-08db71cac6c1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 20:13:13.6348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IwQ+FotIqU4/Cwrcm5ravt9W4K/TjkZ39I+MB4xlgK2CgZYL8+JfCY7JfZGypQBmaVbpzNAJEbDRJqIrqQVs+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8903
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

