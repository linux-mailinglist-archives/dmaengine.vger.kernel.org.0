Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64719211C2A
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2020 08:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgGBGxs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Jul 2020 02:53:48 -0400
Received: from mail-eopbgr60058.outbound.protection.outlook.com ([40.107.6.58]:45039
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726068AbgGBGxr (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 2 Jul 2020 02:53:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lafYxPFGzWp/BLhHbF5idm7mkyPk2dp3+z5gPQYkpNj5XaBr5GVOKMW0kadrlEPxae6wG2DWEjrN02GYAi11meuGCP0f/ASrwM0pvWTYMQf0gXwu7BLSFc3wIFqg8ag11w9YFhuIzsbLxdvuHyg9BBvryxPBEhKjsUvAQdQ2EfDVkDsP8OvW6sbAva1wlmlhBG4R6jUqdSnhwT08R11N66ZPAzvxjFD2ojz1XiQ5RCRIZ0SygQOFLtnHNQWq7agEd+D3H/RRzEc0YNexmbG5gyeovo7DN9T1NsYqE8arG0ih4VTSAMDODJe7vaWoOfMN4KQ44ELTB7+qCO7FOXI30A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBl/Yslh0zQAo/MMEG40uxi0GNH6EHf2t3FgUYJlXJ0=;
 b=ET9mwpUK3s7GPCv3V2msDE2A7Eks3SatiPfEdPpTBVm0pGTF/E0ivRH1LmQURfi0B8bANJaLSqEAS26eqKMa410JWOC2Qc8N5vhSJ3H1tCh2+TuEpE7QgH9ELi7acyKY+sfAf9sUtjEmNQp1bSZqu6tHoVriISTPBagIVMd23oBmRjr5L9yjiiTy+WLPO0wuuG5hpYTuA6lqhI4hjCpUcETF5fZjncJKk1TM9nptaMlh3nVvXRER0dGwWU2fuDPu2NYDEiLuHM2c8Ym6kjNkHm0qMSOYDoAgpnynYsLuCURYOZbhKD7zKc7GFwue9W7uaQwfEUK4b0bsxtXXPEi9Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBl/Yslh0zQAo/MMEG40uxi0GNH6EHf2t3FgUYJlXJ0=;
 b=BScQ4A5mJ600N4HzzzL2K34ZXZ+CxRt5kdpxA5HQJedH88edyJjyckGPOZDN9tRoNn1cRsaGVHMZc4pXHXf3jojtUzxQoj8Kh9GMS+sCHuNB8LY7PrtAHaIXzET3eEPLt/Fqqzybb9d0Dl5e6q3MTffs1i9nvvjwA94LPaqAa0Y=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR04MB6943.eurprd04.prod.outlook.com (2603:10a6:803:13a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Thu, 2 Jul
 2020 06:53:41 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3153.024; Thu, 2 Jul 2020
 06:53:41 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, dan.j.williams@intel.com,
        angelo@sysam.it
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 1/9] dmaengine: fsl-edma: move edma_request functions into drvdata
Date:   Thu,  2 Jul 2020 23:08:01 +0800
Message-Id: <1593702489-21648-2-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593702489-21648-1-git-send-email-yibin.gong@nxp.com>
References: <1593702489-21648-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0172.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::28) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR01CA0172.apcprd01.prod.exchangelabs.com (2603:1096:4:28::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3153.24 via Frontend Transport; Thu, 2 Jul 2020 06:53:37 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ff0f42e3-32a4-4786-0cfb-08d81e54a7b9
X-MS-TrafficTypeDiagnostic: VI1PR04MB6943:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB694372329CE0D73B9B08F325896D0@VI1PR04MB6943.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: apStRKV9GjQ5ApKuEOs7JzL1pLkf3S+9Ce9F0lJ5wHjGP0IWKHG9mb+SZ5CN5oXxsEb1O3B1TrS9Nm+pl4A6LNyFCrOLwqRPiKTNjr59E1MtWu13KEy+wqPBU0elqxLibuwAOLT/S9qSolsPbgtVfeXWTR9ATrtcS0q3hC8UgWxy8pLRBnMsiApkxBD36wMTzsyNMSbtJ0r7ujqJBK4DXwTZFiG/NHsVPb9RO4T8UlAOhBIrAmCwc4QdaNH/wAYuVcprVTuoKO9doNaRszPgcHzFEXLWIpc3PkTlMtaV6cvQmkgZ/unsuo7RtQAMMRZu0qk2hCpQEwBNnXboJ1avxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(83380400001)(66476007)(6666004)(66946007)(66556008)(52116002)(36756003)(8936002)(2616005)(6486002)(956004)(6512007)(186003)(7416002)(4326008)(26005)(2906002)(8676002)(86362001)(16526019)(478600001)(6506007)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: pGK57xjgY/HAYl4KdlIueA3zH4/bLySmyibgz8jOCqMDsbyi6VV/zqU47adXqXHM2Y0192QvijzCa2rX2rvwl3R0C3lA6ze0YTfGSH0OshfXXuWtlBZUifGAnpYKl+bAUlQYtz2qn5zWRY8ollJTn0YbbtBW3UpQbZXQ85TCoTAcxAthkjBNAuLvSkcc9N6JAn6/tPclV6tAiHLOyzj61y0QJH2B+/EP2QYf3rHHEHutJyQgWivg635YwvB/LfwHDgr6Qu5Yn+rZi8azZ71FdqINRXRedwJcE9PGulN8npxlTbbyAuwIL6s56IIFM85xFrjJhb+D8wP0LeznekdpEDjkkAZUYQ684x3Z438btsFk+t5qgaN6oZIjo1oGNpo0qSgOIcWd2VF78po+6dAK9JFFougIOogC+DMCrqSi8ifVAu9AlkeEdq1B1kR2SOD+Vz4O638o+m3+O5tDB+rgETOraPP4kOMXzmf1Yhlk3tc=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff0f42e3-32a4-4786-0cfb-08d81e54a7b9
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 06:53:41.7611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHd8AxJmEsWfcVFKyDgTDIuIc4qCzHtIpazmpDQAtaGbGMlRKpJ09CNEJtRtxBxpjuRS+0FNlsOthcpUydh2fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6943
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

