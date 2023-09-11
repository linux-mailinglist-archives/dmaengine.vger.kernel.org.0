Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1163E79C008
	for <lists+dmaengine@lfdr.de>; Tue, 12 Sep 2023 02:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239232AbjIKWmv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Sep 2023 18:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244168AbjIKTZy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Sep 2023 15:25:54 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC4C10F;
        Mon, 11 Sep 2023 12:25:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpO6FscBAB8z+Ygx5fHCJ9z4aUbuXFE3v5Ed4cRajPdOYHq4CsmlIShQKR/j6YIn1lHUdsWtqVtMpf6cAYhpepqfumkV0PTKEN1xNaYFPGBcaDDYQ2G4hbj5MLQrpaME/Hw2mQAuBWWSk9wASG6QCiQ1F9VsHQX3sOwRY6LFs3JCalEiX5F7H8YrMiijULXbs30UAiQty1Gziv1D0oVsU3cU036EYptpSE9ve7KnOpWayMYJIvl5izSb+pdzbjbJoSPil1nwhvOqlXdc7D4ggMTZ3N02Yjh3XIv/KzV0AC7ljhNVBQMKiXBbW3ZvyZKIcIIeGaQrCeBN9hS7n3v6nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiEijFcBFYR3casefxj/3fzYDHFS55Fw/QCEClmIpzk=;
 b=dmXrO0pzqcOi9mwg8WI6CXp6eZW0cxWP3oc6hlPZtkuOatK3+Tg10u9NS1zIho0HJIlxqn8RbVAKa5n0YWyko6bHsXy084GAkIFISjqIo7TqkDa6DKgCuOVfchj/X0CpTVDpO57C2sQOhS8lDJSaKeGa4+rkDArmp99/DwzuZ3Dn/ioNDkRd3cUEzCVZbN0+Hn4URXlOurYz+UzijNVqe2qE+VXUKNq/Mz8awVLbS+OFhWs0FDZ15cP2GRclEnYK5JN5ufrfbDlRPrQOsc2ZosI9RxseaLd7utR3uUCPTewVrJDEiSEP0ozPkmzQoykYCPw80v8zOLXyACj9ogQM3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiEijFcBFYR3casefxj/3fzYDHFS55Fw/QCEClmIpzk=;
 b=O4yggG4Igk4Fq507M7hiLP3bGDPy2qy7qtuzs0AOsJGnFKZcW//tQuDdylhugK6GXis7syOvYJJ2y7Nu79vpeg0IDaNhLRz9ExNqt6gzxo1qFNmU2Jjk3UhZMGuszAFPXBnRtIu4ibHxyvSOi+py5iQLLkcHRKUas8B/MTDOGDg=
Received: from CH0P223CA0016.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::34)
 by PH0PR12MB8775.namprd12.prod.outlook.com (2603:10b6:510:28e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.33; Mon, 11 Sep
 2023 19:25:46 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::f8) by CH0P223CA0016.outlook.office365.com
 (2603:10b6:610:116::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34 via Frontend
 Transport; Mon, 11 Sep 2023 19:25:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.11 via Frontend Transport; Mon, 11 Sep 2023 19:25:45 +0000
Received: from sanjuamdntb2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 14:25:42 -0500
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     <vkoul@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <dan.j.williams@intel.com>,
        <robh@kernel.org>, <mchehab+samsung@kernel.org>,
        <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH 2/3] dmaengine: ae4dma: register AE4DMA controller as a DMA resource
