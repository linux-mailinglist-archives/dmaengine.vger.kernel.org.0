Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5195E143908
	for <lists+dmaengine@lfdr.de>; Tue, 21 Jan 2020 10:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbgAUJGB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Jan 2020 04:06:01 -0500
Received: from mail-bn8nam11on2050.outbound.protection.outlook.com ([40.107.236.50]:16989
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729162AbgAUJGA (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 Jan 2020 04:06:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHJw3RXbg6cGh8lFGMLI2szis91k76OgNcG+U5e78Pf4etVLudg+bXlBPrmnoaSb63OqinGa8CN9LM9Fe1N/oD5VQfKe6bzlal6ipugWyNNUmrAGW+pvTorb8h37IeW6RKICWN7o7U7UnUkqUGt4uT/+xByQ4zVVJ8IlfA51OH0au5V5bqzuMuEGuQPa1Cz8RJ5MPBcsMsRoIL95axy4yNTItCG1HGVgFi9AKxy8TuKvSc4oPqP14HiE4PeM6ubESYXaOc+tg3ijiCLUlW8HqDzpLQQpW1lTmnfqyphSvPZLxuXahFRKKia5MVL9A+SVooh3mbXq6ged/cuPMJzRlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7iH4gzkPjKML9AgRslwHtXV++rxgHNJsw0Fk9Wgmio=;
 b=Mq0+uu9tSsrPmiazXkclT/XdBtJadj1w+YD7MI9xVKbiDykXWhiiZ/KUgrsQGCQkZr1x40hRBQJBr+u1GsIY8Av0BcBGzJ+pr1597XXPgEp/poDDniYcDNX6VYsrjWqe+1TmvQqIbaIOOk+Ak850M3LLlbXGtEJmDk1UumOb4CKJ7na5HOMgGGbC8BRlcOS5yE8tRXUBJJ0lNP5lTEz3/uAo6w2bmOmTysgWIVacmGDFpBWfhEOrUxqW5QsZpf7b32jVUokj5xE7cnRMGK+iPW6adm2ofQsHq5LKrxJbXxorSSHSE3GsYgk6vxoxIfhS6oU6JWJlUOlWTJ5pNTzZ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7iH4gzkPjKML9AgRslwHtXV++rxgHNJsw0Fk9Wgmio=;
 b=ZuuxTahWHQYnyrSJMAW2Oq92VmTPaBTKEEUy8+9s3SwLgfckTRarHjlFHuxHvwyLKxd67ItXaSO7iFPI+dRke1ZG6utsd6YUJn71SnSn18D6ku/CCTk0gNVHpW9hzb+EKADBp407zFw4HXVZgloiImOJ4utno2bBZLF5dpXefDw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sanju.Mehta@amd.com; 
Received: from MN2PR12MB3455.namprd12.prod.outlook.com (20.178.244.22) by
 MN2PR12MB4048.namprd12.prod.outlook.com (52.135.49.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Tue, 21 Jan 2020 09:05:53 +0000
Received: from MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::1900:6cb7:12ff:11c]) by MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::1900:6cb7:12ff:11c%4]) with mapi id 15.20.2644.027; Tue, 21 Jan 2020
 09:05:53 +0000
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     vkoul@kernel.org, gregkh@linuxfoundation.org,
        dan.j.williams@intel.com, Thomas.Lendacky@amd.com,
        Shyam-sundar.S-k@amd.com, Nehal-bakulchandra.Shah@amd.com
Cc:     robh@kernel.org, mchehab+samsung@kernel.org, davem@davemloft.net,
        Jonathan.Cameron@huawei.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v3 3/3] dmaengine: ptdma: Add debugfs entries for PTDMA information
Date:   Tue, 21 Jan 2020 03:04:54 -0600
Message-Id: <1579597494-60348-4-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579597494-60348-1-git-send-email-Sanju.Mehta@amd.com>
References: <1579597494-60348-1-git-send-email-Sanju.Mehta@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0152.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::22) To MN2PR12MB3455.namprd12.prod.outlook.com
 (2603:10b6:208:d0::22)
