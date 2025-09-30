Return-Path: <dmaengine+bounces-6733-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 181F4BAD07C
	for <lists+dmaengine@lfdr.de>; Tue, 30 Sep 2025 15:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50DDB1928716
	for <lists+dmaengine@lfdr.de>; Tue, 30 Sep 2025 13:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED08530ACE1;
	Tue, 30 Sep 2025 13:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tF+lLX3m"
X-Original-To: dmaengine@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011042.outbound.protection.outlook.com [52.101.62.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE1730AAD7;
	Tue, 30 Sep 2025 13:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759238293; cv=fail; b=L3iyLlUkioO7kt3NAUlvcKoVlXUBRNvRdLpuKMSyGHbP+lYKhrl410lVT4ZsE1kEBwQhH83j+XiSR7Lt3C5+jbMbrwmIma0ylz7K98WPQ/ayD9j+jtFOopF6jn7Alq8VGS5xk8u+2n5ExRM/I1VohlrTpfWDvVpRtW25g2lJ2Mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759238293; c=relaxed/simple;
	bh=YVEbU63l/iLXdb8SEBZ9u97tKg6iIb8NvcCHygtQtsc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iiLugnkh9blbKpSVJgXG0QjjJlYQ0gdMKcwv5WPR3gRGu2wWnkYA/S86ZrIsm6WFf9Dph048jVvQ6gYrdElYYH2Mlmi+wcN30Ih1D3JQEuqWar4slKRWeF76kV5NYTf2GR3NTwVwxDtOmHRNVUa2u/5YDhqfeMX6IiVdrLOP3O8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tF+lLX3m; arc=fail smtp.client-ip=52.101.62.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6r5NF31qXVU15TIPfD+e0Bptjs+8ZQsaoYGx5PDks/zok97WoVMpd7KMO3I8CtNTzQO33wmYytKEe41m1HDMNWYVeve1E4u1+OKkQ8WrUIb/dbJz0Tze4vmM1iX2kyuQEjINOBYEUis3MqpH8L6hPvwMp0BJVmqjyK+Fske9gG3oOjGEm5vfIUG9Y/58pG4HtYKOd0l/HyC8vN6GgEm/E5lVF9ocaRMD3qCrbMciDcrYk4CKiEpamVaWNcUWmr8VUjNGTU4265LZ+WMdcN/QtZ9z1PgEUJ5uOnJYPPyaVhiEjOfq1c/kdNCxO1g6Ts0sifRNVRu1RVE5Q8rszF23g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7p8RlG6U+dnoR2PdGxaP+yP23qTTw6gyM5keLzdbus=;
 b=QYPUIPgTnb0cE4ijG+VRtAKG9RtO5h2kfTy9gSXXYCzhFou8VnRQnmNObIEd/2vEQcjO4HHzLXpAR3PV+evFUpjyjfB/hp/CCyUvT2qXjz3XdLtCRQR0tD7Gs1eZYeYE9wIQqX7RHVjO7RkZj2TM1kmo5AmL2KWx5oahFRia9/mfr9D+upGHMGUywawH9ObfZyqARj1Bgnudsvi8yuX/jAA3MMzp7joSFYfMKaris0XEkMnmCnHeCF11njIBMCypeVQhYxHvO/72K3vlZIuXy4c2+V00/DL0NBFF5gLbe/sdBkT2zUkLo8ZSR3GfYrQEgGe+9RM00nwiD/dMUlmFPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7p8RlG6U+dnoR2PdGxaP+yP23qTTw6gyM5keLzdbus=;
 b=tF+lLX3mfOQka+R/GbToydMP6LHqTR4Uo0PxydGArlesmCJF4NqhFV4rKr5h1lWNlMjS4ws6nao4UpBV703TO9NTgcDchvIqWVvhMvfib7cYt+aYT9GOd5AyuFfzmJHrVLrGWsPzhQx6DnLl+p0sapUKi7uVe2QfUhMAtLIa9Sg=
Received: from BN0PR04CA0030.namprd04.prod.outlook.com (2603:10b6:408:ee::35)
 by IA0PR12MB7531.namprd12.prod.outlook.com (2603:10b6:208:43f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Tue, 30 Sep
 2025 13:18:05 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:ee:cafe::98) by BN0PR04CA0030.outlook.office365.com
 (2603:10b6:408:ee::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Tue,
 30 Sep 2025 13:18:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Tue, 30 Sep 2025 13:18:05 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 30 Sep
 2025 06:18:03 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 30 Sep
 2025 06:18:02 -0700
Received: from xhdapps-pcie2.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 30 Sep 2025 06:18:00 -0700
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>
Subject: [RESEND PATCH v4 2/2] dmaengine: dw-edma: Add non-LL mode
Date: Tue, 30 Sep 2025 18:47:55 +0530
Message-ID: <20250930131755.3844-3-devendra.verma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250930131755.3844-1-devendra.verma@amd.com>
References: <20250930131755.3844-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|IA0PR12MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: 89eeb0f4-9420-49fe-0f54-08de0023ca59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DqvQDJFrL3dR/aZFz/EDkNNWbgrSpNd9xinpYYZS3NOP5LmPusU1HLPYsRiq?=
 =?us-ascii?Q?mUmGBneue6brVPyx8tAEt0HHjMWieXD3OqXxUnVSgACbFXDaZe7zLmloMtWT?=
 =?us-ascii?Q?g9DUIPb2vz//OUy4+UNwH1siQ5n3KipkYho73zJRkSS2mWHJhAu10VbvG2Q8?=
 =?us-ascii?Q?mWuVlYNGPbA3bmpLiRR6MIZpxdMOlaPcXQK937Q8CMqV9fLPnhUuiVn8BX31?=
 =?us-ascii?Q?qulbevS50wESDAXLGA9f1YFg8K83j0TBibqiaskCmBMhW8bQ4NnLMeyPZ7vQ?=
 =?us-ascii?Q?XTY6noj0TT8g9M/zUDkgnG+HIk9MWSA81/UnRz9yNsqkWbvs8ghD+jpjPral?=
 =?us-ascii?Q?NhSYLGagwv8/XWENPUtuCSIR/Ri33YCQGLV74rh6myP2EV4dsklWR3NvQLX9?=
 =?us-ascii?Q?EX1pFzCd6hoGiOKSnithDx9CVnIDGjBhDWisJe7qle7XkL0HbcFgJPlEIw7B?=
 =?us-ascii?Q?MRM2E+O1k18W8XXvL8/CibVk045TCYy5El5gDQOY0kyFCxRetnwX5f3KNdny?=
 =?us-ascii?Q?YAKpsuceDPFnPOP9EXP9McxeU7QQOC1BjBb7Ap6lg3IPcbj6lIOrhyOYlukt?=
 =?us-ascii?Q?xbjwPz/FFRnM13lqMNDBA29VbI29Hrw2MN/S/qJOn9+zQeAnkPkz9IUjzwNa?=
 =?us-ascii?Q?tuYxg9c3y+jCSA0RB30m665tKetA/LVSbU6V2hf353ZeAt3rDXZKDeSjFoC/?=
 =?us-ascii?Q?YDZnq6U+bJ7k/NeUuaLcpWBLX160zBdmeuKDkLvS1H2DTwBDYubvNNzrAJ/C?=
 =?us-ascii?Q?Y98l7SxtQnwP3tnb/XBbIXjse50dTKDIcF1BgXZn3m7/oPuyHCDS+DsC4yj5?=
 =?us-ascii?Q?64troTladiZAP9+pd9YSZE8leVk9EkUMg4K0/1jn/FL3YIYwW65T99q9Z+l8?=
 =?us-ascii?Q?kJx3EsLCjTKCc6YyHjT6ZAT45atOPpmlQ3h7/T19jgdCRNQzZlrUp8qtD6av?=
 =?us-ascii?Q?7CcxyN8X6LxkTxeoJAifPDHGYtDYeAgeqDkqyGlbuN3snFRhoErCrC5DRg7L?=
 =?us-ascii?Q?tdN90k6HeYb29dL1pHaw3vLB88ApqnjcUkITDTZbGLQnG7GoTD10tTibYKso?=
 =?us-ascii?Q?BDM0w8H4/i/IOZ03dAeRw//tmdkKC19A4gOyaI7OXTW0ve7gR8uIcci7mluC?=
 =?us-ascii?Q?cWQx9w/vHEKzHkEBcwzMozy7jMf+Me3xYp/mr54+EtG18q+XO6EiPNE5RKkj?=
 =?us-ascii?Q?k4pKpPNGh9t1MYo/+BZMjC+wQkJg5Ot9sEdblhEybyV4QI8wWZITaFAxYZY5?=
 =?us-ascii?Q?imhZilUhudYRbq+FCjmCLTkjLvucUk0tpopArkzxi0HYqg7xlI3c9xJ+jIWj?=
 =?us-ascii?Q?90Y15ru55rMisH3RIbaVndg3Npoqahdpv6cX8gRzN1jUiwJiSRFAAQUdvx40?=
 =?us-ascii?Q?EpEst4qPfil86WV6HW1xXTwjnPENFxqMQxk44cc4NaSYXCouQ3TghQ1Ctjxd?=
 =?us-ascii?Q?KO9ilNAOp2102DVHzZz+U7hr8RlwvIqhnnpqFjEn36p2ffLQQNSshgHeq63m?=
 =?us-ascii?Q?o+hj+676MZlSlm8uk7IbA1xysdwE4cQr8avTCXGsBPQw6vfgIGaj2K7rLdBO?=
 =?us-ascii?Q?qexN+YsK17E+/ZpdGrs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 13:18:05.1448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89eeb0f4-9420-49fe-0f54-08de0023ca59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7531

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
  Link List.

Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
---
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
 drivers/dma/dw-edma/dw-edma-core.c    | 38 +++++++++++++---
 drivers/dma/dw-edma/dw-edma-core.h    |  1 +
 drivers/dma/dw-edma/dw-edma-pcie.c    | 44 +++++++++++++------
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 62 ++++++++++++++++++++++++++-
 include/linux/dma/edma.h              |  1 +
 5 files changed, 127 insertions(+), 19 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index b43255f914f3..3283ac5ffeeb 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -223,8 +223,28 @@ static int dw_edma_device_config(struct dma_chan *dchan,
 				 struct dma_slave_config *config)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	int nollp = 0;
+
+	if (WARN_ON(config->peripheral_config &&
+		    config->peripheral_size != sizeof(int)))
+		return -EINVAL;
 
 	memcpy(&chan->config, config, sizeof(*config));
+
+	/*
+	 * When there is no valid LLP base address available
+	 * then the default DMA ops will use the non-LL mode.
+	 * Cases where LL mode is enabled and client wants
+	 * to use the non-LL mode then also client can do
+	 * so via providing the peripheral_config param.
+	 */
+	if (config->peripheral_config)
+		nollp = *(int *)config->peripheral_config;
+
+	chan->nollp = false;
+	if (chan->dw->chip->nollp || (!chan->dw->chip->nollp && nollp))
+		chan->nollp = true;
+
 	chan->configured = true;
 
 	return 0;
@@ -353,7 +373,7 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(xfer->dchan);
 	enum dma_transfer_direction dir = xfer->direction;
 	struct scatterlist *sg = NULL;
-	struct dw_edma_chunk *chunk;
+	struct dw_edma_chunk *chunk = NULL;
 	struct dw_edma_burst *burst;
 	struct dw_edma_desc *desc;
 	u64 src_addr, dst_addr;
@@ -419,9 +439,11 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 	if (unlikely(!desc))
 		goto err_alloc;
 
-	chunk = dw_edma_alloc_chunk(desc);
-	if (unlikely(!chunk))
-		goto err_alloc;
+	if (!chan->nollp) {
+		chunk = dw_edma_alloc_chunk(desc);
+		if (unlikely(!chunk))
+			goto err_alloc;
+	}
 
 	if (xfer->type == EDMA_XFER_INTERLEAVED) {
 		src_addr = xfer->xfer.il->src_start;
@@ -450,7 +472,13 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 		if (xfer->type == EDMA_XFER_SCATTER_GATHER && !sg)
 			break;
 
-		if (chunk->bursts_alloc == chan->ll_max) {
+		/*
+		 * For non-LL mode, only a single burst can be handled
+		 * in a single chunk unlike LL mode where multiple bursts
+		 * can be configured in a single chunk.
+		 */
+		if ((chunk && chunk->bursts_alloc == chan->ll_max) ||
+		    chan->nollp) {
 			chunk = dw_edma_alloc_chunk(desc);
 			if (unlikely(!chunk))
 				goto err_alloc;
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 71894b9e0b15..2a4ad45fbe01 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -86,6 +86,7 @@ struct dw_edma_chan {
 	u8				configured;
 
 	struct dma_slave_config		config;
+	bool				nollp;
 };
 
 struct dw_edma_irq {
diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index b26a55eec5e4..1c4d10c38823 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -260,6 +260,15 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
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
@@ -269,6 +278,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	struct dw_edma_chip *chip;
 	int err, nr_irqs;
 	int i, mask;
+	bool nollp = false;
 
 	vsec_data = kmalloc(sizeof(*vsec_data), GFP_KERNEL);
 	if (!vsec_data)
@@ -293,21 +303,24 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	if (pdev->vendor == PCI_VENDOR_ID_XILINX) {
 		/*
 		 * There is no valid address found for the LL memory
-		 * space on the device side.
+		 * space on the device side. In the absence of LL base
+		 * address use the non-LL mode or simple mode supported by
+		 * the HDMA IP.
 		 */
 		if (vsec_data->devmem_phys_off == DW_PCIE_AMD_MDB_INVALID_ADDR)
-			return -EINVAL;
+			nollp = true;
 
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
+		if (!nollp)
+			dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
+						       DW_PCIE_XILINX_LL_OFF_GAP,
+						       DW_PCIE_XILINX_LL_SIZE,
+						       DW_PCIE_XILINX_DT_OFF_GAP,
+						       DW_PCIE_XILINX_DT_SIZE);
 	}
 
 	/* Mapping PCI BAR regions */
@@ -355,6 +368,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->mf = vsec_data->mf;
 	chip->nr_irqs = nr_irqs;
 	chip->ops = &dw_edma_pcie_plat_ops;
+	chip->nollp = nollp;
 
 	chip->ll_wr_cnt = vsec_data->wr_ch_cnt;
 	chip->ll_rd_cnt = vsec_data->rd_ch_cnt;
@@ -363,7 +377,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	if (!chip->reg_base)
 		return -ENOMEM;
 
-	for (i = 0; i < chip->ll_wr_cnt; i++) {
+	for (i = 0; i < chip->ll_wr_cnt && !nollp; i++) {
 		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
 		struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
 		struct dw_edma_block *ll_block = &vsec_data->ll_wr[i];
@@ -374,7 +388,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		ll_region->vaddr.io += ll_block->off;
-		ll_region->paddr = pci_bus_address(pdev, ll_block->bar);
+		ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
+							 ll_block->bar);
 		ll_region->paddr += ll_block->off;
 		ll_region->sz = ll_block->sz;
 
@@ -383,12 +398,13 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		dt_region->vaddr.io += dt_block->off;
-		dt_region->paddr = pci_bus_address(pdev, dt_block->bar);
+		dt_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
+							 dt_block->bar);
 		dt_region->paddr += dt_block->off;
 		dt_region->sz = dt_block->sz;
 	}
 
-	for (i = 0; i < chip->ll_rd_cnt; i++) {
+	for (i = 0; i < chip->ll_rd_cnt && !nollp; i++) {
 		struct dw_edma_region *ll_region = &chip->ll_region_rd[i];
 		struct dw_edma_region *dt_region = &chip->dt_region_rd[i];
 		struct dw_edma_block *ll_block = &vsec_data->ll_rd[i];
@@ -399,7 +415,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		ll_region->vaddr.io += ll_block->off;
-		ll_region->paddr = pci_bus_address(pdev, ll_block->bar);
+		ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
+							 ll_block->bar);
 		ll_region->paddr += ll_block->off;
 		ll_region->sz = ll_block->sz;
 
@@ -408,7 +425,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		dt_region->vaddr.io += dt_block->off;
-		dt_region->paddr = pci_bus_address(pdev, dt_block->bar);
+		dt_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
+							 dt_block->bar);
 		dt_region->paddr += dt_block->off;
 		dt_region->sz = dt_block->sz;
 	}
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index e3f8db4fe909..befb9e0c9bd0 100644
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
+	if (!chan->nollp)
+		dw_hdma_v0_core_ll_start(chunk, first);
+	else
+		dw_hdma_v0_core_non_ll_start(chunk);
+}
+
 static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
 {
 	struct dw_edma *dw = chan->dw;
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 3080747689f6..e14e16f4cc79 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -99,6 +99,7 @@ struct dw_edma_chip {
 	enum dw_edma_map_format	mf;
 
 	struct dw_edma		*dw;
+	bool			nollp;
 };
 
 /* Export to the platform drivers */
-- 
2.43.0


