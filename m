Return-Path: <dmaengine+bounces-4532-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15835A3BC74
	for <lists+dmaengine@lfdr.de>; Wed, 19 Feb 2025 12:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E91916B8E6
	for <lists+dmaengine@lfdr.de>; Wed, 19 Feb 2025 11:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B5F1DED44;
	Wed, 19 Feb 2025 11:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MjFA0we3"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C501DED40;
	Wed, 19 Feb 2025 11:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739963349; cv=fail; b=CCs+fSNDcTMsmZknNLJuab4A+ZMZPNRpmf6RA+HisPkgnNy8iCx7LRgWILZ/AbDOfMJ+nuQye1EJZBDd+irtRxckRfzdQPtLQ5i9zwe0gQ2sTbq/eryB/I9xdG95KSzq8j2Tvt/n8vRQ5/kis4fMLVsRQ37rw/qq4x+L2B42gkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739963349; c=relaxed/simple;
	bh=ysZrdM6A+/p4JvCufvT/JRwdji9xVK3biO57X53FXhc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NSKyMgeBkbmzo6Sg295d6NSM1NYry5jUv5JjaviHZe9leKa2fkHIapWNiWVp25xcv5L2U6JfjEjOAdB/pCkUDgvjyhY26ejRR8a/9SozJG7tow2ak978EzLTTg/MC2T69PiaOYBoFU0q8uAxR6tEpzB7gC9cgvn7lLZDp5zzpfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MjFA0we3; arc=fail smtp.client-ip=40.107.212.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqQwAde42p1F87/g5yDMaEfIuA9yTfhHLBf0YtAaYmG1iA85YrQqa7L9PDyGKKkXgxtv+4WfnnpSWi+XpRMl6F9H1cCIoLK6adO4yyy8pDRPbORdceejARnlcgCsyjn9Phk1u+uLc6+ECcvUF8pQUTcUs8Y24Adf+5qPW8+DyvxXyovwwjkDB1yAQCW0gzljf2LKHbbN9n+F6E9bzCpNOLPrk7fH+aNcOkiieQwFmcId36SH0p9lk2V/QwTfEF9UTq5byaZvgTo5qECEq+R53/Lby4tslvQx3iCG8CUGb/uCp23wiD0pNEwl20iwlr33148/r597tQFVnYJQilq+eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNAx86TjvgcLrvbHSW2bPciwqa07TSNkDVI/SsvP1pM=;
 b=kfUJy7Y4cQQoTKLmPivguaG38XJM/5DABwkIY5257ZFY5Abl+9jsobc0G59Zbev+ep5ooqoo44ms5YtioSBz9MDLfUhTLM5A/QmSKX1Os3tKxGxp16eKRznlHAky6cs1lqSyIhlrhucBa1qecK/+q0pLIhsEsWMW60szwMsOH1tf5G5KjfOdtnsrRwQbnV1hcO8Z+9jLGtnaCiUogZx8KN2ehb222rn5uTCPO4CEyJylbqZ4zd+dI6gA4GQpcyj4oYqAhg/amnsiCuCSkXJUKFrjklwZE/88v2n7ZGsBoYKxMETRZvNzdq2HWdP6YsipfUa0K1p1kDZ2LXlMdM6FLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNAx86TjvgcLrvbHSW2bPciwqa07TSNkDVI/SsvP1pM=;
 b=MjFA0we3+Rx8O27o8nZa07GG6URkRH2Ec0us2rxIpeinqDiqZVLMUtW4mi7099gwZWODti9xinaV0KA9msqRXNRKByiQ0h+tLJ7xlGuA8TMnjKNGOt8Tzek10OwX43xjK2jwlG/fjZ6hXuOZ0to1dU95XaVPyeyy3nLwK7Hq8dc=