MIME-Version: 1.0
Received: from sanjuamdntb2.amd.com (165.204.156.251) by MA1PR01CA0152.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.18 via Frontend Transport; Tue, 21 Jan 2020 09:05:49 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 526c6199-116c-4379-e84a-08d79e511e00
X-MS-TrafficTypeDiagnostic: MN2PR12MB4048:|MN2PR12MB4048:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4048BFC1B6F62F2575529C03E50D0@MN2PR12MB4048.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 0289B6431E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(199004)(189003)(7696005)(52116002)(6486002)(6666004)(8676002)(81166006)(2906002)(81156014)(8936002)(5660300002)(316002)(186003)(66476007)(66556008)(16526019)(2616005)(26005)(956004)(478600001)(66946007)(36756003)(86362001)(4326008)(6636002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB4048;H:MN2PR12MB3455.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l/ChpZIG9G6PtAJUOK3t9Mt4++ZL20nfWBbbgaL/otT+jaVs7AF5I+ih+HkUw7/m7N6zCiDACP+fhOiukhwD3RiFJgwrDM4nf6s+kwkOT74DVEuMQFmOfxf32h0PvPQdyKKILLqkJI233ZKXOO8UMyWbpkFloEqUa5mVZZ2LE78EWfUf16g2uvBCjypQUCrdNSgtajwGtGP4rIgFbiC810Y7XiaMgqYnQa1SiyhXSSQ13HZoprXSIessmdSApaNJ2AGSp+J4m86Fa0jjkMc9+HLEgu7ji9j2b0g+YXjmBA9a/QleAHJfP5/Q1s+Zsyz6fjd9JkhGLfdCU9fAxBI5unfJmnABGhdn3+J48/ThjHSnhsBnWsO4sZDT2AE/1qcZ46bdcmRHKtE9sQ+nHxCjz8Rk8RoOwtVT77/8Bl07KTnGbigdr2LchDFj0PHbu4qq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 526c6199-116c-4379-e84a-08d79e511e00
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2020 09:05:53.1768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n22DZ6r7yfdb+qxP3yz0vxFERmm5PsBsxFIfgQM4TlpNaOevCixJ726V+o42izoYimsMEH3W2AXY7BjijuRMAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048
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
 drivers/dma/ptdma/ptdma-debugfs.c | 237 ++++++++++++++++++++++++++++++++++++++
 drivers/dma/ptdma/ptdma-dev.c     |  26 +++++
 drivers/dma/ptdma/ptdma.h         |  12 ++
 4 files changed, 277 insertions(+), 1 deletion(-)
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
index 0000000..b4af83c
--- /dev/null
+++ b/drivers/dma/ptdma/ptdma-debugfs.c
@@ -0,0 +1,237 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AMD Passthrough DMA device driver
+ * -- Based on the CCP driver
+ *
+ * Copyright (C) 2016,2019 Advanced Micro Devices, Inc.
+ *
+ * Author: Sanjay R Mehta <sanju.mehta@amd.com>
+ * Author: Gary R Hook <gary.hook@amd.com>
+ */
+
+#include <linux/debugfs.h>
+
+#include "ptdma.h"
+
+/* DebugFS helpers */
+#define	OBUFP		(obuf + oboff)
+#define	OBUFLEN		512
+#define	OBUFSPC		(OBUFLEN - oboff)
+
+#define	MAX_NAME_LEN	20
+#define	BUFLEN		63
+#define	RI_VERSION_NUM	0x0000003F
+
+#define	RI_NUM_VQM	0x00078000
+#define	RI_NVQM_SHIFT	15
+#define	RI_NVQM(r)	(((r) * RI_NUM_VQM) >> RI_NVQM_SHIFT)
+#define	RI_LSB_ENTRIES	0x0FF80000
+#define	RI_NLSB_SHIFT	19
+#define	RI_NLSB(r)	(((r) * RI_LSB_ENTRIES) >> RI_NLSB_SHIFT)
+
+static struct dentry *pt_debugfs_dir;
+static DEFINE_MUTEX(pt_debugfs_lock);
+
+static ssize_t ptdma_debugfs_info_read(struct file *filp, char __user *ubuf,
+				       size_t count, loff_t *offp)
+{
+	struct pt_device *pt = filp->private_data;
+	unsigned int oboff = 0;
+	unsigned int regval;
+	ssize_t ret;
+	char *obuf;
+
+	if (!pt)
+		return 0;
+
+	obuf = kmalloc(OBUFLEN, GFP_KERNEL);
+	if (!obuf)
+		return -ENOMEM;
+
+	oboff += snprintf(OBUFP, OBUFSPC, "Device name: %s\n", pt->name);
+	oboff += snprintf(OBUFP, OBUFSPC, "   # Queues: %d\n", 1);
+	oboff += snprintf(OBUFP, OBUFSPC, "     # Cmds: %d\n", pt->cmd_count);
+
+	regval = ioread32(pt->io_regs + CMD_PT_VERSION);
+
+	oboff += snprintf(OBUFP, OBUFSPC, "    Version: %d\n",
+		   regval & RI_VERSION_NUM);
+	oboff += snprintf(OBUFP, OBUFSPC, "    Engines:");
+	oboff += snprintf(OBUFP, OBUFSPC, "\n");
+	oboff += snprintf(OBUFP, OBUFSPC, "     Queues: %d\n",
+		   (regval & RI_NUM_VQM) >> RI_NVQM_SHIFT);
+
+	ret = simple_read_from_buffer(ubuf, count, offp, obuf, oboff);
+	kfree(obuf);
+
+	return ret;
+}
+
+/*
+ * Return a formatted buffer containing the current
+ * statistics of queue for PTDMA
+ */
+static ssize_t ptdma_debugfs_stats_read(struct file *filp, char __user *ubuf,
+					size_t count, loff_t *offp)
+{
+	struct pt_device *pt = filp->private_data;
+	unsigned long total_pt_ops = 0;
+	unsigned int oboff = 0;
+	ssize_t ret = 0;
+	char *obuf;
+	struct pt_cmd_queue *cmd_q = &pt->cmd_q;
+
+	total_pt_ops += cmd_q->total_pt_ops;
+
+	obuf = kmalloc(OBUFLEN, GFP_KERNEL);
+	if (!obuf)
+		return -ENOMEM;
+
+	oboff += snprintf(OBUFP, OBUFSPC, "Total Interrupts Handled: %ld\n",
+			    pt->total_interrupts);
+
+	ret = simple_read_from_buffer(ubuf, count, offp, obuf, oboff);
+	kfree(obuf);
+
+	return ret;
+}
+
+/*
+ * Reset the counters in a queue
+ */
+static void ptdma_debugfs_reset_queue_stats(struct pt_cmd_queue *cmd_q)
+{
+	cmd_q->total_pt_ops = 0L;
+}
+
+/*
+ * A value was written to the stats variable, which
+ * should be used to reset the queue counters across
+ * that device.
+ */
+static ssize_t ptdma_debugfs_stats_write(struct file *filp,
+					 const char __user *ubuf,
+					 size_t count, loff_t *offp)
+{
+	struct pt_device *pt = filp->private_data;
+
+	ptdma_debugfs_reset_queue_stats(&pt->cmd_q);
+	pt->total_interrupts = 0L;
+
+	return count;
+}
+
+/*
+ * Return a formatted buffer containing the current information
+ * for that queue
+ */
+static ssize_t ptdma_debugfs_queue_read(struct file *filp, char __user *ubuf,
+					size_t count, loff_t *offp)
+{
+	struct pt_cmd_queue *cmd_q = filp->private_data;
+	unsigned int oboff = 0;
+	unsigned int regval;
+	ssize_t ret;
+	char *obuf;
+
+	if (!cmd_q)
+		return 0;
+
+	obuf = kmalloc(OBUFLEN, GFP_KERNEL);
+	if (!obuf)
+		return -ENOMEM;
+
+	oboff += snprintf(OBUFP, OBUFSPC, "               Pass-Thru: %ld\n",
+			    cmd_q->total_pt_ops);
+
+	regval = ioread32(cmd_q->reg_int_enable);
+	oboff += snprintf(OBUFP, OBUFSPC, "      Enabled Interrupts:");
+	if (regval & INT_EMPTY_QUEUE)
+		oboff += snprintf(OBUFP, OBUFSPC, " EMPTY");
+	if (regval & INT_QUEUE_STOPPED)
+		oboff += snprintf(OBUFP, OBUFSPC, " STOPPED");
+	if (regval & INT_ERROR)
+		oboff += snprintf(OBUFP, OBUFSPC, " ERROR");
+	if (regval & INT_COMPLETION)
+		oboff += snprintf(OBUFP, OBUFSPC, " COMPLETION");
+	oboff += snprintf(OBUFP, OBUFSPC, "\n");
+
+	ret = simple_read_from_buffer(ubuf, count, offp, obuf, oboff);
+	kfree(obuf);
+
+	return ret;
+}
+
+/*
+ * A value was written to the stats variable for a
+ * queue. Reset the queue counters to this value.
+ */
+static ssize_t ptdma_debugfs_queue_write(struct file *filp,
+					 const char __user *ubuf,
+					 size_t count, loff_t *offp)
+{
+	struct pt_cmd_queue *cmd_q = filp->private_data;
+
+	ptdma_debugfs_reset_queue_stats(cmd_q);
+
+	return count;
+}
+
+static const struct file_operations pt_debugfs_info_ops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = ptdma_debugfs_info_read,
+	.write = NULL,
+};
+
+static const struct file_operations pt_debugfs_queue_ops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = ptdma_debugfs_queue_read,
+	.write = ptdma_debugfs_queue_write,
+};
+
+static const struct file_operations pt_debugfs_stats_ops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = ptdma_debugfs_stats_read,
+	.write = ptdma_debugfs_stats_write,
+};
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
+	pt->debugfs_instance = debugfs_create_dir(pt->name, pt_debugfs_dir);
+
+	debugfs_create_file("info", 0400, pt->debugfs_instance, pt,
+			    &pt_debugfs_info_ops);
+
+	debugfs_create_file("stats", 0600, pt->debugfs_instance, pt,
+			    &pt_debugfs_stats_ops);
+
+	cmd_q = &pt->cmd_q;
+
+	snprintf(name, MAX_NAME_LEN - 1, "q");
+
+	debugfs_q_instance =
+		debugfs_create_dir(name, pt->debugfs_instance);
+
+	debugfs_create_file("stats", 0600, debugfs_q_instance, cmd_q,
+			    &pt_debugfs_queue_ops);
+}
+
+void ptdma_debugfs_destroy(void)
+{
+	debugfs_remove_recursive(pt_debugfs_dir);
+}
diff --git a/drivers/dma/ptdma/ptdma-dev.c b/drivers/dma/ptdma/ptdma-dev.c
index 0162ecd..9815185 100644
--- a/drivers/dma/ptdma/ptdma-dev.c
+++ b/drivers/dma/ptdma/ptdma-dev.c
@@ -14,6 +14,7 @@
 #include <linux/pci.h>
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
+#include <linux/debugfs.h>
 
 #include "ptdma.h"
 
