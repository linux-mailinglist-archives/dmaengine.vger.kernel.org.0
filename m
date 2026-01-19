Return-Path: <dmaengine+bounces-8370-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 501F0D3A27A
	for <lists+dmaengine@lfdr.de>; Mon, 19 Jan 2026 10:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D194930028B4
	for <lists+dmaengine@lfdr.de>; Mon, 19 Jan 2026 09:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BBC33ADB9;
	Mon, 19 Jan 2026 09:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dwvpqYfq"
X-Original-To: dmaengine@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012067.outbound.protection.outlook.com [52.101.43.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7459729BD95;
	Mon, 19 Jan 2026 09:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768813827; cv=fail; b=LhkgoACz86IgQsLzHDgfBsjORjT4cp3I7dUvZSPbZ/dikodqg8l0DFh5K3m3hkL4k0MlyCcP5O9z41WVcf/k9BkLhj05WiBMgxrl6DIQpHW9AzeCj0COEI0LrcHZee0yHfHs+0jxvdPj9wCEhUz2xi2ARd4TRTjryi+BCW1FYJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768813827; c=relaxed/simple;
	bh=bVA5ErMI5oIJCUcMQdA5rxxsW7PwfUReIkR5ME5aq7g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VTZxNNnhboSIMhE3gBclNKYEi2ItOxYVIFqknAgcKp/CsAMSXH0BIdU1yzMXm/YrVF0hPEmRfjHmnWicsVo7rPnYruESOzw/5IHUhCu9rS5RqTUROSW5QG1DVfIxPWeBoaKJ5oYejWzbM00c4FLREgFaxaljQRMRDJ/nPzi0N3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dwvpqYfq; arc=fail smtp.client-ip=52.101.43.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HUxwVBmj0M5jmdfq9mUCh79UnTR1qRMljMMnq5fHsbbkTRYYZY9I2+NkrNd8z8Mz+o787n8DuzDK4goHU0cyUe57qjb7YoQKDE68YWCgEWi+nMys5t8yO+wNv/8mGKXBDw1oJlTcVePJiWNm2Jv0Irv6m8mq3OubRGQ0ePeNxghYFi4lmnt1GJiAej9Z4tRCHr4S2SCkP6lGW9n3xbRgvjn+gGxjdvMCEXoZB76FHMrKspIyywtg4ZXrk/cpVMan4bpFCgLD7reoSfoE5WqYQ7Ij/VbCdnhLqVrwfGeN3Dq5tNeRHWWtvSBt/C+oZqILhhEcTkhk5KrmIVak6JUTyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t12osUwb9sEPd/o/1txr2eAZbJ/KSN5y1keap9ik1cQ=;
 b=aeQeIsyr1Eko6RdZGF/9yFY/4oeKvsCSPiY/4STJ7vTl0qNuMtvn5dvvelB7EXyktEWRAV50+9LCDKNrIhb5Vn2VMC4jAEpn9iTM9m9TKnhCxZF9HrcCRYYrx4prEJCFPiM0OXTJ2zOkUjbvbaGe15bO2TMSc+dERTQQ2PXQJ7KOt24KK+MQekTli0JZxLqtpBao8v1jjLTYBfV/bdwxCOhvzObUp6GErdwojyhPt1RyE5yNXqlsf5by9ivEDqRtN42BnyD+jx46RYPpgzSjcVEM5bevUAzJntBqUunskjntyIV2p2Skd3MeNIrsxYwse2wvYxoFwN3K0FZUzGrUFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t12osUwb9sEPd/o/1txr2eAZbJ/KSN5y1keap9ik1cQ=;
 b=dwvpqYfqqq3k2kUC4Vp5R26xlSxTn6ZYoi2a5keypCtWzSBMqbeQ0P7vduAJCi+1sIbjx+ABA8eOXH5nJXZ/ZAkTE8gCUQyZKXveFWYCIcQXwycPgBAFDDw6GeYGf8r5bTTnOHXcafnLP2fUZ2tdF66VH7jrysdesBscSMpuzak=
Received: from BYAPR08CA0053.namprd08.prod.outlook.com (2603:10b6:a03:117::30)
 by IA0PPFB67404FBA.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Mon, 19 Jan
 2026 09:10:19 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::61) by BYAPR08CA0053.outlook.office365.com
 (2603:10b6:a03:117::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.11 via Frontend Transport; Mon,
 19 Jan 2026 09:10:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 09:10:18 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 19 Jan
 2026 03:10:17 -0600
Received: from xhdapps-pcie2.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 19 Jan 2026 01:10:15 -0800
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<Devendra.Verma@amd.com>
Subject: [PATCH v9 2/2] dmaengine: dw-edma: Add non-LL mode
Date: Mon, 19 Jan 2026 14:40:09 +0530
Message-ID: <20260119091009.70288-3-devendra.verma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260119091009.70288-1-devendra.verma@amd.com>
References: <20260119091009.70288-1-devendra.verma@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|IA0PPFB67404FBA:EE_
X-MS-Office365-Filtering-Correlation-Id: 29b06a19-6a9f-445d-8586-08de573a90d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WfvKis2JHY+Z4sF32EQsElMTNTPD7h6tbw5Wefo3tkkowud5/szBZNHhEpr8?=
 =?us-ascii?Q?FQwdQLpQ9OXYjmBnzgvDgMd2RI2KT+GboPzrWi3VExvRhjLgqm8t3sVCShei?=
 =?us-ascii?Q?ox4MCq/iAoVQ/qSlOfIjs+bXIj22ONHczWMwWTudPD8m5/WOIT3f8phAAdwE?=
 =?us-ascii?Q?xp2KnE/bQoUg2IDzfdN8cKEAJjzf2xytps+9glbMoNAod6JqQYldG2yaMjF9?=
 =?us-ascii?Q?1tdAQq6OSux9OzXFOEVHSji+m7Bp+OvMEFvJGsZ2vN+fqu31A+GQww0KZa9y?=
 =?us-ascii?Q?CHhOBHNRWpLkvBCuqLiJ8tNKvE7W960G1JRNlWzyMgVSCJFkHhMTlnzPpUw+?=
 =?us-ascii?Q?Q/HN4JC2IMVH8H9m0gtYaHkc0HtlqwNQ3Uy0d8RQxIVJQsYBZ7lE52Ot+tDC?=
 =?us-ascii?Q?6EcMnvLyzoMDh3iI2wN3ZoL1exlYJn9AM6DzqZjhwdwmGXjZ5k7eAbTxRA8d?=
 =?us-ascii?Q?Hw+jalcaUCw9XORaoyesG4khYXCCVhRRfKvoFCMkHqeCe2Nnx52qGAGwnL9I?=
 =?us-ascii?Q?wQFsEWdH1jpHDHLRXaslLGZR9wnYcCIGHLS2KG/LSUzVAT1AF6AKJmFmsxtN?=
 =?us-ascii?Q?nIqi4YDpSUFQkSJsnejSN/tBgLXjLaJcJixskVeUp9QIwNwu7hTUZY+UmE8D?=
 =?us-ascii?Q?bsW1MhLoFpiRS4e3a/6PzSltr4sr5nUlYh0zFeHm1OiChGXlGstznCbWyU5R?=
 =?us-ascii?Q?WJsxDvSd97emZFFFIUCE5pwdJ9unaoU7zTEtBmqHxX3ApMBzdty5fbv0PedU?=
 =?us-ascii?Q?scLG92//8f02y4j8ciqMl6XqlchMel57Tdq3DoG8wjaVv0NsQm5YD9GwNZLI?=
 =?us-ascii?Q?HoXqNKFqTFAPWbRXoNyWQ3SIm2lc4H3Akm0g86MEleU2Ug7mQDcncvLhO9+9?=
 =?us-ascii?Q?T5tM05T8g1XjMnS/DOFDGHAwTbfaoo3DWtk0dVgC8OOcypVhZIQdVMyeB8j2?=
 =?us-ascii?Q?mcwdClZKVkn+sHqO/gTdx/2DIgmsAZV9B41yN0ueyQBrRTuZA6kbVSS20YcE?=
 =?us-ascii?Q?FMPQXzuMpLiicfSRLKCOO0JvAK+WcO9nd+6kz/dZtp+rTP+BkHte9J6dwcnw?=
 =?us-ascii?Q?VozcDdlyn8Dr8gg+YAQbrAt3nBVtr2HYV4KqsrHQHte/2+as1X6H6GiMFAic?=
 =?us-ascii?Q?2aAJ8NkjDFrpD3CIUc7cTlAa3PNZbYUrhe5zZ49y0iZYZBegnDlZr1c/+Y6q?=
 =?us-ascii?Q?9UWEEsxUfkR+80S7s3bckBwD/1+Vtgk4SFhCQ9LhbjUCELzM1Sof2iE6uXhk?=
 =?us-ascii?Q?CqqXk/2olzO1Py9BKzcbwwdtAR7ZE0Xo/DcsJptEGSYyDOprthxEK8BSdzkv?=
 =?us-ascii?Q?Zd9YIpb7Hd47YajYxpfrGrYOh9q8AaAf02WIjd8vi5MgbwPZW813yjIMmsd4?=
 =?us-ascii?Q?Xpv/+i99kVEJvh/npw6HYyEgNbKLlOT3TBXytu1Wh6e+x6VAPUf+oT4+2B7i?=
 =?us-ascii?Q?U0Uc6INRT9/YzGdw+7dQvHCD9/62rZk47849S22Wvzo3esESTI7uLIyn4lB8?=
 =?us-ascii?Q?V6bKtWz/BG+U+9hWAHdGoC0r7B0fpaK/aTKQxEjKEiAi4D/S/81GWckFDjsB?=
 =?us-ascii?Q?TBsAFxs6vN9q632KtqkwUL07B5fo6UzaNNLjXrAdtfpIJtZDJufvGIA50puQ?=
 =?us-ascii?Q?u+YG+kC1l4098uhZz2xHzQSMp/J2sD9oFWOr68w2vU6URFGz6sG9+h4aAd27?=
 =?us-ascii?Q?LSuk3A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 09:10:18.1785
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b06a19-6a9f-445d-8586-08de573a90d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFB67404FBA

AMD MDB IP supports Linked List (LL) mode as well as non-LL mode.
The current code does not have the mechanisms to enable the
DMA transactions using the non-LL mode. The following two cases
are added with this patch:
- For the AMD (Xilinx) only, when a valid physical base address of
  the device side DDR is not configured, then the IP can still be
  used in non-LL mode. For all the channels DMA transactions will
  be using the non-LL mode only. This, the default non-LL mode,
  is not applicable for Synopsys IP with the current code addition.

- If the default mode is LL-mode, for both AMD (Xilinx) and Synosys,
  and if user wants to use non-LL mode then user can do so via
  configuring the peripheral_config param of dma_slave_config.

Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
---
Changes in v9
  Fixed compilation errors related to macro name mismatch.

Changes in v8
  Cosmetic change related to comment and code.

Changes in v7
  No change

Changes in v6
  Gave definition to bits used for channel configuration.
  Removed the comment related to doorbell.

Changes in v5
  Variable name 'nollp' changed to 'non_ll'.
  In the dw_edma_device_config() WARN_ON replaced with dev_err().
  Comments follow the 80-column guideline.

Changes in v4
  No change

Changes in v3
  No change

Changes in v2
  Reverted the function return type to u64 for
  dw_edma_get_phys_addr().

Changes in v1
  Changed the function return type for dw_edma_get_phys_addr().
  Corrected the typo raised in review.
---
 drivers/dma/dw-edma/dw-edma-core.c    | 42 +++++++++++++++---
 drivers/dma/dw-edma/dw-edma-core.h    |  1 +
 drivers/dma/dw-edma/dw-edma-pcie.c    | 44 +++++++++++++------
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 61 ++++++++++++++++++++++++++-
 drivers/dma/dw-edma/dw-hdma-v0-regs.h |  1 +
 include/linux/dma/edma.h              |  1 +
 6 files changed, 131 insertions(+), 19 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index b43255f914f3..d37112bc2e16 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -223,8 +223,32 @@ static int dw_edma_device_config(struct dma_chan *dchan,
 				 struct dma_slave_config *config)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	int non_ll = 0;
+
+	if (config->peripheral_config &&
+	    config->peripheral_size != sizeof(int)) {
+		dev_err(dchan->device->dev,
+			"config param peripheral size mismatch\n");
+		return -EINVAL;
+	}
 
 	memcpy(&chan->config, config, sizeof(*config));
+
+	/*
+	 * When there is no valid LLP base address available then the default
+	 * DMA ops will use the non-LL mode.
+	 *
+	 * Cases where LL mode is enabled and client wants to use the non-LL
+	 * mode then also client can do so via providing the peripheral_config
+	 * param.
+	 */
+	if (config->peripheral_config)
+		non_ll = *(int *)config->peripheral_config;
+
+	chan->non_ll = false;
+	if (chan->dw->chip->non_ll || (!chan->dw->chip->non_ll && non_ll))
+		chan->non_ll = true;
+
 	chan->configured = true;
 
 	return 0;
@@ -353,7 +377,7 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(xfer->dchan);
 	enum dma_transfer_direction dir = xfer->direction;
 	struct scatterlist *sg = NULL;
-	struct dw_edma_chunk *chunk;
+	struct dw_edma_chunk *chunk = NULL;
 	struct dw_edma_burst *burst;
 	struct dw_edma_desc *desc;
 	u64 src_addr, dst_addr;
@@ -419,9 +443,11 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 	if (unlikely(!desc))
 		goto err_alloc;
 
-	chunk = dw_edma_alloc_chunk(desc);
-	if (unlikely(!chunk))
-		goto err_alloc;
+	if (!chan->non_ll) {
+		chunk = dw_edma_alloc_chunk(desc);
+		if (unlikely(!chunk))
+			goto err_alloc;
+	}
 
 	if (xfer->type == EDMA_XFER_INTERLEAVED) {
 		src_addr = xfer->xfer.il->src_start;
@@ -450,7 +476,13 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 		if (xfer->type == EDMA_XFER_SCATTER_GATHER && !sg)
 			break;
 
-		if (chunk->bursts_alloc == chan->ll_max) {
+		/*
+		 * For non-LL mode, only a single burst can be handled
+		 * in a single chunk unlike LL mode where multiple bursts
+		 * can be configured in a single chunk.
+		 */
+		if ((chunk && chunk->bursts_alloc == chan->ll_max) ||
+		    chan->non_ll) {
 			chunk = dw_edma_alloc_chunk(desc);
 			if (unlikely(!chunk))
 				goto err_alloc;
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 71894b9e0b15..c8e3d196a549 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -86,6 +86,7 @@ struct dw_edma_chan {
 	u8				configured;
 
 	struct dma_slave_config		config;
+	bool				non_ll;
 };
 
 struct dw_edma_irq {
diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 76fedeb1ec8d..004c0a7132b2 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -298,6 +298,15 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
 	pdata->devmem_phys_off = off;
 }
 
+static u64 dw_edma_get_phys_addr(struct pci_dev *pdev,
+				 struct dw_edma_pcie_data *pdata,
+				 enum pci_barno bar)
+{
+	if (pdev->vendor == PCI_VENDOR_ID_XILINX)
+		return pdata->devmem_phys_off;
+	return pci_bus_address(pdev, bar);
+}
+
 static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			      const struct pci_device_id *pid)
 {
@@ -307,6 +316,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	struct dw_edma_chip *chip;
 	int err, nr_irqs;
 	int i, mask;
+	bool non_ll = false;
 
 	vsec_data = kmalloc(sizeof(*vsec_data), GFP_KERNEL);
 	if (!vsec_data)
@@ -332,21 +342,24 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 
 		/*
 		 * There is no valid address found for the LL memory
-		 * space on the device side.
+		 * space on the device side. In the absence of LL base
+		 * address use the non-LL mode or simple mode supported by
+		 * the HDMA IP.
 		 */
 		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_MDB_INVALID_ADDR)
-			return -ENOMEM;
+			non_ll = true;
 
 		/*
 		 * Configure the channel LL and data blocks if number of
 		 * channels enabled in VSEC capability are more than the
 		 * channels configured in xilinx_mdb_data.
 		 */
-		dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
-					       DW_PCIE_XILINX_MDB_LL_OFF_GAP,
-					       DW_PCIE_XILINX_MDB_LL_SIZE,
-					       DW_PCIE_XILINX_MDB_DT_OFF_GAP,
-					       DW_PCIE_XILINX_MDB_DT_SIZE);
+		if (!non_ll)
+			dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
+						       DW_PCIE_XILINX_MDB_LL_OFF_GAP,
+						       DW_PCIE_XILINX_MDB_LL_SIZE,
+						       DW_PCIE_XILINX_MDB_DT_OFF_GAP,
+						       DW_PCIE_XILINX_MDB_DT_SIZE);
 	}
 
 	/* Mapping PCI BAR regions */
