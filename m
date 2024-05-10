Return-Path: <dmaengine+bounces-2018-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8A88C1F9E
	for <lists+dmaengine@lfdr.de>; Fri, 10 May 2024 10:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D04EA1C2148D
	for <lists+dmaengine@lfdr.de>; Fri, 10 May 2024 08:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CFFC136;
	Fri, 10 May 2024 08:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1lk1GxBv"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200ED15ECFA
	for <dmaengine@vger.kernel.org>; Fri, 10 May 2024 08:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715329305; cv=fail; b=rxBg0gVFxkNrQMm4YooCQZo8LrBVf1HJqklTDzsYVUVKp8fBHSWfip3fzTw0lqbcMOKYEXupmul5vd/+Fyd8hbSWKCJ5mUfHvCkVZCYm8E2cc80mGKtCwIGZg9GxwbH+YrjhkwNkOb96mJt/cm5sAAQPnaUhSrmyvsHox3TCo8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715329305; c=relaxed/simple;
	bh=b0aowZT5jOnuAEJvm1jtpE5bCOc6J1cqlzYDaL7Savc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=udEDTuAOWJVYsJuYL/LkY+Ck9p09pfqlkKUsyMZfkCav0sLB1RHLYXzwaRiUol5lLcnP1RyuJAtcmTtHLSZWLbNWgIhsJVLVd4pPDi/yCscz8SvGAs/6vOF+4GbyYM8LDpWLCo42C1YKJMP8s3mGaoDWWmXQ8ko8sNjJj+W0jWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1lk1GxBv; arc=fail smtp.client-ip=40.107.102.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUuxbHxmh0jeBxA7pgWTYP9KEKbjWwAxC964L7Gkyg9easXMfhWhedOAEECBxa+Qd5r7vcnzZuIQlF1tUjnpurt+7z5uDT3UFsuAykN/6O8tkkcC6L0KFAHkqA6SuT1KNmsGSVUnZckC7c5MBwdW6J4pxrT5a9AiJzkbLr7qB27oVw5X95JjHhSKqcBjaiF44ZciINbosEozu3DETWgZABjkJJ4hz0yyx6fxnVNR93uPHH8TYAIGSTAHyX9tIeGdRsq4bxTp+HQObKapHmwj7EcsAP1v5IeGTgCctv/84IEftcSABIWD5q2k/MwuqgAIfFxk/Ap4d2gRRjfNIbx0Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfVuBQfuvb3Z3ecPjWRpAmSCUYkcHH5s6Ftzphrc9fM=;
 b=WMGI8/QszrxvaybK1WnrAXW2ftBt0JA9H18CuNko7/tiDV3hpI11Bpl3V6DZnljSXgaMfXM6Nn7aGK6QuwireyqKcHfyYPz2HN11BHk3UU6dseMRpo+jz7G1dQJlNqX9KAtu+yQSU5fMpNVOwAJRls+dqvK5gR4eYbKzORS6dctmJZtCGXH4Sfyoc2SEZ9ermcv33FYhJIXBr0ZzTXh+/FHojHYEI7yCM9ymcYrvch4kAhMw7z5jsrhCUVh0QrtBSCCRFjgFPzRnbVtxKl+bodg3FWhiQrZOtyUFezZ4jGyC4/Xv86/iUzAJYJwUEFSPeQDBCV/TZWGnqDJRmeC+CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfVuBQfuvb3Z3ecPjWRpAmSCUYkcHH5s6Ftzphrc9fM=;
 b=1lk1GxBvHJAoDIo0FwpmNqoZm9eACz7j277eZ4qeAb0b97+bYGJceWpQibk/hjTmECa0p1n2n6lIGt81s3g3wzTooW7Q56EidekhYNNaOMnYgX+MeptgyG/D4trAhB4ixd4UR3x7rwN5Y/w76vZ7YuGE8bntcBu0Po4I1tcQZmI=
