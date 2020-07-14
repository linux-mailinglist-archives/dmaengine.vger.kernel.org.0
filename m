Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718E021ECB5
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2020 11:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgGNJ10 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Jul 2020 05:27:26 -0400
Received: from mail-eopbgr50075.outbound.protection.outlook.com ([40.107.5.75]:5605
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725884AbgGNJ1Z (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 14 Jul 2020 05:27:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZECcogu7cEgfVOYDa2IUZkotS81U6rdtvKaXhvCLR0Zr+PHy9xu35s6zBLZe+BHPjAiFkzTwYUslIOY6K9NudINAB8VHBZepmVdoFNoM3TEbp+BNS1cMOJHThaWX9ETnGY30K28ON1Ffjj5im5cE2eRtl/fpLCMDaljLD8SqG3tLzxIKF3bvKtPXX59TmuyNnJCR+pShtJolu1KDEI8SK00YmfNIaaiOul4fiVTm2aVOfweEr2setlQ5NmqH5rGQAlh7APyFwGupWbnT7wgdWIsOnyLpK95/7zuOOcXdBo4/zdoORgvyld+ZtJ+nFhThQnLtDYTtmH047Ee78LJvtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBl/Yslh0zQAo/MMEG40uxi0GNH6EHf2t3FgUYJlXJ0=;
 b=L+qCeu+vNR7iU7rnlboJc7MQGVfqTeVZ72KlC+ifj4ygqWBmiM90rwXdlGqc264m8qtKjWqcggwEnc6FOmkNj814Xbe8+JTCanB2VyGR2EK7ktaM1Kx5zbeDbeHYh0trN4CJrTWWqdB5uN3b3ypHO1efSDXY1F2DcO+gLEY/UM7Ww89DE3agRjypmdOALbW8byPXC+ZwM6eZRddjjBd9FN8ocFPdH6B+CsGYXr/5Oa941tEe2orU3T3zV8Kp6ZMYJsdqrCWDl4MfWx0IIi8WqgMH/vDCioogfESFO+Jg6uuKMrz011DUVQtDHQu6Ym5BrkeQrHJol7Ag0kFE+BppRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBl/Yslh0zQAo/MMEG40uxi0GNH6EHf2t3FgUYJlXJ0=;
 b=Je1xg7zDjdUZch+QSRgMSAAAG2m9btcl8gLnpZ4SRxVIbjo0COIZqAKRGwITgloEC7ikPfWWzkvuBUYyD8sCVQGXl0nZHsVq/KByZHmERIxPxnwETncHYjXTNIeH8N9Mfv0ayoBT3Yr9PCIiieL8Al+AdI4Xn+26IFX/nn5BpZg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR04MB6270.eurprd04.prod.outlook.com (2603:10a6:803:fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Tue, 14 Jul
 2020 09:27:21 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 09:27:21 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, dan.j.williams@intel.com,
        angelo@sysam.it
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/9] dmaengine: fsl-edma: move edma_request functions into drvdata
Date:   Wed, 15 Jul 2020 01:41:40 +0800
Message-Id: <1594748508-22179-2-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594748508-22179-1-git-send-email-yibin.gong@nxp.com>
References: <1594748508-22179-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0092.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::18) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR01CA0092.apcprd01.prod.exchangelabs.com (2603:1096:3:15::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3195.17 via Frontend Transport; Tue, 14 Jul 2020 09:27:16 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 246fa111-a231-45c7-f81d-08d827d81be6
X-MS-TrafficTypeDiagnostic: VI1PR04MB6270:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB627025D1BA066C16B6F2746B89610@VI1PR04MB6270.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s4PZsMIQ6AMaWqvwAGTQD45QOBYofMBP1WthVrpNWHcoEf+QmWrP89cXGM+i9eJOyV4N7sMMc094ht/AsSkTCDZZv6l6d6eKRpJ0zsL0hDK3sRcfu3sVeOGcIZxEvB7qKnxm3rOwn0U6YNWNYmRwaf0AT0L1odHO8+gLGs+ytcU7VtTzyvaMI6r00b/jj1K2o2XNNoJVxddqIFuNPeA5BBAY8iniHO5rBTBDx7GSO+JmAVZqFIPErtGCz1W3weHPgFdpCi7KMo0LBza2/YlQVgE/nW1+ojZ24qzTrFuvo+K8WDAotfe6fV+1+jFIE/PlJkdgRJ8YT9wP8nh983Ivpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(66946007)(6486002)(6512007)(66476007)(66556008)(8936002)(4326008)(86362001)(2906002)(6506007)(83380400001)(478600001)(36756003)(16526019)(956004)(2616005)(186003)(6666004)(26005)(5660300002)(8676002)(52116002)(7416002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 8G38GCIfqkCXWXoIiUg8I4TBenCrBxmhpNMe+6q0rMzVNuxwRvdCtcB3DrL8yAoMJBRO/aHbyS/egSk06nc3ws9120CJtEuknyQHuAp9dUzF3O01aFw+b1McghzepIWjtEN8crcwH3hXMz3UEKdY5rUmc5eUddX7U7xwMpgM6VdJmNaVrOj3WXqVlHqEr8fwdWocYMPgXuiqT/T795UZHvw45GeljGgyhyT84X/IjN4cNjjrBy+/4iU2d1jOSzRre8yybddfc9PPimMJnDpBwiCdzFoeveMnBFjdcdPtxySNMByRkBwQNcuRP0nyiFzT35WFXM/6HcZM+9q9hHiZYeq0DuO9B/kW4X188GKytpDESI20eRa9tWAR9MioM9KNYcUx1tJy3Z0yQk0+Qv60646lQgB0yM+fCkJmReMwCMvckS46XemxK2k+1zsf4bvnAOrRyFSAAX9E7+BKaEvEEjGoBKAAo3XuP+mHhTNVryA=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 246fa111-a231-45c7-f81d-08d827d81be6
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 09:27:21.2093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oDa4mOgqIRS5em7oe6ASDQQtxbapOhQH2tIcD42udDXoLt4tG1MqQCUWQBGReDziDPtFxuvuQxvT532Eubwo3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6270
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Move fsl_edma_enable_request/fsl_edma_disable_request into drvdata so
that later edma3 could easily be added.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 13 +++++++------
 drivers/dma/fsl-edma-common.h |  3 +++
 drivers/dma/fsl-edma.c        | 10 ++++++++--
 drivers/dma/mcf-edma.c        |  2 ++
 4 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 4550818..ef5294f0 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -42,7 +42,7 @@
 
 #define EDMA_TCD		0x1000
 
-static void fsl_edma_enable_request(struct fsl_edma_chan *fsl_chan)
+void fsl_edma_enable_request(struct fsl_edma_chan *fsl_chan)
 {
 	struct edma_regs *regs = &fsl_chan->edma->regs;
 	u32 ch = fsl_chan->vchan.chan.chan_id;
@@ -58,6 +58,7 @@ static void fsl_edma_enable_request(struct fsl_edma_chan *fsl_chan)
 		iowrite8(ch, regs->serq);
 	}
 }
+EXPORT_SYMBOL_GPL(fsl_edma_enable_request);
 
 void fsl_edma_disable_request(struct fsl_edma_chan *fsl_chan)
 {
@@ -164,7 +165,7 @@ int fsl_edma_terminate_all(struct dma_chan *chan)
 	LIST_HEAD(head);
 
 	spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
-	fsl_edma_disable_request(fsl_chan);
+	fsl_chan->edma->drvdata->dis_req(fsl_chan);
 	fsl_chan->edesc = NULL;
 	fsl_chan->idle = true;
 	vchan_get_all_descriptors(&fsl_chan->vchan, &head);
@@ -181,7 +182,7 @@ int fsl_edma_pause(struct dma_chan *chan)
 
 	spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
 	if (fsl_chan->edesc) {
-		fsl_edma_disable_request(fsl_chan);
+		fsl_chan->edma->drvdata->dis_req(fsl_chan);
 		fsl_chan->status = DMA_PAUSED;
 		fsl_chan->idle = true;
 	}
@@ -197,7 +198,7 @@ int fsl_edma_resume(struct dma_chan *chan)
 
 	spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
 	if (fsl_chan->edesc) {
-		fsl_edma_enable_request(fsl_chan);
+		fsl_chan->edma->drvdata->en_req(fsl_chan);
 		fsl_chan->status = DMA_IN_PROGRESS;
 		fsl_chan->idle = false;
 	}
@@ -596,7 +597,7 @@ void fsl_edma_xfer_desc(struct fsl_edma_chan *fsl_chan)
 		return;
 	fsl_chan->edesc = to_fsl_edma_desc(vdesc);
 	fsl_edma_set_tcd_regs(fsl_chan, fsl_chan->edesc->tcd[0].vtcd);
-	fsl_edma_enable_request(fsl_chan);
+	fsl_chan->edma->drvdata->en_req(fsl_chan);
 	fsl_chan->status = DMA_IN_PROGRESS;
 	fsl_chan->idle = false;
 }
@@ -640,7 +641,7 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan)
 	LIST_HEAD(head);
 
 	spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
-	fsl_edma_disable_request(fsl_chan);
+	fsl_chan->edma->drvdata->dis_req(fsl_chan);
 	fsl_edma_chan_mux(fsl_chan, 0, false);
 	fsl_chan->edesc = NULL;
 	vchan_get_all_descriptors(&fsl_chan->vchan, &head);
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index ec11697..87c8d7a 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -150,6 +150,8 @@ struct fsl_edma_drvdata {
 	bool			mux_swap;
 	int			(*setup_irq)(struct platform_device *pdev,
 					     struct fsl_edma_engine *fsl_edma);
+	void			(*en_req)(struct fsl_edma_chan *fsl_chan);
+	void			(*dis_req)(struct fsl_edma_chan *fsl_chan);
 };
 
 struct fsl_edma_engine {
@@ -222,6 +224,7 @@ static inline struct fsl_edma_desc *to_fsl_edma_desc(struct virt_dma_desc *vd)
 }
 
 void fsl_edma_disable_request(struct fsl_edma_chan *fsl_chan);
+void fsl_edma_enable_request(struct fsl_edma_chan *fsl_chan);
 void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
 			unsigned int slot, bool enable);
 void fsl_edma_free_desc(struct virt_dma_desc *vdesc);
diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c
index 90bb72a..95745636 100644
--- a/drivers/dma/fsl-edma.c
+++ b/drivers/dma/fsl-edma.c
@@ -83,7 +83,7 @@ static irqreturn_t fsl_edma_err_handler(int irq, void *dev_id)
 
 	for (ch = 0; ch < fsl_edma->n_chans; ch++) {
 		if (err & (0x1 << ch)) {
-			fsl_edma_disable_request(&fsl_edma->chans[ch]);
+			fsl_edma->drvdata->dis_req(&fsl_edma->chans[ch]);
 			edma_writeb(fsl_edma, EDMA_CERR_CERR(ch), regs->cerr);
 			fsl_edma->chans[ch].status = DMA_ERROR;
 			fsl_edma->chans[ch].idle = true;
@@ -238,6 +238,8 @@ static struct fsl_edma_drvdata vf610_data = {
 	.version = v1,
 	.dmamuxs = DMAMUX_NR,
 	.setup_irq = fsl_edma_irq_init,
+	.en_req = fsl_edma_enable_request,
+	.dis_req = fsl_edma_disable_request,
 };
 
 static struct fsl_edma_drvdata ls1028a_data = {
@@ -245,6 +247,8 @@ static struct fsl_edma_drvdata ls1028a_data = {
 	.dmamuxs = DMAMUX_NR,
 	.mux_swap = true,
 	.setup_irq = fsl_edma_irq_init,
+	.en_req = fsl_edma_enable_request,
+	.dis_req = fsl_edma_disable_request,
 };
 
 static struct fsl_edma_drvdata imx7ulp_data = {
@@ -252,6 +256,8 @@ static struct fsl_edma_drvdata imx7ulp_data = {
 	.dmamuxs = 1,
 	.has_dmaclk = true,
 	.setup_irq = fsl_edma2_irq_init,
+	.en_req = fsl_edma_enable_request,
+	.dis_req = fsl_edma_disable_request,
 };
 
 static const struct of_device_id fsl_edma_dt_ids[] = {
@@ -444,7 +450,7 @@ static int fsl_edma_suspend_late(struct device *dev)
 		/* Make sure chan is idle or will force disable. */
 		if (unlikely(!fsl_chan->idle)) {
 			dev_warn(dev, "WARN: There is non-idle channel.");
-			fsl_edma_disable_request(fsl_chan);
+			fsl_edma->drvdata->dis_req(fsl_chan);
 			fsl_edma_chan_mux(fsl_chan, 0, false);
 		}
 
diff --git a/drivers/dma/mcf-edma.c b/drivers/dma/mcf-edma.c
index e12b754..50e6b9b 100644
--- a/drivers/dma/mcf-edma.c
+++ b/drivers/dma/mcf-edma.c
@@ -174,6 +174,8 @@ static void mcf_edma_irq_free(struct platform_device *pdev,
 static struct fsl_edma_drvdata mcf_data = {
 	.version = v2,
 	.setup_irq = mcf_edma_irq_init,
+	.en_req = fsl_edma_enable_request,
+	.dis_req = fsl_edma_disable_request,
 };
 
 static int mcf_edma_probe(struct platform_device *pdev)
-- 
2.7.4

