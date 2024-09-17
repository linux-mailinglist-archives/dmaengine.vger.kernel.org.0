Return-Path: <dmaengine+bounces-3178-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4AD97B2E7
	for <lists+dmaengine@lfdr.de>; Tue, 17 Sep 2024 18:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 204941F22B40
	for <lists+dmaengine@lfdr.de>; Tue, 17 Sep 2024 16:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF76173332;
	Tue, 17 Sep 2024 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GMwmAQke"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FDE16BE39;
	Tue, 17 Sep 2024 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726590017; cv=fail; b=o9tKN4U3lsKWcceR9gphJ5V7HkPhsBvogvYrkCdobgKskTuS4u/bbO/l68T2otumtBQA7ksU4tR3LBXzdYwekyhyGd4QBDkYIWmHDJYDbrpXOHsXQ1auXOatTAY4Uu0P5nUUHBTJQ/VeDo/wTLGvQ3e74POYwNfCnf5cOGyzaNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726590017; c=relaxed/simple;
	bh=N11dMpaf1O6yuo0CpUGQpJ/D9Hb6wiKYNurL1kgaBM8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ug4AfjN7aDohArqOLhe5u9nmfKSm/MEKlVpP3v3u1avCKE6jv0I8YNY6Jlr0614Eg810wKBDOQVxjxTaTSYZ68Ajs4mBAnkS6tFL5j6eml+geLlmjM6U5OJEdwRC0GB3pxZ++wDCWNK0RwlSFuOEVGsbDcTWg2VrZ+nya+GiRxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GMwmAQke; arc=fail smtp.client-ip=40.107.244.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jd7yFzcIDxy8NBi7rIP3pxqxX6NkMNYFfoi6n1u/a5yJahBh3EABtBsJb5xNe4hKhmNb/PnzvpSAOfC/3CAakSJMjhsZlwFeWfVzPKdKKymZYvWJQL3gk7bvuw9AvIzsxTiR8gU2LKWjARGuyXJhKw8h362bHSZux5gxYG5PWJpdZwSwxwLE+/Ee5T1LQ5ZPCowCbgDNyoC3heewbost700uypXQnql/kws0dod7JgOGAs6YhZKF7PwXSQ6DJWrFayY9R20CHJAehyqk2hOrXf3rdEbKnJroQ0noXTXKTISlQe/O/OfQn12CfXWfo5lcrKe+HYRuv1xI0mxEfq5Yrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2DI7nrd8Vhb3F5CPNR0qJqzgIvdcJdb7XJnzvHFSBY=;
 b=w8EGpADxqgWgpMrMB6C8qICN9yoB590ejNCo+FwRu2xvK9rAFca88ReeWgnd2gjj9wE1Zvaki2CFxhrTlgcHXvcFPA0HUjXJzb/gT3CcFq4owmqG26KUzpY8N4Xad88KL0+Ps2ood0L4mBz6CrOwL5EK+r2WzVyr7jol9GXqVBbzltSGrhZTMd/KvjHkf8PzbyMD5jK2xIFlG0f4/icaQoRGZZxDCC2xbETh8DCqgvgD5FGfw1hscxvKZiBPM4WF+xC6lUAGjpARaMGPF4QbckVHP4N6dxyT82wQiMAVkCvWSHJ74rH0W1CBqM+2XI+Y7BVivkqcRAcB6e7XYOkf4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2DI7nrd8Vhb3F5CPNR0qJqzgIvdcJdb7XJnzvHFSBY=;
 b=GMwmAQke2QSQCdHWWzQI0OBCM8YU6Aqsczwyt+es4DBinGykRibYHbMyRhWlBqx0tNQJqVWK0GcEp1kUx/pN0+j2gZKY7APfByXCgKFSsweL7sut0cKcz59i+4WkULLJqbTUlTUUy6PaFHICHnyh6bck61wWdxyRrqR0hViHQJQ=
