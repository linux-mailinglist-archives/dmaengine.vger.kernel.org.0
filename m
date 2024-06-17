Return-Path: <dmaengine+bounces-2390-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 831BE90AB48
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jun 2024 12:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5243CB264E2
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jun 2024 10:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE4619049F;
	Mon, 17 Jun 2024 10:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZgpN5o99"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C951922C7
	for <dmaengine@vger.kernel.org>; Mon, 17 Jun 2024 10:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718618693; cv=fail; b=mri7VdFDN8VzOa06Aw9zbYFVKC3YqnncNQw2dvPgr2B5jl358RWtzMKB/vyWKdxCvFDV1qJcT7AUgcu52zVh5XW1+KLq3uQZb6yPyKYL+XiiHGZ1riMX38SJ92bx5rfdu64Mo/bBfpXuqqgjzaQP+kqFHvD7kPlJ0YIh2/9RSRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718618693; c=relaxed/simple;
	bh=b0aowZT5jOnuAEJvm1jtpE5bCOc6J1cqlzYDaL7Savc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q517KIByWh2EvfoyqkyBi81HAFbR2pu31l7mvB15zpGIGVvQKuS1DwcpqNX6Cf7FyMWZn+rSj+G/TCmvMby09h9Gvx5bincT7O6wZ9VwcWf7+FP8YA7F54+pDZRmaCsqluIiuLMByIE8KObW/oYu0ajN3pd/5fKps1Qonv0TS/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZgpN5o99; arc=fail smtp.client-ip=40.107.92.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZAAEEyFHvJHlaALny7TtyD6f68KyK1QggjPHK/pDdhnqGNSc6cJ8qUwRYpfFLRTvYhfTT2c5c+v/HjdQkFnRdPmvTT+RZd+K36HFyCpsmN0libKgHwyZQDDtzSoAtvPRuHgeL4Gd+V2m2v0rXWmIrC68FZsmLz74HI8M0TUYDYdcVpIzgzVWARnCt8Cguvv9KgUuyMHXWvNSGyLrcj5d6PxoHO2gnxu0Ae/d/GhjkA72YQ3oH53vDH0B618+r827ihfNLy9SmclllwM6/0AmZpy3828t+b+b7wDnh+MtiCSThCsB2do1vqNX1bQpNL18w8ecyczzLRedArXUAucS2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfVuBQfuvb3Z3ecPjWRpAmSCUYkcHH5s6Ftzphrc9fM=;
 b=OlazVwE+0Tf9kmgrueEmRZqyZREhfPESNFqRHaUvFPJrbjxs1NHYIoj86Y6HC2aA6MY8dEYYkqGi1Pe6gOW0H7/MuXauzX9gb+Xjfcf4OtlbF9oS/4YXgUSUu2Lb0NGB+igXzI4Z4xnTHa60a8UmtJhqylQPWOwpqKuM48xiGVkZUWPlOr3aL1JHPoaGxFT+TJevhFJAWamVSQ6giSLpVZHD+4d2HoEZ4dk+GpF3Hy5rbI25vVEzCXGrwYjm1arjFiAqjJnLfnOsggOE+jWFy94h9ZF8fkgX8q+5hcrU44C5Y9tE6TZrCw28v5g1WbiAttzH1In+SnsgR11Zqk2VhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfVuBQfuvb3Z3ecPjWRpAmSCUYkcHH5s6Ftzphrc9fM=;
 b=ZgpN5o99fHoBKrHxFSisZwGHWh2vJZ0vvYu1YQVDroB8u5kp5VZ8d/C11BDQriLEFL4sTGFzIrZQXZuPr1EjvZo1DL4yIjhTIIUAYSc7FsKncc48aGy+LE+ehvkAIsSD8f/w1AI3qboi3RBay0M9QNouse9NbCXlEBuZ5shY9Io=
