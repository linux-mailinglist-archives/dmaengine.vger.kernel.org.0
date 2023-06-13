Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529F172EDFA
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jun 2023 23:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbjFMVcf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jun 2023 17:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239348AbjFMVca (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Jun 2023 17:32:30 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4227E1FC3;
        Tue, 13 Jun 2023 14:32:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7JE6pK5mqMgYD1fM6eHE4rQgxeg0hZ9PXCOQwuHAz/IaKsUgdpeUJg+tmvqIF7Z6OOmSgyyEt8H7sH4uioE6aSK/IyHHKhMKLW+FW8/tRh7t4gA+6y2zMqbz0x5To+1tZk4/6TMPZgG57ul3oV3AqXMv8/4wGn3jfyOnH+7qPZSGF6owvGAe6BF1LrZcNxFUv67E3ClqWDGShNeOW0zCs3WZba8apor3em7AXR6FPGu9DMwTWx9iWbSbrVG0cb+o5gUol0Hv+/9mhbg9gOP9gWoAJrd1uBRr3z0x3S4FATx5gh5AitI2/kCJ0FCP4gpAmfqrIah+WLH0MPrG4KDnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8SowlELrPWxkRr9/us8d8rvbeSkIi6e/pnhOSy9jcs=;
 b=NfyBT5fkB8xTbjMi7U2CfK8CBXO6SsYck+fS1hOsPXo1jkJbJ+mgyYplm539sBX0zoA04h5u90kqN+D3p4sy5jkP8R/Ew06D+e1E0cUZ0DZf1mwYcFsCTbRnLIjI8lwysj4JbOyG6kRwH/SZRWi1dL+rSxlUUCCa724XioUO1VBj7UPzTvcSLhilXtJ5o31o01ICcMa6MyqHMI85qbV0nThWrD40LRx40gtPXZvw9VWFw360HEq5dq4aQOOe3Z3fEbCOFmBPRkbBdSH9xOlPPkm7TxaBMthrXRRTf2BvSO/scofwW4YvIFzbA783dCfEdTvAxNI++iqAzpHsOI/5ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8SowlELrPWxkRr9/us8d8rvbeSkIi6e/pnhOSy9jcs=;
 b=ZyfNt6+Xf4Rbq4Z1uT2L7EkuKLdNmajFBc/PX8Wh5RCQZF/uDAfCdojnirBnHdJTgtU0igp1QC0kCyf+EtHD+OiJkxwBw6u7KKUs/yamPWlTzE2Dk2GwV5x0WZiSFSpkDpbhSQtvk977ooTyxwz9QxFwdzd2TSvYgytOlq/4W4o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS1PR04MB9479.eurprd04.prod.outlook.com (2603:10a6:20b:4d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 13 Jun
 2023 21:32:21 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.035; Tue, 13 Jun 2023
 21:32:21 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v5 05/12] dmaengine: fsl-edma: move common IRQ handler to common.c
Date:   Tue, 13 Jun 2023 17:31:42 -0400
Message-Id: <20230613213149.2076358-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613213149.2076358-1-Frank.Li@nxp.com>
References: <20230613213149.2076358-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:a03:217::8) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS1PR04MB9479:EE_
X-MS-Office365-Filtering-Correlation-Id: 82a08eb8-449c-4615-6cfb-08db6c55ab8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Etdvh+PzTEmTBmrO05Ul9degLUO4Qhpj+OHrtlWuuUHYeyboNs90pLM+RtFwMIi199U+gLViXEt8aZegQS12GTL2B+EwjL8TpbCegBYaSvIxY4LJI3WepdJw00vRZsmtbIzwy4ieBmy6Hi7YXTUcmczYRQz2wqlXkyD4yvQ0Ls9gS8S92jxM+YsJQ+X0SIeqJLePbYE8Lw1lv1oIvHYTvt0JJQQ73Wgs1ke7MARtjcFRiPwnarED/8Xs53z30De/LUTgofvj3MC1i+PtxX/H8IRzJicSxgUE/d1EiIYGt0VUJxW8mlTn1zrsw01xbWGIUALDR9LhsmdYmIpCVnf5vGjM6NdT6g0sbiB1s0esdjtyj5V2tONEwOxiFchHgMzmnP4BJdexLAUN86qSFXj+Qjza9CMbm+59/I0DB1qHXn4z3lYxA+7Xkrj6rcyf3CmEDan8fz/S5P1oWtQEkZWP6ibTEAJNPA7PNMdHTbqYKJcjP86P9i6Zxp1ZAOSsnYYcg8QndjX1WT3snoiZGYnubF1j36JAy1I235Pl9GBeK3gZDSu7jTj64YWMgxwTuw6pkxu+T/RYzRVbGhWbpKHCL9rLeOxHE84Nk4/KuI4ahYLsxzfIpnH2tB96tpkpVH9p1Qj0On9H7ZdV9T5D9EsE6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199021)(2616005)(36756003)(86362001)(66556008)(478600001)(66946007)(6666004)(66476007)(316002)(6486002)(52116002)(8676002)(41300700001)(2906002)(8936002)(5660300002)(921005)(38100700002)(38350700002)(186003)(83380400001)(26005)(1076003)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dUwVQydjYFQggpPd1yo+7Y1EXBdE03y3YVDYzJQvt5lZ18oj8TnNOa5Qc5pV?=
 =?us-ascii?Q?8Ju0Jb2WUPqwKQL5fnLTQObyArCdVtVbQyfhn4uemTzZvFW99iTyxq2y/att?=
 =?us-ascii?Q?oyiSNu1PhorMsG9J5qU3DV+wSD6QqA9HWgJct3z5bCI3UMurnGoomTFoN0wb?=
 =?us-ascii?Q?4aDlBVlnZZrIwf1Nf5LTP0hb6EWdD/nUe/rFeixY6QcMl+/yd+lglS++gtki?=
 =?us-ascii?Q?SmiTtSc5oVUYBDWaGLDRURrO7v50JgolfnvVr5y3IHGMk2d2oJTAy4B1rXwJ?=
 =?us-ascii?Q?YQyGlJgUBfBl6LUdw0uVnI12AmdCJA9OjPeok5XQ0lBZBpTvFzN8rciGangP?=
 =?us-ascii?Q?9FjBCTV61TqdIdClooZ+y/6PI9UggurPirtk5Q2zNxgmGVuK2h5KThok9YNM?=
 =?us-ascii?Q?kXcQu6dDsSMG5BUgWyojr9iqxcxsGj82lDZaWXo2YHdhyoLsyVSuVo19tL86?=
 =?us-ascii?Q?5sWcK4uz2z+jZdmhlPH+/HIx7eul1nsFZ+/d/PKlTs9vXdgfUJ1mHkEE6PMX?=
 =?us-ascii?Q?8VxrKRLuVay61ekneNvdSvU4WYz4f/HM9LXZ7xf4P/Sugl66Vyldj50+7yVz?=
 =?us-ascii?Q?0IKyLNi46ZS00UnzhaOJavdLSmVIuoBTb1v3otPXj6wCCFcHMZfOBNPbDOy2?=
 =?us-ascii?Q?pszhPyZs8ksMTRySMBUK6in7HhcA+KHkpyBgTWhP31qEiE/SsA7tDYCJ+SJG?=
 =?us-ascii?Q?RAswfkW3tfWXBWmJhBCKAURzzVmR5YbdCTXdjD09S9u2yfb5ToKcYcz9Qed1?=
 =?us-ascii?Q?hn3pmcSr1K21+aChT6Ai+DMRGh20M7ujWmM9iUbo3h8HiLG2RM66kFINbVmH?=
 =?us-ascii?Q?A7vqoPXxn7SJjglW+09kNybCEhwa1i4JIHgPzHcRsoxAFr+h+ZZf2z1+5Vbg?=
 =?us-ascii?Q?YYSCcszJ057cT+wtfQagkJ7UzlBCEBaI5x2lb4ou9FQdgTlobZgzF+WlwMKt?=
 =?us-ascii?Q?xtcj/VdZzuRkXCY/L2KtLuZuEAJcwgR4B4ObbDPsDZ0m7qtNWTEXow3ZChYV?=
 =?us-ascii?Q?08zCIvpQhsy3t8iVf7c1Oe9L8v5+6zu6Lo6jt+wTfyKCg9dA/nEyXBpvLbTC?=
 =?us-ascii?Q?i1ZctUyaZHIPQ/Q2L511YtLkBrcsmwponKevIBsIZ/sS6O7n/0jMoTX22VX9?=
 =?us-ascii?Q?zS2eC99MExQdfnOa6JWyVlm/qx5k9jWKqdHoDosBrpiOvX6tK+6xLdKS1eZD?=
 =?us-ascii?Q?va+Hp6Wal8bXv3J9GU/VQM0d23elbnzykwABN1G8kUim/cPHPx9pOfAYqX/K?=
 =?us-ascii?Q?u2PaMuGjvVLtpmzKod+tnY/JbcAKrql1GqOvJQHulzKDQir9ofszpapvZB+/?=
 =?us-ascii?Q?1AukMuRYkU2j5DPxVQpS5IbbYjVmW2HQ4ZLcNdfNnnd/fSy3WBdtRshHg/lH?=
 =?us-ascii?Q?e5sGXX/WHfMx05pyZp9F76J9HeS9XEtnenTpflsYCkLlqulkIE9aX619uTm4?=
 =?us-ascii?Q?9F6W1k/7lSlcORmn9WS5HfM3NtAJcWthDYQTrisxWHPW8KRDIJHmDR2QOKqD?=
 =?us-ascii?Q?h/Y2HGTQEKn5UCnJNZYpNahUse6qlT9YnodvaYgORckxJEyGiAl9yucE/zDG?=
 =?us-ascii?Q?ElD49tZ+wfJ2xDCqBGY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a08eb8-449c-4615-6cfb-08db6c55ab8c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 21:32:21.1023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: md5M9dImsenkvmp+93WzHbKlpR+/xDRttKT+E2yADomXd8HHU39cu+Ha16zebTefMkchpHcM9nJsH9KJzu7uWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9479
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

