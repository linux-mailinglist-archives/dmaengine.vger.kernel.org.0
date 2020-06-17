Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0732F1FC33D
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2020 03:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgFQBMN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 Jun 2020 21:12:13 -0400
Received: from mail-bn7nam10on2070.outbound.protection.outlook.com ([40.107.92.70]:6071
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726253AbgFQBML (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 16 Jun 2020 21:12:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGHx7NkT3Z5oSQEDl0fxz5+nyiZVnKJaxE2rxLzxoQOUxCvA9NyBPMebvu6rUyRP80WEZwFsUiXdKgIPy3i6XEyKsD+07DBmhFwVHJzLdUZGY65/6NQuGH/m6hJPokenv7SwiU+sIr0VZg5w4Fxb+Aoxo2aCJq3a5sJ1+uz9EaTFSLJZ1EwZ647i6lMAegoaktpTob67rVQE8XWEhpWPX/+hMWUdEQ8UQHt2UxQ+qB2OA9kdaSwq4qM/xjZFDj1DSXFfoNqwhFR2Wr4GhIxoZIJpudBv8fz7eC/SQ/xd9RPpOHyzYwysXNOG+k9M3FtbCeRiozNwARfMF5+zn1ulNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nC8Oxkxs1wUzhNOdHZwUpW/SKj3mk1jlF80dLwUxzkc=;
 b=dliP1bcEuumtIkPsBqJvwu/BXLJHUgdN3S1KoY6btiJYUxOTUq+Hkp/Gk6ObsQAQqGVAHbysO65Da+ytJE4cRQNWbZcXa6NiNj9MuqBUUeq3B2jE+3hqhTO0Y9L04XrWKfou6+vurUWFgfQEztiZzhwE+pSVvcDyoKbxWDoFmc3Fx9adRwL8VnslJ6IRNszaWFtnAuTm8ivo0LCqgGYjyxM839GRrEt7SUvpfu5TU8Y2O2LeLXBppL5YLY798UYWZPtNX6cT1AWa2R6/JoLd6Y1Q5MeNzXDHoA2bZa7hL5oNit6fPGv95DkHv6fKeyAzkvcPhLCctBw2sKCp2ctH6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nC8Oxkxs1wUzhNOdHZwUpW/SKj3mk1jlF80dLwUxzkc=;
 b=Uu2SH/LNk8MS7NLRmqGyiD0EK88OPgZAhMdg/5+jsnT6i12MyB7lP28TXzg3Zs3d8Q9UQcnLBu7r+SeSOehWbB+eRtgGLUFVH8pF7VtaGo2xppA+SCYtAxjtlCXHDl58PIr6ajYAEl2DfbEcKUWJ26UFsV/hd7Bn88c56aAd3sw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3421.namprd12.prod.outlook.com (2603:10b6:208:cd::24)
 by MN2PR12MB3502.namprd12.prod.outlook.com (2603:10b6:208:c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.25; Wed, 17 Jun
 2020 01:12:07 +0000
Received: from MN2PR12MB3421.namprd12.prod.outlook.com
 ([fe80::956f:e98c:37b4:25aa]) by MN2PR12MB3421.namprd12.prod.outlook.com
 ([fe80::956f:e98c:37b4:25aa%7]) with mapi id 15.20.3088.029; Wed, 17 Jun 2020
 01:12:07 +0000
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     vkoul@kernel.org
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v5 3/3] dmaengine: ptdma: Add debugfs entries for PTDMA information
Date:   Tue, 16 Jun 2020 20:11:28 -0500
Message-Id: <1592356288-42064-4-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592356288-42064-1-git-send-email-Sanju.Mehta@amd.com>
References: <1592356288-42064-1-git-send-email-Sanju.Mehta@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR0101CA0003.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::13) To MN2PR12MB3421.namprd12.prod.outlook.com
 (2603:10b6:208:cd::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sanjuamdntb2.amd.com (165.204.156.251) by MA1PR0101CA0003.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3109.21 via Frontend Transport; Wed, 17 Jun 2020 01:12:03 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 903cf98c-97ef-4ece-7fc8-08d8125b73e6
X-MS-TrafficTypeDiagnostic: MN2PR12MB3502:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB35021BD1BC92D209AD1CE2CCE59A0@MN2PR12MB3502.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:22;
X-Forefront-PRVS: 04371797A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0C7v+3FfNmKlHz4bZ7BjB8Jz3oVNfo3fRQE0OcmvVSe+EekQLAytfMwd+rqmLzizjnlMI/xIRD/QlAxf0Gjof/sGy8/NdJ6S2TfIEyNtZSeVus/j5MODyPavPkTqXwLzILkV1NOd1G/3YcSu24iP83wlUjeRUglAczsBwOffH/nwoJEcks2gS2rkZCx1VwbLFFSRg8nbKdKhWs//GMq+9Bx8ilxTgaLRdTzMxW4vFgTDiEtpE3jcoHaYzUbC8vxSNJpBgWJeHVVscarH5HzwL8YQGPOD0si7l//f4EGoNvpyMKOyFb/aNOpeOJU0SLRTDNQLmM3udybicoQuIEIOtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3421.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(5660300002)(4326008)(36756003)(66476007)(956004)(86362001)(7696005)(52116002)(2906002)(6916009)(2616005)(66556008)(66946007)(6666004)(83380400001)(16526019)(316002)(6486002)(478600001)(8676002)(8936002)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: I5/ScXOxCdy9KQzU6Pi8NJmt1ESVUnpy1lo6UibYaZOAUi+cdDZXE0Pn1TAO1NzSAyFMtmFR2qWNX1/oW8PMMD13hkkmlKbJYyU9VbEVP64nMjvi5EoRZeLyzlK0pnWs4dNghhx7VcsiUJbF80sY6aQhqU+detCm6dpA6TtWu0FjFV7CZaroSflQdKxZX65jbeRFzfvWhrtHQ/Je+vyMIIbmCY2PIoQt4CXfWw/29ZhvBWDVrQqfVUHgLrW/x8mo6XgxJHAM0LZqjC9rNcMfmk6RRJuCkUF4ThWe1+aksMz1KeHuedLrulb1pvqeuV0WyoiDyz3S7aLyg7nwq1JtTdyPNuihRbm/RzgUyd7h/BciudJtYUySwGYx8uwYvrGLoIwOv+AJav3lXheNRJc8olDeuGS+qSc1v0/wfeERYDZ4W9d9Xl5KDkkmP/d8nMrc5zWBlzu3sQCArTFnfatZj1WmfELkSM+EffUam8hrDIjAbXBh+HHkzIOf9PopUrrv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 903cf98c-97ef-4ece-7fc8-08d8125b73e6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2020 01:12:07.2692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Opqlh8mv7OJVUUt2LDIMHR+5IfY0bLdidlRagvU0BquO7pwJ7QHtE0NASeyDfgrAh4PITcAmeaXxKUPQkzNgCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3502
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

Expose data about the configuration and operation of the
PTDMA through debugfs entries: device name, capabilities,
configuration, statistics.

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 drivers/dma/ptdma/Makefile        |   3 +-
 drivers/dma/ptdma/ptdma-debugfs.c | 130 ++++++++++++++++++++++++++++++++++++++
 drivers/dma/ptdma/ptdma-dev.c     |   8 +++
 drivers/dma/ptdma/ptdma.h         |   9 +++
 4 files changed, 149 insertions(+), 1 deletion(-)
 create mode 100644 drivers/dma/ptdma/ptdma-debugfs.c

diff --git a/drivers/dma/ptdma/Makefile b/drivers/dma/ptdma/Makefile
index 6fcb4ad..60e7c10 100644
--- a/drivers/dma/ptdma/Makefile
+++ b/drivers/dma/ptdma/Makefile
@@ -6,6 +6,7 @@
 obj-$(CONFIG_AMD_PTDMA) += ptdma.o
 
 ptdma-objs := ptdma-dev.o \
-	      ptdma-dmaengine.o
+	      ptdma-dmaengine.o \
+	      ptdma-debugfs.o
 
 ptdma-$(CONFIG_PCI) += ptdma-pci.o
diff --git a/drivers/dma/ptdma/ptdma-debugfs.c b/drivers/dma/ptdma/ptdma-debugfs.c
new file mode 100644
index 0000000..506c148b
--- /dev/null
+++ b/drivers/dma/ptdma/ptdma-debugfs.c
@@ -0,0 +1,130 @@
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
+static struct dentry *pt_debugfs_dir;
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
+
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
+	mutex_lock(&pt_debugfs_lock);
+	if (!pt_debugfs_dir)
+		pt_debugfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
+	mutex_unlock(&pt_debugfs_lock);
+
+	pt->dma_dev.dbg_dev_root = debugfs_create_dir(pt->name, pt_debugfs_dir);
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
+
+void ptdma_debugfs_destroy(struct dma_device *dma_dev)
+{
+	debugfs_remove_recursive(dma_dev->dbg_dev_root);
+	dma_dev->dbg_dev_root = NULL;
+}
diff --git a/drivers/dma/ptdma/ptdma-dev.c b/drivers/dma/ptdma/ptdma-dev.c
index ef10be5..8b13208 100644
--- a/drivers/dma/ptdma/ptdma-dev.c
+++ b/drivers/dma/ptdma/ptdma-dev.c
@@ -14,6 +14,7 @@
 #include <linux/pci.h>
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
+#include <linux/debugfs.h>
 
 #include "ptdma.h"
 
@@ -107,6 +108,7 @@ int pt_core_perform_passthru(struct pt_cmd_queue *cmd_q,
 
 	cmd_q->cmd_error = 0;
 
+	cmd_q->total_pt_ops++;
 	memset(&desc, 0, Q_DESC_SIZE);
 
 	desc.dw0.val = CMD_DESC_DW0_VAL;
@@ -159,6 +161,7 @@ static irqreturn_t pt_core_irq_handler(int irq, void *data)
 	u32 status;
 
 	pt_core_disable_queue_interrupts(pt);
+	pt->total_interrupts++;
 
 	status = ioread32(cmd_q->reg_interrupt_status);
 	if (status) {
@@ -290,6 +293,9 @@ int pt_core_init(struct pt_device *pt)
 	if (ret)
 		goto e_dmaengine;
 
+	/* Set up debugfs entries */
+	ptdma_debugfs_setup(pt);
+
 	return 0;
 
 e_dmaengine:
@@ -310,6 +316,8 @@ void pt_core_destroy(struct pt_device *pt)
 	struct pt_cmd_queue *cmd_q = &pt->cmd_q;
 	struct pt_cmd *cmd;
 
+	ptdma_debugfs_destroy(&pt->dma_dev);
+
 	/* Unregister the DMA engine */
 	pt_dmaengine_unregister(pt);
 
diff --git a/drivers/dma/ptdma/ptdma.h b/drivers/dma/ptdma/ptdma.h
index 661be6b..db39a4a 100644
--- a/drivers/dma/ptdma/ptdma.h
+++ b/drivers/dma/ptdma/ptdma.h
@@ -239,6 +239,9 @@ struct pt_cmd_queue {
 	u32 q_status;
 	u32 q_int_status;
 	u32 cmd_error;
+
+	/* queue Statistics */
+	unsigned long total_pt_ops;
 } ____cacheline_aligned;
 
 struct pt_device {
@@ -277,6 +280,9 @@ struct pt_device {
 
 	wait_queue_head_t lsb_queue;
 
+	/* Device Statistics */
+	unsigned long total_interrupts;
+
 	struct pt_tasklet_data tdata;
 };
 
@@ -343,6 +349,9 @@ struct pt_dev_vdata {
 int pt_dmaengine_register(struct pt_device *pt);
 void pt_dmaengine_unregister(struct pt_device *pt);
 
+void ptdma_debugfs_setup(struct pt_device *pt);
+void ptdma_debugfs_destroy(struct dma_device *dma_dev);
+
 int pt_core_init(struct pt_device *pt);
 void pt_core_destroy(struct pt_device *pt);
 
-- 
2.7.4

