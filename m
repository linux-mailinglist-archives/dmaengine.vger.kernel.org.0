Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918E03ADF69
	for <lists+dmaengine@lfdr.de>; Sun, 20 Jun 2021 18:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhFTQo3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 20 Jun 2021 12:44:29 -0400
Received: from mail-bn8nam12on2045.outbound.protection.outlook.com ([40.107.237.45]:54433
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230051AbhFTQoZ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 20 Jun 2021 12:44:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oEXUHCdzdPnWnwB5tz27063ajevFJdumI34eY08SWwF/bNc1b1FSVMXgswBL9J123/lG2b6sp0YyhMfaWS6+TyKvLYETEtT473KwdGRWWjwu8UZQekX1MU89bZ/vdPOeiSxxqfrEbMjILQifcOVOUbEireQbWZ/SmSg7/L5w+AbTtdcWj/X0lNnxiWKNs3weN62FdbqXrDWsUYB2pV609BFpclooOq3KS3bQbq5ziIGq0y9fejm2K1BhE+Mdzsjz2K5HJOLC8joQu2nKMOZhkiLT5X1BzBZxOAUYjnNJsv/Mx/zxxQppTun05v5vKdLu3yif9Zzx+QWCTGAyab6hSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bOuM5cx/8rFgNsUviNjvvaehzcY+lryzLWXeaCZx/Y=;
 b=KXrSW4rDDzFBgDXevVZlW5DcKYwlOxlGtPSGkzQ8Booc5x7rONxkQATkypsdVApncWlv566up/u4r6zeOLx68jFWEkfURIRTlWuVHs971bgFmpN0Co17M1W8UV7GQyU+rTg/LApDRkT8sc55cciuMjaUZqVsnuPpS5I8npYCZSYVBCdVPRLxmmbt1k+RJXCo2C4ptmsNkvQENVLTQdU1OgUcVNlyzW/KS9TX4/m1YYCHGbXPTaFdn6lTJUaHCVEQsgMmPDW51EdW86VA5Un2oPuZblzUC7O0IGDJRBBoxHJQ51nJj9FREv7raden5GI9kuUc7J+NdikyWLu/Rka21g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bOuM5cx/8rFgNsUviNjvvaehzcY+lryzLWXeaCZx/Y=;
 b=Smp4NLa99rC7x60GfiwC38fixX3py34VBLcsKz3Aw4km4WiOTFqczJe07FLhA0GnVIDEEdZTvoV6nHqI0Hb6Y66NxTVVg4raONBoUiZI2by20qSNNPBaI7Cik99jr6KXHMbS5+KDU66dlJXxdSd9bnPduaa65uRQIpkBzOdTTDU=
Received: from BN0PR04CA0006.namprd04.prod.outlook.com (2603:10b6:408:ee::11)
 by DM5PR12MB1418.namprd12.prod.outlook.com (2603:10b6:3:7a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Sun, 20 Jun
 2021 16:42:07 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::5c) by BN0PR04CA0006.outlook.office365.com
 (2603:10b6:408:ee::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21 via Frontend
 Transport; Sun, 20 Jun 2021 16:42:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Sun, 20 Jun 2021 16:42:07 +0000
Received: from sanjuamdntb2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 20 Jun
 2021 11:42:03 -0500
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     <vkoul@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <dan.j.williams@intel.com>,
        <Thomas.Lendacky@amd.com>, <Shyam-sundar.S-k@amd.com>,
        <Nehal-bakulchandra.Shah@amd.com>, <robh@kernel.org>,
        <mchehab+samsung@kernel.org>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v10 2/3] dmaengine: ptdma: register PTDMA controller as a DMA resource
Date:   Sun, 20 Jun 2021 11:41:37 -0500
Message-ID: <1624207298-115928-3-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1624207298-115928-1-git-send-email-Sanju.Mehta@amd.com>
References: <1624207298-115928-1-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcedd112-323b-4960-de59-08d9340a57b5
X-MS-TrafficTypeDiagnostic: DM5PR12MB1418:
X-Microsoft-Antispam-PRVS: <DM5PR12MB14180D862C7D5D6BC241E883E50B9@DM5PR12MB1418.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:98;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cCJdQ4dCMbtRi5lZvvQZh1IN6AGM49xmDGvnRf+RB3SQp1IjB0HPQGS9rqaSb+1TIoGsEAaz9FY727oTGGCudnIX1JeQSnA6w34dR9lN6xv54PeUQ+ycDnCn+mCiu4HfTaosUJ7aZxZAPhpO2W36N790pld3deWH+8jhxZxjOq8pBZ5ybRzgTJxwyZ2aj1lR6TRLFb84RtPZ+tGRpV+A9r0AMSfOc1V2MMq9+QAZEp/3fIB32TfnSUb0i91elvFKIPOllfVDrNsSIRK0ZtJghjTHrNgGnKNpmeQyQVNUCgYb4l4IYSKDqXiSMcyyVNb+62fnzQB9sBVidBMTUUF8TprCul4nbQ4zHddHc2oj/0Ta4lHTlx7yOiSO46BRZHzRZcTB8JoRjpK4BayNoK5a+fHf42/IkMl3bK0NuyF4sptaC6X/Dwgzg7qK6aM/QZc8TpaMhI1M9ZDZV8nUrULxjAzo7vLe8Aq8g/cpQM5sNp+bJ6W7v7bH/k92x+Z+hGXxYgi1zhfhjYQVUF0K2sOhvNzLKtz6umCbNjxlkE5AQRJqJB44OfWcs4VWOWrR5h5d1FHVLl4FW0BHHJNk6TK+AreA6rvol1IZ5QQuOAZCtsqvf2Cf6YbVAV7XHQGw6YGgm47DQNIKJ0MHO+YS1nA4UhC2F+OA86E5n01HkjhCZIR//Y2730uivIpiBDAwzC7v
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(36840700001)(46966006)(316002)(5660300002)(2616005)(82740400003)(2906002)(30864003)(70586007)(70206006)(4326008)(478600001)(54906003)(36860700001)(356005)(186003)(6916009)(7696005)(81166007)(8676002)(82310400003)(36756003)(336012)(426003)(6666004)(16526019)(26005)(83380400001)(8936002)(47076005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2021 16:42:07.4960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcedd112-323b-4960-de59-08d9340a57b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1418
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

Register ptdma queue to Linux dmaengine framework as general-purpose
DMA channels.

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 drivers/dma/ptdma/Kconfig           |   2 +
 drivers/dma/ptdma/Makefile          |   2 +-
 drivers/dma/ptdma/ptdma-dev.c       |  32 +++
 drivers/dma/ptdma/ptdma-dmaengine.c | 389 ++++++++++++++++++++++++++++++++++++
 drivers/dma/ptdma/ptdma.h           |  26 +++
 5 files changed, 450 insertions(+), 1 deletion(-)
 create mode 100644 drivers/dma/ptdma/ptdma-dmaengine.c

diff --git a/drivers/dma/ptdma/Kconfig b/drivers/dma/ptdma/Kconfig
index e6b8ca1..b430edd 100644
--- a/drivers/dma/ptdma/Kconfig
+++ b/drivers/dma/ptdma/Kconfig
@@ -2,6 +2,8 @@
 config AMD_PTDMA
 	tristate  "AMD PassThru DMA Engine"
 	depends on X86_64 && PCI
+	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
 	help
 	  Enable support for the AMD PTDMA controller. This controller
 	  provides DMA capabilities to perform high bandwidth memory to
diff --git a/drivers/dma/ptdma/Makefile b/drivers/dma/ptdma/Makefile
index 320fa82..a528cb0 100644
--- a/drivers/dma/ptdma/Makefile
+++ b/drivers/dma/ptdma/Makefile
@@ -5,6 +5,6 @@
 
 obj-$(CONFIG_AMD_PTDMA) += ptdma.o
 
-ptdma-objs := ptdma-dev.o
+ptdma-objs := ptdma-dev.o ptdma-dmaengine.o
 
 ptdma-$(CONFIG_PCI) += ptdma-pci.o
diff --git a/drivers/dma/ptdma/ptdma-dev.c b/drivers/dma/ptdma/ptdma-dev.c
index 4f9ae0b..c1323ed 100644
--- a/drivers/dma/ptdma/ptdma-dev.c
+++ b/drivers/dma/ptdma/ptdma-dev.c
@@ -123,6 +123,26 @@ static inline void pt_core_enable_queue_interrupts(struct pt_device *pt)
 	iowrite32(SUPPORTED_INTERRUPTS, pt->cmd_q.reg_int_enable);
 }
 
+static void pt_do_cmd_complete(unsigned long data)
+{
+	struct pt_tasklet_data *tdata = (struct pt_tasklet_data *)data;
+	struct pt_cmd *cmd = tdata->cmd;
+	struct pt_cmd_queue *cmd_q = &cmd->pt->cmd_q;
+	u32 tail;
+
+	if (cmd_q->cmd_error) {
+	       /*
+		* Log the error and flush the queue by
+		* moving the head pointer
+		*/
+		tail = lower_32_bits(cmd_q->qdma_tail + cmd_q->qidx * Q_DESC_SIZE);
+		pt_log_error(cmd_q->pt, cmd_q->cmd_error);
+		iowrite32(tail, cmd_q->reg_head_lo);
+	}
+
+	cmd->pt_cmd_callback(cmd->data, cmd->ret);
+}
+
 static irqreturn_t pt_core_irq_handler(int irq, void *data)
 {
 	struct pt_device *pt = data;
@@ -149,6 +169,7 @@ static irqreturn_t pt_core_irq_handler(int irq, void *data)
 	}
 
 	pt_core_enable_queue_interrupts(pt);
+	pt_do_cmd_complete((ulong)&pt->tdata);
 
 	return err ? IRQ_HANDLED : IRQ_NONE;
 }
