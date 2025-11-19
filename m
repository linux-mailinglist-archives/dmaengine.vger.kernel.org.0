Return-Path: <dmaengine+bounces-7249-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3210DC704AA
	for <lists+dmaengine@lfdr.de>; Wed, 19 Nov 2025 18:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D83105022FB
	for <lists+dmaengine@lfdr.de>; Wed, 19 Nov 2025 16:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AF435E549;
	Wed, 19 Nov 2025 16:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hJD0S8B7"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011002.outbound.protection.outlook.com [52.101.70.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D778234106C;
	Wed, 19 Nov 2025 16:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763570011; cv=fail; b=LXeI3VMEOVc2B0rfJPyFtlnLGGUKCkpwDfWWnSYy6sTS2CFUrOl8xPhRuH+/3Nk4F3HeE/sGLfjJ1/FhvChCotbv9ILSV/7g7h6CeCUJu8wP5MeLRRcb/4RVzLRXai00Vl0a6PJVQAgoAauH7NOdCdCf7z8EHJH4yrI6DVDug0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763570011; c=relaxed/simple;
	bh=f1Mq44fOzFWC5+Lgme1Y+ukzyzBVxbaVhSh7qWrzHSA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BA3fpNH/OZpManOBUkHS89PIXj9+5C6ztz5ZKKY4X3k/1Zc0WtxosJy75Lb6j9VBD+rFtRcVAZqw+wGpuP+4+d4UCcdTOXc7W0ucPV8Bz6cpIAp65H6OMz+WH9Ne3Gu4HKyY1mDGZ3tkPQmopFcab3cE81UYVe246B0gWTog7mA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hJD0S8B7; arc=fail smtp.client-ip=52.101.70.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ih1lRP3hbQGjQsSRJLwUZRYiuIaGLr+G2KZPrYyb2IdLiQqs12KF54SzBNOl0Ob/SwAo3ZTnwp1M9eEdBRn6e+Jc8d5/Y09MXn2ZId2wNjX//e8DM47L+kLsQIUKw13E8RR44ErC7FFcTmq5f9jhee5bdQFZf5+4K5R7wwvmqRIjGeB1ZgEMcCNYk5MT+yAgk/nF2jvJORzKc8g+ESrnAoXyPZgcUVISxJsDVv5JoS7yiaCA/seIpY3B4PuDhhbi4TAkVvgKmgTCYjI0jfPGzdsHwGfGxPzGp1O1coTYjyxP5rI11f6GfSaTmXUKnY4TAMQOo5gdSZhQrnIRZKQ//w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZXoets+WyFNkfeu+/X4TGNrWo6kl0UMrlfkHaKu6cg=;
 b=RpFtUprqnpHEpycKhH4oLcwXIkJyV+0zfQeTQ4Iv00QhFWHhX/TYaIMzPBuqh3T2utuqMCCT1cadVKoSFJ92Azi7egKJm2bGE1WEzxPWxTl8RQoeN+ghW4UmK5JTatPcTKgP+6RAjII3J061yl0/8tvIPJQWupxh2Kxp3SA+5xnKNCv4T5vlBy69uXiAJ7YhVJlTEgqy6vKqvZB+dtGTofg/YeRv1zZorLQGR3yW8T7qdGDMX45zU2utZOW/n636ive6nmJQmGMhtV1NK4Ziv9VCfQW/ZFkBe1/nqVwDHDQWByuxmhDZaOrgbWc2hQJaORO7wdeb/OZugLjYYVU6MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZXoets+WyFNkfeu+/X4TGNrWo6kl0UMrlfkHaKu6cg=;
 b=hJD0S8B7IZNoZoWQCURPQRH7xe7viqzNOwRYEvTebQbZ4iPInYPz5cLA1MfiIPux0gY1j/fgEdQilghhpDad4qUqfu/YYaDZt4aUSc0CN3F6bQPoSS2oVqWeY4MmH5/56dkUbqybUv1X8MNWFtvBYTFLy4QYQjHDmZn3X9AnFyvwTBIjZDTZu0ve0bWvy+yRoMC7I2SCh4/JXLNtkhne7aydcncSPP2LV1GA3Dn1hxnTguBlTptN3++9DT6+VWNjtTtQ/zA/Qndwt1il7Pt0pcn8MjAOtxU7ydJoJrWbPEglpOnJAvyIIqPRfZm8J54HeaYKLAnl+s/Jqvqx6mK1pA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by AS8PR04MB7829.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 16:33:25 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::b7f2:1d0:6b6a:ba58]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::b7f2:1d0:6b6a:ba58%6]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 16:33:25 +0000
