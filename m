Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3344782E14
	for <lists+dmaengine@lfdr.de>; Mon, 21 Aug 2023 18:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236275AbjHUQQu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Aug 2023 12:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236486AbjHUQQt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Aug 2023 12:16:49 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2083.outbound.protection.outlook.com [40.107.7.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3357FD;
        Mon, 21 Aug 2023 09:16:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjVZvA010klBknEHKYA+Inq1ixnFCPjHfwSBaWVtS/gfTvfmbAcJW6rN18ZWDmapMa3hhSbJuhLVGid9G2lFoCXT7cuZ4ximXMYVGNkFcmSper1tG436GgXoqUqSOtIVENzOAJ6LPA3w4Uf+zN1+JkHSTfPJiIsAgso1XmGg42NQuE4sR89j2gobPBRrEeDmAV/J+qFso94wx1J5spIGz1lgHiiHuHofp4G19+5yCavMDkSJRd9CFf3tooTPmlhFv+P5lRyuo9T4HlsaBZ0vVYGPlnqJi4GMX0E/uHkXgHtREhCLKfVWwfKKGcc1rB12/lpSWRE8PHZqdjGDbMowSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z41lkXvgGM2WpNeGV/txL6nXeuNX68fZZlHG0v6Uyj8=;
 b=FMLIBs+0Hz4dJilYNCknB2DFA8HTUZwo/w9IRdAEbKWNziV3iJAYSYBnQDfy5KQrg06/W3Q3xeBsGBneND2ZwW6SR4EFaN6ISNliuvNxA7/mh2dcmQiyJMCwjOvuzcG1v3+Ksa/ceoirnGgJIWIXjY9xBXdJZdtoHvUJgo3Q7uC5vEwdergMzTXxoIdgH8FkISp+dM2irMILRwW8qGBOGhIWeP7hJAOX4SG2gR8kgxATVJdY3Yt1eJ3us0AH5bK1oSPVchQezZBjfSfz79icoWNPr1qB3rGvLIvwrzNBVXUMhoXXj3lZVFhyExsaGQW8ojXOp3PLeYlJQW0v6/sYyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z41lkXvgGM2WpNeGV/txL6nXeuNX68fZZlHG0v6Uyj8=;
 b=in4l/c/ETdRxbFedILwwMvR8hLWtj/mtrNrJTNXRRAjgMh3uYk26F4S+fz4SKivI78OHyneNZr89VeeZdphM9hlhXSBTqHU37zuLqjzklnCMMVuI9xBKX9FZOA80qvgKyf75OpP2VtCSPrLKvDgOUe7YqCnC6Pi8kRA4PvViIV8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB10042.eurprd04.prod.outlook.com (2603:10a6:20b:67e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 16:16:42 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 16:16:42 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, robh+dt@kernel.org, shenwei.wang@nxp.com
Subject: [PATCH v11 02/12] dmaengine: fsl-edma: clean up EXPORT_SYMBOL_GPL in fsl-edma-common.c
Date:   Mon, 21 Aug 2023 12:16:07 -0400
Message-Id: <20230821161617.2142561-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821161617.2142561-1-Frank.Li@nxp.com>
References: <20230821161617.2142561-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0053.namprd05.prod.outlook.com
 (2603:10b6:a03:74::30) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS5PR04MB10042:EE_
X-MS-Office365-Filtering-Correlation-Id: 59344c68-6075-49d2-37eb-08dba262018f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AaS6eMgrpjIAel+g5RnN7dQww7bRjOdIj/ybw0l+P2dDzTkp/8aJq5qIaGZuxM1ZbvLgN3yItQLWnTmxfsAN5fklSkZDrZJzwyNxmTI4Bo5z88SH88fIvjF75GOmtyyBFMnfPe3cBc+/qBWcJP1scyKcWlV1tBoxSmPe9dohfHBlZY35Fm4E/69Tkj5/+ppylQt/A0puUlrTBFfTQmJzmPhZrw4l8I3ZqwL7XdwFYjHHRK7gJPaVmmTlYP7FtM1aLgWBOgkKoYK60XEiRK7GGiSUBQSJcFGYmrMJPflrn2bl2Z8/rrxPjWRRtZVNNIV3l9z8U5vpWf3tX+jO97I2/FCLO71DX6k0FHyFL4+zrCCYp5kbmhTdyvddxdx2y4CWw+t/23xs2U68qX4TqHGtvlHCAVWHxRwbBbMRON+inHrQWO4j6Erzu38uUihJMea/6OOYZbrc82pC+GmFDwvGdGHOUw4JuQ7TVNbv/iw7PwDBj7C768oQMD4P7OAZV62LKIgV5a2j7GPVvcesFJN9ZO7miKk43jEtrJlJpzmkzM5DZOApLEsUlB219QjXRIvskT8hYYI/sFiSkuQ1yZyb94MU9ciDO3w1b+F8xBUQween0vz9Dj8HRzrKqPjtuP6k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199024)(1800799009)(186009)(2906002)(52116002)(38350700002)(38100700002)(6486002)(6506007)(83380400001)(5660300002)(26005)(86362001)(8676002)(2616005)(8936002)(4326008)(316002)(6512007)(66946007)(66556008)(66476007)(478600001)(6666004)(36756003)(41300700001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G7CfZIr8ZYQ0dPIau2RNqFeMZ49P/F0Ew3cCY/fS6nTuXvkyA4c6dEW3CHmn?=
 =?us-ascii?Q?oQYX1/RAmecd23f9/9ZA7aRnc0TQ0o/ppXrrSnAMhJ3LyeB1fKWpa4C14aTH?=
 =?us-ascii?Q?s5JW2uWFr/8XMcjNhsxOwC13ebEqP3uM2xs6p7WmnAOJitBW3X08cYmwpMH6?=
 =?us-ascii?Q?QP7ndaYXEtY7UEUargu7JNnpCQC60XG2zwR8ZBZZdIwiqfr0a+y+6uEsIhHZ?=
 =?us-ascii?Q?fsbVHuimHnAbHmYskxTjea71wJn6ONL5r24k6ecU0XW/MrUAl9y2e1MxScNn?=
 =?us-ascii?Q?Im7M9R1ZvI2d0hQ41q9bB/zlco0qpqm4FASFgttDdmDnSPGRj+15uaqjYuXK?=
 =?us-ascii?Q?/ImnuZU1aHlk2v9Nox7s5mT7/5WOHh3D721FGX8Lv1NJx83J/6FliqanUwEZ?=
 =?us-ascii?Q?2I0Cc3wD2Ga0upBn3hUmkt3Kz/y6f+oTqS4epEVL7HQ+tgmFhyt6FNnY8vRM?=
 =?us-ascii?Q?lc+mVpAbuIrhXPn2jeDpMJXAVb6d6ossxGKqCtDhX6qw1yCNez+9hTl0u4pO?=
 =?us-ascii?Q?PCZHAS5EFaz1WFwwe/1n1xlKXyEvkofuRCK5Of8OqgPOZqiKUnjkHAH11KFc?=
 =?us-ascii?Q?/1bQXVcChRrSKPTdeCt56miUrA4w3x2vXQNoO4HW4M73isFV3+culLB1DgHy?=
 =?us-ascii?Q?pY0JfAkKsRXmWqBvIMaiBtjpWbtTfuPINxQaxp21ms/hmxFJI7fbfnsB9SLv?=
 =?us-ascii?Q?Z8MXuPubfcCHsHr+cEPnRYuiCrZFIPzrFdr5QjygsuL1ik1gnIbDjx2+yB8q?=
 =?us-ascii?Q?UvA6wGj42KOpWErS9+hcQT9j6cm/nYVKxJy7i7JZPK3JxXSRybwqSjX75+RT?=
 =?us-ascii?Q?5u6C/lVd5TnE0aO9jeSufj7UVcNz6BiNNNXX0TcDjFVIS/YRg7cA63OG2Nzr?=
 =?us-ascii?Q?wL+kVilLKDR3OUbzqv1aJRrwo7DytvVbaIl5ywOBWpviG6XIpwx0c4qKCPYH?=
 =?us-ascii?Q?Affbrgp3z/lCDF0ZXYc48PVQI2I3Ds6MIW4x2CrGmYsfvxARJBIRHnMedPcK?=
 =?us-ascii?Q?y22IszAkHwAZFf/WKNCo0MVlOps+D2FyUo3gbox20eTWUee5iGdD4qSrJ+EE?=
 =?us-ascii?Q?AEd+5TKM1dtneBA2AaOW0EOeOtjZ+fsidNf9V6QHZ40zepjMnBc/CGkzWZPc?=
 =?us-ascii?Q?zVnfbQRCY6FAYwWMZpXqPL2lF5Sng+pUtzv6V3vhlS2dGTbGzpDWoXQIm/vk?=
 =?us-ascii?Q?dbVMXlBpB+9Yld18YZNNtbkShZTKnZ9hvCcWXUN+6j9wJcQWCLnXvDE6wJvx?=
 =?us-ascii?Q?CpXvDLj/AryDAujOBwr/xtCDPYG7ZC8j/aa/pMzyMdYcxsn/QrRDQvb/SzZj?=
 =?us-ascii?Q?gSqOmBhDOxuJ8dgRlCidWIvTy3DQUeKARBE+6sX6UoLX+pugVOQBJMdgkOrK?=
 =?us-ascii?Q?NmSAglInQ3pForatOTWDZMhAHsIrk9ILgz5eshFr1mWqLJRZ1OsuW/WIPMvF?=
 =?us-ascii?Q?mzYHPWNLuu1fvzJY/BtGT2RVbOuZDNkgKpDt9cw63pF2s7xpFBrFGqxtpWT/?=
 =?us-ascii?Q?MZdmXpCC7keGmqsC3xehnAfM4BmbG0x7J3fcTGvqgYdPUkb9ZP2GnzX51q9J?=
 =?us-ascii?Q?/xZVowM5j04srbWWpSE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59344c68-6075-49d2-37eb-08dba262018f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 16:16:42.3371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z59yOCBJ9VWoslYLIoSIHdjdwEPEWuLh7fjE3r1kkCcTejsJRymkMmKYq5r5WzrSvFCtkKtL8+mVy6QswL//UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10042
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Exported functions in fsl-edma-common.c are only used within
fsl-edma.c and mcf-edma.c. Global export is unnecessary.

This commit removes all EXPORT_SYMBOL_GPL in fsl-edma-common.c,
and renames fsl-edma.c and mcf-edma.c to maintain the same
final module names as before, thereby simplifying the codebase.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/dma/Makefile                        |  6 ++++--
 drivers/dma/fsl-edma-common.c               | 17 -----------------
 drivers/dma/{fsl-edma.c => fsl-edma-main.c} |  0
 drivers/dma/{mcf-edma.c => mcf-edma-main.c} |  0
 4 files changed, 4 insertions(+), 19 deletions(-)
 rename drivers/dma/{fsl-edma.c => fsl-edma-main.c} (100%)
 rename drivers/dma/{mcf-edma.c => mcf-edma-main.c} (100%)

diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 07cdfd27d09c..83553a97a010 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -32,8 +32,10 @@ obj-$(CONFIG_DW_DMAC_CORE) += dw/
 obj-$(CONFIG_DW_EDMA) += dw-edma/
 obj-$(CONFIG_EP93XX_DMA) += ep93xx_dma.o
 obj-$(CONFIG_FSL_DMA) += fsldma.o
-obj-$(CONFIG_FSL_EDMA) += fsl-edma.o fsl-edma-common.o
-obj-$(CONFIG_MCF_EDMA) += mcf-edma.o fsl-edma-common.o
+fsl-edma-objs := fsl-edma-main.o fsl-edma-common.o
+obj-$(CONFIG_FSL_EDMA) += fsl-edma.o
+mcf-edma-objs := mcf-edma-main.o fsl-edma-common.o
+obj-$(CONFIG_MCF_EDMA) += mcf-edma.o
 obj-$(CONFIG_FSL_QDMA) += fsl-qdma.o
 obj-$(CONFIG_FSL_RAID) += fsl_raid.o
 obj-$(CONFIG_HISI_DMA) += hisi_dma.o
diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index a06a1575a2a5..89b0d09c13ff 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -75,7 +75,6 @@ void fsl_edma_disable_request(struct fsl_edma_chan *fsl_chan)
 		iowrite8(EDMA_CEEI_CEEI(ch), regs->ceei);
 	}
 }
