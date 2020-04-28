Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39991BCE5C
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2020 23:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgD1VOh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Apr 2020 17:14:37 -0400
Received: from mail-mw2nam10on2045.outbound.protection.outlook.com ([40.107.94.45]:13787
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726884AbgD1VOg (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 28 Apr 2020 17:14:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndufF4DS3yyKNcAe03xixD5dJHkw0CxrquEWMCjoxkvEk1XWAzg73hXgVNjv2DTI0N2qIlf4sbzvKimrcn6rcehB7pSZ/E5VR82E6KqqeyW/OwJz3eYVhTdS4wOWdohOIiw1n2MWn0iChqwjEY9/ZtmxyT2qPVFmoQ50stN0ZlXpYgURRKW2ySDS0DheuwFr0bx9GBbSw6ScHE+9MNBkQ+yhK8zqgevu++f/hxiFP63Vb4/dTG+FA+/2/l9M+fyeERjKktfb9DmnShhAN/BnyHti+OgEl204Dv91d90s37YESzFBW7I53SxC94QT2MRmKxfF1s3WL4wcyIsUx4iqUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vv2U9/w9xHP4SG7qJUfuTw8ZaJ5NaaNkXlwA1GPE5k=;
 b=etQSW34Ws7jihkEPOt6RHyBsc/sonoWSQsfMWIxmmXeuCh2um7e2/Dh6aJSpzJ0cHWEfcTznvuZed3IP3yWsZ4qflX1kAz18/WzSEMf4GcStF532EMGXohZEEjghuBmYMZCXTHh6g5OhpnuLfjuGfUuLW/aIpDqeohey5a0Phs+8v50p+RQAfxAaie6tQDDlS9JV6S+5cPBaORUb/fR64fuQfzeZzPVjH2y04lnBd1Zgw+Xum+MhSdC9dEMrPH11B3VTMLoGXDbFcP1icX8PTqeqeqjuKRhJFS/zQlmGfav8EaevI05PaMrUpih0S4nuN03iPksO+UtEj89CYz229w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vv2U9/w9xHP4SG7qJUfuTw8ZaJ5NaaNkXlwA1GPE5k=;
 b=iYzLIYIyzRG9rkUzvWxNbBZu0ZE8bXYVAAIf497Y340MNplSVgniNH34kjlKf0hJCjXx9N5k9GAt/goULLipgqR4hUTorr2CTym+bIHJA2giIHB0h0mDDTuyNb8T2jGgCcJfDcQaRR71TyiUkvmiS/m+dQpeIqJ2n8+0L2zvSUE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3420.namprd12.prod.outlook.com (2603:10b6:5:3a::27) by
 DM6PR12MB4532.namprd12.prod.outlook.com (2603:10b6:5:2af::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.22; Tue, 28 Apr 2020 21:14:32 +0000
Received: from DM6PR12MB3420.namprd12.prod.outlook.com
 ([fe80::7545:386:8328:18a0]) by DM6PR12MB3420.namprd12.prod.outlook.com
 ([fe80::7545:386:8328:18a0%6]) with mapi id 15.20.2958.019; Tue, 28 Apr 2020
 21:14:32 +0000
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     vkoul@kernel.org
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v4 3/3] dmaengine: ptdma: Add debugfs entries for PTDMA information
Date:   Tue, 28 Apr 2020 16:13:36 -0500
Message-Id: <1588108416-49050-4-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588108416-49050-1-git-send-email-Sanju.Mehta@amd.com>
References: <1588108416-49050-1-git-send-email-Sanju.Mehta@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR0101CA0034.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::20) To DM6PR12MB3420.namprd12.prod.outlook.com
 (2603:10b6:5:3a::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sanjuamdntb2.amd.com (165.204.156.251) by MA1PR0101CA0034.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2958.19 via Frontend Transport; Tue, 28 Apr 2020 21:14:29 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d108fd60-b7eb-4de7-a272-08d7ebb92566
X-MS-TrafficTypeDiagnostic: DM6PR12MB4532:|DM6PR12MB4532:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4532FF4301FC1B51DA8CE2AEE5AC0@DM6PR12MB4532.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3420.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(186003)(4326008)(16526019)(6916009)(36756003)(26005)(52116002)(7696005)(2906002)(8936002)(6666004)(5660300002)(66946007)(956004)(66476007)(2616005)(6486002)(66556008)(478600001)(86362001)(316002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tC9EEEtnLVCR2v1zOIhdSuKAGndBb9zCRC+ZUEAG/BhwAwTZ/jG9dmC9w4F7oxNkQOTHjuJTb0otTDTP+Gvx3ggwJt0s6UXAGpg6Y9SZEcxW3D/uuXFb80GfCX58LRR11nPrxWEJGiixTCwXMp4VonSvk/DI9rWYPa9p4PGAPOdUadDpwe7JOC6mr9tHMxUl48kqLuBTpfYGPs/Yst8bUxHJHUTeQHNt9VhtfSDzbbTSoAtSjlbpSPhrACzBrPTQELmcO7pB8Whm5eRlgVF8ze1V+EenvOA3vb5efJfujFpJqSRLLLsqrM2qbO7nIvUr6f4Ktcueqb9UG9w9/BRP5ka25MUgHr0K4mQj3tMHV+Bcdf+72ZoEf1ig9n2NdqQXp+pZL/5EUN8lUUPwDY4ZeThFPrPCclDSSvWQEtREc8QWJEsdfRygqKMGxekhncyu
X-MS-Exchange-AntiSpam-MessageData: Fy1wv8ubftdfm1sHBLTd/dsm+f7TXvIJlI9SnZJTHDoquPBys7vN+d8v56bCFD1OX9rkC47mlkoiRbd85AolKoV50flLEEwubp2M/8ApYNpV4ikmWlQKwh+c/mSnJpjrU5wme3Cp6RE+w6PYE48fbCUmXyLqKvbQCv69OjVTBTz1Zxmg6OP4FD+JlL/muev5Es9sz+EMf/3FnNaMbxqmtH+LN6oaBXsn88zBYT3r9FDR96y5NnnV2DKgxOUwUbBWccLTpeF39SidknG8lYArGEWgfdozs+t1GLtrJT2NxNjtsjUmlsxyMkxz2fCx1M0TVkuWO1ABFPaahZCu657asBZ4OYskwtFfPDdmS5N+agyAjXnA36OF9jqJvpXF55tpyGZiP2xciPTUvTZ9ELvcJ8UyZYraZKNB3CkvgqDOLgQpE1NCUvVYAN1qRpIzxWelKUNyZD2QgXV/sxeHLl/m+0bJRJawL1k4QJkcolrNkkSzXKdaERcTf9pgXDeJv04RWA49yNskRZcrSB4/oW5I2pOiClOteVtD1tCFHyVJTKwaNKDoZ7Ou1kshsXrjlzyhlZBfelMBJPk5tn7vWkFzqr7H+ESiszFmkAI4/jw77hctyc5/yM16vy0xpkVn2lL2vkakawpmCVr+C2iJ7/w/tr2KarpRBCi2osLJGXDxEjrfoDkPpCZUj4pquPTBwbddRSItqBeG/Ks851oc2WiVPli7cqv0O3X8z4yQ4tAPbtqmcaaKN1GBI8wzdxpJuIAqr/0GHMx0/ASApDOM1edDj4sH47fWHMMWPQpZVRcbIpFlV03Lkg+8q2RR5uOdQzQA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d108fd60-b7eb-4de7-a272-08d7ebb92566
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 21:14:32.9102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zaBu8igkcp3+HNISzlZ/mgvW+hr0frfTKUF91q1r3QyPuoIDdkdpJxkV4xaBiZWQqPaY0NIDujySGbRXngvwLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4532
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
 drivers/dma/ptdma/ptdma.h         |  13 +++
 4 files changed, 278 insertions(+), 1 deletion(-)
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
index 0000000..837c43c
--- /dev/null
+++ b/drivers/dma/ptdma/ptdma-debugfs.c
@@ -0,0 +1,237 @@
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
index 14b4339..f00fb58 100644
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
 void pt_start_queue(struct pt_cmd_queue *cmd_q)
 {
 	/* Turn on the run bit */
@@ -185,6 +203,7 @@ int pt_core_perform_passthru(struct pt_cmd_queue *cmd_q,
 
 	cmd_q->cmd_error = 0;
 
+	cmd_q->total_pt_ops++;
 	memset(&desc, 0, Q_DESC_SIZE);
 
 	desc.dw0.val = CMD_DESC_DW0_VAL;
@@ -217,6 +236,7 @@ static irqreturn_t pt_core_irq_handler(int irq, void *data)
 	u32 status;
 
 	pt_core_disable_queue_interrupts(pt);
+	pt->total_interrupts++;
 
 	status = ioread32(cmd_q->reg_interrupt_status);
 	if (status) {
@@ -382,6 +402,9 @@ int pt_core_init(struct pt_device *pt)
 
 	tasklet_init(&pt->tasklet, pt_do_cmd_complete, (ulong)&pt->tdata);
 
+	/* Set up debugfs entries */
+	ptdma_debugfs_setup(pt);
+
 	return 0;
 
 e_dmaengine:
@@ -408,6 +431,9 @@ void pt_core_destroy(struct pt_device *pt)
 	/* Remove this device from the list of available units first */
 	pt_del_device(pt);
 
+	if (pt_present())
+		ptdma_debugfs_destroy();
+
 	/* Disable and clear interrupts */
 	pt_core_disable_queue_interrupts(pt);
 
diff --git a/drivers/dma/ptdma/ptdma.h b/drivers/dma/ptdma/ptdma.h
index a807f4c..ee99b8c 100644
--- a/drivers/dma/ptdma/ptdma.h
+++ b/drivers/dma/ptdma/ptdma.h
@@ -47,6 +47,7 @@
 #define	CMD_QUEUE_PRIO_OFFSET		0x00
 #define	CMD_REQID_CONFIG_OFFSET		0x04
 #define	CMD_TIMEOUT_OFFSET		0x08
+#define	CMD_PT_VERSION			0x10
 
 #define CMD_Q_CONTROL_BASE		0x0000
 #define CMD_Q_TAIL_LO_BASE		0x0004
@@ -245,6 +246,9 @@ struct pt_cmd_queue {
 	u32 q_status;
 	u32 q_int_status;
 	u32 cmd_error;
+
+	/* queue Statistics */
+	unsigned long total_pt_ops;
 } ____cacheline_aligned;
 
 struct pt_device {
@@ -283,6 +287,12 @@ struct pt_device {
 
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
@@ -350,6 +360,9 @@ struct pt_dev_vdata {
 int pt_dmaengine_register(struct pt_device *pt);
 void pt_dmaengine_unregister(struct pt_device *pt);
 
+void ptdma_debugfs_setup(struct pt_device *pt);
+void ptdma_debugfs_destroy(void);
+
 int pt_core_init(struct pt_device *pt);
 void pt_core_destroy(struct pt_device *pt);
 
-- 
2.7.4

