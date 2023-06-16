Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A493733504
	for <lists+dmaengine@lfdr.de>; Fri, 16 Jun 2023 17:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346094AbjFPPhi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Jun 2023 11:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346098AbjFPPh3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Jun 2023 11:37:29 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7FF3AB4;
        Fri, 16 Jun 2023 08:37:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/TIqBpURkn+vR3CSiot45a2yYU0Z1PFj/jAvWUBz5KGRPejUBsaclCwhzHlsSe3uapyJFBgqFnta9631eXIJcfazuC9cQJxnz5kGx8trQAuyDWTsXDW6VjCHy+kKt72uzIGonCOJKaWpXvRJuJG+fDFNq0IH1Xn04+NtAQaaoNPdKpmm2pppgDRUrlmV8vALtBkxCVULZJmu1CFsKTF+F/sTbUBrqxsXmHfMcCe4h2s1jfhcelYOvMm/xyhc/B5y8Qf2/ZBnTbE7UzwynzGBdqH/csSwwiKIp/B5xH78omx08FMvo5kTr/ni03eunOl4+EygOVUx++her3CnNS/HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3KdPkFxbxRga7c91LrqNvK4Hz0q3Yle4Y9zd3COpac=;
 b=RG6eYBI2wyi3qyp2luxbEB+rXhM0W1lLrnej/2WBVlBomj9Dk4AuephPVjkK2j3Eqjd0LC1umvPsj2USkWMX+YNZX8YqjwTPhJ2YVY4VI5qcB1OKd3+jdKSBcTsmfSyykhrgTUxzTckeqWZ7x3vAlKyvqvYn3qI4MInu/EPOPJBqbPPsZz5vcWLtJ46AH53MHFYEjWxqfHgs/BRFuFdClS2FlXQGolRlnTT4oQa9URH8NxrvUm27haDyPrfMF5+2OtU7Kjy1pIzlO7mtovxFeqgtzRkQm2Zs8DRA2NVa+3f3VWNmf/68zan9AdDPUbOv1lFSrHuLmuSUH30Xq7N1ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3KdPkFxbxRga7c91LrqNvK4Hz0q3Yle4Y9zd3COpac=;
 b=DFz7TO7c8/Ww5XISO2m+Il/D2RtGLgKWqqLhL6UPSf49tnNYiC+LET/SJRTMT4ysv0JbSLk0HwlZKdQsMrBR2UQG3UidlqCRdQmDpOL4rTLvh+1UyrqnLpLc+C18k1Ax4P7j46f8SZjaNgPX9jjkBAo6pLigc3vIqDVjmIyyPqM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PR3PR04MB7339.eurprd04.prod.outlook.com (2603:10a6:102:8b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Fri, 16 Jun
 2023 15:35:30 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.035; Fri, 16 Jun 2023
 15:35:30 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v7 12/12] dt-bindings: fsl-dma: fsl-edma: add edma3 compatible string
