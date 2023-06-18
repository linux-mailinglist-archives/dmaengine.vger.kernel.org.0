Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A6573477F
	for <lists+dmaengine@lfdr.de>; Sun, 18 Jun 2023 20:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjFRSKK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 18 Jun 2023 14:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjFRSKH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 18 Jun 2023 14:10:07 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2050.outbound.protection.outlook.com [40.107.105.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81A2E50;
        Sun, 18 Jun 2023 11:10:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3dzpqpcUaWAkYA8P9kxpr7Hj7UqjpiV8BChblZqOHs9XpAxAjCMvPa0nq7ATTyvF/nVAFK2tz6+ejjnrzC2D7FEWd9aAsmGAGollMHy0xKaXKUCJoQPW6iQMV2FTNuzcvTk+CKnLUKd4Vj1rBsggX/aiMO9E4yTQIzuLk/f9S2SGrH8PHUaIk5J57KztSVsl0htRn6NkE2YCpLzaeZkNtLA5oFZ9WKL1kbtxIpQtcP7DUvCG+qaDJsMvxtAZ68uKX/6YQv4go1tkAnG0pegExM1XM3kNU0pd4Avmc+KCYqwceYao+/f57tYxPJKjeusry40wfF2kvZbG4I+mBBbcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8SowlELrPWxkRr9/us8d8rvbeSkIi6e/pnhOSy9jcs=;
 b=CAnG3AEL7gG12574wdB0ryau7PjWv0Qi+bJzn9UPijEI6CgnCoBnDGSY0Rzpo5LSW76Su+8MtUYzOMW2ns9HMKZ2Mnf4o06ruk1v17jYu8ejbuTPGRdk2oaaX+hGe+zDq2FC6QRSKvQw9WPNxEGZJldF8UkrzLVJW3vKqw0Pj0Q3tT6Rxk272pzvrtv3HROsqJNvRWqO8zTP122srB6PPXdWxGpoLO8PSq1QarkASxC13tO3FoXy6NxkDJXPnrUc5fw8mGTlb5sGNgPBpsdpEHQ0gMaQA8HZDjE07Uuthi3e/+pdUcEBX+SbGNxbDFVIzFn1PMe5b2Fk9DNAa6CVMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8SowlELrPWxkRr9/us8d8rvbeSkIi6e/pnhOSy9jcs=;
 b=Yux4NYge7hXBqwK5BS1VQBiUDNGPIBk2T9pVwjqd2FxGrwCwJGSpcElofWhX0Rz8T2ArzHCXepd68lM3boWWeQbUK1pNAHuKyatZEj2BY3gzgKjGo3dcOjseOYQWQNVpcYALm/YkKZ0/LmJPg0bcuf+SZoOaamPHX5i9xR/340E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB8PR04MB7019.eurprd04.prod.outlook.com (2603:10a6:10:12b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Sun, 18 Jun
 2023 18:10:00 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6500.031; Sun, 18 Jun 2023
 18:10:00 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com, robh+dt@kernel.org,
        shenwei.wang@nxp.com, vkoul@kernel.org
Subject: [PATCH v8 05/12] dmaengine: fsl-edma: move common IRQ handler to common.c
Date:   Sun, 18 Jun 2023 14:09:18 -0400
Message-Id: <20230618180925.2350169-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230618180925.2350169-1-Frank.Li@nxp.com>
References: <20230618180925.2350169-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::23) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB8PR04MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: fe2fc4cf-d894-46bf-5453-08db70273b5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YB1pC/KCFW+EZMsj4f0iw4uWnuUTy+k7QgWU9qK705MJKvB8dNi6KEz9efK01iUJ1i4fxX1c/548VDJjvsLsIwjtommUM/FMwAFZe76M0cE4o5RZ7IfhzF64lGkVrbYEpV/9lUDgzm4r5rH3CTv8PWZYJS7xVCcmiyCG5iLaGnrPE+PPjDthIYpb3tigQg+Wpvgd923ihjT0FVCixdkrSd9Fy6m9MA7hJDdDInuZNuYTO2HCDFsy6Ge6KrEcsC8mk5cHke6bJtmw3DKiYOF973V9FsZD7oI/VSxPIUGBLn62EtrXvLoiGcnJ57HaMsREamJcMBR77E7NSjMzpFWawlpmY2kM/kjK18ssWo9+LcVnBu44hT6awSmOJfeS1lXUiwQvty2+0NoC460B/Uc+B2cMDPlRBT4lfknODhxE41HzGHmH1rwSg40F11AoGCqYXGd3lJHfI0lQGlBJZtj3/pYD0M7Z5YYTDzZyokExA1+wqO+tjLQdKGdYzxeemrvehmRl2JltOdqdmh3Jvxvx4nGKjdPGHQmSAZlUMB7g20/z6JVO2/XGLN5ZuqQbKKqu8e7ESur0HNfopLLRJG3XjV7vFdUFNaDyqCGrQGwQgdhJiqL/q+j4gqdl8rIBH6fX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199021)(66946007)(316002)(4326008)(478600001)(66476007)(37006003)(66556008)(86362001)(36756003)(186003)(6506007)(1076003)(83380400001)(26005)(6512007)(6486002)(34206002)(8676002)(8936002)(5660300002)(2906002)(6666004)(52116002)(38100700002)(38350700002)(2616005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mmw1V4nCXi5YGhqPMdq1GhAWecm3w9P6NEUtb9qK35vUhFg0nRBkxl9dq3pd?=
 =?us-ascii?Q?9RJQZBX/KxKKy8frvKWJBrD+kAfEU0KpTV1+QLuKl6c9ssszKJzRwyoHFI7b?=
 =?us-ascii?Q?+RWcvSY89nQnxTHbmkXUR1tSm4OLKYQvzHVxZGi+iIie9MAJwU1JHLsj5fgD?=
 =?us-ascii?Q?U98L7UOmVNthQNO/57kdapoJCuRZHMSE7xTa0djB8Rsj83iUCw8LcBNUntup?=
 =?us-ascii?Q?jBr+hPqNSdnyl09ApeQhDXpZM0T2ZLNnsboInM0YGubGe1jp8ipZhzpg2szi?=
 =?us-ascii?Q?UMqlKms/mS6vLZ7udfx4i+7tlRbcUnEvR8+6zmcbdsay+Gwx75pj8hCK3PKi?=
 =?us-ascii?Q?l7SWQ1kuEbaP6iTFSWnYSZhwmLJ+r5EaISP1n5pceTlgrqto3zkUVkiSW2wA?=
 =?us-ascii?Q?ugwdR120XF0sytaD/KH6r6xi+yX1qBpajqqEhniVMg6zY2xANeLwYT7nAvpG?=
 =?us-ascii?Q?VsZYfmHDTSI/PInuUbonxfWR+p8lBmbPrPxoWhIwpCC/liNNrraJRFE7G2Uv?=
 =?us-ascii?Q?ZRnqbo4AYV59LTyCCi+lB1tjLzTTWA2MQn+mUtvz1tpHGYwuSjIv6xGTqeeU?=
 =?us-ascii?Q?mcjjnijYldb3oBvv4qAKOo7eIqLeQCEPxq4VdeCZbb4JvSyjXVIcjq0BxYF5?=
 =?us-ascii?Q?N5GYi7K8izfIrMBdtBi7U6sb14crl63KNtXj/+YbQbV3fIrZVSZsJHKKrCmD?=
 =?us-ascii?Q?GB1LCAJ2Dx1SJ/Wzu94aK7H89RNL372W1VxbBRThi6JbkVQ2dizh6aO4XNW9?=
 =?us-ascii?Q?PV6MCheV8FHY7lmwpGXxbQQiP9Wr6ZUmP4ctRti7ik33PmeMEARN0gYa09lx?=
 =?us-ascii?Q?t1Ue1ag2ya9vs2shcLD03K6syWR3yRSnlbJHtbVFgI6vXRWSMIu2MSrPgLaD?=
 =?us-ascii?Q?SrAgk1e2kRa1FbGJIatWe9crw83uZ0IhQcI/sL6yL27T5J+iBQpwwsd+mo3w?=
 =?us-ascii?Q?65vNXhj+Zwi8XPeIQxpuZ1qP67K9kGUyBNmiDgqJt4/DCE+7lkV6A1rYvi8L?=
 =?us-ascii?Q?R1M32A27JT1ko9c5XfhGIElf5MuobaAmw9YysXZeKaI7zi+Pcgp1ZZ9Bf4G5?=
 =?us-ascii?Q?lDfP3v1obioEH6yklCOe39PG9SqeIlBoh2cWTLMR+l3MsJAU8MnTU1tn3dNP?=
 =?us-ascii?Q?181FHM2ds1MdwDz+hoKGlzAxKG2KM6Hdgjtrs2eWohy35fABfe5nCO3PK3g+?=
 =?us-ascii?Q?pop8SClumLi11oPJRd3qwr8OlHjt+9wxdl++GW16inj7aqeuyInf2aw4pxqG?=
 =?us-ascii?Q?yVcz6XBBILDNmA2/HWtI7aJHbkPmkvdrpOwVWfadttOE6mSRQ0LsKkK4lar9?=
 =?us-ascii?Q?dAKLIfH3qbGNm2BYZoWEJWD9dlirebxyrGRbt0kceb0BAh1Z4jTTUVfNW2ur?=
 =?us-ascii?Q?R8S1yEzg0YHm5X7XzRBbzJskhOdAGB7yfZqxyvhIbQBvUp8MZi2sOxE00grc?=
 =?us-ascii?Q?a2+0KF0YYikOKvSHVVdf9fH+4Ar80UX8URQsrOwrF0RzEzUw8OjTHl/ajLkq?=
 =?us-ascii?Q?vObWcLM17QVBEY/BDWuNzXZtgzEXkRvH2gDHLIGWFHqfYm3/6i0VbWEc9zO+?=
 =?us-ascii?Q?2/y5ZVnnvcGasRJXooIWytcKG5nW12m724D57di5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2fc4cf-d894-46bf-5453-08db70273b5a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2023 18:10:00.7095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MzrsY1UVDhEEeIA7nL3I4npIQMoWVGhJaE1JZNe+I53l0Dv/s1jC1G+yQkQpTxplDpBKUfsvK+fG5uypcVJDhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7019
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

