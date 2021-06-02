Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C31399191
	for <lists+dmaengine@lfdr.de>; Wed,  2 Jun 2021 19:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhFBRYv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 2 Jun 2021 13:24:51 -0400
Received: from mail-mw2nam12on2075.outbound.protection.outlook.com ([40.107.244.75]:65024
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230219AbhFBRYv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 2 Jun 2021 13:24:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Br4sCQSNfheu6ovQJcRWz8fuZRFaOpDtZagSJcxzdnHzJUgrxXLjH9rqKPcxncEjhxH4gFt57/lKBrP9B4Yqi52RoYQMv1BZ1DrhdxlIbqizbrecPlcMYIK00pG/fdrqlg1PpEL/mWInQeBxTTKDzpci5s3Yb2IXNvZLUjfs2o21YTLzwXP9HkmpKxnimgcROMoxhRbFZBAgDUOkuKp2f5E/L9gL2Hqx01j5IC8yYWHSDH7kn0E98XtE5N/zwOHik+NYR2KUcaNl7eKCTJj+c4bYqxy+Ywbsiq5Qp/emml/8SsBTZpUKsEJ0piTu8g1c27QjWfVVLd0TUQg1aM7aTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8RYkGzd5uyJWaQRUFtOoWpAnqkQ+3yrXD3N/ydP08o=;
 b=D0Yzbfq05IPikmyYLpRmoulBR1HHv4CQOIq2Nc4GC3oFmTRg6IlzIQNWBs4v0bSzwT+q5sOvNg2dybEghho12snTZppG5ZX1ILrjHXepuDa6C60uUtCZ87yhc0JBc5RlayqPJNBJcP+6zp+ItM6k7pF9GdriwZy5jZDOLL3QKzVSibB9vqrzhOwlga3rV1gAwFcBt4zBcLIWwW6QLdeEmHwdPS2m8tpmrglb3e3hzxuOKC+aP+t3YVKVXFT+3JYq12w3vt50RTQ/8mjcC0ZxPhmdXjnA8erKjJ073VYeZlldJnbpZK13i/3vu+eRz0Nu24M6ncddYDRxnSq55a6I5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=amd.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8RYkGzd5uyJWaQRUFtOoWpAnqkQ+3yrXD3N/ydP08o=;
 b=NF0GhQVH8FSpU4t3DAT+aYCl/cSXJST/rsfeUnA6EPZ03uVsMluO9yAEIFVN0vbW4nI8Ed2ofbX7CQtunhcc/hFajR9D/x1MG1a+Rvgsf4saeEK/3Yk6Iety3fEx98I5erL0I+kbR1o55SgbisziE9N+eM9seelltjwl8xH8/nA=
Received: from BN0PR03CA0055.namprd03.prod.outlook.com (2603:10b6:408:e7::30)
 by SN1PR12MB2430.namprd12.prod.outlook.com (2603:10b6:802:30::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 17:23:05 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::3f) by BN0PR03CA0055.outlook.office365.com
 (2603:10b6:408:e7::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21 via Frontend
 Transport; Wed, 2 Jun 2021 17:23:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Wed, 2 Jun 2021 17:23:05 +0000
Received: from sanjuamdntb2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 2 Jun 2021
 12:23:01 -0500
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     <vkoul@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <dan.j.williams@intel.com>,
        <Thomas.Lendacky@amd.com>, <Shyam-sundar.S-k@amd.com>,
        <Nehal-bakulchandra.Shah@amd.com>, <robh@kernel.org>,
        <mchehab+samsung@kernel.org>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v9 3/3] dmaengine: ptdma: Add debugfs entries for PTDMA
Date:   Wed, 2 Jun 2021 12:22:31 -0500
Message-ID: <1622654551-9204-4-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622654551-9204-1-git-send-email-Sanju.Mehta@amd.com>
References: <1622654551-9204-1-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8afc6cec-4ade-4743-3d36-08d925eb155e
X-MS-TrafficTypeDiagnostic: SN1PR12MB2430:
X-Microsoft-Antispam-PRVS: <SN1PR12MB243012C9D53C537879A8BBC0E53D9@SN1PR12MB2430.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:22;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v9zobDqKmKBAaK+8KXDOeJns95N95FBykN3+paxKJ0R9nUmAVwqVmVxfj/xK1tPKt2OBGnFltJKTUqwjs8tQkJIfiEHE61QAJhDXGqijxtNI1rDHScOfwj1nCPVS1f7tUIW/BdOKLWNoz8joV7M9cFx0gRqE5GZcbzSIMho3EQjR4a/J6LMVvRyopua6o0LRpv2U4flGeSRzlPzfwGAjAUy6urtlse/rRWCnKJjvPDEF6crbv0pcT6vdew01dX3kQtDR1K6mTjdF2STmHLbIPSqwGsr7aWqixdOl7iZV+2hos+pGK1KtKw1bfRtDREYpyrBuleYV9bpLqsR7h6W73b6GDRuo9zs/f9RcRCHpcViNqhhuSQdJ4ziRC1g2L1Y05K3uZxPGQjhgJHDKQjVPpn2zQa9gKGAfMcYfFdljYL+eg8WeSyWMwZSzulBtTu4r+ImpZwu6FZ8ey00DplESIvX/zeATw1BAkLQSaqrITTNkQ9n5RJUdjDnj1BZkug06ihn0et1RrsfjsU9fgriXOeekASkeJ18eTTFXWh7x0SP8lwJUNjZBl2YlzyNwgdJ5j++s1b0FWiDvlNXEMVycttF9Kyvi6y+SDV/qsqjq9q405IYbe6WLNsFTjhwlxFtp+8g40flBKiTPqfWpqE/f1+yCOHFTyciVTXgseanQKPHFKNU+8GWJ0KVBPmsHo/i/
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(46966006)(36840700001)(336012)(54906003)(82740400003)(186003)(26005)(8676002)(2616005)(36860700001)(8936002)(6916009)(2906002)(83380400001)(47076005)(86362001)(5660300002)(316002)(16526019)(426003)(70586007)(4326008)(36756003)(478600001)(7696005)(82310400003)(70206006)(81166007)(6666004)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 17:23:05.5235
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8afc6cec-4ade-4743-3d36-08d925eb155e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2430
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
 drivers/dma/ptdma/ptdma-debugfs.c | 115 ++++++++++++++++++++++++++++++++++++++
 drivers/dma/ptdma/ptdma-dev.c     |   5 ++
 drivers/dma/ptdma/ptdma.h         |   6 ++
 4 files changed, 127 insertions(+), 1 deletion(-)
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
index 0000000..1f69159
--- /dev/null
+++ b/drivers/dma/ptdma/ptdma-debugfs.c
@@ -0,0 +1,115 @@
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
+#define	MAX_NAME_LEN	20
+#define	RI_VERSION_NUM	0x0000003F
+
+#define	RI_NUM_VQM	0x00078000
+#define	RI_NVQM_SHIFT	15
+
+static DEFINE_MUTEX(pt_debugfs_lock);
+
+static int pt_debugfs_info_show(struct seq_file *s, void *p)
+{
+	struct pt_device *pt = s->private;
+	unsigned int regval;
+
+	if (!pt)
+		return 0;
+
+	seq_printf(s, "Device name: %s\n", pt->name);
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
+	regval = ioread32(cmd_q->reg_int_enable);
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
+	char name[MAX_NAME_LEN + 1];
+	struct dentry *debugfs_q_instance;
+
+	if (!debugfs_initialized())
+		return;
+
+	debugfs_create_file("info", 0400, pt->dma_dev.dbg_dev_root, pt,
+			    &pt_debugfs_info_fops);
+
+	debugfs_create_file("stats", 0600, pt->dma_dev.dbg_dev_root, pt,
+			    &pt_debugfs_stats_fops);
+
+	cmd_q = &pt->cmd_q;
+
+	snprintf(name, MAX_NAME_LEN - 1, "q");
+
+	debugfs_q_instance =
+		debugfs_create_dir(name, pt->dma_dev.dbg_dev_root);
+
+	debugfs_create_file("stats", 0600, debugfs_q_instance, cmd_q,
+			    &pt_debugfs_queue_fops);
+}
diff --git a/drivers/dma/ptdma/ptdma-dev.c b/drivers/dma/ptdma/ptdma-dev.c
index 7122933..ba37b81 100644
--- a/drivers/dma/ptdma/ptdma-dev.c
+++ b/drivers/dma/ptdma/ptdma-dev.c
@@ -103,6 +103,7 @@ int pt_core_perform_passthru(struct pt_cmd_queue *cmd_q,
 	struct ptdma_desc desc;
 
 	cmd_q->cmd_error = 0;
+	cmd_q->total_pt_ops++;
 	memset(&desc, 0, sizeof(desc));
 	desc.dw0 = CMD_DESC_DW0_VAL;
 	desc.length = pt_engine->src_len;
@@ -151,6 +152,7 @@ static irqreturn_t pt_core_irq_handler(int irq, void *data)
 	u32 status;
 
 	pt_core_disable_queue_interrupts(pt);
+	pt->total_interrupts++;
 
 	status = ioread32(cmd_q->reg_interrupt_status);
 	if (status) {
@@ -272,6 +274,9 @@ int pt_core_init(struct pt_device *pt)
 	if (ret)
 		goto e_dmaengine;
 
+	/* Set up debugfs entries */
+	ptdma_debugfs_setup(pt);
+
 	return 0;
 
 e_dmaengine:
diff --git a/drivers/dma/ptdma/ptdma.h b/drivers/dma/ptdma/ptdma.h
index bc6676d..a02f47a 100644
--- a/drivers/dma/ptdma/ptdma.h
+++ b/drivers/dma/ptdma/ptdma.h
@@ -233,6 +233,8 @@ struct pt_cmd_queue {
 	u32 q_status;
 	u32 q_int_status;
 	u32 cmd_error;
+	/* Queue Statistics */
+	unsigned long total_pt_ops;
 } ____cacheline_aligned;
 
 struct pt_device {
@@ -271,6 +273,9 @@ struct pt_device {
 
 	wait_queue_head_t lsb_queue;
 
+	/* Device Statistics */
+	unsigned long total_interrupts;
+
 	struct pt_tasklet_data tdata;
 };
 
@@ -324,6 +329,7 @@ struct pt_dev_vdata {
 int pt_dmaengine_register(struct pt_device *pt);
 void pt_dmaengine_unregister(struct pt_device *pt);
 
+void ptdma_debugfs_setup(struct pt_device *pt);
 int pt_core_init(struct pt_device *pt);
 void pt_core_destroy(struct pt_device *pt);
 
-- 
2.7.4