@@ -394,6 +407,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->mf = vsec_data->mf;
 	chip->nr_irqs = nr_irqs;
 	chip->ops = &dw_edma_pcie_plat_ops;
+	chip->non_ll = non_ll;
 
 	chip->ll_wr_cnt = vsec_data->wr_ch_cnt;
 	chip->ll_rd_cnt = vsec_data->rd_ch_cnt;
@@ -402,7 +416,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	if (!chip->reg_base)
 		return -ENOMEM;
 
-	for (i = 0; i < chip->ll_wr_cnt; i++) {
+	for (i = 0; i < chip->ll_wr_cnt && !non_ll; i++) {
 		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
 		struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
 		struct dw_edma_block *ll_block = &vsec_data->ll_wr[i];
@@ -413,7 +427,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		ll_region->vaddr.io += ll_block->off;
-		ll_region->paddr = pci_bus_address(pdev, ll_block->bar);
+		ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
+							 ll_block->bar);
 		ll_region->paddr += ll_block->off;
 		ll_region->sz = ll_block->sz;
 
@@ -422,12 +437,13 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		dt_region->vaddr.io += dt_block->off;
-		dt_region->paddr = pci_bus_address(pdev, dt_block->bar);
+		dt_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
+							 dt_block->bar);
 		dt_region->paddr += dt_block->off;
 		dt_region->sz = dt_block->sz;
 	}
 
