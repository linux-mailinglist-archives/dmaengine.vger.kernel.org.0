Return-Path: <dmaengine+bounces-6530-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B26B593FA
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 12:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C4AA1B21A86
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 10:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658853054C5;
	Tue, 16 Sep 2025 10:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FkQhI2QZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013012.outbound.protection.outlook.com [40.107.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B9D304BBE;
	Tue, 16 Sep 2025 10:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758019417; cv=fail; b=iHYsFM14HWzs3QBeCUfb7OQNQclB2ujEovJ3VVSYrlpViQz+WH5M9CxflVh4wHVqSP+3eGvljEmw1QVVL7EzbbPVINYNWSVXMjhmMbOFLMbNTIBHO+vDFPGEQObh3S0wsLXntaWrRL5Hi1IA6l0mqaND/vqAAS/VJaBB05Pm1ZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758019417; c=relaxed/simple;
	bh=FoMjDkXvd/oT1Sa7ZiX9+QrF1nwusjmlyLQd1dmxm1M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LwSXjHPo6fgUnWaP377bQfnFbqrx7JvhZ9xCbe2NI8dC3+ZUKJgfpG2//3G/0EZ3/26TDkUpKdm+7NYOYLeTCNKnSNcdGIVb5H6qOSvrZZV7IB0B0If3RF6Oo5Ohc07jI73CVW/EyFOx1ctAr7rYn4ozqS34/0/q0vYD6AzsRNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FkQhI2QZ; arc=fail smtp.client-ip=40.107.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xa82SUI5Y27b45Tf+krq5jORJxbHyHCAliOriVso+BPOvLIviM1SioXk0zNEkO+yFu8WU4a86+1hwo15yv12yVRyt6A6GlBuNrCRQ+lHDj2HOWs6WQIOQouqiSMmM5R+aqah3i4u1SGVkPOgF3LZQuJIRV7Y0/Y8GO4dnVBEOfYKZon30igG260taVm+frArp10n5eLIbXTr7qkdldgfTotsURh1Y9LgcqROsHlaSi1cDVaURTT+aYCz3KAFqSt23W5+b0nouwrGwBrxyjELnYf+n98sx30bTsKO0e0jb+X2N16yjuzBjgyaw9BXFXivDS6MgXjxeivhjSSIr2/uaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0V/QvXP/dRi3eYLXsSuOmHix5yehVqk3GeWRDHfHIMQ=;
 b=trD+bX+qVft1vMMCiee+ys4Z9wCgnqZrgQYilDXzBFQfJDHpr4wbD+lVN+Pbo1ATL68X0YM4XJcDyuQpGaqTHE+wH2jAlzlryBYxc0APDdiI5kmvUm0XJgCdKZstqixhhs9Cf+SttXdv5oITzQx0GPqT/HdagzvtYkHNlGE5GO0HqpqfDnWDo1wUyNZCq23x4a6bvkAnqNVxaeTlSVM/dw6ZjuH7DcZxXuIKVye5HXut4K8/RfhqOZyvzA6Bdlfj983/WJY3YHtUPqAWCsbM8oBu7dqhGMVgcwWdbK4KZdzYzUpVNTjF3YYU8Pygbj+jaVYkZC3VayqTfD7Y0j5Iew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0V/QvXP/dRi3eYLXsSuOmHix5yehVqk3GeWRDHfHIMQ=;
 b=FkQhI2QZ+ErTnEFJ5F1y6nCz+FPsvA5XCrXuPJTTPV/JWCIpbwUnwZhd4I+MiDZAvfiUGWCb/W7uISznW8ZAUppjpDiywH71rPBJ0bYCxgWxyvIT3shJucRmhSR+k4NLVtD+NEmGdxZs5N/OxJjMiibveE3f94ymDoej7o2l4Xs=
Received: from BYAPR07CA0020.namprd07.prod.outlook.com (2603:10b6:a02:bc::33)
 by DS4PR12MB9748.namprd12.prod.outlook.com (2603:10b6:8:29e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 10:43:31 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a02:bc:cafe::4d) by BYAPR07CA0020.outlook.office365.com
 (2603:10b6:a02:bc::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Tue,
 16 Sep 2025 10:43:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 10:43:30 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 03:43:30 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 03:43:29 -0700
Received: from xhdapps-pcie2.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Sep 2025 03:43:27 -0700
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>
Subject: [PATCH v2 2/2] dmaengine: dw-edma: Add non-LL mode
Date: Tue, 16 Sep 2025 16:13:19 +0530
Message-ID: <20250916104320.9473-3-devendra.verma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916104320.9473-1-devendra.verma@amd.com>
References: <20250916104320.9473-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|DS4PR12MB9748:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b132f78-d5ed-417c-bad6-08ddf50de09a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H5Y2+qT8uFZZHpV3eACmZE0tuyVWDcBqmLln31cNUexTxCtp5sMrZ9d7PidW?=
 =?us-ascii?Q?cEbIHaJYUoY9dJ2f8efIKqpoUofAqctp+efClwQP46jK8ZajmwmjZY0y27zZ?=
 =?us-ascii?Q?2xKBaoHxxPQKMRNfRTv4Nv5EtCtOXACqjLZErizqVi4UP/2XTwQaVQ2P4Xdt?=
 =?us-ascii?Q?Rlz9R00mYxZQvVPKk+nLxmSffwhoBvoelpqp1YVJ5jqAmLCVT5uNBpEP9lPx?=
 =?us-ascii?Q?1Ekk3GMi4Vgnb3KuIWmxBCyHCie05Lq25zVUDW0ugPseMMN95PzdGQDTxry3?=
 =?us-ascii?Q?Xx2K42BoRjd7fYiHl8p5kDMROwzs3nZ+VSz2Y+VX+ftBs9FiLklSoU08mLX8?=
 =?us-ascii?Q?wCEmfSvRVxtQHaxuul+m+Z2CS6nFPSVahFzWm+U0O3vNXI6oa8q3yLyswKAo?=
 =?us-ascii?Q?iK2o63eFc1sZvGj5LlCoOvwstA5IXe0gZhJKoDKRCAclGr6XF5RDnDAm021/?=
 =?us-ascii?Q?llITi2b36KN2hoMUMxbsoCd33xITsCNW3xiQAycgx9JM1cg/G/P6gH/4pD7T?=
 =?us-ascii?Q?rYj7P/x4jg6A5Pav18cwoZiWplCTTnHSbisfDEw3sjpq5txIoGSNMyONltAA?=
 =?us-ascii?Q?kv9qA6mkB76cCiRzldjZ8WAqhbMQw1T65LV+kgh+QBCuEIWblBPeEgBn1k97?=
 =?us-ascii?Q?+6z7KfknmxkgiIgPTjeo4OIWdBlKx0ZcSdn/gqD2qCQWtPSoMJqWqFBY23AM?=
 =?us-ascii?Q?AP+4JNzsggsDiAxFkMRk3/ngjMVOsX9HE9iqq6ShS1YFFtV4Qd/g9dOaDEeA?=
 =?us-ascii?Q?hPUokvxYYVz5vJKhyc5NZXf01iFRvQdwnT7eqV+Mh5K9fYxRiPQyUOgegPn8?=
 =?us-ascii?Q?ta8erxetDT6Jfa9JFx2OlytoSWVRjoTesT9HlZYM0FDaz/r6kn762ucGofI+?=
 =?us-ascii?Q?Xpzwxu7sSetgmppN+MF6H/MUh+Sqq2EHBr/f3PsjcV86bOzdS2TG2iHR2UFE?=
 =?us-ascii?Q?rsHsAP5+JdPkgJYchm97Ykz67rNLDgeYWmBJ95yOSxcMkmFk7DOWgwa3vslN?=
 =?us-ascii?Q?QfBllWmTI+6XT8FfOHi2tqjZ+98bucJw7iolpUyoNRJq345slbUSRnRWyO7K?=
 =?us-ascii?Q?0x8Giu8W3Ux0royAiThlyd4gL6FSRC3AAfn94qMyxo9suIX2Ho54mHZOzNxM?=
 =?us-ascii?Q?wSEf+qnoPMLFOiN261dDIPmH2azMCJaCjBvsh3WGbqlAX59HDbPnMSO+l3M2?=
 =?us-ascii?Q?iO+6LkfV6zW4Q6UTBFEWH4RA56pEr6wk5rZQK5ZBuzQZt8LwKu2uyk3Lt3f+?=
 =?us-ascii?Q?uAQzqevqfuc39OJp3l8IFNiSgZQR2M1xhoKUDDw9y28/YXolq4lUFkLyZaSi?=
 =?us-ascii?Q?xISbrL6etRCeJibX+9+Y0QwVKGssCU4WqB4mmsTKVMN5oX8WrXHO2lO0lTBG?=
 =?us-ascii?Q?1cgXneuEm02Gb9hqCuQdbNRDO7FNd+9wtQyzgXKwdrT6aHqRx0KB0LKKL1a1?=
 =?us-ascii?Q?jwsk/z6ZYuognaig2yWBALCjdnCYykaW6K6pZQuDETtnp/dcVO6XHH6iLwtZ?=
 =?us-ascii?Q?OjZ/FyEDYyQUxv5msCSPOl2NfyKGqL4qcJOT?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 10:43:30.6759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b132f78-d5ed-417c-bad6-08ddf50de09a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9748

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
Changes in v2
  Reverted the function return type to u64 for
  dw_edma_get_phys_addr().

Changes in v1
  Changed the function return type for dw_edma_get_phys_addr().
  Corrected the typo raised in review.
---
 drivers/dma/dw-edma/dw-edma-core.c    | 38 ++++++++++++++++++---
 drivers/dma/dw-edma/dw-edma-core.h    |  1 +
 drivers/dma/dw-edma/dw-edma-pcie.c    | 37 ++++++++++++++++-----
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 62 ++++++++++++++++++++++++++++++++++-
 include/linux/dma/edma.h              |  1 +
 5 files changed, 124 insertions(+), 15 deletions(-)

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
index 50f8002..4d367560 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -281,6 +281,15 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
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
@@ -290,6 +299,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	struct dw_edma_chip *chip;
 	int err, nr_irqs;
 	int i, mask;
+	bool nollp = false;
 
 	vsec_data = kmalloc(sizeof(*vsec_data), GFP_KERNEL);
 	if (!vsec_data)
@@ -314,17 +324,21 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
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
-		dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0, 0x200000, 0x800);
+		if (!nollp)
+			dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
+						       0x200000, 0x800);
 	}
 
 	/* Mapping PCI BAR regions */
