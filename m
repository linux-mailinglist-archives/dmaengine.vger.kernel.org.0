Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54564343818
	for <lists+dmaengine@lfdr.de>; Mon, 22 Mar 2021 06:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhCVFAf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Mar 2021 01:00:35 -0400
Received: from mail-co1nam11on2056.outbound.protection.outlook.com ([40.107.220.56]:18369
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229822AbhCVFAQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Mar 2021 01:00:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVAcc/R+8ubjtHmWRt87yd5aZMYZqkJZWd2TaVlU93Ob6dRlrWcQa+MZOHOsbizx98qDKLps2DNJkC6FQje3lrP6KYiKmlVQ3aAeY6xZVM3ljohJFnt7rMl2fj6i0uZwzDDStnN+MUWrSIcKnbuFjrKAOlvOmPLimRYTgn35+9KHIOcV52L48YSI0YgECSoxpNJBlYT+VTwJqOYjXVx+v37ys2stJzrToWA3Cy5a+XWknhnRjxx44h9PXZJWHyEHsbQLbaPFBBsCl3XoJbfBvsMwqvkp0ylySXcaHllSHh/Yzudv8WVO66NdVIabWkt21FugfTHbEtomMD5Wwk+swg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8RYkGzd5uyJWaQRUFtOoWpAnqkQ+3yrXD3N/ydP08o=;
 b=M8cNWjmBaLcwRyRbrzLAnTB9z5lqu1d0bQhbyA+cwBucqEwy+BdETkaHt1tNSI34iuD1qLGCkGi1PSbEMTlce3E7HekfTm8ouARdW28Z6SrJdpofx5wP521WoST7DsFo57eK6W4tWR+QjLcOz1SV9bbcekpmIQzNZucJY7hhbFAM7Zo6M5idRXJ6N/fvjGWOADFYuJ7N4P+X6o36CwtakGkPsYcNAsdArbceYOLTYWpmnJTDwL1uNSOxRFYF7YJ02YR4M7e/vsJTFurHULpJCARz3Ra/MzP1pmwZermkJYLnVKZ+U0oemISqpD3uPwc6rkS9yJTdP35GigdilSCJUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8RYkGzd5uyJWaQRUFtOoWpAnqkQ+3yrXD3N/ydP08o=;
 b=eivSyTiI6z3/2lMh3P61iObkYH3PwzZwXogpoKl14/rkIVBMFchyEyuFJJzy8rGk0npaUiTx4JXhjHOPZimTfgX3PaVItpXMQ0lQqLM11ljA7wJMscU+hmEkPUpGtu0NmnY+jkdG4sU2bOfEMLEHORHe6nHUzEwcYLYwFgn3tLw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB2549.namprd12.prod.outlook.com (10.172.121.10) by
 CY4PR1201MB0040.namprd12.prod.outlook.com (10.172.77.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18; Mon, 22 Mar 2021 05:00:11 +0000
Received: from CY4PR1201MB2549.namprd12.prod.outlook.com
 ([fe80::e974:eaaf:2994:ccb6]) by CY4PR1201MB2549.namprd12.prod.outlook.com
 ([fe80::e974:eaaf:2994:ccb6%4]) with mapi id 15.20.3955.025; Mon, 22 Mar 2021
 05:00:11 +0000
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     vkoul@kernel.org
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v8 3/3] dmaengine: ptdma: Add debugfs entries for PTDMA
Date:   Sun, 21 Mar 2021 23:59:32 -0500
Message-Id: <1616389172-6825-4-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616389172-6825-1-git-send-email-Sanju.Mehta@amd.com>
References: <1616389172-6825-1-git-send-email-Sanju.Mehta@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MA1PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::13) To CY4PR1201MB2549.namprd12.prod.outlook.com
 (2603:10b6:903:da::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sanjuamdntb2.amd.com (165.204.156.251) by MA1PR01CA0143.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 05:00:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1f245350-22fb-4862-7f01-08d8ecef5f51
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0040:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB00405720CFABC416B9EA54E5E5659@CY4PR1201MB0040.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:22;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1fRBXzKPKlStP4ZOlHD5ZptMTXh5q/riRcuYdQ8YbZb2COsjHhlU2I3K1QWCf8Jb4YCmhMFYA7KYJzXVY7LxqcRytdudOTzaoPCao9P06pY7VbWkKnfRULvvtvn2dyxCZWPtCN6rs0nm4ZkvCFwxjp7I9gsKEoZ7eHngBJrJgx7xLV72w0fCGSSCkaJMlxB5jil+NAwgKIQzWVJhnxWMTk0vdOFHCMfs8j7+LvxbWxA8RImo+4IGgMe1vfJi2GELcELJc++Eqpw6BzRhP4fjjAyYLBJpMIRuV8YsE5bd3Td4Z7eC5WGREi9t2YRfyb5k+rHzrCtvWlxFwtDyalwCv7ZACrMdA3LSFA4rONk+P29+t5N6FtJQrcY7Wo/pAp64+uE9b5c8XfepH+slwd7tmjo7s32PK784DL8pAtMUuE+jYr1aeTq/CBzJ7oQHPNEc/uAQ8S3VHJ+GMrX9D430uJuAEsLUzEeb4+CBfDuFFfviyEMvx0HUKIs8G1alA7k6pY21AOlV25b8u0Dz1uTKDZgU1z67fRV/r/gqxatWZOlwHXARcnSBNCszTr8cKejJGiQ9S/zB+RpF3GWaKi2+KJps6pq5NTA3zUoqbqdhNshe+cCtIN56IKwrsiKv52DhCI8JRm8oTwKuY1WNIewmmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB2549.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(66946007)(16526019)(5660300002)(38100700001)(36756003)(6486002)(66556008)(8936002)(83380400001)(66476007)(8676002)(26005)(4326008)(6666004)(316002)(7696005)(186003)(86362001)(478600001)(6916009)(956004)(2616005)(2906002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?j4TAFVxAgEhS6KSvMLVcMchVzzmkC/GT9EXVLvm3ZV7drKccG+I0jflmWfMo?=
 =?us-ascii?Q?WE/xPBeLiOORMphPywr9GFKa+hbwfawqwf2ed81SVobNh7tgkactOH6utPCX?=
 =?us-ascii?Q?anZaykzSbdufhLX0WQV7paAI82M2dq9ze06oMYymkFSarxePfpJMbTHWlviY?=
 =?us-ascii?Q?Nu7duPezr52ZShCZ9Cpto2ZFZa7BSmrL/fWjd3T7JKh1d6kpNjdHrLLUz0M7?=
 =?us-ascii?Q?J1XU+sJcM9YUn/tCSKZM0aIhrilLyFFeFdlVkehQ6tAx9295XrhVIqRuWw8P?=
 =?us-ascii?Q?lgE0PUH/DfO/f695pygBfiTS2ru8fcmEJaYNnZIo364gZvuecIJiC8iUjMIK?=
 =?us-ascii?Q?sYgUb/uF+6CqVDRbJ0hOC7Q86YPji3w4rO7qixluRZjmZIY/IIUMOV+usirW?=
 =?us-ascii?Q?c8bUvQjvPbrwzogjeg3WNDp4h4wKNnazqhbSEG6kLlo3mX46JtLyV1QUpfBx?=
 =?us-ascii?Q?4TalNLnNqpSVDFQnXzDHdkVMqni26PFEjh+H2eAg1w2J9Vxf+0rV8l5RdMwl?=
 =?us-ascii?Q?QxlnrXoRoOgfHXiRN2Vx8/3pZL9T1xCt0iJN485NvYWcF30D3xU38XUI22iP?=
 =?us-ascii?Q?w73L5rKTSFeL9/IC89a+AhqjETOW4bfTmyYG1nRM+BrzOyVP/6Bwe4kSI2iN?=
 =?us-ascii?Q?SniSkYttldsM3IgkBa3s9/t4aE37D2eqbMT5rUFlrtBAAUDaPTVVHyDZaYn8?=
 =?us-ascii?Q?UrwEyuZlDVSP4Lx2rhMCWHDlVwr7JAweJr3x5eV7bEVNmI45FLlehXvlkbGK?=
 =?us-ascii?Q?7lJT3TXDOWmEP3t1lkvgRxQbr0mSWY6fIgrHiOYkCV7TAK153+z7YYTLhhpg?=
 =?us-ascii?Q?38pTVbHXZL+WJzB2KMUIC8OF1XkoH213qHMzgOXPaGRGwXV32yBqlEDUsXnv?=
 =?us-ascii?Q?wXmZXoOY9qT6yOr4dNEcvrDFA1y06VoASE1mLHx5JsGbCFS8JxwDvwWaRqW3?=
 =?us-ascii?Q?EA5qTmJwU009B8DDN+3PZwuIVMmbKXqIuPxX+7NktEjg9d3Ty8qqqRzelmM3?=
 =?us-ascii?Q?Ug8Z6znbZlDBI3NtFcdhUMmm3Ugx2aCxp+CErqZ8cgF2KLvC/Zlpe5ZzK6Gb?=
 =?us-ascii?Q?i7EJkv6bip1IpUhCYV7KMoh3H4E+L3Zr9OQOx5xj4sc/el4uXrAy0lis616U?=
 =?us-ascii?Q?KBBCWG0+yLp22mo+dANcaucQcI5SVniHpA6C2J1s4wTc3GBvCYOhR0RFD5+2?=
 =?us-ascii?Q?HmXDzCcjtzJSEtLXU5CyYRj+1JwnpVv92E20d3rP1DK6vW8bDbUwPpxqbf3w?=
 =?us-ascii?Q?OrVCOd7GL4+G02JppnEeHL7uMIhfZW58CaO2fy1n9dslYKFZFaMVZLBm62W+?=
 =?us-ascii?Q?ATLuQPbmPb9cY746ea/4zdvD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f245350-22fb-4862-7f01-08d8ecef5f51
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB2549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 05:00:11.7858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YJP9x3aM1nHMd5JtFzeYKNZCx6AswNT7qDnRgoDZm9uxJXY4rfRY2LinJqHFtxxFVBhcaVjUV7AK4mz7/QO4PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0040
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

