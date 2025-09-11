Return-Path: <dmaengine+bounces-6450-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77603B53141
	for <lists+dmaengine@lfdr.de>; Thu, 11 Sep 2025 13:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0D841C88454
	for <lists+dmaengine@lfdr.de>; Thu, 11 Sep 2025 11:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B13213E9C;
	Thu, 11 Sep 2025 11:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="abojBg3I"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E4A31D39B;
	Thu, 11 Sep 2025 11:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757591110; cv=fail; b=GsdsyZIf9mlMILvYos5YxIi5YTQzTwApAiOIlZVOz2IA59onMghSGI62R0yjDKrVepqdJhwFqHG1fnYY6+igP0MhcR3p1aQjXd+26W9apmXiaQ+g2PJWFKcxeZKUzM2YsfQPx+Sr0KArYxYKOA+m/ajtG8L0u3j+2SB6EX6GUiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757591110; c=relaxed/simple;
	bh=xz25+JDIZMCCUIUYXHFbA/o/yHgzjPJlxszBN5hgIZg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e2RCOGrmbMMMnrrbHubhhkqolAzeQA/elpOyHMXmqvL4LGIffHbb2s5izzDqXMigBIEc05SBp74L3Jf5/GE2Vz6MKw1tFeU3ah3n6ls8S1L6aN701sjqI1bXkqZ79ga1VoCZ0QTT9IedzUlBtFNhh0KDu/F5lMNDgxri4mHaOLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=abojBg3I; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtoXcR5wPXJlB1r+rxE5nzj832akUmWiDEisdmQhmMaoA+8AQ6jd2zzjfc51oHRLwjYIcwa8igXTZEIumxdnymGWM7Q4exKvZLWOXEQP2s/1rbuAVXlgiMfgI/OUXDf9Yud8+hhcutuzAQxO6FolQTL05+73bidI18LY61TPRPXjJzeEimbnl0TGaXOaGuEaC+SQBkMH2RTZ0EKdi533GDQByhlNcoPzfo7YdVMRS+fFUJ2FEl/4SP5/aUgSOHmmYJIsCBwrDwNo60VIZsp60Ye7K3B7UQ3/ijLKXy53wu9+vtLzetlyQC0eaJK+IK5rwkBPA1tewE8Gyo8sv5bNIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSr8AhZzZy9YNmQrMHUaD8D0vUJjKNZ7avCh0x4w7M8=;
 b=xhJA7CNjqZwoLBxxg28mwWqXtKR2ejAl96m9GzIQSJ/0nWEus8KnW8fEQfU0qMX1Lv+/+yRUVdxxJlAgEtUk2/JPi4oIFdnzBrXcPFHt0sr6cqdRNHpjtWWaD0ZeCVm6s036Ye5EYJtOs2WNsVAKGCF2oh5indQn4KRV0+LiBN0qS/+Cs8hkuukA+i2A173qhSJrcUTL30c1QzNKkEtpGP3LPfgLmkKFxayI+JSAOg5QvGkj5YD6ptST5Ydg3qaiO6HjCbIGYfft7ryph+aVP3ZzFafHJFUU5i9duMdOen++WDRvSXS5OhFjKzVzanwRnroskAfTo15qWGbcggfPmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSr8AhZzZy9YNmQrMHUaD8D0vUJjKNZ7avCh0x4w7M8=;
 b=abojBg3I9UPZUyRdCZ3qbsyyE9vZelSf+ajbvkxxvAXdSBmYOjrfV1IP0Hxq4lyzvUythKIOlJaU0xJ6hZN2RUPY9H4WneL5kKGZJjF9ntHEo8TTcyfzs1bI1A3LmeGzlqoaHvkqy6P4frkcr3lk1SqOdn6cf5hA8TaEarWkYJ4=
