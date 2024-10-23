Return-Path: <dmaengine+bounces-3440-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CCA9ACA1F
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 14:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D73B61F2205D
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 12:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3673FD4;
	Wed, 23 Oct 2024 12:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y+WC5O1a"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D721AB517
	for <dmaengine@vger.kernel.org>; Wed, 23 Oct 2024 12:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729687020; cv=fail; b=lgqv2M22kih4diat4l9cT7cKxHu595lY0S+Hjh07gOx965x91SATyvAlnpiQyHRNGgpAKiJO6kg3KiUVtxzqSX7hs8WEwsGKefqq/IWJi1HNzzsCB6VdHawbDWukzA64naWTJMr0sUKUMEqeui1VYKrMbvc++QgMPor9tFrZz8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729687020; c=relaxed/simple;
	bh=CVRoBADF7N3A1kZ/fKXgHbEAdDI+UL3BhsmpuG6h/NE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tR7PSysjmaF3J6Kkm6P2EqeGsIquAniGUUUM32AHr4U2qB4B40H63zEYoXrjqc+NLOeVE4415TnMYq8m3p+7nu3m+AiIC5k78jNQ0z+vRbFTehEAFGqGIAXMWD5okJvLXaUEhdS6lLqUI2DM1+8f+zHjwLSSkghiV2acTAEJtDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y+WC5O1a; arc=fail smtp.client-ip=40.107.93.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aO2yzLgCdCALsoPzl8x7Ut9JDytgTAU6wKzu50c9Ol3t6D+0hFJlMRas5FwmYT7nkRcufLnGeARr9u5krJxK6AtwkTjJI+2jc97sOf+f7GjlqkbXyPmVdBtEEnniJjtUtaNp5T2JQvj0ezm6luT1hY0ZLWiRFxu04fmGYEeU16e/AXzHJ3reT5WXxoldvCjLv2DYW+t6tL9CUhgJGIxatNQn8tslvXihCaqguM/ytqH12jJ0l9p8ZhgaeniSI9sTZEMOPcImzTDal5cyWUlO5rX9QhiNb2V4t6rDLzoxO9u5kk9+f4mvEkArr1oItL1dmvZpGylMajQ4vk7l0eDNZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2e9+sxdRZ/SkazFky06xKq3Gv9iWZvoIjE9gBpBObwM=;
 b=wQ3IrZR5oe6Ae3dq5qNXTYZREgtfEZWSEn0K7roc4QZQtmG/86UYrdBc/ZFGAMf181zLZTFheDa5iHPoAwM6AJ2ylG1EcYh7WVgh0vJu/Fd8KuqoqT9kcBM7nEsDZGAjLfJERe8/dhv0NDTNNeT9q35Vb1yuHCR1GCjvFUxPMAgsh0Nf2bahqWn3K9BiYgRN14ojkx1d0VHBVEd7wz3FmNk8Ogd9s5yLFd7unrloJwR5Yey71f6prDltskCtJxinPM8p79xT05rOaURKWWLDTecHuor0Z8YP/h8b8sCnOxTjWkzXIHU43JAjGJ96gyoO1MhOT0HKBAkT+E7TjnNHBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2e9+sxdRZ/SkazFky06xKq3Gv9iWZvoIjE9gBpBObwM=;
 b=y+WC5O1azIiQ9PGbFKsalUYRRMmkrr3/79WoG7G2hVqafPOR2el91SZ9AwdkqLzEwA0BfnlkAnkyOU1PF+YMIRRZOv45h263ht93MP1XJNyMRe+kpF8U2ks+KTBS79hsgd9a78/YaDEyI0YhPXYHzxWZpnP+Qk5/s/PPMRYF3SM=
Received: from BN9PR03CA0165.namprd03.prod.outlook.com (2603:10b6:408:f4::20)
 by DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 12:36:51 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::59) by BN9PR03CA0165.outlook.office365.com
 (2603:10b6:408:f4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Wed, 23 Oct 2024 12:36:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 12:36:51 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 07:36:48 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, <helgaas@kernel.org>,
	<pstanner@redhat.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v7 5/6] dmaengine: ptdma: Extend ptdma-debugfs to support multi-queue