Received: from DM6PR11CA0027.namprd11.prod.outlook.com (2603:10b6:5:190::40)
 by DS0PR12MB7535.namprd12.prod.outlook.com (2603:10b6:8:13a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Fri, 10 May
 2024 08:21:42 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:5:190:cafe::25) by DM6PR11CA0027.outlook.office365.com
 (2603:10b6:5:190::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49 via Frontend
 Transport; Fri, 10 May 2024 08:21:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 10 May 2024 08:21:42 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 10 May
 2024 03:21:37 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH 6/7] dmaengine: ptdma: Extend ptdma-debugfs to support multi-queue
Date: Fri, 10 May 2024 13:50:52 +0530
Message-ID: <20240510082053.875923-7-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240510082053.875923-1-Basavaraj.Natikar@amd.com>
References: <20240510082053.875923-1-Basavaraj.Natikar@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|DS0PR12MB7535:EE_
X-MS-Office365-Filtering-Correlation-Id: 9669fe26-0e3a-4522-5bb4-08dc70ca3909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|82310400017|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VDh6g2+tMPLTznu/EvzHw6BMYkrA7ufXXF3mDm2HS/QprMqXPJXpSq8TzuvV?=
 =?us-ascii?Q?3eGRfDvThv7+FR2Jyas+3dttXV3/cMQq0aRt/SdlhL+KpR5XM6RtB1cAm35P?=
 =?us-ascii?Q?AHcn1kEwv6PvgljFoyxKVC54ZEn5AeA7Cz/O/kKwg++sf4e7gRp7mGgQN7Ho?=
 =?us-ascii?Q?zUJRK+tWSClDFU0W6FEq1xse/nUF3XZOyW40V+Fz+fZYSWIEnyfrMfBnMeos?=
 =?us-ascii?Q?9q0j8+JTBt/mChUnmhPZSsEs5VUcuHCz86HjRfsmNHz9gWmE+cFBxeOHC2K/?=
 =?us-ascii?Q?W6x+dsVZIPDzg1e8z0GoRbc8PhvNJ9VGJ7ZPYy6TaGYb+XUpYgOP3u7MXL7W?=
 =?us-ascii?Q?jJ418cLMou/vdH7T6pb+vtSR2hhULFa/xIKGnECR1fZaj5z4rvMhSQpqgtCR?=
 =?us-ascii?Q?xWpYp3Ve/KQCGoQNBKcyPzVRQqEIQxYSYEjzmAAZn8VcJTAYWwbXQTkqzF30?=
 =?us-ascii?Q?5+zvK0jXKiGWNzb2bnL0cO5B7rpFVfove55JJP3T0F+156hrvfHBSSjZdjEy?=
 =?us-ascii?Q?2pR7+H6HyH3iWaa/xrPAn446IDpwFjlt7MgLpT0IawEvC4jtn0Q1xwmyp0YS?=
 =?us-ascii?Q?r4VF6QEyRM7towdZkdG1yTfAjPyozWuThT3oIJ2qeJKtb+JQWRvDUL6tD4B6?=
 =?us-ascii?Q?1KVYfaiG2KL7Klr3hrjM1LdYSBTCCMDooK/ipZwXP/rkL15So4s1gshgUyFJ?=
 =?us-ascii?Q?d9iulDYrajruumOdPK0M2VeDYCRgWsj/HxfuRI4I3XXJcUGcDCTs6ZARVe+5?=
 =?us-ascii?Q?fM7RsFIP4tofDXmA+MSm8q1y/uqfHotQitX1i11hEmZfCEz3s6LNOIQP48Pa?=
 =?us-ascii?Q?U+bOilB8Xmeui+pZwH27SC52LwPAoLRPjx+CBLjixj52LcNpE3YRAb30laYS?=
 =?us-ascii?Q?uU8gfEXO0l04FNjzYeObyB3eaNU6s7VtPipjhUcdeqdISLGWvoCVhidQt2kH?=
 =?us-ascii?Q?+PBQSvywTeGafNzescxNTTdYhCSB1EZ6cAIROgug5T7AYLeSmIiJkY6U5//a?=
 =?us-ascii?Q?aFZZH59WE7znbqH4ofl+AiU5fosXyvJ9Jyo+p5C1eRoYmreQ29GgJg5+VcUe?=
 =?us-ascii?Q?dR+zYJdui24f4GMFb/+Exupsmb/WOfWjxPKmbpTIXdTO+jJWoarPvTsUo0Y6?=
 =?us-ascii?Q?u+IKHiJPTOJlLBCCqzk0DcMLyWd2KYd6Q7pksXHzDFM9lRjRgEi/QDR2T1zV?=
 =?us-ascii?Q?UHX3RgZyL25PVVWjC198aHGDiLKpsoVameULnSlkXHJJQk6z6QAzU4SFi9KC?=
 =?us-ascii?Q?fZl2O/wJIAF6YZFWF9A6Hh4gTiAH7g8GPH7sr+peHW1eb9xwbk82lzNrArq+?=
 =?us-ascii?Q?vgQKtez5BK+bmwNrhxidmzIOL0w58uHsK4m8HulCKY/T3bXQvuQwhYOwAn1R?=
 =?us-ascii?Q?IVNCHYY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 08:21:42.1605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9669fe26-0e3a-4522-5bb4-08dc70ca3909
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7535

