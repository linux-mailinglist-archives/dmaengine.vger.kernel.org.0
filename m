Return-Path: <dmaengine+bounces-1795-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8446089E2C2
	for <lists+dmaengine@lfdr.de>; Tue,  9 Apr 2024 20:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AD972847B5
	for <lists+dmaengine@lfdr.de>; Tue,  9 Apr 2024 18:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C411156F5F;
	Tue,  9 Apr 2024 18:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Opp5DMOr"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2126.outbound.protection.outlook.com [40.107.22.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415E8156F3C;
	Tue,  9 Apr 2024 18:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712688877; cv=fail; b=XgDbvi/fl5nLI9+LnSwbFfTMTRV9oqFFxKPW1WC8InaMx1/bEW4LgrUTSIHVN21OyQl+i+hwqLyYjaABdgqS9ZaZhOkrkZCTkaqmq6m1IHz9dkoB8hrnThACSOmdKu4zHhmbIMNsl3hJIpI37cw5y0tW0iKieQ5zkHPv2+9etag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712688877; c=relaxed/simple;
	bh=Q9m1ZNIMnWa+oPk2UpHWADjgk4G4k67ehZ4f5druux0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BUu9LJu8ZgmwjJLq5bNPn0sdynIsxKXzhXCiR6rQMbnsFTbNYBpGDkK+dDrWTRV+dlDv2RFPMbp5DGOHs9AIMm3VoXv9MWXdzNuEnQqNmCU3QvUZ8MHhn4p1CvIsa1q8dDGejgnFAkbA1m6kr/Izpsl2okg94i6l0POwpSHBe1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Opp5DMOr; arc=fail smtp.client-ip=40.107.22.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9bget8lP7EdJZo5OXSocf/rd2mQLBPhyVhTyuplTL3PzvZuqiBld6z+uxoEqYT6/7vpsmuPa/idbjpYaBcA70ZjuvhJ8ki1Uus+oqEbDSB+fUVX4NUtQz1DAnH+Db8HKT1QIlXbv441Sg+9lUralitBTMqFvRauybfDjXWMdW+3tfCQugOeNNLexP3B1uiekYKt7NPWkkw95W9geFezDdV7IwZIuWFC7XEDu4sbcasvEPvd/HzMAqcZ/xHelMlf7woTD2aFIQc7VsvgMU6UGokpXRq2l1BHfISqUkLrU2PEs8rikZNnoyDf0ECMzvPUpeY5FcoLtPzwlvIVpBf2aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylXzJ5bnVbakh8k0dePsCCCAxdKz+Ui7BIyjmorH41o=;
 b=RNTo0DXrixlsUbnrm8ZpMo8U22c2eBnjwLtfAG5I6zMxJLWyOtjZndfeEKDxJa9XlSMvePLv2QLTx/uqfm8JfHHb0bR8QC7EBGJGEcmLV2YD9JtXq7OMUMLY30tDt308hXq4WQGt+f6y2obI0SitfOIQX1/z+h/Xc+RqXanmQieFUzRXud6VKMC/7ZxTHbWecv9NBE3PMtnoBNVTr8ZKtVZJMuA5aCukQmMSx+UGeFWng2CfPkQ76v1/mmLZO+HtrqRRnYqRrQr8c2fdrQ34/4+8KFUNMbWIXMZEOANM4F64btWA6V5rIXE8NH5+2uR6KVZfXEjc+P9+FgzdX5HpXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylXzJ5bnVbakh8k0dePsCCCAxdKz+Ui7BIyjmorH41o=;
 b=Opp5DMOrxmWFaOBPYvDUniIG6fBhryLBCWgBob5EYEGlLvDT4e0aEbTvphZ61fWzQoNmdnczaa5bLXHNPb1jpDuMvg4yBC3Kewn7VjkG1Xx1zPEA8yGECTccA2I60bu/FLqRZpFcTGTRRHQFbHmJzuA0nOKI3j5U+sEOqf0CCxg=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7673.eurprd04.prod.outlook.com (2603:10a6:10:202::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Tue, 9 Apr
 2024 18:54:32 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 18:54:32 +0000
From: Frank Li <Frank.Li@nxp.com>
To: krzysztof.kozlowski@linaro.org
Cc: Frank.li@nxp.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org,
	linux-kernel@vger.kernel.org,
	peng.fan@nxp.com,
	robh@kernel.org,
	vkoul@kernel.org
Subject: [PATCH v3 2/2] dt-bindings: dma: fsl-edma: allow 'power-domains' property
Date: Tue,  9 Apr 2024 14:54:16 -0400
Message-Id: <20240409185416.2224609-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409185416.2224609-1-Frank.Li@nxp.com>
References: <20240409185416.2224609-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0135.namprd13.prod.outlook.com
 (2603:10b6:806:27::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7673:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lASqlRqKgyqk9Njfaa9uPXQhxEowTHZDqh4Z3nnsRnqCYCC3vr1SW+q6TTvO46QVXL0RbFw+LIX6TbbdXHFEQXYij3nKDPh/BVyUYhgYG3sEoF8uz1MDDkARaNlms2dMCMEn+eYGQ083ocLMPPIiqJkW6i3wWiSwffcpjtzE4MBhCL//Ydp7s+kicoebopEZl9xVLSm0/i377L0dpgGAQYAe8Oi7qmaZu6o+kmTgE9uzc76sMhokJMs0T1/2OR7TYdj6mqlVTjZPTZ8kpBJFoayqPaajdiVVQBlxpeIE+kpqUfU1bVXOZNAJp+AEdy7vjDYsnnh13ix+MuXt7ebiAflXOWKb/eFRYAKSOYzIOHE/vq11ztE2SzwMfkdrlGK1s7C4kfNZ3qe1vrh30q/2gEhh4dWUssZ4kmwoQU+Rj+CiMF+i22n52AoJ4LBFPh2U7r7cgkouxzAMFVmzY3iqUlSzfXh5GGXGHbV0Lqutwx51pNMsbvsze+9dJV6oSDF4EHRQy5yTyQBxT/jwB6NKyWDmnsdyEkdwbQwfqX8HHGVjEAET5Sx2bbr4JIvtk1ABuxkoyatc0/H3Fbmo50p1H3UNj/FnbXfotkmBF8ju5pCCGaNW45Iw/BlVhmCuj/uETAr6VaJu8u2ZePsA8Ut+ripCPgya4lU1oa1EWoN3PV9+F+/fHrODXHOpfOicTw/4Uoawtu6ZwW4rGpuJbzmCHw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EWERSAPCEi7oPyDXtujqdRBZhvEOPIsWlfFHpjohZP+qb9e8F7l9Xk4X8yh/?=
 =?us-ascii?Q?4suzDOgSfv8766+VWU/o6dTXAu+/MCcM5A9ErArP/FXwQ3zJG0Zi1jjqy6UA?=
 =?us-ascii?Q?0ntAVQJa1zaX3/ctmWcyuCIePMT4/9KLtqr+wTetaOoEoYCE5MG+3fPQgm0D?=
 =?us-ascii?Q?zHQgBUDrrCNDJCTzbbegXcEZTaYfgXURH87LoCkyZUNhs/8z+jtGdUDWVTVg?=
 =?us-ascii?Q?gUXX/KijRFjpitrqKn766kygKHZwHcztn1mPs6VKUXZoan+lDSLWgpJKRXcq?=
 =?us-ascii?Q?jOZyyZAUT/QCuFKpDwiY3SxTkQ9u/jJMgalvU3dQDLfGF9rl58vC6R3awgp+?=
 =?us-ascii?Q?VkudE+kxpq83Y7JmkJ0DU5r3OYUDWk9BQZOqGEqW/YNVZyWRJmkMHUPPGeWF?=
 =?us-ascii?Q?cCNPVCTeuDJkoYPhFPO34FDWOA0KxjJy5FikjOM7cMWD7PZ2BAGnazNK5N07?=
 =?us-ascii?Q?QtT6kHxSdH9+t63n4KANaymo509SNfFmbgzSaVbdhX3+haGhBItQv8qZlJR6?=
 =?us-ascii?Q?z8XTd14JKjb11zkVgWfsfV7KE/XOLYDgViPskdV7won9LF/pFYNH7tECg9Xs?=
 =?us-ascii?Q?tERWY3eNTqEXshUsdgpxboRutm2/frYJ2/7xBxqHZTusjsenenkbDvs9Clmx?=
 =?us-ascii?Q?V2WEuSFPdfEDzoxx3dUOMnHkf8LXD6LCErA22c9uO0p08NmMSQYB3YmMe8mK?=
 =?us-ascii?Q?3UJ49BImEI511NWGCs3Gy4qBc3cIqU9unZVfmnSUA0xQPQc98jafgShZmF4T?=
 =?us-ascii?Q?Te1xUO6cq60N4wmd97zl02dj/64cN2V0uNwDb/rlWGKsSiaUfMkmfUjiCB8K?=
 =?us-ascii?Q?/xURVFpmX+H5NGPMf17kFG2FFgfqIuE2Qc4TI43JBmZ6v8UwsAycOgs6sw52?=
 =?us-ascii?Q?cIz/Dua84MJws7U6OfIAZtXoh8HWLvPI37bLygTiEIPevDVL9QXJcFBg5gz6?=
 =?us-ascii?Q?fXQjIN/twId2o3JdYDXGkkYmTSR3lr60T3TbKCMPLevX6pQDf7BrGRPRnrpu?=
 =?us-ascii?Q?iFZ2tyN0cx7pdTEQheXfU943cLKgUCOz1y2QVDEtTdSjWAoxBhHUBGKPXIqo?=
 =?us-ascii?Q?5jjPyZR6EeC9wUzdwLS2YXSUwQwCPUKbucnkeqgcpUeUquqXC8iKS4p6JNRI?=
 =?us-ascii?Q?ZwxjsmgiLhBh0U4Zrw88VjEqL/9LaJdn2/331fAgZMo3ufivz9VXPEeWN/sE?=
 =?us-ascii?Q?B+bKFJAgZoz6c7P8nmYCQRHQLk751zWMvTssV6qLjm0a30VS0tpicYiiOfJm?=
 =?us-ascii?Q?1BdO7CtuywuY3nEuJh1T6i184c46L5CeoVAgNY+mhu1VDqH8RBQJZMnRnROv?=
 =?us-ascii?Q?2ZfydAs4g988HdlCbq8k/8UMNgK6Jt1zIv/YntCHmp341rt2uaapfhw5kwrp?=
 =?us-ascii?Q?xjtLxNjAhIUOzTCMQxXZZ2EWAmgtj28Ly16g3V49MzTSoSL57VrytQV9BDDI?=
 =?us-ascii?Q?sMu+BgBCh63JFySFHhn2fI4lIHXr1aP2ZS0nQHCohoMrkNLqttAglMKbHxNO?=
 =?us-ascii?Q?cb7LRtr/FvCcA/xX7mGurcKLawdv+eE6uMUbFYG1S0Prv6PFXVhicQo8K8VQ?=
 =?us-ascii?Q?LF2g5ZO9nqlBnroYft4MwstvVtokbZ6QMt+ohjfq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf58f1d-82ef-4fe8-80ba-08dc58c67e03
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 18:54:32.1580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zRYiPMDIHJNg7xjAZZFKPEbo2f+BV0uw3q52+nm+ax593oDWA7gkCi8tu33/VrhbBAw3j4d7CMsE+2GbOAR04w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7673

Allow 'power-domains' property because i.MX8DXL i.MX8QM and i.MX8QXP need
it. EDMA supports each power-domain for each dma channel. So minItems and
maxItems align 'dma-channels'.

Change fsl,imx93-edma3 example to fsl,imx8qm-edma to affect this variants.

Fixed below DTB_CHECK warning:
  dma-controller@599f0000: Unevaluated properties are not allowed ('power-domains' was unexpected)

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v2 to v3
    - set 'power-domains' false for other compatitble string
    - change imx93 example to 8qm example to affect this change according to
    Krzysztof Kozlowski's suggestion, choose least channel number edma
    instance to reduce code copy. max channel number is 64.
    
    - Rebase to latest dmaengine/next
    
    Change from v1 to v2
    - using maxitem: 64. Each channel have one power domain. Max 64 dmachannel.
    - add power-domains to 'required' when compatible string is fsl,imx8qm-adma
        or fsl,imx8qm-edma

 .../devicetree/bindings/dma/fsl,edma.yaml     | 79 ++++++++++---------
 1 file changed, 40 insertions(+), 39 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
index 657a7d3ebf857..012522612dc96 100644
--- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
@@ -71,6 +71,10 @@ properties:
     minItems: 1
     maxItems: 33
 
+  power-domains:
+    minItems: 1
+    maxItems: 64
+
   big-endian:
     description: |
       If present registers and hardware scatter/gather descriptors of the
@@ -189,7 +193,7 @@ allOf:
   - if:
       properties:
         compatible:
-	  contains:
+          contains:
             enum:
               - fsl,vf610-edma
               - fsl,imx7ulp-edma
@@ -202,6 +206,20 @@ allOf:
       required:
         - clocks
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8qm-adma
+              - fsl,imx8qm-edma
+    then:
+      required:
+        - power-domains
+    else:
+      properties:
+        power-domains: false
+
 unevaluatedProperties: false
 
 examples:
@@ -257,44 +275,27 @@ examples:
 
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
-    #include <dt-bindings/clock/imx93-clock.h>
+    #include <dt-bindings/firmware/imx/rsrc.h>
 
-    dma-controller@44000000 {
-      compatible = "fsl,imx93-edma3";
-      reg = <0x44000000 0x200000>;
+    dma-controller@5a9f0000 {
+      compatible = "fsl,imx8qm-edma";
+      reg = <0x5a9f0000 0x90000>;
       #dma-cells = <3>;
-      dma-channels = <31>;
-      interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
-        clocks = <&clk IMX93_CLK_EDMA1_GATE>;
-        clock-names = "dma";
+      dma-channels = <8>;
+      interrupts = <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 427 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 428 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 429 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 430 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 431 IRQ_TYPE_LEVEL_HIGH>;
+      power-domains = <&pd IMX_SC_R_DMA_3_CH0>,
+                      <&pd IMX_SC_R_DMA_3_CH1>,
+                      <&pd IMX_SC_R_DMA_3_CH2>,
+                      <&pd IMX_SC_R_DMA_3_CH3>,
+                      <&pd IMX_SC_R_DMA_3_CH4>,
+                      <&pd IMX_SC_R_DMA_3_CH5>,
+                      <&pd IMX_SC_R_DMA_3_CH6>,
+                      <&pd IMX_SC_R_DMA_3_CH7>;
     };
-- 
2.34.1


