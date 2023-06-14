Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D8E730875
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jun 2023 21:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236965AbjFNThT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jun 2023 15:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238164AbjFNTgn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 14 Jun 2023 15:36:43 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2054.outbound.protection.outlook.com [40.107.7.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAAE268A;
        Wed, 14 Jun 2023 12:36:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMditC5rSAywr57d43fuQKCatxZCBFGaaWZ5lDbh09vREWLZ9iY7dCf4b8F5wf1+bx3QCBt5AzjieuHfh9RDdioaTBcrF+j4uWdy6IGadhcSqn6F6cgO9Q4bR1ZNVtbCgCiRLyHFYZ0nVIRDfO0TnLergQ4lSyUbge4JyUefoAnknWvJkbT0+GhLxt8zdNDIkq6qSaejUS2cAbhv9SMPVWsyxE1sqU6fRX7DYl2ViBv98WouILJtd7lZX7mkNxffzhPlTbRZuw4Mq6JAx7669Y1Z1w/+o+S/db7+Z8wLEfRedULecjKSe0YP6nmSFUgdLKXXIJKwgdaKUyvfei5DzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=114WxCPFVYq/9aNJyvsoT+DqgQkST53BKA2/YylCI0U=;
 b=lO0OiPw9G7/a3uYkKjTf0SvEYSJCVep5KQNilD5bB/PzoTK7kPN7oYDXf2DHwlfHVSm+ys3Snci+ftH4rZFKowr1D3oMWZlUJCIf9S7B91NMJnzRB14uOpzYnj+PDT3opNUBdD3pL7MCinvfj4/PHjKm6pYhWb2l5c/5IES0+U08r51iCunC74AasdlPET6TXLGrg839Ruzy33qkhNpLm3oOD1xnHpmpkrDjQQ5XwWP5DuM2rVzC85C3oGvrZVIFSfhVrJjCRszu+EIK87Sa9jXYe+GcFoudHr1saR/EPEbg2uMhAAV2vFjTE9PorJYPesFws6vpsLfuhVX4CWSEtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=114WxCPFVYq/9aNJyvsoT+DqgQkST53BKA2/YylCI0U=;
 b=JFM6cATvldSzAIEBDkQQKrS2Ne7TjvwUuHqNDkY+3taw1kfjcQU5bnbFMRC9OCXDLOlErbnJOucm2KxKXrdQjQ55imoMqg9819L4MtMb86LtCmfA54G3FJSQiW5NauQgMNNYNvjM+S2Ues8ZOZa4A5VCWD3QRlizNypp4zhjSYY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by VI1PR04MB9763.eurprd04.prod.outlook.com (2603:10a6:800:1d3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 19:36:33 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.035; Wed, 14 Jun 2023
 19:36:33 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v6 12/12] dt-bindings: fsl-dma: fsl-edma: add edma3 compatible string
Date:   Wed, 14 Jun 2023 15:35:44 -0400
Message-Id: <20230614193544.2114603-13-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230614193544.2114603-1-Frank.Li@nxp.com>
References: <20230614193544.2114603-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0051.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::26) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|VI1PR04MB9763:EE_
X-MS-Office365-Filtering-Correlation-Id: 11d733aa-ce2a-4e2e-6338-08db6d0ea8fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GVSjlbMk1e0HNGu0emhmTrWak9L1dT8oPXKzqGLC0UvqxwrtafPE35EyWDloKdFVjaWT0oFRcqn5KpA7HIfT4V+MQbaTd4g1gqqOhBY3hkE8Zr4VzMXn86CFsEoSpCKJeP9NlAoute8wSpcz3xEKxw6T4GtbXv2hOen5Dtdl3K5G6hUquZ3axRn8R2bMhf6O0LO0jOkMRWmqYcyQqvXZ6fkSru+JhPoFBW1QP1TIiLqBlkY+gEbYZg5ezDPdCZixYgVObhBI/yFZNjlec9CJKbqkH3BlkWo8a83nHLrc50sxsbUo0CobsrPSrBbXzwpdIFXo5PycyhWgBuhQTXhmSOQfZBMH4VpE+Fc5UiU2lpV09BppX1Zi7GRi61eiLx/yF2pHzp4ZUjXTJ0YVS9PxIurc7AwHL6Ds/i21QMwzr489xXXI/N4Q7CZeVYnt3a8FsCHT6LW3A70KwiqxXsvKjU8e/fyuihNh6kADLa590YipCci+AbXISnITS7SxHJg6TxiAlHVwtXBGbHoyH5BftPbhBlkhwKks2s5eThh3aqN9s1sQknAydyRTYl6vv4MIHots3dziJiSztOrT7FsA+UuuG+JGII+3aPTA3yKrUy8RE/B0Yp0usu/ZJGloQLAy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199021)(5660300002)(6486002)(8676002)(52116002)(41300700001)(6666004)(8936002)(66556008)(66476007)(316002)(2906002)(186003)(478600001)(66946007)(83380400001)(38100700002)(38350700002)(921005)(86362001)(36756003)(26005)(6512007)(1076003)(6506007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/ReIzDPaEkeEyH9sfSu+XrKADYn/9b2tNdBjkAYnuI4WyQkCqPdlGGhcQGb5?=
 =?us-ascii?Q?vMvLzFe1q0sx6RT939jbw5GjlvbaGQKu4E5rEQmWZn5MBqeBAndIfzs87K0N?=
 =?us-ascii?Q?ry2A0Pcg9JZV/hEEmcWqsqBdCKvRHr+CNP/2pRy6HhFM9A2jOkjnqSjPz1O3?=
 =?us-ascii?Q?Ll7oLL4Yrijl/vEyC37PJllZkrrwNYhgdL8Ni9gTFhGd6dCiLSDskDSULQ7O?=
 =?us-ascii?Q?HfdW3XxIL8iHyo4IXEchF5Y0AzXxSbmzpWz13oCpns9VMMyC4uJr3jnyBEhD?=
 =?us-ascii?Q?k6sYp0YW/2A6qbyP8Vq+mwIkl9b6yfgsBhtIbPG31bfScc4aVWUPjStfMboF?=
 =?us-ascii?Q?dqbqHFcK0aP2O+TOFa0ZRXbr9kMfyVJz6pY1YRaNdFcHR5q5u72zqYKRFWoK?=
 =?us-ascii?Q?A4nXyu2LLCDhmqngS8MuBTfG3q1dCagOj+qfLCbQYOC/BJSqLkevW+Q5VP4K?=
 =?us-ascii?Q?Dgm9Uutohu3CyzAqa2ThAoapWJVqQ3QpNNjWIG7BBLDUmLOVm5vW1WIsXzpn?=
 =?us-ascii?Q?XIVUfcgUEpQZyoxVvUPISP2Vunr9K+IpKvIsnYZHs2keoM8C9Vppk7MtsZ5m?=
 =?us-ascii?Q?/kvZaNs+xKsrYcGg6gFNBC23xY1zfVXbWA53vIkcxOY19YqICmC4zpDIy4Tx?=
 =?us-ascii?Q?5quBW6nbeU1cCV54TDoE8REmurgbqeGtVaeYbQ/y3foJP3iE6TbDpeFmddm/?=
 =?us-ascii?Q?ojhE3h1QhFYptdsARwNjir3LLowUE7jSb8XXePoIvi7fz0+afdMoKGLPv5Sj?=
 =?us-ascii?Q?ZZg62bntaw4SZiBy7FFr+u2E6zBC6gsUUJrHJr7LO3qhuOAOR65dSBZ9qBKn?=
 =?us-ascii?Q?yeeDwJoLrxkA16Rs1aHkCLY6510ikBw43PXgHI/sX4IpP2cvWlx/gXeKN8Cq?=
 =?us-ascii?Q?7MrPrPOoHKDPQgJvjMq0uomL5/DZ6mkWQZfhXTd50Twea+cUW1vOO+jqn7CH?=
 =?us-ascii?Q?P3qszwGKOjZ/pBdiMrbnJIIBfBDqtETIFUtKGJUu+7T1Wqsh7CYHDzGHARc0?=
 =?us-ascii?Q?mdJsQPX6AU/y6WjBeJ0of4fC1bpMpm+hFEFRPQXDAEip4gzus4f5fxH/JEyB?=
 =?us-ascii?Q?htOgz77LR/+ASSgS4CbXUMyybpreEunXWCh2WCg0GCT6vxD3d0DQ/rQSbFi6?=
 =?us-ascii?Q?KqtH92eNVMHUlXVbTIFSGsmTG53LFLhCTikJW/rJEerKcG7G2FHALlcXPjC5?=
 =?us-ascii?Q?Ii2Ff1lzVaOtq+Zt/lp3pd05HrGcTH7AcOf43wNN7qLBxmdrvcxj7Knwej+Y?=
 =?us-ascii?Q?zxA3qVKrJAS1oDto4bYQNoXcmTJK91AXRwWJqAaSdpmUAJNsDCkwtN2JBish?=
 =?us-ascii?Q?RwK7ncSBvHROv6sgNlGgL0PVRHoztV0uoEyLKmcKWOWawL/WCd5DfAsWkGJf?=
 =?us-ascii?Q?uiGR/TKW+IaRmGGivZFV+am0sSS3J2TVaL2GFq+KN7QOlK84l++KzTsevca+?=
 =?us-ascii?Q?73g7feKbR43lfS0s5g5ge5EEFtXDww78bm/59ZsnxgkG5wqtevGIfIhIGdXk?=
 =?us-ascii?Q?HiMtaHC18SJ/jMdca5nrn8G3bXr3pBFlOYRJa/ZQxVzH7TQ3q7GsOiMUe5M5?=
 =?us-ascii?Q?Ybt2flfAOTCb6WpdS98=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d733aa-ce2a-4e2e-6338-08db6d0ea8fd
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 19:36:33.7111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iyzFYGZDOu5SFgvcop8hwW7evPJuoaxnSyD/LLcXnqUw5kAZ6ZpCDmicDIT3BNxfRAW/S/QHajHH7kyqw6UFMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9763
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
 .../devicetree/bindings/dma/fsl,edma.yaml     | 99 +++++++++++++++++--
 1 file changed, 92 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
index 5fd8fc604261..de8c44bd8a89 100644
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
@@ -65,6 +74,38 @@ required:
 
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
+    else:
+      properties:
+        reg:
+          minItems: 2
+          maxItems: 3
+        interrupts:
+          minItems: 2
+          maxItems: 17
+        "#dma-cells":
+          const: 2
+        dma-channels:
+          const: 32
+
   - if:
       properties:
         compatible:
@@ -153,3 +194,47 @@ examples:
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

