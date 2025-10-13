Return-Path: <dmaengine+bounces-6804-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA01BD10EC
	for <lists+dmaengine@lfdr.de>; Mon, 13 Oct 2025 03:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B45EC3BB12E
	for <lists+dmaengine@lfdr.de>; Mon, 13 Oct 2025 01:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100A9219301;
	Mon, 13 Oct 2025 01:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="fpWnLBgT"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011021.outbound.protection.outlook.com [52.101.52.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665CD1E9B0D;
	Mon, 13 Oct 2025 01:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760317638; cv=fail; b=Jldkoz5SUH5m8JGNHtBe1bfeCfN1qBaQ25JHbuEjpAiouiUU0b8Kva1CG7X3sxXE8neQJfEm6FZf4iqdoasCfG8a2+yOaRnVIvZBF/x0XYlp1jgy7V1PAUUxsnW6HuHxIwWNzH5ISfRK9Zo5IKefwDi3IKdyzGXi+6NZ7l2n4TM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760317638; c=relaxed/simple;
	bh=vyrhJvAVYW9gzeomJ8awOKe8Voits+QqOrEMvRN+OMk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BUb0ptqxyshfC9p3Sre8QqwZhJEtSt9UX5boD5SscGzBcfirZLIc3xnW0536dHm/2mxt9UHnSuiDGXKb6rhK5Ayc8Q2moLB7QpkLrmeHgwF8qb8KLcoBvYxMRcu0s5GtwrwCXhARbL2NirAg60XqjJr69oOQcmsc9BErnTyMIo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=fpWnLBgT; arc=fail smtp.client-ip=52.101.52.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pOJ4a8nEe8jjFIdINl8Qxh6/HwHX9iSCDxYp8SxPr4HPCLHRF8aNWNBMLSQIPD0oaQv+X4RfJ0vfIEANYhPJHcecvUgqa3XATZz7Nqfl1hMam3ieNTdU/DUFs+l9CDzQ6/dp19szVjWlZpEM7Qcyw0RapbrW7Xoypoxr8GalMvNbyDvmBhjmz8RsSaDAZjucjOEOn2PDn8opef6A+h/y+hsN7VjjuRZ0HO2prH57T+pvGi+wRiL1a2Nv7ktK4/AK0e99v8DSKlSq0Snk18HnzEfWocRWUVRrfr0R1x549aygTZWhSoY3doyBSIitsOSZ5ut21PIz7YlefN+JqOth0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ueu16JvUyQ7A8UV8tRomyi7tiRmMi2XbhNn0FZw7idk=;
 b=COwFpK//ym5e53Ctt0FqQIr9m0fOD0D72CjHnnpLIz3OMw7kZzloxUjVW7F2M0c7YjXG6ADS2UaSLUYf+ZsC9zk356eej8vE9Fhlcxo+Mx3FNX6dJvFQQi3ACENBtwLyDOEspnNM1kE/hSH+AGjK6DSQGeLLRF3RMGPy2lM2BBbYMnAvnPxV+ruy2d45T+0tsmTXNsUgqT04UaAANZ4mOiiscyT54uS48UNbD4ctOrmX4OE89KSeok4a7B/YYGteH75QRrrYH+E3pP+sg9Qf91vRH9hwPBUDeOB/IsMpZp4FNQTCWY38gmJ8a9dX52Pz/Lrb3yrFDmFBmMYlfZ09NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ueu16JvUyQ7A8UV8tRomyi7tiRmMi2XbhNn0FZw7idk=;
 b=fpWnLBgTtA0E2WvZc3Lr6X2Y33sNBIbTCxaJix2k95E9yvTyzVmwXwiciixdkpw3G8JaBzkJ2XSyMSry0rU2N4fMxQwHNvJIxuPAno6PjvRnzrF86SzcaMtY6MXb9NIrJyzL0FUZKDknKrPh93UUGLWpHt8gwudm/g3T177GOzmxgDe6gE5nEgp9Dp5JYj9YAczRPUFv0TEHlQhc479kECdpFzAKEqCFC87tgJT8ux9drtPN6uwGG5Y+ESkUO8zmSic4roQAI829DAk89TP2eHYYTSfCIuaSWxnmB8tlIu1gsSNFWFsmioUXs4rDGjDZFab+uHBj2AuL0/2ggYe0RQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by SA2PR03MB5946.namprd03.prod.outlook.com (2603:10b6:806:111::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 01:07:15 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 01:07:15 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
	linux-mtd@lists.infradead.org (open list:CADENCE NAND DRIVER),
	Dinh Nguyen <dinguyen@kernel.org>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
	Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
Subject: [PATCH 2/3] dt-bindings: dma: snps,dw-axi-dmac: Add iommu property
Date: Mon, 13 Oct 2025 09:06:54 +0800
Message-Id: <1907df9cd19df8307932898d1334fc882350a577.1760316996.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1760316996.git.khairul.anuar.romli@altera.com>
References: <cover.1760316996.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0027.namprd10.prod.outlook.com
 (2603:10b6:a03:255::32) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|SA2PR03MB5946:EE_
X-MS-Office365-Filtering-Correlation-Id: 48c7b0a3-fc94-4512-51e2-08de09f4d8fa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p2AB2sAJFRgKuXQgfhyKraYdfsARWKqhrUyzNU9HzDMaDJHVhwC+j8gqanFJ?=
 =?us-ascii?Q?7lDkW3orlbmVUq8+rqXlIlmD0lKz/jTQszyebKTJEy4iyAIIlGYkHYrBpLYO?=
 =?us-ascii?Q?8ZmyE+gp5XRnu9qa8apfCrd2QF0pConocGMnQxpXrQWbFh6fhCep46jtRDZm?=
 =?us-ascii?Q?TPUfRrzgc3Atuo0y8Yz+8YEl/BujG1+O2DZDTQ63T7aS1ASTuTkcT/JLqr79?=
 =?us-ascii?Q?iq+GvXfmSrJ3T233bdFTxkLC86MEDykj9dxeoeOt2GAkbypJpTZ5yCCKKcWo?=
 =?us-ascii?Q?cUDJ5ezF6XPaFflWMZ/rI0v8t/J2dvbq2f5NWw+LRqZ2IcB5RgomyWnB0kDq?=
 =?us-ascii?Q?MdVdRPCnG3d6u1QLE4jEAH+Xcz0d3LaIAlGb7Sm3e8x8j3mz1k4wiEQzbret?=
 =?us-ascii?Q?rk+Du24D34hcLEWar6XX6FDKUB3kmQULnh2v9Ag7GG2c2ZYW7jPCY+S7vM0i?=
 =?us-ascii?Q?jZl74ttuW/NGTWVo0RAvHOGItlBD3SdORP37+CsSaCCJrc+yAbii5wLeyZKK?=
 =?us-ascii?Q?grqHtlsIBY4gwINy8vnnkhZoS2wqE8ooIN8WQzwuSQyF+0qqPTkgj9zwAPaA?=
 =?us-ascii?Q?A9RB25Z47mQg2E38dAV9PCqGTeb/hEEsrPuS5uvrTyT9N8BuPj1fbyV9tLnr?=
 =?us-ascii?Q?YGdK+J8qPyVAWcaSg3lmGbNPsDv49kq6ULBbosZ9WiRSU1X5+QALuWnuCaZW?=
 =?us-ascii?Q?MqUjPQGxKtMabxsaiLqjsAfHh0UAHFEwMkwzLvRzzyLSOm+1mZ592Qr/DSkA?=
 =?us-ascii?Q?AqOQCsaKSviitX9/VfaRc880xkWnag9CfVFNgDV6lKMg/8NfZ32KW7S8VIn/?=
 =?us-ascii?Q?a1IX918sAidQvnaKfVI8UUWg6+IqR7Mgay9tfgljyMfo22d+/TrEfyqAdmUY?=
 =?us-ascii?Q?BVjxh1sZFQgGnNUjeR1XUsoCP0xYWiZFuOUwiQMhuoySPlo4m45vRrNX5wbl?=
 =?us-ascii?Q?8nQKUlnoboXcFoUy4sT7bVAk1SahZyRn5VVbldch1V5KkwY1QzxsHbGIoewf?=
 =?us-ascii?Q?oga+FrHwdZGF+fZMy5Av3eC8rg3mKOIKA4Gy7YfgTwEDHjxWU8Jh4uncbXJS?=
 =?us-ascii?Q?tueLDCUDR4zQGLV8j8iuWSFf24d8+Z/7t3y7j/jer4CyaQ35PGNxeTL9Yvd6?=
 =?us-ascii?Q?L71nKW/OKY8JiD8CNJ83x/05icOvhFqaQVHIkcMVsjFOEv/O9WahmZnbzerp?=
 =?us-ascii?Q?fiB3OH3eIjJTO0zOm5o5g4uXQUZwXs+7H08DQSHaawDbFK8stQHP5vb0VaLw?=
 =?us-ascii?Q?1Wp3keVDhKBsaXYsFfUxFfrLrqdBfmLyc1MDenWfDom99xNJbSuKlK+y7uFx?=
 =?us-ascii?Q?vj/H/wJSHJDdvohNSDwSZ1lYTCof1dkXCEneiSm7zeDs7VBaoeo3Aw7sOymI?=
 =?us-ascii?Q?6jmq/FU1epj79+JxRE43SRjk71slPgoVISQtNxY+HcSlFu0zJmm5V+codAQ0?=
 =?us-ascii?Q?LbFDHwUiQkp9yXEUCogoZah5gmlWNi+PuBPgTyLS6cjQ1wthek3PdOUW/OJF?=
 =?us-ascii?Q?YA3iEksVprgdqIs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D9kUjkMCrnK58QGQof8fURyh+iqkDzuBuKeucIDyXyxsU5B/pOE/rxciBGNp?=
 =?us-ascii?Q?Gm+sM3Y6l3YoXQHXd2sD5bYZRAng1iKqhsW8o5RNX3jNi/G3EMUg7ipD/oSo?=
 =?us-ascii?Q?GhU/uTd3mYkQMss0XdwtGQ++QC1PUFMAVR6iSfJVB4pjyst1jGfU4k//jOBz?=
 =?us-ascii?Q?mv7pZWXFtpQ0eLsg9K1XRoNdxOzgymZz8S47GxYz+6cDKr72tTUFe+lijqj6?=
 =?us-ascii?Q?fX/Rn8paNhSqHaYdwBuccG2z680Xao8sUKTVlXr0wefPtuNWBvF24OjjcT2G?=
 =?us-ascii?Q?/1IJ/cS5isOzejKAVtPETzd/CsZS1rvSl02RFNLjD2WpYqY3DMAfxLw24I6D?=
 =?us-ascii?Q?T8H1vELb1M/e0Fd2eygPRSAsUmZYspxP/9iQ8MScttu2RKSjLZwkV4YA4q77?=
 =?us-ascii?Q?5Zc+znqnFu1oiayAs/MDOu46BHynXeYxqVOafXWCW6ePLYQJFXEEf8HqiZZi?=
 =?us-ascii?Q?tCqc0/txaQfE7VZZVCzTwc8/CH4JjdbDKSWkO8YXtmlpS/r9/FwON8V6oRqp?=
 =?us-ascii?Q?cQTnnqF65egThvpGzXMjYCIKD1k28ArubDlUfTSOYs/23GPAjFLcufJhStPs?=
 =?us-ascii?Q?nnQlx7AkE8+1/rU1FFyJAR0td6I/YQD+n1jl3OnGZGgYT5Ih7jpVyP7kFJTc?=
 =?us-ascii?Q?8BLBQb2+Z0AZ+fsEcvXidywV3LQrIhfAyWW9BpiL+cqOZBbxE+H8Ohse57dF?=
 =?us-ascii?Q?iTpsa7jjo7U6zzd1Hqb9JDVSuxkbg/u0fyy7gq694ZcAyi/H7njLaRv4PXfg?=
 =?us-ascii?Q?Y1bP/IpR6fLjE/DXzLhGndati/kdxAvuP5lr76neHEfm0Knarr81+ihFsfSY?=
 =?us-ascii?Q?gu88xo1zsou1O4DzjVa5+dYviwvq9krj4xLvsuD1Xnh06mEnxQApb3Odr8BM?=
 =?us-ascii?Q?h7erzVS1JoZ2QOntzuCjY2xPpkYYYIkKvKFMyVS5Wuf9NgFAjhS0p3Es7p+S?=
 =?us-ascii?Q?eTBnTRGRwLHcbwvQwVF+NQE//NlNvS8SazonAvRxhTD0Ezt6CF/RQxXyVvXO?=
 =?us-ascii?Q?oGyZjJMUr8KL+L3qksQSiqzb+JjPxbENMGb+6tjGT3tN6jZjgSQPFv/Ryci6?=
 =?us-ascii?Q?JV1HTKKxJ0H/JeHa2GwWTMLsb2yxTDYqYjT6aDTxNA49gk8MzOoN4+FSDE5u?=
 =?us-ascii?Q?qv1DCnREd2r6xjuP7yd/RmgVX5AoHSWYPrqhGuR+SfEN3nGSIvDvuK4Z9ftq?=
 =?us-ascii?Q?HFM3Ke9GLQYxrb8BIQpyggSbD85+qi8aIaXcOpBTshzBpl4CZrpxhdTrfxIU?=
 =?us-ascii?Q?oz35MefOphmUfAj5OzyA1h65NqI0VLT+1HbHumN+GzZ2NNqmCzVJoC4FCgqH?=
 =?us-ascii?Q?fTmfKcVpgOBJVZVfkMWA0LRPCe4eBoMJI/OOFptnRmuL+UsyS4EVDhpmDOV2?=
 =?us-ascii?Q?LYldW6q6L9c4gmATacjtOvj1KqVzaAP+V8Wy6CJrsDKb7ayrhzuoRpSaVWxv?=
 =?us-ascii?Q?Cqlg1lVPRNmahtUJEF8ao7N9OPFtfKZZ1CzER2rWfXPqpxcj9kgbyXH5H7D9?=
 =?us-ascii?Q?rdNDkFsAsUQDd/g8S+L038nCdB4yj0LymrO5xyq6sZIHcZQfzhofUcmPaJ5H?=
 =?us-ascii?Q?39EwFmQ4exGWbfnSdezJ17039A2n4QtvtyZv4eNC3vi79nyK+pdHIqZKVSTN?=
 =?us-ascii?Q?Cg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c7b0a3-fc94-4512-51e2-08de09f4d8fa
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 01:07:15.3112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XAtkyBRIakwlmnN6Rum6gQvSZ8VnIABAvw4cNDowj0TNB7GtFHlYqfQvEvQL7+3KW6/s0wW2OkmRWuB/v6/4XtzLOdAziGr0H84zzKrjFwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5946

Add iommu as an optional property that can be added to the snps,dw-axi-dmac
compatible node.

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
index 935735a59afd..a393a33c8908 100644
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
-- 
2.35.3