@@ -372,6 +386,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->mf = vsec_data->mf;
 	chip->nr_irqs = nr_irqs;
 	chip->ops = &dw_edma_pcie_plat_ops;
+	chip->nollp = nollp;
 
 	chip->ll_wr_cnt = vsec_data->wr_ch_cnt;
 	chip->ll_rd_cnt = vsec_data->rd_ch_cnt;
@@ -380,7 +395,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	if (!chip->reg_base)
 		return -ENOMEM;
 
-	for (i = 0; i < chip->ll_wr_cnt; i++) {
+	for (i = 0; i < chip->ll_wr_cnt && !nollp; i++) {
 		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
 		struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
 		struct dw_edma_block *ll_block = &vsec_data->ll_wr[i];
@@ -391,7 +406,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		ll_region->vaddr.io += ll_block->off;
-		ll_region->paddr = pci_bus_address(pdev, ll_block->bar);
+		ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
+							 ll_block->bar);
 		ll_region->paddr += ll_block->off;
 		ll_region->sz = ll_block->sz;
 
@@ -400,12 +416,13 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
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
@@ -416,7 +433,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		ll_region->vaddr.io += ll_block->off;
-		ll_region->paddr = pci_bus_address(pdev, ll_block->bar);
+		ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
+							 ll_block->bar);
 		ll_region->paddr += ll_block->off;
 		ll_region->sz = ll_block->sz;
 
@@ -425,7 +443,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
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


