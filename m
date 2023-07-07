Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8FD374B6BF
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jul 2023 21:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbjGGTBY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Jul 2023 15:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbjGGTBU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Jul 2023 15:01:20 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2088.outbound.protection.outlook.com [40.107.8.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA7F26AB;
        Fri,  7 Jul 2023 12:01:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OzroLu34yGTipTA+y4Ffgd7vqAKAHVA84aMR7i1UlEj5bNZx93n8jsKyHbj7rxtIT0RqJTnEBKCLudPBhqv3qyL8yTjTFnipSG8q6RFUR7IZnLppt2BpopeuR1hiVWpbu4DZ44QpaQx68d8TkU8quBj7UhsYW2GDlttuScyHrtdkSpU0ZHA0GCKKbIP10NYF1IkceSjjptxqc/CD1W43Q7MQOBiA2vd+xWT97BvgVYsyI+esMLoJwJs4aRGnAeTUNyJdrLuEjejqjPTrJfUTRjcVSO2T3e16urQ6UrJQDtozMY5nJXXefN6aIk9hGyMsKNzeUsbleRFo3155yCzhFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdeS/JJlSBGhfLIYay0YGd5Yd/T/EkmHvXJdldS/U5U=;
 b=g3vhBhU3HjdFBBuiItSkufqKHXHinbJuWMfzmD10axHgZkSc4pIYa+JHSAJNl2CGFSuiz9WQUXH66ryBsGcq3aHJ1OBEuA5UBDWOqRdZstWCxurB0CHaw4H2PFbzrQy+NBuv7+oNWcELGzYDAHNMPomulXXNAO98wPvdxfz3RxPpoaeT6hITMhm/H0dhExzSNODmxIgROfradRikBX7RmyjI+xZjLBmCq18dvXRe40WLiaBw813RRwutJE6/irkRkjNu2CsuNulHlpkSarrFoSelbcinN+tgoZ2u2hMJv55mZ3gzNqa9Hjw1MngqALF29cWmrR6ft1QtfWUaFQjJ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdeS/JJlSBGhfLIYay0YGd5Yd/T/EkmHvXJdldS/U5U=;
 b=h5G6q28fKFwUml7HMFg8ZRnvGiq4cS4p9a5hqDQxvJsjzn5UNuxpqG/MNgul8otkbe8v0b3yK2e3RvzLyAxkB2v90seA5oiT/k2VAuY87nmaoP8VLUsLxNV4bon3o+lFTyzto5Jje6DOiq3oRe8+TuSo83DUUYZ3ubTeZyrrWcA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8103.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Fri, 7 Jul
 2023 19:01:02 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 19:01:02 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, robh+dt@kernel.org, shenwei.wang@nxp.com
Subject: [PATCH v10 05/12] dmaengine: fsl-edma: move common IRQ handler to common.c
Date:   Fri,  7 Jul 2023 15:00:22 -0400
Message-Id: <20230707190029.476005-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707190029.476005-1-Frank.Li@nxp.com>
References: <20230707190029.476005-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0067.namprd11.prod.outlook.com
 (2603:10b6:a03:80::44) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: 447e8c4b-552a-43e2-7aca-08db7f1c822e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uwd2e7uowHbWVrfTu6Jg0So6KygzOqo1k1i87HsTcnMIbAIpJR+Bv02UcmsT9tJkC5LHApDyYX+hXZnHsNPRloNEAENHgO73L8EcnaiEhdxPSH5l9CL1kfBZTcddohUL52cZX/JZh/q3Ka76++qsUBAqvENCWUoME8FRpk2GG0OWn9OKlxhyjyFK9WAW1A7wm25O9WVldYgywUDFy8KAVQdQa2eYMkdKhSOfAcKvqrlG50qTlNrRFBaHlUE9QSPqvjTT2GJAyAoNKPr+5YgvXb5n9u7w67SbJorQ6KE9PdYuULqpfS/YmHy/5yQtkQ/+wuA9NE+VtGtCSPNdNpliA0UmJ3oOrFaBKj6WS/g0GRoDfSBFeFxr955yEAoU+fEqsW3NIsCR89YWnXyqMpl/L1B+3i4orwQ8HOOO+u1rbHdoZ/7BdLUjY6P29cE+xSQ6Jvu0LuVP+T0Y4ZrRTuPytPsYoIHct4INs7MMTYcYO4UZ0n74fC45O9C3VjNwb80A4/ZgSM1UKW0gC5sVgTBRIMA5zz0A1lW17iuVKABR2WTkiHDDoe+bxx3JO5wugQoyEds2ICFUfoBAptZsk7ByOLQWB1Qel1gtWsptyVFiiKAuswHs74dbD6HWdziGTrDh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199021)(478600001)(52116002)(6486002)(6666004)(6506007)(1076003)(26005)(6512007)(2906002)(186003)(41300700001)(316002)(4326008)(66946007)(8936002)(8676002)(5660300002)(38100700002)(38350700002)(66556008)(66476007)(86362001)(36756003)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+S5ZoldpLO9hucY8WSVKq2BsTtoqjfsvn4LqhLXNbB0/Cl+leS3UC/kQfBAY?=
 =?us-ascii?Q?6kBdxNjcaNlNUfLHXAnJLml7lEtQRbrTe2CE7/mGbnerjSIOCyw3L7EYGPjG?=
 =?us-ascii?Q?bJgwnl699sct8DEX2MOQ5JGAgux6iHFfCVjx9RzDWqh6l8vclp/olnCtBP8O?=
 =?us-ascii?Q?VgargyGXbe+r5zyl6tjOLnfmMB5WAdSEsZFiUg+zO8yw5O761ZvPx2ia4/Y5?=
 =?us-ascii?Q?ONzZj6T4A9ezXPgGiLYBYWltAO7Gync7xSbh3XZ6Vz8dUTs1AfZXVtw6UADc?=
 =?us-ascii?Q?jRLcPAQDbAJD/G+Pv+/rPa1Ao0mXYX+4YA1fW+0TDhT+Z7qqiYbf/BnC3Ci7?=
 =?us-ascii?Q?FeycKXy2TxSyq5Mi5N3/DelZIZVqlAxICQ+ll/XTY3rOhCxBr+O9S1eBGdvy?=
 =?us-ascii?Q?1lifZHFa6WKYG8Apo6ZQHLNxnZDPZlxfTfVCViK4mh9n68FE7dH5UdzEx2w0?=
 =?us-ascii?Q?UsE6oXvEw+RGeqv3s9i0MLcEP6JFiZCRQVA+U6Qio4Z3vACrnAFYfU5X39SU?=
 =?us-ascii?Q?at3WAjyG2xnCra2LSMxTc4KcWiBXzlGICnsaRqARuH/5qNtbenRMAJlHwL+r?=
 =?us-ascii?Q?AOj0Ah5AfJjTx/6V2sZIHrW7y+qrzF3XzYN0CapjJ3+McR2q78GVxk/fo7T9?=
 =?us-ascii?Q?LpSJ9C74SLYkB5lJqc9qqSnsxE3Z/LPuhdsKnV8+79GDg/0+qv8BOivofnML?=
 =?us-ascii?Q?27IW717lafusqRY2aSJvsmKjPWQCAdNCO/j6oDtgyV3Db7FGVsnVQjwVsskL?=
 =?us-ascii?Q?NnpNO8CXQU0CAqHipstrK2hWA/eq3eeExfuvp/7Qc1FJl5PxcuPNhVhaCMkU?=
 =?us-ascii?Q?LA51dIa96vPc6ML32THJs0dCtqiu373y5vaKFa9A9wNTDVJd9B1jnMc7r4i2?=
 =?us-ascii?Q?aYUsGB1SzBIxlKI005I53wnIIhcPARY9tedtaGJ/87JsuGMdKNX8H05Ayaws?=
 =?us-ascii?Q?ggqDS5CKY1RL3oGmiV+AtxJxDGwlkGBSRLSphywCInajY1n4zgWJqfY2CjMP?=
 =?us-ascii?Q?YEGMEhODT6GOrW4mEu6e7LMBsVXD63yHZXRaBP2Ybla9RBlGaumT7lJ+ktxM?=
 =?us-ascii?Q?Q8xx8AihDXDY0jogB5pZZJ2woNiXZ77zLPMusPuahCX/0wyNz9gUkPxhHwPX?=
 =?us-ascii?Q?Idlq78ME3Id+AjuI8Gx6UWj1X9gTYJK9p5kNViO1k4tPVLcxC0hwZvZnyfPJ?=
 =?us-ascii?Q?qCxj/2ipIQvNYNWF26e1W+J/u0uzgA2BuRFAXVgAIRy6ThcNhLuPW73lQhUE?=
 =?us-ascii?Q?3NfQCckrTNpB17g9axltp1H90JLZcFfisUhdwSRH8Rq4t/1m8x9mLZ+m0Ab2?=
 =?us-ascii?Q?AwjXKO7ur+cldo0GdrbXTyH3Nb6co8EoWiNKQl4fMJZnCj9rPB78Fm/7IkEg?=
 =?us-ascii?Q?i9eitRoqB1RnmWKJLCgNVE/cGIKVWrZqnuvB8UZSUlq/LN5/6waxuk/FA56a?=
 =?us-ascii?Q?8WUJ6QQFiCFpeqrSgjjzDvX2hO0+5wIJn3Fgdndg7k9AD15ua4Aivn7GJvkK?=
 =?us-ascii?Q?UZfQyfRP/Hf0RjjCEGTDCIodEnAIN/THgD5lVdpB0ZJWBPksur1WYk81fSf2?=
 =?us-ascii?Q?8pqIcXCVf88npM/D6Hs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 447e8c4b-552a-43e2-7aca-08db7f1c822e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 19:01:02.4706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5mZTuYz/Rrgo5YwANBiAZJG42VeDOqYDFNMRyMRsWIWLBwOORl7C5p49866/7rJUa7x2VogO5jpwbiCt/AiFiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8103
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Move the common part of IRQ handler from fsl-edma-main.c and
mcf-edma-main.c to fsl-edma-common.c. This eliminates redundant code, as
the both files contains mostly identical code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 26 ++++++++++++++++++++++++++
 drivers/dma/fsl-edma-common.h |  7 +++++++
 drivers/dma/fsl-edma-main.c   | 30 ++----------------------------
 drivers/dma/mcf-edma-main.c   | 30 ++----------------------------
 4 files changed, 37 insertions(+), 56 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 5800747b8fb3..2b91863502d4 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -42,6 +42,32 @@
 
 #define EDMA_TCD		0x1000
 
