Return-Path: <dmaengine+bounces-7281-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B3273C78D44
	for <lists+dmaengine@lfdr.de>; Fri, 21 Nov 2025 12:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 321123652D5
	for <lists+dmaengine@lfdr.de>; Fri, 21 Nov 2025 11:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BA734C154;
	Fri, 21 Nov 2025 11:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L4d4gklL"
X-Original-To: dmaengine@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012015.outbound.protection.outlook.com [52.101.48.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FCE34888D;
	Fri, 21 Nov 2025 11:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763724915; cv=fail; b=cNwHIeTMHXt0CDepWeyXOudh3wbFhGFU78WGLf9OHXtirsKlBCj9YMhNvzsoCOsTycX5t66hag1DMBHNmlBMkVbv8kouewRlyuvrJewthjIoU1Gsm4OfnZm1oHchYg8Gl1ytMe776Ci20E+TWkKRpD4btBRDzmsIK5Fy6RsdZBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763724915; c=relaxed/simple;
	bh=FlnavPYSETihk8gUzTBC49yc3pUQR57XuZ7loNhqJUo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TWGVu5m+0ihxsDnlTmzrmuLFqstz6ZanEx+qnktxtktw5ZgFSwj91lNGmc7sZm/18b1zvja///rSkG/FVCEkfMYTtN+or/D3ASs0u3EgIADyvwdaHcoa/SVjoPrpaD6VK4NwSvzZ1Z43G0kyutnUpQcH9MAE1N22bjTvZSXBzts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L4d4gklL; arc=fail smtp.client-ip=52.101.48.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9IsLfTocx8SHiLPnwl2jNANUeqmRzfvyRtH2WmBYeuteSNpJAZ4RxpL49JQMkopaPHjVren7EO/LcCGtSUD3qorIDaTNCrlRkn05sLMLc8WsILyAo2BivrF/jpswMWvMCsHJsFbx6y0hptmVgw1Uy6dyfxXgAr+RksE7iWmkyuTDuxlqn1dqx+V1OpGjf2iPTBWAGTjpQ1wc9u9ktPCS82bY4jYLg9+Dznv5QSHf/i/DBuQz1M87dvcUZWPHEZpamHObNs7wHdTR2ph/HllSx0gW8oPKXUxazaa+EELxXByzGTICJiRdME+4NTU42xHDwUPIzZaxqsYy8A0cIKX+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ER5RVZfHRUhwDhGFD8g3Lu5NcYprNJZGO7ijbgkkS+g=;
 b=si3/VZ2SMQuY1ck7DSM/yO4cePrb2q5SCtmZcjTuO/FS8wsj72hFjmh78R3+21+awHQ8RJMxdnFNA+g3rOTkvqIESw1u33uCXti7BRdjsz07NtRFAdsVxbeYgzVwIKX9t3ihRTOWOxmmsCQUzGDgh5DzTOOmmBmIO4So1GO+0fVK2sZ1k2M72qlJw089ICebwu6AiTw9ra7POiqdKzJ2TUtR3f2YnbBg80TDVInHQHV1W+bfUjZidDZR8wgEwtb2LVGajHT4SNbSDj5m4fZkIoTjkND48H6iqiYEGctFPfoTbb9WkYTTls3bD1Tv9qQ9IWiG8v14LSbB70eEy8Tsgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ER5RVZfHRUhwDhGFD8g3Lu5NcYprNJZGO7ijbgkkS+g=;
 b=L4d4gklLzfvp24WmYuZCfoKVvYMARq3wfXOfyhvm8sSiM1UCIbjnxX0s4LUhj0vC3fOeqGDhvcHAfyNhdzblfVULizkutZnPq+fZC6+EnaC0CdAC/xqFNY1DGPlB0Io6RsrYZ4Xii/G9YlZxs9KFDsmPLFlAXDi3ycG4RgS5Ud4=
Received: from BY5PR17CA0015.namprd17.prod.outlook.com (2603:10b6:a03:1b8::28)
 by DS4PR12MB9657.namprd12.prod.outlook.com (2603:10b6:8:27f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 21 Nov
 2025 11:35:06 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::be) by BY5PR17CA0015.outlook.office365.com
 (2603:10b6:a03:1b8::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.12 via Frontend Transport; Fri,
 21 Nov 2025 11:35:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 11:35:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 21 Nov
 2025 03:35:03 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Nov
 2025 05:35:03 -0600
Received: from xhdapps-pcie2.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 21 Nov 2025 03:35:01 -0800
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<Devendra.Verma@amd.com>
Subject: [PATCH RESEND v6 2/2] dmaengine: dw-edma: Add non-LL mode
Date: Fri, 21 Nov 2025 17:04:55 +0530
Message-ID: <20251121113455.4029-3-devendra.verma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121113455.4029-1-devendra.verma@amd.com>
References: <20251121113455.4029-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|DS4PR12MB9657:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c249771-d1aa-4ccf-f638-08de28f20481
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+GAeFr5nps27Y7xHDbEAxRntQCqzWQgDtC9RdGousxopDUldwOq1v7nX330G?=
 =?us-ascii?Q?ngrEG/q66WMigbX6iRuxmb37uTLwiexYSaykaySGfyrM6TCF024HVVRCydZ+?=
 =?us-ascii?Q?brLZmB7IajXSImFus2EPATr7CtXCcWSAQyz6w8DY7gAaIO9L7EPkDJhIUd0K?=
 =?us-ascii?Q?35CIWPZkuLhXSbZ6SHq1RDp2SA1zEWmsZXM/c2/F+EvbxOkf0pfoAGx179tT?=
 =?us-ascii?Q?A7kGIgJRCcnCN6W9UCLbAcAN1fey3OP4AlfXW5/e1RBlbPiX8ri5xuiBkuQk?=
 =?us-ascii?Q?8Tm3GgHgRWmlmxqeNhJsbTI3gNRF5Rh9LRlHHo2y1P5BRoaha7VqoXXt4vqk?=
 =?us-ascii?Q?t+GCnEB/TLgbPabuycN5WA2DcTU9rqqNn2smP1YJXYzsqGeKEWZBoZ1xXqEj?=
 =?us-ascii?Q?KjtIg2tHqyZso4Z8vWgELdi+OtAeoad0cvmNFgwc6fzRpRqpZs7nGpuv7x3c?=
 =?us-ascii?Q?sHqsZxDhIuSPKOympIQgq2eCksxXq5+8yAikwDtx0v3muxGH3j46/GJeODNx?=
 =?us-ascii?Q?b2HsOGFXmvEMmWxAe4iByooFrnWWdsl3cr2YwqDZISDk7H35kZWzfk/xLdoV?=
 =?us-ascii?Q?7OGenr211iDXfRAIaLX1UHDoswxU/VpnVt/k0o6kE/CBV6AZoK+1eHQeHFn6?=
 =?us-ascii?Q?Gd9CV1gHh7AybbQLo0LzKj7P/0nW7NCYSwdIhbB47seqbiCtNS0zwKse9XZl?=
 =?us-ascii?Q?kMHw8AKV7WZGVD+p+X7ER3mME+1SS9PKceaiFPKAGD7E7ACLup4x6qzSQqDY?=
 =?us-ascii?Q?1D/l/Jd7BN9pugTbOMMIfCc58dvDc7HwPOC8JKP34+DUBlKsQYObd0PxZCD5?=
 =?us-ascii?Q?vlWfDITwsqNLY8ww/gGtkdf32IDCMAu3fK7K47KUYKqBft8uyMw9RYvBTbU6?=
 =?us-ascii?Q?ywCxjQSonsL4u0SWXb+KH8Wv3vVTdgcyyzVbwqRn0J2lzdL0nUKvN0v7xEcd?=
 =?us-ascii?Q?9XGZwVS7l0hPyf19PxMYuvaZSwRqkbg5dMzqWCHftPecLYl3CBxl4h+a4OV0?=
 =?us-ascii?Q?kKwI3ZRVTIdP21h9Ti8jd0yvlUVvMDQRJWJf+P+ARQD3BzpJGO0ySTKIaMpj?=
 =?us-ascii?Q?JFmsWaGWTqVwlC2QAsjj/9U9TNxo4JSYa9OdGWIZ06wMjZ+3LqZX/ECgwrAr?=
 =?us-ascii?Q?al7FvCYoK2PDZdlG3QN4he/FH+xBxtoNoJw5XdKUTp6Oxl3EHbSRMVThIib1?=
 =?us-ascii?Q?f1wPnn5K4g5cuFkd/UFem6cW0gzolEyoViB2NszO3Sb517kiz/DB71UVR8ox?=
 =?us-ascii?Q?y3C9EHsE1G50Cak1uRqDgi/WeJ5vyUCs+TyJ0oapes82ysQ7eSsO5EUGttpF?=
 =?us-ascii?Q?89w83FvKzFkvnLQxnIy6DCims4wqO+PA+CvnFbcwDM/npn0W7BcFpBZXLeNu?=
 =?us-ascii?Q?NpMqh7kBa4cUax77MWIBc34j+zCwPKasaIRaLqlI4bqIZGrNXRV+AfIxL+kk?=
 =?us-ascii?Q?PsJRz59aTvRvgS215ZPYH1LravHNkMXg7F7yg4La/xVkxo5xuZF8he4eAm1B?=
 =?us-ascii?Q?UYUnNfcc9qJAKQXS1UjLjq9H0xW2xl5J55Vi7C4TLI8RuzMd2mqB2EeYPO1y?=
 =?us-ascii?Q?mvx/Hhg6r5KB4ER4L6s=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 11:35:05.5232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c249771-d1aa-4ccf-f638-08de28f20481
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9657

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
 drivers/dma/dw-edma/dw-edma-core.c    | 41 ++++++++++++++++++++---
 drivers/dma/dw-edma/dw-edma-core.h    |  1 +
 drivers/dma/dw-edma/dw-edma-pcie.c    | 44 +++++++++++++++++--------
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 61 ++++++++++++++++++++++++++++++++++-
 drivers/dma/dw-edma/dw-hdma-v0-regs.h |  1 +
 include/linux/dma/edma.h              |  1 +
 6 files changed, 130 insertions(+), 19 deletions(-)

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
index 3d7247c..e7e95df 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -269,6 +269,15 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
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
@@ -278,6 +287,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	struct dw_edma_chip *chip;
 	int err, nr_irqs;
 	int i, mask;
+	bool non_ll = false;
 
 	vsec_data = kmalloc(sizeof(*vsec_data), GFP_KERNEL);
 	if (!vsec_data)
@@ -302,21 +312,24 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
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
@@ -364,6 +377,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->mf = vsec_data->mf;
 	chip->nr_irqs = nr_irqs;
 	chip->ops = &dw_edma_pcie_plat_ops;
+	chip->non_ll = non_ll;
 
 	chip->ll_wr_cnt = vsec_data->wr_ch_cnt;
 	chip->ll_rd_cnt = vsec_data->rd_ch_cnt;
@@ -372,7 +386,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	if (!chip->reg_base)
 		return -ENOMEM;
 
-	for (i = 0; i < chip->ll_wr_cnt; i++) {
+	for (i = 0; i < chip->ll_wr_cnt && !non_ll; i++) {
 		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
 		struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
 		struct dw_edma_block *ll_block = &vsec_data->ll_wr[i];
@@ -383,7 +397,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		ll_region->vaddr.io += ll_block->off;
-		ll_region->paddr = pci_bus_address(pdev, ll_block->bar);
+		ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
+							 ll_block->bar);
 		ll_region->paddr += ll_block->off;
 		ll_region->sz = ll_block->sz;
 
@@ -392,12 +407,13 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
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
@@ -408,7 +424,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		ll_region->vaddr.io += ll_block->off;
-		ll_region->paddr = pci_bus_address(pdev, ll_block->bar);
+		ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
+							 ll_block->bar);
 		ll_region->paddr += ll_block->off;
 		ll_region->sz = ll_block->sz;
 
@@ -417,7 +434,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		dt_region->vaddr.io += dt_block->off;
-		dt_region->paddr = pci_bus_address(pdev, dt_block->bar);
+		dt_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
+							 dt_block->bar);
 		dt_region->paddr += dt_block->off;
 		dt_region->sz = dt_block->sz;
 	}
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index e3f8db4..ee31c9a 100644
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
+	if (!chan->non_ll)
+		dw_hdma_v0_core_ll_start(chunk, first);
+	else
+		dw_hdma_v0_core_non_ll_start(chunk);
+}
+
 static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
 {
 	struct dw_edma *dw = chan->dw;
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
index eab5fd7..7759ba9 100644
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


