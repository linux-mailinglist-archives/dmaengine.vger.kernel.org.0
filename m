Return-Path: <dmaengine+bounces-2823-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCCB94BA68
	for <lists+dmaengine@lfdr.de>; Thu,  8 Aug 2024 12:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44E081F227F9
	for <lists+dmaengine@lfdr.de>; Thu,  8 Aug 2024 10:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8DA18A926;
	Thu,  8 Aug 2024 10:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0ZK9lamf"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5142B18A920;
	Thu,  8 Aug 2024 10:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723111255; cv=fail; b=mDNOmrgMVzuIWMH+iyCAJsp3HpQ5SrID6Cn5Aw7mPZ3md9wVjdNjKY7fktk67JSXGR0aMlwsa8eK3SOroyLnYz4l3QC6LorY7f1ngHrTJ1bGpNN9NyyLC6kAhMcLr48g2c1XZIgm8wCVpnoTursiIOxGsx3Q3AN+AnrXuOn7dfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723111255; c=relaxed/simple;
	bh=+grviH9hsua3pOKuEBdCXKe8a6f8zJNBNGVMx1HdeQc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jq15jvInrHlLAHlSz7W7jG1y/382EsCeBJD05KATXvVV/6af6PdH/pbvgR468nWprw8sicouItcPttSXyyi9oOEGwbbCOUkO6CB3lVfat0MAuR7Ju0bjisyYn1xLIWV2h8OAeI3kavTsl5etyLBf+JwGSjNRM3+H+fQG+c99TPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0ZK9lamf; arc=fail smtp.client-ip=40.107.102.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x8I0NNo2QYpgJz0H/51Oea88M/6FJfpeq6EUhGJPyVmOwwz96bUo2sOnwbv4HKKh+X8Eo+66NFehA0wjqfo297OEtxRjNez7hkHiWFIGKjppWhu5Kja6hhrqDeMhLmSjUiW/C8aS3Jr6IQNLQ0SHQinacEx2rBhPYPBBfMJNkzxZXt3Sx651Bdv7fE/xBhE2Jc4RKwW8nzZIwzK4nb75Pb53bkczfX8dNqeUYHikV5zKagAXvUPiOjcWQ1YLklJUXtYthvn1H64B39Qw/gJH5Qyx+6EgH531if0R5IH3D8y8bCX/rE6XcY/eWWBpbbHVRs9kxL+zMUpCaEdOQvUi7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+yLsT/rgd1sjU1pIzB4eCDXjKH9umJk5+tIAoYKlXw=;
 b=BIpBF5kfUpDZr+48zhP+/2DAMlgqrWTFvW823AME0kdHiIO5AkmWaOO9nHzKiS/NxTMgUeGf924uFLYs/Ddy6gqL4uLrwBWaNeXKgnAIL8faWsEB/ZJFr15Id556IKR8Uq4Nl92eJ0rSlwb2CPtQKK01P1pmtnymcSso28L/t3K2mAlLb7KFWW37vWN4iLKkucoFqUXP6NfrJeBFBuIVWnvlK5foR7z41wP19fayr/iUXLxO0wuMDkqfmLMCF+Kc/UBnYRzHLFy9XjknTZLU79MF/ZzZK4n1SnoAyqPsND0CTcfat86WggSLsS3j42cEY9jMXvGz5VxtvmfRnCAsZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+yLsT/rgd1sjU1pIzB4eCDXjKH9umJk5+tIAoYKlXw=;
 b=0ZK9lamfle89Xmd4i8Ay5B6sSQHBDFd1vezfkI1jAV/hHRkn7u2MASI7r+dyJEUktk42A5o+ojo84nNs7CWoUeIaRDDS7+d+FKKv6ZJyyDrVs2x71GYYHRGEne3FBxICJCnl2eZ7AW1F07mmcioXO04LL02IXFzTIMl5f9p2CCs=