Date: Wed, 23 Oct 2024 18:06:12 +0530
Message-ID: <20241023123613.710671-6-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241023123613.710671-1-Basavaraj.Natikar@amd.com>
References: <20241023123613.710671-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|DM6PR12MB4155:EE_
X-MS-Office365-Filtering-Correlation-Id: 036c74a7-d224-4ba2-6d55-08dcf35f5ec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OFIGR6e/CAzDzfd1jrUjS7oRsz9R4mc3C9x06coPnSbtcs2xfC2hpXprcK0C?=
 =?us-ascii?Q?r8ZF4o5AO8h0sa1GYUNvyGmcspUSQrelIGLB9zcAluZdeGTy0Nu49drP6l/M?=
 =?us-ascii?Q?En/c1si+rBTr+KczAr2l6mhgZHncD4TUXUFCk6Y3eZ7/pScU75yiO0DjVCut?=
 =?us-ascii?Q?zwHVmwKfj5tYMgY09CZ+maWFnDvkkz4cV3x+81mycBaiADyZrUOgPWx/uj57?=
 =?us-ascii?Q?cZTXUP7YFgx3QRV8qDuOnwf0FyuwGktQ2kyVWWl/Q34+n6xIsOR3tkk8p0/D?=
 =?us-ascii?Q?qjjldm5IILeZHgRATpn/EdpSq8ftN4z20d+lERwmoENUAuYmz51yRM/wCMFi?=
 =?us-ascii?Q?pV5hl1mcdmoLh6lEuNxIajiPgNDmPBE4l+f0458aZTk9nJo+tOWPfTnqCmLB?=
 =?us-ascii?Q?/WBxWOGSBNru8hfCkUflBKAnAcsUo7oDpBCQ10muMoh7CKD/PeQj80eVSND+?=
 =?us-ascii?Q?Ckpl0p4iyBj4SSD7RES9rsIDaBz2DcNoC2Mlg16/bUbxkTDRwjNMedz0ZZfF?=
 =?us-ascii?Q?XPjXktdgC0ffNSoe1jBtx8VITEEIMs1jIEy1zpOQ/zWsw5Q3LUgcvuT9qQS6?=
 =?us-ascii?Q?Jmt5OTX+LhiVKLILyiZHNDuTEaPpMBehHS5rkE4R7eNXPlH3+m0+dibwKcOq?=
 =?us-ascii?Q?efHa0FUA0t1F/sCcph67RNMAGBhL/W9ahIX6C4U2yp4af2/N3c1IPLRJs+IS?=
 =?us-ascii?Q?nzeLBBDuosUT35ao+TEQu/vMF5uBPc7SZv10C7aV8JBxDg8UmCPnyn00y/bN?=
 =?us-ascii?Q?32LYmUlw1ZOPeJBW4656t5GCCKLYDY9uRo+fVf85zs1G9p79Y1eO9v7RPz8X?=
 =?us-ascii?Q?HUMmUjdDfIYqcOAW/Pt17VnQq/3PYlOQzAV+ID/ZZn379Tx49ubJ9CV8eXAI?=
 =?us-ascii?Q?93rne50OxWeVV2CUMLTq19eGi/VmjorZMt/lgelQTjPqe7GSxEuhFQT9bthE?=
 =?us-ascii?Q?7AziYUQbkCNOyCTEZXGJ+RnCt7N5sruZ2zETOOooM7ynS6ANoh7V95d24BMx?=
 =?us-ascii?Q?ZcP+3nDHElTYCOpgFJ5AUffB0SyGZyWo3I9qQEsL72nPUwBQJQwZKAwLeIW7?=
 =?us-ascii?Q?Zz6sMel4tETo1emQl9REDAbR0sYJOWGUCLZybMpAbc/cZZEeMwj1HhvzbHLz?=
 =?us-ascii?Q?OJbaghnWGzfsNjTrAs1ce9J1j3b47j1Eo66GADZXFHBmkjxmS6K3zFY3tjX7?=
 =?us-ascii?Q?gCZCFKTNNy2O4x6Z3jgwjNWw2KqXXhcU0gLoO80Ij1lBZjpE7XTiJFo5sYWL?=
 =?us-ascii?Q?iy1SBVHkcdOT9yjfx3GCxuIXnYFn+TpIQjb9eHdGBvLGvuFK3gUUA0rjafIN?=
 =?us-ascii?Q?L6jZkmDEgo9kud4pUJqkKRkHiXsos4MOpv4JwsCZ9Dj4Riu/yLuUpaX4hFu1?=
 =?us-ascii?Q?P6oUE2IbeIPmUt/qb+gNV/lHZ//o9QKYD9mCfw1n3t6ter6z1A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 12:36:51.6229
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 036c74a7-d224-4ba2-6d55-08dcf35f5ec2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155

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


