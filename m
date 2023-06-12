Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A20072D08B
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 22:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236841AbjFLUfK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 16:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237616AbjFLUez (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 16:34:55 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2088.outbound.protection.outlook.com [40.107.8.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1187AE57;
        Mon, 12 Jun 2023 13:34:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zn7+RplSkIOJD2mVSd84vl6F4leTSNzIjSZ455C8NKEsc/XGxmDhW8ERbs/+jhMEZC9/uRqf/rgsuBWxS1gT0wiR9EJbCP9gMvquJXks9sOr8ENZd3jJZdU/gY5G0wEO4HjNFZcvhgyKTBcIaDXde9R3+HQXpgnHyJIsredRCwg/Ay+WfztwoR/nSEow3pLiq9C5Kt6dBNmpq8wsqOkj2utxPWsUHUqK/daXqt389atkwO1VaOObxEO3Wm1J/G3QwxV5m/Uv2VjUoftS8VWPo1L2kaPUTt1liT5UHNPdvP/5poHdU1pzdfwKtm4oECe8VxfxgoY58WL8c49HT+86FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8SowlELrPWxkRr9/us8d8rvbeSkIi6e/pnhOSy9jcs=;
 b=gpFgAmD+Mm3G/oi6mncHHqpl6R0Up0bf8HrK0OOWlqbNTPxAfo01GCVQGf5aSq9X7FWoRfoHCdmDjdOXfXnBUyts6tOsra1hRx0NSj2SICAHF7bRKqG0RS009k1Kc/NjSSQFPys2f/RZSm5VcNVLVs0Sdwr6BTLLEgcmj7fjVkaC1mt4e6U5rFv8tzD2AdTeIkknv9COrOLoVrAv4izhsfPCbujceufF8ExlzL5BZBcNGrwY9UnfJZM4qy4FxLSwOhFKvj1xKTFu5AePTT0qrfbNO8yaGBW4xKm46fD+9r+CVzlRN+i9AFQqt970ndFT3BvsUDAT8SdLAF84YmG3pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8SowlELrPWxkRr9/us8d8rvbeSkIi6e/pnhOSy9jcs=;
 b=ROF735X/4mrBEkBKyeGwRIbqONthS7JZWB2kOEY6iA9UzpJe2H1krqwKd6ohVgYeYG3u+qM6nNAdi1sKNjY5sL3KzWPYI01NTdnZSAIoZTU7/pBlLo13A9ah7/inAGxy79p4mYj4XNrng5d4LRNGHa1iCsn66qOWyNanDbEeLl4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (2603:10a6:803:51::30)
 by AS8PR04MB7975.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Mon, 12 Jun
 2023 20:34:52 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::602f:42ad:882a:5ca7]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::602f:42ad:882a:5ca7%3]) with mapi id 15.20.6455.045; Mon, 12 Jun 2023
 20:34:52 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v4 05/12] dmaengine: fsl-edma: move common IRQ handler to common.c
