Return-Path: <dmaengine+bounces-3574-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1789AFF5F
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 12:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E25A4B2414C
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 10:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120D81D9669;
	Fri, 25 Oct 2024 10:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vRYhQPEx"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29011D5ABF
	for <dmaengine@vger.kernel.org>; Fri, 25 Oct 2024 10:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729850456; cv=fail; b=M0Lxa4jnwqO2zCrTLRLrssqKcdaVXFaerFvk7/jUvW/Sp36RX9gC7oz/EyuBXRbuEHftP/kIdmV1dtdqi76yBphJqUFwD0PMsRLlcyIOe+oPE2tE9OwiIa7vvRL0sfytcTnHkmwcnzLp9SWcLC4tN+6EalE0FHul6P57cl7bwrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729850456; c=relaxed/simple;
	bh=CVRoBADF7N3A1kZ/fKXgHbEAdDI+UL3BhsmpuG6h/NE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tRC3AlUueFt4ydsgmD0YAUI0HTidZEqpR2KabZiB3WKfGPRdLKJtatnAJ6zY2afM2hcn/8sfMgIxLUIzqC11bH0/j2+9IKRwakYHjhaOLlqjmT4+6+aIzrpqtM6KIYbekCxYPh7zpUdD0uko1y3A7825LLVZZC4zV/V0x6k+tB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vRYhQPEx; arc=fail smtp.client-ip=40.107.236.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wV36O56jV8BvFpQQ1EPOkCFxWwvhcxva2QFeHRpBwKdbuIo4qLllZnFl9aYWai3CT+LnxnsX3EmRka29wwYMpeyVhniVwPyhlnDRO/FIXkuyWgMcdEgGN/w1cfgZUDTaC/MZqBeifOs5wOW3aHaqYzDXvL6Wh3EHiVn5OktFM7YyqOkza8Au53b+qN8M4/KEvG6DdXf2qmBdV8a6l37gWDwhnJF2rlqUdnsclOf29zgd4Djf5+AonfYJ/AW0zXIKeNc8VdzJybLpRyp4br0lOySQaU5xxP9kq/OEPcPORYf3Zg5h96npy1NEAx+Dbl4lqkSZhXcs82OIeOXK0qw+/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2e9+sxdRZ/SkazFky06xKq3Gv9iWZvoIjE9gBpBObwM=;
 b=sg7cVmC3jG5quJFKC+NOUg5DA4vC6n1U0PwIIC+HQWJgSDjn8QhI0qkhB1+mR3PiVrBKn0Ogdvb25w5PMAvzMUP8JhoBzHu9oSDB+2Q78dyzwpipX8f/wrECZVQH9h1rFzz1orZfh/3FefNDQGFdzLc1TUiZe+2mIZcIPu6mtp0aR0sLPKueN/5dDXGz/GAFqe22APXM+8EGfrihwKk8OowC8wfMsQPw1/ZrI5xEigJoSL+rac9nbfRhKCG6VI1u6sm0c1VRmQ12k0gTokN5X1fUCMpOXdYdQw2K24XlogewwyTGfbJST96nIcFprH4ewFnmX9pxTnp8fCfGPRDOpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2e9+sxdRZ/SkazFky06xKq3Gv9iWZvoIjE9gBpBObwM=;
 b=vRYhQPEx5spfG6ti9RFnL+FQfHq7KVBNVM+SoTm+FJpqB8mJsAzp6H3WFuKIFd1mRtR4sUy7ayBpLayhjXTkCxBvONop+kLVWQFMqc5Ab3A0bmPSX6BPbLUlvMxZPigCaN8Iyt60Re0Un3zv3fOzhAe8MhelFhWtQvETHeDM8PQ=
Received: from MN2PR10CA0021.namprd10.prod.outlook.com (2603:10b6:208:120::34)
 by PH7PR12MB9222.namprd12.prod.outlook.com (2603:10b6:510:2ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 10:00:49 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:120:cafe::cf) by MN2PR10CA0021.outlook.office365.com
 (2603:10b6:208:120::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Fri, 25 Oct 2024 10:00:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 10:00:49 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Oct
 2024 05:00:44 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, <helgaas@kernel.org>,
	<pstanner@redhat.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v8 5/6] dmaengine: ptdma: Extend ptdma-debugfs to support multi-queue