Received: from PH7P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::35)
 by SJ0PR12MB7005.namprd12.prod.outlook.com (2603:10b6:a03:486::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 8 Aug
 2024 10:00:45 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:510:33a:cafe::28) by PH7P222CA0008.outlook.office365.com
 (2603:10b6:510:33a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14 via Frontend
 Transport; Thu, 8 Aug 2024 10:00:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Thu, 8 Aug 2024 10:00:45 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 Aug
 2024 05:00:40 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 8 Aug 2024 05:00:36 -0500
From: Abin Joseph <abin.joseph@amd.com>
To: <vkoul@kernel.org>, <michal.simek@amd.com>, <robh@kernel.org>,
	<conor+dt@kernel.org>, <krzk+dt@kernel.org>,
	<u.kleine-koenig@pengutronix.de>, <radhey.shyam.pandey@amd.com>,
	<harini.katakam@amd.com>
CC: <git@amd.com>, <abin.joseph@amd.com>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] dmaengine: zynqmp_dma: Add support for AMD Versal Gen 2 DMA IP
Date: Thu, 8 Aug 2024 15:30:24 +0530
Message-ID: <20240808100024.317497-3-abin.joseph@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240808100024.317497-1-abin.joseph@amd.com>
References: <20240808100024.317497-1-abin.joseph@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: abin.joseph@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|SJ0PR12MB7005:EE_
X-MS-Office365-Filtering-Correlation-Id: 368365b8-d47e-40f3-eb4a-08dcb790f8a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FK2w+RJ0FlhyWNoSeAKigL7ZMgl3HWqWloF8kAzhfLajOExfk4Nd++P9tsZO?=
 =?us-ascii?Q?qKI5t8GflYsKmthChtGrCf9hcpwi9zzUUHzsOmSQfxu5Y82myJZFfqq76hnZ?=
 =?us-ascii?Q?xfNysIim44RzsrLYiy4NXahdCA/BjedYdl+aysw0TlEuvAA1nva0S4/1kl6M?=
 =?us-ascii?Q?vhiEZG3HTpST8f73snevWajQ8hW+nNpmrrwQtUFWQK8qNI3lD5xBmzCVVzel?=
 =?us-ascii?Q?79Ff0TDz+/zGDu2XfCTvmEraDCJxoYCAs617e/67l4hEqqMkjaTA+u7ntp79?=
 =?us-ascii?Q?wVLqY5r3u2tw/0cNTo3N2bj9qelyVsPL6XgYWGKdu2gW/bbN55poNUZMXoCY?=
 =?us-ascii?Q?UfkW4rxMBYBhVwgmExwhsQZwemX3mipmZDuehpKoctg26N8roJaXP48xBf9H?=
 =?us-ascii?Q?PAFIX7S/L3TiW4N3DeaFa3GDMaQkg087A6oW2apBHqlPOhq59Z9VvRey95Oe?=
 =?us-ascii?Q?6aeQF0X7jeoH9nOQ7VsDDcF3hpCsRCheUQPpctSEVcr5RyUPWJjMzykg6x7t?=
 =?us-ascii?Q?9c7rvO1J+FlwKIZmDVhDkquwgZe15aHvJ8nDBCfXYaTMNAWfqlAaArKziblw?=
 =?us-ascii?Q?16bzfkY6LUZXEiQTc7GoCnSEWWZpJoPxFo0nEN0KeznjFTcjZ41ycZ/vcb7+?=
 =?us-ascii?Q?B5vqgiuCVOxqYYndjAujwTx15UzuEFeIKEmEgNTaEKWVC++tTuIjKgr9nKP4?=
 =?us-ascii?Q?xQvgthwpEYvLCLoIPwrzRCeXUXrbHTctoR9SV5/VC71leTaShdSSsIN3mxno?=
 =?us-ascii?Q?pgLyRTcuNrmSlvW4ZHpX8X2QX2tVt2ks/XkNg4x4p3UY5lcWbU7wHNj2dm+e?=
 =?us-ascii?Q?d1qXN8H2UsQw1LVBmdcjHKqUO/r8p7qwGGOq7m9qcOY4NRSH8QYPwfx3hcWw?=
 =?us-ascii?Q?Q6gGI/W/IlK+d/WjH5kaPOIh67i1yq1YvkB23SdEJROYBH8lKOIU+RE9p5/G?=
 =?us-ascii?Q?4ZqmhYkkPIzN7ouGrfr7uecpK+gAWD/kI+1f2jdMEzhRuTliiDj2pteJ8gz4?=
 =?us-ascii?Q?BHt56IVBC1L+zjkyM/zR7olCrKtSx7cSYImO6Q5JGoAwiH6pRUtlRawWsOvL?=
 =?us-ascii?Q?egwLBupy+Fvrhi9KeLyF3d0nRiGOoVFECSK+P9RM4v/CPr5QtjYveHeXMiEI?=
 =?us-ascii?Q?RhFELxVgh3UWy11NHwwqYJqP4bzIBuan1AExrldxK1H7bFBy2SYruZnMp6g7?=
 =?us-ascii?Q?w/rKSg4SLiQxogc/unLrhenNn6DGDBK8HMfc3q79fveUcc2bZwBIyhHMI3gD?=
 =?us-ascii?Q?7vobPUI+AyRPrVFNEoHMX62xgdZcC7VVx9N980H/JatOjQUMuiCsWqRIwhKL?=
 =?us-ascii?Q?CQdq/PY5I9Ez57axgkUhmFjgijEFndNPgM82kuJvp33BaHtV78BZ11AY4/jJ?=
 =?us-ascii?Q?y8KG6O6tOkRZ01tQiQCgsIyBLOtHWsctLyd3BKmrzqtp1kWh/o89M+vRsojl?=
 =?us-ascii?Q?5JsU/s0TbrdcYLSXXJRzWyWXsxoiJqqg?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 10:00:45.3042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 368365b8-d47e-40f3-eb4a-08dcb790f8a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7005

