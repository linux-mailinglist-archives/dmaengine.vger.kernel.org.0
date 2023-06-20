Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E027375CC
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jun 2023 22:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjFTUNb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Jun 2023 16:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjFTUNU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 20 Jun 2023 16:13:20 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2045.outbound.protection.outlook.com [40.107.6.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB78E1BD3;
        Tue, 20 Jun 2023 13:13:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntHt2sRZ7Kvk9Hcs0pTSQ8nWsgPxE93C7QssBAv0KqGuyNOEq9OvvIn19OJdrbHjcTnfHrCCbXKGdqqhbHnSetKlQd+j5MMAJxETWxHyUE0J27RmQxGmaXQfq94VOusYij+bxzNrzE7Xg/0JP+P6o1qa5/Y6ioso8im1rBZA835ZGDoBvqH0KaVpei+9eFsmj4D64f5Oi8LoNEDhTTJ40XHVnmKVGvzV2diPLRHNFOV72VFI/7nNdl8lHsuOc7UZYRxhnsZF0p/NVKtLydCqIR5m38KNPlEcyEiWbdHMbbdcifnLktZht8xPtHwlXrg5mhqNQ0cGZt4t4SG35tTIww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8SowlELrPWxkRr9/us8d8rvbeSkIi6e/pnhOSy9jcs=;
 b=h7d4w9udTw1g6TroCNGmUATQj1jqBa8yowBDNy9KD14bFtUL+h5j5AL4KEY9I7rfQf43PKU55up/IEgeUqakOZWDHd5vNrPKLgEfnQ3US4mnB4EdSt8/MNDL5t8e6W3lvjm2z45FwwjnRSkAtYm8k6KaIPIi9Q2Rvs7NYo4MczI+QJ33l3Nq83T9ThR3KACMpvyxlD4nK56GKJKLlUgxmDG6n6zDmeVrFm+pR4VIzgkKy4KDnTuzQt3wU26IVujxpNqFmlIkSkgn6CClcWs5IsT1D4vDqJ4QFZ2xH4fYzXiqhjokDq1uZzPKyYvRoEtr3qMXGXB8EP27a44wXHFL1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8SowlELrPWxkRr9/us8d8rvbeSkIi6e/pnhOSy9jcs=;
 b=Rs9pdT6gRieLdR4yqOSj3TRYLJisH3QXXcbb+Y6Lxb0rHGvZBl2eWjXI9IK6PtwGOueUqIxKT+9gRdN8ohArQMmb+hJJ2Cr8h/agImtxR/q9BQmVcB9m90vogdcd38w6tm40BHCVSmhwoGCrXOK1YQGL6CjiYUKjkRQRV0tQxNk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB8903.eurprd04.prod.outlook.com (2603:10a6:10:2e2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 20:12:54 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 20:12:54 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v9 06/13] dmaengine: fsl-edma: move common IRQ handler to common.c
Date:   Tue, 20 Jun 2023 16:12:14 -0400
Message-Id: <20230620201221.2580428-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620201221.2580428-1-Frank.Li@nxp.com>
References: <20230620201221.2580428-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0086.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::31) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU2PR04MB8903:EE_
X-MS-Office365-Filtering-Correlation-Id: 39277f8c-2bec-4511-aec0-08db71cabb0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a/shknRCa3Avs9lTS3CcbQbZASWm5cIb5Gpgr1cERgyz+xBJaLtHB8xuq7Sc+lKbf0VekS4PTMVya7QTY4vxqwcFWw+Lov+sQWK2Et/apExQHd4yvvI77JziIoTjr+3duoBaQB0syXkIfqYtLApfsAz1ZZkJdCQp16VyCQeZgxzjBRk+4tMfs2OBAUbGbONuva76zIlDG7oPLs8cwjhN/7yTS6DNygjCiQkGnys+gK/MeZAEgYSdLhauT5nbYb1cWb2wv3lV/qw+VhOrZl1pQv/YWEBawmwtEjgV05SMwYWxMXXKXc838s9OfZjNjnYy8xAs7XBnXg+S7O3KAUHVGBTiAXsgUYB8weqwoDiqiuTEAYy1lhmFcJt3n8Ow2Zq4/qDnvoBUpDdYgS29ZL3llPR/k+pyRzc7nN7r37m1BIrr8rsq1Evl5DZhGTAltH0ugJSIvgwoUJVbPxRJ9rEL7eQVP4RKpYCGJqbn9O/yYvGVif8gn915I+hkz4N4XeVlPlzZDFnjJ2bVAlsj5YTOnhbHDW2xe8ut5r83w7dKKhk10w+qJpjHMkY5m284NAV+B47/WNfD2Bml4qNatMVrpG1vDw83bzhR2lW4vzySaBXTiUjtRkst1SgLOAj0z2EpDsyqQ74CupEPrLzT6dIBgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(451199021)(83380400001)(66556008)(316002)(41300700001)(66946007)(66476007)(36756003)(1076003)(6506007)(2906002)(8676002)(8936002)(5660300002)(86362001)(38100700002)(38350700002)(921005)(2616005)(6666004)(478600001)(6512007)(26005)(186003)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mjprSYCBwdbk/l9hAergQ5ODkiY+spxM14fBcN1l1VVH2UGw91jJ+Lr2tiBa?=
 =?us-ascii?Q?89UZgtWz08VQl2o9kwfdjymEf70zkzJ6mQBCmkL0H/VbNeQaUi847g5MMdxE?=
 =?us-ascii?Q?GmH+3t9NkuI6qwfiXOgX2SByDr02KK2pu4wEAeAlvP8x8GQ/ACykOqDUWIqm?=
 =?us-ascii?Q?KPtar4ab+VSVM4WpgRY6x/Lp0mhTWFQYwCp9NjRcO0wsOfRZLhCm01aKdoI7?=
 =?us-ascii?Q?HlFxuOwXJgXSuLvV2Pmd3MvuHuki2SlK2WSRbCzbDLkqD4yNU2yx7w8NMX9K?=
 =?us-ascii?Q?EfiBJEzZfRW5vJp5Gm7w1/XksEvp0lyo6cHWIsVpyypJEXlIzwzpN+poBsUH?=
 =?us-ascii?Q?Usxa8A2qxXV2bQebvCwqEz1/ZKzPlfK97l2rdkntXyLIJyOu6RDZHmLdokHx?=
 =?us-ascii?Q?F9X05C2tKukwsj/XrSTO7a0RwM5XzaZ98Xcq0qMLhjhT6ZPgXVfjdRsGl9Ic?=
 =?us-ascii?Q?9PthCGLw3+YvxPNkB4Pr0Wu0CB6T/YAo035UmyAfKQzNDfGk9WEEoCUCUUha?=
 =?us-ascii?Q?3WlvhdszzP84hxgXH5StC9OMBiKKZyPYyhDE/AoRVLuo2MUJpSulP1bGdxuS?=
 =?us-ascii?Q?BGWe2SN5xfyj0siSAY5spqEjEMVrEi6kYj7WK6lTxC7lPKzCM4NFwwGPfj2h?=
 =?us-ascii?Q?7GDNsOTgfecX0904Hi/RJsTJP4wT7QdtDKEAddvV9/CDK4LR9JP6kaA3LofM?=
 =?us-ascii?Q?M7482cyIRpbyUqe/KnPdHg4OM8UwI8YBHxCALNWwEjJQ9DcP9Bh1QrbYwpn/?=
 =?us-ascii?Q?xcF7t3SqhuH2lgXgTorz0Cm96U9f/NF1YVyLE6bhFh9VqhN6XS2bhmPGWrlB?=
 =?us-ascii?Q?aoLJjWMBV1njEYY7evkza96NruQn/x/ldXiDqtIDbr7laDp/KUrl25/1FygR?=
 =?us-ascii?Q?am9LT7jQvhQVLFff+7ZnLtx9U6Nh069DQxdMx5/d7EXVVszjF4sSmG+uHl+E?=
 =?us-ascii?Q?QMro00TB8JI39ByGEiqSox5dFDNteaQ1ZNkK4XZslA98htPCdMHIZqWVgKeX?=
 =?us-ascii?Q?8J+w7iXdtsFZzwSEY/4iN2CYUM310IO0Ppv3PM00QVurZX4J405TNCcD0DeK?=
 =?us-ascii?Q?2PFQ3zCCuqiJIf7ZQGzQaRowB9XxnNg+ruagJ4Q5yLQSltgTeDRtGa+WS4DJ?=
 =?us-ascii?Q?wPEfjCWzDz9CQ1jev4xkMttYqMCyCVJ+OpCbXGJy4z6iGych1Ly5jtV9JQ27?=
 =?us-ascii?Q?9lhkXeTEDCuuFK5ZmxDDEIOVuyRcLjjYgTmlDXyGZT2wifOu2P3U2vCj9aiz?=
 =?us-ascii?Q?9q81la0qa6q7nw5uaRX3gDxtV5AA/5oeVtEOAh1ih8O0BkuQVB3qtmIJYeVr?=
 =?us-ascii?Q?/nmkN/5aZfl7vqFqqXKsnfbjTcTNnYwE7If58DM8M+Ef5yZzWNG36nvucsGx?=
 =?us-ascii?Q?BrlYisv27vf47MoRP8Q+yUxEOkiFFoeUZKKK+eOxDX7ja+XNL3q+9S9fZL7H?=
 =?us-ascii?Q?/LhnM2jAGGm0A4LDzHra1KvBNU8XsK+++oZOEm4RPH3b0dRjzriKyjDLC0gS?=
 =?us-ascii?Q?ZSbwdBAp3lP//91PALJC7LX+mr1xm0ON9AOPqVaCXGl1RSZNbfWZLBUWxGCQ?=
 =?us-ascii?Q?yVxzyJj3d5/XzI4aPK5T7kK6BR/yRdy0c2fXv21g?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39277f8c-2bec-4511-aec0-08db71cabb0c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 20:12:54.0029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NrhsuKUhGFwBBa30MkBW3L7ibOtJQpG2qXMedlBV1qYyOx8EkQAn6n8yRtGSbWI/ctfZJFzaDxZridH72UjOdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8903
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