Date: Fri, 25 Oct 2024 15:29:30 +0530
Message-ID: <20241025095931.726018-6-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241025095931.726018-1-Basavaraj.Natikar@amd.com>
References: <20241025095931.726018-1-Basavaraj.Natikar@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|PH7PR12MB9222:EE_
X-MS-Office365-Filtering-Correlation-Id: b2b30629-f689-4120-4c86-08dcf4dbe749
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yZ7XAU/yc2YUCjMlXx1TrvtdnGFEg7cpGwOoe4QWkd6TEUHlaDTDm/+YYJxG?=
 =?us-ascii?Q?z3ahRHuIePjFCMDYOaEHfeDdXQvucvZb4CKg2nLWOEkUW4smOsdo1uFyjHTT?=
 =?us-ascii?Q?rgF2mfhEnstAyBWDXhvi0Fw12mbL3OJLFOOw4jRdCoJghibVCDQsgKvBgWsR?=
 =?us-ascii?Q?wXP7lsTj0CfsfhfW1AjYKv1H1jaa6jsZC7ZQReMl7MFonXN7pUGNxnZQ3vOU?=
 =?us-ascii?Q?ECepsuIdtI/U6hDkyC7TjIY/5sh3SmHeXEioBB8GBVr7Ldvi3YV0ik/7qtuW?=
 =?us-ascii?Q?uMcyccFE/sMU3I5Ba72vK52flmVqJ8Pa6FgRO2KKBVaduHv9tZNL7QX2qGXB?=
 =?us-ascii?Q?QgJPtYOSzMfFk8/JBKGIuxBMf0i9pSeXjLjUMd36qgHQw/ix/LKLl4GLX5KD?=
 =?us-ascii?Q?6VeL05z9GcwheAMbXOYHLqkxwm31CZhnE7wLnRiuKCKosn+7TrvNLz/Csqbr?=
 =?us-ascii?Q?6AyuErEsg13Dyax4r19TZCvqvQg3Ki3keLonWa02+FVwPyRcA8rv/5hu42I+?=
 =?us-ascii?Q?hUbw4SnymwWX+79jK0tgCfLghOJqJmt+QW6IafO+HDsYyTlYRhy/pZjK/JAL?=
 =?us-ascii?Q?xLgjLwcexOQkb1aWQ7JJm1Q/JlkLdR/BoVH5DHquyxX6r8hdp/wr9ECWr4g6?=
 =?us-ascii?Q?0ju+sa+fN+xMrvGx3DBKICxv3Mv+JOZx04wF810uO3kXEvYBb+4FqHFgvVWO?=
 =?us-ascii?Q?UqLt8dYZp6K8DDfJhF2yNqgttCtDE9KDqy1ubcJDCNa/1hMcIB7COz/DIGjQ?=
 =?us-ascii?Q?P6TMnTpeFIEtq5iTFV/CnRFEu0g431CnwAcDAdGxnfABzUCLkYDLfvnN2XXX?=
 =?us-ascii?Q?jKllMpXJ4gjG7Eso39ZzzVRjU1wapLzWvxxQ9Tub+5ZgN17Tuxb38SabH2WN?=
 =?us-ascii?Q?Ubvu/iOzF5WqqdpDpmYWE1M6h5zGsVAxdZ1UC3eiFD9NE8vjjibcXJ3wU7qI?=
 =?us-ascii?Q?/eTub19MJH8toue7eRDagy/Dg9uzEdwV8+RX7/cRoQRjLcSOkcNh4uB2+sb6?=
 =?us-ascii?Q?nLzdRrR5kg7VRfWlobi6xn6XA5r2Wb7QuSFjJClXuxiytqg4Xd4wGE0Fr0Wt?=
 =?us-ascii?Q?oGKSvEiXZK1mSNxImXv5AzVw6kZTNImlWP4Zv8NtCrNV97G9EIaMcqzf+FHZ?=
 =?us-ascii?Q?UKU27q+3oPZ6lTjXYoLaWvul47nnUd4EPZJ2MdmbaT49K1Ay2ny8tN/w1Ttg?=
 =?us-ascii?Q?Qc1j0m/r3ZfWVq+cfgtIake9S9wMz2tE6jrDb8Wbf3URDu7iv8XxD5tcEWdk?=
 =?us-ascii?Q?aZV58CthfkHRpdgeoMK3l32eQ0aDrnuswuYeh61jg0Oee1FBCdby9JD77GXg?=
 =?us-ascii?Q?/o1XKtTj6vWj52G22w4mvqImQd4QuJfF9I/JISZjlQwiwhEoWKxLoFsDr04j?=
 =?us-ascii?Q?l0bfsdH+9GdiS2GNGdzVxqI5Uic+eC9Dv5F7gDYE++SSw2VyKw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 10:00:49.3561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b30629-f689-4120-4c86-08dcf4dbe749
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9222

To support multi-channel functionality with AE4DMA engine, extend the
ptdma-debugfs with reusable components.

Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/dma/amd/ptdma/ptdma-debugfs.c | 78 +++++++++++++++++++--------
 1 file changed, 57 insertions(+), 21 deletions(-)

diff --git a/drivers/dma/amd/ptdma/ptdma-debugfs.c b/drivers/dma/amd/ptdma/ptdma-debugfs.c
index c8307d3044a3..0e54060d6c34 100644
--- a/drivers/dma/amd/ptdma/ptdma-debugfs.c
+++ b/drivers/dma/amd/ptdma/ptdma-debugfs.c
@@ -13,6 +13,7 @@
 #include <linux/seq_file.h>
 
 #include "ptdma.h"
+#include "../ae4dma/ae4dma.h"
 
 /* DebugFS helpers */
 #define	RI_VERSION_NUM	0x0000003F
