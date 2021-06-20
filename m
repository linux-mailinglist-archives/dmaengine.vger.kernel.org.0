Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138943ADF6B
	for <lists+dmaengine@lfdr.de>; Sun, 20 Jun 2021 18:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbhFTQoh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 20 Jun 2021 12:44:37 -0400
Received: from mail-bn8nam11on2075.outbound.protection.outlook.com ([40.107.236.75]:12673
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230071AbhFTQod (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 20 Jun 2021 12:44:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N82l8iGO9EcCJkTYYua+Mc2TmYDHhFC/eihXe18851XmeKeq7whxBq2wfc0yj4KnXB45NWPIdwQYH/5pSLhA9sMJsOQKZff/c9hAiSBaUQttVGW6rlUE/ANxWJ64lQIt+QcsJNz+cGj7fiCpKHhxeRZ1UUYmM9KdXtAIGg2Bqu2D7wsK3OwuuwGK1W4Spp8oiHZFXu1L4GuwisovMOuKVTnTzwhGmmEyIA1mmMbmtU8hLfzJT+E++Mhxv3gK2BSEC+760blCNzO9yAlDRCjOcE2FoDp8QFzuUM1s5ywW4e152sxIyAeb4TXnKVQS/SYOjFiBITnbNJSfN3IJJyPicw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqgVgDOoZ144yhEAIG4lsGnyh38F/A14DCvgzTOuHMM=;
 b=deIsB5tWb582bcVLCC4Y+UnCr+O7L3qm5gJPdiVu8MyihZYAM6XF757KQuerqKQ/I4COgAQlLcTiabKd2je5B0xr8mw+BIbJ3LsPVz7B1uuJfDBKQ+2aEsKuIOHZpr9Xrc0JBRPdR+RXM/tICeTIChLgrs+gqRoOtldvWnXvgW7Xi0HXo+6Qfv5CxBWInYeqzrxh5TJz9R5aLHz/LFQWH1a85frV4+DTaZCKfqmZd4elu0wlR3RS/V22p2qmT88YH2jsh3uAmHtvx8WplInHko2DRoOmhFpzphxt7pUP5O1lK+Sbfn8hBm6MeUcjIR9sOuV3zSeI3HVPix+xObzdwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqgVgDOoZ144yhEAIG4lsGnyh38F/A14DCvgzTOuHMM=;
 b=uJzdQZCuNgzudnD7iTVrMA9di++cae8twVEJOUlHriuBJFL4XpUhaPQw2QHRK700EWjzxET0SL/xNx4MhXAc21ebMnA3o9n4FmdJVhNa739RjNuFrJeqkzK2mZKj4UL6xxyD+QcSUbN4DD8oadwbGLUMbucZm3INRa1XvcHJASk=
Received: from BN6PR1101CA0021.namprd11.prod.outlook.com
 (2603:10b6:405:4a::31) by CH2PR12MB4954.namprd12.prod.outlook.com
 (2603:10b6:610:63::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Sun, 20 Jun
 2021 16:42:13 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4a:cafe::e0) by BN6PR1101CA0021.outlook.office365.com
 (2603:10b6:405:4a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21 via Frontend
 Transport; Sun, 20 Jun 2021 16:42:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Sun, 20 Jun 2021 16:42:13 +0000
Received: from sanjuamdntb2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 20 Jun
 2021 11:42:08 -0500
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     <vkoul@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <dan.j.williams@intel.com>,
        <Thomas.Lendacky@amd.com>, <Shyam-sundar.S-k@amd.com>,
        <Nehal-bakulchandra.Shah@amd.com>, <robh@kernel.org>,
        <mchehab+samsung@kernel.org>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v10 3/3] dmaengine: ptdma: Add debugfs entries for PTDMA
Date:   Sun, 20 Jun 2021 11:41:38 -0500
Message-ID: <1624207298-115928-4-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1624207298-115928-1-git-send-email-Sanju.Mehta@amd.com>
References: <1624207298-115928-1-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 585da1dd-9c8f-4ecd-4514-08d9340a5b75
X-MS-TrafficTypeDiagnostic: CH2PR12MB4954:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4954CD879D399A2D57F2D8E5E50B9@CH2PR12MB4954.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:22;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o0qmfY9u/Qr+oFibhMx/loCE5QizAHM6HC+E5sb4Xww9acVpbFN9ziB5IzuyaEkP63Ebs2q6SI0QAYBH+v406GPpB8mIS3WKarvUJ3AYj0ZrLSJrcOwEksKL+truwug6LaVzqFdSvDL9MQDTqzuijVUuweaBHOwxiNqpAXpyvK6vSNHeyvqAIYRQgzpmxq87dck8j5Myk9iP6ZCGgroj360+cx90QjLK3kMh9nojaBK9cELiZZEAlDsRYxwOaI3tvvgul47qAjRY8pj/+oSyvboQi8NPq4N5MRCtI+oRUuqjRhIlPiUfoJeHr7MAFxQSWqva0c78R6QzDGXziQMtks27+oTeaYOITjiFgnlN9VleXb3nUkv7O3FQRzNWy52sZRE8YgpvxcWcVHk3VN0huBCIM4B45dO0m2qhCE4NJEa3uQa0du394GoscjFu64+gVdhPueRsLtMTcBaQRkX1lPtBCYhQsD/5AEtKILJGQP5SMmFWXksNuNRFYZAsbx/VCbLyuKDQzYVg49mxR3rJSddQ4UA/YFc7mMhgE1LgUxP7i0RtOCZqYd3Gm0N0Pf2Iib/Z8VKmSx0mh0aSPYpwjddBhMHIgQw/3vZkYTIGVUSjmS9OsmdOkupqMV5UZmlqm/nJLMNpwZAxa0nH89a9xUMJxRb8g/r35p8CJEF9ttcIcHJgNi1EgESt83Xx6Fle
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(376002)(396003)(46966006)(36840700001)(36756003)(86362001)(426003)(8676002)(186003)(336012)(82740400003)(36860700001)(6666004)(16526019)(478600001)(316002)(2616005)(82310400003)(70206006)(7696005)(81166007)(6916009)(70586007)(4326008)(26005)(83380400001)(356005)(5660300002)(54906003)(47076005)(2906002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2021 16:42:13.7825
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 585da1dd-9c8f-4ecd-4514-08d9340a5b75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4954
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
 drivers/dma/ptdma/ptdma-debugfs.c | 110 ++++++++++++++++++++++++++++++++++++++
 drivers/dma/ptdma/ptdma-dev.c     |   5 ++
 drivers/dma/ptdma/ptdma.h         |   6 +++
 4 files changed, 122 insertions(+), 1 deletion(-)
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
index 0000000..57d81c3
--- /dev/null
+++ b/drivers/dma/ptdma/ptdma-debugfs.c
@@ -0,0 +1,110 @@
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
+static int pt_debugfs_info_show(struct seq_file *s, void *p)
+{
+	struct pt_device *pt = s->private;
+	unsigned int regval;
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
+	debugfs_create_file("stats", 0400, pt->dma_dev.dbg_dev_root, pt,
+			    &pt_debugfs_stats_fops);
+
+	cmd_q = &pt->cmd_q;
+
+	snprintf(name, MAX_NAME_LEN - 1, "q");
+
+	debugfs_q_instance =
+		debugfs_create_dir(name, pt->dma_dev.dbg_dev_root);
+
+	debugfs_create_file("stats", 0400, debugfs_q_instance, cmd_q,
+			    &pt_debugfs_queue_fops);
+}
diff --git a/drivers/dma/ptdma/ptdma-dev.c b/drivers/dma/ptdma/ptdma-dev.c
index c1323ed..4429de0 100644
--- a/drivers/dma/ptdma/ptdma-dev.c
+++ b/drivers/dma/ptdma/ptdma-dev.c
@@ -102,6 +102,7 @@ int pt_core_perform_passthru(struct pt_cmd_queue *cmd_q,
 	struct ptdma_desc desc;
 
 	cmd_q->cmd_error = 0;
+	cmd_q->total_pt_ops++;
 	memset(&desc, 0, sizeof(desc));
 	desc.dw0 = CMD_DESC_DW0_VAL;
 	desc.length = pt_engine->src_len;
@@ -151,6 +152,7 @@ static irqreturn_t pt_core_irq_handler(int irq, void *data)
 	bool err = true;
 
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
index 9627585..a5cd65f 100644
--- a/drivers/dma/ptdma/ptdma.h
+++ b/drivers/dma/ptdma/ptdma.h
@@ -225,6 +225,8 @@ struct pt_cmd_queue {
 	u32 q_status;
 	u32 q_int_status;
 	u32 cmd_error;
+	/* Queue Statistics */
+	unsigned long total_pt_ops;
 } ____cacheline_aligned;
 
 struct pt_device {
@@ -263,6 +265,9 @@ struct pt_device {
 
 	wait_queue_head_t lsb_queue;
 
+	/* Device Statistics */
+	unsigned long total_interrupts;
+
 	struct pt_tasklet_data tdata;
 };
 
@@ -316,6 +321,7 @@ struct pt_dev_vdata {
 int pt_dmaengine_register(struct pt_device *pt);
 void pt_dmaengine_unregister(struct pt_device *pt);
 
+void ptdma_debugfs_setup(struct pt_device *pt);
 int pt_core_init(struct pt_device *pt);
 void pt_core_destroy(struct pt_device *pt);
 
-- 
2.7.4

