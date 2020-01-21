Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B683143905
	for <lists+dmaengine@lfdr.de>; Tue, 21 Jan 2020 10:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgAUJFv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Jan 2020 04:05:51 -0500
Received: from mail-bn8nam11on2066.outbound.protection.outlook.com ([40.107.236.66]:6028
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727360AbgAUJFv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 Jan 2020 04:05:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqZZXPR7GCXQrElezzBcxlyE0AxfUvS3eoae7YLjAuK842bTSNrelz2vApsdteE2wKhwByhLHCUO3OZT/NUJZkWNlwjt4ygGXQ0wxsEBt5mePWozr1Jm9Cpe2kX/zZbIhUVTYzywbXJzTJSy3FgG8ZbVHMQrmmobW0/tINKUMGPQ4P5O5UVQqM8WhRa6EEj42OsXCr8vPg+sKTWYLaFmSqVG3PZZdj0NK0puCcG4f8QnUtLEJr3D1oY/dA/Zzw/06OAWf5cgTKOvyGYFqy/ONpa4zP4LZNFPLVUarbbRbd+4mIAUaTyKwKRheE5UyFDB8xwtrLe3SiEIxKsslFF2RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8bKn37AXl7GreNi2VMkMs0JJMANKUG3s7ImIQzdlI0=;
 b=FVWNLZY4OYdJSG09q7snsoxEtEonb5lcp5czivZhbtMukFUbhB3WPJvSZDRfslyLv85uW5AJZwDt7hTNRGhACJ+pSHu0Sy8bVFSCw4R9QgtsiCO3grvVX/QLOrxRzvfWcTMfu6uqkKafLiTsQX408uwj0xzC3MaAtsnx/fClesWXo8EgxspNvhJoHuBzW+t+HrbKk2lvqaSjs1CeWCMTStzsyUfLKEX2U/VbUjffEBVLsHgzMY5yoeYFyI1+NPQibUbejCBLnw7ne/s0/k8hnBbRG9Jw3wzWGJX1ce55ldwRmB0bVOMJSOJQrngGjIousgUgIirigfd7U45F2M37MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8bKn37AXl7GreNi2VMkMs0JJMANKUG3s7ImIQzdlI0=;
 b=UEMJd/ChRBQ25rYgEwmCRG2c026BWoZjVMdfpdY3+JxFi0kiNGn3pw+NBm/wol0FU5LcxTpcA0c+gyK0j6fm8FpvQLQzLOc6G1Tzu4ihxYQukyrNSI4NHEH+ch8UVJfw36PSTqFoTGkmiZcsHZPTaB5Hpzc4Xsh23epbTswAeeI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sanju.Mehta@amd.com; 
Received: from MN2PR12MB3455.namprd12.prod.outlook.com (20.178.244.22) by
 MN2PR12MB4048.namprd12.prod.outlook.com (52.135.49.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Tue, 21 Jan 2020 09:05:47 +0000
Received: from MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::1900:6cb7:12ff:11c]) by MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::1900:6cb7:12ff:11c%4]) with mapi id 15.20.2644.027; Tue, 21 Jan 2020
 09:05:47 +0000
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     vkoul@kernel.org, gregkh@linuxfoundation.org,
        dan.j.williams@intel.com, Thomas.Lendacky@amd.com,
        Shyam-sundar.S-k@amd.com, Nehal-bakulchandra.Shah@amd.com
Cc:     robh@kernel.org, mchehab+samsung@kernel.org, davem@davemloft.net,
        Jonathan.Cameron@huawei.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v3 2/3] dmaengine: ptdma: Register pass-through engine as a DMA resource
Date:   Tue, 21 Jan 2020 03:04:53 -0600
Message-Id: <1579597494-60348-3-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579597494-60348-1-git-send-email-Sanju.Mehta@amd.com>
References: <1579597494-60348-1-git-send-email-Sanju.Mehta@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0152.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::22) To MN2PR12MB3455.namprd12.prod.outlook.com
 (2603:10b6:208:d0::22)
