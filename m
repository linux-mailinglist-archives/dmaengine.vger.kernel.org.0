Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5081FC33B
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2020 03:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbgFQBME (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 Jun 2020 21:12:04 -0400
Received: from mail-dm6nam11on2044.outbound.protection.outlook.com ([40.107.223.44]:9056
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726253AbgFQBMD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 16 Jun 2020 21:12:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ze27qjkeVe5H3CMJIPx3yJFTeh10DoyiCxNf4xAoOyGmxr3hiCB/3Pkg/Ax+XMBSMpSVc2EayU4VuucpPea0uN9MhRHUEkOCWHY0aCWpMoQQ6kyvw2HV886mhemhrizITANySr81JuwnfUrMcdMfZ75Tex9tfDyfZpJGotW//pY8GA/yiMcE94SaG432+WlJIrjwoL/HUv5LCdQO2L2QVmp6Nc5YLn+Vy0ivyV1NA2SI5S/d7ZfWmhphNAhvCH7VawX7V042EgYTL1SlbJCalCOkFmI+NmEV+EnniJAe07WepOM9yFQ5BG9TQbOpMTVXVue3/HcNhN+CwZ/ZRu0j4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsxrxLWCFa/tISfesWANnOtPQvn2g4fpUGhW586XZOY=;
 b=i4yoi6U4nCBxLjFrcCx+72w9SwcGjNb8F3nTAgc1uILC6/QSmvcDjAKjctPf6JZ/X3DYkiuI7UpgQDoiC0btXNAhmHBZjDb6uPP9wQ3K9xXSbN4lB23uK8GlaqOHTxNCVeF4akqSeEPBYWAtfOBuSLJtpEJPZ+poWYIm4kEwe4lNlgJORH8QSU3HWLrbJsY16E+RhzHGPhQPvyMPDquQP3KKx4AnR4RFC09CwWOKdQq3oMwufIwG1JHjR3zKrEQdHPIGAt5fJP/zVb5b+EAOUnjFhJOo0z8LcqZE+cquftYIKEVCAD9DEVWy+ZZLEu2tUgjEKQrcHH4OoAyCWGq9fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsxrxLWCFa/tISfesWANnOtPQvn2g4fpUGhW586XZOY=;
 b=vnfdrZxRclL7aeQkWKu+cs/sqb9i6UwHBuh+PbK0jfL6TQjnPTzDs2A8yRWpcwzBKmGafWrVPxZMIGqXELVC4EDHqgZkqbocHr5f8s6r2Luia7eJUf7qDEZOOMp4HnBhztgYmNtDEWsBGQGrRxtOYXa9dGWwIv13ngWrKNF14VQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3421.namprd12.prod.outlook.com (2603:10b6:208:cd::24)
 by MN2PR12MB3502.namprd12.prod.outlook.com (2603:10b6:208:c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.25; Wed, 17 Jun
 2020 01:11:58 +0000
Received: from MN2PR12MB3421.namprd12.prod.outlook.com
 ([fe80::956f:e98c:37b4:25aa]) by MN2PR12MB3421.namprd12.prod.outlook.com
 ([fe80::956f:e98c:37b4:25aa%7]) with mapi id 15.20.3088.029; Wed, 17 Jun 2020
 01:11:58 +0000
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     vkoul@kernel.org
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v5 2/3] dmaengine: ptdma: register PTDMA controller as a DMA resource
Date:   Tue, 16 Jun 2020 20:11:27 -0500
Message-Id: <1592356288-42064-3-git-send-email-Sanju.Mehta@amd.com>
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
Received: from sanjuamdntb2.amd.com (165.204.156.251) by MA1PR0101CA0003.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3109.21 via Frontend Transport; Wed, 17 Jun 2020 01:11:55 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a971a229-ba2a-4ff4-50de-08d8125b6f0b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3502:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3502FAB8AE6CD536C3F6DD85E59A0@MN2PR12MB3502.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:95;
X-Forefront-PRVS: 04371797A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JeBJ38jFVfJR3OOScAVoE5ZOQTdUwt23ZUldst+GXj/x7YgA+w1nzLYjiDYPNxRQnAqRNEu8nCo+SFumFw4EBLlJOLgCyGnMEg9Nvz4XBh5uChipZEscL4MUzvkg+4HDXg/c1+EIgA46OsP1PZ/aiXtROYeq6e+UY0sDIGv/eww6xQhjgI+Ac8XFm/fDhXoJzbFaXI+fcIGtDjmZ8gyV/FoBKnuZA0hUqY2MtH/tjGN4ex6VvrKPRrAvgYfIqbEQDWsa/YSs0cOTuuxtCczO896ZRcV4ytR53o40Nwgolr4RJVADuJK6f03oWxkRfEOt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3421.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(30864003)(5660300002)(4326008)(36756003)(66476007)(956004)(86362001)(7696005)(52116002)(2906002)(6916009)(2616005)(66556008)(66946007)(6666004)(83380400001)(16526019)(316002)(6486002)(478600001)(8676002)(8936002)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: nwc877ipLbtpK3P5pyDKuB+8t9SN86QeRRExCuKIyql3p+DrpLri5UvyjJKn3ZJ68j8sEIEgrHfmPaLmpBm9xHqOKMe9RI7Nx3+FsVDwmqr4ebpj+cvP08cvKVJ0EpeVusKudFb6IDJHX/Z5QuQ32sDuJ+s49ihFF476sQgk77jIeV+IY6E+k0HWXYCIX13JTz5qjQQtfG5QyVjen/ZYXw7LiayCqZxmNnBOYI3QECHJ3021t21tJ/3gIWeW2mq+uC+I/CuLwxcLvx5ywntvfa1NtLbwxWOnMMtIBZPqzCOwJ8BWKnR3NhpFpkaMYtr0PLooRMHzyZ5Cfbk4utDcMd5QMfPBfYVCeC6P5nTT4FYgg9E5vLVXL03z8Sy0Uo+zDqMzCB1kI5ESt/00kQk03RZv7AYcNkYrgsU4LFA35V7a5XqxhqP2BoJGwuJMGrwOYQE8wuspDkK2IHY32BGvdWLATuk8/XPzff5X8BlVFA0lEuUL4hS7rJ0/fHQZoae3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a971a229-ba2a-4ff4-50de-08d8125b6f0b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2020 01:11:58.9150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GEGe3r9zE6oBSrilmGo0dPr62viCRIAYWKBDpBXY0pmVFqK5l10S2Bk1l2Yq4DKUMxiYAHnQVEgtEhM4oEmDFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3502
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

This registers the ptdma queue to Linux dmaengine framework
as general-purpose DMA channels.

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 drivers/dma/ptdma/Kconfig           |   2 +
 drivers/dma/ptdma/Makefile          |   3 +-
 drivers/dma/ptdma/ptdma-dev.c       |  33 ++
 drivers/dma/ptdma/ptdma-dmaengine.c | 600 ++++++++++++++++++++++++++++++++++++
 drivers/dma/ptdma/ptdma.h           |  31 ++
 5 files changed, 668 insertions(+), 1 deletion(-)
 create mode 100644 drivers/dma/ptdma/ptdma-dmaengine.c

diff --git a/drivers/dma/ptdma/Kconfig b/drivers/dma/ptdma/Kconfig
index f93f9c2..694ed27 100644
--- a/drivers/dma/ptdma/Kconfig
+++ b/drivers/dma/ptdma/Kconfig
@@ -2,6 +2,8 @@
 config AMD_PTDMA
 	tristate  "AMD PassThru DMA Engine"
 	depends on X86_64 && PCI
+	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
 	help
 	  Enable support for the AMD PTDMA controller.  This controller
 	  provides DMA capabilities & performs high bandwidth memory to
diff --git a/drivers/dma/ptdma/Makefile b/drivers/dma/ptdma/Makefile
index 320fa82..6fcb4ad 100644
--- a/drivers/dma/ptdma/Makefile
+++ b/drivers/dma/ptdma/Makefile
@@ -5,6 +5,7 @@
 
 obj-$(CONFIG_AMD_PTDMA) += ptdma.o
 
-ptdma-objs := ptdma-dev.o
+ptdma-objs := ptdma-dev.o \
+	      ptdma-dmaengine.o
 
 ptdma-$(CONFIG_PCI) += ptdma-pci.o
diff --git a/drivers/dma/ptdma/ptdma-dev.c b/drivers/dma/ptdma/ptdma-dev.c
index d6dca5a..ef10be5 100644
--- a/drivers/dma/ptdma/ptdma-dev.c
+++ b/drivers/dma/ptdma/ptdma-dev.c
@@ -132,6 +132,26 @@ static inline void pt_core_enable_queue_interrupts(struct pt_device *pt)
 	iowrite32(SUPPORTED_INTERRUPTS, pt->cmd_q.reg_int_enable);
 }
 
+static void pt_do_cmd_complete(unsigned long data)
+{
+	struct pt_tasklet_data *tdata = (struct pt_tasklet_data *)data;
+	struct pt_cmd *cmd = tdata->cmd;
+	struct pt_cmd_queue *cmd_q = &cmd->pt->cmd_q;
+	u32 tail;
+
+	tail = lower_32_bits(cmd_q->qdma_tail + cmd_q->qidx * Q_DESC_SIZE);
+	if (cmd_q->cmd_error) {
+	       /*
+		* Log the error and flush the queue by
+		* moving the head pointer
+		*/
+		pt_log_error(cmd_q->pt, cmd_q->cmd_error);
+		iowrite32(tail, cmd_q->reg_head_lo);
+	}
+
+	cmd->pt_cmd_callback(cmd->data, cmd->ret);
+}
+
 static irqreturn_t pt_core_irq_handler(int irq, void *data)
 {
 	struct pt_device *pt = (struct pt_device *)data;
@@ -156,6 +176,8 @@ static irqreturn_t pt_core_irq_handler(int irq, void *data)
 
 	pt_core_enable_queue_interrupts(pt);
 
+	pt_do_cmd_complete((ulong)&pt->tdata);
+
 	return IRQ_HANDLED;
 }
 
@@ -263,8 +285,16 @@ int pt_core_init(struct pt_device *pt)
 
 	dev_dbg(dev, "PTDMA device %s registration successful...\n", pt->name);
 
+	/* Register the DMA engine support */
+	ret = pt_dmaengine_register(pt);
+	if (ret)
+		goto e_dmaengine;
+
 	return 0;
 
+e_dmaengine:
+	free_irq(pt->pt_irq, pt);
+
 e_dma_alloc:
 	dma_free_coherent(dev, cmd_q->qsize, cmd_q->qbase, cmd_q->qbase_dma);
 
@@ -280,6 +310,9 @@ void pt_core_destroy(struct pt_device *pt)
 	struct pt_cmd_queue *cmd_q = &pt->cmd_q;
 	struct pt_cmd *cmd;
 
+	/* Unregister the DMA engine */
+	pt_dmaengine_unregister(pt);
+
 	/* Disable and clear interrupts */
 	pt_core_disable_queue_interrupts(pt);
 
diff --git a/drivers/dma/ptdma/ptdma-dmaengine.c b/drivers/dma/ptdma/ptdma-dmaengine.c
new file mode 100644
index 0000000..f1faba6
--- /dev/null
+++ b/drivers/dma/ptdma/ptdma-dmaengine.c
@@ -0,0 +1,600 @@
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
+#include "ptdma.h"
+#include "../dmaengine.h"
+#include "../virt-dma.h"
+
+#define PT_DMA_WIDTH(_mask)		\
+({					\
+	u64 mask = (_mask) + 1;		\
+	(mask == 0) ? 64 : fls64(mask);	\
+})
+
+static void pt_free_cmd_resources(struct pt_device *pt,
+				  struct list_head *list)
+{
+	struct pt_dma_cmd *cmd, *ctmp;
+
+	list_for_each_entry_safe(cmd, ctmp, list, entry) {
+		list_del(&cmd->entry);
+		kmem_cache_free(pt->dma_cmd_cache, cmd);
+	}
+}
+
+static void pt_free_chan_resources(struct dma_chan *dma_chan)
+{
+	struct pt_dma_chan *chan = container_of(dma_chan, struct pt_dma_chan,
+						 vc.chan);
+
+	dev_dbg(chan->pt->dev, "%s - chan=%p\n", __func__, chan);
+
+	vchan_free_chan_resources(&chan->vc);
+}
+
+static void pt_synchronize(struct dma_chan *dma_chan)
+{
+	struct pt_dma_chan *chan = container_of(dma_chan, struct pt_dma_chan,
+						 vc.chan);
+	dev_dbg(chan->pt->dev, "%s\n", __func__);
+
+	vchan_synchronize(&chan->vc);
+}
+
+static void pt_do_cleanup(struct virt_dma_desc	*vd)
+
+{
+	struct pt_dma_desc *desc = container_of(vd, struct pt_dma_desc, vd);
+	struct pt_device *pt = desc->pt;
+	struct pt_dma_chan *chan;
+
+	chan = container_of(desc->vd.tx.chan, struct pt_dma_chan,
+			    vc.chan);
+
+	pt_free_cmd_resources(pt, &desc->cmdlist);
+	kmem_cache_free(pt->dma_desc_cache, desc);
+}
+
+static int pt_issue_next_cmd(struct pt_dma_desc *desc)
+{
+	struct pt_passthru_engine *pt_engine;
+	struct pt_dma_cmd *cmd;
+	struct pt_device *pt;
+	struct pt_cmd *pt_cmd;
+	struct pt_cmd_queue *cmd_q;
+
+	cmd = list_first_entry(&desc->cmdlist, struct pt_dma_cmd, entry);
+	desc->actv = 1;
+
+	dev_dbg(desc->pt->dev, "%s - tx %d, cmd=%p\n", __func__,
+		desc->vd.tx.cookie, cmd);
+
+	pt_cmd = &cmd->pt_cmd;
+	pt = pt_cmd->pt;
+	cmd_q = &pt->cmd_q;
+	pt_engine = &pt_cmd->passthru;
+
+	if (!pt_engine->final)
+		return -EINVAL;
+
+	if (!pt_engine->src_dma || !pt_engine->dst_dma)
+		return -EINVAL;
+
+	pt->tdata.cmd = pt_cmd;
+
+	/* Execute the command */
+	pt_cmd->ret = pt_core_perform_passthru(cmd_q, pt_engine);
+
+	return 0;
+}
+
+static void pt_free_active_cmd(struct pt_dma_desc *desc)
+{
+	struct pt_dma_cmd *cmd = NULL;
+
+	if (desc->actv)
+		cmd = list_first_entry_or_null(&desc->cmdlist, struct pt_dma_cmd,
+					       entry);
+	if (!cmd)
+		return;
+
+	dev_dbg(desc->pt->dev, "%s - freeing tx %d cmd=%p\n",
+		__func__, desc->vd.tx.cookie, cmd);
+
+	list_del(&cmd->entry);
+	kmem_cache_free(desc->pt->dma_cmd_cache, cmd);
+}
+
+static struct pt_dma_desc *pt_next_dma_desc(struct pt_dma_chan *chan)
+{
+	/* Get the next DMA descriptor on the active list */
+	struct virt_dma_desc *vd = vchan_next_desc(&chan->vc);
+
+	return vd ? container_of(vd, struct pt_dma_desc, vd) : NULL;
+}
+
+static struct pt_dma_desc *__pt_next_dma_desc(struct pt_dma_chan *chan)
+{
+	/* Get the next DMA descriptor on the active list */
+	struct virt_dma_desc *vd = vchan_next_desc(&chan->vc);
+
+	if (list_empty(&chan->vc.desc_submitted))
+		return NULL;
+
+	vd = list_empty(&chan->vc.desc_issued) ?
+		  list_first_entry(&chan->vc.desc_submitted,
+				   struct virt_dma_desc, node) : NULL;
+
+	vchan_issue_pending(&chan->vc);
+
+	return vd ? container_of(vd, struct pt_dma_desc, vd) : NULL;
+}
+
+static struct pt_dma_desc *pt_handle_active_desc(struct pt_dma_chan *chan,
+						 struct pt_dma_desc *desc)
+{
+	struct dma_async_tx_descriptor *tx_desc;
+	struct virt_dma_desc *vd;
+	unsigned long flags;
+
+	/* Loop over descriptors until one is found with commands */
+	do {
+		if (desc) {
+			/* Remove the DMA command from the list and free it */
+			pt_free_active_cmd(desc);
+			if (!desc->actv) {
+				/* No errors, keep going */
+				if (desc->status != DMA_ERROR)
+					return desc;
+				/* Error, free remaining commands and move on */
+				pt_free_cmd_resources(desc->pt,
+						      &desc->cmdlist);
+			}
+
+			tx_desc = &desc->vd.tx;
+			vd = &desc->vd;
+		} else {
+			tx_desc = NULL;
+		}
+
+		spin_lock_irqsave(&chan->vc.lock, flags);
+
+		if (desc) {
+			if (desc->status != DMA_ERROR)
+				desc->status = DMA_COMPLETE;
+
+			dev_dbg(desc->pt->dev,
+				"%s - tx %d complete, status=%u\n", __func__,
+				desc->vd.tx.cookie, desc->status);
+
+			dma_cookie_complete(tx_desc);
+			dma_descriptor_unmap(tx_desc);
+			list_del(&desc->vd.node);
+		}
+
+		desc = pt_next_dma_desc(chan);
+
+		spin_unlock_irqrestore(&chan->vc.lock, flags);
+
+		if (tx_desc) {
+			dmaengine_desc_get_callback_invoke(tx_desc, NULL);
+			dma_run_dependencies(tx_desc);
+			vchan_vdesc_fini(vd);
+		}
+	} while (desc);
+
+	return NULL;
+}
+
+static void pt_cmd_callback(void *data, int err)
+{
+	struct pt_dma_desc *desc = data;
+	struct pt_dma_chan *chan;
+	int ret;
+
+	if (err == -EINPROGRESS)
+		return;
+
+	chan = container_of(desc->vd.tx.chan, struct pt_dma_chan,
+			    vc.chan);
+
+	dev_dbg(chan->pt->dev, "%s - tx %d callback, err=%d\n",
+		__func__, desc->vd.tx.cookie, err);
+
+	if (err)
+		desc->status = DMA_ERROR;
+
+	while (true) {
+		/* Check for DMA descriptor completion */
+		desc = pt_handle_active_desc(chan, desc);
+
+		/* Don't submit cmd if no descriptor or DMA is paused */
+		if (!desc)
+			break;
+
+		ret = pt_issue_next_cmd(desc);
+		if (!ret)
+			break;
+
+		desc->status = DMA_ERROR;
+	}
+}
+
+static struct pt_dma_cmd *pt_alloc_dma_cmd(struct pt_dma_chan *chan)
+{
+	struct pt_dma_cmd *cmd;
+
+	cmd = kmem_cache_zalloc(chan->pt->dma_cmd_cache, GFP_NOWAIT);
+
+	return cmd;
+}
+
+static struct pt_dma_desc *pt_alloc_dma_desc(struct pt_dma_chan *chan,
+					     unsigned long flags)
+{
+	struct pt_dma_desc *desc;
+
+	desc = kmem_cache_zalloc(chan->pt->dma_desc_cache, GFP_NOWAIT);
+	if (!desc)
+		return NULL;
+
+	vchan_tx_prep(&chan->vc, &desc->vd, flags);
+
+	desc->pt = chan->pt;
+	desc->actv = 0;
+	INIT_LIST_HEAD(&desc->cmdlist);
+	desc->status = DMA_IN_PROGRESS;
+
+	return desc;
+}
+
+static struct pt_dma_desc *pt_create_desc(struct dma_chan *dma_chan,
+					  struct scatterlist *dst_sg,
+					  unsigned int dst_nents,
+					  struct scatterlist *src_sg,
+					  unsigned int src_nents,
+					  unsigned long flags)
+{
+	struct pt_dma_chan *chan = container_of(dma_chan, struct pt_dma_chan,
+						 vc.chan);
+	struct pt_device *pt = chan->pt;
+	struct pt_dma_desc *desc;
+	struct pt_dma_cmd *cmd;
+	struct pt_cmd *pt_cmd;
+	struct pt_passthru_engine *pt_engine;
+	unsigned int src_offset, src_len;
+	unsigned int dst_offset, dst_len;
+	unsigned int len;
+	size_t total_len;
+
+	if (!dst_sg || !src_sg)
+		return NULL;
+
+	if (!dst_nents || !src_nents)
+		return NULL;
+
+	desc = pt_alloc_dma_desc(chan, flags);
+	if (!desc)
+		return NULL;
+
+	total_len = 0;
+
+	src_len = sg_dma_len(src_sg);
+	src_offset = 0;
+
+	dst_len = sg_dma_len(dst_sg);
+	dst_offset = 0;
+
+	while (true) {
+		if (!src_len) {
+			src_nents--;
+			if (!src_nents)
+				break;
+
+			src_sg = sg_next(src_sg);
+			if (!src_sg)
+				break;
+
+			src_len = sg_dma_len(src_sg);
+			src_offset = 0;
+			continue;
+		}
+
+		if (!dst_len) {
+			dst_nents--;
+			if (!dst_nents)
+				break;
+
+			dst_sg = sg_next(dst_sg);
+			if (!dst_sg)
+				break;
+
+			dst_len = sg_dma_len(dst_sg);
+			dst_offset = 0;
+			continue;
+		}
+
+		len = min(dst_len, src_len);
+
+		cmd = pt_alloc_dma_cmd(chan);
+		if (!cmd)
+			goto err;
+
+		pt_cmd = &cmd->pt_cmd;
+		pt_cmd->pt = chan->pt;
+		pt_engine = &pt_cmd->passthru;
+		pt_cmd->engine = PT_ENGINE_PASSTHRU;
+		pt_engine->src_dma = sg_dma_address(src_sg) + src_offset;
+		pt_engine->dst_dma = sg_dma_address(dst_sg) + dst_offset;
+		pt_engine->src_len = len;
+		pt_engine->final = 1;
+		pt_cmd->pt_cmd_callback = pt_cmd_callback;
+		pt_cmd->data = desc;
+
+		list_add_tail(&cmd->entry, &desc->cmdlist);
+
+		dev_dbg(pt->dev,
+			"%s - cmd=%p, src=%pad, dst=%pad, len=%llu\n", __func__,
+			cmd, &pt_engine->src_dma,
+			&pt_engine->dst_dma, pt_engine->src_len);
+
+		total_len += len;
+
+		src_len -= len;
+		src_offset += len;
+
+		dst_len -= len;
+		dst_offset += len;
+	}
+
+	desc->len = total_len;
+
+	if (list_empty(&desc->cmdlist))
+		goto err;
+
+	return desc;
+
+err:
+	pt_free_cmd_resources(pt, &desc->cmdlist);
+	kmem_cache_free(pt->dma_desc_cache, desc);
+
+	return NULL;
+}
+
+static struct dma_async_tx_descriptor *
+pt_prep_dma_memcpy(struct dma_chan *dma_chan, dma_addr_t dst,
+		   dma_addr_t src, size_t len, unsigned long flags)
+{
+	struct pt_dma_chan *chan = container_of(dma_chan, struct pt_dma_chan,
+						 vc.chan);
+	struct pt_dma_desc *desc;
+	struct scatterlist dst_sg, src_sg;
+
+	dev_dbg(chan->pt->dev,
+		"%s - src=%pad, dst=%pad, len=%zu, flags=%#lx\n",
+		__func__, &src, &dst, len, flags);
+
+	sg_init_table(&dst_sg, 1);
+	sg_dma_address(&dst_sg) = dst;
+	sg_dma_len(&dst_sg) = len;
+
+	sg_init_table(&src_sg, 1);
+	sg_dma_address(&src_sg) = src;
+	sg_dma_len(&src_sg) = len;
+
+	desc = pt_create_desc(dma_chan, &dst_sg, 1, &src_sg, 1, flags);
+	if (!desc)
+		return NULL;
+
+	return &desc->vd.tx;
+}
+
+static struct dma_async_tx_descriptor *
+pt_prep_dma_interrupt(struct dma_chan *dma_chan, unsigned long flags)
+{
+	struct pt_dma_chan *chan = container_of(dma_chan, struct pt_dma_chan,
+						 vc.chan);
+	struct pt_dma_desc *desc;
+
+	desc = pt_alloc_dma_desc(chan, flags);
+	if (!desc)
+		return NULL;
+
+	return &desc->vd.tx;
+}
+
+static void pt_issue_pending(struct dma_chan *dma_chan)
+{
+	struct pt_dma_chan *chan = container_of(dma_chan, struct pt_dma_chan,
+						 vc.chan);
+	struct pt_dma_desc *desc;
+	unsigned long flags;
+
+	dev_dbg(chan->pt->dev, "%s\n", __func__);
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+
+	desc = __pt_next_dma_desc(chan);
+
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+
+	/* If there was nothing active, start processing */
+	if (desc)
+		pt_cmd_callback(desc, 0);
+}
+
+static enum dma_status pt_tx_status(struct dma_chan *dma_chan,
+				    dma_cookie_t cookie,
+				    struct dma_tx_state *state)
+{
+	struct pt_dma_chan *chan = container_of(dma_chan, struct pt_dma_chan,
+						 vc.chan);
+	struct pt_dma_desc *desc;
+	enum dma_status ret;
+	unsigned long flags;
+	struct virt_dma_desc *vd;
+
+	ret = dma_cookie_status(dma_chan, cookie, state);
+	if (ret == DMA_COMPLETE)
+		return ret;
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+	vd = vchan_find_desc(&chan->vc, cookie);
+	desc = vd ? container_of(vd, struct pt_dma_desc, vd) : NULL;
+	ret = desc->status;
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+
+	dev_dbg(chan->pt->dev, "%s - %u\n", __func__, ret);
+
+	return ret;
+}
+
+static int pt_pause(struct dma_chan *dma_chan)
+{
+	struct pt_dma_chan *chan = container_of(dma_chan, struct pt_dma_chan,
+						 vc.chan);
+	unsigned long flags;
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+	pt_stop_queue(&chan->pt->cmd_q);
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+
+	return 0;
+}
+
+static int pt_resume(struct dma_chan *dma_chan)
+{
+	struct pt_dma_chan *chan = container_of(dma_chan, struct pt_dma_chan,
+						 vc.chan);
+	struct pt_dma_desc *desc = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+	pt_start_queue(&chan->pt->cmd_q);
+	desc = __pt_next_dma_desc(chan);
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+
+	/* If there was something active, re-start */
+	if (desc)
+		pt_cmd_callback(desc, 0);
+
+	return 0;
+}
+
+static int pt_terminate_all(struct dma_chan *dma_chan)
+{
+	struct pt_dma_chan *chan = container_of(dma_chan, struct pt_dma_chan,
+						 vc.chan);
+
+	dev_dbg(chan->pt->dev, "%s\n", __func__);
+
+	vchan_free_chan_resources(&chan->vc);
+
+	return 0;
+}
+
+int pt_dmaengine_register(struct pt_device *pt)
+{
+	struct pt_dma_chan *chan;
+	struct dma_device *dma_dev = &pt->dma_dev;
+	struct dma_chan *dma_chan;
+	char *dma_cmd_cache_name;
+	char *dma_desc_cache_name;
+	int ret;
+
+	pt->pt_dma_chan = devm_kcalloc(pt->dev, 1,
+				       sizeof(*pt->pt_dma_chan),
+				       GFP_KERNEL);
+	if (!pt->pt_dma_chan)
+		return -ENOMEM;
+
+	dma_cmd_cache_name = devm_kasprintf(pt->dev, GFP_KERNEL,
+					    "%s-dmaengine-cmd-cache",
+					    pt->name);
+	if (!dma_cmd_cache_name)
+		return -ENOMEM;
+
+	pt->dma_cmd_cache = kmem_cache_create(dma_cmd_cache_name,
+					      sizeof(struct pt_dma_cmd),
+					      sizeof(void *),
+					      SLAB_HWCACHE_ALIGN, NULL);
+	if (!pt->dma_cmd_cache)
+		return -ENOMEM;
+
+	dma_desc_cache_name = devm_kasprintf(pt->dev, GFP_KERNEL,
+					     "%s-dmaengine-desc-cache",
+					     pt->name);
+	if (!dma_desc_cache_name) {
+		ret = -ENOMEM;
+		goto err_cache;
+	}
+
+	pt->dma_desc_cache = kmem_cache_create(dma_desc_cache_name,
+					       sizeof(struct pt_dma_desc),
+					       sizeof(void *),
+					       SLAB_HWCACHE_ALIGN, NULL);
+	if (!pt->dma_desc_cache) {
+		ret = -ENOMEM;
+		goto err_cache;
+	}
+
+	dma_dev->dev = pt->dev;
+	dma_dev->src_addr_widths = PT_DMA_WIDTH(dma_get_mask(pt->dev));
+	dma_dev->dst_addr_widths = PT_DMA_WIDTH(dma_get_mask(pt->dev));
+	dma_dev->directions = DMA_MEM_TO_MEM;
+	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
+	dma_cap_set(DMA_MEMCPY, dma_dev->cap_mask);
+	dma_cap_set(DMA_INTERRUPT, dma_dev->cap_mask);
+	dma_cap_set(DMA_PRIVATE, dma_dev->cap_mask);
+
+	INIT_LIST_HEAD(&dma_dev->channels);
+
+	chan = pt->pt_dma_chan;
+	chan->pt = pt;
+	dma_chan = &chan->vc.chan;
+
+	dma_dev->device_free_chan_resources = pt_free_chan_resources;
+	dma_dev->device_prep_dma_memcpy = pt_prep_dma_memcpy;
+	dma_dev->device_prep_dma_interrupt = pt_prep_dma_interrupt;
+	dma_dev->device_issue_pending = pt_issue_pending;
+	dma_dev->device_tx_status = pt_tx_status;
+	dma_dev->device_pause = pt_pause;
+	dma_dev->device_resume = pt_resume;
+	dma_dev->device_terminate_all = pt_terminate_all;
+	dma_dev->device_synchronize = pt_synchronize;
+
+	chan->vc.desc_free = pt_do_cleanup;
+	vchan_init(&chan->vc, dma_dev);
+
+	ret = dma_async_device_register(dma_dev);
+	if (ret)
+		goto err_reg;
+
+	return 0;
+
+err_reg:
+	kmem_cache_destroy(pt->dma_desc_cache);
+
+err_cache:
+	kmem_cache_destroy(pt->dma_cmd_cache);
+
+	return ret;
+}
+
+void pt_dmaengine_unregister(struct pt_device *pt)
+{
+	struct dma_device *dma_dev = &pt->dma_dev;
+
+	dma_async_device_unregister(dma_dev);
+
+	kmem_cache_destroy(pt->dma_desc_cache);
+	kmem_cache_destroy(pt->dma_cmd_cache);
+}
diff --git a/drivers/dma/ptdma/ptdma.h b/drivers/dma/ptdma/ptdma.h
index 6b3b3cc..661be6b 100644
--- a/drivers/dma/ptdma/ptdma.h
+++ b/drivers/dma/ptdma/ptdma.h
@@ -20,6 +20,9 @@
 #include <linux/list.h>
 #include <linux/wait.h>
 #include <linux/dmapool.h>
+#include <linux/dmaengine.h>
+
+#include "../virt-dma.h"
 
 #define MAX_PT_NAME_LEN			16
 #define MAX_DMAPOOL_NAME_LEN		32
@@ -179,6 +182,25 @@ struct pt_cmd {
 	void *data;
 };
 
+struct pt_dma_cmd {
+	struct list_head entry;
+	struct pt_cmd pt_cmd;
+};
+
+struct pt_dma_desc {
+	struct virt_dma_desc vd;
+	struct pt_device *pt;
+	struct list_head cmdlist;
+	enum dma_status status;
+	size_t len;
+	bool actv;
+};
+
+struct pt_dma_chan {
+	struct virt_dma_chan vc;
+	struct pt_device *pt;
+};
+
 struct pt_cmd_queue {
 	struct pt_device *pt;
 
@@ -247,6 +269,12 @@ struct pt_device {
 	 */
 	struct pt_cmd_queue cmd_q;
 
+	/* Support for the DMA Engine capabilities */
+	struct dma_device dma_dev;
+	struct pt_dma_chan *pt_dma_chan;
+	struct kmem_cache *dma_cmd_cache;
+	struct kmem_cache *dma_desc_cache;
+
 	wait_queue_head_t lsb_queue;
 
 	struct pt_tasklet_data tdata;
@@ -312,6 +340,9 @@ struct pt_dev_vdata {
 	const unsigned int version;
 };
 
+int pt_dmaengine_register(struct pt_device *pt);
+void pt_dmaengine_unregister(struct pt_device *pt);
+
 int pt_core_init(struct pt_device *pt);
 void pt_core_destroy(struct pt_device *pt);
 
-- 
2.7.4