Date:   Mon, 11 Sep 2023 14:25:23 -0500
Message-ID: <1694460324-60346-3-git-send-email-Sanju.Mehta@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|PH0PR12MB8775:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b96d959-8956-4b09-839c-08dbb2fce5c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gg4OdQ0lJ9iUH894mREMtiiqUvyF798KuPW0D0bN0o55cVBoH1VmBh6teekFMv1MWrTfgy6AhQhnnJcJzj62pC1WBAiwdswL/Ykzlqs7Zs9cQwDRlekbYZEPfc0wxo1jwVupoNWA7hNrtJw4K8zUniYqU7LE+M7QcCKL+QVzl0Ua92l7ij8TbbVbjnk7YIYfuimnHaL8n43unSXtaH1u1FGbC0l7AOn/oFooXDcCGdQym1HSgmrYuxqNfERUwTHbKIDiKsVEirsjomM+jmaMYbwVW3VMI0eG8no/cAUEFB/q0nomuCoC6232gsKM/lycWXrNehuzxhV+w3zqxNEwtR/4MaCMWxoJRRxfINmAQhbq5bMFtOuxAOJ3hK05L3Y3Aehr/vNRgR1UhBe4WYE5+LDD1eapVXAGkk/FarqGsrSDQjsGW2lB8AHkWHGynZL6dmxqS8aTWxZXH8Ll72byURYPKZzGJiv8AF8bGnhB2SyCH3NgkZLD/icnAwPWzu1htlJRyTt4s0ThA9dfGFmEsg3GWxVpTjXNar5wESxDtHDBmA/sDAtA69l4e7Jja2he6HuuVMaOaoSbxSIoTafADtQmLVMtRtocMF3YgJByqInx+Yrtac89K2V1gnrOL+xjWu8aOeHMtwtvqE3ttOGKUXrT+09ceiS6ibIYMXKlvqi7jbsPso8ibEeLZyv8crOwM33Dxv52Jg+XW8N4N1Kdz+pbalO4zCllnFD6iEBUAh4B8EgdFE0He65U+OiS7iz5P7583GFXksuY7kcZSjr6hoJMcEklQigeyDtGHaQHpKk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(186009)(451199024)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(41300700001)(6916009)(316002)(16526019)(40480700001)(26005)(336012)(426003)(8936002)(2906002)(8676002)(70206006)(30864003)(4326008)(70586007)(54906003)(5660300002)(478600001)(6666004)(66899024)(40460700003)(7696005)(36756003)(36860700001)(47076005)(2616005)(83380400001)(86362001)(81166007)(82740400003)(356005)(32563001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 19:25:45.8286
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b96d959-8956-4b09-839c-08dbb2fce5c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8775
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

Register ae4dma queue's to Linux dmaengine framework as general-purpose
DMA channels.

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 drivers/dma/ae4dma/Kconfig            |   2 +
 drivers/dma/ae4dma/Makefile           |   2 +-
 drivers/dma/ae4dma/ae4dma-dev.c       |  17 ++
 drivers/dma/ae4dma/ae4dma-dmaengine.c | 425 ++++++++++++++++++++++++++++++++++
 drivers/dma/ae4dma/ae4dma.h           |  28 +++
 5 files changed, 473 insertions(+), 1 deletion(-)
 create mode 100644 drivers/dma/ae4dma/ae4dma-dmaengine.c

diff --git a/drivers/dma/ae4dma/Kconfig b/drivers/dma/ae4dma/Kconfig
index 1cda9de..3d1dbb7 100644
--- a/drivers/dma/ae4dma/Kconfig
+++ b/drivers/dma/ae4dma/Kconfig
@@ -2,6 +2,8 @@
 config AMD_AE4DMA
 	tristate  "AMD AE4DMA Engine"
 	depends on X86_64 && PCI
+	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
 	help
 	  Enabling this option provides support for the AMD AE4DMA controller,
 	  which offers DMA capabilities for high-bandwidth memory-to-memory and
diff --git a/drivers/dma/ae4dma/Makefile b/drivers/dma/ae4dma/Makefile
index db9cab1..b1e4318 100644
--- a/drivers/dma/ae4dma/Makefile
+++ b/drivers/dma/ae4dma/Makefile
@@ -5,6 +5,6 @@
 
 obj-$(CONFIG_AMD_AE4DMA) += ae4dma.o
 
-ae4dma-objs := ae4dma-dev.o
+ae4dma-objs := ae4dma-dev.o ae4dma-dmaengine.o
 
 ae4dma-$(CONFIG_PCI) += ae4dma-pci.o
diff --git a/drivers/dma/ae4dma/ae4dma-dev.c b/drivers/dma/ae4dma/ae4dma-dev.c
index a3c50a2..af7e510 100644
--- a/drivers/dma/ae4dma/ae4dma-dev.c
+++ b/drivers/dma/ae4dma/ae4dma-dev.c
@@ -25,6 +25,11 @@ static unsigned int max_hw_q = 1;
 module_param(max_hw_q, uint, 0444);
 MODULE_PARM_DESC(max_hw_q, "Max queues per engine (any non-zero value less than or equal to 16, default: 1)");
 
+static inline struct ae4_dma_chan *to_ae4_chan(struct dma_chan *dma_chan)
+{
+	return container_of(dma_chan, struct ae4_dma_chan, vc.chan);
+}
+
 /* Human-readable error strings */
 static char *ae4_error_codes[] = {
 	"",
@@ -273,8 +278,17 @@ int ae4_core_init(struct ae4_device *ae4)
 		tasklet_setup(&cmd_q->irq_tasklet, ae4_do_cmd_complete);
 	}
 
+	/* register to the DMA engine */
+	ret = ae4_dmaengine_register(ae4);
+	if (ret)
+		goto e_free_irq;
+
 	return 0;
 
+e_free_irq:
+	for (i = 0; i < ae4->cmd_q_count; i++)
+		free_irq(ae4->ae4_irq[i], ae4);
+
 e_free_dma:
 	dma_free_coherent(dev, cmd_q->qsize, cmd_q->qbase, cmd_q->qbase_dma);
 
@@ -292,6 +306,9 @@ void ae4_core_destroy(struct ae4_device *ae4)
 	struct ae4_cmd *cmd;
 	unsigned int i;
 
+	/* Unregister the DMA engine */
+	ae4_dmaengine_unregister(ae4);
+
 	for (i = 0; i < ae4->cmd_q_count; i++) {
 		cmd_q = &ae4->cmd_q[i];
 
diff --git a/drivers/dma/ae4dma/ae4dma-dmaengine.c b/drivers/dma/ae4dma/ae4dma-dmaengine.c
new file mode 100644
index 0000000..a50e4f5
--- /dev/null
+++ b/drivers/dma/ae4dma/ae4dma-dmaengine.c
@@ -0,0 +1,425 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AMD AE4DMA device driver
+ * -- Based on the PTDMA driver
+ *
+ * Copyright (C) 2023 Advanced Micro Devices, Inc.
+ *
+ * Author: Sanjay R Mehta <sanju.mehta@amd.com>
+ */
+#include <linux/delay.h>
+#include "ae4dma.h"
+#include "../dmaengine.h"
+#include "../virt-dma.h"
+
+static inline struct ae4_dma_chan *to_ae4_chan(struct dma_chan *dma_chan)
+{
+	return container_of(dma_chan, struct ae4_dma_chan, vc.chan);
+}
+
+static inline struct ae4_dma_desc *to_ae4_desc(struct virt_dma_desc *vd)
+{
+	return container_of(vd, struct ae4_dma_desc, vd);
+}
+
+static void ae4_free_chan_resources(struct dma_chan *dma_chan)
+{
+	struct ae4_dma_chan *chan = to_ae4_chan(dma_chan);
+
+	vchan_free_chan_resources(&chan->vc);
+}
+
+static void ae4_synchronize(struct dma_chan *dma_chan)
+{
+	struct ae4_dma_chan *chan = to_ae4_chan(dma_chan);
+
+	vchan_synchronize(&chan->vc);
+}
+
+static void ae4_do_cleanup(struct virt_dma_desc *vd)
+{
+	struct ae4_dma_desc *desc = to_ae4_desc(vd);
+	struct ae4_device *ae4 = desc->ae4;
+
+	kmem_cache_free(ae4->dma_desc_cache, desc);
+}
+
+static int ae4_dma_start_desc(struct ae4_dma_desc *desc, struct ae4_dma_chan *chan)
+{
+	struct ae4_passthru_engine *ae4_engine;
+	struct ae4_device *ae4;
+	struct ae4_cmd *ae4_cmd;
+	struct ae4_cmd_queue *cmd_q;
+
+	desc->issued_to_hw = 1;
+	list_del(&desc->vd.node);
+
+	ae4_cmd = &desc->ae4_cmd;
+	ae4 = ae4_cmd->ae4;
+	cmd_q = chan->cmd_q;
+	ae4_engine = &ae4_cmd->passthru;
+
+	ae4_cmd->qid = cmd_q->qidx;
+	cmd_q->tdata.cmd = ae4_cmd;
+
+	/* Execute the command */
+	ae4_cmd->ret = ae4_core_perform_passthru(cmd_q, ae4_engine);
+
+	return 0;
+}
+
+static struct ae4_dma_desc *ae4_next_dma_desc(struct ae4_dma_chan *chan)
+{
+	/* Get the next DMA descriptor on the active list */
+	struct virt_dma_desc *vd = vchan_next_desc(&chan->vc);
+
+	return vd ? to_ae4_desc(vd) : NULL;
+}
+
+static void ae4_cmd_callback_tasklet(void *data, int err)
+{
+	struct ae4_dma_desc *desc = data;
+	struct dma_chan *dma_chan;
+	struct ae4_dma_chan *chan;
+	struct dma_async_tx_descriptor *tx_desc;
+	struct virt_dma_desc *vd;
+	unsigned long flags;
+
+	dma_chan = desc->vd.tx.chan;
+	chan = to_ae4_chan(dma_chan);
+
+	if (err == -EINPROGRESS)
+		return;
+
+	tx_desc = &desc->vd.tx;
+	vd = &desc->vd;
+
+	if (err)
+		desc->status = DMA_ERROR;
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+	if (desc) {
+		if (desc->status != DMA_COMPLETE) {
+			if (desc->status != DMA_ERROR)
+				desc->status = DMA_COMPLETE;
+
+			dma_cookie_complete(tx_desc);
+			dma_descriptor_unmap(tx_desc);
+		} else {
+			/* Don't handle it twice */
+			tx_desc = NULL;
+		}
+	}
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+
+	if (tx_desc) {
+		dmaengine_desc_get_callback_invoke(tx_desc, NULL);
+		dma_run_dependencies(tx_desc);
+	}
+}
+
+static struct ae4_dma_desc *ae4_handle_active_desc(struct ae4_dma_chan *chan,
+						   struct ae4_dma_desc *desc)
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
+			tx_desc = &desc->vd.tx;
+			vd = &desc->vd;
+		} else {
+			tx_desc = NULL;
+		}
+		spin_lock_irqsave(&chan->vc.lock, flags);
+		desc = ae4_next_dma_desc(chan);
+		spin_unlock_irqrestore(&chan->vc.lock, flags);
+	} while (desc);
+
+	return NULL;
+}
+
+static void ae4_cmd_callback(void *data, int err)
+{
+	struct ae4_dma_desc *desc = data;
+	struct dma_chan *dma_chan;
+	struct ae4_dma_chan *chan;
+	struct ae4_device *ae4;
+	int ret;
+
+	if (err == -EINPROGRESS)
+		return;
+
+	dma_chan = desc->vd.tx.chan;
+	chan = to_ae4_chan(dma_chan);
+	ae4 = chan->ae4;
+
+	if (err)
+		desc->status = DMA_ERROR;
+
+	while (true) {
+		/* Check for DMA descriptor completion */
+		desc = ae4_handle_active_desc(chan, desc);
+
+		/* Don't submit cmd if no descriptor or DMA is paused */
+		if (!desc)
+			break;
+
+		/* if queue is full dont submit to queue */
+		if (ae4_core_queue_full(ae4, chan->cmd_q)) {
+			usleep_range(100, 200);
+			continue;
+		}
+
+		ret = ae4_dma_start_desc(desc, chan);
+		if (!ret)
+			break;
+
+		desc->status = DMA_ERROR;
+	}
+}
+
+static struct ae4_dma_desc *ae4_alloc_dma_desc(struct ae4_dma_chan *chan, unsigned long flags)
+{
+	struct ae4_dma_desc *desc;
+	struct ae4_cmd_queue *cmd_q = chan->cmd_q;
+
+	desc = kmem_cache_zalloc(chan->ae4->dma_desc_cache, GFP_NOWAIT);
+	if (!desc)
+		return NULL;
+
+	vchan_tx_prep(&chan->vc, &desc->vd, flags);
+
+	desc->ae4 = chan->ae4;
+	cmd_q->int_en = !!(flags & DMA_PREP_INTERRUPT);
+	desc->issued_to_hw = 0;
+	desc->status = DMA_IN_PROGRESS;
+
+	return desc;
+}
+
+static struct ae4_dma_desc *ae4_create_desc(struct dma_chan *dma_chan,
+					    dma_addr_t dst,
+					    dma_addr_t src,
+					    unsigned int len,
+					    unsigned long flags)
+{
+	struct ae4_dma_chan *chan = to_ae4_chan(dma_chan);
+	struct ae4_cmd_queue *cmd_q = chan->cmd_q;
+	struct ae4_passthru_engine *ae4_engine;
+	struct ae4_dma_desc *desc;
+	struct ae4_cmd *ae4_cmd;
+
+	desc = ae4_alloc_dma_desc(chan, flags);
+	if (!desc)
+		return NULL;
+
+	ae4_cmd = &desc->ae4_cmd;
+	ae4_cmd->ae4 = chan->ae4;
+	ae4_engine = &ae4_cmd->passthru;
+	ae4_cmd->engine = AE4_ENGINE_PASSTHRU;
+	ae4_engine->src_dma = src;
+	ae4_engine->dst_dma = dst;
+	ae4_engine->src_len = len;
+	ae4_cmd->ae4_cmd_callback = ae4_cmd_callback_tasklet;
+	ae4_cmd->data = desc;
+
+	desc->len = len;
+
+	spin_lock_irqsave(&cmd_q->cmd_lock, flags);
+	list_add_tail(&ae4_cmd->entry, &cmd_q->cmd);
+	spin_unlock_irqrestore(&cmd_q->cmd_lock, flags);
+
+	return desc;
+}
+
+static struct dma_async_tx_descriptor *
+ae4_prep_dma_memcpy(struct dma_chan *dma_chan, dma_addr_t dst,
+		    dma_addr_t src, size_t len, unsigned long flags)
+{
+	struct ae4_dma_desc *desc;
+
+	desc = ae4_create_desc(dma_chan, dst, src, len, flags);
+	if (!desc)
+		return NULL;
+
+	return &desc->vd.tx;
+}
+
+static struct dma_async_tx_descriptor *
+ae4_prep_dma_interrupt(struct dma_chan *dma_chan, unsigned long flags)
+{
+	struct ae4_dma_chan *chan = to_ae4_chan(dma_chan);
+	struct ae4_dma_desc *desc;
+
+	desc = ae4_alloc_dma_desc(chan, flags);
+	if (!desc)
+		return NULL;
+
+	return &desc->vd.tx;
+}
+
+static void ae4_issue_pending(struct dma_chan *dma_chan)
+{
+	struct ae4_dma_chan *chan = to_ae4_chan(dma_chan);
+	struct ae4_dma_desc *desc;
+	unsigned long flags;
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+	vchan_issue_pending(&chan->vc);
+	desc = ae4_next_dma_desc(chan);
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+
+	ae4_cmd_callback(desc, 0);
+}
+
+static int ae4_pause(struct dma_chan *dma_chan)
+{
+	struct ae4_dma_chan *chan = to_ae4_chan(dma_chan);
+	unsigned long flags;
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+	//TODO : implemnt pause
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+
+	return 0;
+}
+
+static int ae4_resume(struct dma_chan *dma_chan)
+{
+	struct ae4_dma_chan *chan = to_ae4_chan(dma_chan);
+	struct ae4_dma_desc *desc = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+	ae4_start_queue(chan->cmd_q);
+	desc = ae4_next_dma_desc(chan);
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+
+	/* If there was something active, re-start */
+	if (desc)
+		ae4_cmd_callback(desc, 0);
+
+	return 0;
+}
+
+static int ae4_terminate_all(struct dma_chan *dma_chan)
+{
+	struct ae4_dma_chan *chan = to_ae4_chan(dma_chan);
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
+int ae4_dmaengine_register(struct ae4_device *ae4)
+{
+	struct ae4_dma_chan *chan;
+	struct ae4_cmd_queue *cmd_q;
+	struct dma_device *dma_dev = &ae4->dma_dev;
+	char *cmd_cache_name;
+	char *desc_cache_name;
+	unsigned int i;
+	int ret;
+
+	ae4->ae4_dma_chan = devm_kcalloc(ae4->dev, ae4->cmd_q_count,
+					 sizeof(*ae4->ae4_dma_chan), GFP_KERNEL);
+	if (!ae4->ae4_dma_chan)
+		return -ENOMEM;
+
+	cmd_cache_name = devm_kasprintf(ae4->dev, GFP_KERNEL,
+					"%s-dmaengine-cmd-cache",
+					dev_name(ae4->dev));
+	if (!cmd_cache_name)
+		return -ENOMEM;
+
+	desc_cache_name = devm_kasprintf(ae4->dev, GFP_KERNEL,
+					 "%s-dmaengine-desc-cache",
+					 dev_name(ae4->dev));
+	if (!desc_cache_name) {
+		ret = -ENOMEM;
+		goto err_cache;
+	}
+
+	ae4->dma_desc_cache = kmem_cache_create(desc_cache_name,
+						sizeof(struct ae4_dma_desc), 0,
+						SLAB_HWCACHE_ALIGN, NULL);
+	if (!ae4->dma_desc_cache) {
+		ret = -ENOMEM;
+		goto err_cache;
+	}
+
+	dma_dev->dev = ae4->dev;
+	dma_dev->src_addr_widths = DMA_SLAVE_BUSWIDTH_64_BYTES;
+	dma_dev->dst_addr_widths = DMA_SLAVE_BUSWIDTH_64_BYTES;
+	dma_dev->directions = DMA_MEM_TO_MEM;
+	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
+	dma_cap_set(DMA_MEMCPY, dma_dev->cap_mask);
+	dma_cap_set(DMA_INTERRUPT, dma_dev->cap_mask);
+
+	/*
+	 * AE4DMA is intended to be used with the AMD NTB devices, hence
+	 * marking it as DMA_PRIVATE.
+	 */
+	dma_cap_set(DMA_PRIVATE, dma_dev->cap_mask);
+
+	/* Set base and prep routines */
+	dma_dev->device_free_chan_resources = ae4_free_chan_resources;
+	dma_dev->device_prep_dma_memcpy = ae4_prep_dma_memcpy;
+	dma_dev->device_prep_dma_interrupt = ae4_prep_dma_interrupt;
+	dma_dev->device_issue_pending = ae4_issue_pending;
+	dma_dev->device_tx_status = dma_cookie_status;
+	dma_dev->device_pause = ae4_pause;
+	dma_dev->device_resume = ae4_resume;
+	dma_dev->device_terminate_all = ae4_terminate_all;
+	dma_dev->device_synchronize = ae4_synchronize;
+
+	INIT_LIST_HEAD(&dma_dev->channels);
+	for (i = 0; i < ae4->cmd_q_count; i++) {
+		chan = ae4->ae4_dma_chan + i;
+		cmd_q = &ae4->cmd_q[i];
+		chan->cmd_q = cmd_q;
+		chan->id = cmd_q->id;
+		chan->ae4 = ae4;
+		chan->vc.desc_free = ae4_do_cleanup;
+		vchan_init(&chan->vc, dma_dev);
+	}
+
+	dma_set_mask_and_coherent(ae4->dev, DMA_BIT_MASK(64));
+
+	ret = dma_async_device_register(dma_dev);
+	if (ret)
+		goto err_reg;
+
+	return 0;
+
+err_reg:
+	kmem_cache_destroy(ae4->dma_desc_cache);
+
+err_cache:
+	kmem_cache_destroy(ae4->dma_cmd_cache);
+
+	return ret;
+}
+
+void ae4_dmaengine_unregister(struct ae4_device *ae4)
+{
+	struct dma_device *dma_dev = &ae4->dma_dev;
+
+	dma_async_device_unregister(dma_dev);
+	kmem_cache_destroy(ae4->dma_cmd_cache);
+}
diff --git a/drivers/dma/ae4dma/ae4dma.h b/drivers/dma/ae4dma/ae4dma.h
index 0ae46ee..d341c35 100644
--- a/drivers/dma/ae4dma/ae4dma.h
+++ b/drivers/dma/ae4dma/ae4dma.h
@@ -11,6 +11,7 @@
 #define __AE4_DEV_H__
 
 #include <linux/device.h>
+#include <linux/dmaengine.h>
 #include <linux/pci.h>
 #include <linux/spinlock.h>
 #include <linux/mutex.h>
@@ -18,6 +19,8 @@
 #include <linux/wait.h>
 #include <linux/dmapool.h>
 
+#include "../virt-dma.h"
+
 #define MAX_AE4_NAME_LEN			16
 #define MAX_DMAPOOL_NAME_LEN		32
 
@@ -168,6 +171,22 @@ struct ae4_cmd {
 	u8 qid;
 };
 
+struct ae4_dma_desc {
+	struct virt_dma_desc vd;
+	struct ae4_device *ae4;
+	enum dma_status status;
+	size_t len;
+	bool issued_to_hw;
+	struct ae4_cmd ae4_cmd;
+};
+
+struct ae4_dma_chan {
+	struct virt_dma_chan vc;
+	struct ae4_device *ae4;
+	struct ae4_cmd_queue *cmd_q;
+	u32 id;
+};
+
 struct ae4_cmd_queue {
 	struct ae4_device *ae4;
 
@@ -248,6 +267,12 @@ struct ae4_device {
 	struct ae4_cmd_queue cmd_q[MAX_HW_QUEUES];
 	unsigned int cmd_q_count;
 
+	/* Support for the DMA Engine capabilities */
+	struct dma_device dma_dev;
+	struct ae4_dma_chan *ae4_dma_chan;
+	struct kmem_cache *dma_cmd_cache;
+	struct kmem_cache *dma_desc_cache;
+
 	wait_queue_head_t lsb_queue;
 };
 
@@ -298,6 +323,9 @@ struct ae4_dev_vdata {
 	const unsigned int bar;
 };
 
+int ae4_dmaengine_register(struct ae4_device *ae4);
+void ae4_dmaengine_unregister(struct ae4_device *ae4);
+
 int ae4_core_init(struct ae4_device *ae4);
 void ae4_core_destroy(struct ae4_device *ae4);
 
-- 
2.7.4