MIME-Version: 1.0
Received: from sanjuamdntb2.amd.com (165.204.156.251) by MA1PR01CA0152.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.18 via Frontend Transport; Tue, 21 Jan 2020 09:05:43 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d7fcda3e-9ba6-4cc5-074a-08d79e511a69
X-MS-TrafficTypeDiagnostic: MN2PR12MB4048:|MN2PR12MB4048:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40486FA94BFF6987F276905AE50D0@MN2PR12MB4048.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:126;
X-Forefront-PRVS: 0289B6431E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(199004)(189003)(7696005)(52116002)(30864003)(6486002)(6666004)(8676002)(81166006)(2906002)(81156014)(8936002)(5660300002)(316002)(186003)(66476007)(66556008)(16526019)(2616005)(26005)(956004)(478600001)(66946007)(36756003)(86362001)(4326008)(6636002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB4048;H:MN2PR12MB3455.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Ju7NsQdXQECaeLcktnHUTCG7wSqvTdH3Vy90ibmnpckxjHnPEcL9zj/jNFLtfTrF0OerbAP5Z72yetzUWYWw2enT2pXiDkXfPBFEPvL0/6USh+jnQeY1AsXXI6DHDVJU4UJSPoOlIAjDsZNf2Wlz/JIG0ilKjbNEkKLqFCFgROgAk38wpZh80wGjvWiBl42cBoIdZ829LU8NhuMoaEmGV71H0rvfaiQVs9bBnoZLB1uyg8AcL2737JVx1Nt6pwN5GuYv/58nES0VtkbwYpb5CTOuHCA45EXNfEiFNx6QUZiR+JwXvdogkjrumxWZvHx+R2IyoHXky49yd7emM+4NvFuvSsa2RMeRjEkBfoLlOTMGzKEkjKH13aq/aOANee/fBgbKX3CiiUWynFGgBWpVLElnqcsaVKkV9Npl5Fko7wr7OGfGhYNYQwJWROqE2Nx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7fcda3e-9ba6-4cc5-074a-08d79e511a69
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2020 09:05:47.1533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vtSmuLBX1ZbOq91wG6VFjMQbyza7Hm/n0LHNT5dEc8qhMIV+ZUzHpkLVbLDzECTpkQWEMLXBf6bnFIvowHmyiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

This Registers the ptdma queue to Linux dmaengine
framework as general purpose DMA channels.

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 drivers/dma/ptdma/Kconfig           |   1 +
 drivers/dma/ptdma/Makefile          |   3 +-
 drivers/dma/ptdma/ptdma-dev.c       |  35 ++
 drivers/dma/ptdma/ptdma-dmaengine.c | 704 ++++++++++++++++++++++++++++++++++++
 drivers/dma/ptdma/ptdma.h           |  45 +++
 5 files changed, 787 insertions(+), 1 deletion(-)
 create mode 100644 drivers/dma/ptdma/ptdma-dmaengine.c

diff --git a/drivers/dma/ptdma/Kconfig b/drivers/dma/ptdma/Kconfig
index 4ec259e..f4848bf 100644
--- a/drivers/dma/ptdma/Kconfig
+++ b/drivers/dma/ptdma/Kconfig
@@ -2,5 +2,6 @@
 config AMD_PTDMA
 	tristate  "AMD PassThru DMA Engine"
 	depends on X86_64 && PCI
+	select DMA_ENGINE
 	help
 	  Provides the support for AMD PassThru DMA Engine.
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
index c10adce..0162ecd 100644
--- a/drivers/dma/ptdma/ptdma-dev.c
+++ b/drivers/dma/ptdma/ptdma-dev.c
@@ -222,6 +222,8 @@ static irqreturn_t pt_core_irq_handler(int irq, void *data)
 
 	pt_core_enable_queue_interrupts(pt);
 
+	tasklet_schedule(&pt->tasklet);
+
 	return IRQ_HANDLED;
 }
 