@@ -130,6 +131,23 @@ static void pt_del_device(struct pt_device *pt)
 	write_unlock_irqrestore(&pt_unit_lock, flags);
 }
 
+/*
+ * pt_present - check if a PTDMA device is present
+ *
+ * Returns zero if a PTDMA device is present, -ENODEV otherwise.
+ */
+static int pt_present(void)
+{
+	unsigned long flags;
+	int ret;
+
+	read_lock_irqsave(&pt_unit_lock, flags);
+	ret = list_empty(&pt_units);
+	read_unlock_irqrestore(&pt_unit_lock, flags);
+
+	return ret ? -ENODEV : 0;
+}
+
 static int pt_core_execute_cmd(struct ptdma_desc *desc,
 			       struct pt_cmd_queue *cmd_q)
 {
@@ -173,6 +191,7 @@ int pt_core_perform_passthru(struct pt_cmd_queue *cmd_q,
 
 	cmd_q->cmd_error = 0;
 
+	cmd_q->total_pt_ops++;
 	memset(&desc, 0, Q_DESC_SIZE);
 
 	desc.dw0.val = CMD_DESC_DW0_VAL;
@@ -205,6 +224,7 @@ static irqreturn_t pt_core_irq_handler(int irq, void *data)
 	u32 status;
 
 	pt_core_disable_queue_interrupts(pt);
+	pt->total_interrupts++;
 
 	status = ioread32(cmd_q->reg_interrupt_status);
 	if (status) {
@@ -370,6 +390,9 @@ int pt_core_init(struct pt_device *pt)
 
 	tasklet_init(&pt->tasklet, pt_do_cmd_complete, (ulong)&pt->tdata);
 
+	/* Set up debugfs entries */
+	ptdma_debugfs_setup(pt);
+
 	return 0;
 
 e_dmaengine:
@@ -396,6 +419,9 @@ void pt_core_destroy(struct pt_device *pt)
 	/* Remove this device from the list of available units first */
 	pt_del_device(pt);
 
+	if (pt_present())
+		ptdma_debugfs_destroy();
+
 	/* Disable and clear interrupts */
 	pt_core_disable_queue_interrupts(pt);
 
diff --git a/drivers/dma/ptdma/ptdma.h b/drivers/dma/ptdma/ptdma.h
index 943660b..cbeed10 100644
--- a/drivers/dma/ptdma/ptdma.h
+++ b/drivers/dma/ptdma/ptdma.h
@@ -45,6 +45,7 @@
 #define	CMD_QUEUE_PRIO_OFFSET		0x00
 #define	CMD_REQID_CONFIG_OFFSET		0x04
 #define	CMD_TIMEOUT_OFFSET		0x08
+#define	CMD_PT_VERSION			0x10
 
 #define CMD_Q_CONTROL_BASE		0x0000
 #define CMD_Q_TAIL_LO_BASE		0x0004
@@ -252,6 +253,8 @@ struct pt_cmd_queue {
 	u32 q_int_status;
 	u32 cmd_error;
 
+	/* queue Statistics */
+	unsigned long total_pt_ops;
 } ____cacheline_aligned;
 
 struct pt_device {
@@ -290,6 +293,12 @@ struct pt_device {
 
 	wait_queue_head_t lsb_queue;
 
+	/* Device Statistics */
+	unsigned long total_interrupts;
+
+	/* DebugFS info */
+	struct dentry *debugfs_instance;
+
 	struct tasklet_struct tasklet;
 	struct pt_tasklet_data tdata;
 };
@@ -357,6 +366,9 @@ struct pt_dev_vdata {
 int pt_dmaengine_register(struct pt_device *pt);
 void pt_dmaengine_unregister(struct pt_device *pt);
 
+void ptdma_debugfs_setup(struct pt_device *pt);
+void ptdma_debugfs_destroy(void);
+
 int pt_core_init(struct pt_device *pt);
 void pt_core_destroy(struct pt_device *pt);
 
-- 
2.7.4

