Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52CAE1BCE5F
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2020 23:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgD1VOd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Apr 2020 17:14:33 -0400
Received: from mail-mw2nam10on2077.outbound.protection.outlook.com ([40.107.94.77]:6219
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726753AbgD1VOc (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 28 Apr 2020 17:14:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxHtbHXD5n0h7WIxnkT7BkSqMgNIU7VBAxWQr1v4Kcm+tOO4CF+vl5QnHRkLiDSWekUuSOgXmngrPxRkKDKqwm2FxHe9Wp0LSQTgnCsOv2uMDVDJV7ZQNzrhsT5vz9bSnegQEaEQb/BBDhopZNhmgvnGhhwAdENwgErhIMGyl1mHUQbDdQb+UFvVVlZI3tCIvjjxIfr7hxpI3RZ/+XP9jk0Ua4WCjRW34l5+nn7cS60RIPPyMNadRg/oYhIp62qGvoq5shAipmSHQT2eDn9wSWkTDqFJTlFAY8ilJ222goUnP986cnyzLsSgIhy4zEd8fiHep3C0lqyU2xRqW0pTSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qwBGi8HgYlTa9E3SaRKWcEjus/wkLxnR4GlgtVKBvs=;
 b=iU0A4Z4jUZyWiroar6wJxPF4dwd1vjJmRPBx76kTgSUFJr3ap//Q0go5q6+zmA9uBfiScJTxBPSdvF6MQ3NbeSrYGpAO+H0+UNWi3IXdABuNYqtM5xtWEBo/zK/lYG0C4jdiYia0ouVBvFhfMmfp6t8tlH/8PSI2t1aquBvjWBP2FVBoyZrkjcS87+8WRnv41LcDlwW64MeCwOHRNv3/KvbFhjc35fKcuaUXHaVh46ffqHiMDa/I3jyI/m2UgSILFxZuYSuy1onSiLAWoC0GVZZ9PoRa1lasajRYxbEErlc+CNGUfUbaiyEHqvj3O8sFF5iMs+E2JqZwsaPyFeOiaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qwBGi8HgYlTa9E3SaRKWcEjus/wkLxnR4GlgtVKBvs=;
 b=EfqRCorqUoFBU1bWabelDH/EcS8JGECTkTHVvwKxtKLxyfMqHskRD8BkgQQ4/Y46OiqRvect6VLVtJKolLdsEHV92ceZ38YpDLlmE2Ku8C/DdXZn2X4R69psWwtmeKHSZLtcPg4xAofM3eB1v+dij5l0CU1TXA8r2IkBPx3pduc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3420.namprd12.prod.outlook.com (2603:10b6:5:3a::27) by
 DM6PR12MB4532.namprd12.prod.outlook.com (2603:10b6:5:2af::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.22; Tue, 28 Apr 2020 21:14:26 +0000
Received: from DM6PR12MB3420.namprd12.prod.outlook.com
 ([fe80::7545:386:8328:18a0]) by DM6PR12MB3420.namprd12.prod.outlook.com
 ([fe80::7545:386:8328:18a0%6]) with mapi id 15.20.2958.019; Tue, 28 Apr 2020
 21:14:26 +0000
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     vkoul@kernel.org
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v4 2/3] dmaengine: ptdma: register PTDMA controller as a DMA resource
Date:   Tue, 28 Apr 2020 16:13:35 -0500
Message-Id: <1588108416-49050-3-git-send-email-Sanju.Mehta@amd.com>
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
Received: from sanjuamdntb2.amd.com (165.204.156.251) by MA1PR0101CA0034.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2958.19 via Frontend Transport; Tue, 28 Apr 2020 21:14:22 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2245230a-7c90-4642-765f-08d7ebb9218f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4532:|DM6PR12MB4532:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB453259B2F4912B61FD1DA0B3E5AC0@DM6PR12MB4532.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:108;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3420.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(186003)(30864003)(4326008)(16526019)(6916009)(36756003)(26005)(52116002)(7696005)(2906002)(8936002)(6666004)(5660300002)(66946007)(956004)(66476007)(2616005)(6486002)(66556008)(478600001)(86362001)(316002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O0xkvbof5XUsEsK7UFFYrLR6TvlwgCv2tv8EUlgALxkS1v7BufRUy9wSSuN9cnhcgNJRL2DBmst7yJe1nM2TVLkq66pK9cJ5Vy+v57hxryaKvHPiNnKPSac6NCceDz/6aaJiruZZf34XgdSHdIVOAGcFhd8lz1bVc6azst9gKaxuaw/0/R2OQTgV7evea2jJsyjMEYSLEnEB4kP1xRr8TTO+PQgd7AwkT5s0G2X0VCVcg2FwNi3wr5GbEFVuHX1+1gcede2N/v2p5fXuawDUSA0HM/HOxVQF33aR1WiPcN1ZTjrhdkVLghc9OfI+Dj59w1lnYNvjMv9pU0gP3ZuvkvaegzjJCUfomX47l1/dn4XmBMmhULWi+KCCMtJiNTitSkxg9S46vJ3EVDctzshBd6j1mqnLit8m0HkEdLom0FKRHKZfIzemLLZjkodsfz2a
X-MS-Exchange-AntiSpam-MessageData: LX79/kU6ltV2XPI+KkwJTGJnyKjw5nYJfj1KQfOxx5LFtci9im8UznC8I1RajivePMMtgZKU9xr284GOE8+3msviJEub/dRpnxQ0qNwGcC2WXAwvj0bXBIq2u/B26IXU/xsFUQ6kfyqThBXyy3rfAvUtZLRzhM5SlWHVgbJvymyFtLdF0npbzPOju2Q9VJH3yiNpFoPbwJkchKsr8kbgUjOuStpHo34fiyrW2yvbBrOc8APKt5LlmZy1duSeIIYSwv9ms7T3zAEbkCiH42klDXutISNwliZs+wszleAp9luEJoX05+3mtF1J4brPUA97vLr/rHgkFkNCa4fxeA2bM6XqyN42zf3tQcleP9tKTJONdTLnNKhW9hUDfnjz28K7/zo6AO81ue8Zq9/rAQyegL0b8U6P7D3jIsvuQf+K+3ZLmq6H9LTJX+hq3zYnB2aBTHwNGMFhpXmmcQlbG7iy5047VUluNlFtV6Y6jU4gfOfBnS2YB7lsftRn3DeeCr4mQ3uSNUDUKv12aeN0QdW0mnwXg+kAPD6oaQcj2QyOjvGRcTZQfCXXaLVSGbVDilQp4WuIQufbvQiQNprHTmPAFGEJF7X51KkB5/6b6jOwITk4JaWoAGyTEEB1/uXmkMeha269wcogrG8MElgaKk4d7Ry6Id7npdt/fNxx7CCtExQ+eOMekFd4G2Cw5kZri3IF9bYOjkPNTwhPJJAjHLutx/qzor1Io4kLvY6H+NQMo7Ap+hqT8RFFWroSSr+i2hr4RTQk2b8g2Wh06+jA30McSnlcRvIux5Xvs5+nr6gcqBVlmvsJVNmbFBXfP0S3HQeb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2245230a-7c90-4642-765f-08d7ebb9218f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 21:14:26.4819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jSLX1CQvSYXPM2oiSx/GYkzJ8TlUZQPyPYw9athYfW3yagpb7SGkiqeJrF1LuDiLZR79OZgy69YDBuKCtLlJ3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4532
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
 drivers/dma/ptdma/ptdma-dev.c       |  35 +++
 drivers/dma/ptdma/ptdma-dmaengine.c | 597 ++++++++++++++++++++++++++++++++++++
 drivers/dma/ptdma/ptdma.h           |  38 +++
 5 files changed, 674 insertions(+), 1 deletion(-)
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
index 0a69fd4..14b4339 100644
--- a/drivers/dma/ptdma/ptdma-dev.c
+++ b/drivers/dma/ptdma/ptdma-dev.c
@@ -234,6 +234,8 @@ static irqreturn_t pt_core_irq_handler(int irq, void *data)
 
 	pt_core_enable_queue_interrupts(pt);
 
+	tasklet_schedule(&pt->tasklet);
+
 	return IRQ_HANDLED;
 }
 
@@ -252,6 +254,26 @@ static void pt_init_cmdq_regs(struct pt_cmd_queue *cmd_q)
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
@@ -353,8 +375,18 @@ int pt_core_init(struct pt_device *pt)
 
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
 
@@ -370,6 +402,9 @@ void pt_core_destroy(struct pt_device *pt)
 	struct pt_cmd_queue *cmd_q = &pt->cmd_q;
 	struct pt_cmd *cmd;
 
+	/* Unregister the DMA engine */
+	pt_dmaengine_unregister(pt);
+
 	/* Remove this device from the list of available units first */
 	pt_del_device(pt);
 
diff --git a/drivers/dma/ptdma/ptdma-dmaengine.c b/drivers/dma/ptdma/ptdma-dmaengine.c
new file mode 100644
index 0000000..2b0d739
--- /dev/null
+++ b/drivers/dma/ptdma/ptdma-dmaengine.c
@@ -0,0 +1,597 @@
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
+	pt_free_cmd_resources(pt, &desc->active);
+	pt_free_cmd_resources(pt, &desc->pending);
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
+	cmd = list_first_entry(&desc->pending, struct pt_dma_cmd, entry);
+	list_move(&cmd->entry, &desc->active);
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
+	struct pt_dma_cmd *cmd;
+
+	cmd = list_first_entry_or_null(&desc->active, struct pt_dma_cmd,
+				       entry);
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
+			if (!list_empty(&desc->pending)) {
+				/* No errors, keep going */
+				if (desc->status != DMA_ERROR)
+					return desc;
+				/* Error, free remaining commands and move on */
+				pt_free_cmd_resources(desc->pt,
+						      &desc->pending);
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
+		if (!desc || chan->status == DMA_PAUSED)
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
+	if (chan->status == DMA_IN_PROGRESS) {
+		chan->status = DMA_PAUSED;
+		pt_stop_queue(&chan->pt->cmd_q);
+	}
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
+	if (chan->status == DMA_PAUSED) {
+		/* Indicate the channel is running again */
+		chan->status = DMA_IN_PROGRESS;
+		pt_start_queue(&chan->pt->cmd_q);
+		desc = __pt_next_dma_desc(chan);
+	}
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
index 5b21162..a807f4c 100644
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
@@ -178,6 +181,32 @@ struct pt_cmd {
 	void *data;
 };
 
+struct pt_dma_cmd {
+	struct list_head entry;
+	struct pt_cmd pt_cmd;
+};
+
+struct pt_dma_desc {
+	struct virt_dma_desc vd;
+
+	struct pt_device *pt;
+
+	struct list_head pending;
+	struct list_head active;
+
+	enum dma_status status;
+
+	size_t len;
+};
+
+struct pt_dma_chan {
+	struct virt_dma_chan vc;
+
+	struct pt_device *pt;
+
+	enum dma_status status;
+};
+
 struct pt_cmd_queue {
 	struct pt_device *pt;
 
@@ -246,6 +275,12 @@ struct pt_device {
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
@@ -312,6 +347,9 @@ struct pt_dev_vdata {
 	const unsigned int version;
 };
 
+int pt_dmaengine_register(struct pt_device *pt);
+void pt_dmaengine_unregister(struct pt_device *pt);
+
 int pt_core_init(struct pt_device *pt);
 void pt_core_destroy(struct pt_device *pt);
 
-- 
2.7.4