@@ -23,11 +24,19 @@
 static int pt_debugfs_info_show(struct seq_file *s, void *p)
 {
 	struct pt_device *pt = s->private;
+	struct ae4_device *ae4;
 	unsigned int regval;
 
 	seq_printf(s, "Device name: %s\n", dev_name(pt->dev));
-	seq_printf(s, "   # Queues: %d\n", 1);
-	seq_printf(s, "     # Cmds: %d\n", pt->cmd_count);
+
+	if (pt->ver == AE4_DMA_VERSION) {
+		ae4 = container_of(pt, struct ae4_device, pt);
+		seq_printf(s, "   # Queues: %d\n", ae4->cmd_q_count);
+		seq_printf(s, "     # Cmds per queue: %d\n", CMD_Q_LEN);
+	} else {
+		seq_printf(s, "   # Queues: %d\n", 1);
+		seq_printf(s, "     # Cmds: %d\n", pt->cmd_count);
+	}
 
 	regval = ioread32(pt->io_regs + CMD_PT_VERSION);
 
@@ -55,6 +64,7 @@ static int pt_debugfs_stats_show(struct seq_file *s, void *p)
 static int pt_debugfs_queue_show(struct seq_file *s, void *p)
 {
 	struct pt_cmd_queue *cmd_q = s->private;
+	struct pt_device *pt;
 	unsigned int regval;
 
 	if (!cmd_q)
@@ -62,18 +72,24 @@ static int pt_debugfs_queue_show(struct seq_file *s, void *p)
 
 	seq_printf(s, "               Pass-Thru: %ld\n", cmd_q->total_pt_ops);
 
-	regval = ioread32(cmd_q->reg_control + 0x000C);
-
-	seq_puts(s, "      Enabled Interrupts:");
-	if (regval & INT_EMPTY_QUEUE)
-		seq_puts(s, " EMPTY");
-	if (regval & INT_QUEUE_STOPPED)
-		seq_puts(s, " STOPPED");
-	if (regval & INT_ERROR)
-		seq_puts(s, " ERROR");
-	if (regval & INT_COMPLETION)
-		seq_puts(s, " COMPLETION");
-	seq_puts(s, "\n");
+	pt = cmd_q->pt;
+	if (pt->ver == AE4_DMA_VERSION) {
+		regval = readl(cmd_q->reg_control + 0x4);
+		seq_printf(s, "     Enabled Interrupts:: status 0x%x\n", regval);
+	} else {
+		regval = ioread32(cmd_q->reg_control + 0x000C);
+
+		seq_puts(s, "      Enabled Interrupts:");
+		if (regval & INT_EMPTY_QUEUE)
+			seq_puts(s, " EMPTY");
+		if (regval & INT_QUEUE_STOPPED)
+			seq_puts(s, " STOPPED");
+		if (regval & INT_ERROR)
+			seq_puts(s, " ERROR");
+		if (regval & INT_COMPLETION)
+			seq_puts(s, " COMPLETION");
+		seq_puts(s, "\n");
+	}
 
 	return 0;
 }
@@ -84,8 +100,12 @@ DEFINE_SHOW_ATTRIBUTE(pt_debugfs_stats);
 
 void ptdma_debugfs_setup(struct pt_device *pt)
 {
-	struct pt_cmd_queue *cmd_q;
 	struct dentry *debugfs_q_instance;
+	struct ae4_cmd_queue *ae4cmd_q;
+	struct pt_cmd_queue *cmd_q;
+	struct ae4_device *ae4;
+	char name[30];
+	int i;
 
 	if (!debugfs_initialized())
 		return;
@@ -96,11 +116,27 @@ void ptdma_debugfs_setup(struct pt_device *pt)
 	debugfs_create_file("stats", 0400, pt->dma_dev.dbg_dev_root, pt,
 			    &pt_debugfs_stats_fops);
 
-	cmd_q = &pt->cmd_q;
-
-	debugfs_q_instance =
-		debugfs_create_dir("q", pt->dma_dev.dbg_dev_root);
 
-	debugfs_create_file("stats", 0400, debugfs_q_instance, cmd_q,
-			    &pt_debugfs_queue_fops);
+	if (pt->ver == AE4_DMA_VERSION) {
+		ae4 = container_of(pt, struct ae4_device, pt);
+		for (i = 0; i < ae4->cmd_q_count; i++) {
+			ae4cmd_q = &ae4->ae4cmd_q[i];
+			cmd_q = &ae4cmd_q->cmd_q;
+
+			memset(name, 0, sizeof(name));
+			snprintf(name, 29, "q%d", ae4cmd_q->id);
+
+			debugfs_q_instance =
+				debugfs_create_dir(name, pt->dma_dev.dbg_dev_root);
+
+			debugfs_create_file("stats", 0400, debugfs_q_instance, cmd_q,
+					    &pt_debugfs_queue_fops);
+		}
+	} else {
+		debugfs_q_instance =
+			debugfs_create_dir("q", pt->dma_dev.dbg_dev_root);
+		cmd_q = &pt->cmd_q;
+		debugfs_create_file("stats", 0400, debugfs_q_instance, cmd_q,
+				    &pt_debugfs_queue_fops);
+	}
 }
-- 
2.25.1


