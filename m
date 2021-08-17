Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A953EEDDF
	for <lists+dmaengine@lfdr.de>; Tue, 17 Aug 2021 15:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240055AbhHQN5o (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Aug 2021 09:57:44 -0400
Received: from mail-bn7nam10on2075.outbound.protection.outlook.com ([40.107.92.75]:8929
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239975AbhHQN5n (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 17 Aug 2021 09:57:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2uqXhijuDwg8TLher9UtRwFd5DHPOFfoKEKWv+yWnjfXwlQ3c5gBGEI1ZGjymBvTi4CaXwNu1Whde+rMHhhPaaAFvdQf+N0j+TE6F4CqdO7SEcy7jTgfvg651SK8y/XQOonrhalROWMIlWKTJBnGZ+DkF+WqfH574LhV1M0OfV1pNFHx1ewB92t3nhf6N377LNOTTceniV9BD6jj96d6bbg3tB97n+UJ8j+ghcUNLNTViHfWa0KyFYEqZr+ffxEVal/HnMlcfR1ZgdrYEmTZZztHJBM40ZeSSqlx+auhCoFg5uzyJTeVdVGdeXbYCQp98E0n15++qbktPtXQenStQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfWfyBSSJ5YiBDEe6oOAOLnXqv4iF55VV8K97wx40Os=;
 b=Kr0fNyzE+ANSSU6mPRkRJw/Pd/9HOKl8MQYuJAsw28tFGCfznMOdjbIOxQJEOdmhLALd9TjkyT8sCWjSBNs3dFOXXejjy2nNtpcMQ0u9MCHRpANy2WlOlAmlh2g1V9h6RpbT+07Xx0tBP0EpL0L/JCtPeyoDvZmzxvbIWC8UBiRZPoMgiOJU3cKxE2ddea6NVMnF8QDoyemnCocPNulLvx5EbUSS4OS2MH1LoLu5SfvJ8TrHUIlc2e7/9B6aRqJM5YPVmjmjzgj9s2hc1TlgftQK8rjwHuhAKKzJdxlAxtdDwA15lQLONM8/uvV9Z00cTCrUwZOuDotpRwHOGniVJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfWfyBSSJ5YiBDEe6oOAOLnXqv4iF55VV8K97wx40Os=;
 b=4Bs6c3uJKs9JKCHE3UwBe4Y/cTubYJz3AZhhrkbsrJgMEvXbze9AJqZ0oH9AkXmyzAbaZoSj27EJ2lykmNx/aWPeA5wYJDsGad7Gg4a/OJWwJWBOCTZzAEV8DgxA2tIGzaHXG6EFchaTiDEiPReP2j3UCtlosuWUR7wG3iGw1qQ=
Received: from MW4PR04CA0125.namprd04.prod.outlook.com (2603:10b6:303:84::10)
 by DM6PR12MB4548.namprd12.prod.outlook.com (2603:10b6:5:2a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Tue, 17 Aug
 2021 13:57:07 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::46) by MW4PR04CA0125.outlook.office365.com
 (2603:10b6:303:84::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Tue, 17 Aug 2021 13:57:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.14 via Frontend Transport; Tue, 17 Aug 2021 13:57:07 +0000
Received: from sanjuamdntb2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 17 Aug
 2021 08:57:03 -0500
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     <vkoul@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <dan.j.williams@intel.com>,
        <Thomas.Lendacky@amd.com>, <robh@kernel.org>,
        <mchehab+samsung@kernel.org>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v12 3/3] dmaengine: ptdma: Add debugfs entries for PTDMA
Date:   Tue, 17 Aug 2021 08:55:59 -0500
Message-ID: <1629208559-51964-4-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1629208559-51964-1-git-send-email-Sanju.Mehta@amd.com>
References: <1629208559-51964-1-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9969562a-3c88-446e-8de1-08d96186e6a6
X-MS-TrafficTypeDiagnostic: DM6PR12MB4548:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4548F8A9F2D78AA3FFB8B59EE5FE9@DM6PR12MB4548.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:22;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 60iB6UFo1m+HzestkYeubzFU42zYcUFpSdSYtrxie0RZRPPmJA0Haukr9VQPWDUqbCGoT8QOZu077r26JWZ9EUsaD9av1CtEw31QKi3vSRQT+5kzddC+LSaAnuO2Oh8nrAGQvVj1u7sDurHJIpOeD1MaP6a3welwhfWL5C5YLoDwFaKFBRJSKvr4Hbocj7ZAZIPybWc5l0k7RvK0t354+S5PpZDgpRFW9QmwxP1yxJQSD814Gmo8Qcmx0L9vP818DZ/u354NKfXWsZxKiXmLuQH63DJA6Rxpo1uiUhgxH3xddFXFrg+CcKRO2dEr+jVvm6Tt6D0uhdo9iSj0BiSGK4gfZ64S931YN0Dg/1cRPto2GiNvare++gJ0uH+7ub7bKlmsnfHXyl5Yir1FANqK/mNQqML0ROg5IEtXcYNFVBku3JajPGxxOTBgFHyUU++huA+NtkCta8Ja1joYvrtnotdVxofo2P76c4MHMj97iky8AozZBg66MWT0T5akZlA5Aeb3U7AxDTEVLIvgST+Mp+tLfXWPYIppTW1ICVZYRLBeJGmRdOWF/EOS95WV8XE+rcQp5wNrghlt5WJwYdJihN5dWWhKYoi1l0oqFmM9niCgcrq/oV4Tgv41K1qMCKIbvqNfMJvUAqfE7kCmv/tJoUKPmR7QqyQCezGGJGjilTYLc5RuOpBmmfpf9e37WNzeuGYV/P2xRglinpHXh0dPJccGqe27g+NsZ/xRlA0C5CRiqWAWflTQYiiKQ8c6YtywKnmlbryZQPtioRAzWsDyxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(46966006)(36840700001)(8676002)(34020700004)(82740400003)(54906003)(47076005)(8936002)(82310400003)(356005)(81166007)(478600001)(26005)(86362001)(83380400001)(6666004)(316002)(70206006)(70586007)(2616005)(36860700001)(5660300002)(426003)(4326008)(7696005)(6916009)(186003)(2906002)(336012)(36756003)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 13:57:07.1303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9969562a-3c88-446e-8de1-08d96186e6a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4548
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

Expose data about the configuration and operation of the
PTDMA through debugfs entries: device name, capabilities,
configuration, statistics.

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 drivers/dma/ptdma/Makefile        |   2 +-
 drivers/dma/ptdma/ptdma-debugfs.c | 106 ++++++++++++++++++++++++++++++++++++++
 drivers/dma/ptdma/ptdma-dev.c     |   5 ++
 drivers/dma/ptdma/ptdma.h         |   6 +++
 4 files changed, 118 insertions(+), 1 deletion(-)
 create mode 100644 drivers/dma/ptdma/ptdma-debugfs.c

diff --git a/drivers/dma/ptdma/Makefile b/drivers/dma/ptdma/Makefile
index a528cb0..ce54102 100644
--- a/drivers/dma/ptdma/Makefile
+++ b/drivers/dma/ptdma/Makefile
@@ -5,6 +5,6 @@
 
 obj-$(CONFIG_AMD_PTDMA) += ptdma.o
 
-ptdma-objs := ptdma-dev.o ptdma-dmaengine.o
+ptdma-objs := ptdma-dev.o ptdma-dmaengine.o ptdma-debugfs.o
 
 ptdma-$(CONFIG_PCI) += ptdma-pci.o
diff --git a/drivers/dma/ptdma/ptdma-debugfs.c b/drivers/dma/ptdma/ptdma-debugfs.c
new file mode 100644
index 0000000..c8307d3
--- /dev/null
+++ b/drivers/dma/ptdma/ptdma-debugfs.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AMD Passthrough DMA device driver
+ * -- Based on the CCP driver
+ *
+ * Copyright (C) 2016,2021 Advanced Micro Devices, Inc.
+ *
+ * Author: Sanjay R Mehta <sanju.mehta@amd.com>
+ * Author: Gary R Hook <gary.hook@amd.com>
+ */
+
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+
+#include "ptdma.h"
+
+/* DebugFS helpers */
+#define	RI_VERSION_NUM	0x0000003F
+
+#define	RI_NUM_VQM	0x00078000
+#define	RI_NVQM_SHIFT	15
+
+static int pt_debugfs_info_show(struct seq_file *s, void *p)
+{
+	struct pt_device *pt = s->private;
+	unsigned int regval;
+
+	seq_printf(s, "Device name: %s\n", dev_name(pt->dev));
+	seq_printf(s, "   # Queues: %d\n", 1);
+	seq_printf(s, "     # Cmds: %d\n", pt->cmd_count);
+
+	regval = ioread32(pt->io_regs + CMD_PT_VERSION);
+
+	seq_printf(s, "    Version: %d\n", regval & RI_VERSION_NUM);
+	seq_puts(s, "    Engines:");
+	seq_puts(s, "\n");
+	seq_printf(s, "     Queues: %d\n", (regval & RI_NUM_VQM) >> RI_NVQM_SHIFT);
+
+	return 0;
+}
+
+/*
+ * Return a formatted buffer containing the current
+ * statistics of queue for PTDMA
+ */
+static int pt_debugfs_stats_show(struct seq_file *s, void *p)
+{
+	struct pt_device *pt = s->private;
+
+	seq_printf(s, "Total Interrupts Handled: %ld\n", pt->total_interrupts);
+
+	return 0;
+}
+
+static int pt_debugfs_queue_show(struct seq_file *s, void *p)
+{
+	struct pt_cmd_queue *cmd_q = s->private;
+	unsigned int regval;
+
+	if (!cmd_q)
+		return 0;
+
+	seq_printf(s, "               Pass-Thru: %ld\n", cmd_q->total_pt_ops);
+
+	regval = ioread32(cmd_q->reg_control + 0x000C);
+
+	seq_puts(s, "      Enabled Interrupts:");
+	if (regval & INT_EMPTY_QUEUE)
+		seq_puts(s, " EMPTY");
+	if (regval & INT_QUEUE_STOPPED)
+		seq_puts(s, " STOPPED");
+	if (regval & INT_ERROR)
+		seq_puts(s, " ERROR");
+	if (regval & INT_COMPLETION)
+		seq_puts(s, " COMPLETION");
+	seq_puts(s, "\n");
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(pt_debugfs_info);
+DEFINE_SHOW_ATTRIBUTE(pt_debugfs_queue);
+DEFINE_SHOW_ATTRIBUTE(pt_debugfs_stats);
+
+void ptdma_debugfs_setup(struct pt_device *pt)
+{
+	struct pt_cmd_queue *cmd_q;
+	struct dentry *debugfs_q_instance;
+
+	if (!debugfs_initialized())
+		return;
+
+	debugfs_create_file("info", 0400, pt->dma_dev.dbg_dev_root, pt,
+			    &pt_debugfs_info_fops);
+
+	debugfs_create_file("stats", 0400, pt->dma_dev.dbg_dev_root, pt,
+			    &pt_debugfs_stats_fops);
+
+	cmd_q = &pt->cmd_q;
+
+	debugfs_q_instance =
+		debugfs_create_dir("q", pt->dma_dev.dbg_dev_root);
+
+	debugfs_create_file("stats", 0400, debugfs_q_instance, cmd_q,
+			    &pt_debugfs_queue_fops);
+}
diff --git a/drivers/dma/ptdma/ptdma-dev.c b/drivers/dma/ptdma/ptdma-dev.c
index 46e7eff..8a6bf29 100644
--- a/drivers/dma/ptdma/ptdma-dev.c
+++ b/drivers/dma/ptdma/ptdma-dev.c
@@ -102,6 +102,7 @@ int pt_core_perform_passthru(struct pt_cmd_queue *cmd_q,
 	struct ptdma_desc desc;
 
 	cmd_q->cmd_error = 0;
+	cmd_q->total_pt_ops++;
 	memset(&desc, 0, sizeof(desc));
 	desc.dw0 = CMD_DESC_DW0_VAL;
 	desc.length = pt_engine->src_len;
@@ -150,6 +151,7 @@ static irqreturn_t pt_core_irq_handler(int irq, void *data)
 	u32 status;
 
 	pt_core_disable_queue_interrupts(pt);
+	pt->total_interrupts++;
 	status = ioread32(cmd_q->reg_control + 0x0010);
 	if (status) {
 		cmd_q->int_status = status;
@@ -250,6 +252,9 @@ int pt_core_init(struct pt_device *pt)
 	if (ret)
 		goto e_dmaengine;
 
+	/* Set up debugfs entries */
+	ptdma_debugfs_setup(pt);
+
 	return 0;
 
 e_dmaengine:
diff --git a/drivers/dma/ptdma/ptdma.h b/drivers/dma/ptdma/ptdma.h
index 1329c55..860e302 100644
--- a/drivers/dma/ptdma/ptdma.h
+++ b/drivers/dma/ptdma/ptdma.h
@@ -216,6 +216,8 @@ struct pt_cmd_queue {
 	u32 q_status;
 	u32 q_int_status;
 	u32 cmd_error;
+	/* Queue Statistics */
+	unsigned long total_pt_ops;
 } ____cacheline_aligned;
 
 struct pt_device {
@@ -254,6 +256,9 @@ struct pt_device {
 
 	wait_queue_head_t lsb_queue;
 
+	/* Device Statistics */
+	unsigned long total_interrupts;
+
 	struct pt_tasklet_data tdata;
 };
 
@@ -307,6 +312,7 @@ struct pt_dev_vdata {
 int pt_dmaengine_register(struct pt_device *pt);
 void pt_dmaengine_unregister(struct pt_device *pt);
 
+void ptdma_debugfs_setup(struct pt_device *pt);
 int pt_core_init(struct pt_device *pt);
 void pt_core_destroy(struct pt_device *pt);
 
-- 
2.7.4

