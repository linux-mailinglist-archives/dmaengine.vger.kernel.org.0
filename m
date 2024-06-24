Return-Path: <dmaengine+bounces-2521-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 282FA914401
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2024 09:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D724A2824D2
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2024 07:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24F4481C4;
	Mon, 24 Jun 2024 07:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VWa1cNAy"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF834487B3
	for <dmaengine@vger.kernel.org>; Mon, 24 Jun 2024 07:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719215809; cv=fail; b=ky8XNZYRo3SxM7g5ZuDaZaNsaGKm4iW7qM4qTkYbKkQ/ANkGynujpRDKjGJ8Ps3qoGQpX1A8eHZ52y3TXLlufAok7PZCm5gRpZITvQTXx42OkxwR09dZ1cYlbH6PaMseUTssyeHqui3ms8ZdM81spB4wyHUoiP6Ne71FawCC2Ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719215809; c=relaxed/simple;
	bh=b0aowZT5jOnuAEJvm1jtpE5bCOc6J1cqlzYDaL7Savc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cZjpnydlU0MkQo+7+xhWtsaBfM39P2EzefN4uPWArqkPFxp6V4Hk8lnGRTODT5u8MUWfBNAK0wA1QmZt5xro0GER10PHsgKxL4xdv9n/Bk6ld527VXTYWi+1EbxU2YN/vh1uUT7tl90BEgkiWXX9qGiP6piBXHfNsD7INTR5X5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VWa1cNAy; arc=fail smtp.client-ip=40.107.92.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEdy74wtM3FXvX+bwb/Ugs4PEW9X1IEwXODKR4JnPOoe87tWfRrPbCS1f/5YhHglP5x17bUdX4FT9y6J+ncTDMiWgvKbhvOkL8rtFOMWm5y6lyzxydntAqpcZaMsqv7GP0NZgSyziX/xyIn651npV3FXQWsEtMPeCfaEbBG3SN0anA+QLqsq68OSFVjQ+UoHDIHc98RNwtQ62pabHavYIOmpXFu0kR6lYAxsMyg/5fD5BtDBh+3d6y+i19Y1zSMubVlivfaZCiR0I6yzef2gvcU2mw3fJjKsag+Pr//6P3M3JHSKeViU1YhMHa1wAEV/6HX4Caxl1cEt0yrW5niTBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfVuBQfuvb3Z3ecPjWRpAmSCUYkcHH5s6Ftzphrc9fM=;
 b=mFLIt5Ej6enjB/PQEO4MKKvdtd9uAEVqtI17gajs1Qvcrmg+xW1BoxJ3I5woV2jynuYpocaNVztxVrYmxNamnCDsvbDhrcYYmFDDfC69FoRVuLW3QAnuXlKP28sOlZigRyUYAwc87cW/7iQ0YRr3/eetm2XNG5e0/t1i4MgbEFgGENq2kq5OJMdxn98rWfJPGsOntPLyFQn7jjzmwKdN+s68dR7+VGE9V998W06pc74eC6qDJwOIFFOfTagLaf+rHC7a4J3okjwErEd4CKIlUwMoUtl1sk6NQ03x0lvm+iJATvuyAFpNqmEUMnhDnRC365JlcOosFzYj/UB0etHdzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfVuBQfuvb3Z3ecPjWRpAmSCUYkcHH5s6Ftzphrc9fM=;
 b=VWa1cNAy/Xool/gM3zlUTvTlKcozxRDdcC2WMIq6C/FPcSr8/54ofTWhduuKz4xtsKYLeRoBZBCYGGn28LOJCgHXXOvUvmrYdpkdJALtCMNaAYcKSZtBsuiKu+bCr+bu2qxTM6I4+SvimyYfu57f78ulTpCKcsdEUIfXZuga7uQ=
Received: from CH0PR04CA0081.namprd04.prod.outlook.com (2603:10b6:610:74::26)
 by DM4PR12MB6376.namprd12.prod.outlook.com (2603:10b6:8:a0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 24 Jun
 2024 07:56:45 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::13) by CH0PR04CA0081.outlook.office365.com
 (2603:10b6:610:74::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 07:56:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 07:56:45 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 02:56:42 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, <helgaas@kernel.org>,
	<pstanner@redhat.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v3 6/7] dmaengine: ptdma: Extend ptdma-debugfs to support multi-queue
