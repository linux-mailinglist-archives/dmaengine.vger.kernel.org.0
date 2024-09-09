Return-Path: <dmaengine+bounces-3121-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 755639719AA
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 14:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F4BE2849BC
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 12:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15A81B375C;
	Mon,  9 Sep 2024 12:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ylKho8EL"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3F21B78FD
	for <dmaengine@vger.kernel.org>; Mon,  9 Sep 2024 12:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725885621; cv=fail; b=Ep7fELwKweJIMGETXKzRH7F2/NIVu1VyrsFX9UwHpnHaAGtzKktDRPhG8QFaoRD3ecHSM1u7qW+uR07nooV9HJaJab0lDh5kZC1Gss6eMFnMCe4Ni7MCfence30d4Ve1E/Txl07QrNQnCM8sOfbWr8JUGVL1F95P1tBn5tZBmDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725885621; c=relaxed/simple;
	bh=CVRoBADF7N3A1kZ/fKXgHbEAdDI+UL3BhsmpuG6h/NE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qFh4VeF6pyrwDxQUTin33RUFCRGYIIh8ia6BCt/nyxIctcbe+p02RK/JHAuTv2DkLpR3g/aG6gLeX/25G215RsQQNXOUskfXt3EPNj8Op/RjAXoasNFl7BZ19MPCxQftbSZEBpibi4Wcvvi9hA2g/2qAfd9WU+ceLf6U2bAxU90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ylKho8EL; arc=fail smtp.client-ip=40.107.92.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hw0EepNXEsczQ8jiZQT43qs9G4QF9GfeYB8fhMzjjgHxAgq6FvhrkJwZTX8QF3oJDtrkR4Nlf8G3vR5oxQW8PA0StCFMsmpkXpC5Jy3UTdHSDPB1gJ0ZxnE1RLdlyeTqppgQrnhlEvQ3ijoPGhZ0PNg82Sv/PsCbY5ArBRIBqeRPnV1XXOjeYNS4u+ahjDM3yRHWiNJDiM3XCFYsj2DFnWIWRMxgb1Iw8IRXvttipZSfXSV2Ztu/KiKunGkQzyKebMy8/KdXf/cf5R1vPcyJD/9hiu1ThIhQ6zU8accEJErBD8WcYzMOVJ1owx7ZbHl3tb+mI4U5KLb8uhIpHGLdIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2e9+sxdRZ/SkazFky06xKq3Gv9iWZvoIjE9gBpBObwM=;
 b=Sl/NRvqB2gapaMDEmlz8UnVNZxDueWgvhP37mN6Lh23fV5JAeZKav7FmHMSj34hyH6DDQGXfF/IFw6rJB/a9FjVFGzGP+JUUn/QOeDntWZIf49aj87U4G803PokbUOtWIlqF+zBEYxAQIqceL60AbGn6HH9CA3XaFGXv5feJXSg++upUC74d+7+/A6s90iXrImkjk7e8cp75TAkZHCQtQoc+Thqo/AV1h8cMCaunSf/zpGDAzmjmqOyhjjk96qhYXOZKLwZWwnvx9lm76nz5LOhEl7micvMZ3c1WybR4aZy+vyQdUY+maUpSZjbfFGqwg8TrRJk3SJ9MyvN4KyEVuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2e9+sxdRZ/SkazFky06xKq3Gv9iWZvoIjE9gBpBObwM=;
 b=ylKho8EL0pDoo4XM74j5lyipymbPopu0Ie0YBL6/TqfThyWN64D1tmjlnBHskk4spYy8WkAszVS97NXT5Ey+28ucK4QDV6RCOQS9Gvt/h0a/DF+TMlRboikcY3TUACakCBhd8O9FrThimmz5tb9aoZOt+ANNa2gD2nseXt6f/RM=
Received: from BL1PR13CA0006.namprd13.prod.outlook.com (2603:10b6:208:256::11)
 by DS0PR12MB8480.namprd12.prod.outlook.com (2603:10b6:8:159::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Mon, 9 Sep
 2024 12:40:16 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::e6) by BL1PR13CA0006.outlook.office365.com
 (2603:10b6:208:256::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Mon, 9 Sep 2024 12:40:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 12:40:15 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 07:40:11 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, <helgaas@kernel.org>,
	<pstanner@redhat.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v6 5/6] dmaengine: ptdma: Extend ptdma-debugfs to support multi-queue
