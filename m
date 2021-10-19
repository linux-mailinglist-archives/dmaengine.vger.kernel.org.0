Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54776432E43
	for <lists+dmaengine@lfdr.de>; Tue, 19 Oct 2021 08:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhJSG2y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Oct 2021 02:28:54 -0400
Received: from mail-eopbgr80082.outbound.protection.outlook.com ([40.107.8.82]:7079
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233717AbhJSG2w (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 19 Oct 2021 02:28:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ls2peS3KnJXdvPAW1/CJqb7wyLqgr/q1UBrMmx9VhstJQeMZXi/XrvinvKKKYMVM14noRLToufnutSAowg/LOLQm2uh0IwsOMGrBuNUyCGB9y/oF72Wq+LkhDyU7e9uEfvO5YRNdoqDWNl2nF9RReqT+vt0OtQN2uk4KgLTGaz7Fs4Cnbx0VO5bRR3era6EAo4fPwz9UXuN/ODu4L0kEyoGxyafchyg5e0b0UeR+8mv/D1KDjokcDTaDutiP2m7O5+IYOJTU1/yKBW0LkqQcUvNalOD9lyzRHk2+JRdmCY96fcqNojeiEXA6EYUkroGt++Cx5vzgNpHFfDntiLOiTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+wgv79elngAIXVBfdTktWBOyxk4eK01vRYUXZRChj4=;
 b=CcVx7LRyXxhTuc0N4qO13AHF1AyQL+DwAMoSTmnaEMZSwVL2j1Y54riq5Ef72+UTkimtJHK7Fe5ShO8T/B6MY4lWc7sVbQHnesyQ5cO8hWG7yZUUd3/zSi34/CoqBjsnCqfV/rS4R7WEwzMb1EQgmXpLv919/ugci1L+pUEV+/DX9MGBMqNbCQXjR1BNxzph0fErJqkuY+Yi08fYw8EDM31/7H7KjeTtHhP4TdyHKGLdRSh0OCMNzJdazqoNdK+tbEdFpWgNVqNfXSRpE/hnHqI9iII+xjYzfOGpUEnWmrlvduHe8Z8ZLYYYVjGEzZXdsmgVETcbjRZ8MD2J1Zwe1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+wgv79elngAIXVBfdTktWBOyxk4eK01vRYUXZRChj4=;
 b=r5jUwFH2qBogtfz/1sP/HQANZeuM6kruD6vqAPb5OUBC5XDrWjvONbhFMTFcRxkwJEUzHIkHW83IJQPtoFzW9DHXZHtWjtqKuIKjnu0bJYYjgy2mTGZDSSnP8j5Kw10VHIVqBqXQvq1sfwh4pt5wBfazNDJ4Z3pIO4Q1Q/ly7bY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7444.eurprd04.prod.outlook.com (2603:10a6:20b:1de::16)
 by AM0PR04MB7027.eurprd04.prod.outlook.com (2603:10a6:208:191::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15; Tue, 19 Oct
 2021 06:26:38 +0000
Received: from AM8PR04MB7444.eurprd04.prod.outlook.com
 ([fe80::6db3:208e:1a23:be9e]) by AM8PR04MB7444.eurprd04.prod.outlook.com
 ([fe80::6db3:208e:1a23:be9e%5]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 06:26:38 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     vkoul@kernel.org, yibin.gong@nxp.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/1] dmaengine: fsl-edma: support edma memcpy
Date:   Tue, 19 Oct 2021 14:25:37 +0800
Message-Id: <20211019062537.1209683-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0302CA0021.apcprd03.prod.outlook.com
 (2603:1096:3:2::31) To AM8PR04MB7444.eurprd04.prod.outlook.com
 (2603:10a6:20b:1de::16)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by SG2PR0302CA0021.apcprd03.prod.outlook.com (2603:1096:3:2::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.8 via Frontend Transport; Tue, 19 Oct 2021 06:26:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 003d7039-8b2c-4200-608c-08d992c967c0
X-MS-TrafficTypeDiagnostic: AM0PR04MB7027:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB70273493D8316477C26FFBBFE1BD9@AM0PR04MB7027.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:269;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C4bz0Vu/GN4YXcZWKTGL201MM8PhypCODAUqGYOrh8JY6XlK66YQmieNs6/7PP+B1wcvjgsL1QXwpsOuzzsb4fIGxu+ihwKx3bCFaKXRgFd6G91BM/84lGji0dbbcMGxcWrNjtdwl7UjPvXhclXU6obtRttYnkKmu0aKsv9fli/OGyRiZ5niKAg69rRj9xGFpLHAEviijgO3617FUSelAZleIsU2/5LP+QwIuK82ggBgHQ+O9ILkYZLWjb7oNM0jSWENZWD/gPdBVX1WArURO6/iFYe5TC8Oj/w0dyWhGrS4zAkdBv2G912U19zgSJgHQshUg5Tz04oZ3CNZ+AXiJQWKHKcv6lVl0BJg+LjvxMpPYRDVzbTyW6Ik1FapUS1mCJl7rLRbnif5yUPUJBzCCv6cBj99X5iIVcyf49kWrggvZJ2Te4f2XwNpEolo2PwtjWy0rWp40RrZhQYAPFNsiO62HvnUTXn4oikEN+TNmB5gzX2FiqR+5G1C5OR2gKrEyCEaKxYY2KAIQwLrT25zzazNspE3X3kCv7OmDahK0xKFFrry3HSHsfNUBjPV7Im3WzC/CTtZpHTj07eWIANeb6y30UIUqq/etvSIeMSUIX2tDr9CUwLRIhu4UITR+qKeGnhCdG1l7c/RrdYnhubIpM/uOs9YZM+If4MX1UjuiYFomioCDmXY6VSnovFFFB+WjgeeF69fj9yRX9a1njWCgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7444.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(186003)(44832011)(508600001)(6486002)(38350700002)(5660300002)(956004)(38100700002)(8936002)(6512007)(316002)(2616005)(86362001)(4326008)(6636002)(52116002)(66946007)(83380400001)(26005)(66476007)(66556008)(6506007)(36756003)(1076003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vmlFMO6Oe8xoRxuPDAI6UkR0T5Od7PK/2h7QGaIBhsllWMOKDo4KRIb2MKEF?=
 =?us-ascii?Q?rBXQd5O9bX3mUy2t6TBGBPL5h20E9Az/kqaiAYrV2Bct0Me3UIElbvRLxPvp?=
 =?us-ascii?Q?b0+Aa5XydY1bZNDdUU8nnJSuE0I5r4N5bp0Vkh3OaV+GLogWurfZwJ7YpsPI?=
 =?us-ascii?Q?JMjk4Jy91Jv8DE3eakUz8yVv74O4fwVVFIZJnb+V3OnFduEYSC7405xgV6q2?=
 =?us-ascii?Q?rovIUF9nvMzpnPS8EYFfIWz0SsofS8P1PUK3IbaAQLo4tfG7yix1H5PtJPov?=
 =?us-ascii?Q?HT0E82HdTtALHUyKwZGT180nLnpUkk9MPoGBvKu+K0kqXixXSB/RKArMj8Vl?=
 =?us-ascii?Q?xAsVdq8dgsNq6mob6xHxMfGJMPG5LmTItZUvIvLoYK/QH+3FtttbUpcxM8Uv?=
 =?us-ascii?Q?eZ6lrZ0/k27f8Yp+gRm5Ukjcp0lrtFTt/m9ywTe+4/mHxgcNgnMsXUXDIR1r?=
 =?us-ascii?Q?anrA4XXlNeDPnRn12Nhpu7brPkc8KCjXogCIqgwo44x8CWiMllc8BQwfleT+?=
 =?us-ascii?Q?ez9uX13WYOSsTNGuHC3uYrVPEYqgThsPN4vK/JAddF0w/0Vwtjogwc78svU7?=
 =?us-ascii?Q?gzj7/ldZKaVaCZ7luoK2pwNAlEEq6yN9/jsUXRA7EtkKqIA+TsNzA/TDyIlL?=
 =?us-ascii?Q?pBnS9m0lqDXFEIqyG7yDux74sfGtm4sglt/arnHy2R/mxlq6fmX7lpLP/jXP?=
 =?us-ascii?Q?jWStvGpTqibzUU9IvHMUP5Qr6t2fLzQGqOBirfmXBeaHReWKPgOT5P4ftKBE?=
 =?us-ascii?Q?JyZxe8E5aRW1kAXiB7q4l32dDaEojs3j9dJnsaUL7LCqywHWAjwlxIq9IfRr?=
 =?us-ascii?Q?m1ER5amB/MrO60ZPyacnBhcHa4ygfar7BtWIYYLXZkb1nhJoDmFvPW7GRQVH?=
 =?us-ascii?Q?oD2IIAMbxyVyA0hlbIo23dPT+SJZNDmqo3iXbpNijVfcMYSAwSjRhYXxi1Ep?=
 =?us-ascii?Q?BI2jWu4EQRDptZaw9N5Beb4UURlcZ1NmYpD9sf51I7gNKX8nI8Eu4NyRjZ41?=
 =?us-ascii?Q?ixmJ6Q4fgJvyOAT1BoQ/Jk4hhLIYVrCHuJ9W7dKv2yBQBBwQYnOKjCT9rtQo?=
 =?us-ascii?Q?Dd93rcoupzEdyxJ9KRSM8glubn7LE/HlkqsGqBudanrzY/2wgbGHzkfYWbXn?=
 =?us-ascii?Q?rfFx4dIr51b50wDKRFbkJAvdekq+yQnBDX6g2Ac/S8GKOJFLKf2EzzpJ8QoG?=
 =?us-ascii?Q?+hj59K/kgtWIYixuhTyqEbuOwdLkD7P/taZ0+guxNuXd8cwhRU27thmK8uj9?=
 =?us-ascii?Q?i29oALK70PzIYP2qE0ICXc1i3QQbLLyxx65kZroRM3pRA7uUlTUm78RLfL+A?=
 =?us-ascii?Q?9323YadWC0i5wIokJEsUy2tl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 003d7039-8b2c-4200-608c-08d992c967c0
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7444.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 06:26:37.8807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJkYQMaTS9Tp1JfOB3bjmElF7AmvEIaSInnKBansRQaZf7zIDkqtVC5p88mL7RuI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7027
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add memcpy in edma. The edma has the capability to transfer data by
software trigger so that it could be used for memory copy. Enable
MEMCPY for edma driver and it could be test directly by dmatest.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes since (implicit) v2:
Remove 'Reported-by' tag in v3.
Robot report sparse warning on v1, fixed it in v2.
Add blank line in v3.
Add commit message in v3.
---
 drivers/dma/fsl-edma-common.c | 34 ++++++++++++++++++++++++++++++++--
 drivers/dma/fsl-edma-common.h |  4 ++++
 drivers/dma/fsl-edma.c        |  7 +++++++
 3 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 930ae268c497..3f7c9faa8c9a 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -343,11 +343,11 @@ enum dma_status fsl_edma_tx_status(struct dma_chan *chan,
 EXPORT_SYMBOL_GPL(fsl_edma_tx_status);
 
 static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
-				  struct fsl_edma_hw_tcd *tcd)
-{
+				  struct fsl_edma_hw_tcd *tcd){
 	struct fsl_edma_engine *edma = fsl_chan->edma;
 	struct edma_regs *regs = &fsl_chan->edma->regs;
 	u32 ch = fsl_chan->vchan.chan.chan_id;
+	u16 csr = 0;
 
 	/*
 	 * TCD parameters are stored in struct fsl_edma_hw_tcd in little
@@ -373,6 +373,12 @@ static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
 	edma_writel(edma, (s32)tcd->dlast_sga,
 			&regs->tcd[ch].dlast_sga);
 
+	if (fsl_chan->is_sw) {
+		csr = le16_to_cpu(tcd->csr);
+		csr |= EDMA_TCD_CSR_START;
+		tcd->csr = cpu_to_le16(csr);
+	}
+
 	edma_writew(edma, (s16)tcd->csr, &regs->tcd[ch].csr);
 }
 
@@ -587,6 +593,29 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 }
 EXPORT_SYMBOL_GPL(fsl_edma_prep_slave_sg);
 
+struct dma_async_tx_descriptor *fsl_edma_prep_memcpy(
+		struct dma_chan *chan, dma_addr_t dma_dst,
+		dma_addr_t dma_src, size_t len, unsigned long flags)
+{
+	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
+	struct fsl_edma_desc *fsl_desc;
+
+	fsl_desc = fsl_edma_alloc_desc(fsl_chan, 1);
+	if (!fsl_desc)
+		return NULL;
+	fsl_desc->iscyclic = false;
+
+	fsl_chan->is_sw = true;
+
+	/* To match with copy_align and max_seg_size so 1 tcd is enough */
+	fsl_edma_fill_tcd(fsl_desc->tcd[0].vtcd, dma_src, dma_dst,
+			EDMA_TCD_ATTR_SSIZE_32BYTE | EDMA_TCD_ATTR_DSIZE_32BYTE,
+			32, len, 0, 1, 1, 32, 0, true, true, false);
+
+	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
+}
+EXPORT_SYMBOL_GPL(fsl_edma_prep_memcpy);
+
 void fsl_edma_xfer_desc(struct fsl_edma_chan *fsl_chan)
 {
 	struct virt_dma_desc *vdesc;
@@ -652,6 +681,7 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan)
 	vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
 	dma_pool_destroy(fsl_chan->tcd_pool);
 	fsl_chan->tcd_pool = NULL;
+	fsl_chan->is_sw = false;
 }
 EXPORT_SYMBOL_GPL(fsl_edma_free_chan_resources);
 
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index ec1169741de1..004ec4a6bc86 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -121,6 +121,7 @@ struct fsl_edma_chan {
 	struct fsl_edma_desc		*edesc;
 	struct dma_slave_config		cfg;
 	u32				attr;
+	bool                            is_sw;
 	struct dma_pool			*tcd_pool;
 	dma_addr_t			dma_dev_addr;
 	u32				dma_dev_size;
@@ -240,6 +241,9 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 		struct dma_chan *chan, struct scatterlist *sgl,
 		unsigned int sg_len, enum dma_transfer_direction direction,
 		unsigned long flags, void *context);
+struct dma_async_tx_descriptor *fsl_edma_prep_memcpy(
+		struct dma_chan *chan, dma_addr_t dma_dst, dma_addr_t dma_src,
+		size_t len, unsigned long flags);
 void fsl_edma_xfer_desc(struct fsl_edma_chan *fsl_chan);
 void fsl_edma_issue_pending(struct dma_chan *chan);
 int fsl_edma_alloc_chan_resources(struct dma_chan *chan);
diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c
index 90bb72af306c..76cbf54aec58 100644
--- a/drivers/dma/fsl-edma.c
+++ b/drivers/dma/fsl-edma.c
@@ -17,6 +17,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_dma.h>
+#include <linux/dma-mapping.h>
 
 #include "fsl-edma-common.h"
 
@@ -372,6 +373,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	dma_cap_set(DMA_PRIVATE, fsl_edma->dma_dev.cap_mask);
 	dma_cap_set(DMA_SLAVE, fsl_edma->dma_dev.cap_mask);
 	dma_cap_set(DMA_CYCLIC, fsl_edma->dma_dev.cap_mask);
+	dma_cap_set(DMA_MEMCPY, fsl_edma->dma_dev.cap_mask);
 
 	fsl_edma->dma_dev.dev = &pdev->dev;
 	fsl_edma->dma_dev.device_alloc_chan_resources
@@ -381,6 +383,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	fsl_edma->dma_dev.device_tx_status = fsl_edma_tx_status;
 	fsl_edma->dma_dev.device_prep_slave_sg = fsl_edma_prep_slave_sg;
 	fsl_edma->dma_dev.device_prep_dma_cyclic = fsl_edma_prep_dma_cyclic;
+	fsl_edma->dma_dev.device_prep_dma_memcpy = fsl_edma_prep_memcpy;
 	fsl_edma->dma_dev.device_config = fsl_edma_slave_config;
 	fsl_edma->dma_dev.device_pause = fsl_edma_pause;
 	fsl_edma->dma_dev.device_resume = fsl_edma_resume;
@@ -392,6 +395,10 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	fsl_edma->dma_dev.dst_addr_widths = FSL_EDMA_BUSWIDTHS;
 	fsl_edma->dma_dev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
 
+	fsl_edma->dma_dev.copy_align = DMAENGINE_ALIGN_32_BYTES;
+	/* Per worst case 'nbytes = 1' take CITER as the max_seg_size */
+	dma_set_max_seg_size(fsl_edma->dma_dev.dev, 0x3fff);
+
 	platform_set_drvdata(pdev, fsl_edma);
 
 	ret = dma_async_device_register(&fsl_edma->dma_dev);
-- 
2.25.1