-	for (i = 0; i < chip->ll_rd_cnt; i++) {
+	for (i = 0; i < chip->ll_rd_cnt && !non_ll; i++) {
 		struct dw_edma_region *ll_region = &chip->ll_region_rd[i];
 		struct dw_edma_region *dt_region = &chip->dt_region_rd[i];
 		struct dw_edma_block *ll_block = &vsec_data->ll_rd[i];
@@ -438,7 +454,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		ll_region->vaddr.io += ll_block->off;
-		ll_region->paddr = pci_bus_address(pdev, ll_block->bar);
+		ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
+							 ll_block->bar);
 		ll_region->paddr += ll_block->off;
 		ll_region->sz = ll_block->sz;
 
@@ -447,7 +464,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		dt_region->vaddr.io += dt_block->off;
-		dt_region->paddr = pci_bus_address(pdev, dt_block->bar);
+		dt_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
+							 dt_block->bar);
 		dt_region->paddr += dt_block->off;
 		dt_region->sz = dt_block->sz;
 	}
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index e3f8db4fe909..a5d12bc400ea 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -225,7 +225,7 @@ static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
 		readl(chunk->ll_region.vaddr.io);
 }
 
-static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
+static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma *dw = chan->dw;
@@ -263,6 +263,65 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
 }
 