@@ -240,6 +242,26 @@ static void pt_init_cmdq_regs(struct pt_cmd_queue *cmd_q)
 	cmd_q->reg_interrupt_status = io_regs + CMD_Q_INTERRUPT_STATUS_BASE;
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
 int pt_core_init(struct pt_device *pt)
 {
 	struct device *dev = pt->dev;
@@ -341,8 +363,18 @@ int pt_core_init(struct pt_device *pt)
 
 	dev_dbg(dev, "PTDMA device %s registration successful...\n", pt->name);
 
+	/* Register the DMA engine support */
+	ret = pt_dmaengine_register(pt);
+	if (ret)
+		goto e_dmaengine;
+
+	tasklet_init(&pt->tasklet, pt_do_cmd_complete, (ulong)&pt->tdata);
+
 	return 0;
 
+e_dmaengine:
+	free_irq(pt->pt_irq, pt);
+
 e_dma_alloc:
 	dma_free_coherent(dev, cmd_q->qsize, cmd_q->qbase, cmd_q->qbase_dma);
 
@@ -358,6 +390,9 @@ void pt_core_destroy(struct pt_device *pt)
 	struct pt_cmd_queue *cmd_q = &pt->cmd_q;
 	struct pt_cmd *cmd;
 
+	/* Unregister the DMA engine */
+	pt_dmaengine_unregister(pt);
+
 	/* Remove this device from the list of available units first */
 	pt_del_device(pt);
 
diff --git a/drivers/dma/ptdma/ptdma-dmaengine.c b/drivers/dma/ptdma/ptdma-dmaengine.c
new file mode 100644
index 0000000..b91a83e
--- /dev/null
+++ b/drivers/dma/ptdma/ptdma-dmaengine.c
@@ -0,0 +1,704 @@
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
+#include "ptdma.h"
+#include "../dmaengine.h"
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
+static void pt_free_desc_resources(struct pt_device *pt,
+				   struct list_head *list)
+{
+	struct pt_dma_desc *desc, *dtmp;
+
+	list_for_each_entry_safe(desc, dtmp, list, entry) {
+		pt_free_cmd_resources(pt, &desc->active);
+		pt_free_cmd_resources(pt, &desc->pending);
+
+		list_del(&desc->entry);
+		kmem_cache_free(pt->dma_desc_cache, desc);
+	}
+}
+
+static void pt_free_chan_resources(struct dma_chan *dma_chan)
+{
+	struct pt_dma_chan *chan = container_of(dma_chan, struct pt_dma_chan,
+						 dma_chan);
+	unsigned long flags;
+
+	dev_dbg(chan->pt->dev, "%s - chan=%p\n", __func__, chan);
+
+	spin_lock_irqsave(&chan->lock, flags);
+
+	pt_free_desc_resources(chan->pt, &chan->complete);
+	pt_free_desc_resources(chan->pt, &chan->active);
+	pt_free_desc_resources(chan->pt, &chan->pending);
+	pt_free_desc_resources(chan->pt, &chan->created);
+
+	spin_unlock_irqrestore(&chan->lock, flags);
+}
+
+static void pt_cleanup_desc_resources(struct pt_device *pt,
+				      struct list_head *list)
+{
+	struct pt_dma_desc *desc, *dtmp;
+
+	list_for_each_entry_safe_reverse(desc, dtmp, list, entry) {
+		if (!async_tx_test_ack(&desc->tx_desc))
+			continue;
+
+		dev_dbg(pt->dev, "%s - desc=%p\n", __func__, desc);
+
+		pt_free_cmd_resources(pt, &desc->active);
+		pt_free_cmd_resources(pt, &desc->pending);
+
+		list_del(&desc->entry);
+		kmem_cache_free(pt->dma_desc_cache, desc);
+	}
+}
+
+static void pt_do_cleanup(unsigned long data)
+{
+	struct pt_dma_chan *chan = (struct pt_dma_chan *)data;
+	unsigned long flags;
+
+	dev_dbg(chan->pt->dev, "%s - chan=%s\n", __func__,
+		dma_chan_name(&chan->dma_chan));
+
+	spin_lock_irqsave(&chan->lock, flags);
+
+	pt_cleanup_desc_resources(chan->pt, &chan->complete);
+
+	spin_unlock_irqrestore(&chan->lock, flags);
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
+	cmd = list_first_entry(&desc->pending, struct pt_dma_cmd, entry);
+	list_move(&cmd->entry, &desc->active);
+
+	dev_dbg(desc->pt->dev, "%s - tx %d, cmd=%p\n", __func__,
+		desc->tx_desc.cookie, cmd);
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
+	struct pt_dma_cmd *cmd;
+
+	cmd = list_first_entry_or_null(&desc->active, struct pt_dma_cmd,
+				       entry);
+	if (!cmd)
+		return;
+
+	dev_dbg(desc->pt->dev, "%s - freeing tx %d cmd=%p\n",
+		__func__, desc->tx_desc.cookie, cmd);
+
+	list_del(&cmd->entry);
+	kmem_cache_free(desc->pt->dma_cmd_cache, cmd);
+}
+
+static struct pt_dma_desc *__pt_next_dma_desc(struct pt_dma_chan *chan,
+					      struct pt_dma_desc *desc)
+{
+	/* Move current DMA descriptor to the complete list */
+	if (desc)
+		list_move(&desc->entry, &chan->complete);
+
+	/* Get the next DMA descriptor on the active list */
+	desc = list_first_entry_or_null(&chan->active, struct pt_dma_desc,
+					entry);
+
+	return desc;
+}
+
+static struct pt_dma_desc *pt_handle_active_desc(struct pt_dma_chan *chan,
+						 struct pt_dma_desc *desc)
+{
+	struct dma_async_tx_descriptor *tx_desc;
+	unsigned long flags;
+
+	/* Loop over descriptors until one is found with commands */
+	do {
+		if (desc) {
+			/* Remove the DMA command from the list and free it */
+			pt_free_active_cmd(desc);
+
+			if (!list_empty(&desc->pending)) {
+				/* No errors, keep going */
+				if (desc->status != DMA_ERROR)
+					return desc;
+
+				/* Error, free remaining commands and move on */
+				pt_free_cmd_resources(desc->pt,
+						      &desc->pending);
+			}
+
+			tx_desc = &desc->tx_desc;
+		} else {
+			tx_desc = NULL;
+		}
+
+		spin_lock_irqsave(&chan->lock, flags);
+
+		if (desc) {
+			if (desc->status != DMA_ERROR)
+				desc->status = DMA_COMPLETE;
+
+			dev_dbg(desc->pt->dev,
+				"%s - tx %d complete, status=%u\n", __func__,
+				desc->tx_desc.cookie, desc->status);
+
+			dma_cookie_complete(tx_desc);
+			dma_descriptor_unmap(tx_desc);
+		}
+
+		desc = __pt_next_dma_desc(chan, desc);
+
+		spin_unlock_irqrestore(&chan->lock, flags);
+
+		if (tx_desc) {
+			dmaengine_desc_get_callback_invoke(tx_desc, NULL);
+
+			dma_run_dependencies(tx_desc);
+		}
+	} while (desc);
+
+	return NULL;
+}
+
+static struct pt_dma_desc *__pt_pending_to_active(struct pt_dma_chan *chan)
+{
+	struct pt_dma_desc *desc;
+
+	if (list_empty(&chan->pending))
+		return NULL;
+
+	desc = list_empty(&chan->active)
+		? list_first_entry(&chan->pending, struct pt_dma_desc, entry)
+		: NULL;
+
+	list_splice_tail_init(&chan->pending, &chan->active);
+
+	return desc;
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
+	chan = container_of(desc->tx_desc.chan, struct pt_dma_chan,
+			    dma_chan);
+
+	dev_dbg(chan->pt->dev, "%s - tx %d callback, err=%d\n",
+		__func__, desc->tx_desc.cookie, err);
+
+	if (err)
+		desc->status = DMA_ERROR;
+
+	while (true) {
+		/* Check for DMA descriptor completion */
+		desc = pt_handle_active_desc(chan, desc);
+
+		/* Don't submit cmd if no descriptor or DMA is paused */
+		if (!desc || chan->status == DMA_PAUSED)
+			break;
+
+		ret = pt_issue_next_cmd(desc);
+		if (!ret)
+			break;
+
+		desc->status = DMA_ERROR;
+	}
+
+	tasklet_schedule(&chan->cleanup_tasklet);
+}
+
+static dma_cookie_t pt_tx_submit(struct dma_async_tx_descriptor *tx_desc)
+{
+	struct pt_dma_desc *desc = container_of(tx_desc, struct pt_dma_desc,
+						 tx_desc);
+	struct pt_dma_chan *chan;
+	dma_cookie_t cookie;
+	unsigned long flags;
+
+	chan = container_of(tx_desc->chan, struct pt_dma_chan, dma_chan);
+
+	spin_lock_irqsave(&chan->lock, flags);
+
+	cookie = dma_cookie_assign(tx_desc);
+	list_del(&desc->entry);
+	list_add_tail(&desc->entry, &chan->pending);
+
+	spin_unlock_irqrestore(&chan->lock, flags);
+
+	dev_dbg(chan->pt->dev, "%s - added tx descriptor %d to pending list\n",
+		__func__, cookie);
+
+	return cookie;
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
+	dma_async_tx_descriptor_init(&desc->tx_desc, &chan->dma_chan);
+	desc->tx_desc.flags = flags;
+	desc->tx_desc.tx_submit = pt_tx_submit;
+	desc->pt = chan->pt;
+	INIT_LIST_HEAD(&desc->pending);
+	INIT_LIST_HEAD(&desc->active);
+	desc->status = DMA_IN_PROGRESS;
+
+	return desc;
+}
+
+static struct pt_dma_desc *pt_create_desc(struct dma_chan *dma_chan,
+					  struct scatterlist *dst_sg,
+					    unsigned int dst_nents,
+					    struct scatterlist *src_sg,
+					    unsigned int src_nents,
+					    unsigned long flags)
+{
+	struct pt_dma_chan *chan = container_of(dma_chan, struct pt_dma_chan,
+						 dma_chan);
+	struct pt_device *pt = chan->pt;
+	struct pt_dma_desc *desc;
+	struct pt_dma_cmd *cmd;
+	struct pt_cmd *pt_cmd;
+	struct pt_passthru_engine *pt_engine;
+	unsigned int src_offset, src_len;
+	unsigned int dst_offset, dst_len;
+	unsigned int len;
+	unsigned long sflags;
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
+		list_add_tail(&cmd->entry, &desc->pending);
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
+	if (list_empty(&desc->pending))
+		goto err;
+
+	dev_dbg(pt->dev, "%s - desc=%p\n", __func__, desc);
+
+	spin_lock_irqsave(&chan->lock, sflags);
+
+	list_add_tail(&desc->entry, &chan->created);
+
+	spin_unlock_irqrestore(&chan->lock, sflags);
+
+	return desc;
+
+err:
+	pt_free_cmd_resources(pt, &desc->pending);
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
+						 dma_chan);
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
+	return &desc->tx_desc;
+}
+
+static struct dma_async_tx_descriptor *
+pt_prep_dma_interrupt(struct dma_chan *dma_chan, unsigned long flags)
+{
+	struct pt_dma_chan *chan = container_of(dma_chan, struct pt_dma_chan,
+						 dma_chan);
+	struct pt_dma_desc *desc;
+
+	desc = pt_alloc_dma_desc(chan, flags);
+	if (!desc)
+		return NULL;
+
+	return &desc->tx_desc;
+}
+
+static void pt_issue_pending(struct dma_chan *dma_chan)
+{
+	struct pt_dma_chan *chan = container_of(dma_chan, struct pt_dma_chan,
+						 dma_chan);
+	struct pt_dma_desc *desc;
+	unsigned long flags;
+
+	dev_dbg(chan->pt->dev, "%s\n", __func__);
+
+	spin_lock_irqsave(&chan->lock, flags);
+
+	desc = __pt_pending_to_active(chan);
+
+	spin_unlock_irqrestore(&chan->lock, flags);
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
+						 dma_chan);
+	struct pt_dma_desc *desc;
+	enum dma_status ret;
+	unsigned long flags;
+
+	if (chan->status == DMA_PAUSED) {
+		ret = DMA_PAUSED;
+		goto out;
+	}
+
+	ret = dma_cookie_status(dma_chan, cookie, state);
+	if (ret == DMA_COMPLETE) {
+		spin_lock_irqsave(&chan->lock, flags);
+
+		/* Get status from complete chain, if still there */
+		list_for_each_entry(desc, &chan->complete, entry) {
+			if (desc->tx_desc.cookie != cookie)
+				continue;
+
+			ret = desc->status;
+			break;
+		}
+
+		spin_unlock_irqrestore(&chan->lock, flags);
+	}
+
+out:
+	dev_dbg(chan->pt->dev, "%s - %u\n", __func__, ret);
+
+	return ret;
+}
+
+static int pt_pause(struct dma_chan *dma_chan)
+{
+	struct pt_dma_chan *chan = container_of(dma_chan, struct pt_dma_chan,
+						 dma_chan);
+
+	chan->status = DMA_PAUSED;
+
+	/*TODO: Wait for active DMA to complete before returning? */
+
+	return 0;
+}
+
+static int pt_resume(struct dma_chan *dma_chan)
+{
+	struct pt_dma_chan *chan = container_of(dma_chan, struct pt_dma_chan,
+						 dma_chan);
+	struct pt_dma_desc *desc;
+	unsigned long flags;
+
+	spin_lock_irqsave(&chan->lock, flags);
+
+	desc = list_first_entry_or_null(&chan->active, struct pt_dma_desc,
+					entry);
+
+	spin_unlock_irqrestore(&chan->lock, flags);
+
+	/* Indicate the channel is running again */
+	chan->status = DMA_IN_PROGRESS;
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
+						 dma_chan);
+	unsigned long flags;
+
+	dev_dbg(chan->pt->dev, "%s\n", __func__);
+
+	spin_lock_irqsave(&chan->lock, flags);
+
+	pt_free_desc_resources(chan->pt, &chan->active);
+	pt_free_desc_resources(chan->pt, &chan->pending);
+	pt_free_desc_resources(chan->pt, &chan->created);
+
+	spin_unlock_irqrestore(&chan->lock, flags);
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
+	dma_chan = &chan->dma_chan;
+
+	chan->pt = pt;
+
+	spin_lock_init(&chan->lock);
+	INIT_LIST_HEAD(&chan->created);
+	INIT_LIST_HEAD(&chan->pending);
+	INIT_LIST_HEAD(&chan->active);
+	INIT_LIST_HEAD(&chan->complete);
+
+	tasklet_init(&chan->cleanup_tasklet, pt_do_cleanup,
+		     (unsigned long)chan);
+
+	dma_chan->device = dma_dev;
+	dma_cookie_init(dma_chan);
+
+	list_add_tail(&dma_chan->device_node, &dma_dev->channels);
+
+	dma_dev->device_free_chan_resources = pt_free_chan_resources;
+	dma_dev->device_prep_dma_memcpy = pt_prep_dma_memcpy;
+	dma_dev->device_prep_dma_interrupt = pt_prep_dma_interrupt;
+	dma_dev->device_issue_pending = pt_issue_pending;
+	dma_dev->device_tx_status = pt_tx_status;
+	dma_dev->device_pause = pt_pause;
+	dma_dev->device_resume = pt_resume;
+	dma_dev->device_terminate_all = pt_terminate_all;
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
index 7cd1b0d..943660b 100644
--- a/drivers/dma/ptdma/ptdma.h
+++ b/drivers/dma/ptdma/ptdma.h
@@ -20,6 +20,7 @@
 #include <linux/list.h>
 #include <linux/wait.h>
 #include <linux/dmapool.h>