Received: from PH8PR22CA0017.namprd22.prod.outlook.com (2603:10b6:510:2d1::13)
 by SJ1PR12MB6244.namprd12.prod.outlook.com (2603:10b6:a03:455::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Tue, 17 Sep
 2024 16:20:13 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:510:2d1:cafe::b5) by PH8PR22CA0017.outlook.office365.com
 (2603:10b6:510:2d1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.29 via Frontend
 Transport; Tue, 17 Sep 2024 16:20:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 17 Sep 2024 16:20:12 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Sep
 2024 11:20:10 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 17 Sep 2024 11:20:09 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <vkol@kernel.org>, <hch@lst.de>
CC: Lizhi Hou <lizhi.hou@amd.com>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nishads@amd.com>
Subject: [PATCH 1/1] dmaengine: amd: qdma: Remove using the private get and set dma_ops APIs
Date: Tue, 17 Sep 2024 09:17:40 -0700
Message-ID: <20240917161740.2111871-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|SJ1PR12MB6244:EE_
X-MS-Office365-Filtering-Correlation-Id: 191218b6-c01b-4047-88b0-08dcd7349b8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tGtuC/F3LGhwcbmAw0HvPNJkungWxsB9o09ycdp7Ds6VEWUS3yJPLwQOqys5?=
 =?us-ascii?Q?ziNX6bQgQ3dT68hFKKe6RLKvw39YSiNuf1M+B5T/hBqvU6dtHdffRNxXtQco?=
 =?us-ascii?Q?HFkzckqS+TK06Kdituv8e/BJ/mStiCMRHbwyeTA+16EONk480RN2RBi1EQzd?=
 =?us-ascii?Q?Zw5ZvyEtRePk8a+8ysb158luHUyGpE1HIiWhryBXwFUOlrp3x3XLxH0HzNct?=
 =?us-ascii?Q?srGh7JGiStADD3EEVpSBrIIGALOkETpwyXnVx3xvGzUme08TNL1Bru/RGCEd?=
 =?us-ascii?Q?xa9ma5KyeAP1aAULfXSLPQ8PemMz288Eh61QmYQHuuesIBQj6J8gd2IwoCvG?=
 =?us-ascii?Q?Z7yhK3GHuaJZ/PPWqfYCxRjykJbCihPM7Rao8UArnxkf5gUGf0Yi/LXsa3IQ?=
 =?us-ascii?Q?tGhRah6KCaJXPAVvms+rglAeQlq9OvNwibl7MSGQmBpwJFER0UONwu2kVTuj?=
 =?us-ascii?Q?gbSqCu/gkjplEm8IfF/TO+ZQuRZ2frjp/0vIacrP9YmPQqrVQovMT+xrvzVU?=
 =?us-ascii?Q?tgzxVIzbQ/A9OFoVPz3pFxURBbQzCoyA5r46PZ3Wm+ApxRUE35q1CO3uGcPx?=
 =?us-ascii?Q?t4yUx+tOZX6dPjnVJBL6nGWLIDzf2OtIMUFmna0XcdfPOSH1+DZyzWaGPJjL?=
 =?us-ascii?Q?gl+0n1uh73V2rZBDwIdmE6p2r36UwamRmLxQQe+yU+lCTq2rjfYWphji9KvH?=
 =?us-ascii?Q?YZBA4gynPx95JZbODEqsEcqqiI7S8AOxO/24Mq3zPIiqtcKFpF67nqdDn0sy?=
 =?us-ascii?Q?PJpNzxdccy4yJ6GDKzyAM6STxbipY3+wirOPQKGSPqO1+whKcHIK8qXj1Gua?=
 =?us-ascii?Q?vcsE6vfd8wD93tnebcpdQSPQHmWprjmXdN3bvr1nnghYVXaM167UOD/ximnc?=
 =?us-ascii?Q?RZB9XyAeWoi0YneaAG0UGUTU7s3WHn+THy05wkgCzz8JFvaNHs4jXOLqPwvS?=
 =?us-ascii?Q?Rl2tBwjk8CT9SJ/96QX9wHlqxeC7dgVxqE1JnbiXXTqe6V9J/mFsQzc5xyOe?=
 =?us-ascii?Q?mKgJJ+iblvtpk3YLMDHIWxf0A2wIkjGXyVVOWDRjxDkNFjC7/F7ZfhkJbl46?=
 =?us-ascii?Q?TWYGHB8Nazgkwej7zuqUcK5IZzh28Tn+hFNQ+Y7xw4Qy0L/qnHp89SueZgPP?=
 =?us-ascii?Q?OD/bmZWsD1jEPwoKTD9O1u0ujNCEXbEpdQeJ2YqQOGzF7DrNKO8xxW+wkK5V?=
 =?us-ascii?Q?aqmL1EXNcVWe0fG2EP5i1dkAafA1PTgpnfNxB3M6pfcUavurdcUo6yUsVxf+?=
 =?us-ascii?Q?1BGHbI43m4VgEQuFhjLslfK0oQCeIWCsCu5iK85HHLYHbA/YxJBhaRw9OkMS?=
 =?us-ascii?Q?wOSeYJnz4GoY4bBAfyfugtbXkesSht+ykXkV1WUNmQNhzBx/YT0/yC5ACgcL?=
 =?us-ascii?Q?NCM1+db21QrQXtsxnN296E92SBzGiUsM2cFhG7gNdD23zssBstu8gUJdci1m?=
 =?us-ascii?Q?PoIJChd2z+6nTC/dXawWYAW6MjE3r7lC?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 16:20:12.5726
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 191218b6-c01b-4047-88b0-08dcd7349b8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6244

The get_dma_ops and set_dma_ops APIs were never for driver to use. Remove
these calls from QDMA driver. Instead, pass the DMA device pointer from the
qdma_platdata structure.

Fixes: 73d5fc92a11c ("dmaengine: amd: qdma: Add AMD QDMA driver")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/dma/amd/qdma/qdma.c            | 20 +++++++-------------
 include/linux/platform_data/amd_qdma.h |  2 ++
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/amd/qdma/qdma.c b/drivers/dma/amd/qdma/qdma.c
index b0a1f3ad851b..ded79352550b 100644
--- a/drivers/dma/amd/qdma/qdma.c
+++ b/drivers/dma/amd/qdma/qdma.c
@@ -492,18 +492,9 @@ static int qdma_device_verify(struct qdma_device *qdev)
 
 static int qdma_device_setup(struct qdma_device *qdev)
 {
-	struct device *dev = &qdev->pdev->dev;
 	u32 ring_sz = QDMA_DEFAULT_RING_SIZE;
 	int ret = 0;
 
-	while (dev && get_dma_ops(dev))
-		dev = dev->parent;
-	if (!dev) {
-		qdma_err(qdev, "dma device not found");
-		return -EINVAL;
-	}
-	set_dma_ops(&qdev->pdev->dev, get_dma_ops(dev));
-
 	ret = qdma_setup_fmap_context(qdev);
 	if (ret) {
 		qdma_err(qdev, "Failed setup fmap context");
@@ -548,11 +539,12 @@ static void qdma_free_queue_resources(struct dma_chan *chan)
 {
 	struct qdma_queue *queue = to_qdma_queue(chan);
 	struct qdma_device *qdev = queue->qdev;
-	struct device *dev = qdev->dma_dev.dev;
+	struct qdma_platdata *pdata;
 
 	qdma_clear_queue_context(queue);
 	vchan_free_chan_resources(&queue->vchan);
-	dma_free_coherent(dev, queue->ring_size * QDMA_MM_DESC_SIZE,
+	pdata = dev_get_platdata(&qdev->pdev->dev);
+	dma_free_coherent(pdata->dma_dev, queue->ring_size * QDMA_MM_DESC_SIZE,
 			  queue->desc_base, queue->dma_desc_base);
 }
 
@@ -565,6 +557,7 @@ static int qdma_alloc_queue_resources(struct dma_chan *chan)
 	struct qdma_queue *queue = to_qdma_queue(chan);
 	struct qdma_device *qdev = queue->qdev;
 	struct qdma_ctxt_sw_desc desc;
+	struct qdma_platdata *pdata;
 	size_t size;
 	int ret;
 
@@ -572,8 +565,9 @@ static int qdma_alloc_queue_resources(struct dma_chan *chan)
 	if (ret)
 		return ret;
 
+	pdata = dev_get_platdata(&qdev->pdev->dev);
 	size = queue->ring_size * QDMA_MM_DESC_SIZE;
-	queue->desc_base = dma_alloc_coherent(qdev->dma_dev.dev, size,
+	queue->desc_base = dma_alloc_coherent(pdata->dma_dev, size,
 					      &queue->dma_desc_base,
 					      GFP_KERNEL);
 	if (!queue->desc_base) {
@@ -588,7 +582,7 @@ static int qdma_alloc_queue_resources(struct dma_chan *chan)
 	if (ret) {
 		qdma_err(qdev, "Failed to setup SW desc ctxt for %s",
 			 chan->name);
-		dma_free_coherent(qdev->dma_dev.dev, size, queue->desc_base,
+		dma_free_coherent(pdata->dma_dev, size, queue->desc_base,
 				  queue->dma_desc_base);
 		return ret;
 	}
diff --git a/include/linux/platform_data/amd_qdma.h b/include/linux/platform_data/amd_qdma.h
index 576d952f97ed..967a6ef31cf9 100644
--- a/include/linux/platform_data/amd_qdma.h
+++ b/include/linux/platform_data/amd_qdma.h
@@ -26,11 +26,13 @@ struct dma_slave_map;
  * @max_mm_channels: Maximum number of MM DMA channels in each direction
  * @device_map: DMA slave map
  * @irq_index: The index of first IRQ
+ * @dma_dev: The device pointer for dma operations
  */
 struct qdma_platdata {
 	u32			max_mm_channels;
 	u32			irq_index;
 	struct dma_slave_map	*device_map;
+	struct device		*dma_dev;
 };
 
 #endif /* _PLATDATA_AMD_QDMA_H */
-- 
2.34.1


