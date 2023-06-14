Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E07B730860
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jun 2023 21:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237071AbjFNTg2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jun 2023 15:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236878AbjFNTgS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 14 Jun 2023 15:36:18 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2070.outbound.protection.outlook.com [40.107.7.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DE81FDD;
        Wed, 14 Jun 2023 12:36:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQPV9oqltE35/ilhyakcMOEKdDrB6KnZcSPRctxj0g2WgBGDfmozxedhL4H7IxB9k86pBcW+kP+OHNDhXvfqs5nM/vkzf6GiuNbtSvj0cNd5WyOiUHQdgQU919UMw/NouO++ErLXJJrpUuuXB6Ce/RL6Z2NI+aKOI6XQe1fyJ3QDhV5geDdl7vz+3TpauGx0lFzCC82xkIs8H75FweizxRQA89jkBGNnqKfgI3Kr/o2jbG08m9OKR+KyI1BiM3UeM6Tx+zpdukD/7aqU+vDYXIXVO9FUwhLnoKOf6/hvj0t8DINLBLIPl/ll2RgzB20xDsKS72wb3DWIx4DK9JfvIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8SowlELrPWxkRr9/us8d8rvbeSkIi6e/pnhOSy9jcs=;
 b=D0O/Munoxd253jruCLehf5/Ts+k+oSVe/LpBAhoJk7eZyhPZY7DceowBssUvBRSZNYAfGGWTeLrQH75sSDPdOJZqUGwcTnVjhHs38fvp6D+VUr6PQJ7WahLJtoAbxGuIZHwZnRb+Kk/7Kz+3J5R6JPx8hCEXo/RxetvdtUBtYX3nr0ACJ7fZE9NTP6MPEY6VZjehxCHrbsD0WAKKaeQhR1eG7dcutmF+NS08Y/K37PdfpisFEaV7Mhd7UXh47PS7pfnudjNP/EPkOe3of13Sef3XVUVxuwyRfUdUqJX8XUaObM1Ph0445IBDsCKD9+6bFtqO4QcJgGfzyY9cNxYFOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8SowlELrPWxkRr9/us8d8rvbeSkIi6e/pnhOSy9jcs=;
 b=H7IYtTXfD3F0w6urTPAPsNtjB0/5Nl6QJH6siOQ0hefdCp0aooWaUyI3QZj40ErZI+GQmbm/Vie7kJ8LAyM1CkEXsRJfnDdWHi44HNaFYfsN5udxU3sVWkBdts1uHT013XI3DRNmB/VmEbU4SgK6njQXZjICtCvI/UcGzr+yS0Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by VI1PR04MB9763.eurprd04.prod.outlook.com (2603:10a6:800:1d3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 19:36:14 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.035; Wed, 14 Jun 2023
 19:36:14 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v6 05/12] dmaengine: fsl-edma: move common IRQ handler to common.c
Date:   Wed, 14 Jun 2023 15:35:37 -0400
Message-Id: <20230614193544.2114603-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230614193544.2114603-1-Frank.Li@nxp.com>
References: <20230614193544.2114603-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0051.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::26) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|VI1PR04MB9763:EE_
X-MS-Office365-Filtering-Correlation-Id: da80c79b-6e20-46be-d491-08db6d0e9d4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1qrIP/rAMkvm1z23mGFmozhaWxefg4PntD1C729ctt100gfUoRC+6XtDeYw12v8J7oeRSJrElijg5HLCio51KKcPdAfdCUUTdpPpCzuAP2jvsTQMp8XgfGBeSkH8iZoEc9oHFqtKV/9YDvT6wUYHKM0VO9o4ggj1vikM7HFy3bAt0lDx6SQyTA6qkYjethWhegsF3MN7wvafflXcLvA7fwaumH+lNs/2Pa6XZhRUg7hPnSXe6Z9IKObPoGtObgDmE3iZ8Ptf22m1GhAe7cZqMwnrip4dnqW6VG/ijnfKLGsk2DM9hvwY3k86tx5p1Iizczw94BT1sWAzP6noZ17Q56Z4k0Kc46fVsI6iwzg5tvxMYkFnKRUt5FouVrAC6ip6jKbDimzh4LCqQllqiMM7rDvW4wz9PC7M37rPIGfSfXN6mEmc4dMnqdi4IZQg4YbiPVYyYxmoGx9pUlZyfunza+pU+3Pd59DnKEG6v8nPN9DdZ5JYi1M0h11iwWZjYpwr6DBGfxyvYu0YhGd9mWae7hhcJK7YB15+IHbJSncR566WOK1JlQxTX7SDiLpoAkzeusTIit0ca24hoLwXwGz5+FyOqf4ZEtJaw8UBbuMxbNHoKFfXypInCBecbtbs+Ebo6TQ7J7KNFFHH2a51BuS2pg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199021)(5660300002)(6486002)(8676002)(52116002)(41300700001)(6666004)(8936002)(66556008)(66476007)(316002)(2906002)(186003)(478600001)(66946007)(83380400001)(38100700002)(38350700002)(921005)(86362001)(36756003)(26005)(6512007)(1076003)(6506007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kkBnySmCJkFrETHF0mlo3UXc3q6Wmdt6iooJaaCPLHej39U+ZEHx8e1BDJRw?=
 =?us-ascii?Q?oFP4bt4KCgx+vrkpuFKy24XLBL8pd4ICy7y0Ccy9FIrKinFdsJCEtK5vEBji?=
 =?us-ascii?Q?NKVi81gUy7WP9bk/1HQXSR165L68aKjHaF067I5nBWJW19we+A6eAs7wi05m?=
 =?us-ascii?Q?VBEbkUI1w7yAIxjG2rAymLm57MDpMZzV9apPQTr2m93EIh/MIZ+s0CNDwhLe?=
 =?us-ascii?Q?m5nyQ61ANneLX1SSGok2UyZfyBrBnopilKAyTmnrxluxCb0GWgo0lMqDYuIK?=
 =?us-ascii?Q?e6NZ08YOa5rsgJLaRpMcBy+tdeX8rg9UJYD0uPzFu3vBlt9dvSoLCYAuN95N?=
 =?us-ascii?Q?+htSfPRqk02VpwtWYmszykrTVgS6oXsBaf5bITLTXZ3ufBpSQfZVCoR0u3xu?=
 =?us-ascii?Q?bDdJE3FrE9lS9IVu/rYbaSgSMpy/D4vYo+ZvpOg4HaIGO0+uObCQJf+uAUvk?=
 =?us-ascii?Q?/XpCq2RS4PPwvLUAmFJFFvOrnvUkw/oms5KYpo9GrpYbzt05OqyI87ux4eAw?=
 =?us-ascii?Q?D8LYyb1PxyKwVZOvHYMRYqkXcx9ZH31Jw9i/wd3b3UF7UrtJXoVhcfkbAvqn?=
 =?us-ascii?Q?hO5UKzcpynqTiaLyaIcHsps2TVbHB4W7p1b3yO7YtpV5HipdNe/oblPcRq1p?=
 =?us-ascii?Q?pxCTnFFYhgKxKrJkEaVFUOMayasBbPEgoRx/YEtj5KJ3rptSdHBOgl0SvnqR?=
 =?us-ascii?Q?i8RhJICYjrNZQ0TdiWhTh/WKWDGCCfTWwZrQvK5w5j1YXMmbNoCWk3yuxXc7?=
 =?us-ascii?Q?2YU8Wgx9SIXCu62f7SCqGSMn67yRo5mqGcEpdjnFCaMDW8POM6cEQ1LWMYSG?=
 =?us-ascii?Q?iUs+yRPzHZQstXsxTb/69ID81KN7j/pbWFNUiGo+Bbomw++pcP70gG98yVVg?=
 =?us-ascii?Q?+eiGc7zpCj/XWSdsCloLX4Ow6wOJdjN9GchlBKWkIkf22Bntp0yCxczTOKQO?=
 =?us-ascii?Q?x2TclOCwqB+WkmA/uTYJxtfyzVdG2GTzNoFMGtE5WTZN0HE/xGBWJqFoqmJB?=
 =?us-ascii?Q?3DK9T/V6kdTpnPfEHsSN//fdSQQ6v1tNVzA7RoAm6IbK3tM+4UwQ9W2QlCNH?=
 =?us-ascii?Q?uGJh3ieGpb1453woOvb3Vx8CZm4LOzsrddLcCOO3FizeOz6nDW1mgZi2cDHc?=
 =?us-ascii?Q?rSLjNY2sI58A6zpFoBp6q9L5+il09eeHq8dG+yn0Qicf6NyzBJ6SBz0RyuE+?=
 =?us-ascii?Q?re0JMtrMF2mvv6vh91DBf5fC9XYbeCOQUpiAUb/01BkgqpSWfMZUIEU8C7XQ?=
 =?us-ascii?Q?Z/yXQ8uWjSudr9GioxK50cQSuVzrpu60zwPRoOEyY+4Qx/iuEAr02AM2ByBL?=
 =?us-ascii?Q?H3pWEmOGQYtC1HUFLFXK9V0Qsh0ohX06axaa4ynYj14D/lxtRFCvnyAsFyKA?=
 =?us-ascii?Q?fZZwwzNH+i5y+2TR8gIvv+JrD70N9O3y5+IVhNAu96wwpSSasLU85oBiC5ox?=
 =?us-ascii?Q?grwdswxOEIIaHENjrD9TFcL6tqNUBPICV2c8cWT2Jx4l5jBa1lMYFY/f2W9d?=
 =?us-ascii?Q?jMbLhN1a7xKYm+gfaJFjeVoAzUqDj6FRlLBsF8DGR2Si3HDsqZ6ksxwswr/V?=
 =?us-ascii?Q?VsSAJph94Aue/zQ3yX0ryVLoQHcrwYalEVlDeaXD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da80c79b-6e20-46be-d491-08db6d0e9d4f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 19:36:14.0716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YegwUdivQw+495KeiE0rmJESW5kEYN7aDmlDR1rO0A13cZ8cESi1h6+7E1wfw3KjFULp8ZygOiOYwRT2j6numw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9763
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
index 9948babcadf6..a9d17cf142fc 100644
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
index 47bfef1c562c..a0e54ca4893c 100644
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

