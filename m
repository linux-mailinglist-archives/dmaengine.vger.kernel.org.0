Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D7572EE13
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jun 2023 23:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240237AbjFMVf3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jun 2023 17:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbjFMVfX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Jun 2023 17:35:23 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE6D1FF5;
        Tue, 13 Jun 2023 14:34:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=diPt5ripJ6GhSQNj51Lpu5el5jBhPRWa9/hNk4CySx3fPAJbtzwnyvvh8flns7vhUU1K/9vdyIMhf4hchuQ5YV6uPb9JMQGJV3ziTkEVN9uzxEw5d5lNXDIWf49ypYpuw6O/G62vLApeFE2cA4d3998upKtsfk15K06GtbXk3P+26nwGkAiKv2QTn1y1PTYHgekxOyPCGQI5JT5L0Nl/A5o4sup2M3mbxu9gEQvCLFB35gvkj1ohemr8wrfBMkP8cvhFwziCvDMFqApYGmwHMaKg4EC7hBcQtWMMRjHa01a9xpSk30WXRkDasp2TKTsAXOlHCaCP0tvirbADDdN+9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bBn48GvYU2PDBw7lnQdJEp+7PBC3yqtIWZ4VrcJV8Q=;
 b=ZeIfBVQRxUrX6O0DxyhBVX11NDP+vNf62vWFfSiKxxvBcN3s6m4cyuzOun7xd9k6YNrkTXaWIdYFQXCE7xqK5FNGrwz3Mlu3hZznd2hZOkWOaKZPc75ijtGfrd2V/10pwUsLbhU3FK11DK5T0jAUtYz+olL1aExWhho38nL6dh7zaDIXJON1uwKz3mznbT2kFCYRWaIIs4OU+zP67YuOXlSS8isdoH5T6+5+VIYf0oPsnNGDaz3cHeDEV6PUO2qkYAxG7WO7uiM08M+brFdftbehmZzcgDM+PvrlZXn2z7eUOLip8H36qwMYlWlQdGg7qUvbdifSHqARVdEqw7JvnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bBn48GvYU2PDBw7lnQdJEp+7PBC3yqtIWZ4VrcJV8Q=;
 b=dE9YXympFM3GUqKdPL65IRaxrsZwy+eHZcZwG4FHeGGV3Y4ItwfoicQmfJ6XCMlhkraZyNM4zCv1IyTIt+3k+KYOs+lZnBXyntp/Oau5WdY1UYmjMR4Ux4l+qh4S0o06Ox79FcLRmkV5BnBKYkZAspF2dn+Dyx3DZpBH4gb9aHk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS1PR04MB9479.eurprd04.prod.outlook.com (2603:10a6:20b:4d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 13 Jun
 2023 21:32:41 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.035; Tue, 13 Jun 2023
 21:32:41 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v5 12/12] dt-bindings: fsl-dma: fsl-edma: add edma3 compatible string