+#include <linux/dmaengine.h>
 
 #define MAX_PT_NAME_LEN			16
 #define MAX_DMAPOOL_NAME_LEN	32
@@ -177,6 +178,41 @@ struct pt_cmd {
 	void *data;
 };
 
+struct pt_dma_cmd {
+	struct list_head entry;
+	struct pt_cmd pt_cmd;
+};
+
+struct pt_dma_desc {
+	struct list_head entry;
+
+	struct pt_device *pt;
+
+	struct list_head pending;
+	struct list_head active;
+
+	enum dma_status status;
+	struct dma_async_tx_descriptor tx_desc;
+	size_t len;
+};
+
+struct pt_dma_chan {
+	struct pt_device *pt;
+
+	/* channel lock */
+	spinlock_t lock;
+
+	struct list_head created;
+	struct list_head pending;
+	struct list_head active;
+	struct list_head complete;
+
+	struct tasklet_struct cleanup_tasklet;
+
+	enum dma_status status;
+	struct dma_chan dma_chan;
+};
+
 struct pt_cmd_queue {
 	struct pt_device *pt;
 
@@ -246,6 +282,12 @@ struct pt_device {
 	 */
 	struct pt_cmd_queue cmd_q;
 
+	/* Support for the DMA Engine capabilities */
+	struct dma_device dma_dev;
+	struct pt_dma_chan *pt_dma_chan;
+	struct kmem_cache *dma_cmd_cache;
+	struct kmem_cache *dma_desc_cache;
+
 	wait_queue_head_t lsb_queue;
 
 	struct tasklet_struct tasklet;
@@ -312,6 +354,9 @@ struct pt_dev_vdata {
 	const unsigned int version;
 };
 
+int pt_dmaengine_register(struct pt_device *pt);
+void pt_dmaengine_unregister(struct pt_device *pt);
+
 int pt_core_init(struct pt_device *pt);
 void pt_core_destroy(struct pt_device *pt);
 
-- 
2.7.4