-EXPORT_SYMBOL_GPL(fsl_edma_disable_request);
 
 static void mux_configure8(struct fsl_edma_chan *fsl_chan, void __iomem *addr,
 			   u32 off, u32 slot, bool enable)
@@ -126,7 +125,6 @@ void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
 	else
 		mux_configure8(fsl_chan, muxaddr, ch_off, slot, enable);
 }
-EXPORT_SYMBOL_GPL(fsl_edma_chan_mux);
 
 static unsigned int fsl_edma_get_tcd_attr(enum dma_slave_buswidth addr_width)
 {
@@ -155,7 +153,6 @@ void fsl_edma_free_desc(struct virt_dma_desc *vdesc)
 			      fsl_desc->tcd[i].ptcd);
 	kfree(fsl_desc);
 }
-EXPORT_SYMBOL_GPL(fsl_edma_free_desc);
 
 int fsl_edma_terminate_all(struct dma_chan *chan)
 {
@@ -172,7 +169,6 @@ int fsl_edma_terminate_all(struct dma_chan *chan)
 	vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(fsl_edma_terminate_all);
 
 int fsl_edma_pause(struct dma_chan *chan)
 {
@@ -188,7 +184,6 @@ int fsl_edma_pause(struct dma_chan *chan)
 	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(fsl_edma_pause);
 
 int fsl_edma_resume(struct dma_chan *chan)
 {
@@ -204,7 +199,6 @@ int fsl_edma_resume(struct dma_chan *chan)
 	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(fsl_edma_resume);
 
 static void fsl_edma_unprep_slave_dma(struct fsl_edma_chan *fsl_chan)
 {
@@ -265,7 +259,6 @@ int fsl_edma_slave_config(struct dma_chan *chan,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(fsl_edma_slave_config);
 
 static size_t fsl_edma_desc_residue(struct fsl_edma_chan *fsl_chan,
 		struct virt_dma_desc *vdesc, bool in_progress)
@@ -340,7 +333,6 @@ enum dma_status fsl_edma_tx_status(struct dma_chan *chan,
 
 	return fsl_chan->status;
 }
-EXPORT_SYMBOL_GPL(fsl_edma_tx_status);
 
 static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
 				  struct fsl_edma_hw_tcd *tcd)
@@ -520,7 +512,6 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
 
 	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
 }
-EXPORT_SYMBOL_GPL(fsl_edma_prep_dma_cyclic);
 
 struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 		struct dma_chan *chan, struct scatterlist *sgl,
@@ -589,7 +580,6 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 
 	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
 }
-EXPORT_SYMBOL_GPL(fsl_edma_prep_slave_sg);
 
 struct dma_async_tx_descriptor *fsl_edma_prep_memcpy(struct dma_chan *chan,
 						     dma_addr_t dma_dst, dma_addr_t dma_src,
@@ -612,7 +602,6 @@ struct dma_async_tx_descriptor *fsl_edma_prep_memcpy(struct dma_chan *chan,
 
 	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
 }
-EXPORT_SYMBOL_GPL(fsl_edma_prep_memcpy);
 
 void fsl_edma_xfer_desc(struct fsl_edma_chan *fsl_chan)
 {
@@ -629,7 +618,6 @@ void fsl_edma_xfer_desc(struct fsl_edma_chan *fsl_chan)
 	fsl_chan->status = DMA_IN_PROGRESS;
 	fsl_chan->idle = false;
 }
-EXPORT_SYMBOL_GPL(fsl_edma_xfer_desc);
 
 void fsl_edma_issue_pending(struct dma_chan *chan)
 {
@@ -649,7 +637,6 @@ void fsl_edma_issue_pending(struct dma_chan *chan)
 
 	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
 }
-EXPORT_SYMBOL_GPL(fsl_edma_issue_pending);
 
 int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 {
@@ -660,7 +647,6 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 				32, 0);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(fsl_edma_alloc_chan_resources);
 
 void fsl_edma_free_chan_resources(struct dma_chan *chan)
 {
@@ -683,7 +669,6 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan)
 	fsl_chan->tcd_pool = NULL;
 	fsl_chan->is_sw = false;
 }
-EXPORT_SYMBOL_GPL(fsl_edma_free_chan_resources);
 
 void fsl_edma_cleanup_vchan(struct dma_device *dmadev)
 {
@@ -695,7 +680,6 @@ void fsl_edma_cleanup_vchan(struct dma_device *dmadev)
 		tasklet_kill(&chan->vchan.task);
 	}
 }
-EXPORT_SYMBOL_GPL(fsl_edma_cleanup_vchan);
 
 /*
  * On the 32 channels Vybrid/mpc577x edma version (here called "v1"),
@@ -743,6 +727,5 @@ void fsl_edma_setup_regs(struct fsl_edma_engine *edma)
 
 	edma->regs.tcd = edma->membase + EDMA_TCD;
 }
-EXPORT_SYMBOL_GPL(fsl_edma_setup_regs);
 
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma-main.c
similarity index 100%
rename from drivers/dma/fsl-edma.c
rename to drivers/dma/fsl-edma-main.c
diff --git a/drivers/dma/mcf-edma.c b/drivers/dma/mcf-edma-main.c
similarity index 100%
rename from drivers/dma/mcf-edma.c
rename to drivers/dma/mcf-edma-main.c
-- 
2.34.1