Date:   Tue, 13 Jun 2023 17:31:49 -0400
Message-Id: <20230613213149.2076358-13-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613213149.2076358-1-Frank.Li@nxp.com>
References: <20230613213149.2076358-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:a03:217::8) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS1PR04MB9479:EE_
X-MS-Office365-Filtering-Correlation-Id: 81b381b8-8bd9-4277-3456-08db6c55b754
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UTgPvNPdeF/0/FxowvfqJC0jDV+6o0tGDS3sCl/iM3RwA7hYXOz8rAsxi7v6Vk/0Z7PagWCN78hARAy5m1iPLPipAiK0HWst6npnmO6t+MBGftDVDy/TbfHcl1KZpu7u7MG3V/XV/2ck0y421p2ASdH5DhfTtz6+MlKrpZSaS6hd4qdqnrhZ+j59uiX+TcXvv+7+QYdIhv40EQU4zLu5bHx5NlZ8NNOlMpcFvUJKPldJEQMIB2gUTqTQzwZ13sgZorSl402yyaPOXGrW2UCuINNLUZWvOVPKHYx7fE9jqpxRSPNrUhylGAjFayk6H5VWNjM6V4Ye+/sfduT8JnJEnwOiaaEiJIH/Tv8jx154hgeaHWcUTTil8ysrjL0EsM/WWcF9rnouOn0nKyDUDMt5oHyvd9bMDxgwR+R039fmCeBse3MBxBFJ9saywsSmj/cIhWCcG3ZWyfPbCf45Ic+gbMXr92PSElnOvOUHUjq8QIjWtPLi+RVdjPHYTh9lzv+K4O2F0NVwh5dcEThemrDcuRmONV2QFKrYTH8+KT4EUddFeEzxGzR/R+UFGKCEda10K5r7sScLUEL1C2Ct3xvGQ3zsQaQ4OulUDNjiCiS1lRDve05LOkQhIBfGZVRPa8Lh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199021)(2616005)(36756003)(86362001)(66556008)(478600001)(66946007)(66476007)(316002)(6486002)(52116002)(8676002)(41300700001)(2906002)(8936002)(5660300002)(921005)(38100700002)(38350700002)(186003)(83380400001)(26005)(1076003)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y45vNP8Pjl+92VHQCjs3OZ+MsLofV5JmOSp0vWhEzfqgEGtvKpXav24ow/ZN?=
 =?us-ascii?Q?kEnib6Of/BrY87EkLmmcEdO2yXSvhdnEa8A2hhksb+d5ZzMIfUEsLNT8vyew?=
 =?us-ascii?Q?P7ENrVBL+QzrrxJJld9kA/jTllLnL5L7r7CBTdaEUWho0yUNKCRyDbxjelZ7?=
 =?us-ascii?Q?CJctAUUO1tdROyaTqEj4I0kh78xps18D0mywhp1/ieGGJCTCHBY7LE5xLXQk?=
 =?us-ascii?Q?GMq/B1HjJDfY/mQHwN743rbYZTo/xxG8HtMqVkOFDTYsd4UQT01uDCRLA7vN?=
 =?us-ascii?Q?sucOY1+RMy4nRcegUz7XPLNP4JTOhwbofSv+ZesPlv2hJ4nGupYrtoY/eH2N?=
 =?us-ascii?Q?PNn+a0+I3597isac7JAFPNd94csAAMUuqlB0AFVY5u6snhO/ttN3UQbCvNx0?=
 =?us-ascii?Q?Kj0eV60SlCDrLqmEDXHgKXrhjofntYqbbx33PXQKyaE9tGv53b7Yrs/S7Zk6?=
 =?us-ascii?Q?CDUK88tNkCe4SSiLtAAjhp12FZ90XLuuKzLnStJyL2kHTbMecEfYVy/V4VW3?=
 =?us-ascii?Q?TysgXDXFmuOsGkevzlBVl+FISZ/GwaT+Nm/k6VF8A+//kyo8s5vlKDxVZJlL?=
 =?us-ascii?Q?XmHfiKt5A4B2A0q2TLCe8LSXUDHCrJnp4F6rayCzSPGbB40A+PcIn6id7WPa?=
 =?us-ascii?Q?E5Ps4vNS0Cp16hBRakVHKGD/0oHFF7U9Uu1TvCPg6IBFplYmzyck1uobWrBb?=
 =?us-ascii?Q?iBAsNizfdsy/iIO6IYDB1qVv8XIBD/cdd3fuQdoY3/VK2jPhmPNcDLfGWMgK?=
 =?us-ascii?Q?P3/D5jfUkP3gzuEIcv8Ah/eZQKANuK1B4eGpNAHCJ20YiLngPvkRHPRMwk2b?=
 =?us-ascii?Q?vqxlE1Xu71k1P+HQUK5H4rrBnG5kyHoaTM5aaWxNQGL9C8BB2/SCiNGhmiuD?=
 =?us-ascii?Q?4uVmL84efOiCS56SWWlvXKjQCQNEGZkvg+O+IxWlThSaRxZvg3KWmqhx2by8?=
 =?us-ascii?Q?vgxgAjCgbjldRWLar8D2lWkQ5HgyAgbgh3e8qSiANqv/Q+5JwC/2U5tIvpvB?=
 =?us-ascii?Q?cTpdeHApKlRAOOm+Xo1Mn7TKmRO+2wtjhwKvnH+mQRk0G6SIIpcDp0Savn4R?=
 =?us-ascii?Q?FuADTxiPAkd2vF22FJZ+d5pcuxbWyjHTV8amVZYPsblcFa88leKTOLQ8GGdC?=
 =?us-ascii?Q?But+nB9rawB53D9tx+rnPnrrwDtqBxgH3gd+n6HNPiweP5tTkcZO3nc7X9aM?=
 =?us-ascii?Q?D3hPmM0HzDWAGnzIimQOH5l/d7452neBYgc/zgbIEd0lfCQ4q8VUNODrIv28?=
 =?us-ascii?Q?cdO26CC4g4eU0DbTpG4YHjocZry8v48FnZx2J8L8thqV2uOYWozxbA2+Hgl8?=
 =?us-ascii?Q?OTOMTwom6PIAyAf8FizKacrWeTFAsaSgOFneyrydjhr6T+lLme4+KoEazq90?=
 =?us-ascii?Q?iVjPap0v7lawStR9AwCeyUPFGLEy38l+K5yQwya5UJpHsb054Z2uhpSkVkkK?=
 =?us-ascii?Q?1hdKubzKrQ9eGKEGxQeJWoWceuAY3RfRchcghazHzRAVj0ThoCRWoqUA7uaE?=
 =?us-ascii?Q?HKxMKP5oBYiHdT6j3PVTAZ8fxQGa2lgVKAYZ5q3JOVYtiNz4mFuR7MTaTzme?=
 =?us-ascii?Q?h/tAmueqckaAhP2qaSI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b381b8-8bd9-4277-3456-08db6c55b754
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 21:32:40.9346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LfDY55Q55R/HYAcc6qX9HHFpmP/OSmf+L1rHDrQAliGP1HVQo3TFsWzCeGiTlJvJkMh0FAIKzIwhiILWPWKo4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9479
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Extend Freescale eDMA driver bindings to support eDMA3 IP blocks in
i.MX8QM and i.MX8QXP SoCs. In i.MX93, both eDMA3 and eDMA4 are now.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/dma/fsl,edma.yaml     | 118 +++++++++++++++---
 1 file changed, 100 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
