Return-Path: <dmaengine+bounces-4562-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8648CA4028F
	for <lists+dmaengine@lfdr.de>; Fri, 21 Feb 2025 23:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7D0E19C295F
	for <lists+dmaengine@lfdr.de>; Fri, 21 Feb 2025 22:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6A5204C10;
	Fri, 21 Feb 2025 22:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="K3KwRh4Q"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2067.outbound.protection.outlook.com [40.107.103.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8342D18DB0B;
	Fri, 21 Feb 2025 22:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740176535; cv=fail; b=e8uevy6L6T91mW9pDIxpqGIct9tAcMGHNikmO6R4rNNagAyIzEDOMlqI+l+Cu96AY9d36sswBgFGHf0shxSi7supXOC8nsZGWG2em63fES5nJ8XsvKeFQ380CEEeEfMsD/kEOzRB2Mn1RSSu370y37I5YyZ2SeHKt4nZ+NCHzQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740176535; c=relaxed/simple;
	bh=j/ZGZE026J+8KFuYxsnOPrDyvCC6WA0l0bZe1xobrRc=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=QpvAcWA5HuLqOsSZitoqqC8ZZWbW8f045m1ZQ00JUQyrFuTECLOK0EpN7GFi9TmmAuyn/4m0rqs7J7Wt4VHUOm/AZUDDFg4jDzs0pSlXPTwam1BnxqpI5+okzzmz+G8jOl+fcIkkJhO5iowW1ehNDia+4J7OoEuqcGofRYASVgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=K3KwRh4Q; arc=fail smtp.client-ip=40.107.103.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZYxvrSOVEkEWl86482Y0H+ak2M8wWWcVpnyF1sRWhXTGZzq3n3d1wO5a30MfO8RN67CBNKpCzvhQLWCUykGxVXYTuNvms7aImlzEkFkLVxxcnhXgkpzquyx5qs9NqfJRDe9rXCvzRILC48YrUS9Xb0abu8IHXwiulva7SbcBRtEsRzYjGLNyNHFdnz1eR+Gz27gXbM7Pff4Ax1Ys4PhR0hxMYR/CYkCnzIuDQFCBqSEGaiDpBRXLLOAl4JNZqsvlXTYSZPx3xsQYH4k/fInJ7p5iwl01CSDnUHg8RcEj1BAyeZOyFWKm6eok20QU3s8DnqXA3fNIP5ttfn9cuSlCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GoM1L/n1r8ePlFFh02gw2UIAaFQDwfqaw1UDI3AACo=;
 b=w+x8+RdDHNUlt0WQFGNZbmptvsZgTvHN+IfhLESB26Tni5sMw6PXrhPt3Wk+w/UQP0goZFhJgE6ZCgKbFmt98hvCy0DmvFHSsNXZCCOu81SdrkLbxdmhjBvjETw5UOGlIdL/+rq2vsMAbUZ4a0VFwAGmuMbagFMRvAiVfpREiXiSq5Bxvsz+4FOZQ6cxSKnkKoyyxLQKfqI1yYjAEfyl2guiDkwO4pTjieKAEqEM7zR1XIHdO81tNvcNV7Q4X73zpR2qsRWbXVSajXPbmvVRviRyFTWK/MZ2dqd9kC1Y5TVByfWGIpqSLwPXbKloXzoa21YzKEITny6bUqC1xs1nEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GoM1L/n1r8ePlFFh02gw2UIAaFQDwfqaw1UDI3AACo=;
 b=K3KwRh4Q0EteugJ5RezdL2lCLMK+aPdvtz+o32o/7S91iGj9+O+3ypjdLUcgYguIQ875e3uATZG5mvWJDaM/bsGAAKXqlU0LCza+HL3YnXrblTlEXd3DQbzoTpp32J9s1LqNvyCYYdPu4ISH1eu1pBuEljlqrFjYTDgiyQpzRp12mgL32ScIidyAi26FVI6BkDajvh5sNTZ5SjUm/DN8SR3N+/nj5YemrWSRwlaWAKGrRb+Kq6giNwQa6OjpWFaK9SCPbSE3/ZoHwjFOFQ4ZVN/3S3oxKqNTObKvqekSyKsxMF67o0TBLUQHNk2hth3sKJYlTGw+Ov8In2hQXurWxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8214.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 22:22:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 22:22:09 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	imx@lists.linux.dev (open list:FREESCALE eDMA DRIVER),
	dmaengine@vger.kernel.org (open list:FREESCALE eDMA DRIVER),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/1] dt-bindings: dma: fsl,edma: Add i.MX94 support
