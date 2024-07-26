Return-Path: <dmaengine+bounces-2741-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A2D93CE22
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jul 2024 08:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2042D1F2303F
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jul 2024 06:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D46D176AA2;
	Fri, 26 Jul 2024 06:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NSxGqPc3"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2079.outbound.protection.outlook.com [40.107.102.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97151176255;
	Fri, 26 Jul 2024 06:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721975221; cv=fail; b=luVES9A95gTAEh6a1uYghH9WfEWAHLSkGbaLWPXFWINTvlQaims9H1b6XZHpFCqomgwlp3W+P+LDD+MLVzPOU71NcHmaMVhPrbCGQ4kIrJoeZXM9aLCeW4D6em1aFHrJ8aI+kZUqf+WQ+jMhUOKZH3qBtr342tDGGKZoSzazk/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721975221; c=relaxed/simple;
	bh=ohzNNItMRwmIPWvRkMGgghSpEUQT9P/0RBIIgcxtjSw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZiWj+Z8HHTClwPYkVyB7kM/DeVpFe3saE6IH+8x1+VfT55gtW2zPLW2xdiIpDx1WMEQfHRa86y52ZHZCP+ZXnpFhAGwd+SUzBYib6893QGFiAaSOxaGOQayRLKmNVIJsybXnpaj943lS79o2LBQmcElJZLDBjxX+TVXivSlJlCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NSxGqPc3; arc=fail smtp.client-ip=40.107.102.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXzlWePQqfrXZxKExBGUsVqfAw7xjRyfX8OB+DXD2KB7GZ5ZSlA0xATCy4e+ReB+RnrvGw08WUj6RhksfdyATHUZgB+RML3i3AcD/tmeH9gq1UUfbtb81NJot/jq5GprYxwJ0XUdV49t2TP6SZrQfE+sQRX+9xtunhTeVgwv3evtkNTPB4RdJEbocNZWWfOyNxZIQ+CJOOMag6Z9jjeSlq+t/u7QenX+hgqZBb2P48DArsJN4VlOQxPhkIK8uz2a+qFBzmYn8KutfhH8mJrBO3WlHYg+0fsgt5UqSGdWbaR1ElxonKbysPfzqF7A3d+flnNB65CF/AwZ9CQOzNy9Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkF8tMqG9rcX9LES/G1M4qlMugBcZo+yog47nzfE4ag=;
 b=erWp/a3srdEsdWhv0RyFHs/J105jla3sQsJslhXzkfXvYaOfsFOmnDebrZgRxqk2KpQgzWQ7W+7C+lQjGxHDTJYrjiYFmCNvDALSLF/pod68IvU465uG6KOuvlUwXrWopIay8ihRqv1NkekaEMClxhLF2j7sVbr94XKY7X3xdfwTDPZlwd1jb8TIjKaTyPeKo2i6X3uzuCZDKAvwobVryJ19HgHGwZ8NvPl20fg24wkB8DJUXKqDkrgtb94Q5y+OJild+v/wph8LnD2aEllfkJAWFN8+Ohl4HLTO5mgjvCNFoIh6EyfipgcbmeD4zzAVQ8e9zXo9M6lh5GSVYrWpmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkF8tMqG9rcX9LES/G1M4qlMugBcZo+yog47nzfE4ag=;
 b=NSxGqPc3N9xhSiiF56sfNgskVNrXkt2gKWiUjRVLxWq/nzRgv/n/Ewquq8fwvDvXgA5BkW+uGXROvomCzaKP5hU4TTcN9/XqREhBFtu893RWsuSbBAVp3GeKsWHVvEc1cY/XcTj/M4es1uWqOXgkspNOLS241OWat7esZNPaZic=
