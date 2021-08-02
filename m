Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D2D3DD3B9
	for <lists+dmaengine@lfdr.de>; Mon,  2 Aug 2021 12:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbhHBKdn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Aug 2021 06:33:43 -0400
Received: from mail-dm3nam07on2087.outbound.protection.outlook.com ([40.107.95.87]:52128
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233175AbhHBKdm (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 2 Aug 2021 06:33:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRyLMevwL+JgdS0uxIqsSq0Yrjm3yzm5CTXWOwjhUCc+Q21ukYb1Y/OYhZZU8lv8YkgLkq7S7W1ykODrXlcqTbVhMfD4YUydcVqd+8cBD5hlTwJ0ZNQFTB2PsZM65drAtngq2DRQL331Ty/5VaODkkfT81qQHb5DtBcUD77nGh/bp+egZHX27Iv/t2Vbenu80Y2TIxuVunqFDt1rGYRxIBunx8I/8lTKk10CSlMllZ1l+AmF++M5vMR5qxiLtJNDqFwd42/lHpNwKdQzNxwrUI4D7XzHMHb29TM/He4Y5hZ0XD7tdxRJOdoWB/f5MeCegquicRkGNsWingt5ISkbTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtcOJIGqcO/W0EDEHY9IF5yLrZ/mvY8U7t3xiPb8q6M=;
 b=BiYPmYhbCbYI2uf3Pn4px4x594i4ki2FSRdXirKlf/Kw8ddIRfgTVQ3TlDKaDXqcEJa/bXoZWA9f1lYtt64KsTBHSbgw6UdXW56MecLbEQqYjLXcVDm9Y8RyBVZFKZeWbo6a+wBnKovAdjmamt5GpzjQDzvIb0yo3VPXeql8pZxQjNoxupYz1NYTgSlQiMAodMB3yjyoPpJuazvLgI1plVI6wnkzXHkrUbm4dAsvLk5p1wKM8BQ86spPeW1SMr0X9QkoNBzeZLae5TcAJFR4j8hclwd+/tiiKjSyeiq6SSO56ti+6Qk532p2m4/hBAV2YVkxDIOJL57eXhsGOKUbsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtcOJIGqcO/W0EDEHY9IF5yLrZ/mvY8U7t3xiPb8q6M=;
 b=4ugpAY4tixNhbK0nfx+tWh5AaOH3K8ZbckZZi5XrIHtoJRnEsxv3RhbZZCV2K4pdAOufz2Z+RI9GiKXzr97Zn8jrb0UeNjA2n3Ye5q0jMDkQ2k5uhj/DelLVRbodyNcOSR+TtXAa1vnyTAzPXBW9HTvU9VR43qTmCj7vKZcOugk=
Received: from BN6PR14CA0022.namprd14.prod.outlook.com (2603:10b6:404:79::32)
 by DM5PR1201MB0043.namprd12.prod.outlook.com (2603:10b6:4:57::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.25; Mon, 2 Aug
 2021 10:33:30 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:79:cafe::42) by BN6PR14CA0022.outlook.office365.com
 (2603:10b6:404:79::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17 via Frontend
 Transport; Mon, 2 Aug 2021 10:33:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Mon, 2 Aug 2021 10:33:30 +0000
Received: from sanjuamdntb2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 2 Aug
 2021 05:33:25 -0500
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     <vkoul@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <dan.j.williams@intel.com>,
        <Thomas.Lendacky@amd.com>, <Shyam-sundar.S-k@amd.com>,
        <Nehal-bakulchandra.Shah@amd.com>, <robh@kernel.org>,
        <mchehab+samsung@kernel.org>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v11 2/3] dmaengine: ptdma: register PTDMA controller as a DMA resource
Date:   Mon, 2 Aug 2021 05:32:54 -0500
Message-ID: <1627900375-80812-3-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1627900375-80812-1-git-send-email-Sanju.Mehta@amd.com>
References: <1627900375-80812-1-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 332fa53a-09c4-4eb0-c084-08d955a0f8af
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0043:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB004302F7FF3E88B740535EA6E5EF9@DM5PR1201MB0043.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:98;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qcQWwEfqcdel/s+WOHDKfhzcMlrBJiafgfYUKeTuPdtcB8NeGaaOzdcGuRptufZjG36zcrVBa4tBhyK0dgSNmReoRvzUEwWOUg6ZLcvf5CpsgcQ4HRaJUuIkfyuUYZiZ2kJiwcPPe88IEIH6a2f3kzWxLUgAKHfeXP8vOLnijDfvRAkasgFv9wG2MQ73aIDb6ntYR1uvmcIkGxNvS3P9pA4OrL+BCfmuEofl8zZRpTWGjmfIGuEdVUlwK1iKS2bQuhOxqTZ86P2rbbzcwfh418DI+DFPjuQfrU2sL/n9/JSG417ob+IdJavqqMBBmw5hELPjkH2fwWo5a/+YoxhQQ37pLhSa7l2oTr/vRkTkjFlGP1yaayUSAUI6Lb/7ryRsamSqwtFy/zOoWakuwPWYXZV6qmSnU3Cc2zqbPt7TzgBlwyHDQzanFoRPSrB6eg55CTtZisN9g8o4T6IILdFMyHUJLTpQPnVy6mRnA3GoYU1Z9p18SW17//X13WkKcNwBIXjAODV9IMViYJVuaNJWHq+ni4CbivpNL7JuEFjlGeXtRZLeouqvtbWUlPrAHx0pXo/6k+zAlWDHx9UP7EAwLfn0EWvjZ3vitcGeo2HbFj+eC2MmfDeDf0JV9uj2/1ItK4/nvPko2QZx/k3RUiDG5fpfSvW9OKqMsbnX8siTt77DqtnkX2UHv7vjg6GzJWY+ulO5dVyywGGLr7XIXCEn0Gwtmu2FGg2vK/r0IzUtxJk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(36840700001)(46966006)(186003)(356005)(81166007)(16526019)(26005)(478600001)(336012)(82740400003)(83380400001)(6666004)(8676002)(7696005)(4326008)(8936002)(36756003)(5660300002)(47076005)(86362001)(30864003)(82310400003)(6916009)(2616005)(426003)(54906003)(316002)(70206006)(70586007)(36860700001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 10:33:30.4602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 332fa53a-09c4-4eb0-c084-08d955a0f8af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0043
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
 drivers/dma/ptdma/ptdma-dmaengine.c | 389 ++++++++++++++++++++++++++++++++++++
 drivers/dma/ptdma/ptdma.h           |  26 +++
 4 files changed, 418 insertions(+), 1 deletion(-)
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
diff --git a/drivers/dma/ptdma/ptdma-dmaengine.c b/drivers/dma/ptdma/ptdma-dmaengine.c
new file mode 100644
index 0000000..c9e52f6
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
+					dev_name(pt->dev));
+	if (!cmd_cache_name)
+		return -ENOMEM;
+
+	desc_cache_name = devm_kasprintf(pt->dev, GFP_KERNEL,
+					 "%s-dmaengine-desc-cache",
+					 dev_name(pt->dev));
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
index f195b15..1329c55 100644
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
 
@@ -229,6 +246,12 @@ struct pt_device {
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
@@ -281,6 +304,9 @@ struct pt_dev_vdata {
 	const unsigned int bar;
 };
 
+int pt_dmaengine_register(struct pt_device *pt);
+void pt_dmaengine_unregister(struct pt_device *pt);
+
 int pt_core_init(struct pt_device *pt);
 void pt_core_destroy(struct pt_device *pt);
 
-- 
2.7.4