To support multi-channel functionality with AE4DMA engine, extend the
ptdma-debugfs with reusable components.

Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/dma/amd/ptdma/ptdma-debugfs.c | 76 +++++++++++++++++++--------
 1 file changed, 55 insertions(+), 21 deletions(-)

diff --git a/drivers/dma/amd/ptdma/ptdma-debugfs.c b/drivers/dma/amd/ptdma/ptdma-debugfs.c
index c8307d3044a3..9aa7a49ae5be 100644
--- a/drivers/dma/amd/ptdma/ptdma-debugfs.c
+++ b/drivers/dma/amd/ptdma/ptdma-debugfs.c
@@ -12,7 +12,7 @@
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 
-#include "ptdma.h"
+#include "../common/amd_dma.h"
 
 /* DebugFS helpers */
 #define	RI_VERSION_NUM	0x0000003F
@@ -23,11 +23,19 @@
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
 
@@ -55,6 +63,7 @@ static int pt_debugfs_stats_show(struct seq_file *s, void *p)
 static int pt_debugfs_queue_show(struct seq_file *s, void *p)
 {
 	struct pt_cmd_queue *cmd_q = s->private;
+	struct pt_device *pt;
 	unsigned int regval;
 
 	if (!cmd_q)
@@ -62,18 +71,24 @@ static int pt_debugfs_queue_show(struct seq_file *s, void *p)
 
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
@@ -84,8 +99,12 @@ DEFINE_SHOW_ATTRIBUTE(pt_debugfs_stats);
 
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
@@ -96,11 +115,26 @@ void ptdma_debugfs_setup(struct pt_device *pt)
 	debugfs_create_file("stats", 0400, pt->dma_dev.dbg_dev_root, pt,
 			    &pt_debugfs_stats_fops);
 
-	cmd_q = &pt->cmd_q;
 
-	debugfs_q_instance =
-		debugfs_create_dir("q", pt->dma_dev.dbg_dev_root);
+	if (pt->ver == AE4_DMA_VERSION) {
+		ae4 = container_of(pt, struct ae4_device, pt);
+		for (i = 0; i < ae4->cmd_q_count; i++) {
+			ae4cmd_q = &ae4->ae4cmd_q[i];
+			cmd_q = &ae4cmd_q->cmd_q;
+
+			snprintf(name, 29, "q%d", ae4cmd_q->id);
+
+			debugfs_q_instance =
+				debugfs_create_dir(name, pt->dma_dev.dbg_dev_root);
 
-	debugfs_create_file("stats", 0400, debugfs_q_instance, cmd_q,
-			    &pt_debugfs_queue_fops);
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


