Return-Path: <dmaengine+bounces-2612-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECE091E59D
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jul 2024 18:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 822DA1C21A01
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jul 2024 16:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8947216DC15;
	Mon,  1 Jul 2024 16:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hwkq6Bn7"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB22316D9DF
	for <dmaengine@vger.kernel.org>; Mon,  1 Jul 2024 16:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852196; cv=fail; b=sR88P4M3V0zW9gjPUON4WZyVUmxSuKsqeXF4IEG2h8V8Djbs2Qjh6ZB6J8OvYWDBFkGRf0XRAaFFmhI1ogMJHJWeX+kT4c1Q+JTCrt5e/IZU3Sz9lSPnXgPc/5ly67QP6M6arMTYAEN4mjdK32vMaJaWOeWKliUwd2SFKnh+B3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852196; c=relaxed/simple;
	bh=b0aowZT5jOnuAEJvm1jtpE5bCOc6J1cqlzYDaL7Savc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fJ6ZIttkQ0ENdrYzEq2jdRqke85h5so7EMgBflHBDhAnNXNa5CB1njh4y6JEQjXHpRgD9ZNYMhh2f7J+z8oRUAT+5Zjji0a1AQr/4crPXuY9ob7ipEgmI6AtZxBiIhhxAmRrnD9Q8ldPCDcREFZfDCjoSmMWs1IJhq6am5cpI/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hwkq6Bn7; arc=fail smtp.client-ip=40.107.223.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6va07x7P/21K4/k+a1D/wmKvaMao5UJOKnUp7cBuHElpEQNG5HCrAe8FJUtWu8+AR/b5toRcA8UKFrnhqHIfZfinOZ/9Hjmbv1hOfZtv3u0lUt0Vo5xF1I8uIA7Qb4KCbTgE1OHALlS0N+YdREgGzTxtj3o9MRmr4cdhkLOMGYq6iPq8goU0ndI+vgtjfxe6IIcS1Iew5tQkIjkP2bUtwdLkbeiFwY+/u1azt4wvq+8YYY8zUjoboZYE596nIRLVl6FEwW0zTH5BHkCS3vV09wbv1ul++TijwgqyklFkkqxGjFJ36qaSi3kXKcPS9OiIOOGkMqnfL6QPPcDUFdvrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfVuBQfuvb3Z3ecPjWRpAmSCUYkcHH5s6Ftzphrc9fM=;
 b=jMQsJVT8BYzgVJ4WnQd3p5WoiBYB7BazGg4WmaFr6YE2pxua+JzW68o1nv9eMQ3NNuO+/kuTc61PJ6BjB15e6hpm8Y6ViKp/etXE1AdJXOdp5eM4MWAPMxs+2zImseRipBwYQaOKPBTy4oFzFo1z7gIVDADXCbfksMZyIjRkfyV09W1GJHWUzXCv9mUZpW68Ur632uP+7a76Amtatw0xJQzxSPnSueXIDMFlgjpbzEDW5nnsiU9I6C30EmxXZefCkF/dmUad9IG1bweaUzYdT3/ftUz3aq7EpUA9wfvS6uqOVt8Z1Gu2uPdaKzOvPB3xd7F1WEyKJReVo2MWMahzdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfVuBQfuvb3Z3ecPjWRpAmSCUYkcHH5s6Ftzphrc9fM=;
 b=hwkq6Bn7vG72cppolTwtMZuv2hX9nFzeHomWzGs/3veS5hkiYGLYnkwTfVTAQcYpoogbbbBnVy68dD8Dg27lAd1cZhp9qty+diAViBzm/wEFsvn3Bv/XPPLRO5l38YfCjVUke++z4SoOQCiMB1mphSJAcmCX0tP494FfTXRfqlc=
Received: from MW4PR04CA0360.namprd04.prod.outlook.com (2603:10b6:303:8a::35)
 by SA3PR12MB7832.namprd12.prod.outlook.com (2603:10b6:806:31f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 16:43:10 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::7d) by MW4PR04CA0360.outlook.office365.com
 (2603:10b6:303:8a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33 via Frontend
 Transport; Mon, 1 Jul 2024 16:43:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Mon, 1 Jul 2024 16:43:09 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Jul
 2024 11:43:06 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, <helgaas@kernel.org>,
	<pstanner@redhat.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v4 6/7] dmaengine: ptdma: Extend ptdma-debugfs to support multi-queue
