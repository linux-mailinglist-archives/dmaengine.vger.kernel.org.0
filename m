Return-Path: <dmaengine+bounces-2656-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD88D92A500
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jul 2024 16:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D42BB230B2
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jul 2024 14:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A071713C674;
	Mon,  8 Jul 2024 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Vck/bAwM"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B6213F016
	for <dmaengine@vger.kernel.org>; Mon,  8 Jul 2024 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720449939; cv=fail; b=Apy8ZYS1nfzSSiUkiBjY16szKTLG2en/hstWqSHiNOuqgjAGz/KCuMv1HSx5R//d1D4Hqm+kmiFKOGPl5jXA5QcBf/pwwtyBysT7n5k6Wq/AQLH1PaNxZEpeHTIC80TR+wBbXACxdre+8iBCY3Weii3O0fXGOITw1irHJ8ATxfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720449939; c=relaxed/simple;
	bh=9OEB5+8kKPVowdTn1Q92kP3B2AFMNreyu3XBze81R0g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S9tSvYsvvAKM4OqMP79JrnehyKbsDKPOgEDouitdZgG+eMGVFCpxfud5vx/EXhMg5HtvEPrCYVtuXTKTV0vv1Ybq1ZfRQjcxIm+uxrJIL46MrOU9ni8By1Nj93uVDDX+U1YTtXQpgwFOhH9l+rra3G+3O0fZeO/ijxp7nbxF83A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Vck/bAwM; arc=fail smtp.client-ip=40.107.220.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAT7pfJrduhy9waUJV18j0JjRjTDNUus8J5iLmo1A9bASY8ihlq3JmlG5LV4zknoBWob9Nxu4eQCyaL/gtWTr+x9zq+33BqMF8z+J95faMD2W+yGGiE/XlW9mJfK6Uzkhm6RquVOBw4hGp6zxbbuIfSIyjKC/G0iTmr/hnvySBiJhr80g07cAZFgYLiGoG/qHrlVHB2Of3CMi3VjZNr91HlC7lwy7fF4nPSqOFFZGL09JIfzGtPhYHDBiihXhC1GH48KgPKN73ZmdfcC/uC0nf/GkltQz9EedsfvMahh1jimRgU62EurHE/1K0ujWv+vX91eyhpzZx+fNK8Az3kAvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDi7zs2g5k7SXLCIBrzVN/WI+geBfUtsW28xJzadxps=;
 b=J2mc7x4KBiA+uzXJXvYcCs8vn09lLNGRg1VkmyH5yaxP4+cHQ3mpeSgaHQuEH07ZHYm2lUMjFEMJYSL7UulUcYOt9PUgmSS+s7jXnjFodQgCrcMd865u/Q9S2Og2o+gNsQNsndKrwGF+p3TUHL5c6+d5AFZ8Yz/ZHMxqv9LTqwMqyIAWpMaM5kP93NwtslVBSt7bCssvzTXnc0xVkLyDJ96vI+s/LEqIWM824OaZZ3lHwAxHdbVo8sUgOoBX7V7RVn0cxCYQ0XJgIJIfkthk82+zVq7oM7ngfrLQhyXwq4oA4vU+ezM2GouW5d3E4ZUOZoidq09enapFcX7oVF3AHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDi7zs2g5k7SXLCIBrzVN/WI+geBfUtsW28xJzadxps=;
 b=Vck/bAwM/79DVYBTIBkazQLpSnd5WGB/B/Bvc+unNudzq+lyD5lJ/U4NY+aRFWvIHFdvbQXgM7lDUYhbpkkOoRdtep3i+YRArd/CPB789LjR4avxyAYJSwJWfEzGrPAANPlCSOhhsjhhClulgyyVQX8qSn81K4aNqQLuSy2eFwA=
Received: from BLAPR03CA0138.namprd03.prod.outlook.com (2603:10b6:208:32e::23)
 by CY5PR12MB6203.namprd12.prod.outlook.com (2603:10b6:930:24::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 14:45:34 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::61) by BLAPR03CA0138.outlook.office365.com
 (2603:10b6:208:32e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35 via Frontend
 Transport; Mon, 8 Jul 2024 14:45:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 14:45:34 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 8 Jul
 2024 09:45:31 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, <helgaas@kernel.org>,
	<pstanner@redhat.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v5 6/7] dmaengine: ptdma: Extend ptdma-debugfs to support multi-queue
