Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36B828FF46
	for <lists+dmaengine@lfdr.de>; Fri, 16 Oct 2020 09:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404714AbgJPHkU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Oct 2020 03:40:20 -0400
Received: from mail-dm6nam11on2076.outbound.protection.outlook.com ([40.107.223.76]:2273
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404630AbgJPHkU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 16 Oct 2020 03:40:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxyOu7m5xLtifVmVzxUR9RVFTogB1+bu1x1ybXKkqNz7X99vHHu0VIuxttDGy0BM/bADxTcSpeYr9sr8RZMLn2ikGPZ1DgwJIUWIHcj5E2KHrFTjA8jeut/W6JHvyhgmjWGciEKMDmsr22SRJZU3hVPgU+3h5ehpJB5n02c5xUX5SAcw+J65NwXpWgoaBTpmvQ8XgyfFj0his6FsIEg+20wBketu6PVeB91tvIl3T2h/VlKu9/2eubibpW96iYgL53K7nkk2+azO/Zd3R4LJYuBEs75yzr/rZRPg4AGXRQ2Z0hGdSAER7/DuQy1vCtHPc2VM4ej8K2ima8izCNCIQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h93f/5IcVFknBzP0aviAtUP0iX4JRJ5aXtDEtdmuhXE=;
 b=khYewHjKjhZgZx08Cp01D/jakQweJTjzFOwUGhRykg5qG1H4YXJMEL9d+/2Vebhwo9jGZ0AkxhaAMfVGT1Du9y4KhP+FbYfyhOmOZ3NUfwQT6xvAitybLlYzNmuFAjYIjOOuQfM9+3YEYEe6s2aKq0sSGtd2Dl7VPw6mFo6z7GN7PHkOAfhIB6cOEBQSNeYhrmYbfWaF7zIPim69sBk9yeOn7F0Hv71K8GwQ9c3yroWqrE+Sb0EKQl2wJKSee2rkGpNzsSfU7IYN+i8IiiPcWBnJnDH9FWaL65qR26c8xoVaX2NUTsi8DFHC8O+x+nx25LBXxDX8tpotYc9YaHjARw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h93f/5IcVFknBzP0aviAtUP0iX4JRJ5aXtDEtdmuhXE=;
 b=mTlDzpWOLxAhxE7MMJ1bQ8IQU6bu0oLQR0bDkV0tvNUKx60D+6G5cFTIQgUjA4mbr4vFsXDT8SxUobnsIqg7Ot6cAMTmAoHXkYdtrI3yTEpa2hRh9k7NaP3cipMj3yYl49bZRrX3RUmiznyhRvhDjKOzJWwNknq1e8gK7yxcp+o=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3540.namprd12.prod.outlook.com (2603:10b6:408:6c::33)
 by BN6PR1201MB0212.namprd12.prod.outlook.com (2603:10b6:405:56::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Fri, 16 Oct
 2020 07:40:17 +0000
Received: from BN8PR12MB3540.namprd12.prod.outlook.com
 ([fe80::9d06:595:4be5:3af7]) by BN8PR12MB3540.namprd12.prod.outlook.com
 ([fe80::9d06:595:4be5:3af7%7]) with mapi id 15.20.3477.024; Fri, 16 Oct 2020
 07:40:17 +0000
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     vkoul@kernel.org
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v7 3/3] dmaengine: ptdma: Add debugfs entries for PTDMA information
Date:   Fri, 16 Oct 2020 02:39:07 -0500
Message-Id: <1602833947-82021-4-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602833947-82021-1-git-send-email-Sanju.Mehta@amd.com>
References: <1602833947-82021-1-git-send-email-Sanju.Mehta@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MAXPR01CA0101.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::19) To BN8PR12MB3540.namprd12.prod.outlook.com
 (2603:10b6:408:6c::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sanjuamdntb2.amd.com (165.204.156.251) by MAXPR01CA0101.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3477.21 via Frontend Transport; Fri, 16 Oct 2020 07:40:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 67271727-48d9-4b2e-266e-08d871a6b985
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0212:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0212E32CC56B3DAFC1AC0CB0E5030@BN6PR1201MB0212.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:22;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MouukEC83madbk9BO087enzcWucKzXWUV9sNpBln6d2EbFOAtiNYnPh4df7rQ9iLSBhgpzrVMCa12YDsct+WGKN0nFo6n1xD3Nd71cjOeyZajqQG/LIPVCJmrS9n6gyjZZ2VQogTgQK2eLjIFO+Y/QStCe/G4kHo4RFq4VdgLzdMSO0XmFDkTZMPjz8tehZC0UlrOot341133DPtwCyveA4nGIyxJKvuKRUcdC3UrZUJ5OlBssQVZG5Yq6vDmfZhnnx1wjfQPhj/bfdgrKnHoLOR0oyaCdsYoqRgslr5BXRToSNuyIJB+NwX9oTy1F1qnRrWjzFVXMu+q3fCSY9w5VFcxMAzTmfj2jY2+ThZ2LgyVRFfaoKujiJ7VXS/QdjK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3540.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(478600001)(4326008)(6916009)(5660300002)(2616005)(956004)(34490700002)(6486002)(86362001)(316002)(7696005)(6666004)(16526019)(186003)(52116002)(26005)(8936002)(8676002)(66946007)(66556008)(36756003)(2906002)(66476007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: JT59/mNZNRox3a7gmcHsPSO8ubA8PVQohycdhT4N9YI/N2XNNzrbgy20LPOS5KnyTbF+nMo88nm1hTjrtVkIirxqQYXRqtNsN4oM8FyZz5aWIClw38RKjxfADohb6+rN7/7J9AfuF79P39lGylKZXwd/LCOVfCpL09LbKDWMmI0sXD1IqfVRFfLgTyJpxNEPyL+9Mj/NNHyCUFDlqRPX8D+pChDgB9hnFhoqXK6tnBhzJZa7cagKInkZA5ZWLLiYMIleXoEePX2lMQliSAx06ndk05qqT/awo9LDBDqG/YShUFsVs1POVBBEC2V6f7xB557oPmX4jsB8FeO4ml+NSnAs17twZj3TPMrGfqHv+ZBRacupV5NAIKIdstSXp3msh9oK7Y3JX4lCYxuPmS1tXpYl4fnHwUpmc8sURUYIPby+LRVtp72g8p0aa/jZ687lKGUgGpoYHq82S940ezGsSX/m+zAyfdUL9gUuYjohJRnHRyZl44TTomN4tyQffswIgAY5N8aClPmsYF9DphCt6v1+Ni/Jv4GyA0EGUXB4TUBtthWkFOC2NZjCegsA6mrhxaFEe16aPfMYvs+ZHN4q+w6qkQ/8ZjtXYBb+dFTai76zQgPyXxnFeclfagJlahft6lveWNQ1qLwaO9/AGhf+Eg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67271727-48d9-4b2e-266e-08d871a6b985
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3540.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 07:40:16.8363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/3R0X3GEDuZKa3UpT7fcPCp3ae4+dsE6EE9GLr/gLTFXvlK5RIV1ESNy7tPr90YqlktE9pA8phxok/gmBUE2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0212
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
 drivers/dma/ptdma/ptdma.h         |   5 ++
 4 files changed, 126 insertions(+), 1 deletion(-)
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
index 0000000..03d47cd
--- /dev/null
+++ b/drivers/dma/ptdma/ptdma-debugfs.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AMD Passthrough DMA device driver
+ * -- Based on the CCP driver
+ *
+ * Copyright (C) 2016,2020 Advanced Micro Devices, Inc.
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
index 4bdad35..0f44944 100644
--- a/drivers/dma/ptdma/ptdma-dev.c
+++ b/drivers/dma/ptdma/ptdma-dev.c
@@ -106,6 +106,7 @@ int pt_core_perform_passthru(struct pt_cmd_queue *cmd_q,
 	struct ptdma_desc desc;
 
 	cmd_q->cmd_error = 0;
+	cmd_q->total_pt_ops++;
 	memset(&desc, 0, sizeof(desc));
 	desc.dw0.val = CMD_DESC_DW0_VAL;
 	desc.length = pt_engine->src_len;
@@ -154,6 +155,7 @@ static irqreturn_t pt_core_irq_handler(int irq, void *data)
 	u32 status;
 
 	pt_core_disable_queue_interrupts(pt);
+	pt->total_interrupts++;
 
 	status = ioread32(cmd_q->reg_interrupt_status);
 	if (status) {
@@ -279,6 +281,9 @@ int pt_core_init(struct pt_device *pt)
 	if (ret)
 		goto e_dmaengine;
 
+	/* Set up debugfs entries */
+	ptdma_debugfs_setup(pt);
+
 	return 0;
 
 e_dmaengine:
diff --git a/drivers/dma/ptdma/ptdma.h b/drivers/dma/ptdma/ptdma.h
index 67c24bd..67027d8 100644
--- a/drivers/dma/ptdma/ptdma.h
+++ b/drivers/dma/ptdma/ptdma.h
@@ -232,6 +232,8 @@ struct pt_cmd_queue {
 	u32 q_status;
 	u32 q_int_status;
 	u32 cmd_error;
+	/* queue Statistics */
+	unsigned long total_pt_ops;
 } ____cacheline_aligned;
 
 struct pt_device {
@@ -270,6 +272,8 @@ struct pt_device {
 
 	wait_queue_head_t lsb_queue;
 
+	/* Device Statistics */
+	unsigned long total_interrupts;
 	struct pt_tasklet_data tdata;
 };
 
@@ -335,6 +339,7 @@ struct pt_dev_vdata {
 int pt_dmaengine_register(struct pt_device *pt);
 void pt_dmaengine_unregister(struct pt_device *pt);
 
+void ptdma_debugfs_setup(struct pt_device *pt);
 int pt_core_init(struct pt_device *pt);
 void pt_core_destroy(struct pt_device *pt);
 
-- 
2.7.4