Date: Mon, 1 Jul 2024 22:12:32 +0530
Message-ID: <20240701164233.2563221-7-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240701164233.2563221-1-Basavaraj.Natikar@amd.com>
References: <20240701164233.2563221-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|SA3PR12MB7832:EE_
X-MS-Office365-Filtering-Correlation-Id: d7087f47-ca54-41b8-1f48-08dc99ece446
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0G856cPRgtmesRSu/XCGr2dPX+itCXhyfmNwaWRgYF4Yr73arZtRvqo0zLGl?=
 =?us-ascii?Q?80RgdLlT3nf/VdWc461gpYYFCG1jbrOcMK5Q4dCFJeZ7KiRTEUlr00cezaOf?=
 =?us-ascii?Q?W8I1dqyJCbImy4khcqdgIs81FSDxB2DhzXCOAR8Xsj3UcTlljxsEQgnCexwW?=
 =?us-ascii?Q?2ITtRx8hfYNetWsywL+G1SlGhcuft7rYREDRQcCOIvnYJ1D4kfvzgdselHii?=
 =?us-ascii?Q?wMv/ByabUkLJnNdE+1PMvWa3AEoT8NUMDNZdn6ZMnNxj0B4yYZet0mfItA75?=
 =?us-ascii?Q?TwLVaQ7zYTUgpKwNmpzrXhxhqqaWQVfXDfYh7w3Z7s2ACrnkyjsYkRTN9MGM?=
 =?us-ascii?Q?LmHXP2EeLys0FGYPBd54DI7F14MtRSbD20qcXrKVvIW63HX1ALxYDud7ZSzk?=
 =?us-ascii?Q?JEm7nRHdcA1+iMVC0tov0v5yqALIa8/XP6w25+YLcUXOV4WIb88yMeSdXGpw?=
 =?us-ascii?Q?Vap+M+bRiBld41LPpgURPXYid2Lq0i/YtlA8I5++pO2m+xRRFwORZQOANgd7?=
 =?us-ascii?Q?rZQNjtP2BssnjyQZAo47BJxwo7EaZWz1l7ue41xwMFgISrL1CiiaBSQ6KspU?=
 =?us-ascii?Q?oWxYdl4Euscw5W1WDb9neKeiqquRDZYFuBLw9u0v9To7TRiwdNDLhJS3l+pq?=
 =?us-ascii?Q?PD0qC4bMDEYZB6tOJuIt96RuMyX7Ts636W/XZN+MOjvoA4edQvCAuR9fMueQ?=
 =?us-ascii?Q?sDAPI8KjQPhRcqE61X9aADmm/F/U/NmXmWslucnrK/9RzqghMrCVhdgKJnxd?=
 =?us-ascii?Q?PQXG6XIbpczFBK5Fe0qOoNQOWVDb3L6z4xMG7+/OBUBIVDfritoT04aDq880?=
 =?us-ascii?Q?x5cEMpHPFW1bTzzUpx9McaQ4VtQRsm3DOAKGiO6fJ6zCsAxN/LedpW7NH5Uz?=
 =?us-ascii?Q?+l2o9ynrn3YVFdU4NEzkyXbKQw1RGjFUsHhAvmbvDrFTz8LRPfwb5cOXkFgU?=
 =?us-ascii?Q?o2Kf2w2cL+clRiaw04nj2mygmh8VgwKAxDS5gpPeoOcIOr/tkg+a3R1xoGtx?=
 =?us-ascii?Q?gobR8U3/6yIzs348bfcg6lQYaru0xmc08ebCGxXjnednJG+ja+Qv7W/yDRNj?=
 =?us-ascii?Q?vd9p+SCJ6ohIjjI6KSo/0d0Fn5Ix3EHo8xGGsladvqFoHgM+eGqLbZ8b9XJo?=
 =?us-ascii?Q?To9vlnQGyMXZB8ISTeXhdAdd7yuGhb0q48FSG3l11Bu+CiXlxRS7TayaKBth?=
 =?us-ascii?Q?GsqHSH76uAn5VZsNwGHYDzyo8Grq6X5KSgJPdwzikB/Z/UbDsOXpuDtByXOT?=
 =?us-ascii?Q?18+JVJNbqIT71qASrlHxjdoGFIaJ4S9tcTcaRmnC/6Thz1vTtWJiHE9HtHel?=
 =?us-ascii?Q?OqX+GsYwfeoataqIrdflIpRGmBiqrbqj81w0cIGxuPOAQ0bjVuy2XVR53Ozv?=
 =?us-ascii?Q?0VMywm8O/TwivBdi7FzcP+AjLj5K4Dn65wtOTrTLDlGnxDg39tyr6IjJppm8?=
 =?us-ascii?Q?qSbxQ55HYhY13S5oPgvMeVIYOCCZYsj9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 16:43:09.9493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7087f47-ca54-41b8-1f48-08dc99ece446
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7832

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