+void fsl_edma_tx_chan_handler(struct fsl_edma_chan *fsl_chan)
+{
+	spin_lock(&fsl_chan->vchan.lock);
+
+	if (!fsl_chan->edesc) {
+		/* terminate_all called before */
+		spin_unlock(&fsl_chan->vchan.lock);
+		return;
+	}
+
+	if (!fsl_chan->edesc->iscyclic) {
+		list_del(&fsl_chan->edesc->vdesc.node);
+		vchan_cookie_complete(&fsl_chan->edesc->vdesc);
+		fsl_chan->edesc = NULL;
+		fsl_chan->status = DMA_COMPLETE;
+		fsl_chan->idle = true;
+	} else {
+		vchan_cyclic_callback(&fsl_chan->edesc->vdesc);
+	}
+
+	if (!fsl_chan->edesc)
+		fsl_edma_xfer_desc(fsl_chan);
+
+	spin_unlock(&fsl_chan->vchan.lock);
+}
+
 static void fsl_edma_enable_request(struct fsl_edma_chan *fsl_chan)
 {
 	struct edma_regs *regs = &fsl_chan->edma->regs;
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 5f3fcb991b5e..242ab7df8993 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -219,6 +219,13 @@ static inline struct fsl_edma_desc *to_fsl_edma_desc(struct virt_dma_desc *vd)
 	return container_of(vd, struct fsl_edma_desc, vdesc);
 }
 