Date:   Fri, 16 Jun 2023 11:34:38 -0400
Message-Id: <20230616153438.2299922-13-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616153438.2299922-1-Frank.Li@nxp.com>
References: <20230616153438.2299922-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:a03:331::12) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PR3PR04MB7339:EE_
X-MS-Office365-Filtering-Correlation-Id: 592b3c3b-8171-44e1-7b4b-08db6e7f50d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O+Rcq8l23u6uQI7J/oRDNeCet6VzYesO/lFH9FiOIaQ4E1JXJG5t3VETniRGWljEDUB5rT/orAoWeUFxqrv96tE8zSle36kaifVF9/AMc8No4OA+CGHyTv2Rs6PdjGhS2SOJvBBIvfVDv8JmnZChVM8L20ycNwpcswf5cP0PwshNG3rFkVwFFyqmCcqy3GLp/mgDfvgh+MCiF3my/Icb+uST/ueuv5Vd5C9rwKzudd3eww1x15YHiutiAgE+uHyshtUqRVdgAFSLU+Y4cnxdyZaHe0yjn5SxqLO1nPk93UlTVMjoLlT8ho+qfv6CwLOLZON9os0hr+W8LAFFYGQiqjpU8mR5BRxHKTsNvpdzs2E25kK0+QpZkYHy5gIPr9Es7iQaDJOY/tm0DLxImVD0TxJXh9rpAPlzzzXWnCboBsbv9prJvsLbOLNhCe/XSjRRIvJ8a1Q6MeAelhUyYk871jUSHCbUmfCkyAgR4f/EABRvzEPtnQ+3DrGSoc1SBwILhnJYKxP77UWPDqtFOp9X8mfIV44Jvwcr3/cqlJq/EcXbIRYZUlkFToKMzRyHoKPFtpXo6utvQ8U1hQiXTlhZjzRGWKsh/GcMp2USnSUFAQNy6RF0ov9IYMS6vdoWUF9o
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(38100700002)(66476007)(66556008)(921005)(66946007)(316002)(2616005)(38350700002)(86362001)(186003)(52116002)(36756003)(6486002)(26005)(6506007)(6512007)(1076003)(478600001)(2906002)(8936002)(8676002)(5660300002)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+TfYzHgEIXwwfsCfS2yL3fG4xeQTBvfCdcLCIqz+s7LLD1CPVlz9ImQkdlad?=
 =?us-ascii?Q?QF0YnfxoW0GsCXqRFBUBa0Ztls2YgR7ibdYJTZ4acoMv8jnzu339J/vVWbfa?=
 =?us-ascii?Q?lCLN5Ocv/11IsLUMrMyFvVx82ncRcUujHfmw/7FPuc9MD9LCX0Chc62BHzSy?=
 =?us-ascii?Q?qSw9meSEH4LM4Ys6KaaIgDxLQ1+71M2svwzg4136E0SKomK8VvEL31FHY5Ij?=
 =?us-ascii?Q?fqZsW740aw0MWof5fqPVYusWuoIpHphBYeHTnYwNQcmC+YnC5tobgC8S4/xi?=
 =?us-ascii?Q?WzXm3P6rLLpgP5F1L8kIW/YElrvgxOPlRFWQ7/iPbC1qZZLst8yb3P77dZSb?=
 =?us-ascii?Q?O1ENkQXLr6R/r/V7+29yichzjVy226qOFUmHanp3TN9nHITZExuBbthFs5w4?=
 =?us-ascii?Q?h68NLpwgtCeo67zDVtPFFaJiNN0v3fOukdzyo9vZolrZRCJyW9RQ7qiHVbX3?=
 =?us-ascii?Q?SPDWe/wH8JVUbCD5TkWKfgJoJigy83y5RnfThr2n5miebl3E7OOKrBvbxSxR?=
 =?us-ascii?Q?V5+7PtDKH23xY2zlDLTU/Qb3jL3LPgh2tPNXV7JsF9pAcZgtzrPKK/xT7r8+?=
 =?us-ascii?Q?cGITT9n546lKBWVVdrxyxEAUEJivzocHC2I7wWkZYsB800WqeRE5rVVRHuVk?=
 =?us-ascii?Q?FR85L0QKq1spXQ3pt7cMNGRnYAkveEX2D1/a83o2bygIGE2CSxNfk7O6bxtN?=
 =?us-ascii?Q?G/SfAwW20dIWJJ9GEgdFpQLYGlwy+BoV0fg0wYgA/iWVhpZG2LAtr4hE7IEW?=
 =?us-ascii?Q?JwrxPu3RTwumWZBRZshqlvTBisN7V7FlGhNY7ZQt2c8vnFPuPbMFaygoqdPH?=
 =?us-ascii?Q?e3M+Vrh2aj/cJtmp6/pwL+l32ioCA/1E3vQq0JjQxOeVCLqbhZZ6Q5Wk1hcO?=
 =?us-ascii?Q?VorlbAlmkMZdWhFpvf3nHqPcMb2yhZ9htzINvMGZ84w9auePsEqdP8LKCZtv?=
 =?us-ascii?Q?tsnzY2SRZXGbDUYKas+MXVSn5PawA3UYcBGzyxa7IGOH1fnxOC2dp5C8derI?=
 =?us-ascii?Q?y/vj0dhIwpQvY9BEqKOLkMYNzZucj+Oz2aowDzrb+TT72S/STom7sxoJIR5K?=
 =?us-ascii?Q?1oEodJUAm4dK8eSCNKTXwC5+tunsWaZ4wzDe/Cs2QE0hZqjCdQ2vQvyRfXzA?=
 =?us-ascii?Q?sK8y92c2rteQD1+i56okqj1o7SF8+eWrwZ8GU+rQDIF6IKcj5tgozRqTI55F?=
 =?us-ascii?Q?s+D2NHz/0IDT3U/ae5aEFqq8JIwZpithX7zuVZ8Tk//99Ob7ECO353mY/6xv?=
 =?us-ascii?Q?p0XVaYijP/y0hlgpCjVr+EoUOz98ylTQwgsfvHFNdaLbfssxwgedGNytRhQs?=
 =?us-ascii?Q?epaf/yD4sFB3/cK7pIPhqrIVOC1D+G+FeEFB71OainBYg/g9clpDHpXmD5sZ?=
 =?us-ascii?Q?Gq+LTwm+lZHtmeatjLc6gt4MVuj/SaUimOl0sV+2uoKkarV1nXra8BjewHC9?=
 =?us-ascii?Q?1xGAJohk1+1m7ZZRfal44SAZ1dSGOMMpPWPH9KeWTAoQar5n1qvJufBRHRzy?=
 =?us-ascii?Q?H6ZLXYgPVBby7wF86QSHE4XBM+QA9lYOcijS7wX2lMq+nOeGC3DOumF9bA+9?=
 =?us-ascii?Q?q+7d53Ri2mSL6nI+JYk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 592b3c3b-8171-44e1-7b4b-08db6e7f50d7
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 15:35:30.0914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BAa2gM614DNrolBiui7Cy6hyYqvbbdREBOiPXDOHLhqrdrBcZ6jwSGx5r9wluf2BxapU6+cCErxywfZSh5vhWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7339
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
 .../devicetree/bindings/dma/fsl,edma.yaml     | 103 ++++++++++++++++--
 1 file changed, 96 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
index 5fd8fc604261..2363c10e0d1c 100644
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
@@ -65,6 +74,26 @@ required:
 
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
+          const: dma
+
   - if:
       properties:
         compatible:
@@ -72,18 +101,26 @@ allOf:
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
@@ -92,14 +129,22 @@ allOf:
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
 
@@ -153,3 +198,47 @@ examples:
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

