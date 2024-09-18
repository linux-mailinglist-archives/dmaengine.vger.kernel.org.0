Return-Path: <dmaengine+bounces-3186-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F1397BFFD
	for <lists+dmaengine@lfdr.de>; Wed, 18 Sep 2024 20:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADBDC1F21B53
	for <lists+dmaengine@lfdr.de>; Wed, 18 Sep 2024 18:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134141C9DFF;
	Wed, 18 Sep 2024 18:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3ersud+5"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348091509AE;
	Wed, 18 Sep 2024 18:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726683037; cv=fail; b=W8W0yhxjhueeGUlTnk8jh05lZdG4KT/oIi5ThWX50BiXOvIYcyOr74ESDtS8FWBM6VIhE+vXE3A773nBVwHQN7Pu79VEeOc8mHdQtDRz7TXibOKVNc0QS5U5RIy2P9+HwwJDSanBO6rquXZHQ5CXQ4C64j1i3TxenCR969f9GgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726683037; c=relaxed/simple;
	bh=PaVsJk5KYIknKu9+V54XHJ82z0/Wy5KWZ0fLmqnD6mE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gDwG5tZ7CMT/KY2cKiP8EgnHujxqY34rx0FqRRy3Q+1tGLqwdqqZLTrhy2vDbvVpGJE93D0O/4gWefqQcf4vNYMLtcCFeV0tiZ/ecKLFplnUasyM36TmuKb3K3qnVXNyI1TrOOy9ODVdSvRGzLG8OwZSBv+GysHP4zUyObagtTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3ersud+5; arc=fail smtp.client-ip=40.107.95.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sygt2MA8qCjSmZ0hi63WPty/7yNl7uiYbdiGh33Py6SL8DJh+Nbq1oYMzZKdphSB7FTdO3AkHqTzp0jruur0jRx6RMsh5GFVabRqNAwe745clcKnkIu5i5A+E1OY+FgOmjbDyU8I0d0X+ZCXaMpMKE/Incf9phBC8yys6AcNq0g7EisiiNo2C8u05PftJ7mfJSzcCiXi+CgqCojlpO99Wx7XUlEoDNkHgzHbYotGglBte29YLDiVNQ9muiR2Uo7KgG826GgY7WBy3EWaI7Je5p/OygPkWlkzYDu5JkjUw1TcsdouLVICvhECC+y+hVCJLHdUI1nVGcFcWVI6PwhdQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yx4CIqOt0W/5gVQOR68PWArhMSd+PCNOeabC+ZfPgfY=;
 b=HNkRgS0bJjH6d0ZpuENjsTq+2+in7GOKPG2j4MkNRxSkm+6N11DhLfIALChdp6YLi9JMBU4aJC1v/SwCW8OFJ4N44UrzrIemF/jIXGdNIh14ZTBNl5bX3fnMNxXYHXegf+7yanQ4yw9MSA1Kz9WcalR+A5VB4txgGk+PsQlqriy4qeQFp/CbwhyO54Tsf7l61zzj79OeuaSXN+4BBpwv9MUtDf3ZWIEARVclJSd/Z1h/Kys1kI3BaYptpILcIR88LIobM1GwcEVW86Q3CbgQ/LK2ANsWjMh06O9iO1EPEKM9GHqX51NbvoYqD9KiVGVU4ochafhKgIKA0DY9tPzQ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yx4CIqOt0W/5gVQOR68PWArhMSd+PCNOeabC+ZfPgfY=;
 b=3ersud+5gpfBrbv/RhjH4Alcj4/Q6swRYRJUcMBODhX0zG4ovBYXYKgoUPCREcSXwHMl0RkmfNCfCHLenpJRC/DrnqFyuVrTUKisJ8ZlSwsPd9lzuW1aq6bSP5namF0IY4kVZwHhWjODt4UFy2miMorxzKoZl14cLCwDMfORdPg=
