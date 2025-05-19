Return-Path: <dmaengine+bounces-5191-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E38D7ABB459
	for <lists+dmaengine@lfdr.de>; Mon, 19 May 2025 07:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 874413B7ABA
	for <lists+dmaengine@lfdr.de>; Mon, 19 May 2025 05:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C541F098F;
	Mon, 19 May 2025 05:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="j9VSh/zY"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5F51EF393;
	Mon, 19 May 2025 05:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747631425; cv=fail; b=f4gNNMs871ESxklZ3o0HhZzbh9bAKBTprVDufXq6clxztMUrJewna5/CayoEl7VJnwBlsYKPbNeOxhYQJ28igUOvxJC1sxMNho8Y/dUEf40oqf/36BabHvs/8CmEdeoJHVLkbrcMgpCuz7d58/sfNxcJRgHI8h+Aq8W5uzjRum4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747631425; c=relaxed/simple;
	bh=TFPi5kjkIsZ3se/aGjCsR/Lg7t2USkei9dbjnIQ2evg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N6GcfJQsiA0V3XAgIx7K8tnztiua2pC1NqrLcBBytT5ZIQK6lixfJZvk7dob+ja3/GzuCr0sXOE03u+EcNQMthvntZ7FmqVdkXuEZz0chci6BLMCNQCR6O3RKaNK1GGJdsIDfZtBjzqq3pExOvQMhxj3RCjsXoVFaHV9rKHegKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=j9VSh/zY; arc=fail smtp.client-ip=40.107.244.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YHjam91SAnI1A3hmJxTCqMvLhx6kEpU12Emn510pGXHpWfYAbkKAo1UAm4vJzJn/S9wltuBF7a6FHyg2Bb6JQPlbzKhGTZue4bDCNMOkq3jrhnpyohopwksRBZaqeOJxCFtJFuREkul3ZIxb70QRTXYjHnx0QKOND540vp7vcyzI5+vk38wEPlrzlC2LqeV1ahpTGqbB3yJZJcAri9xKjconLase0PJ8VJpw5NeNNIh7KDnVumjc2M11zPlBvKh3tRQ3NbCqEFAY5FppjFEr/Q1H+FGx6NbdN1nGXNxmLAcYvF2FCJywFOUPWlTlP8Ot+2fJ5q40P8iKzD3xs48vJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7e3BShKtAP2T6zVxx/3RuZhhXANtyhiWu2E9EW7ct8=;
 b=cN2lF8EXxsfEgoo5ZyD/Lhksi/jMIkbYM+kl0tcMchQIAmzDfyFpZOcaIgQN8lwIIyZXVCBksWq+rA1Fph4cBnuB+I9lX4o09mm12MDZ+Olj+8vLPMdZW0s+G8Tg7MezBY1PTnjMfdgTErjkdlpe2cnDg21XPLTToKOL/b2Zf052nsDPaARMe2pOtqzx9fJR7FiQasVwHZ+u8SDCKYeNlp8WzNSGSktocEtmoXBitA8GAc7/w03s8AkW21m5U/ndQmzv374SJHyJUA+fy7D6RDMZ31Y5YBcAkFzPXuVCw1QJ8ppcLKbMxfACIKSt/dPumiosfCWz/dRoBUnVIa4QDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7e3BShKtAP2T6zVxx/3RuZhhXANtyhiWu2E9EW7ct8=;
 b=j9VSh/zYxazknPPb1NERjUxAwZQOEeWbSgBKeD8WYGjALe9JGfgt1YrpxT1vhSeEgiEsk+56OhWpu4XSXCtIeKC353DEpif1NhK+7onpzBcnoe8UF/NNIztTBMwE3iq6+UYVJsJ2+xhKirWnPlrBUaL598G/vur6Rv050uJPKRjL7fFVLm4TDl/fpOzOt4s+50WbYnqTb1npDvl2+bUjgk3YyZwYumTV2my5klUpBXm60jhZZaE0ulyK4CBWKbNy6qmoisq+Q9tL7sG2sTpugcGL8e/sMvF4Es/cg+XV87nhhmLQur3jLVIKwjPqU9M7ktrA7SSPgZggOMkYaepDIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 CH2PR03MB8060.namprd03.prod.outlook.com (2603:10b6:610:280::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 05:10:22 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::c297:4c45:23cb:7f71]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::c297:4c45:23cb:7f71%7]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 05:10:22 +0000