Date: Mon, 8 Jul 2024 20:14:59 +0530
Message-ID: <20240708144500.1523651-7-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240708144500.1523651-1-Basavaraj.Natikar@amd.com>
References: <20240708144500.1523651-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|CY5PR12MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: b0169db2-96c0-4649-29d2-08dc9f5c9fa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1eE1TfK216tr7Mb1MITcsnQlIFKxUoCEJHyLcPXy9GxGsZgRZcr1z/zRiiUA?=
 =?us-ascii?Q?+OzstIJrzEm3bjQUtDcRmDnY71/VVyWs9StOgjrVYTo6XDWukNroW1Z1+3gu?=
 =?us-ascii?Q?ZmF4o9ELDYkXKGEJ5OPWFLjysnFMzy3diig4QCkoC9PA7QWj9c/aZ0ETQg23?=
 =?us-ascii?Q?QiM/phsTVGaLb8eu5fQm0fWocvOm1pHqdba3RqNjVQPyHENU4slV6ePMSp04?=
 =?us-ascii?Q?VXs4obHRur0lhbDurj1zvhQ2o3qQyVusN77RrECcJMk0kfn1jBjtINSy/xAr?=
 =?us-ascii?Q?s4LKWin30pjvOJ6HtrwVGIg4/swAdFzxYjyyjhJzWCth1bbZ+IhMxWlrnw2I?=
 =?us-ascii?Q?JwsB2RRwBpW7yByWQk4NBdp7eYF3q5K7qrXZCi77STsF6JDuMfMTBJV8fGJb?=
 =?us-ascii?Q?HH/hU6FrprRekZGdhmPhJkPpX9jkLmdkMzGNDL53ev/T5ebmiA0eq8XguFL9?=
 =?us-ascii?Q?+UB02IKUVwibqinN3eQlm3qH+ADh3QE0IBBuQ9b4dIp4I96pRwYdWNhmd7kA?=
 =?us-ascii?Q?LP4ArRmoaM2ElcQIw/Wio/mPSJGuZr46f87k+sFsOZXFuLjClTM8FYma0W+/?=
 =?us-ascii?Q?qmezqZ0Zia8JIYxWc9WQy6e4gZ4JgF0NVXUfTjHCTA+UjceNd186Mk0ktwws?=
 =?us-ascii?Q?j+dXXAOe+UObNp216TObtjAyZ1yIVNODpAEwrNEMSM1FJFEngCvzlN6Rzj4t?=
 =?us-ascii?Q?AKVZUoh/kQSZ0Z7T5T5DzLQakfYisNXuUgzx1lyb6JEJGFu459mF0DsM2j+B?=
 =?us-ascii?Q?k/j7PeZSzzvQY376J8c+SVhZPOiFCRDeFaFH/aZZcSC2V+6T1tNqqgMxZVFd?=
 =?us-ascii?Q?Irqmb/e2Hr29mHLV7+D8s+ivo67tnr8vpwTYbjjQv++VUDaUvwU5XCAefSir?=
 =?us-ascii?Q?FSnn3+Z5kfJ2DzOCoAmdTOKspyMFpErI+ux+hvzun0IHbRTshNOy/8S0bCud?=
 =?us-ascii?Q?8K3BJ/j6kVyzNJYpSdGiilPUXJ3tETE95VdaOCi1gydNdlJRAK8+cxrhlYWj?=
 =?us-ascii?Q?gHQEoIM5aqi1EcNoAry7XCYYJ+IgWg62JHSxUtqHwIq3XVJYG9DwIJGQ3Ddz?=
 =?us-ascii?Q?uzeK1pantnr2vTvirHdwrLW+CkxnTSIgRwS3rq/e7/a1tzD0a8Cgy3tLawhG?=
 =?us-ascii?Q?nrpmknEJEmirmYnq9kD0hE5i5m2A/2KqPDCMz2ScFjre9hPRnL7VSUJ/Y796?=
 =?us-ascii?Q?jYA+N8KMp5Y8VirPmGnPBW68VkVBCx/CQMK646Qpxh1dm9ZT0Uy/VBOEV0ws?=
 =?us-ascii?Q?8ywczCf76SqRJucszX8YwAuhaT8ENwT7aA/vdsffWJfauiND1WHnddLMZ7H3?=
 =?us-ascii?Q?pHPCqVQAuwlWTzeMATZ4gh/qYFDe3ySYO3qqQYXlxu3YKG2Lu9MFFn3/5Eji?=
 =?us-ascii?Q?dM5qfyQAI45KHegCcfgjZz7CY1X8OQy5vc8YQSaT+LTc3WchK3L8IyFEP2pZ?=
 =?us-ascii?Q?1x8/iMgVAiMK4oNvIRnfQy8IMYyx9qr9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 14:45:34.2232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0169db2-96c0-4649-29d2-08dc9f5c9fa7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6203

To support multi-channel functionality with AE4DMA engine, extend the
ptdma-debugfs with reusable components.

Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/dma/amd/ptdma/ptdma-debugfs.c | 79 +++++++++++++++++++--------
 1 file changed, 57 insertions(+), 22 deletions(-)

diff --git a/drivers/dma/amd/ptdma/ptdma-debugfs.c b/drivers/dma/amd/ptdma/ptdma-debugfs.c
index c8307d3044a3..25654799077b 100644
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
@@ -96,11 +115,27 @@ void ptdma_debugfs_setup(struct pt_device *pt)
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