Received: from SJ0PR13CA0051.namprd13.prod.outlook.com (2603:10b6:a03:2c2::26)
 by CH3PR12MB9121.namprd12.prod.outlook.com (2603:10b6:610:1a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 11:08:57 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::d2) by SJ0PR13CA0051.outlook.office365.com
 (2603:10b6:a03:2c2::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Wed,
 19 Feb 2025 11:08:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 11:08:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Feb
 2025 05:08:55 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 19 Feb 2025 05:08:53 -0600
From: Devendra K Verma <devverma@amd.com>
To: <manivannan.sadhasivam@linaro.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <michal.simek@amd.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] dmaengine: dw-edma: Add simple mode support
Date: Wed, 19 Feb 2025 16:38:47 +0530
Message-ID: <20250219110847.725628-1-devverma@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: devverma@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|CH3PR12MB9121:EE_
X-MS-Office365-Filtering-Correlation-Id: 7592a6e3-933d-4d2f-64ec-08dd50d5cdad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W1UEa9SIavuVzDUDyBCG8q0mqt8DIHX3/sCc1vBxoLE7dK1fcW4kqlfwxImK?=
 =?us-ascii?Q?D8QxRSeuTuzP2oF/iBerjdm43rtGgW1gS5fDA9SrF1W0iK8Pthi+F5+7KXIT?=
 =?us-ascii?Q?U9325OkY+w1mKHbJpmB2E/TF+VEcZ8PFupHtFQulijZsMg/VyQ9dIrn0xj+m?=
 =?us-ascii?Q?TgPdRbFpEIsD4vKj4GhBcS2ubv8aIAtpyKDaGSEd0D0hsPtpMQ2Ga/Mc23TO?=
 =?us-ascii?Q?gJCf5vOhmT9K+1SYl/IQDOcYtsORyigCGnb2Jkah459KQ/IOnSNkEuXJFU1F?=
 =?us-ascii?Q?WnmflVCTulYK6m2+B9V+VXo5yfrc5gRV2cwmfDCOfCp41h4vyA+ucd8fT9PL?=
 =?us-ascii?Q?7TvPySP9N8i/izDQNhjSKEEqptw2csRO+yRTvEff5ItIVWPvZBvTqrN6c/tY?=
 =?us-ascii?Q?Nt2ZhewpPadU5cNgBRwWIfPgN4PbNakwcPBMwB7Ff5cibYd0PVXc6F4oZHr2?=
 =?us-ascii?Q?Ua2LMvmmLz2DsmlvYNkvtoOdjWc0B2ByiXKAlptvAWlGmGnOIRf9fQxbgEDI?=
 =?us-ascii?Q?bgHE0PY00lrXxrYiTBRuMCTyNS0UWXqLQkZP1oJn+xEX8y/azXxR1Jtcpo29?=
 =?us-ascii?Q?WV33ZWz3Kjgh6wVkdBvww3ZkrIz3I/EO9KugX7+UYYZRb1hELKCJ05nXPutM?=
 =?us-ascii?Q?K/Aw0L6uM2pGgPZ6PWdXneoGn2sEkGrcFofyozTOx9mId61aj33gLN8cYTty?=
 =?us-ascii?Q?C7wWUEPijhjpXn8wSH59w1zZKvRmpj/nHY8e+kA3mqqUKudftw9jyXrdL2cl?=
 =?us-ascii?Q?gGuE3IpK8d0mdg09A2VNavLCQcrtrZ6oCljs/WjbtKE5mHqyB65i2uaQzgEi?=
 =?us-ascii?Q?phAg/lpMDpR3R+bWdtYsMe0gaI7NJMj4oWnUBouUeNhxercMjRUDUX/3PUTy?=
 =?us-ascii?Q?tBPlenEjAkt9kQi41F47NveO0F4XolSaOkGY0eHwfi+cO1vT2DMJEWhgzm0w?=
 =?us-ascii?Q?qHaIpdfn2tFv79S4BKQj8NK+qD3kvaWWDRjRhehMiUqWFWsySrnOGswG603c?=
 =?us-ascii?Q?71DIqnmPGi7eItfSJCCcZCPlCnQyvQzqI2QN8xPlIZ/yDVZSZdS50cKUdQq4?=
 =?us-ascii?Q?nu5nmHDv1OfJI6L14K39iwKz+tqcMcZvlfWOgYbnTwmL1Aw82LUqQW+ZRQII?=
 =?us-ascii?Q?7bN2hpT/UONyGd6VG7cRcpFh4XPRoZiRBTjppUIXXWo7WVHuvijbnXJvQN5M?=
 =?us-ascii?Q?tS245AwoqavMUqgOsxZDnhWjd3yIGQHI+AVcdVMiBtT/XKa9UZg/t43qJMt2?=
 =?us-ascii?Q?cOldVqzkveeCLb8L0PQezAg46i3yML90Ia26gftQFlCmw0nkD4wMVbdbQxWP?=
 =?us-ascii?Q?0VPQIFDdL02v+EPXqgoe1B0chuyjpEnQ1ufFpaDz2T15RtnKyJNwZzqXz3dM?=
 =?us-ascii?Q?gloT+OhtiES9hOy0M1iaw3LIRwu1Vcpes5PrMwUAowfLTCHlNXwPUpGw97Kh?=
 =?us-ascii?Q?Wt2yibjIniOfONSPTx16on2LyZsZB4QPkwYcVhNijaxCt/9ZdIt5dRDHQGXj?=
 =?us-ascii?Q?8e5smwdIw5jmXlc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 11:08:56.3708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7592a6e3-933d-4d2f-64ec-08dd50d5cdad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9121

Added the simple or non-linked list DMA mode of transfer.