+static void dw_hdma_v0_core_non_ll_start(struct dw_edma_chunk *chunk)
+{
+	struct dw_edma_chan *chan = chunk->chan;
+	struct dw_edma *dw = chan->dw;
+	struct dw_edma_burst *child;
+	u32 val;
+
+	list_for_each_entry(child, &chunk->burst->list, list) {
+		SET_CH_32(dw, chan->dir, chan->id, ch_en, HDMA_V0_CH_EN);
+
+		/* Source address */
+		SET_CH_32(dw, chan->dir, chan->id, sar.lsb,
+			  lower_32_bits(child->sar));
+		SET_CH_32(dw, chan->dir, chan->id, sar.msb,
+			  upper_32_bits(child->sar));
+
+		/* Destination address */
+		SET_CH_32(dw, chan->dir, chan->id, dar.lsb,
+			  lower_32_bits(child->dar));
+		SET_CH_32(dw, chan->dir, chan->id, dar.msb,
+			  upper_32_bits(child->dar));
+
+		/* Transfer size */
+		SET_CH_32(dw, chan->dir, chan->id, transfer_size, child->sz);
+
+		/* Interrupt setup */
+		val = GET_CH_32(dw, chan->dir, chan->id, int_setup) |
+				HDMA_V0_STOP_INT_MASK |
+				HDMA_V0_ABORT_INT_MASK |
+				HDMA_V0_LOCAL_STOP_INT_EN |
+				HDMA_V0_LOCAL_ABORT_INT_EN;
+
+		if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL)) {
+			val |= HDMA_V0_REMOTE_STOP_INT_EN |
+			       HDMA_V0_REMOTE_ABORT_INT_EN;
+		}
+
+		SET_CH_32(dw, chan->dir, chan->id, int_setup, val);
+
+		/* Channel control setup */
+		val = GET_CH_32(dw, chan->dir, chan->id, control1);
+		val &= ~HDMA_V0_LINKLIST_EN;
+		SET_CH_32(dw, chan->dir, chan->id, control1, val);
+
+		SET_CH_32(dw, chan->dir, chan->id, doorbell,
+			  HDMA_V0_DOORBELL_START);
+	}
+}
+
+static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
+{
+	struct dw_edma_chan *chan = chunk->chan;
+
+	if (chan->non_ll)
+		dw_hdma_v0_core_non_ll_start(chunk);
+	else
+		dw_hdma_v0_core_ll_start(chunk, first);
+}
+
 static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
 {
 	struct dw_edma *dw = chan->dw;
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
index eab5fd7177e5..7759ba9b4850 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
+++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
@@ -12,6 +12,7 @@
 #include <linux/dmaengine.h>
 
 #define HDMA_V0_MAX_NR_CH			8
+#define HDMA_V0_CH_EN				BIT(0)
 #define HDMA_V0_LOCAL_ABORT_INT_EN		BIT(6)
 #define HDMA_V0_REMOTE_ABORT_INT_EN		BIT(5)
 #define HDMA_V0_LOCAL_STOP_INT_EN		BIT(4)
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 3080747689f6..78ce31b049ae 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -99,6 +99,7 @@ struct dw_edma_chip {
 	enum dw_edma_map_format	mf;
 
 	struct dw_edma		*dw;
+	bool			non_ll;
 };
 
 /* Export to the platform drivers */
-- 
2.43.0