From: Han Xu <han.xu@nxp.com>
To: Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Joy Zou <joy.zou@nxp.com>
Cc: Han Xu <han.xu@nxp.com>,
	imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: fsl-edma: configure tcd attr with separate src and dst settings
Date: Wed, 19 Nov 2025 10:32:55 -0600
Message-Id: <20251119163255.502070-1-han.xu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0072.namprd07.prod.outlook.com
 (2603:10b6:a03:60::49) To GV1PR04MB9071.eurprd04.prod.outlook.com
 (2603:10a6:150:22::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9071:EE_|AS8PR04MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: e91e443b-b152-45b6-2652-08de27895c8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v/zymt+zZ5nilDoATa8buG8pyUi/nO1ZcOQSTjswNhjrhrHEYaSNcm17QtQo?=
 =?us-ascii?Q?HD2v3xefajkf+vznTcSXSLkqGq1EfnM+2slfeB9K72QEMfwKUQOHKy/eHUZE?=
 =?us-ascii?Q?yhPD2VqaiGbV2JGnldNY0++rN24jkWyYumwMq4WHCSStYufH8mT3NPbgjDfN?=
 =?us-ascii?Q?BRTxzU2o38Ju79XVekIbvHAIQgDd48Q+VbuyqB3Ja6UTjTO43APO161p86JA?=
 =?us-ascii?Q?A4vSuo+G8OfMnFYAUU+l2cLOvBuiM6creACkz2Xg0b+l1tdmF4OjR6hsi6uH?=
 =?us-ascii?Q?UInYDEbHiAmRe+EdjvOLHiE8iXF5C5IE1PUmRTqZbABAv8xOTEfR9OrLf5py?=
 =?us-ascii?Q?2Drc6j0xZjWy8wBCzrrjpVZyeLeCYTJ/GS+B1JfJN4c0G9bBQi6e9CYCdJtV?=
 =?us-ascii?Q?wZKNl1GKYBbfQ9HK/0f2IjnyGgwpTgngvtT+8jHGaCPCCK/vAQ40wigBoPnS?=
 =?us-ascii?Q?bgtha2lwaMA72vlXlA98d8of812XtIq8/SuLbxPy8QmvHefq/DiqS6UgkX72?=
 =?us-ascii?Q?OT7sUhWRnXXtCHP2zIaxRFhgNOGhQtzBB7J9DDklBa9DiTrkArNSEIR5Ld1W?=
 =?us-ascii?Q?94pjrhl6B4Y91gSCA/luv/AwcHGUTGvd4uQB1Ta/AEgG7XxHi3bgVgCiKV6R?=
 =?us-ascii?Q?Tovo3dOnzq4yhjcidau2gD/VULtq0Jth7Het8gV5zKOQby48iAXtnv+wbih1?=
 =?us-ascii?Q?HvBQrfoRzohAU+4Fli6Rwu2SOoy4hSWXanMEMoAwSWDApW0X2IpgbA0XS5D0?=
 =?us-ascii?Q?TDWAphRHArx5wLS0pluU37BBAdcvXnBuaJFeD/KJ9t+r+zhTTISVe7N2GCX5?=
 =?us-ascii?Q?fBT+Y2Etgm4a6vxafrEjeBswTCiwqK6FGQ3Z/HQdLEw+dQwj2iFVFShG6Kwn?=
 =?us-ascii?Q?2IY7BMsByMrnebQZ7zMuNE85vkK10TGiJOyTXhPnF9sN0vpz01qfHQs491b2?=
 =?us-ascii?Q?wAhj0Q/BBzzaFI4Ps9GcKVSrogaQOi9+bkvZELTQ4aXR9N559Ge9jF7Rf1p3?=
 =?us-ascii?Q?ny9YuTM6mnW9mhJ3abi9z5u4KWOI1jz0GvaANq16hk/lYffiUuYuCwGqxuto?=
 =?us-ascii?Q?C/XSFoJjiwg8P4W4DubygqrNG9sEiVLTue66b0Tr0PXXVGc5xsrgPBUf7Z/P?=
 =?us-ascii?Q?NxLdoOjfhhO2G4m5xa3NHca9fo8GEgDhp1pndK/cOpEziuOWyIWAJhOEB5wF?=
 =?us-ascii?Q?IfSvH3811VrjYO8nsr4BwrEYACggftunhTkb+89HYE8LAk6XmykYbpb+wTcg?=
 =?us-ascii?Q?RB8ka9iam/FEY+7tGrs4izRan0AIib7HM2sn+kpBrggxNINyQvvWJYLfAmoX?=
 =?us-ascii?Q?3uJVmhQLrZsbQE8djQ5lHywKpWPnCTr50vi8PqYJyWqGT9HUTWaIpgf7LRBS?=
 =?us-ascii?Q?iU45D2YO1zCNgMQv09Bwi/ci1Dbo42pEIubKscJCK8weuUbx0L4TZOvIgUyz?=
 =?us-ascii?Q?ZOxODZhtZJSRe0WNwhblpsMiVpMPGgJC8aqNRy5q/Du9xO/DGjXSvqGxNGAT?=
 =?us-ascii?Q?i4pbopgV13bqmmqySkjTz9Qm23OKMgujtX49?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AhqrNeGO/it0iFRNS0r14yPKCvf3YMJ9ocuSCPXMII8HaGsMVRDcJC5LdyeD?=
 =?us-ascii?Q?P/Ty0SmHpD3A4gwMjv9AaUUBF0VQqS0jpr2AsQtDcghKKZRC41H38Bccw9kj?=
 =?us-ascii?Q?Ckct2gBIttMQVRsWRJvmqQdB/mkP9CUk4HM8zvh1t18NCAcVDLauW8zoqwaM?=
 =?us-ascii?Q?eajOalBOJCncvgvb17H1HU6of65Biqhwm2qNCXQo7QozkAOZlnA7BXyW3DxQ?=
 =?us-ascii?Q?GGUk0CnMne+LWa3pGSIUhc5QHh6SW7rp7fMeUIt/ZcXcK9JPvFMMSCqfgELr?=
 =?us-ascii?Q?sDdah48kv922EKt2sasf3oImPITGv17GIh1G2JJ7VxPX1UwdtJgP3iQzKPQ0?=
 =?us-ascii?Q?Zll1L+PcKLPAMmaMJsXGyAIEZlsj9y9gwixpvom01ybeJoQVOq83udqA4X4J?=
 =?us-ascii?Q?dHJIPiIXqkdiQDiNwlcTkoiTRSrkMEn1njTyRdqsYXgs8YapBVBvcI1S3BNA?=
 =?us-ascii?Q?ccHYf9CjD9ntn2kudD1rua4eKfTzF0OytfFR7m5OhBy1x2Sru+LUMmpzQVOT?=
 =?us-ascii?Q?Y6ZyJ0DUw3/jEjNscbkQ4SlG263hSeGi6m0U8rcYS/YthU7gYUT/txu7mHOu?=
 =?us-ascii?Q?lJ2zRvNfbTvgEm7XyYQ2Hqep4oVxC/JlYbpv41dyoK6yL24zRc13JTIkM17Q?=
 =?us-ascii?Q?83HJu+E124ah25dWblYRL0FnU0HAvhyncxiThEcOQbeaGDosHNFLiZovdRf/?=
 =?us-ascii?Q?gtmWLkfryPvuqwDwl+ACFn3xcSf4tTxG7piSdtVraeXVrYfvQR0x2zpO1Aw9?=
 =?us-ascii?Q?pYbck0m2dsb8SnX6vbISnBGzOLWbIEfoaTctD/p8+byHzcxoXwjjRnUkakQO?=
 =?us-ascii?Q?Bb8wVqhHDQ8fNYkwZGg51aC5k0Q8pLLkE1q37M67q+rrq3L8swXjgPZyAMJK?=
 =?us-ascii?Q?r5yLDONTg3dqW4kKofkIWmSwVTtErkPQwX4rLIyOZg9v2vxWoDziP1MOb0Np?=
 =?us-ascii?Q?dhbGHaLwNQmE3xeul2XA8oHhjwZ7nPxqX2yoeBMTuuAj1Jb4C6VXpSpDaMk1?=
 =?us-ascii?Q?GfIq8iym9Yn8Fuhl+4bQxuTurQoQ4YsUjK68EiVA4hR8F/JJFK/euDJAbWsF?=
 =?us-ascii?Q?gXgdNrnq93B3HfOHwmhnuRqXk55N8YAQH+rAoGaUEA5MQl3yglAG6O61Xs/8?=
 =?us-ascii?Q?AEXcollmniMy7A6HKV4v17fEJoOSNMBfI0TlVYpnMHgbSHvASOkIKn/R1cUy?=
 =?us-ascii?Q?fRQpaFIZizsIdRzlJs0Xia1loHtaY8/8AH7VetdJ+Ore/i+AIMDqTVWGPhto?=
 =?us-ascii?Q?hTpcNZcH6RbCD53SAbTxpb51NiVkPaWgiX03/B1JTqDnZTXoBCZE4EhKvAat?=
 =?us-ascii?Q?+73bFK6jsCt6/V3Vl6cRe5PjcNOm43eG1bgtNbsQX53g8s3/8FHUE/Y3Qmwl?=
 =?us-ascii?Q?9WM7VNNWVXDI0K+NDqwbriOqTfYOqRBfltBxwWOPfWGwhNl5IQbuCUMNmmKL?=
 =?us-ascii?Q?A0BbnZXp5WG+0Nci2Zwg50Qj7ERfbusCOTiG9yf7f55rRD3P2vft3c68GWSP?=
 =?us-ascii?Q?kOXcBGtnLffmBz+UOP0puHvEyd6BIrpz3dBx5WM4Pc4DVr1wud6LGYDMW6AF?=
 =?us-ascii?Q?kzF2YinemhofpFrSzhc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e91e443b-b152-45b6-2652-08de27895c8c
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 16:33:25.3020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TRlQOvCTHiy/eMo0LGF99adnJevBeF1iSEOwrGMd9lpaQ30JDdaAOe/0liuH+24V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7829

Set the edma tcd transfer attribution settings for the src and dst based
on their respective dma_addr values, to remove the previous 32-byte
alignment limitation in the EDMA memcpy function.

Fixes: e067485394328 ("dmaengine: fsl-edma: support edma memcpy")

Signed-off-by: Han Xu <han.xu@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 45 +++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 4976d7dde0809..a592127580299 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -206,15 +206,19 @@ void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
 		mux_configure8(fsl_chan, muxaddr, ch_off, slot, enable);
 }
 