Received: from MN2PR07CA0030.namprd07.prod.outlook.com (2603:10b6:208:1a0::40)
 by CY5PR12MB6407.namprd12.prod.outlook.com (2603:10b6:930:3c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Fri, 26 Jul
 2024 06:26:56 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:1a0:cafe::8d) by MN2PR07CA0030.outlook.office365.com
 (2603:10b6:208:1a0::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28 via Frontend
 Transport; Fri, 26 Jul 2024 06:26:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Fri, 26 Jul 2024 06:26:55 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 26 Jul
 2024 01:26:54 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 26 Jul
 2024 01:26:54 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 26 Jul 2024 01:26:50 -0500
From: Abin Joseph <abin.joseph@amd.com>
To: <vkoul@kernel.org>, <michal.simek@amd.com>, <robh@kernel.org>,
	<u.kleine-koenig@pengutronix.de>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <radhey.shyam.pandey@amd.com>,
	<harini.katakam@amd.com>
CC: <git@amd.com>, <abin.joseph@amd.com>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] dmaengine: zynqmp_dma: Add support for AMD Versal Gen 2 DMA IP
Date: Fri, 26 Jul 2024 11:56:39 +0530
Message-ID: <20240726062639.2609974-3-abin.joseph@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240726062639.2609974-1-abin.joseph@amd.com>
References: <20240726062639.2609974-1-abin.joseph@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|CY5PR12MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fb355c8-e860-4db5-9b76-08dcad3bf264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hxp5PXY2gQt8HEdfRUnFRFo9ZFcU50afphu2mHDlfuDZu+GunfcCWb0F6ItN?=
 =?us-ascii?Q?KF7mKZRrWWcVi0cQHb3z1NzBXNiZfZdAb+tqte4S04axiV74UOtprX/DvTrF?=
 =?us-ascii?Q?V6r9AuyzAOfInBc1jXucbv4HpzsTTwEWvPSGT794cmdCn51WyCNGNLaJAROw?=
 =?us-ascii?Q?QHnzhf/NwtD0Wpphn8MohTKXhzY3C/fn43AkLrYfk5WqQQ/uB7+oKZud0OW4?=
 =?us-ascii?Q?QLAaUmzKB4tyE24YenMd26Aa7xp+YkGHo9hZ5IW4r+2fW+W8NyyR/gTJXV+N?=
 =?us-ascii?Q?soN47qcfqZbQs+FJs5c6yoRFuk4bEbWLmYUK8ZhJsPObp/b7VOOtGPifCEgJ?=
 =?us-ascii?Q?x5ziZT6BsNPf12yeIy/6mG58hLjzS2qB4cWpPy4hcbGkhqZQG5DJIjbs/uJ7?=
 =?us-ascii?Q?rEzfYjlxb4/S1jM5ERcuv0ItKwiEDq8M1rO2L0xRNeVKJ4T4tSnI2wkrXyre?=
 =?us-ascii?Q?SMtVXU0HezydNzAA4lubx12ZvkkFhwcB0zXWIvl7XwCLFTtFR9LPhZ7knHGk?=
 =?us-ascii?Q?tA4tei/7Smluy8TEEVjFwO2BV7E7fsYTQU2BrrI2bDifAie1Y/okSi7yQnQ+?=
 =?us-ascii?Q?6ZGE4ogoYF1cQsTw81iUISub9o+Y3LtOUH6ouaJZl/TNxkWrN3fk6+bffZ0D?=
 =?us-ascii?Q?Rzn1R6s98gZDwoLpn6sVNt2+8XZQMN+HCza2EHPVLM8OiH3/i3h1Wz/ZtsQ3?=
 =?us-ascii?Q?tSo/n8iXL0SEGKtPSlSgea2JhT5+XqaeNjJhT7JjB3MBAFX8kxtw/rftUjYI?=
 =?us-ascii?Q?qdSGm2BK4MZSNiJrk2o5szpoTUaBD32MbkBRr6OmQrUUXgX/tMPzTjOaMKih?=
 =?us-ascii?Q?VrVJqIt4Ytknk9fIZXNyenuVzXmTjrzziyqflt3VV2ZGB49UaiDpgR/p4L9u?=
 =?us-ascii?Q?u8NmO7NqZyBOfErV6lAk5rr8nRJt+LF/c3/EtpLn6+qR0iKA1iJbPa1pMfQS?=
 =?us-ascii?Q?jMwnc4UIwIAL76GlMaDOt2bNiumCk5iDtaU19HEbBzPEw7RJ8wZtbrkbt27v?=
 =?us-ascii?Q?ZD2gifc84alZ9aZhDIq5KN/OyGvzhGF9j/A44onrBDqLuI6XLfzsCa10lJFU?=
 =?us-ascii?Q?xKihg8FgzwOX+dT45uSCTbXgqYeTedZji3Kad3bgUy1WdWdws5v7Hi3APsuW?=
 =?us-ascii?Q?cco1oM95o9WsQV/FG+pIdMaZDiHo57MPhHdCT2U7GMuU4RhrT4l0enWsiFlM?=
 =?us-ascii?Q?w/FwaflYqMDXxJFg2jvp57AISkb7irVGBv+mZ45DfDSXn05+nhhJC8dLzd+n?=
 =?us-ascii?Q?Mgd9lcbNg06U30Ipw5I0+WwbpWgtkm2GfW/5Ni3y86ynWC/Q9H9JLKDtf+Hv?=
 =?us-ascii?Q?cQUYeNuqnepk5Y0pxySjvhCmBO4UKwMl9rUXzQR0hNjELBBwqd1+HcSk+HPM?=
 =?us-ascii?Q?el19k9+T0Gk7bYYhiRfxHZeoeSmwTC8rgBIla77WKxITJRPDBYJ9y5KpJuyB?=
 =?us-ascii?Q?ZfIOka9evGgUoUcbD9cu/VSN2WF3MZT7?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 06:26:55.8623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb355c8-e860-4db5-9b76-08dcad3bf264
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6407

