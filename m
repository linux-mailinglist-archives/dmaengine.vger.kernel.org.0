Return-Path: <dmaengine+bounces-7018-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B029DC145ED
	for <lists+dmaengine@lfdr.de>; Tue, 28 Oct 2025 12:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F4B05E839E
	for <lists+dmaengine@lfdr.de>; Tue, 28 Oct 2025 11:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D22830BB9E;
	Tue, 28 Oct 2025 11:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O9DEr2cm"
X-Original-To: dmaengine@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012015.outbound.protection.outlook.com [52.101.48.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6596B309F00;
	Tue, 28 Oct 2025 11:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761650953; cv=fail; b=JRXOU/Lw8p4EFrvwIyqCotPSy6gkNqWjSdGt5bmfpZd3QxWqmoAxm57eA9S6VLrm1lhe0P3PLZHfXdItqT3ru/X8f8zYWevTZMdJxcw4eaWPcQ4gXKG9DICM0vsXYYzpk/Pn5qzSqrkuZVIH6ucQUj79hvv9tAf76IthiobWFLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761650953; c=relaxed/simple;
	bh=BuzjGPwKYU7WhdzdWqm+u9E0FjemCTNNsM3ZZvhXh80=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rbXHmY0pGjJQNyRap9d/R/nL9C/vLWv09xPa4R//70ZsnyCgHuPpjDpYNDbtwjLJk3drAjSIKw+3hL1dyTLZc41Qp0QAv2wkI746SjP4GOV/ezMGf64TEeCX9guY+q9w0VChRBTok3fMXV5ox1ZjU/t8+1PjK4SpL/zUqLqMI+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O9DEr2cm; arc=fail smtp.client-ip=52.101.48.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUyBE8XBJUdJ4/e0dkXTm4+zy6sjcdVhpO1q4I4/pH+vBQkNfm0mULX5AXSEDUJ4bELAoaUPEowgtx9GsW5+NSlkSS36rRsQ/s2POXguVd2D6RNhM4LtWsCJY1cRbx2artz2Sy8WS10ednVk2HliErlIPfCVzXsPUsXWgROY6JSbCkExV2MKtS8EeL8UQjkd+xeGBEUFon9qhu+WD/3+WCgjyb0pKKe882zWH7vdkprn+NG0MpS5w2rbk5+HCtmlETiCRuJrGrf3NfV6c84fX/yrmn9hBqDBVmVFYKyDzgtE2hpFN1tAE5qCJiQAGjKfvmbl2el0U/q5tLi4SgltAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/2k9PynIiW3qCFTLd+fZTYp2ICVC3M2S8aw1Xwb0A4=;
 b=mNXwaVHxGQ6sZoku6/uTf1K5EOt+hMHMmvRVP67faGXk1ZDJmTLGAqDbPcN94mD/7jiEeulZMKbFAvtP9G39NvM1iQ+2MOs9+V6vYMQ+BfcBWzvZqXhhdRQyTtvq4LmRqY2IMQP5QfTk58q6MR4zDdj6Fz+xAyuzlX6oI+pX3VchPVqIfkLYXOlXk+0G0Fzjihmk/+S93vX2YQHBJw5luA4bf8nUMtzv+LqL/Owh0MLs6oUS8Vl4uGOK3ugXtRZ6s9igC7RooTM+Mq9Ssk2Uekxqk8ZAbYqGf4ejJ4sF4v183vCchoJcMEvEZwO7Fl9S/8/1wkUPKlAmk3yG9oR6gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/2k9PynIiW3qCFTLd+fZTYp2ICVC3M2S8aw1Xwb0A4=;
 b=O9DEr2cmzRr9TUa7VbQIbuPEGaWYUjKOr4PkEr5goM29KDJycT6x6T3LPdc7O3Ll8dF+N0rsyTzvcOe5SsAX+gdrI/0G/S2eW+0MOag8OTeuf1wh6mBkKVEqPK1x0ezoJ3caz6oEVH5WNKPAYNSVds7eoWFhr0LU0K4VE054JaI=
Received: from SJ0PR05CA0083.namprd05.prod.outlook.com (2603:10b6:a03:332::28)
 by DS4PR12MB9820.namprd12.prod.outlook.com (2603:10b6:8:2a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 11:29:08 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::e9) by SJ0PR05CA0083.outlook.office365.com
 (2603:10b6:a03:332::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Tue,
 28 Oct 2025 11:29:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 28 Oct 2025 11:29:07 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Oct
 2025 04:29:07 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Oct
 2025 04:29:06 -0700
Received: from xhdapps-pcie2.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 28 Oct 2025 04:29:04 -0700
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<Devendra.Verma@amd.com>
Subject: [PATCH v5 2/2] dmaengine: dw-edma: Add non-LL mode
Date: Tue, 28 Oct 2025 16:58:58 +0530
Message-ID: <20251028112858.9930-3-devendra.verma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251028112858.9930-1-devendra.verma@amd.com>
References: <20251028112858.9930-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|DS4PR12MB9820:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c36d0c4-0973-4325-3339-08de16153561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qRJB551qhqZ5NacLoqSiYxJOutO1jG3cJtwU2jZ9gmsqddTQZRjSY/U/OCSb?=
 =?us-ascii?Q?LTCbuAuG7uXMA7bvkL1QjklGZ/1jvHkZHdFLeaOpXTpk0oZdhlhIU0FAuZr4?=
 =?us-ascii?Q?VPQwVN3pKj0PdKyygaqquN5GzHK77YiccCZQ8OZOmfnrqFZqVSSbuXE/8JHG?=
 =?us-ascii?Q?uboBpEEbVN2X0YDMRVDiAqqMX/ugY5Sh2UskSSPjZF+uRbVx1ywJQdlJ/GjQ?=
 =?us-ascii?Q?Euh11uCeWLfd/pP5stzSa4/fpZtqbjoleQI/AOq9293edmhel2H/H5OH/tGz?=
 =?us-ascii?Q?d200i7FI86PURbJSwHD3BtaRF9M7LXWp69LctFmoSK1FJrha5qh9szZiHAiH?=
 =?us-ascii?Q?gCrN2Vb4hE50QpomsA2/g9E7x81xWZ1jqmNBHWMv3997cyBMBJbfrPkSKj01?=
 =?us-ascii?Q?f+aQiiHhEaQ5eBH6+tD6WjBx2YflDEeqNk8rt9kH5j8RgdxV9fzWudbsctz2?=
 =?us-ascii?Q?v1MzBZek49e4elD6a6Wg5wIEd3upInHB7zC8yHWfkXtMs6xLvWOZzaq+BuN7?=
 =?us-ascii?Q?evQg5hhCc7Bpqh/cgCc/C3eymZx+3NDzM262e0Rxzca8OERR3ljear9C9t/y?=
 =?us-ascii?Q?vRJ+SRIIpZCsXAi0f++8ulyy+/333LiwSCagGm/Ifv+K75tkbhtzf3Kp/D+A?=
 =?us-ascii?Q?6F9YI1pq7qhoG8IanG7hv7Vropxm0HIrESvqdDND613rOqmexnIuqVGX6hV9?=
 =?us-ascii?Q?MeeXfzQhSomgocd0vNHk1xoxtGVFmgomjiS5FtC5q5PN76qhnyKtAL2712vd?=
 =?us-ascii?Q?qJ6UXlyIbX05geLU98nCK9Kzq0qmsVrgeXkyfh70E+Xwky8e1SeQ4dAteqzP?=
 =?us-ascii?Q?cyxHFyGEIwO1v1fv3t/KNhuNS9znNeNMUVMSKWqKN5c0QbnGcj3dkuMN6wah?=
 =?us-ascii?Q?JLRgo+AUQiNn9MYd1Zg/Wmo6GqdO0Ti6mGR89WtpUWbWx3dUwNI1EtFxEAJM?=
 =?us-ascii?Q?chCfb4lE7wd8z7Do2f1sPOZnQyqupaZHqD9RKTxiZEIG0zHnnZZ+8lrI1GPB?=
 =?us-ascii?Q?I856EMz+GQVM+vS0xxJHPa8mYq33KBwk+GGxTMLv/Bnlscxvz1bWgUSBdpv1?=
 =?us-ascii?Q?FfSrORvWvfYcz/vrmu/lr1vRZZAfilDbijk3LMkuOcXPSjqEwL1B/F9+pTp+?=
 =?us-ascii?Q?v9yRhE6l7vMlGSKtPLQDymq8I9weIwBUe5wIAHgWu88/CbdNynd1qXjl5+ug?=
 =?us-ascii?Q?cQZ3GZ98EBrUTIAMp6tFAhrlqVijl5yS3bC+MhYpM6Qt6IVl2MBZdzHCQKcW?=
 =?us-ascii?Q?UObYGnBS/0vNg0RZndzBdZy4ZqPJAov1FwI1vjRMhzsJFFMRQBvMSP1yymM3?=
 =?us-ascii?Q?PKVfys/ikO91MK7gghn1+meTEb+0FFQHrzfq7RhUq8XSv2rz5JK7QDfIlH0r?=
 =?us-ascii?Q?GTpCRE6QxPssd5mlOD6ZA4vyjBpE/lBiblublYSUgOkVUgfLzn/nxXMOMLY/?=
 =?us-ascii?Q?D/wPIKkFPoSSm50GzkNeiJBBQnDdVqsoRqPgCRHH3Zni5r+XyGZlcgaUKj9A?=
 =?us-ascii?Q?3ymHDUkPuStTdbr4cQnG6Ku/k9M1QAJqK+ovfyTimd+tZa3LoaOcp11pyH31?=
 =?us-ascii?Q?/II5xjES1wb4BRB7lvQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 11:29:07.7540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c36d0c4-0973-4325-3339-08de16153561
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9820

AMD MDB IP supports Linked List (LL) mode as well as non-LL mode.
The current code does not have the mechanisms to enable the
DMA transactions using the non-LL mode. The following two cases
are added with this patch:
- When a valid physical base address is not configured via the
  Xilinx VSEC capability then the IP can still be used in non-LL
  mode. The default mode for all the DMA transactions and for all
  the DMA channels then is non-LL mode.
- When a valid physical base address is configured but the client
  wants to use the non-LL mode for DMA transactions then also the
  flexibility is provided via the peripheral_config struct member of
  dma_slave_config. In this case the channels can be individually
  configured in non-LL mode. This use case is desirable for single
  DMA transfer of a chunk, this saves the effort of preparing the
  Link List. This particular scenario is applicable to AMD as well
  as Synopsys IP.

Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
---
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
 drivers/dma/dw-edma/dw-edma-core.c    | 41 ++++++++++++++++++++---
 drivers/dma/dw-edma/dw-edma-core.h    |  1 +
 drivers/dma/dw-edma/dw-edma-pcie.c    | 44 +++++++++++++++++--------
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 62 ++++++++++++++++++++++++++++++++++-
 include/linux/dma/edma.h              |  1 +
 5 files changed, 130 insertions(+), 19 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index b43255f..60a3279 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -223,8 +223,31 @@ static int dw_edma_device_config(struct dma_chan *dchan,
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
@@ -353,7 +376,7 @@ static void dw_edma_device_issue_pending(struct dma_chan *dchan)
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(xfer->dchan);
 	enum dma_transfer_direction dir = xfer->direction;
 	struct scatterlist *sg = NULL;
-	struct dw_edma_chunk *chunk;
+	struct dw_edma_chunk *chunk = NULL;
 	struct dw_edma_burst *burst;
 	struct dw_edma_desc *desc;
 	u64 src_addr, dst_addr;
@@ -419,9 +442,11 @@ static void dw_edma_device_issue_pending(struct dma_chan *dchan)
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
@@ -450,7 +475,13 @@ static void dw_edma_device_issue_pending(struct dma_chan *dchan)
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
index 71894b9..c8e3d19 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -86,6 +86,7 @@ struct dw_edma_chan {
 	u8				configured;
 
 	struct dma_slave_config		config;
+	bool				non_ll;
 };
 
 struct dw_edma_irq {
diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 7b991a0..b02977c 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -268,6 +268,15 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
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
@@ -277,6 +286,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	struct dw_edma_chip *chip;
 	int err, nr_irqs;
 	int i, mask;
+	bool non_ll = false;
 
 	vsec_data = kmalloc(sizeof(*vsec_data), GFP_KERNEL);
 	if (!vsec_data)
@@ -301,21 +311,24 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	if (pdev->vendor == PCI_VENDOR_ID_XILINX) {
 		/*
 		 * There is no valid address found for the LL memory
-		 * space on the device side.
+		 * space on the device side. In the absence of LL base
+		 * address use the non-LL mode or simple mode supported by
+		 * the HDMA IP.
 		 */
 		if (vsec_data->devmem_phys_off == DW_PCIE_AMD_MDB_INVALID_ADDR)
-			return -ENOMEM;
+			non_ll = true;
 
 		/*
 		 * Configure the channel LL and data blocks if number of
 		 * channels enabled in VSEC capability are more than the
 		 * channels configured in amd_mdb_data.
 		 */
-		dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
-					       DW_PCIE_XILINX_LL_OFF_GAP,
-					       DW_PCIE_XILINX_LL_SIZE,
-					       DW_PCIE_XILINX_DT_OFF_GAP,
-					       DW_PCIE_XILINX_DT_SIZE);
+		if (!non_ll)
+			dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
+						       DW_PCIE_XILINX_LL_OFF_GAP,
+						       DW_PCIE_XILINX_LL_SIZE,
+						       DW_PCIE_XILINX_DT_OFF_GAP,
+						       DW_PCIE_XILINX_DT_SIZE);
 	}
 
 	/* Mapping PCI BAR regions */
@@ -363,6 +376,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->mf = vsec_data->mf;
 	chip->nr_irqs = nr_irqs;
 	chip->ops = &dw_edma_pcie_plat_ops;
+	chip->non_ll = non_ll;
 
 	chip->ll_wr_cnt = vsec_data->wr_ch_cnt;
 	chip->ll_rd_cnt = vsec_data->rd_ch_cnt;
@@ -371,7 +385,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	if (!chip->reg_base)
 		return -ENOMEM;
 
-	for (i = 0; i < chip->ll_wr_cnt; i++) {
+	for (i = 0; i < chip->ll_wr_cnt && !non_ll; i++) {
 		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
 		struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
 		struct dw_edma_block *ll_block = &vsec_data->ll_wr[i];
@@ -382,7 +396,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		ll_region->vaddr.io += ll_block->off;
-		ll_region->paddr = pci_bus_address(pdev, ll_block->bar);
+		ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
+							 ll_block->bar);
 		ll_region->paddr += ll_block->off;
 		ll_region->sz = ll_block->sz;
 
@@ -391,12 +406,13 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
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
@@ -407,7 +423,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		ll_region->vaddr.io += ll_block->off;
-		ll_region->paddr = pci_bus_address(pdev, ll_block->bar);
+		ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
+							 ll_block->bar);
 		ll_region->paddr += ll_block->off;
 		ll_region->sz = ll_block->sz;
 
@@ -416,7 +433,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		dt_region->vaddr.io += dt_block->off;
-		dt_region->paddr = pci_bus_address(pdev, dt_block->bar);
+		dt_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
+							 dt_block->bar);
 		dt_region->paddr += dt_block->off;
 		dt_region->sz = dt_block->sz;
 	}
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index e3f8db4..47ecc84 100644
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
@@ -263,6 +263,66 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
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
+		SET_CH_32(dw, chan->dir, chan->id, ch_en, BIT(0));
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
+		/* Ring the doorbell */
+		SET_CH_32(dw, chan->dir, chan->id, doorbell,
+			  HDMA_V0_DOORBELL_START);
+	}
+}
+
+static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
+{
+	struct dw_edma_chan *chan = chunk->chan;
+
+	if (!chan->non_ll)
+		dw_hdma_v0_core_ll_start(chunk, first);
+	else
+		dw_hdma_v0_core_non_ll_start(chunk);
+}
+
 static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
 {
 	struct dw_edma *dw = chan->dw;
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 3080747..78ce31b 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -99,6 +99,7 @@ struct dw_edma_chip {
 	enum dw_edma_map_format	mf;
 
 	struct dw_edma		*dw;
+	bool			non_ll;
 };
 
 /* Export to the platform drivers */
-- 
1.8.3.1


