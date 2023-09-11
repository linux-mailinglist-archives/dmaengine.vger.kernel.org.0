Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8863179AE16
	for <lists+dmaengine@lfdr.de>; Tue, 12 Sep 2023 01:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237243AbjIKWmm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Sep 2023 18:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244171AbjIKTZ6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Sep 2023 15:25:58 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D999210D;
        Mon, 11 Sep 2023 12:25:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PaiNKO9RUJL6gcY8D9IykLREkvBcr9JpXz+IM7W9P0r/UpXUOW4MXDedPXrk+ZY/5wH4FbIojVMsUDmF4Jr2JlgFoeBFapVHKp96+8jlY4WXnIpLybMsGurfJwaOLaTe25RM7GbU51HS97wk3FlCdaS3KToqw4gZKXJZCUIW5MVzGyDsxMPGyNahJiKek5Q+iwZwwBQouiMNJfJWKAL874crWXpMlzQBeUpqj7j1cEl/Nwq9NKCu81tPlDWZkSfamDuJR0Srs2M/cScROIbjt8xPqq/IvyjTfOLHAaTgqL5KhVThV5+LXNFDhIaR6OmzqXLtaaXIbjb2xlRgkuci7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHxMy4EMQaOD1iMyczU71yM3qZGPbVQKxatlf29tXP8=;
 b=YTyO5iKENLFVmOWxW0/t88lzHmrnaZQ//GCzdzAlljSaDjvFM49LHX24tZwd0IHGsEmt8fzLeiF8OKsBldh86R860FUK8k5jB+5G1qfes+vWeYnSXUt7A6E5W8RKwZka0+M+3+UNudbDyRZx4i0kSqr2dAuqIZ/P6ACxXj5TQCVDthNKaYArWM59G3w3g0RiigqYrYnQkDgjlC5YNk+GS8Wf8oGJ8cwHeZW400ZcAuxVbMpk+X1OfsvdZLkS4u7VfdjlEzb1cM6usbdNCPQpnmKYCKsoEEF/dhZpVyfd4SCmUO1TyZajwismo2ar7sgV6RJ6ucyEO7Ari75QVfVEFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHxMy4EMQaOD1iMyczU71yM3qZGPbVQKxatlf29tXP8=;
 b=ro2xVwSNGkQeeSz/342mnLPcY2subtMUZbJ+asYYMqwb8oIpsjVbt2+/2jkDK+tVWc+IYvrU84UBFUVTkJUwSi8lmmfiigkqXA6jTNOJchTxXIlkRLv8MI6W8/kDzIcZQ4BR6zUrkXHF/mZvoZbbGajCa8YRJyY+ma377YO/xs0=
Received: from CH0P223CA0023.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::22)
 by SA3PR12MB7832.namprd12.prod.outlook.com (2603:10b6:806:31f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Mon, 11 Sep
 2023 19:25:49 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::3e) by CH0P223CA0023.outlook.office365.com
 (2603:10b6:610:116::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35 via Frontend
 Transport; Mon, 11 Sep 2023 19:25:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.11 via Frontend Transport; Mon, 11 Sep 2023 19:25:49 +0000
Received: from sanjuamdntb2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 14:25:45 -0500
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     <vkoul@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <dan.j.williams@intel.com>,
        <robh@kernel.org>, <mchehab+samsung@kernel.org>,
        <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH 3/3] dmaengine: ae4dma: Add debugfs entries for AE4DMA
