Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428B1715040
	for <lists+dmaengine@lfdr.de>; Mon, 29 May 2023 22:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjE2UGI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 May 2023 16:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjE2UGH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 May 2023 16:06:07 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2044.outbound.protection.outlook.com [40.107.13.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9A7F4;
        Mon, 29 May 2023 13:05:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2uZR2cA+Ak0rpxz0I5lVZT07vLWFvOZ5as53qfsevH7aeDATCFq7y+1OLazJd0ToAwBjjzCvcGfeTH64FEWc9GD05xtQx6LD572pnjiRdE9Qv2ytrJe0zx5pEjnizFEFW0BsHP3OHUVMx/87Ld8NpfufwapQZyp5qpokbjcR7Jo5yqqh4ClDAD+8PC6pP1ipIxZYYCcMKLXQKziYLo8suXHVTlE5UGT/TeReND/ehoJ6DhVm7oSXxupuX/qArq4wmnbCFXvc8jYO6ndIEX3UelQ4Z0iTBKCS6Ge4WPSaDBh9/bFZIHhYefXQOkk4pylqDlI3WI8jeG4n/bU80e85A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msrt5RHHs6IHX/f7JbgffOTIryNu0J13mXMJS9oOE4A=;
 b=QbzTL+q47Jt4eoIqoyaEQlRNMD250pW/tnIU43Y8J9lHjDWYQkV12acHim2pK9PeDf+tfVeIr9yzPcD/PSxp7C+a96d6Mgsuq4cor5Doz4GtedgQ/Sp6ODdwjz9rz80TcbZUAVKQaDeX+bsqF+zLEnpgqhVuUsXBMksMdNFMTeRcXF5W9oqXJ/9QurzALU40+i0tGshttqglEahcmGFv1C91z6ntH3/JzXpvjwQYryYqzmHk9mDjpYZwbAIcqYMX7VT6fxKKXFB5hoNRsHmGFd6AC3ngBxdKPHuh4N0aYD6SYHbTMqsDXvzKArJ98qinpld+zPpl5kn2GvHtORpJ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msrt5RHHs6IHX/f7JbgffOTIryNu0J13mXMJS9oOE4A=;
 b=NuEoz7GOku1LRwgFfEfNXhLTVGZEYmbpZpFQkekATcx+bjyLXVYvAEUGF+f8YTOjoMZxz+r/pqgrmi3uV5U+M7cRsJArmiH7xvl5TCXWsBguTbIdST9oblrl5fJ7+ZHE9mIKWcI+8tj1haYxe/5k/wNOevhW8Fhe55BPjmZIOyw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9820.eurprd04.prod.outlook.com (2603:10a6:10:4c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 20:05:27 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 20:05:27 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, krzysztof.kozlowski+dt@linaro.org,
        peng.fan@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, shenwei.wang@nxp.com
Subject: [PATCH v2 05/12] dmaengine: fsl-edma: move common IRQ handler to common.c
Date:   Mon, 29 May 2023 16:04:46 -0400
Message-Id: <20230529200453.1423796-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230529200453.1423796-1-Frank.Li@nxp.com>
References: <20230529200453.1423796-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0161.namprd03.prod.outlook.com
 (2603:10b6:a03:338::16) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB9820:EE_
X-MS-Office365-Filtering-Correlation-Id: 0567357e-1c7c-4131-e38c-08db60800b84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0vkEMBs81wWdr04XI6AXmW+wl7G3yN7Nq5f7t8MUfeMeXbIde3tGyv2C3KiyBuYOvcxGrZ1JUB0IGQ//TxO4xgoq6YdBtGtdI3K9fXNwUufj0OpbUKcjYC6fZ4O/cl9pxS5sUYFIqNxtuG6TC/+UctkMDnKm0qS28OinvttohdzgdugXpi8GEqXhAKbyqVeOUInpPb5bqThTGYJmwLfm8BD1qV6uzhzhJjmF9YbN4UCnEEKq31gTFlXnU+U5bAe7zMqh/Tt5e6/goJ9eq/zeWvVGXRXuZponWZehbjJUUzZcwZUH4lxBZDHGuMb5TLWmJXz9ePNJCQTmR1O1wOrW3ROhAf0lhmfjPcr+3QAauHH0BuxhaEEBzq6I76rvuxkhuw+xmIQHMtpiLqCKs/b95fOYSY+bUqVJqq2G6Aim9Z5TIxdboybM1vvvzPZn/mw+CjZ+IJRODLX2BT3nBX2/yWa8CcLvlPK1QPu9q/fXSqyYX/LQk0oRThq40Xp4u9QbXU0wrknNFwkXNpxfwUvxWkvpfTEMjZPyTV2Q2pPzNl9MIteT3lqHPXADs43xUydDvBqMekJeIvzlxg5OwFETSpyglY1V5T7168T60pGXb7p0XYrqkOCjoMoF0Jb9BrC0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199021)(83380400001)(52116002)(6666004)(5660300002)(66946007)(316002)(36756003)(66476007)(66556008)(4326008)(8676002)(38100700002)(41300700001)(6486002)(38350700002)(8936002)(86362001)(2906002)(2616005)(6512007)(6506007)(186003)(478600001)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?218cP+w7Mbkan/cWw4You4P2WEpHyf4EhYtQAKhEcZ438TXEyj0EA9krKdv/?=
 =?us-ascii?Q?uEo3cHZmdEyao6EymrNhYVG8v0HyBvQRiFngIwSnLrS+bW+8z9j86fVSVQpk?=
 =?us-ascii?Q?TnahLBZXlE7xFBqpDTwtgHzJ7syatdzxQ1LtGCOVbmRHNV6LkuAH3hqaY/Hx?=
 =?us-ascii?Q?cTJcIX4zVaO+9umH03fZYamXmYYPU8nyp3a7mUx982XLqdAbxTE52zeRF5x+?=
 =?us-ascii?Q?CaAvcNj9ikNFJhqqVD8hZBiocUTqKlkf1ddltQ64qTew2cBy9WFpyhQu4MrB?=
 =?us-ascii?Q?dj7whDbTptAQvs2xQdzCbBYTNihRlr4meQSQ8Y2Jl19kU7/1zT2ektvyF83c?=
 =?us-ascii?Q?4ckSARXE14WLvyFIzxs4CRjJCOrgJwaowuNIMO6+yPY0esf6fAspenoyJUQ6?=
 =?us-ascii?Q?herIf+Xgz8YK/QwLKb0WmyXSyKO7K2ne8OBhbNb5Dy7TgsFx2GR1cqNdFmgv?=
 =?us-ascii?Q?XjlSZ/byzqluCAolr4SQ99B+FmZ7svquaHbEPKPyv5UlMI4peE5cWUefpA3m?=
 =?us-ascii?Q?03Gyhiv4mM9XkndMuYOWiZfoj0ZEexfiv6dO0N6wHnvOY0Z4t1iyIqfUDRb7?=
 =?us-ascii?Q?/TxUM+xD1vRYtS2m9eMh23xGQGDKwtvpvNfQo8XCj27g7PLPXwSeBa3SFw2/?=
 =?us-ascii?Q?fegbeYgG23mEJUMDpKHx6LT/AMQvc/L/Px3/LBUna2XBN9PW57eMKrltKdm6?=
 =?us-ascii?Q?qiihara+rxm04KLrw5z+cUfynghB2bqVlJQD6f4X2m7j//ShEXqZLOufj4sP?=
 =?us-ascii?Q?TDJj9T6qYEjT7bo8OG3s/Tsgd8rjLXaIsPQ77vuOTTEemc1JxiV6x1JSWzRi?=
 =?us-ascii?Q?YOsQJPcBl2ZempQgYtOFbnF4YG7n0CKj0SM3xbFDKFwc31/3oEns189cHIFt?=
 =?us-ascii?Q?TFE1PWsto9Dbz9qG1cIsOv3uAF4fGwCzEAFPRyUwgpciNDumRWiF8VRzazrC?=
 =?us-ascii?Q?dfKnLTJ4204og06vIz+Vq5HuVYF4PKtTNcIfpyAHn2MOqKnfAOD0DnzR1FYC?=
 =?us-ascii?Q?ZpA37mzFyPMUaQUi0eJORzHy48BpRAyEayRou5f4mdrUR4Q0rHaAxVG+Z4VE?=
 =?us-ascii?Q?oVttEc+7/zZJRyJ/TpkgTgQKYdfinLsobVbQfkVcpURhssxFIDQLqD3u30nS?=
 =?us-ascii?Q?zYnk3BKUvyEpMu+7C4ay9PD8OPyRJPqZVCDnBnKT2u6vwWGskEhq68rDfud4?=
 =?us-ascii?Q?AcY8HgQJtQdzI7+gG3fu/5/b3K7sQAjkH5cgaqwPpVjcWLF8vhj/aaVUabMN?=
 =?us-ascii?Q?GB5vZkFe3jUIVTAeZ2tNmbXcFJUwXh0hleWAXKbTTfHAB3MMG9a2D1XOBvRl?=
 =?us-ascii?Q?Y6kz8tj8UikeCXiG8QrhzxDWbLesrCrriupwx7kdy7WZ/uU1pzKSQaAJ3A45?=
 =?us-ascii?Q?74qOaLEI3hMTGPXnkO8BPiB96up/rs6tyr1lSaj9WrvpB2MmqwpZFc2/Z05G?=
 =?us-ascii?Q?5X+XBb/yMkWhTvhQhvyg5sfethkIeuNNxOLjFDAfATq0ghDaqLVvTDyDJ2/u?=
 =?us-ascii?Q?HW/1qRjf8kf86Ifm9lDOhEJEjnWtG/AS2WMuhnlIiAzOqLAqdizfPH00nS+L?=
 =?us-ascii?Q?Y+wF01rb+nduBGVYCHNUnevhf3F5jeHptXK1NE/b?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0567357e-1c7c-4131-e38c-08db60800b84
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 20:05:27.0322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /N9vSLKP6CiOeyFu7KwtmZISncXOrzBq6zCfPyYDUYBvJgKD6/52m0sGa4pLqMkfzIjAo8Cpi/spVZlvqmJ1hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9820
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index e5c7497c1ff3..839471c42758 100644
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
index 2f13e687a721..71e19e20f1cb 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -223,6 +223,13 @@ static inline struct fsl_edma_desc *to_fsl_edma_desc(struct virt_dma_desc *vd)
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
index 31531b8bde78..9c0b6fb4cb8f 100644
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
index ebd8733f72ad..af1b0e8a3021 100644
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

