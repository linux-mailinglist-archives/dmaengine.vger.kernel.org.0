Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 524A012B54F
	for <lists+dmaengine@lfdr.de>; Fri, 27 Dec 2019 15:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfL0Os7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 27 Dec 2019 09:48:59 -0500
Received: from mail-dm6nam12on2061.outbound.protection.outlook.com ([40.107.243.61]:37857
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726379AbfL0Os7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 27 Dec 2019 09:48:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TH1T770FwKkhSEdQahRhXXDcPt/cFRQm4tILajRX+Rhifh+yMvXuDjK0iMwTnIOWH2GhjRQNLAYYaI7wCgOb0N/GZPIXsp498gF8k5Pu7SDEhuJFMqKmITHjhJSb3I5iYIb/75gOLDTxTl6piXyQI0HUvNjrfHqU8wd8z0slvsapwme1i/80OOTHuvOFVPBGEyHotessElGF8wdHwI8enKbzbgy04/oRnWAdUM8L3kUBw7TzE4F7AzFBQcNN1CHof35NwxbcO7bSAvxRIY+qMvs0DjRa3b57cqM1wwyAr0yJuvwKDbtiVbK3gYV5+WqW/bA6eAda6ubwOawqBIwoDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBKNzRBG/bHUbCS+7M9ep4kk41HUKA/HzvOlJ5Ld+zg=;
 b=UE3AYYIBe1ETKTSs+aTJA25eHa7mHaK98YAQhUC+eUBQUv40GVvNjQyLT54wmGxe8osdozMX6J9lRRs5/Z98grIIJRDEnvrChcOyQBLv+R6JxMdUrsudVysLU/V5ZWruKf/hCU6dEIFVBu2UxTCxb0Ry6Mh9LPpQQxMs/RiArwniqRxHmMa3v4VR1XgOrnYRIs4+RlrqvYhlYvtZVgDNnHIJlsuWJ/FAdNkNhu5nPcPstr2Ne8iOUJVvFPneBZb5g/xnSAscII1jApHRNVZRLHz9EHjjzK/1hvnUNHn9I8EOLNx7fa9SOpxSGydYP6688tMG4aPeRfoVsRn8X5LIvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBKNzRBG/bHUbCS+7M9ep4kk41HUKA/HzvOlJ5Ld+zg=;
 b=qRQu9/jpe1AYIP9qzdoHoTK4sye8NmsH9D9yIp/NEqJoUlhfq8wn+7jiNbqwHMK/4fWCKpQpxeeOeTbSwcd0YrIhhteB5pY5lk5GbGD4qRKoApkI9Y1rrzFE/xj584UJS9TThdmRdJbaJ3jHFeWcM5qn7JwjtkriJnkT9h2Tcug=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sanju.Mehta@amd.com; 
Received: from MN2PR12MB3455.namprd12.prod.outlook.com (20.178.244.22) by
 MN2PR12MB3485.namprd12.prod.outlook.com (20.178.242.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11; Fri, 27 Dec 2019 14:48:51 +0000
Received: from MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::1900:6cb7:12ff:11c]) by MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::1900:6cb7:12ff:11c%4]) with mapi id 15.20.2581.007; Fri, 27 Dec 2019
 14:48:51 +0000
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        gregkh@linuxfoundation.org, Gary.Hook@amd.com,
        Nehal-bakulchandra.Shah@amd.com, Shyam-sundar.S-k@amd.com
Cc:     davem@davemloft.net, mchehab+samsung@kernel.org, robh@kernel.org,
        Jonathan.Cameron@huawei.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v2 3/3] dmaengine: ptdma: Add debugfs entries for PTDMA information
Date:   Fri, 27 Dec 2019 08:48:32 -0600
Message-Id: <1577458112-109734-1-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0120.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::14) To MN2PR12MB3455.namprd12.prod.outlook.com
 (2603:10b6:208:d0::22)
MIME-Version: 1.0
Received: from sanjuamdntb2.amd.com (165.204.156.251) by MA1PR01CA0120.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:35::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2581.11 via Frontend Transport; Fri, 27 Dec 2019 14:48:47 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dc64b79d-c7ce-4212-5fe2-08d78adbe341
X-MS-TrafficTypeDiagnostic: MN2PR12MB3485:|MN2PR12MB3485:|MN2PR12MB3485:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB34857B855AE376B5EA5A6576E52A0@MN2PR12MB3485.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 0264FEA5C3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(189003)(199004)(81156014)(478600001)(2616005)(16526019)(186003)(6486002)(8936002)(956004)(86362001)(36756003)(8676002)(81166006)(66556008)(66946007)(66476007)(6636002)(4326008)(5660300002)(52116002)(2906002)(6666004)(316002)(26005)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3485;H:MN2PR12MB3455.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gEuEDtQBLLFGt22wZiKO9tnyHY9C06sUwYooru7+WMS4IZ+XkJod/NzYVR1ogBt/l3JVHV/9Ege5/kAcfDSdmQhoT2CY9miwx+ounIMnFPa/8NaaNt6jGObBXrmvlFctnAxrspF46JOOkF+zgiIf9VejQUocqyjBH67JF6LYxgjMz9zKxK2pgTichGUgLty6u7mJjw+o6+Ip9BoDOZGbgtv4dIeUjGvhOykZwsRrjXHe8POuGsgXngqulKiia5eRhcc0Pp5kqEW+xgppHGAzAaErZ9OKt2109SgM/HgV/HqhjQ/KaPf5MJn7vc6WXj+R0idHopqVZQvNJ5DRLAQPeGipVxkHFPV7ZYWGNkdEKMeQo+l0bJBE3B8IejYtufvuKsykZWdz87rfsc0f21sY4BJtSGuqFzFyAuQ9Lk/OIskX7xZx1RCJkwtbahIdWt0P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc64b79d-c7ce-4212-5fe2-08d78adbe341
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2019 14:48:51.5295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eBXOWlX6NJeQZ9n7Pipe7cRhloYVvX5lL8V1e4o7nFQHSBSmLNQyGOQ2qZXoy1m1w7Rook5n/gY8W9vS3YLrvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3485
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
index 893ba32..1cb47bb 100644
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
+int pt_present(void)
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
index 20e1de8..0d373d2 100644
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

