Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3482428AD0
	for <lists+dmaengine@lfdr.de>; Mon, 11 Oct 2021 12:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235792AbhJKKje (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Oct 2021 06:39:34 -0400
Received: from mail-vi1eur05on2067.outbound.protection.outlook.com ([40.107.21.67]:20357
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235602AbhJKKjc (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 11 Oct 2021 06:39:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJG+wy681n/TGwRKRPOmJt2HsccIYjZXzOYRIiA0/rSG2NqJHfXGf7m8qWBL4A5gNuidPpRINlGP6CZgN221Wg/FjYqaDwY+QmwALlk3to+jNaBmSZRaQZBLgPWCR4wl8L8947uNjdXNBFMaxrHNtGQQW4yW8keuS/VW/7QqJOrYRZKH/mAs9mjyz0y/j49m5V9n93xOpJwnzltSkrzwrlHIZoqFMg3pxzZ7ZiBSLViuWlL9TQCKUnXPwoLMbP+Rps5QdAmyxjKREJoXUl7o6pwtTR27bnXfEjoS7OALYuLLLf1C0RF+MxbdQJq/s5W4kg9Ii2wgKy4zgIo/FmA8JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lop1MXrmnfSQ2sTwmXiEKbmv2J2tMTrsAckqP+h48Vc=;
 b=PgSLjkQtSQrX4m4sD+UskZuU9BgaION2ZT3MgVKSnmV4rsyPfaWgEUTtgVTiDLQN4H76+QrM4KW3yLEN+eRPSXovimrZELUt2Ta/Af5jHAkP2VHE78SLlvLWa6FqZne+CDf/8lzHL4HfaIkj0ArI0qu9A4uCR7Xa2RcpaQZPOPSttyupMYhdx6oCmgYrebzv3AnQVLS+VZ6wnSSPqbe6kuV1fTgoiDmQ5Bjv0wqAXTaiCQO5jajo2urCY/1snBcT7dxZ8917ov1oavlPi0uzxz9QIE434iII2cNsi/gSDRoESrSJQT0S5XY3XSAPFYxFlhGNQZkcYQrgyxOkzqNsRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lop1MXrmnfSQ2sTwmXiEKbmv2J2tMTrsAckqP+h48Vc=;
 b=YGTdBTON/cp9PJkTy5t3SBJqgUoX+SRceve6UwzDQYJOHSQzpozssJxrBmB2YWx+NIzr4q0tJvKM4LZGBcInsV8cZkKOFtRJFneIUd95wZDYnX7awMpvQd3z1W6jjVM33P5TtjkgpcIYvjxLjMx2vMNONjiXmlhWP8F3WB97dec=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7444.eurprd04.prod.outlook.com (2603:10a6:20b:1de::16)
 by AM8PR04MB8020.eurprd04.prod.outlook.com (2603:10a6:20b:244::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Mon, 11 Oct
 2021 10:37:30 +0000
Received: from AM8PR04MB7444.eurprd04.prod.outlook.com
 ([fe80::21fe:cfa4:5b31:4f25]) by AM8PR04MB7444.eurprd04.prod.outlook.com
 ([fe80::21fe:cfa4:5b31:4f25%3]) with mapi id 15.20.4587.025; Mon, 11 Oct 2021
 10:37:30 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     vkoul@kernel.org, yibin.gong@nxp.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/1] dmaengine: fsl-edma: support edma memcpy
Date:   Mon, 11 Oct 2021 18:36:23 +0800
Message-Id: <20211011103623.456865-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::29)
 To AM8PR04MB7444.eurprd04.prod.outlook.com (2603:10a6:20b:1de::16)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by SG3P274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19 via Frontend Transport; Mon, 11 Oct 2021 10:37:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d8a3699-a1ee-42ce-bce7-08d98ca3207d
X-MS-TrafficTypeDiagnostic: AM8PR04MB8020:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8PR04MB80201C616DCFEB76F1E80C67E1B59@AM8PR04MB8020.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YZSJ2/RqkVUkr0OcQU38BTCWdT6e6PSpAPAAU1urRxXXnLtHm6+2JtmgDzaGxloJ4o60/W7M3lhydYUkdbWVe/I7jNccasMBZu5uiS3HaeK6wNLe0CuSNkQjEOiFsCCnvZ3PO2sbPkRraXttQm6aZs9N7L+8zznQqAwZnX1GGxhSEUXG5nCfBMCu+T0CLlqxk/BeMkenOBsfBS9pkW++y/FYlceftcvp2mVvZvaBkyuRUqOM+MEt2NC8QFuMniWMi9Y+vjyLr3ED4aN2U191n4kqkeO9KQAFDguuczUtDZGrRIII/5YahXvpLtQc9CUw2QQB/O/I63skX81CiJBGer86Z9eAUsPAILeaMFVgQpJFbhwrGJ7gw00wFSzG9YR3BUa25S4mRn/NYsgdbGr7cQ0BJM5yby0yEKzXdSqzLN5gty2iCqYc394m4mIrdamiAdQXeAVPj/+j8gUm/VcSrT2tg1WrB42c6CDs+CqSzuY/QYd/mI6l02jWQGysW15Cc5B4EQo5Twqh3zscSY+RQ2s+ZDDpEtgnFR34vW5olgks2t/WFYO/TVufH/dt6ILt38R5jiVnOnPv8jW0lkmQ//8/9RYyXWHUZZRBP6OlfEX9e5gcsDW1APOi2D2BryOuq6na2T1GQIoQ10uEYIaYpy/4MFyeEsjd6nS7r4fFeBlg1wnTF0EvgyDUPVF8LC1JfTQXfXuvN2xj/y/mqJ1TLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7444.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(6636002)(316002)(52116002)(4326008)(44832011)(66946007)(1076003)(956004)(86362001)(36756003)(38100700002)(66476007)(2616005)(6486002)(66556008)(6506007)(38350700002)(6666004)(6512007)(8936002)(186003)(5660300002)(508600001)(26005)(83380400001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hh8Ex6za443TCTzljU/WSYeLcxo3xS4ZPyob/jOCCnYHd4/ea21+9fPxLT8g?=
 =?us-ascii?Q?fEPDjbirOPag4DPvleMBhVF6A13kJDDXXEANU2KopVg/binLuWWBMSd0vvcC?=
 =?us-ascii?Q?sdInFUIKIuP4ru/1yEIgigt/E/Ri01/F/oDWaLa4mcdzhQdOpoLQUhGVfuZa?=
 =?us-ascii?Q?wpbohIW9tpdiGwKevM6cZLbLwLoaUCuU8vYl46TIdXurU6cA46Md4t4mjn1j?=
 =?us-ascii?Q?fGu7DOs9SavWczPk+Fz3ror1OtWzYZwciE6GGaqBJdTDfTYO1C1CrlrZfApB?=
 =?us-ascii?Q?qAgzlm1nQ4UcIquUhhdEdZ1w+4HMUkdfZdzZLHn/lZDUw/VZWJT8JZUOHsVs?=
 =?us-ascii?Q?muhZrTAMmJmoqZCuuRiCafnpg5XidShTEjM8iZ8rnC/6SncSqDhYRrE7Cc6S?=
 =?us-ascii?Q?8ihCG00TPFvmD0cJSnM1CCtdr5oPS74AbSsJal2pf58nT0Jb5V+Gc1GRo71Q?=
 =?us-ascii?Q?uXG+sPC9Ftqox3yqHQR7eReRNh4GJVs2WpDr0jddvsArd9vaMXLMioyqXbDX?=
 =?us-ascii?Q?5TiFaLOBxCx2t2qqNlOX3rKntGN8G8/gKHGS9s+BS9R+cyRjwd+Sbbg+zNKZ?=
 =?us-ascii?Q?/gV8vqovCxWR3/oNDxLoWmeHWjkJ7GUs5Mf1MvzgFHeMa3ofsdbth7uV07az?=
 =?us-ascii?Q?ixDZ7vMt3/EdHW6X7HEZoqjtcN7m7GB9lS8g/sbaL5MhY0qCJDf/efEkONHt?=
 =?us-ascii?Q?vENBebaaa0bQomhRGpEc6P0BqyLmxcU1+3o7XOVJiCIv0hbgCoJ81l/Oqvps?=
 =?us-ascii?Q?eIlZHNstefIM6ROPAakwgg/Uhflxvl9BaoV3fHHRUbbiFqVAuo88RzRnaG0O?=
 =?us-ascii?Q?6NTLOtabpRxbXSkA2mwReoUTEdaymoKJpbDV+YVjoG0rrBwsYQD/S3SRp0HY?=
 =?us-ascii?Q?6AL/OxAuLIKHOtRR+6T+KZc4mdWQGMlqTDegSxk+7r0Rh8Z8sakApkdJ1EyF?=
 =?us-ascii?Q?y/hxzoRUZTKyw3gZ5seW8yypVsN2Fhm7qYOUdTVFzFVDHaN788pzKHpslCTD?=
 =?us-ascii?Q?DIwF3R1OO+s8Ms1Suwa6w6Rhle5Go5EgUKOPVVLllkRLQlH+N3YWGAHQxrvT?=
 =?us-ascii?Q?8DR0ZJ5gT8hPs+/Js3YDqN76LraT3FSCb0/d0QVdIP3trDM4SYuPC4pkPSOK?=
 =?us-ascii?Q?FldR1Cc1I0Vv4hITqrWs/2SimphztPSv0Rnrz9Rov2MIzKKhGSdHYt2kiqkw?=
 =?us-ascii?Q?NHZ/3VjVVqSpHDXi1sHEgJt9+e/M7jpWwAEdeqNR58fxg8cUy4oztLT1Vbry?=
 =?us-ascii?Q?/Gobwmd1vNtJ2RRRm6IUqMqynMzaRT/KawOfLQb4P8C2Y0u6CsCQGnsUx8CN?=
 =?us-ascii?Q?c/lokSAVUAYA0+c8ehxFjz+r?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8a3699-a1ee-42ce-bce7-08d98ca3207d
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7444.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 10:37:30.3718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cRgloHO8sSo1JEwdVKu1aBWDCJGlwut/wjZTRaVofA2tpgKMsy1Tusae+E+00hVJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8020
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

add memcpy in edma.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/dma/fsl-edma-common.c | 32 +++++++++++++++++++++++++++++++-
 drivers/dma/fsl-edma-common.h |  4 ++++
 drivers/dma/fsl-edma.c        |  7 +++++++
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 930ae268c497..8a451855c3be 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -348,7 +348,7 @@ static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
 	struct fsl_edma_engine *edma = fsl_chan->edma;
 	struct edma_regs *regs = &fsl_chan->edma->regs;
 	u32 ch = fsl_chan->vchan.chan.chan_id;
-
+	u16 csr = 0;
 	/*
 	 * TCD parameters are stored in struct fsl_edma_hw_tcd in little
 	 * endian format. However, we need to load the TCD registers in
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

