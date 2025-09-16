Return-Path: <dmaengine+bounces-6534-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BF6B59597
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 13:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B6AD4E453F
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 11:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD3530C634;
	Tue, 16 Sep 2025 11:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lLPJGiYR"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011044.outbound.protection.outlook.com [52.101.52.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8FD30BF6B;
	Tue, 16 Sep 2025 11:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758023668; cv=fail; b=i6lwwsiPWTi21NGB9FRKJhqwS7QxtUI9sHv0doeu09V4c2EaXGW0CO9NXGgtCO8FgupZNx7Q3F6kP/gIHUOwR1pv+91VtJLZBC1ZFtBE3TjWPIK6rT0CShwExA/ADarT1+vpjH2AgDdykq6j4RY5rX8AqiAged+x3/SKK21Xxns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758023668; c=relaxed/simple;
	bh=+GilGKbCiaLmYHYoaWZTHK7VYwzhh1xBavpUhUmSOmA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YSotwn3LRshzId2j3oUDgNLH3iB/VUatGul7EXh1zXSv3rN30KyrN32Cihs9+PqfCEUNr4vNmaLXMOp/93J8vFC5EFdE8S/Bt0HhVzO5/rv/B1RsNQaCMzWFHwH6RgOnFjd+s4yMCFACvrrfuxY2rwezgvwdglH2++X6uQ1AbOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lLPJGiYR; arc=fail smtp.client-ip=52.101.52.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eDATAwnSCVeD1qNISTytmh6scjzRe3FagnHrYHByeDTDg/mh9QVb0kPFQvn26FMUYaBKKKNoYLICe/cno/LTVWTKbhWf74cSynSTnJx18h0NuclmMqUrI5L7pXpJXNhEDfr+2WHyz46FqjbgcyYQuBBFkKvawl2U8J4ysy/7z8QCnnIl9JCzEOD/76xN7HTOsegCXlc+ydLqBpfiA5hY6op9sp5+0qq3/n5qrqNbffyBot/VwmVACHuwFeC3+wkT9hbIYHAUvYN/3d0sNP31Qn4qu4glJdqjeJOPKlbtRwjziPt7GJAUvrIboAqex5so65MS+TT8flvFyBSW80L98Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9ETbbuGkYcLcHAOog2seMpN9qpCIQ2wCdtkHWBHni8=;
 b=pBv5nm9aFntHbjgXdwlebSO1AMGPDlh0GRLlE7cm19jbYfJnaacxq72MV1/l+Dx1w/LL/RMI2/uhHrbwwCE1vjDBBeOxpW2XIlC5KfHApC5KdF61VtlIfTmSxB0QCH/W0rg8OlS85qojiIAIKKgzoPR8XyOblJ6VQyxWawCoXsNWhcYTy/OwSiOfSEoKXwaa4TqK9XsnOWGhmA+V4ThbTeJR92vXSB4xzezbHtZ2XOSGLQUMiJ+Gg10MacZs1bI4S9kxnTBXGhMSkzzAZOhv9QXqz5H4F4jfN7Zwm4fVqvrgTt5Qsq6SiXcML1lULSRlx0MZA1tJIM2Lu6Q2YSkgWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9ETbbuGkYcLcHAOog2seMpN9qpCIQ2wCdtkHWBHni8=;
 b=lLPJGiYRmDc56lOgqSLJAXtNP1P5LI2fKEr1SGrNpMFkfH1u7aoQdY9z/PMIG9J1acypfSpUmeTzkAIDOtDE5YAfVczKG4aUUR/gkQ3Xb//XBdtWvXuAEu5Wgws5/oVnAqtvUCPqJHQx9/qflvfeoxJ3qSnXBfIwSJjcvzES15Y=