index 5fd8fc604261..2f79492fb332 100644
--- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
@@ -21,32 +21,20 @@ properties:
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
 
-  reg:
-    minItems: 2
-    maxItems: 3
-
-  interrupts:
-    minItems: 2
-    maxItems: 17
-
-  interrupt-names:
-    minItems: 2
-    maxItems: 17
-
-  "#dma-cells":
-    const: 2
-
-  dma-channels:
-    const: 32
-
   clocks:
+    minItems: 1
     maxItems: 2
 
   clock-names:
+    minItems: 1
     maxItems: 2
 
   big-endian:
@@ -55,6 +43,43 @@ properties:
       eDMA are implemented in big endian mode, otherwise in little mode.
     type: boolean
 
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - fsl,imx8qm-adma
+          - fsl,imx8qm-edma
+          - fsl,imx93-edma3
+          - fsl,imx93-edma4
+then:
+  properties:
+    reg:
+      maxItems: 1
+    interrupts:
+      minItems: 1
+      maxItems: 64
+    "#dma-cells":
+      const: 3
+    dma-channels:
+      minItems: 1
+      maxItems: 64
+else:
+  properties:
+    reg:
+      minItems: 2
+      maxItems: 3
+    interrupts:
+      minItems: 2
+      maxItems: 17
+    interrupt-names:
+      minItems: 2
+      maxItems: 17
+    "#dma-cells":
+      const: 2
+    dma-channels:
+      const: 32
+
 required:
   - "#dma-cells"
   - compatible
@@ -101,6 +126,19 @@ allOf:
         reg:
           maxItems: 2
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx93-edma3
+              - fsl,imx93-edma4
+    then:
+      properties:
+        clock-names:
+          const: dma
+
+
 unevaluatedProperties: false
 
 examples:
@@ -153,3 +191,47 @@ examples:
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