Date: Mon, 9 Sep 2024 18:09:40 +0530
Message-ID: <20240909123941.794563-6-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240909123941.794563-1-Basavaraj.Natikar@amd.com>
References: <20240909123941.794563-1-Basavaraj.Natikar@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|DS0PR12MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: ae9eb012-88b7-4d94-f7be-08dcd0cc8e61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1UFsykF+/3UAeibMq04q0VgG1cDsNaR9EYYRB0wfEcMwNlG3ZRvLdkyBMcgz?=
 =?us-ascii?Q?seIIyA7xQhZFTRBrAIIk4MtKBxzsfUmCy6v909RoQWifjfetKINMru0bYKd1?=
 =?us-ascii?Q?a0hXWGuLrACkr7eA8eVe7sXU7Ki8NpOqz3BkbiY5CHTta/avhvybOfmrolrp?=
 =?us-ascii?Q?+nqv0+JXsW3zUJ59TRlRyp0zXwh2+gWAIfFYm8XWJVdvrtqhPXoeJztRrs5V?=
 =?us-ascii?Q?l5KQAlmNf+f5ohMqjmbioOFZ70z8Al+mRSZ2Wgd0cCC07a57TUtk2Tga3YwO?=
 =?us-ascii?Q?Ij/G0FQOdelT0hMLBDAbz+mmC/M+xsQmDTEVXgivkIVosFhS2qw2CxUYPtxq?=
 =?us-ascii?Q?bhGPYAtGo2nXOOVTMxOdAk8kh56GXZMKX0QYNi1H1LftReUozjhv4zsh94G1?=
 =?us-ascii?Q?DxacqirnADez63NdRCXhZtFFmxjWQCPekdh/0kU55NCxS34a/r7tpIZRXpFQ?=
 =?us-ascii?Q?7XAkUjbiH1GgnTna7Awu1kzGj2ox9y+mj7tRdU3IifdQRO9784PHrRYRZlDQ?=
 =?us-ascii?Q?szNe5MWwFGgYK5nSi+GH2papOz/c5qIIORiiU9FLi2ZnIaRssOAsGqu49fmL?=
 =?us-ascii?Q?+619zckskj+oSw898cEfBXjozLziwZh2FvtLbF9gfniEn0+kIhudfUVKlIbT?=
 =?us-ascii?Q?/DDBWd3CYNUVJ099HJGCMRNJCGxGA1d0eEd6eMOjCIHIgJZUbpOwuwQEPKhZ?=
 =?us-ascii?Q?eUz5fxdvd0RMl+Zy6OM3Yeqx7xN68HaGzpCpGdivUbqfdc1axmn5t1VM/dUo?=
 =?us-ascii?Q?GiNl0r6hb9A8tGPdahyT6zPJftDC0GrpVmb9Miw/HFbRZamNBFy3So2zlZzS?=
 =?us-ascii?Q?3uQOz0NLs+5Acl0AbpB6B0ZpI7YQtymjD5dFT/52xCiP3VStSmpTOp0N22DO?=
 =?us-ascii?Q?a8S5CHVd8zBKxUCfIvOVV8CrmSKblSHL330mwS5TyCtuTLjMC885d/QB+7XP?=
 =?us-ascii?Q?1jgmh4ESm/1WttGyhCApP8WnUWioOuy+w+rUEbb6VILFty02qwV1hHyYnc9M?=
 =?us-ascii?Q?RktnxLCfPw2H+cRb5PfMf3wiTMRyMn0Q8Yuar9sfgo3Sw4jv8L5sdaP0kH2V?=
 =?us-ascii?Q?QgTdMqe9ECKygGwpRALhRTqALexQeHUKQap6WChpWmmc2k3yYMTR4cy0F4fj?=
 =?us-ascii?Q?7NoNCy0yBJK8ODsVjvx1+oyDT1NX/irlu1ErykevqiAQViPtKFbdaF43sV1i?=
 =?us-ascii?Q?+bGSeJ1MROikFY28My0LkwChwkjdM5YHulLbf//Pw91mHPzBN/D+P+HNkJlE?=
 =?us-ascii?Q?/LB5e5Jg+M8b6zWqXjqThkTT6dbcivam6T6WjZLePnqD/+1ATKB1CLdDc6Pz?=
 =?us-ascii?Q?MWc3NN3+F1In/mYBSFsyLZrLQaVrwmI4kiBCE1Fl3QBvYXP7Oq5+S3NuK8w4?=
 =?us-ascii?Q?WWU8PLFPlrSPWQglGJlPDTh5za3Y21roLjVd2APkeC0PGwHBEDMmE6jD4e66?=
 =?us-ascii?Q?Q+215rl0+EIc698PvP/9KyHEhDMk8LD1?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 12:40:15.9833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae9eb012-88b7-4d94-f7be-08dcd0cc8e61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8480

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