Signed-off-by: Devendra K Verma <devverma@amd.com>
---
 drivers/dma/dw-edma/dw-edma-core.c    | 38 +++++++++++++++++
 drivers/dma/dw-edma/dw-edma-core.h    |  1 +
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 59 ++++++++++++++++++++++++++-
 3 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 68236247059d..bd975e6d419a 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -595,6 +595,43 @@ dw_edma_device_prep_interleaved_dma(struct dma_chan *dchan,
 	return dw_edma_device_transfer(&xfer);
 }
 
+static struct dma_async_tx_descriptor *
+dw_edma_device_prep_dma_memcpy(struct dma_chan *dchan,
+			       dma_addr_t dst,
+			       dma_addr_t src, size_t len,
+			       unsigned long flags)
+{
+	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	struct dw_edma_chunk *chunk;
+	struct dw_edma_burst *burst;
+	struct dw_edma_desc *desc;
+
+	desc = dw_edma_alloc_desc(chan);
+	if (unlikely(!desc))
+		return NULL;
+
+	chunk = dw_edma_alloc_chunk(desc);
+	if (unlikely(!chunk))
+		goto err_alloc;
+
+	burst = dw_edma_alloc_burst(chunk);
+	if (unlikely(!burst))
+		goto err_alloc;
+
+	burst->sar = src;
+	burst->dar = dst;
+	burst->sz = len;
+	chunk->non_ll_en = true;
+
+	desc->alloc_sz += burst->sz;
+
+	return vchan_tx_prep(&chan->vc, &desc->vd, flags);
+
+err_alloc:
+	dw_edma_free_desc(desc);
+	return NULL;
+}
+
 static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 {
 	struct dw_edma_desc *desc;
@@ -806,6 +843,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 	dma->device_prep_slave_sg = dw_edma_device_prep_slave_sg;
 	dma->device_prep_dma_cyclic = dw_edma_device_prep_dma_cyclic;
 	dma->device_prep_interleaved_dma = dw_edma_device_prep_interleaved_dma;
+	dma->device_prep_dma_memcpy = dw_edma_device_prep_dma_memcpy;
 
 	dma_set_max_seg_size(dma->dev, U32_MAX);
 
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 71894b9e0b15..b496a1e5e326 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -58,6 +58,7 @@ struct dw_edma_chunk {
 
 	u8				cb;
 	struct dw_edma_region		ll_region;	/* Linked list */
+	bool				non_ll_en;
 };
 
 struct dw_edma_desc {
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index e3f8db4fe909..0d5fdab925fd 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -225,7 +225,56 @@ static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
 		readl(chunk->ll_region.vaddr.io);
 }
 
-static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
+static void dw_hdma_v0_non_ll_start(struct dw_edma_chunk *chunk)
+{
+	struct dw_edma_chan *chan = chunk->chan;
+	struct dw_edma *dw = chan->dw;
+	struct dw_edma_burst *burst;
+	u64 addr;
+	u32 val;
+
+	burst = list_first_entry(&chunk->burst->list,
+				 struct dw_edma_burst, list);
+	if (!burst)
+		return;
+
+	/* Source Address */
+	addr = burst->sar;
+
+	SET_CH_32(dw, chan->dir, chan->id, ch_en, BIT(0));
+
+	SET_CH_32(dw, chan->dir, chan->id, sar.lsb, lower_32_bits(addr));
+	SET_CH_32(dw, chan->dir, chan->id, sar.msb, upper_32_bits(addr));
+
+	/* Destination Address */
+	addr = burst->dar;
+
+	SET_CH_32(dw, chan->dir, chan->id, dar.lsb, lower_32_bits(addr));
+	SET_CH_32(dw, chan->dir, chan->id, dar.msb, upper_32_bits(addr));
+
+	/* Size */
+	SET_CH_32(dw, chan->dir, chan->id, transfer_size, burst->sz);
+
+	/* Interrupts */
+	val = GET_CH_32(dw, chan->dir, chan->id, int_setup) |
+	      HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK |
+	      HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
+
+	if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+		val |= HDMA_V0_REMOTE_STOP_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN;
+
+	SET_CH_32(dw, chan->dir, chan->id, int_setup, val);
+
+	/* Channel control */
+	val = GET_CH_32(dw, chan->dir, chan->id, control1);
+	val &= ~HDMA_V0_LINKLIST_EN;
+	SET_CH_32(dw, chan->dir, chan->id, control1, val);
+
+	/* Ring the doorbell */
+	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
+}
+
+static void dw_hdma_v0_ll_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma *dw = chan->dw;
@@ -263,6 +312,14 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
 }
 
+static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
+{
+	if (!chunk->non_ll_en)
+		dw_hdma_v0_ll_start(chunk, first);
+	else
+		dw_hdma_v0_non_ll_start(chunk);
+}
+
 static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
 {
 	struct dw_edma *dw = chan->dw;
-- 
2.43.0


