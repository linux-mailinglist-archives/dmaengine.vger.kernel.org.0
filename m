Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346477334EC
	for <lists+dmaengine@lfdr.de>; Fri, 16 Jun 2023 17:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346031AbjFPPfm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Jun 2023 11:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345789AbjFPPfk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Jun 2023 11:35:40 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2041.outbound.protection.outlook.com [40.107.104.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F194A3C02;
        Fri, 16 Jun 2023 08:35:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDu5hbnpdK7vsKfXnrImAR9QFG0vUwOc/xcPQoNji8fQ0KNT9BrizZNL3TTBk0K4FLYX06YX248DAKdVyrArTNADgvFZTgztAY/8o2It0WZD7rFv/MILQ94zEZaFRYLVn3la7Lm92Gm7jZ1b2CJMBLzXXSblKY1yc1j0HjiVm3+9XRRpZ86ficXrTy67gr0j3nRKbbJV7MzyvHyozb7mnSCZO04qShD2rB2yPrtNeE57CSlU9XiqMpmvIGBsICQINjR9WNGfOy8ymcepFdbf7bWC/l6JB7y+Vlb4p3lzi+98hco9Cu3Jh5JTrI0mEoh8WvKg+t5mR3g+DF4lrCW8tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8SowlELrPWxkRr9/us8d8rvbeSkIi6e/pnhOSy9jcs=;
 b=KPavZnwxOdZiEd1KF3oe8lJwc3kKAvt8ikT51nS7JFWoMPPBHOPNPW46WoqgN/lOrr3fxR6cbZ+VcqyEzUJSrNJ4fsLKQDH+mzaC8SIkhz5OzOhNT5BQu3jPcuts+wRdId/9oMSOpNaBqakS67IqodxrSlB90xxcdmB8ace6LDXQuP3n81tELDgbBiSjtoYBNU71n2qcs8zm6/OIYUKf5JMfJFJbGpYr7g9N7dgHL//o4vS6rcF0jHsI7a+ZTvNSZ7q81g84g5RtKpx0l+cktyT1lqpSD3rr2gIeUwYQxi9tREyT5kYMkrO0R/IrTeJEaWY9xJksds+/dVIvpHV9SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8SowlELrPWxkRr9/us8d8rvbeSkIi6e/pnhOSy9jcs=;
 b=Ajvs02oL0JliayseX4E2AqE6/skkTAwVPAsgAKQAu0xOTgnWt3lSAPIgfuP0MDkW0h15K8XnNeFpIYzXzAe9pyANXlju4CVFIDLW4io+zvF+zlabTfj71Hk0Cb/30vFlvIKB5di6Ivc+vHUxUUATH6RAZpbw1dpTkddI37OQX1M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PR3PR04MB7339.eurprd04.prod.outlook.com (2603:10a6:102:8b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Fri, 16 Jun
 2023 15:35:09 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.035; Fri, 16 Jun 2023
 15:35:09 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v7 05/12] dmaengine: fsl-edma: move common IRQ handler to common.c
Date:   Fri, 16 Jun 2023 11:34:31 -0400
Message-Id: <20230616153438.2299922-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616153438.2299922-1-Frank.Li@nxp.com>
References: <20230616153438.2299922-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:a03:331::12) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PR3PR04MB7339:EE_
X-MS-Office365-Filtering-Correlation-Id: 81e7a1da-4083-4bf5-cad6-08db6e7f44c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rX6bzVGrRaFIv7jWzZAZSVcaFX8ZtfxMklje/inKBkqpy+Jv7vzX2xUdyqcBvnx98Div67gZ71ts8uk4+0CIWpshI0xhMferKpUba0ph4zUGiCBJt6l3KQSBzLtnOoWUbABZ2Jb/nRY/Wb9CFdOm0fief4hbOSv/+lnIafjIU+31Rj4UHilRBX8L4yPJzWnmvzzScYGll9oe1CK+qJfoSAZwpM9bhqb+xw7nR8Frf4nWbtHTN9/j/oOAkT0EmvycZteAJp8d6YAx5wXhe+iu5d/OVYbTIOeMrDEGry0/ruHd6J7OBiA8q1gnF9pUcXoXnh5dj+rZWg71wKft3tYtX/yZjLNBHJY1zfeFQL2mqcGTYUxWKzJRN+eP7b1nFb8NHGDzqF6xbJkkUuNc2gbfG7vwtuDPIWNRIvnRjAUE7ur7zUxxLovDNhB/rPW8RCP5MUaiSEYUFTuLoBQNqVH9J6ED1yLF9UUYiXLALCcUrphIKU/LEFdA/jXtcsP9Ndwq46m/FfcYjHtmE8WB6fGCk2lkDOR0qYpogwWLCcDl5EeR7evNhXRedOeqakk4MnWONQWRLED3Y1PG0bFgidjdPc0FpsPxybZgX0XIR7pyyNuO+m7V0ytd281NCFnblx9zVE9E6e3lMrBXQ1vWg8kR1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(38100700002)(66476007)(66556008)(921005)(66946007)(316002)(2616005)(38350700002)(86362001)(186003)(52116002)(36756003)(6486002)(6666004)(26005)(6506007)(6512007)(1076003)(478600001)(2906002)(8936002)(8676002)(5660300002)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z6vTg6dJaxuLyyjyja3eMey53FLnT1qFsBhWXcIzroPGW/U4I9AZJZx21Tfv?=
 =?us-ascii?Q?BVuZJzYpZhi04fd9UWKcCuxxfhMEZ4ofm8fCn3eVHneNrTtinrEKGdJ/+kNe?=
 =?us-ascii?Q?pknywHE2wjofRMy6Mecka8R/QbouY3Ms010sAIlk/2DZ90gi6F0KcTx0Avvp?=
 =?us-ascii?Q?GbGF+MpHaVrkjYPwV0D/t3OkTGMrHWCc6mczUyfSEUZedQ0R8sJqF/7XfOM0?=
 =?us-ascii?Q?Wnb/JgF4Jhk6wIKAEPhYXUm1w1IY+vpAjA1aCbn52bqNynnBXLdUNplzWLUf?=
 =?us-ascii?Q?6+3L+QVJHiOsPeW2Ps1PDcYU54jn6Y8tYjHsrctaUEJGSjPAQLpFE2swW03W?=
 =?us-ascii?Q?wQllPjMgLEAs6ay4tMFeWihMQcj3p3Pdsk5ZGPHIqmrW3OQ+ULC0hHusN3LP?=
 =?us-ascii?Q?XyAD4ieCY209i4C02kgc5YwnNzRsALdXqdvoEoBwtPOOyWD/vUec0NoTCITn?=
 =?us-ascii?Q?77WKg6yZzFXnihomXkeL0JV3jWY9l2pIVL8TiabMcFQJI+78gRnoT6PfNhzi?=
 =?us-ascii?Q?UQ7CTDlpQIP+bYJz6Zkv2RCg8RjhdngKxurLThsyXTJcw9xMh3Tn9ih91jQ0?=
 =?us-ascii?Q?DVQnYQBxU6YBdetes3Felp9QW6eOJOLPI2h4v4QUOK/8BFgB3XsUsndd/0np?=
 =?us-ascii?Q?LtKUyMVY/YFSeYe0ndUCthEipuUPQSyEIwafymTAKTN25tkJL7D4kMA7Zd2d?=
 =?us-ascii?Q?rtOYisqXktacu5kRaG8p20ZZ5IUITbEA9YCC7s+dun9QvsEn5Dfmcbp36cFj?=
 =?us-ascii?Q?+zSVF6UQSaW9sFDl9e14qs/Gbcza7vVBtq4icYbuMyiza9qZrB4VhavOJxMq?=
 =?us-ascii?Q?rNgQ/xaKGSoKeq00WStHXkUJEmu4UhATHAlNGlxaLT3aFAPzWBHnbvf3Qwpj?=
 =?us-ascii?Q?/KwG+yrU/tz6SnRHsFXxY7ZUohmmB56PqU5g5zau+eX9eTO4fQ+h0CTQ+5ic?=
 =?us-ascii?Q?oRiT+ufbh1ZDxUNO+tdZ2S765QRTx47vRFduMSSPeEZTbci8iZMx3vdFXYzO?=
 =?us-ascii?Q?rcTxCPtf1vZ+aNiv/kVmoYtedzjmAMykGDV5H+oflm7LmK4VBhqmHqh8fJel?=
 =?us-ascii?Q?unI+LhMZx/GmtUICRG+ilp+QAZjsm+ZrmgXKjYdjyZTtNiq6qX5aWoH9odhM?=
 =?us-ascii?Q?bKne36cPGqsxTUUbB1iIlqxPLkmD14xuFKJYzSE2qG4RE722N+5WQFVLDi4r?=
 =?us-ascii?Q?vGC+awHmprtNHOje3x3xo+XqygSHgkk76UzVhbIoXT4PK/7qVnxRSxwFe26L?=
 =?us-ascii?Q?2/VTOCWCEzKga7XwZHUJZuSwjCkcjy2+Yod2b2qvh8R351OIggpJWYdBToei?=
 =?us-ascii?Q?jTei0BI0+BuvUQUGf6uqoYz7l6zfQ0sDo/YlXp6jOPpqt8muPjpqY3nJJXG7?=
 =?us-ascii?Q?7YFVAA5H6lhXG5b/8VoUbjYM9QEhtNywMFsRF5e2j359fMHEXazJwv8jGZsJ?=
 =?us-ascii?Q?spWQvldJ9tVNSIEIWWUh28tB1dAelkfo35OyHXFfhcun5kKHzSk5NrC9SMH6?=
 =?us-ascii?Q?mLy8FkxvMI34CCF4+YpXX6QmOQcg3bzUF7rIuQxJ1a4CMpOoSJ0SAY+e0EWA?=
 =?us-ascii?Q?XpVkNyX/oP7VZInKdl8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e7a1da-4083-4bf5-cad6-08db6e7f44c5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 15:35:09.8366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DKE6bHi5EhUYBes/fX/YcWGa56M8anZtHVczuTQx0DR+6T0tjJSRQRuL9PkuIVKoAeMhQ40Et2PUebq4ntQBFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7339
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
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