Received: from BL1P222CA0027.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::32)
 by LV8PR12MB9208.namprd12.prod.outlook.com (2603:10b6:408:182::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Wed, 18 Sep
 2024 18:10:27 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:2c7:cafe::8d) by BL1P222CA0027.outlook.office365.com
 (2603:10b6:208:2c7::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.29 via Frontend
 Transport; Wed, 18 Sep 2024 18:10:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 18 Sep 2024 18:10:27 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Sep
 2024 13:10:26 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Sep
 2024 13:10:26 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 18 Sep 2024 13:10:25 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <vkol@kernel.org>, <hch@lst.de>
CC: Lizhi Hou <lizhi.hou@amd.com>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nishads@amd.com>
Subject: [PATCH V1 1/1] dmaengine: amd: qdma: Remove using the private get and set dma_ops APIs
Date: Wed, 18 Sep 2024 11:10:22 -0700
Message-ID: <20240918181022.2155715-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|LV8PR12MB9208:EE_
X-MS-Office365-Filtering-Correlation-Id: 72797a87-ca7a-4fa8-7a13-08dcd80d2c75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?47w2JqktNUQqu/f/7slVylvwL84aN5/R23/d8klOdkT/8sCs10ntktGxeAlY?=
 =?us-ascii?Q?2wjIO82u8clgY1B9hV8Ld2nYssxowy2HQ5cEcQV1ftZJRfPZ8tqzhERKpxNa?=
 =?us-ascii?Q?sQeWOumdUtJ4AJpZT04NI+S9Gi3j3ASPcg0m6DA4zOYtDT7AwxJ1nljop5C5?=
 =?us-ascii?Q?MVEgKBqEG1tcgmNn/vHnwfT0KFiWNNrXQmvx4OBTCAQofZicHuwE/8uDwAy/?=
 =?us-ascii?Q?6FGxmjVA5/jExSmkOlbpqp5wMRrk24HY7E7vXOF/9KQWYYl/UWtPj49nDQwQ?=
 =?us-ascii?Q?DmfrBdrP5WOGnMemgt3MTcJx3Mb4rUvOD/CQg/hSwyJiB8trngPpgq+Vohcr?=
 =?us-ascii?Q?dhIhQS/j2HRBS6DmuzVfIgrbGEyEVYMpWJcn7+pO0DUu7+ipKawkHpzfKUNY?=
 =?us-ascii?Q?avD20KZOsUDDmxD+phUoYy9hJDVc4nWfuF8SjohWiP5vRlgbgSty23in5jSa?=
 =?us-ascii?Q?D+ChjjF6IA4z/twAK2lK4ToM9rFZjyUtsHp9P7DFVWojjcAur0ymFDhQ8EwF?=
 =?us-ascii?Q?brd+JLdx0DhBjnyGr2qbgfsIBZnfcoZvh916Y2OGaFjX8w5NVb9OVeDjd5F/?=
 =?us-ascii?Q?Bo9DI+eOzT+J/CDNiCoh+e1EO4sruYYbz6X4Ts2uyN0tdpFDHY4TUhD2Ueqg?=
 =?us-ascii?Q?ro9YR5YgFRPDWYCmpUEetguNBZH5mc/2i/w+hSOmqGRSuY88gbaKJgHi3Th9?=
 =?us-ascii?Q?FeFmPlPolKBt0sFYsLVw9xc6uwjsNOECw0G1yewyF0LqZKx1lzVmjXY2wtmG?=
 =?us-ascii?Q?nzVwjKqoaYWGHoqge1Unpl9jJJWclMaVbCuEjbYMrKtRepqF1/87o4FMB9Yr?=
 =?us-ascii?Q?UHu/PFJ7FCDspiVs/JGXsuQ0nXbYMv1GCXQlhXaG9hTnhKsyH+nyHR45piMd?=
 =?us-ascii?Q?4A2YUwflMVlI2d5Ehz28IflJhXgB04lqBxS5aUyde95lEnH3J0phf5kcHDRN?=
 =?us-ascii?Q?hpTRz/RkXOBD9DVAIQI530sS1oSNz6nLxUhx9+Yx3OmjWm6WJfpHZ7OBfViW?=
 =?us-ascii?Q?CB6ZTUKXW+msyaPy9WUZeSfPnjedhjDXSqB5j6TuH3rwaHMcQkiyZm1Y8eoy?=
 =?us-ascii?Q?OAtI5hy7FKxleWBlPOwPadkq8Wwe76YQVjr8rACiV1n5wJ9ToaiKQ3k0/j2T?=
 =?us-ascii?Q?+49JJMTn6DZwsYzTwPn4i0o7xOvCN5KM07LsOn/jKhV93fPPlzjmnz617/jS?=
 =?us-ascii?Q?Sx7Fx8yFV8g9kqO/S/uy7yZ17KqqW0FPZMNm8368HrmoVPQgu8KPnSQQ5tVC?=
 =?us-ascii?Q?KpEpt2CyJt0YLTWmQtO8Gd0pRrlCogEItdg8cFNxQX2aGwRuaVl3GfNpWGA1?=
 =?us-ascii?Q?R1bz9nAvdWuh8X51/hgNh6xl2Q1Jo0TMInLFx8Ux6LXPRwZYWa9vsWdCO2tu?=
 =?us-ascii?Q?lslOtU8rup3sEJxGKEglTzHsF3NieUU6hZDNSTBhBjQGQP6V0+z/Gkdnz8+3?=
 =?us-ascii?Q?yYdLqkDjEHUWy4JBae9/k6TP+nHO7Pt8?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 18:10:27.1057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72797a87-ca7a-4fa8-7a13-08dcd80d2c75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9208

The get_dma_ops and set_dma_ops APIs were never for driver to use. Remove
these calls from QDMA driver. Instead, pass the DMA device pointer from the
qdma_platdata structure.

Fixes: 73d5fc92a11c ("dmaengine: amd: qdma: Add AMD QDMA driver")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/dma/amd/qdma/qdma.c            | 28 +++++++++++---------------
 include/linux/platform_data/amd_qdma.h |  2 ++
 2 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/amd/qdma/qdma.c b/drivers/dma/amd/qdma/qdma.c
index b0a1f3ad851b..4761fa255015 100644
--- a/drivers/dma/amd/qdma/qdma.c
+++ b/drivers/dma/amd/qdma/qdma.c
@@ -7,9 +7,9 @@
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
-#include <linux/dma-map-ops.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/amd_qdma.h>
 #include <linux/regmap.h>
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
@@ -948,8 +942,9 @@ static int qdma_init_error_irq(struct qdma_device *qdev)
 
 static int qdmam_alloc_qintr_rings(struct qdma_device *qdev)
 {
-	u32 ctxt[QDMA_CTXT_REGMAP_LEN];
+	struct qdma_platdata *pdata = dev_get_platdata(&qdev->pdev->dev);
 	struct device *dev = &qdev->pdev->dev;
+	u32 ctxt[QDMA_CTXT_REGMAP_LEN];
 	struct qdma_intr_ring *ring;
 	struct qdma_ctxt_intr intr_ctxt;
 	u32 vector;
@@ -969,7 +964,8 @@ static int qdmam_alloc_qintr_rings(struct qdma_device *qdev)
 		ring->msix_id = qdev->err_irq_idx + i + 1;
 		ring->ridx = i;
 		ring->color = 1;
-		ring->base = dmam_alloc_coherent(dev, QDMA_INTR_RING_SIZE,
+		ring->base = dmam_alloc_coherent(pdata->dma_dev,
+						 QDMA_INTR_RING_SIZE,
 						 &ring->dev_base, GFP_KERNEL);
 		if (!ring->base) {
 			qdma_err(qdev, "Failed to alloc intr ring %d", i);
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