Date: Fri, 21 Feb 2025 17:21:53 -0500
Message-Id: <20250221222153.405285-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0047.namprd02.prod.outlook.com
 (2603:10b6:a03:54::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8214:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e802333-bdf8-402b-7fb7-08dd52c62e85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cOgE9sN5knnM9l4ULufdxsxDysSmiq8zQd+VnQ3orifIZKcEuv49p3HySlpC?=
 =?us-ascii?Q?eh4cUCJCMSs7SX/7g8FdcudIkj9dnNpSYpvkCcbsRMZvOScfg6+01/a6eHjG?=
 =?us-ascii?Q?6BFeUwkChHH4+b7nwKF0/jA0f29+jdzIHnwRPyJiil3Hqv9yvXuMGgSyIKf9?=
 =?us-ascii?Q?liCqdYYFG4YX4tgC1KaPR1HMSBnVgvQHpvNeHBNiHFh+B9/M45V23u3Bcplh?=
 =?us-ascii?Q?1WOAts1thl2DhD6SgZRyMPR9qVG5uoWNodbkU8QjCRal2MrmU7VRR5+hSGzz?=
 =?us-ascii?Q?AwuTxU8gQHLWGS32xsrxMb8fWFRqQFzqSVJmWEYLs9Kj7oO/xnIFOpTBKcYq?=
 =?us-ascii?Q?A4Y8GmJiqgO4lnPRstOAhzcT4lxfoQS6sBi4sJ/sf5AmOJ/AHqnIG/BJtYTI?=
 =?us-ascii?Q?ZJSCTe65r0u4PCAMtvWTjQAUqYriGjkoE62vId0VzSfne1O5fAQVHH5azFfc?=
 =?us-ascii?Q?VnJq7uFu6bzKZDYcaGWlm3TMoFMVzl+KLw50cfeOmtJVtNCGD5d+ray78sK8?=
 =?us-ascii?Q?8XAD0MJulwy9F618J+4aF/lJhE4Lr6KgQjOTLyz4NrZs7Gf9QgXq/L/jxj+O?=
 =?us-ascii?Q?FBU8+yPw2UZh6BpDmq+eCnQaPa3K9yZ9MMFfKOZFwB8e7K9PCLr11bIxihLz?=
 =?us-ascii?Q?2HpeiLJUGPPSAoUk1ws6f14Zaxec7jtFzL8vArZgU52SvTlDDYiggyjq01bm?=
 =?us-ascii?Q?eWRAD7l+oefz6GayFYejJ2O2c9A8ZiwPDDthvG46AeTfZluMelgrIsqJKnxS?=
 =?us-ascii?Q?VE5i+grhqWDlRPy2a86WZeHHNUJHTvCAnN3tR9+YfMc+BMvss9cWErDpfuhu?=
 =?us-ascii?Q?67oRyfl4mvEd95ox2b5NnmFCl4diU9otpc9BQXuP1QsDkXxfgiBaj+Btxzqj?=
 =?us-ascii?Q?eCWCyjp1fOZZQqTq1hSe4vLcXSf/k/ZTAldRWGkLpR5lK+QKdETPLP7XrDdi?=
 =?us-ascii?Q?OIsCPGxw6F9zsk6PAQ3br6uNwuuaaKEnJgZiAbBlPqdtlEQljiY2a/1tJUjx?=
 =?us-ascii?Q?6hI1MMSuAPestWYbzwvVOaXhar1Ytjtq+ZtbvqTvSb343LtZUwTGxi8MT2y4?=
 =?us-ascii?Q?bt/xPNYYiktON7fr99r+46a5XqGLzIN5M78V1wGuBV1gsJqbUhLyL0fcOze7?=
 =?us-ascii?Q?GUyUjA/fHMynjFuvZVB0zKDHR4ILEnqykncIG89+H99cFFMtNYy447y6KqfK?=
 =?us-ascii?Q?4T89jW+K8h1XdAXLJLOcB0GBpTsVHjYjkpziOqJjCTz/VO0DCRD0TSDKRwtI?=
 =?us-ascii?Q?rSiHbSAp6pHgbqtrTaIn5uHWeXKdxSlZm400eDEngEVyzE0WqlR4GVzL5WfG?=
 =?us-ascii?Q?Tdxu6RDgSzhNnugLbtPvl29djEzrj3M7pzeGMAwxavKR7c2XAaGErkRoYV79?=
 =?us-ascii?Q?G5HMxuQb3FtyPXb+UkbI6+cm/ytoBPn+zWA2zEJPNKP2ajaHSCydLkQ/TSMx?=
 =?us-ascii?Q?Wc/3T+ofiYctF0u7NJ4dgjvRaPjDxC0b?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lLRR5MYgKXfPDAwvqXOLMsO4Tqr7enxV8OedtHRwL5uqG/PQ4txZlE1Q0QHW?=
 =?us-ascii?Q?dgzTD5Ramj9mL/2OvG/pNILXwx3c/3ruzD/KnhX7h0aKPwOdoThUD28hQKu0?=
 =?us-ascii?Q?i+xTPszVH0kc5mzOxKQT2ykPekwUkE64vz+gpkJWLcnMWiV5WkFDCSCEewUs?=
 =?us-ascii?Q?I8gtE2d7fW7Kr0NT6Yy4Qfm7TY3d1oU+p9zEiLI3AuXSyIalgg8lqqvrAuKA?=
 =?us-ascii?Q?a1HZnz9S/YyI1aZOWDtkFGRE9eyOc4RD9GEIZbNluqKeEif2bD0VPQjS58sM?=
 =?us-ascii?Q?06LI4AyNubyUFttLMOnXDGLfftJN34es/FPaHYu0h/JTRntw3V0ibxrOsPFp?=
 =?us-ascii?Q?j8nrIK0ugoS4YrQLRTTydaZ+HhCUSsPxRx1KjaZ7MUZ2edw+GHZFzU//MvjI?=
 =?us-ascii?Q?OIObeayGqINkIZRRV2iS4NcNmztevBYdk8hVrqTuKXrYw7R7PrnZoBtZ9Z41?=
 =?us-ascii?Q?sqUdeO7go0gFVvOXhu+Y5+hXkk58PBfJ554BOB07hQvAGqq1FlyWIR4CmZUy?=
 =?us-ascii?Q?VknIU7v2Qa/84RZhfAOEKQgOoJBA/FC/MnNVzu/ztQvswhqZpGqkAr0EOyUy?=
 =?us-ascii?Q?aiNfVmPQMcqUyiikY0fvnYThRRGQLtczJtkphkv3EQUq1AFrgkCZJm5y/rG3?=
 =?us-ascii?Q?cbEcAoSfvbRYJ19gTZUiMVp5EaRn4dwnBXFH5FQnMZ5ZzpbwJykq7sZMuID5?=
 =?us-ascii?Q?TLW4YkUuw7nCnJ3EmSRIybzq1thruLtyqKlVg+hKUdPXiVW9C1XWvB79eiUB?=
 =?us-ascii?Q?iQaqIDigfmkG918of0ywptMd5TbAi2kzqNatoLygwIcVVUyTPuKnrv/Bw1DU?=
 =?us-ascii?Q?S0/fM1gDzaVRoQ/H5uqAejva8i5fuT60ZqVtPscG+WTKmTHeberhkPvDZwBD?=
 =?us-ascii?Q?4L4B0dVRN71U1kacab4mwmnGNV/U+ZlSxj6dlkECl5ytNO9us+fOYxUgDLHf?=
 =?us-ascii?Q?ekm/jsbxuo1INgq0E9c/SE8cEOkWD4zatTcFYLsmOQXAyxhNxrQFtomhTgLt?=
 =?us-ascii?Q?3wRQO2UaBekuSuaAEeEkgu6XxaerCbDHNGpdUckeFBQdlvYq/jEeaE/LjAtk?=
 =?us-ascii?Q?xTAfGE2vh+I7HIJDyNeoAbMJrnhlToV8JAFvk+CbsscKDh5OID4msjVIpj8x?=
 =?us-ascii?Q?PmJ4A42vPuUXXquYyR5Tfrjptusr+hgQ02uWQo9i5RRXcIkuqYuDEgh2yXQW?=
 =?us-ascii?Q?qOXBOBzTyylDdlpuiSeJ5T8ncTZTKU3TuXQnJ6kjaP7HV5nLbgsUyajb2Wbr?=
 =?us-ascii?Q?nVVLtQhMJi/Rpv7Gcr1YRBRFb9h5oWcfNvx+SmujAbS1SanRNM8LacxbyI/O?=
 =?us-ascii?Q?TjzuqujzyYugGGnDZZn1LFURMO593ywF/itygqBkA98jG9g9x+sRuCh9MzQm?=
 =?us-ascii?Q?Acd1jdikW4wi++Esps8LBHujzRApdWrqfaptp0WmWahbtHfEzxZw2bsOD449?=
 =?us-ascii?Q?gBrmhaF/oxWkoF5OkwI3ks6UjMJqTm+vr6uTrqICifz0WQLn4VjboAMAvrE2?=
 =?us-ascii?Q?YYWFoQKi8YyBMHdSDSyVkivuFr39DSaflRZZ8ZwNVm2jz5wCX2VkpBuqCYxc?=
 =?us-ascii?Q?Z+SEJ9DJupegmHWA5nFissS41U95THzC/4vJUx4I?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e802333-bdf8-402b-7fb7-08dd52c62e85
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 22:22:09.6826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +kLvNhEjzlDFXRzUQcj8xtmyXe4QrZhAAAh2QAq71zA54hkQaSpZarf5dADPcDHTtGsQGedP/G+lrckY8RbuhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8214

Add support for the i.MX94 DMA controllers. The SoC includes two DMA
controllers: one compatible with i.MX93 eDMA3 and another compatible with
i.MX95 eDMA5.

Add compatible string "fsl,imx94-edma3" with fallback to "fsl,imx93-edma3".
Add compatible string "fsl,imx94-edma5" with fallback to "fsl,imx95-edma5".

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
dts patch first try at
https://lore.kernel.org/imx/AS8PR04MB8642049B19BC7A5C8833FEB487042@AS8PR04MB8642.eurprd04.prod.outlook.com/
---
 Documentation/devicetree/bindings/dma/fsl,edma.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
index 4f925469533e7..950e8fa4f4ab4 100644
--- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
@@ -27,6 +27,14 @@ properties:
           - fsl,imx93-edma4
           - fsl,imx95-edma5
           - nxp,s32g2-edma
+      - items:
+          - enum:
+              - fsl,imx94-edma3
+          - const: fsl,imx93-edma3
+      - items:
+          - enum:
+              - fsl,imx94-edma5
+          - const: fsl,imx95-edma5
       - items:
           - const: fsl,ls1028a-edma
           - const: fsl,vf610-edma
-- 
2.34.1