Date:   Mon, 11 Sep 2023 14:25:24 -0500
Message-ID: <1694460324-60346-4-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1694460324-60346-1-git-send-email-Sanju.Mehta@amd.com>
References: <1694460324-60346-1-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|SA3PR12MB7832:EE_
X-MS-Office365-Filtering-Correlation-Id: 192f2d02-496c-4599-e482-08dbb2fce7a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GJe76Gs3rj4f/17n4lO9fv6+dNmXgogBgBwic1yZpZPnrYiTSXLauWT41m1kSK1S07w1Wa5ulFhjywmmOyFDQzWsqttwWWjjcAHufFA+xsyvaPoajJ2cEH3Ljjhk6MQhKhQ4d0XUX4YlOifiySYgNmlpgqbdYwbWaxpvOX4qOKFBK2/W+YQHW5d+iCSTOtTNz0goIhWSju0mucSbECn45A9eVdDTLi4qzCdSKITW9gXJw5jY+wuu3HWNhFJrwOVjQIZ1l2BcflumswdZ8QjatiDeRofEN0mAsoLR5GO/BgaD/qotnjqTIrHpc6z99uLBxTfZWlQe+R3Iy3Vr5k6xS6ibNOvnSJ2rORhnFP8DZJV7J8qPWlbWCwYXBVuVt4CWE8VBvI03/gzjuctIMxpAdDQgFO/GWJML73B3YeiKnoFiKcJY9ClJYVP+NMF5sdmKVZ4OJ37qa4OWDNJxpDBTm+j6f5HRKqWuu5psbrtzTFetsGHnRsTbaCRcglgWpVHuk33+nn/XDWvZFnIlY8ELay217nOMUX6nmurbcOtG+z9tzR4L1PIlQ3bp7wblLf9fBNuxRHlONUo621yzoRfm4K38vBcN+mT6swoRp/kPygBdswMXYrpWEApXCQYsvH+/Fvc2PsAgskBEDmeA/+xPD2fCeceaE1y5n+/ti4NFD3bcpjqRx/FnMc10/4qhEQ6T4xOrY5R0r0/q3NbUlqP9a+c7m6MTFIck1WfTjAHyDY699Y4GG2cdAv0BEpCx7en8A9nLnedYcM9rc9vHp06wsjrZMCFdMsDQlkiGSbMgHzQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(82310400011)(186009)(1800799009)(451199024)(40470700004)(36840700001)(46966006)(40460700003)(7696005)(6666004)(83380400001)(356005)(82740400003)(81166007)(86362001)(36860700001)(47076005)(36756003)(2616005)(336012)(426003)(16526019)(40480700001)(26005)(6916009)(316002)(41300700001)(2906002)(8936002)(70586007)(54906003)(70206006)(8676002)(4326008)(478600001)(5660300002)(32563001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 19:25:49.0162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 192f2d02-496c-4599-e482-08dbb2fce7a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7832
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

Expose data about the configuration and operation of the
AE4DMA through debugfs entries: device name, capabilities,
configuration, statistics.

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 drivers/dma/ae4dma/Makefile         |  2 +-
 drivers/dma/ae4dma/ae4dma-debugfs.c | 98 +++++++++++++++++++++++++++++++++++++
 drivers/dma/ae4dma/ae4dma-dev.c     | 16 ++++++
 drivers/dma/ae4dma/ae4dma.h         |  8 +++
 4 files changed, 123 insertions(+), 1 deletion(-)
 create mode 100644 drivers/dma/ae4dma/ae4dma-debugfs.c

diff --git a/drivers/dma/ae4dma/Makefile b/drivers/dma/ae4dma/Makefile
index b1e4318..4082fec 100644
--- a/drivers/dma/ae4dma/Makefile
+++ b/drivers/dma/ae4dma/Makefile
@@ -5,6 +5,6 @@
 
 obj-$(CONFIG_AMD_AE4DMA) += ae4dma.o
 
-ae4dma-objs := ae4dma-dev.o ae4dma-dmaengine.o
+ae4dma-objs := ae4dma-dev.o ae4dma-dmaengine.o ae4dma-debugfs.o
 
 ae4dma-$(CONFIG_PCI) += ae4dma-pci.o
diff --git a/drivers/dma/ae4dma/ae4dma-debugfs.c b/drivers/dma/ae4dma/ae4dma-debugfs.c
new file mode 100644
index 0000000..ae6ec7d
--- /dev/null
+++ b/drivers/dma/ae4dma/ae4dma-debugfs.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AMD AE4DMA device driver
+ * -- Based on the PTDMA driver
+ *
+ * Copyright (C) 2023 Advanced Micro Devices, Inc.
+ *
+ * Author: Sanjay R Mehta <sanju.mehta@amd.com>
+ */
+
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+
+#include "ae4dma.h"
+
+/* DebugFS helpers */
+#define	RI_VERSION_NUM	0x0000003F
+
+#define	RI_NUM_VQM	0x00078000
+#define	RI_NVQM_SHIFT	15
+
+static int ae4_debugfs_info_show(struct seq_file *s, void *p)
+{
+	struct ae4_device *ae4 = s->private;
+	unsigned int regval;
+
+	seq_printf(s, "Device name: %s\n", dev_name(ae4->dev));
+	seq_printf(s, "   # Queues: %d\n", 1);
+	seq_printf(s, "     # Cmds: %d\n", ae4->cmd_count);
+
+	regval = ioread32(ae4->io_regs + CMD_AE4_VERSION);
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
+ * statistics of queue for AE4DMA
+ */
+static int ae4_debugfs_stats_show(struct seq_file *s, void *p)
+{
+	struct ae4_device *ae4 = s->private;
+
+	seq_printf(s, "Total Interrupts Handled: %ld\n", ae4->total_interrupts);
+
+	return 0;
+}
+
+static int ae4_debugfs_queue_show(struct seq_file *s, void *p)
+{
+	struct ae4_cmd_queue *cmd_q = s->private;
+
+	if (!cmd_q)
+		return 0;
+
+	seq_printf(s, "        Total CMDs submitted: %ld\n", cmd_q->total_ae4_ops);
+	seq_printf(s, "        Total CMDs in q%d: %ld\n", cmd_q->id, cmd_q->q_cmd_count);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(ae4_debugfs_info);
+DEFINE_SHOW_ATTRIBUTE(ae4_debugfs_queue);
+DEFINE_SHOW_ATTRIBUTE(ae4_debugfs_stats);
+
+void ae4dma_debugfs_setup(struct ae4_device *ae4)
+{
+	struct ae4_cmd_queue *cmd_q;
+	struct dentry *debugfs_q_instance;
+	unsigned int i;
+	char name[30];
+
+	if (!debugfs_initialized())
+		return;
+
+	debugfs_create_file("info", 0400, ae4->dma_dev.dbg_dev_root, ae4,
+			    &ae4_debugfs_info_fops);
+
+	debugfs_create_file("stats", 0400, ae4->dma_dev.dbg_dev_root, ae4,
+			    &ae4_debugfs_stats_fops);
+
+	for (i = 0; i < ae4->cmd_q_count; i++) {
+		cmd_q = &ae4->cmd_q[i];
+
+		snprintf(name, 29, "q%d", cmd_q->id);
+
+		debugfs_q_instance =
+			debugfs_create_dir(name, ae4->dma_dev.dbg_dev_root);
+
+		debugfs_create_file("stats", 0400, debugfs_q_instance, cmd_q,
+				    &ae4_debugfs_queue_fops);
+	}
+}
diff --git a/drivers/dma/ae4dma/ae4dma-dev.c b/drivers/dma/ae4dma/ae4dma-dev.c
index af7e510..fe5af0c0 100644
--- a/drivers/dma/ae4dma/ae4dma-dev.c
+++ b/drivers/dma/ae4dma/ae4dma-dev.c
@@ -74,6 +74,7 @@ static int ae4_core_execute_cmd(struct ae4dma_desc *desc, struct ae4_cmd_queue *
 {
 	bool soc = FIELD_GET(DWORD0_SOC, desc->dw0);
 	u8 *q_desc = (u8 *)&cmd_q->qbase[0];
+	unsigned long flags;
 	u32 tail_wi;
 
 	cmd_q->int_rcvd = 0;
@@ -99,6 +100,10 @@ static int ae4_core_execute_cmd(struct ae4dma_desc *desc, struct ae4_cmd_queue *
 	tail_wi = (tail_wi + 1) % CMD_Q_LEN;
 	iowrite32(tail_wi, cmd_q->reg_control + 0x10);
 
+	spin_lock_irqsave(&cmd_q->cmd_lock, flags);
+	cmd_q->q_cmd_count++;
+	spin_unlock_irqrestore(&cmd_q->cmd_lock, flags);
+
 	mutex_unlock(&cmd_q->q_mutex);
 
 	return 0;
@@ -110,6 +115,7 @@ int ae4_core_perform_passthru(struct ae4_cmd_queue *cmd_q, struct ae4_passthru_e
 	struct ae4_device *ae4 = cmd_q->ae4;
 
 	cmd_q->cmd_error = 0;
+	cmd_q->total_ae4_ops++;
 	memset(&desc, 0, sizeof(desc));
 	desc.dw0 = CMD_DESC_DW0_VAL;
 	desc.dw1.status = 0;
@@ -173,9 +179,12 @@ static irqreturn_t ae4_core_irq_handler(int irq, void *data)
 {
 	struct ae4_cmd_queue *cmd_q = data;
 	struct ae4_device *ae4 = cmd_q->ae4;
+	unsigned long flags;
 	u32 status = ioread32(cmd_q->reg_control + 0x4);
 	u8 q_intr_type = (status >> 24) & 0xf;
 
+	ae4->total_interrupts++;
+
 	if (q_intr_type ==  0x4)
 		dev_info(ae4->dev, "AE4DMA INTR: %s (0x%x)\n", "queue desc error", q_intr_type);
 	else if (q_intr_type ==  0x2)
@@ -187,6 +196,10 @@ static irqreturn_t ae4_core_irq_handler(int irq, void *data)
 
 	ae4_check_status_trans(ae4, cmd_q);
 
+	spin_lock_irqsave(&cmd_q->cmd_lock, flags);
+	cmd_q->q_cmd_count--;
+	spin_unlock_irqrestore(&cmd_q->cmd_lock, flags);
+
 	tasklet_schedule(&cmd_q->irq_tasklet);
 
 	return IRQ_HANDLED;
@@ -283,6 +296,9 @@ int ae4_core_init(struct ae4_device *ae4)
 	if (ret)
 		goto e_free_irq;
 
+	/* Set up debugfs entries */
+	ae4dma_debugfs_setup(ae4);
+
 	return 0;
 
 e_free_irq:
diff --git a/drivers/dma/ae4dma/ae4dma.h b/drivers/dma/ae4dma/ae4dma.h
index d341c35..ae31b26 100644
--- a/drivers/dma/ae4dma/ae4dma.h
+++ b/drivers/dma/ae4dma/ae4dma.h
@@ -231,6 +231,10 @@ struct ae4_cmd_queue {
 	wait_queue_head_t q_space;
 	unsigned int q_space_available;
 
+	/* Queue Statistics */
+	unsigned long total_ae4_ops;
+	unsigned long q_cmd_count;
+
 	struct ae4_tasklet_data tdata;
 	struct tasklet_struct irq_tasklet;
 
@@ -274,6 +278,9 @@ struct ae4_device {
 	struct kmem_cache *dma_desc_cache;
 
 	wait_queue_head_t lsb_queue;
+
+	/* Device Statistics */
+	unsigned long total_interrupts;
 };
 
 /*
@@ -326,6 +333,7 @@ struct ae4_dev_vdata {
 int ae4_dmaengine_register(struct ae4_device *ae4);
 void ae4_dmaengine_unregister(struct ae4_device *ae4);
 
+void ae4dma_debugfs_setup(struct ae4_device *ae4);
 int ae4_core_init(struct ae4_device *ae4);
 void ae4_core_destroy(struct ae4_device *ae4);
 
-- 
2.7.4

