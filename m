Return-Path: <dmaengine+bounces-5494-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AB4ADB43A
	for <lists+dmaengine@lfdr.de>; Mon, 16 Jun 2025 16:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 833E91646B1
	for <lists+dmaengine@lfdr.de>; Mon, 16 Jun 2025 14:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11091E98E3;
	Mon, 16 Jun 2025 14:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="APkHC59w"
X-Original-To: dmaengine@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010051.outbound.protection.outlook.com [52.101.61.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13364217F53;
	Mon, 16 Jun 2025 14:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750084943; cv=fail; b=eMAO8VmVDRMsxc8fuCNyffa89ysoVP2CdselxW739/PLX3G5roC9HI93d9KSoMKrJV77RW0tpwGEnc8Oo8uTgpFwtURxz2LH7y9popOdiqgItRoMCmmNIh++LW4ffm62p0Uc2oro8xUZYw2MMCtq46EDqRvCuTrDnL+OHebKYlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750084943; c=relaxed/simple;
	bh=D0gTPrPgQqRNwZUsnXRXssx/ni5ewBDp5sKRBov2WXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U+CIJ+3N8pnd8UCDfBi5a/ERCDJhElexbkAxlVpxBWDsPhUXqxkE9DI2NxNVznyRsbf3RNpBmv44hyEoFy5201aqsfRORJOQmSDku51Ycb2Te5G8fwh+VSnAiCq9uxsUPSM3ysgKhIIA4zfripkkF1zzZFgewcwm9XLEJtIwBlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=APkHC59w; arc=fail smtp.client-ip=52.101.61.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KSNbqcBCvZP7qV0R9h2V5ejVlm55w5k50fm7QepN/pMykpdvIIDZ3gEJgDMg3RCLnTe1gjpaOcT5eGFFN7hPrxSdnM4WCAyznimtOz/f5BfCqapDqxIv+RQMVkrPtWABQltL2Fwo1fwO2FzK7enBuWkhiSGdM5IrqwPmAvjX+K4HVY0+v77L/gJSOGoXe+JypqVkQL2OYu2Nb+qoZJxhp1lt3kEcRhCqus5UUNqxCH6RhRhKTrHioBlmUPSiNfnX6Ofi8VxooTs3jxkBiLLaW2PkVcVeY8cZb8IkHvw6I+gTjPl6sFpDyOipfERRt321tC88C2oCSJC2zFBKFvL7ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNP60jD/0f6tAcYx3sNY7kZWKuE/s1oc8X/qv+daB5A=;
 b=ILyrRE8dQu5HDqbHcEKnd/sZatdChVl6/Un6xbctTPrmjk4k3Eu/qGEa7Ni764BcPKt0FbdWMmm5m7gyAWtRVVmodnyurlqRv6On9lTXKLVgVLCRYO2cmfk3t2F0QMR1hLWvzJ30tMVS1Zrzd1oAuFcd8j7pouIJ8bVTj76onffGC6GR9Wkg6/zyLQ9irSkfa8WRxS0g4YBWMoB4ltDB7I2lD6hEtvaMgfjymrEK35a72d4SzclCZNVxGgECPaYIqY+gTFDg5w4wPrQSC5S6nDl+Gpw6c7Uv4+rbOm1JZqiXQqUpRcarQNb5NK++qr0+z6LE8jJbyvgkiokyXMBclA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNP60jD/0f6tAcYx3sNY7kZWKuE/s1oc8X/qv+daB5A=;
 b=APkHC59wBKDebt19/KMgCbRQCziC8OxVI1UGcaP3NXJIUe2lD1BnInG7K1o3ZKbHIIf5x26tOE5DV8KsZic7yHozfWiVMDMgECX0TC5hB09wpqGSf47yq9o+ZgaijqiLnP0ExTm2Jdi9NTkRqm5Vf0vW2WI86gyjvOJmHAoULFY+K2yMY5Ts84xn3vC4PS2k2jr8zu+ZTPlQ+SfBfMXzdtL9Xzezr6Q+f4gJ9Oclkn65+xhOQZIOuRzL6xU3/GyRc9LxyeGLxfI+Yx/xCSkKMZ+cJomSJxYPt6sanoPpdiBawEdupa/BYAbuU0wQbpu4s8GcN7pTqp3kRwkVk84wBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 CH2PR03MB8027.namprd03.prod.outlook.com (2603:10b6:610:280::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.29; Mon, 16 Jun 2025 14:42:20 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::c297:4c45:23cb:7f71]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::c297:4c45:23cb:7f71%7]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 14:42:20 +0000
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
Subject: [PATCH v3 4/4] dma: dw-axi-dmac: Add support for dma-bit-mask property
Date: Mon, 16 Jun 2025 22:40:48 +0800
Message-ID: <d28a649938adec18bb0a550b28ed86b4c711cfc1.1750084527.git.adrianhoyin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <cover.1750084527.git.adrianhoyin.ng@altera.com>
References: <cover.1750084527.git.adrianhoyin.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0022.namprd21.prod.outlook.com
 (2603:10b6:a03:114::32) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|CH2PR03MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: e4d93f9c-0af1-455a-59aa-08ddace3ff99
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i2aF9vShm5kN5WBYbp2J8ZXWOzhRhQ6PAHzxqu17Npz2KmVWZ+X/spAQVwsB?=
 =?us-ascii?Q?QMaj5LTOggZg/e4zSkxXwoo2pJCQwGSJkYM9tOQ8U7R4jDlVUXabGoMlmIi/?=
 =?us-ascii?Q?6ee50C3MNvURgjtxLKuqyDP3cyq4DcLft2wG7Or1xrCk+3kAw2sx8pBMtAx8?=
 =?us-ascii?Q?N+yu+3MT7VIh9nqhgFXfFVRjtOpjmcoW8pq9S2I7D8EHuQEE6mvJBFpf3SfP?=
 =?us-ascii?Q?coHISJzG06oBMi58Vmlvh9zeWDaloqlpwKAf+VHseTApX/PGMBzUkV6C0Ouy?=
 =?us-ascii?Q?NXbAZVRdXvd0/Dv6McOcxT2Nd4h5myQ8VmwHrv1DTSGTUcPPEuBUWvff9y7E?=
 =?us-ascii?Q?5cSCp4uebSa+RCJQimytbrRM4nGzyDtbdzFSrX2fkw9YDLUQGV4kTLlxFEgu?=
 =?us-ascii?Q?2ENaHU2WE5bnKhyXYSw8ib9KahAc1wQoGkuTnDc0i+GUf/4zXZvTYxlx1/Wa?=
 =?us-ascii?Q?f1V5XIeYLqe8RLnGIAuHN1xlYnUF60z5OevcTM8l9fUZJbTQEOZbZuo2+5XO?=
 =?us-ascii?Q?k/K1Qj3jR9DiwKh3je0c/+OTPCrG+r8KI931fyEElhStdFby3sZAuwvvgxj4?=
 =?us-ascii?Q?mMx4h2l6ItWDdwmE9eLTk8TvC5H5wrx0gI/hhAy61qA5O05KQxpQJyUMvcxJ?=
 =?us-ascii?Q?slRsvRU/GKd/m5T18IcUzENx94t2I+Wsot4x1pBa8CtXyTPk7Vld/btW6iFx?=
 =?us-ascii?Q?80Anh+GAOkzvsYZBtKfC+54IzMD3IjDT68z0vNT4Kg9PabKl4J0//wxb0RFM?=
 =?us-ascii?Q?QFTHqxcyBrpv95vc9/JT0qtl7HG58UFXrsCjcMSyP0UBe/Q2gY7E/m1LmhVe?=
 =?us-ascii?Q?yMcYu7jKsCim6j1HtS2fhp68KupuoqPASye4bb4lrEDMdVEPXG2HXM62qO7h?=
 =?us-ascii?Q?l4NLISuLfpIsZtKpxwlI8w5G97oj0TQCKmicF16mY19AzxQiyrCRuIqhFOT+?=
 =?us-ascii?Q?X0Id3LBi71J2XceSn2Ncpd92G4gfAeiz3u8C2S5y0PJBMx56HlBZVYgbmFtS?=
 =?us-ascii?Q?3VvIkcMW+fGf5jKnPqqbPX0boifoJQz6lqeDD4DIVLN8giuBXsaD6L9PlLRd?=
 =?us-ascii?Q?VvD55j6VO10TkJIf4TB0awSbWqiANRL5YTPmdavVXCgpeNMdu5spmfbhkc86?=
 =?us-ascii?Q?kGvIm6CRGf5tYyGf8thHmBUxjaWxvSwWKGWnBGhzFxUGaO2JLK2LlyGzWSYR?=
 =?us-ascii?Q?/WpKTaYw2GSxkCps/6ptpauqqx8r4MMImWgu5N6thR+w96YMI7mwXz2Ce4c3?=
 =?us-ascii?Q?/d5yj+z7zp1Oy/NztUE9qwdiZ60FFIwA3o3tBARsPRr8zmLq4/Twfj+fqgUg?=
 =?us-ascii?Q?fgwqHzcNRbHDb3PvQcjqh5Ns1FlwTJyhnbbbH8Dsm5q+kjcc2KUrmkmCQEAL?=
 =?us-ascii?Q?znRgwgYGBAOZHi+Gtw2YrZ9V91AeT/caooCFyNdcBiDjdathD+9e/ugOSgmR?=
 =?us-ascii?Q?rJaTIcCTYBM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7yNvTJDioo1qXsgUqGeePZroKUxzbx3SBTuFienod7I0V6oIAj6HWjQm7Ber?=
 =?us-ascii?Q?hr0TI/ZJO+JVM40iQH/xGUhCvYtlz2I32qiI/8OCyBSMU+Ew159kQnex9W5D?=
 =?us-ascii?Q?ffFBLT1TKBJstUCxEVtZIDKDhI1NthRddbghwcthgkxCp/ph9uPWxx5qyMx0?=
 =?us-ascii?Q?jKx8EVmzWT14wRWb4M5eEtH/4xKRP8eLHH4SSH+60BQViCB3NuqtC2Wt8JEy?=
 =?us-ascii?Q?nXKVzu+imEPkOGQ+JlNypsUJOR+BYNmw27PFjpEguKT+cBzaTbW3dpET3arD?=
 =?us-ascii?Q?XyVn3eP28joFGXEzkQO2NDsxqQxEktOYkbzF+SsvmYZK+KUawdhzZhKX5M+k?=
 =?us-ascii?Q?1ya+V/DZv4xxEJVZZPWLqNKQI7YWcN7TCY4vJpJP5w56jJpBB6hDfpSBH4tA?=
 =?us-ascii?Q?W8tBTji9QykOfy+OwwbfmXHWrHikKG4e47cn+QqONAyLPYvehvFuAf6vjECu?=
 =?us-ascii?Q?trUlUpeVW/es/rnEiflJiFDNsnjTsINrX0C+FWQ+gkCcQOJmtfMg56Z/S1xf?=
 =?us-ascii?Q?FBFqL3tfJcIjGrX/ppQHhyBaNMZAqbC0qUUxhKgn+TbjIEmCYkuw1CAnGgI+?=
 =?us-ascii?Q?/osrZ9PXkHSPOklJaR11wMbZKQtMP8sxKxI7zGKxVCpX6CVfRTs53H9uVnbf?=
 =?us-ascii?Q?yXxIBBF8nDwOhsEPLrYW33fGwS8ioQuv/eLi0rv9LN0WD5CqT0bxqyFgwyDV?=
 =?us-ascii?Q?yIDlUyF1FjQuTFg1ur2443woubBm0rR9iCZ8NpjsP+Sroz6N/Hu9YSRAk00F?=
 =?us-ascii?Q?v+eNJ8KMt72HU0DXEbwCLjc0GiQMKSWnfP6ESSzGXLcnM3552qtLkExbek26?=
 =?us-ascii?Q?3qGLH2r+TZPvIRdb31405VaLWUf+lTOMhiKkJbBnZZFOn9P/mhOTEJjH2X8/?=
 =?us-ascii?Q?UglYGr6DHD5XY7485rOUDiIdz4NhlcJEGoWhkhCDjSn/GkCFeAboArAtrKAP?=
 =?us-ascii?Q?AW7xCfhI0PTaXJAF1JJdgWqAdv/FJPmTJIjbISmK2FS16ZPV7KiFfUeFUsDV?=
 =?us-ascii?Q?LpTa8rI5heMaI7+JpZknAj1iSbNb3OYgviOfbR4DquKii3DQgBTynYJN1epb?=
 =?us-ascii?Q?t2dN3MqW7s0XoRi6NuvY+7LcPhbPdLTGZm4Lyb7/Eme9mth5YKb/42rhdr4u?=
 =?us-ascii?Q?BLeJLfydR6sJsuHIm8V/PWHzzuyVBXTaQ1ruX/G19fQNEFfj9g1U01HAwhPT?=
 =?us-ascii?Q?e4RZVFy2LQMQIoqIIZSdKXPl6U57ZZUFmWWhxKAMDXf+1KbW/m2MIPDnSLlQ?=
 =?us-ascii?Q?8rDL6iPleRcGCVIDTEIcSFgQ0aJGY2TIRP87ri/lPQI3d99biY9tcKZp4NWn?=
 =?us-ascii?Q?dvdwX1PfwPV67Fixrws1gdriH+8ABTdPeXJ38JV7omz4U/BGZhxACzJ56uyF?=
 =?us-ascii?Q?kyjkYkJQGBzkGdzy2oxbB18wmMwQ4KMkuv6M6vlxBicBSZmhhtHsp3QBWLPw?=
 =?us-ascii?Q?3Ij8JAfU3/kAOkEiKqleownTovOH5fDEOpawWofunGYrR2oHsZcv3r+baau0?=
 =?us-ascii?Q?G5AvunMkw4iR1s4QU14WWQvcbP0YbDqPn6lK1o30L2JRg8V+UCkWOc+ld1uQ?=
 =?us-ascii?Q?QlrErAyaUnULGg6rrE+2gK4Aeh99yh52tPLZzl8fxSSGqdckCr7vO7lryC9R?=
 =?us-ascii?Q?bg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d93f9c-0af1-455a-59aa-08ddace3ff99
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 14:42:20.4976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4Qq6U8MKvPHNJFYzLROEYMiJ3MJGg5L17WXuks+23fO+dE49/M7vHOyRTeKDps+QpFurgsHWcyk6alsSwgFaEAUbCe4OAcDNY21/JzONvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB8027

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

