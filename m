Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7B728B3A7
	for <lists+dmaengine@lfdr.de>; Mon, 12 Oct 2020 13:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388079AbgJLLUa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Oct 2020 07:20:30 -0400
Received: from mail-dm6nam08on2063.outbound.protection.outlook.com ([40.107.102.63]:13056
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388003AbgJLLUa (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 12 Oct 2020 07:20:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U08YJd0vQ6sLGeF59sqc7jJZfGIWSzDlar9V5hQ/YXIscMKzV8JF79RIysN+3e3s/BaRmFtWiTj72x51EsuuPIOESoHZScEfPDkOJF9TtTCRLv3JPSxFDt9iiR4zgNwUHuKzUh2WJrnaARVx711gmUmTEVv60pZTKexGlP/cI+n6DOzFtBcoL8QPEcbNpkdXB5AMviaijX1yRwRsLOCopvQxIlXB0wmyxQN+stMchF/arGYB2OaIPB0+zrsFu/MJ93AeRc2WVmIbq2VmUzsqEl+OR8RIGsp8JLDFUhePlCX5g4J/sxoISoFvnPejznwv+PjjHxkRq1yf65o3Zm5npQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h93f/5IcVFknBzP0aviAtUP0iX4JRJ5aXtDEtdmuhXE=;
 b=EW0Uq93F1c3RcUzpSzB3VKwvCiZgG7o41PoqGAsWAvPxYUMBaKXq1NaDOL/SD5R9kGGGHJEFofpGdFid/ZY09pAr0K5Fc5SrTIRrmWYbPDMYrTaOItcBgsorMPOuTwJiocr71FTS0U4ht0JlCrVLnMv/yxhRgG/Sx4bKtR5QQsVlE+iBZQ7zfF8pwqR4jnhlzAlvsu5f5Wv8+1dmTaz/+bswQpdrDFMJ2RkVQNqdj02WI1wUwid0NCiohVngl1Nqltf3+IaQ4Jw4VA/aIkHSDt0NUyCjrzE2NY/FEUTy/sLOH9eE82ncl7eYtuwgKTYPqahmqs1PL76EOhbkAM3PYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h93f/5IcVFknBzP0aviAtUP0iX4JRJ5aXtDEtdmuhXE=;
 b=drJUvyz475WUsSeUrhMQVUzFPWjan/BYfiKZmOXiAKz25CZofs5yrT6/n1LXhhbiAE258lvy7D0olryCrqn8aODl1XghV2fQvQY9sq5XoiTjOXiIMlsiwAN6nOBsSRBOUZ2zSeH7M9rq+nAn9JNWdRGYhWWQmzFOzjwhDplZka4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3540.namprd12.prod.outlook.com (2603:10b6:408:6c::33)
 by BN8PR12MB2979.namprd12.prod.outlook.com (2603:10b6:408:66::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Mon, 12 Oct
 2020 11:20:27 +0000
Received: from BN8PR12MB3540.namprd12.prod.outlook.com
 ([fe80::9d06:595:4be5:3af7]) by BN8PR12MB3540.namprd12.prod.outlook.com
 ([fe80::9d06:595:4be5:3af7%7]) with mapi id 15.20.3455.029; Mon, 12 Oct 2020
 11:20:27 +0000
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     vkoul@kernel.org
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v6 3/3] dmaengine: ptdma: Add debugfs entries for PTDMA information
Date:   Mon, 12 Oct 2020 06:19:19 -0500
Message-Id: <1602501559-67927-4-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602501559-67927-1-git-send-email-Sanju.Mehta@amd.com>
References: <1602501559-67927-1-git-send-email-Sanju.Mehta@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MAXPR01CA0115.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::33) To BN8PR12MB3540.namprd12.prod.outlook.com
 (2603:10b6:408:6c::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sanjuamdntb2.amd.com (165.204.156.251) by MAXPR01CA0115.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3455.21 via Frontend Transport; Mon, 12 Oct 2020 11:20:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 92729a54-8ab4-4413-b676-08d86ea0d1c2
X-MS-TrafficTypeDiagnostic: BN8PR12MB2979:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB2979BB25FD5EFA13186F13CEE5070@BN8PR12MB2979.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:22;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EMRyEVGLpJI3UC2kxSMeX712e8MIX3dijxOb08YiKe0amHI/DY0riJTl1Q6e8xxmW/tFPs2I29r3K73lk601SjTyvSN35GPxO0Z9mO4ARBm0EYujyFSDzaFkqeUd6fQsx2Kle3hZfEaCP4o4CfWIILuahfgoT2IdeSqplCDb9F29+2nIf35zDK5DGrKPOT/EOOrWSL52LsMjgrfgV/XpK3Wo9bOsN4JeEoV7CAB29Fd9W3l/sZbydsA0RNNg1Hl9DL1Km12xf+l7j6mG7N3HN0kwEL3WcbQ5jHX4bX8Vlj1DM68oTr7/MeKagQYZ/ME6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3540.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(16526019)(52116002)(186003)(7696005)(26005)(2616005)(316002)(956004)(478600001)(36756003)(4326008)(6486002)(2906002)(5660300002)(86362001)(6916009)(66476007)(66946007)(66556008)(8936002)(83380400001)(6666004)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: gcjhzh5auZT7PmhpWD59unXTJHtmx+rrf+P9LoOHDLfytP0J2cmrI0sjZjD8qnaKyYHW4MdOhy8it/3/9OGZbgdDOsHxVVTaGQen4P1Py+0V2SU7zFX5pU67dXWmdO9zArh7uVFPX1MXDZQGEBmZWs9o1wXLfMlBq5EQW30WnyeaCLhczMI9wRHFUOMwYIITNRaM+ZnvcuC7Yw9NzdtxU+SpL0TmKy9wtEmsed3YVxmDWFAY2INQmOTWQCaF32kjXgt0zS3BtVidn4hETv5K5A4I0WbjpJBkkyioLZK4nd7HeYafezhClfhJT2H6PddTc8/rY2qXcTQ8S9zAHAxpHzrfoaPCI470Bhql271z207aG+eqhu/+Tje42WETyptwizjLj3zEoM6RcfDMDotprJQCGKoyhuOfka2dE8ZyblOjVohQeLw1DvDVfoIuOwGWCK+RZzyk6/cs9tDNJYBRkkx/yc6usqaO8IfJpE+GSD96PWDYlMF1cjwrBjZtOMXiDvDN4Vqs/2w0uBRXmVXylSSzQqX0x/IHxA346Hf1UkRiw5WXkwzE0Wjiij8jjIplLuQ2XncBGWdNBVA3ZOedbfg/BhSkZclonUdFzePDf0sfTBYUKSDQwVhCSwpS9sOMFvlbv4t9Xe1IkHlItZjqBg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92729a54-8ab4-4413-b676-08d86ea0d1c2
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3540.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 11:20:26.9814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hlXlrMqjyNJGnfcHX77N7PQf1gk1t2iZ2+0tL8FSbSoNQ7XuX3gyysCsYjaavGm/6oZpxoZtAwzFXkH1XYgqjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2979
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