Received: from BN8PR12CA0016.namprd12.prod.outlook.com (2603:10b6:408:60::29)
 by SJ0PR12MB6928.namprd12.prod.outlook.com (2603:10b6:a03:47a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 11:45:04 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:60:cafe::4) by BN8PR12CA0016.outlook.office365.com
 (2603:10b6:408:60::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Thu,
 11 Sep 2025 11:45:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 11:45:04 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 11 Sep
 2025 04:45:02 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Sep
 2025 06:45:01 -0500
Received: from xhdapps-pcie2.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 11 Sep 2025 04:44:58 -0700
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>
Subject: [PATCH v1 2/2] dmaengine: dw-edma: Add non-LL mode
Date: Thu, 11 Sep 2025 17:14:51 +0530
Message-ID: <20250911114451.15947-3-devendra.verma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250911114451.15947-1-devendra.verma@amd.com>
References: <20250911114451.15947-1-devendra.verma@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: devendra.verma@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|SJ0PR12MB6928:EE_
X-MS-Office365-Filtering-Correlation-Id: 21c9b83a-bf22-456e-3cc9-08ddf128a5e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZNUExO+MU0okmQTOQsfc6/zBXKAEAq46kdfYiFyd+HP3ONqtjTe15QE3wzqS?=
 =?us-ascii?Q?U3PGrP35TJF/4etdk9S3NaErPyoYURFHtNieWZW6F+3kmqO1jYOtF+/T4iIm?=
 =?us-ascii?Q?/0V7169r1fLCFJmwFSB4GOfuM5Y9bcn2E806RzbW2mJzvyv8Y+SwnUt/YUK4?=
 =?us-ascii?Q?VTgt7F8VJhwooScv1VNOz+wzKWfAvh5lUoJ3z3yEhoNc6tO1KLNZ523uf90f?=
 =?us-ascii?Q?azptBMJmRqS6zDoNCeXg/keDaG7MwwH25NAr/GYsphmopyRqQ09wtfrE5MiH?=
 =?us-ascii?Q?VNWjMf9XBQTXYDMslciQwHhMe1rMJi8A5/DnMMCtNKi//sLlwC2L6DnDbaRU?=
 =?us-ascii?Q?KopkTPYd/8wx6Hu6jwj61COBGduY7iyYuKOduqTVPtl57Rvg4gh//ytb9uY3?=
 =?us-ascii?Q?C3DcYz3MC1XDr+CUwyvBO4bvMgr09L8izw9Pu7ncoqMwE3maA27CwBAWkhRL?=
 =?us-ascii?Q?gWpBmmOv6b3QArRRkrXOEnvDMo1oWB5o0ANNB15ZStX8UGKqSVy2Cj0ppRSF?=
 =?us-ascii?Q?oFejS5iGo0tyXY9EBz4hIAYR5ccljYZEEQ9zPkMxJWsDxaOuww4GELy0YViM?=
 =?us-ascii?Q?cTfjzA9izHs+5JQ1aMR/xfDNFoMJsFUvlFvPPDj4KHblxgpoHtrJLWazbvc2?=
 =?us-ascii?Q?zU0xdppH4gJ0JHXPgaF0cNd8U7q9kH5M0KbDoHAcLogKs8+MnnuhWRf/gDhN?=
 =?us-ascii?Q?DBOE9ppKbL4T8hb9W5N/YS5mOKcqJWp9mokrcx7qbu08yUxhQ/H+wZ16LBYl?=
 =?us-ascii?Q?bgInMzX/Gv6UM36qHmsOU8vWzBk8CWTA7sINTb0UjXmhoXAX53JL3XltJtLT?=
 =?us-ascii?Q?w/u+0ABYLSn8sladQFt38dyenAspYrGTdyAa2EALzsoJd/EFn7rD6PY2HejZ?=
 =?us-ascii?Q?aSCLaGEnKuSccJ1J+GKwQj7+QTEGDxnEdFbhif03ERC3CXDZsiTFP3e/2u2j?=
 =?us-ascii?Q?EcWUFCGPFBXBPngFQB5kPwslPZy4cAYQ89RZy5NMCOFNJYDejy/ot2tPoaMg?=
 =?us-ascii?Q?qwO4MJ0hg8VnDPloxznW2Et8uk4GJHbJXBJTFC0t0kGaDs9HpQWfhG6pL6NT?=
 =?us-ascii?Q?zPR2ZPEG6KG8gCFmzpK9QxhWeabaJTWotQhoBBrt8y8LaHi0oVwH5kayi3P/?=
 =?us-ascii?Q?V/tl0YwfAOYYgUfZ9XVHKYQH/+5RcJcylc9XtMInFC4IsNwQ6HHwDPTznggY?=
 =?us-ascii?Q?/zMX9IqHSno2IyAbaTXhxWE6gcwmuiaa3amoxAw4tTox0/HlVpDoILMkt+aD?=
 =?us-ascii?Q?2mG5aTWtBLk6v/B/x8Y1Y0laxjlyh9btFIiJtdKwKYBHNruo9VH7axbvWHlA?=
 =?us-ascii?Q?iiBTVudMdAeYGDMfae0xC/1ATI3bC4vRfSIswxzZml8+5dLNS4ST0umylmDy?=
 =?us-ascii?Q?4vZE4bf4R32c/OvOl+s+6Z9dp5kiI5ozXiQ2Rr7Olt37riDM3REcBjHOokyJ?=
 =?us-ascii?Q?GI43teE210kaYYs1yKX3d2NpwLN7JMCiJwOZxqNdb3HyvNlmeUNS00h3cmoE?=
 =?us-ascii?Q?bcUFt+8szrRSU015ckLBtKXKq+dl/wONvl9B?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 11:45:04.0571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c9b83a-bf22-456e-3cc9-08ddf128a5e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6928

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
Changes in v1
  Changed the function return type for dw_edma_get_phys_addr().
  Corrected the typo raised in review.
---
 drivers/dma/dw-edma/dw-edma-core.c    | 38 ++++++++++++++++++---
 drivers/dma/dw-edma/dw-edma-core.h    |  1 +
 drivers/dma/dw-edma/dw-edma-pcie.c    | 36 +++++++++++++++-----
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 62 ++++++++++++++++++++++++++++++++++-
 include/linux/dma/edma.h              |  1 +
 5 files changed, 123 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index b43255f..3283ac5 100644
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
@@ -353,7 +373,7 @@ static void dw_edma_device_issue_pending(struct dma_chan *dchan)
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(xfer->dchan);
 	enum dma_transfer_direction dir = xfer->direction;
 	struct scatterlist *sg = NULL;
-	struct dw_edma_chunk *chunk;
+	struct dw_edma_chunk *chunk = NULL;
 	struct dw_edma_burst *burst;
 	struct dw_edma_desc *desc;
 	u64 src_addr, dst_addr;
@@ -419,9 +439,11 @@ static void dw_edma_device_issue_pending(struct dma_chan *dchan)
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
@@ -450,7 +472,13 @@ static void dw_edma_device_issue_pending(struct dma_chan *dchan)
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
index 71894b9..2a4ad45 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -86,6 +86,7 @@ struct dw_edma_chan {
 	u8				configured;
 
 	struct dma_slave_config		config;
+	bool				nollp;
 };
 
 struct dw_edma_irq {
diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 48ecfce..daf1fa7 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -268,6 +268,15 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
 	pdata->devmem_phys_off = off;
 }
 
+static pci_bus_addr_t dw_edma_get_phys_addr(struct pci_dev *pdev,
+					    struct dw_edma_pcie_data *pdata,
+					    enum pci_barno bar)
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
+	bool nollp = false;
 
 	vsec_data = kmalloc(sizeof(*vsec_data), GFP_KERNEL);
 	if (!vsec_data)
@@ -301,17 +311,20 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
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
-		dw_edma_assign_chan_data(vsec_data, BAR_2);
+		if (!nollp)
+			dw_edma_assign_chan_data(vsec_data, BAR_2);
 	}
 
 	/* Mapping PCI BAR regions */