ZynqMP DMA IP and AMD Versal Gen 2 DMA IP are similar but have different
interrupt register offset. Create a dedicated compatible string to
support Versal Gen 2 DMA IP with Irq register offset for interrupt
Enable/Disable/Status/Mask functionality.

Signed-off-by: Abin Joseph <abin.joseph@amd.com>
---

Changes in v2:
- Update the logic to use of_device_get_match_data
instead of of_device_is_compatible.
- Use lower case hexa decimal value for macros.

---
 drivers/dma/xilinx/zynqmp_dma.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index f31631bef961..9ae46f1198fe 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -22,10 +22,10 @@
 #include "../dmaengine.h"
 
 /* Register Offsets */
-#define ZYNQMP_DMA_ISR			0x100
-#define ZYNQMP_DMA_IMR			0x104
-#define ZYNQMP_DMA_IER			0x108
-#define ZYNQMP_DMA_IDS			0x10C
+#define ZYNQMP_DMA_ISR			(chan->irq_offset + 0x100)
+#define ZYNQMP_DMA_IMR			(chan->irq_offset + 0x104)
+#define ZYNQMP_DMA_IER			(chan->irq_offset + 0x108)
+#define ZYNQMP_DMA_IDS			(chan->irq_offset + 0x10c)
 #define ZYNQMP_DMA_CTRL0		0x110
 #define ZYNQMP_DMA_CTRL1		0x114
 #define ZYNQMP_DMA_DATA_ATTR		0x120
@@ -145,6 +145,9 @@
 #define tx_to_desc(tx)		container_of(tx, struct zynqmp_dma_desc_sw, \
 					     async_tx)
 
+/* IRQ Register offset for Versal Gen 2 */
+#define IRQ_REG_OFFSET			0x308
+
 /**
  * struct zynqmp_dma_desc_ll - Hw linked list descriptor
  * @addr: Buffer address
@@ -211,6 +214,7 @@ struct zynqmp_dma_desc_sw {
  * @bus_width: Bus width
  * @src_burst_len: Source burst length
  * @dst_burst_len: Dest burst length
+ * @irq_offset: Irq register offset
  */
 struct zynqmp_dma_chan {
 	struct zynqmp_dma_device *zdev;
@@ -235,6 +239,7 @@ struct zynqmp_dma_chan {
 	u32 bus_width;
 	u32 src_burst_len;
 	u32 dst_burst_len;
+	u32 irq_offset;
 };
 
 /**
@@ -253,6 +258,14 @@ struct zynqmp_dma_device {
 	struct clk *clk_apb;
 };
 
+struct zynqmp_dma_config {
+	u32 offset;
+};
+
+static const struct zynqmp_dma_config versal2_dma_config = {
+	.offset = IRQ_REG_OFFSET,
+};
+
 static inline void zynqmp_dma_writeq(struct zynqmp_dma_chan *chan, u32 reg,
 				     u64 value)
 {
@@ -892,6 +905,7 @@ static int zynqmp_dma_chan_probe(struct zynqmp_dma_device *zdev,
 {
 	struct zynqmp_dma_chan *chan;
 	struct device_node *node = pdev->dev.of_node;
+	const struct zynqmp_dma_config *match_data;
 	int err;
 
 	chan = devm_kzalloc(zdev->dev, sizeof(*chan), GFP_KERNEL);
@@ -919,6 +933,10 @@ static int zynqmp_dma_chan_probe(struct zynqmp_dma_device *zdev,
 		return -EINVAL;
 	}
 
+	match_data = of_device_get_match_data(&pdev->dev);
+	if (match_data)
+		chan->irq_offset = match_data->offset;
+
 	chan->is_dmacoherent =  of_property_read_bool(node, "dma-coherent");
 	zdev->chan = chan;
 	tasklet_setup(&chan->tasklet, zynqmp_dma_do_tasklet);
@@ -1161,6 +1179,7 @@ static void zynqmp_dma_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id zynqmp_dma_of_match[] = {
+	{ .compatible = "amd,versal2-dma-1.0", .data = &versal2_dma_config },
 	{ .compatible = "xlnx,zynqmp-dma-1.0", },
 	{}
 };
-- 
2.34.1