@@ -246,8 +267,16 @@ int pt_core_init(struct pt_device *pt)
 
 	pt_core_enable_queue_interrupts(pt);
 
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
 
@@ -264,6 +293,9 @@ void pt_core_destroy(struct pt_device *pt)
 	struct pt_cmd_queue *cmd_q = &pt->cmd_q;
 	struct pt_cmd *cmd;
 
+	/* Unregister the DMA engine */
+	pt_dmaengine_unregister(pt);
+
 	/* Disable and clear interrupts */
 	pt_core_disable_queue_interrupts(pt);
 
diff --git a/drivers/dma/ptdma/ptdma-dmaengine.c b/drivers/dma/ptdma/ptdma-dmaengine.c
new file mode 100644
index 0000000..45392a3
--- /dev/null
+++ b/drivers/dma/ptdma/ptdma-dmaengine.c
@@ -0,0 +1,389 @@
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
+#include "ptdma.h"
+#include "../dmaengine.h"
+#include "../virt-dma.h"
+
+static inline struct pt_dma_chan *to_pt_chan(struct dma_chan *dma_chan)
+{
+	return container_of(dma_chan, struct pt_dma_chan, vc.chan);
+}
+
+static inline struct pt_dma_desc *to_pt_desc(struct virt_dma_desc *vd)
+{
+	return container_of(vd, struct pt_dma_desc, vd);
+}
+
+static void pt_free_chan_resources(struct dma_chan *dma_chan)
+{
+	struct pt_dma_chan *chan = to_pt_chan(dma_chan);
+
+	vchan_free_chan_resources(&chan->vc);
+}
+
+static void pt_synchronize(struct dma_chan *dma_chan)
+{
+	struct pt_dma_chan *chan = to_pt_chan(dma_chan);
+
+	vchan_synchronize(&chan->vc);
+}
+
+static void pt_do_cleanup(struct virt_dma_desc *vd)
+{
+	struct pt_dma_desc *desc = to_pt_desc(vd);
+	struct pt_device *pt = desc->pt;
+
+	kmem_cache_free(pt->dma_desc_cache, desc);
+}
+
+static int pt_dma_start_desc(struct pt_dma_desc *desc)
+{
+	struct pt_passthru_engine *pt_engine;
+	struct pt_device *pt;
+	struct pt_cmd *pt_cmd;
+	struct pt_cmd_queue *cmd_q;
+
+	desc->issued_to_hw = 1;
+
+	pt_cmd = &desc->pt_cmd;
+	pt = pt_cmd->pt;
+	cmd_q = &pt->cmd_q;
+	pt_engine = &pt_cmd->passthru;
+
+	pt->tdata.cmd = pt_cmd;
+
+	/* Execute the command */
+	pt_cmd->ret = pt_core_perform_passthru(cmd_q, pt_engine);
+
+	return 0;
+}
+
+static struct pt_dma_desc *pt_next_dma_desc(struct pt_dma_chan *chan)
+{
+	/* Get the next DMA descriptor on the active list */
+	struct virt_dma_desc *vd = vchan_next_desc(&chan->vc);
+
+	return vd ? to_pt_desc(vd) : NULL;
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
+			if (!desc->issued_to_hw) {
+				/* No errors, keep going */
+				if (desc->status != DMA_ERROR)
+					return desc;
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
+	struct dma_chan *dma_chan;
+	struct pt_dma_chan *chan;
+	int ret;
+
+	if (err == -EINPROGRESS)
+		return;
+
+	dma_chan = desc->vd.tx.chan;
+	chan = to_pt_chan(dma_chan);
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
+		ret = pt_dma_start_desc(desc);
+		if (!ret)
+			break;
+
+		desc->status = DMA_ERROR;
+	}
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
+	desc->issued_to_hw = 0;
+	desc->status = DMA_IN_PROGRESS;
+
+	return desc;
+}
+
+static struct pt_dma_desc *pt_create_desc(struct dma_chan *dma_chan,
+					  dma_addr_t dst,
+					  dma_addr_t src,
+					  unsigned int len,
+					  unsigned long flags)
+{
+	struct pt_dma_chan *chan = to_pt_chan(dma_chan);
+	struct pt_passthru_engine *pt_engine;
+	struct pt_dma_desc *desc;
+	struct pt_cmd *pt_cmd;
+
+	desc = pt_alloc_dma_desc(chan, flags);
+	if (!desc)
+		return NULL;
+
+	pt_cmd = &desc->pt_cmd;
+	pt_cmd->pt = chan->pt;
+	pt_engine = &pt_cmd->passthru;
+	pt_cmd->engine = PT_ENGINE_PASSTHRU;
+	pt_engine->src_dma = src;
+	pt_engine->dst_dma = dst;
+	pt_engine->src_len = len;
+	pt_cmd->pt_cmd_callback = pt_cmd_callback;
+	pt_cmd->data = desc;
+
+	desc->len = len;
+
+	return desc;
+}
+
+static struct dma_async_tx_descriptor *
+pt_prep_dma_memcpy(struct dma_chan *dma_chan, dma_addr_t dst,
+		   dma_addr_t src, size_t len, unsigned long flags)
+{
+	struct pt_dma_desc *desc;
+
+	desc = pt_create_desc(dma_chan, dst, src, len, flags);
+	if (!desc)
+		return NULL;
+
+	return &desc->vd.tx;
+}
+
+static struct dma_async_tx_descriptor *
+pt_prep_dma_interrupt(struct dma_chan *dma_chan, unsigned long flags)
+{
+	struct pt_dma_chan *chan = to_pt_chan(dma_chan);
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
+	struct pt_dma_chan *chan = to_pt_chan(dma_chan);
+	struct pt_dma_desc *desc;
+	unsigned long flags;
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+
+	vchan_issue_pending(&chan->vc);
+
+	desc = pt_next_dma_desc(chan);
+
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+
+	/* If there was nothing active, start processing */
+	if (desc)
+		pt_cmd_callback(desc, 0);
+}
+
+static int pt_pause(struct dma_chan *dma_chan)
+{
+	struct pt_dma_chan *chan = to_pt_chan(dma_chan);
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
+	struct pt_dma_chan *chan = to_pt_chan(dma_chan);
+	struct pt_dma_desc *desc = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+	pt_start_queue(&chan->pt->cmd_q);
+	desc = pt_next_dma_desc(chan);
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
+	struct pt_dma_chan *chan = to_pt_chan(dma_chan);
+	unsigned long flags;
+	LIST_HEAD(head);
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+	vchan_get_all_descriptors(&chan->vc, &head);
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+
+	vchan_dma_desc_free_list(&chan->vc, &head);
+	vchan_free_chan_resources(&chan->vc);
+
+	return 0;
+}
+
+int pt_dmaengine_register(struct pt_device *pt)
+{
+	struct pt_dma_chan *chan;
+	struct dma_device *dma_dev = &pt->dma_dev;
+	char *cmd_cache_name;
+	char *desc_cache_name;
+	int ret;
+
+	pt->pt_dma_chan = devm_kzalloc(pt->dev, sizeof(*pt->pt_dma_chan),
+				       GFP_KERNEL);
+	if (!pt->pt_dma_chan)
+		return -ENOMEM;
+
+	cmd_cache_name = devm_kasprintf(pt->dev, GFP_KERNEL,
+					"%s-dmaengine-cmd-cache",
+					pt->name);
+	if (!cmd_cache_name)
+		return -ENOMEM;
+
+	desc_cache_name = devm_kasprintf(pt->dev, GFP_KERNEL,
+					 "%s-dmaengine-desc-cache",
+					 pt->name);
+	if (!desc_cache_name) {
+		ret = -ENOMEM;
+		goto err_cache;
+	}
+
+	pt->dma_desc_cache = kmem_cache_create(desc_cache_name,
+					       sizeof(struct pt_dma_desc), 0,
+					       SLAB_HWCACHE_ALIGN, NULL);
+	if (!pt->dma_desc_cache) {
+		ret = -ENOMEM;
+		goto err_cache;
+	}
+
+	dma_dev->dev = pt->dev;
+	dma_dev->src_addr_widths = DMA_SLAVE_BUSWIDTH_64_BYTES;
+	dma_dev->dst_addr_widths = DMA_SLAVE_BUSWIDTH_64_BYTES;
+	dma_dev->directions = DMA_MEM_TO_MEM;
+	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
+	dma_cap_set(DMA_MEMCPY, dma_dev->cap_mask);
+	dma_cap_set(DMA_INTERRUPT, dma_dev->cap_mask);
+
+	/*
+	 * PTDMA is intended to be used with the AMD NTB devices, hence
+	 * marking it as DMA_PRIVATE.
+	 */
+	dma_cap_set(DMA_PRIVATE, dma_dev->cap_mask);
+
+	INIT_LIST_HEAD(&dma_dev->channels);
+
+	chan = pt->pt_dma_chan;
+	chan->pt = pt;
+
+	/* Set base and prep routines */
+	dma_dev->device_free_chan_resources = pt_free_chan_resources;
+	dma_dev->device_prep_dma_memcpy = pt_prep_dma_memcpy;
+	dma_dev->device_prep_dma_interrupt = pt_prep_dma_interrupt;
+	dma_dev->device_issue_pending = pt_issue_pending;
+	dma_dev->device_tx_status = dma_cookie_status;
+	dma_dev->device_pause = pt_pause;
+	dma_dev->device_resume = pt_resume;
+	dma_dev->device_terminate_all = pt_terminate_all;
+	dma_dev->device_synchronize = pt_synchronize;
+
+	chan->vc.desc_free = pt_do_cleanup;
+	vchan_init(&chan->vc, dma_dev);
+
+	dma_set_mask_and_coherent(pt->dev, DMA_BIT_MASK(64));
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
index f8082c9..9627585 100644
--- a/drivers/dma/ptdma/ptdma.h
+++ b/drivers/dma/ptdma/ptdma.h
@@ -14,6 +14,7 @@
 #define __PT_DEV_H__
 
 #include <linux/device.h>
+#include <linux/dmaengine.h>
 #include <linux/pci.h>
 #include <linux/spinlock.h>
 #include <linux/mutex.h>
@@ -21,6 +22,8 @@
 #include <linux/wait.h>
 #include <linux/dmapool.h>
 
+#include "../virt-dma.h"
+
 #define MAX_PT_NAME_LEN			16
 #define MAX_DMAPOOL_NAME_LEN		32
 
@@ -170,6 +173,20 @@ struct pt_cmd {
 	void *data;
 };
 
+struct pt_dma_desc {
+	struct virt_dma_desc vd;
+	struct pt_device *pt;
+	enum dma_status status;
+	size_t len;
+	bool issued_to_hw;
+	struct pt_cmd pt_cmd;
+};
+
+struct pt_dma_chan {
+	struct virt_dma_chan vc;
+	struct pt_device *pt;
+};
+
 struct pt_cmd_queue {
 	struct pt_device *pt;
 
@@ -238,6 +255,12 @@ struct pt_device {
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
@@ -290,6 +313,9 @@ struct pt_dev_vdata {
 	const unsigned int bar;
 };
 
+int pt_dmaengine_register(struct pt_device *pt);
+void pt_dmaengine_unregister(struct pt_device *pt);
+
 int pt_core_init(struct pt_device *pt);
 void pt_core_destroy(struct pt_device *pt);
 
-- 
2.7.4