@@ -359,6 +372,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->mf = vsec_data->mf;
 	chip->nr_irqs = nr_irqs;
 	chip->ops = &dw_edma_pcie_plat_ops;
+	chip->nollp = nollp;
 
 	chip->ll_wr_cnt = vsec_data->wr_ch_cnt;
 	chip->ll_rd_cnt = vsec_data->rd_ch_cnt;
@@ -367,7 +381,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	if (!chip->reg_base)
 		return -ENOMEM;
 
-	for (i = 0; i < chip->ll_wr_cnt; i++) {
+	for (i = 0; i < chip->ll_wr_cnt && !nollp; i++) {
 		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
 		struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
 		struct dw_edma_block *ll_block = &vsec_data->ll_wr[i];
@@ -378,7 +392,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		ll_region->vaddr.io += ll_block->off;
-		ll_region->paddr = pci_bus_address(pdev, ll_block->bar);
+		ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
+							 ll_block->bar);
 		ll_region->paddr += ll_block->off;
 		ll_region->sz = ll_block->sz;
 
@@ -387,12 +402,13 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
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
@@ -403,7 +419,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		ll_region->vaddr.io += ll_block->off;
-		ll_region->paddr = pci_bus_address(pdev, ll_block->bar);
+		ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
+							 ll_block->bar);
 		ll_region->paddr += ll_block->off;
 		ll_region->sz = ll_block->sz;
 
@@ -412,7 +429,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		dt_region->vaddr.io += dt_block->off;
-		dt_region->paddr = pci_bus_address(pdev, dt_block->bar);
+		dt_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
+							 dt_block->bar);
 		dt_region->paddr += dt_block->off;
 		dt_region->sz = dt_block->sz;
 	}
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index e3f8db4..befb9e0 100644
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
index 3080747..e14e16f 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -99,6 +99,7 @@ struct dw_edma_chip {
 	enum dw_edma_map_format	mf;
 
 	struct dw_edma		*dw;
+	bool			nollp;
 };
 
 /* Export to the platform drivers */
-- 
1.8.3.1