Intel Agilex5 address bus only supports up to 40 bits. Add dma-bit-mask
property support where configure dma-bit-mask based on dma-bit-mask
property or fallback to default value if property is not present.

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altrera.com>

v3:
-update to read from updated property name.

v2:
-Fix build errors and warning
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index b23536645ff7..e56ff7aadafd 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -265,13 +265,23 @@ static inline bool axi_chan_is_hw_enable(struct axi_dma_chan *chan)
 static void axi_dma_hw_init(struct axi_dma_chip *chip)
 {
 	int ret;
-	u32 i;
+	u32 i, tmp;
 
 	for (i = 0; i < chip->dw->hdata->nr_channels; i++) {
 		axi_chan_irq_disable(&chip->dw->chan[i], DWAXIDMAC_IRQ_ALL);
 		axi_chan_disable(&chip->dw->chan[i]);
 	}
-	ret = dma_set_mask_and_coherent(chip->dev, DMA_BIT_MASK(64));
+
+	ret = device_property_read_u32(chip->dev, "snps,dma-addressable-bits", &tmp);
+	if (ret)
+		ret = dma_set_mask_and_coherent(chip->dev, DMA_BIT_MASK(64));
+	else {
+		if (tmp == 0 || tmp < 32 || tmp > 64)
+			dev_err(chip->dev, "Invalid dma bit mask\n");
+
+		ret = dma_set_mask_and_coherent(chip->dev, DMA_BIT_MASK(tmp));
+	}
+
 	if (ret)
 		dev_warn(chip->dev, "Unable to set coherent mask\n");
 }
-- 
2.49.GIT