From: adrianhoyin.ng@altera.com
To: dinguyen@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Eugeniy.Paltsev@synopsys.com,
	vkoul@kernel.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: adrianhoyin.ng@altera.com,
	Matthew Gerlach <matthew.gerlach@altrera.com>
Subject: [PATCH v2 1/4] dt-bindings: dma: snps,dw-axi-dmac: Add iommus dma-coherent and dma bit-mask quirk
Date: Mon, 19 May 2025 13:09:38 +0800
Message-ID: <c9d1ae618b43b328b3b8775334987e5acdaf2490.1747630638.git.adrianhoyin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <cover.1747630638.git.adrianhoyin.ng@altera.com>
References: <cover.1747630638.git.adrianhoyin.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0114.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::18) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|CH2PR03MB8060:EE_
X-MS-Office365-Filtering-Correlation-Id: a6dd20db-967d-4fe5-abb0-08dd969374ec
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4O4aYun6Dy5hFqyEK6IG43f8as2Ok13c9bca8VfGtq3P7/FO3zmN4KuMYHZa?=
 =?us-ascii?Q?gF2PPvu7nyhrgLkBeqf6YDW3HyCiqQeh0x5RpbGynUywCQ7ENWGAtrQn+7l3?=
 =?us-ascii?Q?qGZV4HaUC2a569ac57C7LZFsfmgHVdZXBKUjepl/io/3YBWd9oV1k4DCQw81?=
 =?us-ascii?Q?ErAza1lpRz8GP/grj2gB4no1ScgqmPYQUJDuHLlKji6abdABaiDGMCH3SPRs?=
 =?us-ascii?Q?DcpQ8HX43tGBCFYbwEB9Drs5pAj45g54SzJ6AASB0pRmwyYJ1UkkAnxxHiIh?=
 =?us-ascii?Q?diaARchKO7qmibEvduezQxo3gsduBtyND1+3SNnAObI0+lB7xCjHlVleauqH?=
 =?us-ascii?Q?gsnTr3fQr0tu6oXSFQqbgWRbl6wKcPLoxwgUvziPE9pQVhq2y1s53RXHgGCF?=
 =?us-ascii?Q?6Ql8Nx+Ljz9KVZpglgXhX3EYurStSBSJkohqykulkyOLSod3rHP/rVqJ/GQ6?=
 =?us-ascii?Q?T3wDhrBppwTYcKPh2NHsSuN6gbVxbiXX0ZlAO6ElwuP0DIPI+5oDRogpbx9J?=
 =?us-ascii?Q?EG8SmCvYDwyYc/lANE4BkTB4agHx2ckE7iKALLiXeex4GtvgELHH7o3NQYb4?=
 =?us-ascii?Q?rmjFcwDCg1rpCpbVTYbXv28CDGygNkleexPgPnE64Q8jL7UFkT6aLm6U58ea?=
 =?us-ascii?Q?iymExrhwyAg5kECF1E2yzON+aJ8MmBH6JFghhDu3LU7MsMctPVOMOp/tHpZo?=
 =?us-ascii?Q?PQ7qmj31KBa4K5We9UFXIfr7CdPs5Ro7BE18BkuleuS4w+gLKN+3ZLoKM368?=
 =?us-ascii?Q?AcisH6cv/T4ELt/iq1mW9HL16eNSvKwWJ84k7BoOb2LnvHrt8meJydcoPcUR?=
 =?us-ascii?Q?JyMrNFSpASCT623Qtl0wVFvrVUpwi9cS17pxmJPIgWYsX5d68IBlorKzjmcn?=
 =?us-ascii?Q?CyiTRJxnsjB8o1Y4aebWn4be000hk4R05id6039DyOedUHt57ZKcCzAjauYW?=
 =?us-ascii?Q?8iiRhSyTjYIt4QvLDS+ZWiwfQ4EVfN1l3jp6sYHScU277WoauYy4BROGdJtL?=
 =?us-ascii?Q?8ZzwEpN/gWe7jSSK9Q1PG49QFjeZePFRA9Lpl2hb5oodgDqS684bNOl3b3M8?=
 =?us-ascii?Q?P/V70dozsmeyVgRjFAXFCkObRk+VVmA6/xs/JA0wg9+DIAvegqX473+illGn?=
 =?us-ascii?Q?UdTcSGcXZ6UROqfPWYQd72bBtPM/6w69wwNprgBVXxgEv+QzccTWItL8b2JQ?=
 =?us-ascii?Q?6Fp1+f3I/585bbIqJH5mFLEKtqhkLe6UtGZU3mdgH2527/fPXguwtGp3dz4T?=
 =?us-ascii?Q?WiVAlGjLM8D5lX9zpxnHddGurAB6/K+pKZYdBL2bsnoBRPot8LPtxwveJwXl?=
 =?us-ascii?Q?LljXj/19mSBYsDbQah7C9ImMctBL43TiEnvmdrM3Yj6/Sk7Qm6znk4Tn7B/5?=
 =?us-ascii?Q?OgI0xwxcFQPHejGTtULMxNAC3vSx0wDv9xkO+B22oPZuwsQ0km7ojvPwCN/N?=
 =?us-ascii?Q?yJmcDbFyX7E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GJyPAfhR7r7JWnh7wyv/VnFti3mB97R2GsVFYLNZzrMo1WK6ClPUTFQmPX+m?=
 =?us-ascii?Q?GTXwAx1Ilh04wOpWhreqUHktWJm9b3b77nLvZXD4wB+zFgSu20vmRDDTNLx0?=
 =?us-ascii?Q?Y7w+jlbE3dO+yk1LszV0S46WH1i9TG6w7bEV6QhQc149eaBoXEYS5UIhly9e?=
 =?us-ascii?Q?CDrRFYS8WKkEGVMTIxeuWsLA00mOdEICB5KmVNB+DmllXN7lUcxAFvat5sG7?=
 =?us-ascii?Q?WHjCy0C/By1WYGnxu28YXwJQ5VmdY3Vc5HsqV394NFtY62SoHe01X8uziyVD?=
 =?us-ascii?Q?sA+BzUM8kGAQ/4Yz/fFk1SbzWTbF8u9Ro8a8QnPlAq8+1mdgEV2WVJbJhEyx?=
 =?us-ascii?Q?w636Fx9DZYrRp1EvGW5VmOTJ+7nhvUx3zLPDLA6FOkievUVXNm3E8Civ/ecX?=
 =?us-ascii?Q?PmBqn5dTyBYE03IYa2rA5jBy9wbVXIjZP+6oNsaznhfOvMqK+2BNLRF1LOl9?=
 =?us-ascii?Q?TJz5sPdQb47a7pEMOoHyKr14tN6oHJk7ZLOGeoK/mC5PSaf6ejtXgUqgG68e?=
 =?us-ascii?Q?RG4O+puQD2HniAJY4DOKHFCBuSMPKvhVeBTQ1mrwb86+1LDT3CnGugHrYE8D?=
 =?us-ascii?Q?6vP/gjyDoPjZRC2g8s0pi3nOZJYZTYMJB79aUbIaaUg/pD4WRy/eeA9Xxcop?=
 =?us-ascii?Q?N1TbODvIsIeaCfohlZxJ8vv3jWaFwnTDnoRuOfIUSZslwc1oBJlPOaSqXoW6?=
 =?us-ascii?Q?/HEvWYWge+2MonprlT1e/tY9yvLD2yjgY4MmyDbGBLsBtzFw+9g+wddNPjOu?=
 =?us-ascii?Q?94f4K5wQa43lvVMSCIVQRxEcSxDy31cC5/e2DtZfpSRfFUvD61KO+gvaAvEL?=
 =?us-ascii?Q?hisS7OQRFT0Ow1TdP0CZNJza30xZBwceEMh6igSlUogoCYDRKIvI2/t7KXk5?=
 =?us-ascii?Q?jwxt/Gnj9EHYzF5plEk4AGW1YZrTk75dfpCYAqXdev9BOaDnp4rtGh+yDcuA?=
 =?us-ascii?Q?GuFdnz/IAZ7ugc+jcSUm9Sf+BYA0iujjvVtXmtIl2P3PIpX9W/OGOZ9rIOc5?=
 =?us-ascii?Q?UO6g8Zd7KBX72sba3PbM4Uqc+T4sgNOHUg3DZEhcBY6TPENsGFAELEJV8rSZ?=
 =?us-ascii?Q?LXhmk/qB+humiXtp1bfgp+txD8RT25aTq6R/3lMe4+o+BFNVhLHljNsrME3K?=
 =?us-ascii?Q?zK1DlaRV9rNkpvMT5U6dvvOgyI0LO0wVmuzgKB7v6FTRwM8j1PCpNLBV6ZNu?=
 =?us-ascii?Q?mBjE0Iws0s7Z2idY0K/uWy14Et18cwKr+wBs6MqiCVueAGyGpS5iYVFrhhSR?=
 =?us-ascii?Q?xWvPEdgnAR+nDtpfs3fQIZehLDdvzh0VFyJUypt2LymL5bXV5zssUnmz9Pv/?=
 =?us-ascii?Q?nDHXNiLgv65b7NVSmA6MbMM3ncrl2ds5U7w7e6RQMkcqqO2pVIlHd6t0aXNx?=
 =?us-ascii?Q?vKO6rnkhvT7A5ogXEv9jPyskFhGbsGywvydF7MA0K4PgYJLFq1RrBwfYs2gB?=
 =?us-ascii?Q?m9kwWK1yxYEhM1ioFBnnDn+idmmgPw2RfaqAaL9usuEkcRqS0WBSGT+qSY74?=
 =?us-ascii?Q?Gkbx5cH/xMsJ3IvWsoVNXIck6aVJXDArkgVVXIVagviQk0zYgQeglyW0cjsq?=
 =?us-ascii?Q?SYO6MF5OaSol2ycpoWZRk906BTyFurhI8dJ3IjKlmbQXYGWs2RmeAJaBL7VO?=
 =?us-ascii?Q?8Q=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6dd20db-967d-4fe5-abb0-08dd969374ec
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 05:10:22.3365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3BhCshLoYrTmCVFIl9vc4JpsFHmtwn/rN5x/M3nbSXPrAR3PoWt9xyW81AAVxJAbqRZLTIAx39xSnIJ0pnnS4wGB5FXaFe1zEaskR7HDV3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB8060

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

Intel Agilex5 address bus only supports up to 40 bits. Add dma-bit-mask
property to allow configuration of dma bit-mask size. Add iommu property
for SMMU support. Add dma-coherent property for cache coherent support.

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altrera.com>
---
 .../devicetree/bindings/dma/snps,dw-axi-dmac.yaml   | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
index 935735a59afd..f0a54a1031e7 100644
--- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
@@ -42,6 +42,9 @@ properties:
     minItems: 1
     maxItems: 8
 
+  iommus:
+    maxItems: 1
+
   clocks:
     items:
       - description: Bus Clock
@@ -61,6 +64,8 @@ properties:
 
   dma-noncoherent: true
 
+  dma-coherent: true
+
   resets:
     minItems: 1
     maxItems: 2
@@ -101,6 +106,14 @@ properties:
     minimum: 1
     maximum: 256
 
+  snps,dma-bit-mask:
+    description:
+      Defines the number of addressable bits for DMA.
+      If this property is missing, the default 64bit will be used.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 32
+    maximum: 64
+
 required:
   - compatible
   - reg
-- 
2.49.GIT