Date:   Mon, 12 Jun 2023 16:34:11 -0400
Message-Id: <20230612203418.2017769-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230612203418.2017769-1-Frank.Li@nxp.com>
References: <20230612203418.2017769-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:a03:505::16) To VI1PR04MB4845.eurprd04.prod.outlook.com
 (2603:10a6:803:51::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB4845:EE_|AS8PR04MB7975:EE_
X-MS-Office365-Filtering-Correlation-Id: a24ac35e-f9b9-412e-7047-08db6b84798f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gq64IC07+vXTyvYgBAMh2JNBuPBNtiw+DaNOJaaFts/OkiPPiH6lAo1Id8gOYezYFbdv8SLOFHNKoF5HbZo1VlaJZDBwG3L60dYrSj0NSklTassGTa3bY5FeBZm2AJ4mtKT2l0xxfCS8XtK5h4CwXqLPIjxr+HXdqRYPXdxybRFDm45pe8J7mvNZREXQVUL310J6R28ESEeENoE3rQp96cXsfbGC+e+y1QAhEBVDMCk8g37c/9Olv3UcU3vlhZrPxNVFHgkEQwv5yda1H5UiWI+H8KNjHwfsoulUWdT5g/MwQ6AMrg9ZwX/c0Wgwzi9yfRtzTkwf0cFMwQ9RgqMNJ3gnTZvRWWjiv+0CEcVRQ1ILzV4F7xucD7SAxVLTuAFWTg1waZbCGiWhBiYXMeFya5BXA2L3n0bQBJqNdkRjEoOg3GBhw1vdn55VwJrfIOftXAwbsiAFz8/gisOw9x4liMG6foiypYoNhTurNRgoJk9gdtXTAk7g+OXkiOUT+NZbU4WaU93mqKDJhJBzizrYe0aZDexORGOa6erCKLa7Yr1u3sgF8ytgcUefp4c4/jw+sNgwMoximCwpv398Nkc+xI3arEfi2zKYS99vCX93camE6cjZlegxAKFDuVPi2ozfMt/NmdFAcZU/risKJ0/zQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4845.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(36756003)(1076003)(26005)(6512007)(186003)(5660300002)(41300700001)(6506007)(478600001)(8676002)(2616005)(66556008)(66946007)(83380400001)(66476007)(6666004)(8936002)(2906002)(6486002)(38350700002)(38100700002)(316002)(86362001)(52116002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o/CXghlh9hB6gS8SEyWpFYj8LPtl9CUYmzrsrGgb3Sw/xeW4crdKTIPl6ANY?=
 =?us-ascii?Q?mHIeRwCiyjRdYn+VgLNgbTYQsB6hFfUwrgMOs7NSu5YGLUzb6Z2cLRwFzvz5?=
 =?us-ascii?Q?dF0+0b+Ld4v3b8PpZxKxt3VGuhfm835yHjQRVzSWhsW1wl8rbEiNiKJ9qZkF?=
 =?us-ascii?Q?464Q3LecH7h6fviGhdhup+duDapoGbOcmnyYrDpPb2x/G8HOXTEu0q/d3mFK?=
 =?us-ascii?Q?oNnQHjPGUO2xUvEZYOv+0vY2P7ZLz4lV+B3Fk+YqSoV+XTlm1WI1mn3UhyOK?=
 =?us-ascii?Q?DL1jCALmEQPN4d/cki4dc5UGiuf0iBfk/y1vg6IFD4z+YOhTLoMr1/FdOa0x?=
 =?us-ascii?Q?sFXuU4A04Q/P6AywSfYBKkGVPZFXC/MDd3RSZCEBnxwZR75selC5hghqw2sB?=
 =?us-ascii?Q?N+tKjyL+Dw97KLzdeULokzKPmj/FCxiDw2WQsNZs0nYDvuHg3+62382QHPCO?=
 =?us-ascii?Q?oF/WqOcQKnX+k8OrykyX9ZyiRwWMZPB1gYt1OhMzQYBjEANU5CkaWwjUHc58?=
 =?us-ascii?Q?hY63VO8r74jY/exS8Dgl6x/tjLWLtwTQvnqNeTMjMCuiUJApM8yrm70dTYdG?=
 =?us-ascii?Q?T/PgalZdiOVvunigeMU+v9amafL9gy6ohywjQPd+zkcCZ4+d6gLsnFPUxS5p?=
 =?us-ascii?Q?lMGXZmowdEtbFOmrxEYE+WLXofmgGtmRv6WaIw8zkeVtELaa90B2rfgAcrhq?=
 =?us-ascii?Q?1qaJJf5B1lKybjQX/XU9Pc/S5VrytuPGT8RwjziydKl7EKcgsQ1YF4lanEnW?=
 =?us-ascii?Q?JYzfA2Agk45vKn4j3xISMgQSyvFgcm6zQaeDkS/Wn5FBldwmxFLkgNpaZVOh?=
 =?us-ascii?Q?zBjxhuayaX2hbVqMdEDDcauEmGKIzuKPwkn/ZIsFLWH9H0H56776acFTHWQp?=
 =?us-ascii?Q?c98vDhDfgLDFSuCUIN1pC8nFaYjWH2NEQ7hOZtk8jnaBV07mcgC86jcXhIZJ?=
 =?us-ascii?Q?Xe5Ra1XKAwr/PzaFQGBegEMsEoxPApDEACQwhcLB19floi8CLc2U3JURMwrE?=
 =?us-ascii?Q?i2xiquk25B57HOdAbYLcQQHCfpE2QygOVQllDj1zNXYZJt1PmvhJEI8LevOk?=
 =?us-ascii?Q?urwQUJnImh4zk2qPrBN3u9n4McVDoRnjS3Ie+EN42GVToeOxjfbcuY87pbNa?=
 =?us-ascii?Q?E42s8RGhITizyjxpDVNNf6tOyqd4Lu3PsGQ62+oF+Mg6tLJDwuajk2F+Vccm?=
 =?us-ascii?Q?A+TUQ3ZgQXHsF6ur2Y3DQVAryp5CtU+HEIMBczON2Baa/rI9wIlvYNxhPTlT?=
 =?us-ascii?Q?RfrPBVbLA07T+qgLYgLS+vHCVq1RjPoK2+yQR3JqrKpgxtD/bo3xOyk7CEI4?=
 =?us-ascii?Q?kKsTMw9TO6CwgMGQcwIY2An3CLEw+jIXWUaJQRNZUYXhih88/n3Q98ZkqiYN?=
 =?us-ascii?Q?rjwjwX2aFTyAVYjFE6TdC07J/0NWpuholQhG02jev0Lk3Wg+93h4FMME1qpp?=
 =?us-ascii?Q?vaoRx6TsULdTJbAjER5U1Su1VmdE3y2W5iZmAUPmI9d6AYjjChrC9p/TWVv7?=
 =?us-ascii?Q?b+KOJ1Er2Yd4kt8jI9rXv3uKivsLaCsGIK7Ia+BBTzvmqmqf+HTfvbiVMHKZ?=
 =?us-ascii?Q?NHlpCMBc7jZC/gHkJAs0xOJww1Z/OX5INP4fIeM7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a24ac35e-f9b9-412e-7047-08db6b84798f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4845.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 20:34:52.3905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rDRrpMCUSM3PGEaL5G+ESQY1kieXsdRr5ueW7kJqp6hzDdezslQj/+al2xF7vEByk7orcazA0f/B3qpTrj61UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7975
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

