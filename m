Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89CA3343816
	for <lists+dmaengine@lfdr.de>; Mon, 22 Mar 2021 06:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhCVFAf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Mar 2021 01:00:35 -0400
Received: from mail-dm6nam12on2040.outbound.protection.outlook.com ([40.107.243.40]:57313
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229771AbhCVFAI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Mar 2021 01:00:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLGl11J4uWirafbjNBQytZAzFV7JvYPi3oMczGMi66ZA7IlPuO36WuT1FrTkkF2MVIzlPLgaxBDZ3YbchLytEfJzCcwivzdH7PwR2dfVWV8E2owEJHuy4YWutNXMIm6Jk/Q4cFTY3KgazbXo45Bzx/cwThL1SSgtss7QTZ/+o2a0HLuconFbx7UPLWD5+62aLxxbAc3aD/sPme1Nhgan1Go2laJnY7oHZJwiZHRUbucRD5jz0fUbk+lIPGyO5K0ANQjv7ARyVSkcSFN5YtERjIohL5SG3MWlNtlay1cFoipYfInyuLITJx1h/VxT+s8lFF9UL5ijPREXGVK1npK7eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DloJOnupBj3tufQ+HWX2PWEtaAOU2bnlSI177FMrdq4=;
 b=Of/SAfdCEUP+QscLBu1E7az/UbDkWLthPw2pzBGUoqqlrpeyAVOHHucdIMAGrCLahijrGs+us3oDmRgsPSdSvstJ0l8fW7DlGQg1DTA6jZcYbih6w+SlXKN/bZru0QudBTxrjJBeS76HrSKciiK0IpzpV6CDNECn/LoM4PIdwzxLbTkyq0yQD4uVPapLNS9Qfe/bhY6xkfsfXgYzaqPvOT8I6p4bCAzE/bB0OL92+MGiVpE/l3mm49+Tw0nz2VZzaxWa+g+0IgWY7vPv1p7gpNfm8D8lvhYTRV2r8ZRWQJ91j48jNTqo2vnijEOk7e+SbXDz5bmWyotEK0hppPUPjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DloJOnupBj3tufQ+HWX2PWEtaAOU2bnlSI177FMrdq4=;
 b=gMw/NTajdbll6o8/POZFfSLoRVLgqqV+IHKATjgQb69YO/fiWgQ0NbghiO7S3iftnC365uYNZlbo4Aljka63uLPA4fiRv9IJlGt008NDDlWqyx5AGpvQaAfe6hcAw1/5GtFsCxhu28XQIECcX/OlzRzndM21b0456IFstjuyWo4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB2549.namprd12.prod.outlook.com (10.172.121.10) by
 CY4PR1201MB0040.namprd12.prod.outlook.com (10.172.77.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18; Mon, 22 Mar 2021 05:00:06 +0000
Received: from CY4PR1201MB2549.namprd12.prod.outlook.com
 ([fe80::e974:eaaf:2994:ccb6]) by CY4PR1201MB2549.namprd12.prod.outlook.com
 ([fe80::e974:eaaf:2994:ccb6%4]) with mapi id 15.20.3955.025; Mon, 22 Mar 2021
 05:00:06 +0000
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     vkoul@kernel.org
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v8 2/3] dmaengine: ptdma: register PTDMA controller as a DMA resource
Date:   Sun, 21 Mar 2021 23:59:31 -0500
Message-Id: <1616389172-6825-3-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616389172-6825-1-git-send-email-Sanju.Mehta@amd.com>
References: <1616389172-6825-1-git-send-email-Sanju.Mehta@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MA1PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::13) To CY4PR1201MB2549.namprd12.prod.outlook.com
 (2603:10b6:903:da::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sanjuamdntb2.amd.com (165.204.156.251) by MA1PR01CA0143.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 05:00:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b391ed20-dd6d-415a-0fe7-08d8ecef5beb
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0040:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB00404FA6A77CEFF50943580BE5659@CY4PR1201MB0040.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:154;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rWMW+tZrBb9x9XAQ2E9IUhv8NzjqQTpTRKBCzxg0Bg9pbW0VXSn3joe+RtHDUEumqNy8980ADJg7JI/lO8tzLi0FBTtUBJxHvASxCvYDWoNDOwBhVtr5+7+RUrjYABqvQcu17UCU5aR7IejiRmEsy3eNhF46+HGuf3xvXYC5pkoaL1zXvZzXCbP8H08jLHlT/ukiQimQNsttr0TnsEfyp0Ec0pGf2C4n+SwWnwQoI6W5e9lw3Lg4DrcX096zYUvX6wXDgI7YtO20u49f+ftcdDtc1ZbAqi6ejtXGZiWqY3g2zdqcNVFL+ULrUV7+DjH9xkvTIkUOLcDsxJgqA2vHepUgwHmk0pB7x5/uJkAoD59Ue1Hc1TNfcBzH94Rx3nFBChnQfl7OPfosH3c1HIQChiECIoQRubxkW4wI3BOdPLFLEMe1/EeEK+gsqzuVaRDMraklIUZ6o1OuXq+DqOmpsnC/w4JeYAPjLyyLe+O1k4BemTBEWC5q+eKrMSsnohK9WeUSMhVhJft0XhRBhxFVTJQu0msWkUyY+TKLNrj9rjj+Q4x3CmNI2drfbrwGM6++UyCb7x4vq6kFAsAkhlP7P2Z20vSis8Z9HE7OG+EgtN3twyFYVjtUx3BEkf/BEuh8ILIUD0hxN4CTDXZTyduZgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB2549.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(66946007)(16526019)(5660300002)(30864003)(38100700001)(36756003)(6486002)(66556008)(8936002)(83380400001)(66476007)(8676002)(26005)(4326008)(6666004)(316002)(7696005)(186003)(86362001)(478600001)(6916009)(956004)(2616005)(2906002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0vCfpxP1dDbl3Fxkj5oh6dhybx1TNRfo9Cvfw/Tui+RkPkgVjgs+TqcP5oQA?=
 =?us-ascii?Q?4Q5L1GoVBSatQwcmb48YHLKAQdETywR1BoTKQNOR8QIa/UbHcMizC1wDQiQ2?=
 =?us-ascii?Q?2zIZmOCOlizB1myjNbQo7d+YQ0RHaQH1vG6JMqqGhMkdsfBkstvmuiggBqG7?=
 =?us-ascii?Q?xTR1mjHrU/7yirsDfNJC3YmVGcNaGImkqFAuyZWrrnwfceWOPBDkJyI3+cQ1?=
 =?us-ascii?Q?ZsUdA8Z2dwDxRkBCpe6x7pah0WZPK2rzqs84PeAYmM1dGWpnc91qZpVTxMWb?=
 =?us-ascii?Q?/1qW/ZAzXXz27UkWoQlyrNzM00Z6kBNnULKmhpMZplOoIyYlvv06H3g2qJmg?=
 =?us-ascii?Q?JqIMTIhJSNBoNvuL+cNR2VzTpvq51ZsZHic9zi/lzgtLwE6qs45cBw9DuQb/?=
 =?us-ascii?Q?vopiLHD+46LGO036dxZC9Cpp8ZIzlyaZWHZUuAQrxqL90+AJvCVlLCGEVfJM?=
 =?us-ascii?Q?4kBOgdh/Wjyv4fzd/mZTC7IPIQp8OQOJhjr7/8UKq5dCPoMCN/1/jWyJ9F4A?=
 =?us-ascii?Q?uRPzJAwq5TAPl3fSdVTvJAGdYpIL+JX0FugzF8+iWyN82tUpSnd3yYmwvcFA?=
 =?us-ascii?Q?2LmZSKqFwuUx1wXtzgiePumM8vgtUq3hK9bQ2+E1afNV8XYfHWBP4Ccrc57r?=
 =?us-ascii?Q?6jj3Dxhsxo2E93mkw7o3t0kX5Se2LMvX2PacqbNty8DWIBwkzfIByc9p2Knb?=
 =?us-ascii?Q?UqCjoHTPZr74x9BYMmuqXQ2Ovv36kNwTgU1A8ynJTHSq0Mnt8dTcSI6aMQYK?=
 =?us-ascii?Q?FhghR4THaDFkOEibytbPUvWqZi3GUsvj+PdlCBL4RQrh971oSLFVq7G5M6DF?=
 =?us-ascii?Q?iRwx01gGiSef2JQNmE69u3f8pCV7agG4Gq+lul1MCeJiQScEYdkTY1G3VKKB?=
 =?us-ascii?Q?fwLEJ5PuLjDl+huEjBCNXZXmpoK1LAtoPMI4K40ZrkJ+KK6rs2CUoZp5DgUx?=
 =?us-ascii?Q?HUO7jHzSrlST9sGtuYP11nlsAdM5xYn4P3t2IYGYQZiKBbanjTrXvWeCMPZA?=
 =?us-ascii?Q?1T2pUg5WKlKNBdt0gF7ULa4PuLTircAex2NzWno7xr8+rS1DpZ7LKiLcRHFv?=
 =?us-ascii?Q?PIif+8VITbNmOIZbacXk8LCFSJaRdmEYYb/jTr3DXJrUSvHNaBOvcz4buNbN?=
 =?us-ascii?Q?nPsL/B9/wy2zwFpZp1WznW8hOcBNSuavSnAnoWivpZEV7iI6+9O0/7qOK9PX?=
 =?us-ascii?Q?4U/EPN7fkGRRcE3cmiqoWSaZa5mq/Zpud6i7JbjtNgknYX9x+NdYDEZGgEkz?=
 =?us-ascii?Q?1e4oPTZFx2/6BBr+WTKM3R/h8Tsegrvxo7EwII1Cpq/KfffVf8bP5GfiVAf1?=
 =?us-ascii?Q?Idi2/Oan1/3kxsmP4Cor3cOd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b391ed20-dd6d-415a-0fe7-08d8ecef5beb
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB2549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 05:00:06.0463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yBM4mUMqvsCF2CLMp1GWs7z3LCHaK4jUKQW/fvV/SZvIdkWyyymx+2z1eYdPNnjLT2VPpxapXq/8i6igXYKFeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0040
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
 drivers/dma/ptdma/ptdma-dmaengine.c | 480 ++++++++++++++++++++++++++++++++++++
 drivers/dma/ptdma/ptdma.h           |  31 +++
 5 files changed, 546 insertions(+), 1 deletion(-)
 create mode 100644 drivers/dma/ptdma/ptdma-dmaengine.c

diff --git a/drivers/dma/ptdma/Kconfig b/drivers/dma/ptdma/Kconfig
index c4f8c6f..7a6bfcd 100644
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
 	  provides DMA capabilities to performs high bandwidth memory to
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
index 0000000..9db9923
--- /dev/null
+++ b/drivers/dma/ptdma/ptdma-dmaengine.c
@@ -0,0 +1,480 @@
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
+static struct pt_dma_desc *pt_find_active_desc(struct pt_dma_chan *chan, struct pt_dma_desc *desc)
+{
+	if (desc) {
+		/* Remove the DMA command from the list and free it */
+		pt_free_active_cmd(desc);
+		if (!desc->issued_to_hw) {
+			/* No errors, keep going */
+			if (desc->status != DMA_ERROR)
+				return desc;
+
+			/* Error, free remaining commands and move on */
+			pt_free_cmd_resources(desc->pt, &desc->cmdlist);
+		}
+	}
+
+	return NULL;
+}
+
+static void pt_cmd_to_hw(void *data, int err)
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
+		desc = pt_find_active_desc(chan, desc);
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
+static struct pt_dma_desc *pt_handle_active_desc(struct pt_dma_chan *chan,
+						 struct pt_dma_desc *desc)
+{
+	struct dma_async_tx_descriptor *tx_desc;
+	struct virt_dma_desc *vd;
+	unsigned long flags;
+
+	if (desc) {
+		/* Remove the DMA command from the list and free it */
+		pt_free_active_cmd(desc);
+		tx_desc = &desc->vd.tx;
+		vd = &desc->vd;
+	} else {
+		tx_desc = NULL;
+	}
+
+	if (desc) {
+		if (desc->status != DMA_ERROR)
+			desc->status = DMA_COMPLETE;
+
+		dma_cookie_complete(tx_desc);
+		dma_descriptor_unmap(tx_desc);
+		list_del(&desc->vd.node);
+	}
+
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+
+	if (tx_desc) {
+		dmaengine_desc_get_callback_invoke(tx_desc, NULL);
+		dma_run_dependencies(tx_desc);
+		vchan_vdesc_fini(vd);
+	}
+
+	return NULL;
+}
+
+static void pt_cmd_callback(void *data, int err)
+{
+	struct pt_dma_desc *desc = data;
+	struct dma_chan *dma_chan;
+	struct pt_dma_chan *chan;
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
+	}
+}
+
+static struct pt_dma_cmd *pt_alloc_dma_cmd(struct pt_dma_chan *chan)
+{
+	return kmem_cache_zalloc(chan->pt->dma_cmd_cache, GFP_NOWAIT);
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
+	/* If there was nothing active, start processing */
+	if (desc)
+		pt_cmd_to_hw(desc, 0);
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

