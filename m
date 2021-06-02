Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510B039918F
	for <lists+dmaengine@lfdr.de>; Wed,  2 Jun 2021 19:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbhFBRYt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 2 Jun 2021 13:24:49 -0400
Received: from mail-mw2nam10on2066.outbound.protection.outlook.com ([40.107.94.66]:27009
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230520AbhFBRYo (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 2 Jun 2021 13:24:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQ+rDutItmmjmanB9t0lwcrzkFi5ARk9JjAkCCwsd/6vqyeNW1AR0hR5ym35WrsJdDsU7JVMkEZH6KSFHqwm0nPVvr1eMx2K4AEP4wzurlFcEvKnRTbel+tqceVpnNWdSpnZ9+bXBqbbdNrlDStudTsKM2PqUj8wQkApPe0s2bHIZGUOvMp/4j/rCkBUUJdHUDQ4HvnGSxoPoZgBAdOf2YyhMiTAde2HW+EIzhgC2MDT1F/m9/3HT/EX23iYJigQ3/PcRpKnsXpqnbg6woUTlwynZVnQQ8Z+i+ftHbuiTNWLFYX1aVr+oQxSFxKcI3fmDzOXsoLN/dw10VCiJr4Jkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMGVJWkh5lYg4vN39XmZvOm0+gmamBewrCL5VFH9piU=;
 b=S1yK8W8C98rFjjPub1Q0pRKBGU/Dp845T/Xc3s5E6om2HnzSGRgZ6cYrXQ97SBBt466cp1RKVfWwAQLAeI90L5MznVMZusMY3su4wPdd4RQ06uTIi+B9mWofqbqYgu+Msk79nMKhHkto649PB6nmN50CfhztD+/KnYbz1EaWHkYKkSlGENvQArAFuBmn4ATC21sHemLXBfOBgbyWkBl9CUyLy++tYFbVxEL6B2gm9DjFNijv2UR8xV42hzLFbYL3rHXllNFBQ2M87tvJGX+ds4fkpXxnKRmYhA+4c88MLh5vtBQS01X/1lNoj5HhAxLnh5OCjimje4YvCyhuXh166w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=amd.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMGVJWkh5lYg4vN39XmZvOm0+gmamBewrCL5VFH9piU=;
 b=Xzr9B1BLuhQhT89y9Cz9XPt5gaS3ybh/wkGArpFkQ9DPlNf2BlrqSU012bQNpZFIV6pEF0N4KC4jHE2J42qxpfis+iCmXKwKV2dCT9K9EzWHkZJORpgrpGYSCHjEpnTXL1lNVLPh7/skxg9pQf+/W3Gg10/lg3BSMq8KYFhzuyA=
Received: from BN9PR03CA0243.namprd03.prod.outlook.com (2603:10b6:408:ff::8)
 by CH0PR12MB5154.namprd12.prod.outlook.com (2603:10b6:610:b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Wed, 2 Jun
 2021 17:23:00 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::97) by BN9PR03CA0243.outlook.office365.com
 (2603:10b6:408:ff::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend
 Transport; Wed, 2 Jun 2021 17:23:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Wed, 2 Jun 2021 17:22:59 +0000
Received: from sanjuamdntb2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 2 Jun 2021
 12:22:55 -0500
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     <vkoul@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <dan.j.williams@intel.com>,
        <Thomas.Lendacky@amd.com>, <Shyam-sundar.S-k@amd.com>,
        <Nehal-bakulchandra.Shah@amd.com>, <robh@kernel.org>,
        <mchehab+samsung@kernel.org>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v9 2/3] dmaengine: ptdma: register PTDMA controller as a DMA resource
Date:   Wed, 2 Jun 2021 12:22:30 -0500
Message-ID: <1622654551-9204-3-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622654551-9204-1-git-send-email-Sanju.Mehta@amd.com>
References: <1622654551-9204-1-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbf37f9e-fad3-4e89-250b-08d925eb1209
X-MS-TrafficTypeDiagnostic: CH0PR12MB5154:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5154C936687263C460499D6DE53D9@CH0PR12MB5154.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:154;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /3p40MZQRqomdkb6ragbnd45OTGhDUbHxqn28c5haEPm+g4NqaImI6H6ZVMQluRIoIBExY0AO01W21flOyzSnxb09nA/f/YBZlK9BLDwvDNG8sIh9/TwzgivtsnVFGtvp8kV+UvPNc+aCqNTnNixd6+l5vvFGOb1N6P2xa26GzxFStftYbs1Lv84ckX0vbbnW6NJargWFf8Vh5M06oBeLYlvhdnQqdMlH5T/EYPbPUJxefoJ8P0636FV/x+w9/SxUc/GffsWjxlq+11dKxssM9QAV97rQ5u8Ih4s+0VaPORKyP9u/4AQyIJR1LJPajA7p0o+NyQta5RlpUUvecLraTvGpif5Q/pQxNTFMI5w9nCLMMv2KUvi3uXGz7nHX1y9EMZQU/ifYmAvCwfe0mMjQ90fiX3UZxVLnTNrG1vTHCeyFM18KfYkgAdf9kZ808OjfowCzNL3Veo/ocw9nB3tV8KnBC97EHqBgR3TxfW7l+BXNjRp26SdQWP1wd+jCT1NnDmRIBClf3wp/gXGGfbvfFu52EzlGMEOjKSnASWKrC/BVOLNeq4Xl5zYDaiP+5cgITEKUqsZxSkuc5MvodKD2NkzxZY1HKz6uqpwcC8NPMvQP81gwHQ0X241dqssfsVKoybqiB9AanJXRhNkrJZCarzcQlgyiQvzw+RBEjLvZp8xlLjCojwmHKVAEHsEAMBA
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(39850400004)(136003)(376002)(346002)(46966006)(36840700001)(70206006)(36756003)(26005)(6916009)(70586007)(81166007)(356005)(5660300002)(30864003)(86362001)(2616005)(7696005)(54906003)(82740400003)(8676002)(426003)(36860700001)(8936002)(478600001)(336012)(186003)(47076005)(83380400001)(6666004)(16526019)(2906002)(316002)(82310400003)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 17:22:59.9337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf37f9e-fad3-4e89-250b-08d925eb1209
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5154
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
 drivers/dma/ptdma/ptdma-dmaengine.c | 460 ++++++++++++++++++++++++++++++++++++
 drivers/dma/ptdma/ptdma.h           |  31 +++
 5 files changed, 526 insertions(+), 1 deletion(-)
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
index 4617550..7122933 100644
--- a/drivers/dma/ptdma/ptdma-dev.c
+++ b/drivers/dma/ptdma/ptdma-dev.c
@@ -124,6 +124,26 @@ static inline void pt_core_enable_queue_interrupts(struct pt_device *pt)
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
 	struct pt_device *pt = data;
@@ -147,6 +167,7 @@ static irqreturn_t pt_core_irq_handler(int irq, void *data)
 	}
 
 	pt_core_enable_queue_interrupts(pt);
+	pt_do_cmd_complete((ulong)&pt->tdata);
 
 	return IRQ_HANDLED;
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
index 0000000..c67a1ab
--- /dev/null
+++ b/drivers/dma/ptdma/ptdma-dmaengine.c
@@ -0,0 +1,460 @@
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
+	desc->issued_to_hw = 1;
+
+	pt_cmd = &cmd->pt_cmd;
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
+static void pt_free_active_cmd(struct pt_dma_desc *desc)
+{
+	struct pt_dma_cmd *cmd = NULL;
+
+	if (desc->issued_to_hw)
+		cmd = list_first_entry_or_null(&desc->cmdlist, struct pt_dma_cmd,
+					       entry);
+	if (!cmd)
+		return;
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
+	return vd ? to_pt_desc(vd) : NULL;
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
+			/* Remove the DMA command from the list and free it */
+			pt_free_active_cmd(desc);
+			if (!desc->issued_to_hw) {
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
+	desc->issued_to_hw = 0;
+	INIT_LIST_HEAD(&desc->cmdlist);
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
+	struct pt_device *pt = chan->pt;
+	struct pt_dma_desc *desc;
+	struct pt_dma_cmd *cmd;
+	struct pt_cmd *pt_cmd;
+
+	desc = pt_alloc_dma_desc(chan, flags);
+	if (!desc)
+		return NULL;
+
+	cmd = pt_alloc_dma_cmd(chan);
+	if (!cmd)
+		goto err;
+
+	pt_cmd = &cmd->pt_cmd;
+	pt_cmd->pt = chan->pt;
+	pt_engine = &pt_cmd->passthru;
+	pt_cmd->engine = PT_ENGINE_PASSTHRU;
+	pt_engine->src_dma = src;
+	pt_engine->dst_dma = dst;
+	pt_engine->src_len = len;
+	pt_cmd->pt_cmd_callback = pt_cmd_callback;
+	pt_cmd->data = desc;
+
+	list_add_tail(&cmd->entry, &desc->cmdlist);
+
+	desc->len = len;
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
+	desc = __pt_next_dma_desc(chan);
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
+	struct pt_dma_chan *chan = to_pt_chan(dma_chan);
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
+	pt->dma_cmd_cache = kmem_cache_create(cmd_cache_name,
+					      sizeof(struct pt_dma_cmd),
+					      sizeof(void *),
+					      SLAB_HWCACHE_ALIGN, NULL);
+	if (!pt->dma_cmd_cache)
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
+					       sizeof(struct pt_dma_desc),
+					       sizeof(void *),
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
index a89a74ac..bc6676d 100644
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
 
@@ -173,6 +176,25 @@ struct pt_cmd {
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
+	bool issued_to_hw;
+};
+
+struct pt_dma_chan {
+	struct virt_dma_chan vc;
+	struct pt_device *pt;
+};
+
 struct pt_cmd_queue {
 	struct pt_device *pt;
 
@@ -241,6 +263,12 @@ struct pt_device {
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
@@ -293,6 +321,9 @@ struct pt_dev_vdata {
 	const unsigned int bar;
 };
 
+int pt_dmaengine_register(struct pt_device *pt);
+void pt_dmaengine_unregister(struct pt_device *pt);
+
 int pt_core_init(struct pt_device *pt);
 void pt_core_destroy(struct pt_device *pt);
 
-- 
2.7.4