+static inline void fsl_edma_err_chan_handler(struct fsl_edma_chan *fsl_chan)
+{
+	fsl_chan->status = DMA_ERROR;
+	fsl_chan->idle = true;
+}
+
+void fsl_edma_tx_chan_handler(struct fsl_edma_chan *fsl_chan);
 void fsl_edma_disable_request(struct fsl_edma_chan *fsl_chan);
 void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
 			unsigned int slot, bool enable);
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index be79a06fd6e3..d974db8c1776 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -33,7 +33,6 @@ static irqreturn_t fsl_edma_tx_handler(int irq, void *dev_id)
 	struct fsl_edma_engine *fsl_edma = dev_id;
 	unsigned int intr, ch;
 	struct edma_regs *regs = &fsl_edma->regs;
-	struct fsl_edma_chan *fsl_chan;
 
 	intr = edma_readl(fsl_edma, regs->intl);
 	if (!intr)
@@ -42,31 +41,7 @@ static irqreturn_t fsl_edma_tx_handler(int irq, void *dev_id)
 	for (ch = 0; ch < fsl_edma->n_chans; ch++) {
 		if (intr & (0x1 << ch)) {
 			edma_writeb(fsl_edma, EDMA_CINT_CINT(ch), regs->cint);
-
-			fsl_chan = &fsl_edma->chans[ch];
-
-			spin_lock(&fsl_chan->vchan.lock);
-
-			if (!fsl_chan->edesc) {
-				/* terminate_all called before */
-				spin_unlock(&fsl_chan->vchan.lock);
-				continue;
-			}
-
-			if (!fsl_chan->edesc->iscyclic) {
-				list_del(&fsl_chan->edesc->vdesc.node);
-				vchan_cookie_complete(&fsl_chan->edesc->vdesc);
-				fsl_chan->edesc = NULL;
-				fsl_chan->status = DMA_COMPLETE;
-				fsl_chan->idle = true;
-			} else {
-				vchan_cyclic_callback(&fsl_chan->edesc->vdesc);
-			}
-
-			if (!fsl_chan->edesc)
-				fsl_edma_xfer_desc(fsl_chan);
-
-			spin_unlock(&fsl_chan->vchan.lock);
+			fsl_edma_tx_chan_handler(&fsl_edma->chans[ch]);
 		}
 	}
 	return IRQ_HANDLED;