Received: from BN8PR07CA0029.namprd07.prod.outlook.com (2603:10b6:408:ac::42)
 by MN0PR12MB6002.namprd12.prod.outlook.com (2603:10b6:208:37e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 10:04:47 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:ac:cafe::94) by BN8PR07CA0029.outlook.office365.com
 (2603:10b6:408:ac::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Mon, 17 Jun 2024 10:04:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7719.0 via Frontend Transport; Mon, 17 Jun 2024 10:04:47 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 05:04:44 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, Basavaraj Natikar
	<Basavaraj.Natikar@amd.com>
Subject: [PATCH v2 6/7] dmaengine: ptdma: Extend ptdma-debugfs to support multi-queue
Date: Mon, 17 Jun 2024 15:33:58 +0530
Message-ID: <20240617100359.2550541-7-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240617100359.2550541-1-Basavaraj.Natikar@amd.com>
References: <20240617100359.2550541-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|MN0PR12MB6002:EE_
X-MS-Office365-Filtering-Correlation-Id: f579f4e1-36c7-498d-ad3b-08dc8eb4eb2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a7dSmXJQtRQMZ70paPc0XugKJ1za9x5m3SpPQiIsKarEUV6SKYPDIQoaDhNm?=
 =?us-ascii?Q?X1US4GL8Mex5Zs54FO1ZwEDN0yvcLmn1pTYCmK/w6S/pCHU6bNEOvzHSItyR?=
 =?us-ascii?Q?Krjl+RqiQ1KYtFcgTZWLIG06X8zYK/UEnh153ndHUswdQpCBcHMf8GC7pV7E?=
 =?us-ascii?Q?uTzDksqrw25GUgNnQ1fk/UlXAnnKz+UsAEtaPsEJ8t93MWWC5X5bUjVPa476?=
 =?us-ascii?Q?7sVwIyL4rQI2kGiU0Y4ZGV+GdaQXq9u4PoD1J12CLyMboCOOqTp+W1YsJbuX?=
 =?us-ascii?Q?jcFoSKsvCrTtcg3EuSavbY427PKcpm/DgPG/Hns2Oe9E74uc0ZpE3lh3jlTx?=
 =?us-ascii?Q?UK6b6O70uOr0HAuDOuZFLK5Nfi5krlxoIXsRcrl1EfO46JD8jYPhoHig07Jl?=
 =?us-ascii?Q?c/m1Kh9jJaAZOUE4V8cT7VURNv5ei38GXFLGweirpvjpwBh41gJddq3BkQml?=
 =?us-ascii?Q?UxIbHZYSuVXYyWKe/WOE0iQmfJPEZk7bH08tdCNSGVZm0JEVJcsIrepTOHqX?=
 =?us-ascii?Q?RI5kbrcphf+STd2DfnIFzyn0O/dIRHy12FZ8GKFBYwUQlOTyOHUhJs5jNqvM?=
 =?us-ascii?Q?bpVLmm45jNfi1HCJMiVT6wCfiYKPYlPgvkVv+X8YaAsZJNuhiNT8kqTZIkLn?=
 =?us-ascii?Q?mnX/qoWNVgzADTtouBJY1tPKs6XzyKWmAucvni0vXJcUWt6AEeCyCjIDXs0J?=
 =?us-ascii?Q?VUPH5Ca/tJENDrd7fSn/peTu96P6icvitKMZFVWNvqK34BJkzxVX+UqCj7DO?=
 =?us-ascii?Q?PTa9QE6rcrxGs2H+HuDk/MtE3aqrYRk5Inz6esSgE6KLVNKEtkDou1yRNtFW?=
 =?us-ascii?Q?TmsLF646jsgU9rYthtd0rqM+stymJVq+4yvR27JxHXtxfAHMqSqrK89Hmtrr?=
 =?us-ascii?Q?WLjlFXc45PehSzat6FSAtQYphdyh5WJRY199cQe3PZ7vFVNUuDtBaJNPQeWG?=
 =?us-ascii?Q?uqVQH3USc8OtgmUGU+ixcxQ8vtD9zflX1915me8Ylanjs3HXDF+mWdefnJQt?=
 =?us-ascii?Q?YW9jW9m3/uG4dlpnHHgC7L6c4wLLzg7vg9FEwPrZKg8kVtL6ohbrf4kLklbc?=
 =?us-ascii?Q?agryb3PDNnsOhSzChvu6i0fJDq6myMJsIWsuKp4SBPby/KZbZ3QX/TKzcWMS?=
 =?us-ascii?Q?3apHLtwBC58+Yp/Sr3OAZt4NgRMxyh/Gr/dDtGvjnORdopIm9NNlGH0TdiQL?=
 =?us-ascii?Q?Bsm6Mna6pnp7zYI1pcfSX8DqfQU4E3FbWhtpap/nekwr3VGasOw1ujdLyVNg?=
 =?us-ascii?Q?B986sNxAxg6/zl+i0/nI0s7uRFlJftkRzFeW5AIjT+dU7KBOhguc0jeiRVHE?=
 =?us-ascii?Q?Gwon3a5Zkn3Ob5b3J9NlJotQaiHQJfBJElw39lc21zVjPi6xYyxLRH6zYMSr?=
 =?us-ascii?Q?zB19GIY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 10:04:47.0105
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f579f4e1-36c7-498d-ad3b-08dc8eb4eb2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6002

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