Date: Mon, 24 Jun 2024 13:26:09 +0530
Message-ID: <20240624075610.1659502-7-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240624075610.1659502-1-Basavaraj.Natikar@amd.com>
References: <20240624075610.1659502-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|DM4PR12MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ba12e48-6e7b-416f-22fc-08dc94233159
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|36860700010|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wVsJr2cKR+7X6f2Sb8CFO2GrnPryiIsP7s01Mo9C37NQ7Qra4m5IA4bO4COI?=
 =?us-ascii?Q?VtOeCGMyo1aTpSU+LK/b4F65UiTx1TAmXs+k6/uOovXlw0/rQvXw/AA+ofu3?=
 =?us-ascii?Q?ejCMrwpEDb7rKky7vifl5lI4JwZWrxiuKaUi0s8mJFi8H12Aupv4DMjUHw21?=
 =?us-ascii?Q?eT9lZ2r0vCLzq7SmlLfyykq+jt4Y3KZo9fVj+uJllRcfcvdHXsDWI/o8g9Rc?=
 =?us-ascii?Q?XrWKRAgmw8iBE+CZmhhOzxBZjvTSupTcuvg/69AE88Iw8GrL4HQrhkCX5/UV?=
 =?us-ascii?Q?q67//u45LB7T1qSj+17Fzbx1gV5bX6aEQfs0p2sr4Aune4wlusNrYXlC6cjC?=
 =?us-ascii?Q?eqk17P2cmGx+VnwbHo0dOYoluBEQX9PnK62p0+jHWwy8x1P7CpuWCmFQZ7n2?=
 =?us-ascii?Q?zKjh5NW42CUKRBkDP/J2vqrty1TLRze9WnFfpNIBC1zUMp9ITnj3G1GaZ+5a?=
 =?us-ascii?Q?y7Vtsc5uxukhl0dqr5c2nnUqiTZF1FNsB2QUVg5pBhfGTVfA6Vd2vexiB+X2?=
 =?us-ascii?Q?FzgJXa7yiRMBVAIJdNdDfOXC0e9WkA3CTM/srQfX1cUlIMQiFvzdc4X5sTEz?=
 =?us-ascii?Q?CJyeJ9rHHdARdJzUI3g4IMKqPySQMFep/3C8fApEvsFYM8LPVHNavpfgfRSG?=
 =?us-ascii?Q?NMCUPjQNSvx71HH6a1tCYMxxJmClNnRVACyriEP6K0joKmOUxvC/gUKosALZ?=
 =?us-ascii?Q?CgDxGVD6ZN1rAZ0CLpSOOuPWviDPBlvzbOja20cSaUjxKqty1Xgjh9/6pFwF?=
 =?us-ascii?Q?5rbKIwSMW8OUqwDxTa7ZRwh1fikpkcjrI+340aluU6JZjMuqkzM5tJwXGvZX?=
 =?us-ascii?Q?sasAeohkbvJh5nuShn6Xm1oXAMaC1kcox+GeD17u6r+gFhvxLA7OfhaXrRsW?=
 =?us-ascii?Q?+o/DSng2HmxpK+2pW4Qb6Xu3wRIPYs2AFa26PEyxAvgixn4CF3jiA+NWzL7I?=
 =?us-ascii?Q?BaUVLIIgDV/1Ql0Y7y3pODrEAE/qAVJ2LAg/y5SQbM3h96752eYgX/piA4Aa?=
 =?us-ascii?Q?CjHvwxri7OD7ni4hevcYYas1DZVVTkoxguXxwNE8o0FcToBVhygACwjpenjS?=
 =?us-ascii?Q?9gFWZMl2kZAp/aiceFrmzeHzW6gUYuDFM93lv/EUw47kSbkIIVa+3t4ez2NV?=
 =?us-ascii?Q?8MpQOglchZnyf1ykfVcFmE3zB2bVSDfhtkSHAeiBXX4p6kSW/OVOnRsLA49t?=
 =?us-ascii?Q?qkhsdBxOyy+p2NNhIwQh1/r+G3/OYuE/NIKeu4Iu3tWF1Ws3t4vUSik4SNjJ?=
 =?us-ascii?Q?7TkYqJQs25AxyoeHDGI6OxcSNroVN91z8yfHN4BAnjUdTraBOLTpgTAMfQOv?=
 =?us-ascii?Q?+EUlCO1nWGasIF9uAvG0fVl1JIr7lP4ly94I5Mop7DqB7iCq6xes9Jey1zGm?=
 =?us-ascii?Q?lXTf8+63pvtJeyqUpAWytuEcUoSK/TxYgPcY9XOBgwvMmyV4FQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(36860700010)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 07:56:45.1678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba12e48-6e7b-416f-22fc-08dc94233159
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6376

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