Received: from BL1PR13CA0016.namprd13.prod.outlook.com (2603:10b6:208:256::21)
 by IA0PPF0A63E7557.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 11:54:22 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::50) by BL1PR13CA0016.outlook.office365.com
 (2603:10b6:208:256::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12 via Frontend Transport; Tue,
 16 Sep 2025 11:54:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 11:54:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 16 Sep
 2025 04:54:21 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Sep
 2025 06:54:21 -0500
Received: from xhdapps-pcie2.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Sep 2025 04:54:18 -0700
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>
Subject: [PATCH v3 2/2] dmaengine: dw-edma: Add non-LL mode
Date: Tue, 16 Sep 2025 17:24:11 +0530
Message-ID: <20250916115411.23655-3-devendra.verma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916115411.23655-1-devendra.verma@amd.com>
References: <20250916115411.23655-1-devendra.verma@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: devendra.verma@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|IA0PPF0A63E7557:EE_
X-MS-Office365-Filtering-Correlation-Id: eea3a78d-9cd8-4aa1-acba-08ddf517c6b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hLoTOdlySOCiI0gCfddM+u/N8ru13Y68IZYBp4GpjB6s7uoaxHgghBfa1nXF?=
 =?us-ascii?Q?bV6KFLGrtQ1wX650dyxvc8zKAn9rCacSzfv8uKrLdDfsWYX42OeNhbZPwEI4?=
 =?us-ascii?Q?sKx3vUHDhTjLpV2b1A3IEpM/pepxJ1JtoqUnabdA+3BYraytI4K4naT6rJV0?=
 =?us-ascii?Q?BiCZB2CK+nfSaBVttXTTA12iWWJ2UrR5qimYAPIA8tTOmh/x/1gwO3PB3ImX?=
 =?us-ascii?Q?+ayIxNDRVBTM7SV4ydcCa9mi3yoNnXEB2pk8SG3ncObnTjCDXuvJpthErg2q?=
 =?us-ascii?Q?Yg9/ClHzPL6+sDJK1aYRrxcFuib96JWgn/FML0EmYszzQfCSbzEY6UPstTxC?=
 =?us-ascii?Q?DKUG2RYsXGXa8/DY1/eCuWWFhVSMy3cUFFsnownZ4X7Db8ZBDhlrGy5FEKVC?=
 =?us-ascii?Q?8Yq3rXHvV7NIHkMobp0qw0VoUO2uavexxZANAvTk5XZejdGevzockGK3V8NX?=
 =?us-ascii?Q?RcvkdhcEyyUJyPhPL3PekhP4rQzH3vmuMFAe1ZcLfREIzTT/e/mxNb7Fk6U6?=
 =?us-ascii?Q?jF2p/ZFFmcCj45He5gj/IceWLkzh/DXIVOoXx7cu9TRGWXVMazs8MN7glZ2P?=
 =?us-ascii?Q?9lzxKYsZDCn/N2tq60AGOumTURzz1PEQhGMRgZJzLiZWOTrcQDNJ7UkpKF4i?=
 =?us-ascii?Q?PIvWE40PeBtzbUeAUq+TVxn34Y1LPM51eq2CmDqdNgU1eTYhlAV2C+EqmL78?=
 =?us-ascii?Q?W6T2UASOf6pXeb+tyfqEMNVMY/8gsTpl9xO24xK/7LdkFP+OYtTk7BF8bTaF?=
 =?us-ascii?Q?DCD4R4noHh5DCzJCRvEx38aTh0V1YyNE/sYyBAscapzMzbnzVSc2gCdJP163?=
 =?us-ascii?Q?OChyMrCpQ+8wxIZac5Cy6+XxW6fpM+uKQmmGNj/lEHvpJH8U8UFaicnTa7dZ?=
 =?us-ascii?Q?UgrKgvLD29O25LRIJcLTL9AaI7wPZAP+AhODUKvHDIkobmWRipfEz5b8TYI5?=
 =?us-ascii?Q?UirRnfibDnTh2WGyI+lIqQPImjLr02yUDdODBS5EKQzNCr3XkZg5adGAjAv3?=
 =?us-ascii?Q?iGb50Kq1eHf9KAqgv3UQe5VK7kM/j/a0fKmhdKu/BuBelbuFw/EMKzHh5Ttr?=
 =?us-ascii?Q?hxpIAufD56Tc06BdhSfYUB8de/xtgBRSuRR1vmaixgKRzipJ8UGvbpkRqMfk?=
 =?us-ascii?Q?JiDFKKuANztjklfpXrWp/jjUlwP7hWQm0qEYzNlBPA7nzFu95bTGc9ITaBSu?=
 =?us-ascii?Q?QtV1IrHQOJ59dQAoUP35DacnmlDt2TgcZBCri1iWn5b+3TSEkVyzvtjwkeyB?=
 =?us-ascii?Q?MEajXwIde2DqOndo+hVHorRkAOk3V7vmFBGOE1ELlBaWbbFPTttMVhJ6I8WB?=
 =?us-ascii?Q?7OJX6D3+fsSXWZVIeDw4Q6LeC1Um/su+75Z36p+TmR+m7OgC/lHP0JTTQ2n2?=
 =?us-ascii?Q?3ot9r4U52Ofufky2LP6uic6ojBZ+qKxtWBcg6Z1IBVBYOpmeP5l6AwSjigoD?=
 =?us-ascii?Q?1PkE7wTUIAwmdb/f2FRbC26jfPp8OGST5ITFWpKCzZGcdjujWY8VPmZtDamY?=
 =?us-ascii?Q?QlHxdM2GJVEZEp8FRMQLAh4LPV+NyIJd9Pgg?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 11:54:22.2566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eea3a78d-9cd8-4aa1-acba-08ddf517c6b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF0A63E7557

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
Changes in v3
  No change

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
index 7549125..68300fa 100644
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


