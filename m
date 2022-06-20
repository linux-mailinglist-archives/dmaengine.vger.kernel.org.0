Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9ED550E76
	for <lists+dmaengine@lfdr.de>; Mon, 20 Jun 2022 03:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbiFTB6f (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 19 Jun 2022 21:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237615AbiFTB6Z (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 19 Jun 2022 21:58:25 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10045.outbound.protection.outlook.com [40.107.1.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9F95F93;
        Sun, 19 Jun 2022 18:58:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=feGUA6+Vr4HPEXhOg3got7RJT49u9bxs/zxwTzsC8i8i5D1IZziJu4Qmp5oyuHZYYiprkIPU+U4/f5gqSn3nUKpIdq/nEjHtovWlEioMyENUyF/cpgcr3mgewP6AINbjN6bHMDpQ2963KZZp8f+TuFlWWV5KrPzmd/N4IwmQwJNABSe7/BeIhLp4RaFAI351zeWWtINNMfRQh/tHgbtGbr5IVXEf3i6IeSvdcte2RXD2gNBB7InB26nX83IklqvLkbrMcM1lLrek0rv4waW+ETY7fhcKJoyqWdTkD9AGyMWoz8144ahjhzm/sFLiyxTpfP5+q7qUR2bBPemhbwCPWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yF4oWIl/NQDYISPaYyTiwWv2KazKoXvtMjwpOmaO2/Y=;
 b=cPcBkObiUmlkJVdAxL+VL7yolgjWWeZ+RAUW9VzgqbYVWdAAxf6/41YqxLkhs5si/a+3vrUGhYO67H6sOmlvPF4UweKucGWczjFvvYO2dlDxmmrwoOMxUfOxc1H5wzW3spHUAUrFihzBxFYbK5Ap1i2LeOwJp9dDslleVhxOfmwCavbQqnkOgTzatMgQV2pMQ4o/GrNW5PHhTKgTrwCzI7HU+OtPdBq0bPv5wieJpTfsnbIcmn9puv2tVa0PalB9/i1yMI2hYwFyn93bJF2DEASjGDrfbzco2/ORXSHQJVLUJ6aeFcak4z2H4H2Itc683CcnZimnDwV89lRYOXcsCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yF4oWIl/NQDYISPaYyTiwWv2KazKoXvtMjwpOmaO2/Y=;
 b=MLB6qkkXZNJwGV6v9r3GpmqiBSrNMHBrEzf9pkrtwYr72u/75HkoIrQNbrneUhKhM9033tuxxp6i9wgsbCH7pirDklak0LebyEXKP6IjUjK0CGEHmpsUtxBgJCnSy5MZKBjHMfEJyIJadbmxMh1oTGs+Thxup+e1X0USIUBBIB0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB7PR04MB5212.eurprd04.prod.outlook.com (2603:10a6:10:20::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.20; Mon, 20 Jun
 2022 01:58:19 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%9]) with mapi id 15.20.5353.016; Mon, 20 Jun 2022
 01:58:19 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     vkoul@kernel.org, dmaengine@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, joy.zou@nxp.com,
        Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V4] dt-bindings: dma: fsl-edma: Convert to DT schema
Date:   Mon, 20 Jun 2022 10:00:02 +0800
Message-Id: <20220620020002.3966343-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0077.apcprd02.prod.outlook.com
 (2603:1096:4:90::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27f3077d-c48e-4dff-9379-08da52605924
X-MS-TrafficTypeDiagnostic: DB7PR04MB5212:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB5212A4EC225C7F4585571DDEC9B09@DB7PR04MB5212.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ht4X899mIQrSz9AGbAYCjdHXRlhgUZShrA3LZrEBg6bZFyz84XQrF47WhLprtp3A+V1Wtpk8PcOHuCDr5FufSDFWFiDLT1HobxK9D8Wwhv+EGFPJXbr87KGzQQLN/wRjXltEOq306y2SKim/quQPOU8krM96Nwqlx3qFZJEtdD4KnqBCSCM6FzQh6lqPZSzxu4g3tlnQpWLKDi2BXs8/ZBNnIp6YV2zOmQ7jlIfEMpVHiHzNSO1DkE3PZKb0f2wgMfvcCV8PYRvhqtlVpfl2pk3HSrzX9kon3LUeHoO/SlHuvsk4qmSjhdu30E3qER0rKSu9MhZQVmOEtxAsXYi76yEjk1Hw102XJ+YDpVBtlJWny5d1tGD6Iuu+Q7IbbZ/1R8jNK6jCgMfij/BI16Em6BVYbLxMWj7pkgwy2YYHxgagaQ9DRsV97oOC7SvTxdAWde2Le5MPoGDIGXZTQ8N93CbNBF06nwUtMBOLPwWpnTOG0evNIWD/bD2CP9NMYi8Fn8N2P0lzY8d2dDeTpT64UlcmEjfCQiDpAp/cWNsMQz4UELB6WMEpgsK2wFGia46KK6+OCOT2Im3fsNF5osKXtZYHrvCBjgJc7FG4cf1RLY6zdaXr5NuewCbZfyRwM35yplT0IfEd2XigomBIVCzBv+zkEjlO6NhkzcRGZ0SQ/oy0gEqUG9laEuD0IQEa9PA1DjgrkIGtIGgKdwYM2qKqqOZBBqiWbKdWfyYXveakR8uMSUk7RVTvqYkh+Z+ac8DUI/EoojrbMv2+wdnyT2PKJPMWgplsdW9CC8L1zQjAUx344YrmMxcDbVerYu7msWbR/LGLUsCNVQQnOcCx4HQAjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(1076003)(66556008)(66946007)(8676002)(83380400001)(66476007)(8936002)(6486002)(186003)(4326008)(498600001)(2906002)(6512007)(26005)(2616005)(6666004)(86362001)(6506007)(52116002)(966005)(5660300002)(38350700002)(38100700002)(54906003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OSDa8HikqqykFBmnBnOhQ+1LRqxaq7QlLGhaOpR4QCPj743MdjPwOSiBohIO?=
 =?us-ascii?Q?vs1lmUsVfYxVi0fffsUna79/BfG/MDt1/v3AlH36LWVYoZwdUgxNiK+jPyBN?=
 =?us-ascii?Q?PbAAaYTSZqrYYZVfqzFydEa0YEdtUgfNREkgHI9hMHEysILDKLlcfEgmVvvb?=
 =?us-ascii?Q?777W9mk7XFNoo2fJgorEcCkD7McYL3uChpPWaTAu6Eom03tiFV8OopJ1C/QZ?=
 =?us-ascii?Q?SmxKMm4OmBUxM441/LqkEN/mKuHMnt6ee81d3TTRdkIoZcka65ltGIhsLh3x?=
 =?us-ascii?Q?Z5rs0OCVlPc/jrQ4JjiVNzDCQdW5aa9spB/s4goj2/5SBQIFP+gClocjD2Z0?=
 =?us-ascii?Q?eZiXljYa8r2zztgY8G+Gmxflh3IuDmB+zUe51mBWaCVaImEK7e6MKtVLlWy3?=
 =?us-ascii?Q?+qdRMTOUMSSK/rrlkM7oB8hu9+d6Nj+mCAiDpH29mHDCeJHNPuGEm6MterQt?=
 =?us-ascii?Q?s55sss2s4YAwJU9IdGImiebBXzlQwGiOhyMlWjLaTDnzYhygONqozX6IVlAM?=
 =?us-ascii?Q?nh7jRVu30Wywh0H8b7OR+HQygwViHYYLH676RjrNl7hDguJ4cQiK+HCvkGFl?=
 =?us-ascii?Q?sHA+jO+hzhuupquMTn5p4py9znNr4nW3i0aftxfNIbaJGVih8Si+E8HJmOCU?=
 =?us-ascii?Q?B8obPtfctwNORd0tECVC0sqD8i1BA74PQwZmpg9+UHEEmZMPnnu0sxSm34z2?=
 =?us-ascii?Q?fNpmEMz0Z4aPugTUPgEJahTGlxB8lwXWfFUTvpVBTO55TTKgRQ/tO37tHueQ?=
 =?us-ascii?Q?JSJ6W64JDEOS5Y5WGAcuSRN1EH+QqUbB7GEkVX1TRiw5bXCoRARryJh/e3V7?=
 =?us-ascii?Q?gXW6egNKvRiJtox+nlNwDmmPpvWNa7+2U4BlQ7qbNat4cGq5j098gJ30DhHK?=
 =?us-ascii?Q?vJQviKJ+r135cpHamKPC7XTiCdeqcngZ/CX/Y75FX8f0V603g/Rk39bz2+kJ?=
 =?us-ascii?Q?+RlQ9MOs92QtBlUFWAEDqp+vAUne0g3Hq11JCvgaBA8d6FiBfmca/1U7dg8M?=
 =?us-ascii?Q?IBLxJxlRpEz+SxsP3syFHSQI2bwFhydnki1dSEFj6mNFj691atwSgDYZZcKO?=
 =?us-ascii?Q?meKpj+0I37KTGCGHoZb5xm/t1nf764x7GbNk1KqX+EIUai1kI6FFWtYv8+Wn?=
 =?us-ascii?Q?ReKDsEMKGDNN1MWCOQZXP1Wh/gxWRAsT3epSVQfH0sPGDk6BIVccgW2tTzwo?=
 =?us-ascii?Q?WndwqSOhCjB42b3C7juxVeBbCH9OBk9aPpSTbS3pIF5bUmKPXzhDI+ywpbIb?=
 =?us-ascii?Q?Xw7gE93OIsSEMSeEklPr+VYHWB9PDnfQyKxhpkrUQMyNRjpYguQ9KUXJggCX?=
 =?us-ascii?Q?qm1EA/XCH1rq/ND+KHUfYZzu2reDJiCG5QKfTZd9lPEhEPh4w5jMoD0hTMon?=
 =?us-ascii?Q?7XLl2WNf8AK3Vcxh/vDnppAmlRkyPyI00bOfzgWBFf3hZLQTMYrxE9433ZrI?=
 =?us-ascii?Q?upjC7/HCLyOGhUH87ZlHWNSbXcsZgf4qet0s87S6mWBZ2okj6fg5K8stqtAH?=
 =?us-ascii?Q?DGDWXKiIYT5qtlbU/P4CLp0YQyqp043eZqxiTz4jMIQ8P7iZNFyUK2AafvJc?=
 =?us-ascii?Q?iUNaTT378X9d5izdoA2u9c//U5o4eBkuEkATAqED6NulGba+z6DoGpsZXc/i?=
 =?us-ascii?Q?DX7qZCOciuNXjPun+SxcJUk7PuHTtqVZejtOn7bKqu661cje7U3EOtkNgneT?=
 =?us-ascii?Q?pZrYRMbzTeLpbL9gBjGdo+01jCGzixqhFDoatxp1htzPVn2kBlGUIhRecd0C?=
 =?us-ascii?Q?Ie7dCuxHRQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27f3077d-c48e-4dff-9379-08da52605924
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 01:58:19.5858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oc2QsBNuY6DLktW+6mMF8MakIu7JEL/HP4UUWkwquS+VwcpIq+lHNBHTf2pebiXDpGXobHmISlxBzXFE60ETLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5212
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

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V4:
 Add R-b tag from DT maintainer
 Rebase with linux-next/master

 .../devicetree/bindings/dma/fsl,edma.yaml     | 155 ++++++++++++++++++
 .../devicetree/bindings/dma/fsl-edma.txt      | 111 -------------
 2 files changed, 155 insertions(+), 111 deletions(-)
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
-- 
2.25.1