ZynqMp DMA IP and AMD Versal Gen 2 DMA IP are similar but have different
interrupt register offset. Create a dedicated compatible string to
support Versal Gen 2 DMA IP with Irq register offset for interrupt
Enable/Disable/Status/Mask functionality.

Signed-off-by: Abin Joseph <abin.joseph@amd.com>
---
 drivers/dma/xilinx/zynqmp_dma.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index f31631bef961..a5d84d746929 100644
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
+#define ZYNQMP_DMA_IDS			(chan->irq_offset + 0x10C)
 #define ZYNQMP_DMA_CTRL0		0x110
 #define ZYNQMP_DMA_CTRL1		0x114
 #define ZYNQMP_DMA_DATA_ATTR		0x120
@@ -145,6 +145,9 @@
 #define tx_to_desc(tx)		container_of(tx, struct zynqmp_dma_desc_sw, \
 					     async_tx)
 
+/* IRQ Register offset for VersalGen2 */
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
@@ -919,6 +924,9 @@ static int zynqmp_dma_chan_probe(struct zynqmp_dma_device *zdev,
 		return -EINVAL;
 	}
 
+	if (of_device_is_compatible(node, "amd,versal2-dma-1.0"))
+		chan->irq_offset = IRQ_REG_OFFSET;
+
 	chan->is_dmacoherent =  of_property_read_bool(node, "dma-coherent");
 	zdev->chan = chan;
 	tasklet_setup(&chan->tasklet, zynqmp_dma_do_tasklet);
@@ -1162,6 +1170,7 @@ static void zynqmp_dma_remove(struct platform_device *pdev)
 
 static const struct of_device_id zynqmp_dma_of_match[] = {
 	{ .compatible = "xlnx,zynqmp-dma-1.0", },
+	{ .compatible = "amd,versal2-dma-1.0", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, zynqmp_dma_of_match);
-- 
2.25.1