@@ -86,8 +61,7 @@ static irqreturn_t fsl_edma_err_handler(int irq, void *dev_id)
 		if (err & (0x1 << ch)) {
 			fsl_edma_disable_request(&fsl_edma->chans[ch]);
 			edma_writeb(fsl_edma, EDMA_CERR_CERR(ch), regs->cerr);
-			fsl_edma->chans[ch].status = DMA_ERROR;
-			fsl_edma->chans[ch].idle = true;
+			fsl_edma_err_chan_handler(&fsl_edma->chans[ch]);
 		}
 	}
 	return IRQ_HANDLED;
diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
index 7b05e303ba51..316e637b00c4 100644
--- a/drivers/dma/mcf-edma-main.c
+++ b/drivers/dma/mcf-edma-main.c
@@ -19,7 +19,6 @@ static irqreturn_t mcf_edma_tx_handler(int irq, void *dev_id)
 	struct fsl_edma_engine *mcf_edma = dev_id;
 	struct edma_regs *regs = &mcf_edma->regs;
 	unsigned int ch;
-	struct fsl_edma_chan *mcf_chan;
 	u64 intmap;
 
 	intmap = ioread32(regs->inth);
@@ -31,31 +30,7 @@ static irqreturn_t mcf_edma_tx_handler(int irq, void *dev_id)
 	for (ch = 0; ch < mcf_edma->n_chans; ch++) {
 		if (intmap & BIT(ch)) {
 			iowrite8(EDMA_MASK_CH(ch), regs->cint);
-
-			mcf_chan = &mcf_edma->chans[ch];
-
-			spin_lock(&mcf_chan->vchan.lock);
-
-			if (!mcf_chan->edesc) {
-				/* terminate_all called before */
-				spin_unlock(&mcf_chan->vchan.lock);
-				continue;
-			}
-
-			if (!mcf_chan->edesc->iscyclic) {
-				list_del(&mcf_chan->edesc->vdesc.node);
-				vchan_cookie_complete(&mcf_chan->edesc->vdesc);
-				mcf_chan->edesc = NULL;
-				mcf_chan->status = DMA_COMPLETE;
-				mcf_chan->idle = true;
-			} else {
-				vchan_cyclic_callback(&mcf_chan->edesc->vdesc);
-			}
-
-			if (!mcf_chan->edesc)
-				fsl_edma_xfer_desc(mcf_chan);
-
-			spin_unlock(&mcf_chan->vchan.lock);
+			fsl_edma_tx_chan_handler(&mcf_edma->chans[ch]);
 		}
 	}
 
@@ -76,8 +51,7 @@ static irqreturn_t mcf_edma_err_handler(int irq, void *dev_id)
 		if (err & BIT(ch)) {
 			fsl_edma_disable_request(&mcf_edma->chans[ch]);
 			iowrite8(EDMA_CERR_CERR(ch), regs->cerr);
-			mcf_edma->chans[ch].status = DMA_ERROR;
-			mcf_edma->chans[ch].idle = true;
+			fsl_edma_err_chan_handler(&mcf_edma->chans[ch]);
 		}
 	}
 
-- 
2.34.1