-static unsigned int fsl_edma_get_tcd_attr(enum dma_slave_buswidth addr_width)
+static unsigned int fsl_edma_get_tcd_attr(enum dma_slave_buswidth src_addr_width,
+					  enum dma_slave_buswidth dst_addr_width)
 {
-	u32 val;
+	u32 src_val, dst_val;
 
-	if (addr_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
-		addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	if (src_addr_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
+		src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	if (dst_addr_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
+		dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 
-	val = ffs(addr_width) - 1;
-	return val | (val << 8);
+	src_val = ffs(src_addr_width) - 1;
+	dst_val = ffs(dst_addr_width) - 1;
+	return dst_val | (src_val << 8);
 }
 
 void fsl_edma_free_desc(struct virt_dma_desc *vdesc)
@@ -612,13 +616,19 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
 
 	dma_buf_next = dma_addr;
 	if (direction == DMA_MEM_TO_DEV) {
+		if (!fsl_chan->cfg.src_addr_width)
+			fsl_chan->cfg.src_addr_width = fsl_chan->cfg.dst_addr_width;
 		fsl_chan->attr =
-			fsl_edma_get_tcd_attr(fsl_chan->cfg.dst_addr_width);
+			fsl_edma_get_tcd_attr(fsl_chan->cfg.src_addr_width,
+					      fsl_chan->cfg.dst_addr_width);
 		nbytes = fsl_chan->cfg.dst_addr_width *
 			fsl_chan->cfg.dst_maxburst;
 	} else {
+		if (!fsl_chan->cfg.dst_addr_width)
+			fsl_chan->cfg.dst_addr_width = fsl_chan->cfg.src_addr_width;
 		fsl_chan->attr =
-			fsl_edma_get_tcd_attr(fsl_chan->cfg.src_addr_width);
+			fsl_edma_get_tcd_attr(fsl_chan->cfg.src_addr_width,
+					      fsl_chan->cfg.dst_addr_width);
 		nbytes = fsl_chan->cfg.src_addr_width *
 			fsl_chan->cfg.src_maxburst;
 	}
@@ -689,13 +699,19 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 	fsl_desc->dirn = direction;
 
 	if (direction == DMA_MEM_TO_DEV) {
+		if (!fsl_chan->cfg.src_addr_width)
+			fsl_chan->cfg.src_addr_width = fsl_chan->cfg.dst_addr_width;
 		fsl_chan->attr =
-			fsl_edma_get_tcd_attr(fsl_chan->cfg.dst_addr_width);
+			fsl_edma_get_tcd_attr(fsl_chan->cfg.src_addr_width,
+					      fsl_chan->cfg.dst_addr_width);
 		nbytes = fsl_chan->cfg.dst_addr_width *
 			fsl_chan->cfg.dst_maxburst;
 	} else {
+		if (!fsl_chan->cfg.dst_addr_width)
+			fsl_chan->cfg.dst_addr_width = fsl_chan->cfg.src_addr_width;
 		fsl_chan->attr =
-			fsl_edma_get_tcd_attr(fsl_chan->cfg.src_addr_width);
+			fsl_edma_get_tcd_attr(fsl_chan->cfg.src_addr_width,
+					      fsl_chan->cfg.dst_addr_width);
 		nbytes = fsl_chan->cfg.src_addr_width *
 			fsl_chan->cfg.src_maxburst;
 	}
@@ -766,6 +782,10 @@ struct dma_async_tx_descriptor *fsl_edma_prep_memcpy(struct dma_chan *chan,
 {
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
 	struct fsl_edma_desc *fsl_desc;
+	u32 src_bus_width, dst_bus_width;
+
+	src_bus_width = min_t(u32, DMA_SLAVE_BUSWIDTH_32_BYTES, 1 << (ffs(dma_src) - 1));
+	dst_bus_width = min_t(u32, DMA_SLAVE_BUSWIDTH_32_BYTES, 1 << (ffs(dma_dst) - 1));
 
 	fsl_desc = fsl_edma_alloc_desc(fsl_chan, 1);
 	if (!fsl_desc)
@@ -778,8 +798,9 @@ struct dma_async_tx_descriptor *fsl_edma_prep_memcpy(struct dma_chan *chan,
 
 	/* To match with copy_align and max_seg_size so 1 tcd is enough */
 	fsl_edma_fill_tcd(fsl_chan, fsl_desc->tcd[0].vtcd, dma_src, dma_dst,
-			fsl_edma_get_tcd_attr(DMA_SLAVE_BUSWIDTH_32_BYTES),
-			32, len, 0, 1, 1, 32, 0, true, true, false);
+			fsl_edma_get_tcd_attr(src_bus_width, dst_bus_width),
+			src_bus_width, len, 0, 1, 1, dst_bus_width, 0, true,
+			true, false);
 
 	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
 }
-- 
2.34.1


