Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089951F0779
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jun 2020 17:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbgFFPWT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 6 Jun 2020 11:22:19 -0400
Received: from mail-eopbgr80044.outbound.protection.outlook.com ([40.107.8.44]:26597
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728991AbgFFPWS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 6 Jun 2020 11:22:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QekgbrYbLEdrq4muIPqoRU0zlLrNXdv4eccDuOV1dd+pRiKBK8/em2fCllKnfmaJWPzLjddT5OUEhmCgPnf7sQdePXucvxhqYAUuTAkGWudcRtky3go8VpoYZkx6ZvIuKzzz/eic4fZ4H+rBjwM0+8eRgrDQUystXOJ3cQ4heLECgjOakmD0z65AeMawMn+wx6m/tzFv/ArSZT9MRyTpZY5kaTXMs3MOdiVmvaGwxdw2AtyFChwoIagiMdcPRldsgydZJ3kmQ45X6SLYgPSi7IhJHdZBi412qxuxtm7xev38j+UfSZbnsVSHTCdAoyF7dUd0U4ParlT5Yk8aAPxMKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFbDanBWSu2S5nbk4C4ogbtxHYjU/2zcsNJWbhy/sHo=;
 b=BLS6DVB1DFH9eNZPmcXmL1WxYsobro7guoybRUU0KXar3CMvP5TfPSesiNpTgY9uLxMhE7GC2LR4cgmRnKwz7URii8bVLesFMXK4XiL9bDbt0PpIlOhRtIXm8Tmup18oovTpq6005/+n6WsKI2LzCMZnXXw9o4BbpJD5kKBm7qOQ4Ov6NO6rWBnD0bzrcdK7c/OXxmo2GnXrdLk0I+OY7wHeP9VNa1UxJcqglpLKYOncNt+XZLiggzVRubnl03AkMcySY6q9jQDEo48b1lQPqf99ZJCSHAGznRkziB/2MMUMI25ysIdKBPHjYEQ/CTJo9S6U3vF8uQiebnQcmjX3Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFbDanBWSu2S5nbk4C4ogbtxHYjU/2zcsNJWbhy/sHo=;
 b=HIigH58nz4aw7muA9t8iK8N15uNQRpmeF1JOyjBu4EvNqI30J8yWLWTtTBRKbRPJm4c2O/iU0sDa+slJXrRSvS6UNZ1go7xkXjgbpSI91qSHs7WDuKtFERXF7/InV/TWhlJBrEsZ5RD7NkQG2wcDUewXpykQvNT5pbY4hwih5b8=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6429.eurprd04.prod.outlook.com (2603:10a6:803:11a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Sat, 6 Jun
 2020 15:22:14 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3066.019; Sat, 6 Jun 2020
 15:22:14 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-imx@nxp.com, dmaengine@vger.kernel.org
Subject: [PATCH v9 RESEND 12/13] dmaengine: imx-sdma: fix ecspi1 rx dma not work on i.mx8mm
Date:   Sun,  7 Jun 2020 07:21:16 +0800
Message-Id: <1591485677-20533-13-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591485677-20533-1-git-send-email-yibin.gong@nxp.com>
References: <1591485677-20533-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0184.apcprd04.prod.outlook.com
 (2603:1096:4:14::22) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR04CA0184.apcprd04.prod.outlook.com (2603:1096:4:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3066.18 via Frontend Transport; Sat, 6 Jun 2020 15:22:08 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dff58dcb-e259-4682-9a53-08d80a2d6405
X-MS-TrafficTypeDiagnostic: VE1PR04MB6429:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6429DD06868822AE1866C9A189870@VE1PR04MB6429.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 04267075BD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O0oqycciC1aTCVhke0xezIUwCkxM9/P0bjvSDKaDMACFJm4I0Rcko6Wsa5jNSO+vDE1Zdr4ybIvni9bgw8rLknIlDoH2Ntny8WvL2fjS7gg+BvfZRx/E5qgwF5wGXZX30zxBJlc+jR6+DDz1y+HAtyxuCi+x8zAqzsTV+ToFi5Ht/YpZphJMdsdnrfRqLD57OYn0iImvGP21PM0A1hn5r5RrFa8FMiFrOmTLhtlpLPqKwBFX4uHyakvARlxAVXFOaBoTq7KrKaFq3g2V/EPwsbguNfzIMSHew7+2tlr/Q4fyXM6bZlhTDdvSnBVYvucSrEP3VsM78LBljjSwdnoHS/4lNlPTmx/wCj5Kyp4eEExsjCxUHRax1wL4wbWXkUNJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(66946007)(52116002)(6512007)(66476007)(66556008)(6506007)(186003)(7416002)(16526019)(26005)(83380400001)(2906002)(86362001)(8936002)(956004)(8676002)(2616005)(6486002)(6666004)(316002)(4326008)(36756003)(478600001)(5660300002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Lc7nnBtZG7YaM3Lu5WdKt5UsagLZsOT2CUpLkqR8sBCvn20iGjH/rf4pwqklgvoXN8a0qLkHzbwiTNuVhaAWyt5hUQ5wF4BNpEqvNBpf5vXz6lbXa+iI2fBg2K8rMwnBM/6StyAavdNmMvRS/xhvdKKY97ocyEZmCGFz1iTZw8i54uvYt0AV2ojburjTbfv8Slu1ldcL+LEBFUkNB82YL6ITSxrTmMM6lR36sHjVCTbayDyDJtD+O+nKekkCbAHa4TEayLGZdTMCk03FhK4rnvyh94Jjxsz+hxPXgJfaSyDCVMLCHzaIBk6RFixG4Dm6nJf4hWD67d53fvqjTOx042kQFII0PQA4hL98EVdZJyMvhpQc49L1mExl2bE3jzprm3sXuwZ5BcmI8nm8KBnvsLuQ27TIybpUuWXrvjMt5zaQxVQQ3RyYqEIwsQypvnOEw0HbpRgRDUFa+J6K6uNM7OlfWRlp6jqkRmHXMrM8QxY=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dff58dcb-e259-4682-9a53-08d80a2d6405
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2020 15:22:14.3308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ljn6Zw16HeX1fgLctXU078cOKMmqRHQynulStd6X11zTn5N10Xqjw4Su3xoeDQvz0guKWBjxWQ+tsPRAA/9Q7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6429
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Because the number of ecspi1 rx event on i.mx8mm is 0, the condition
check ignore such special case without dma channel enabled, which caused
ecspi1 rx works failed. Actually, no need to check event_id0/event_id1
and replace checking 'event_id1' with 'DMA_DEV_TO_DEV', so that configure
event_id1 only in case DEV_TO_DEV.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/imx-sdma.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index be86ae8..320104f 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1183,7 +1183,7 @@ static int sdma_config_channel(struct dma_chan *chan)
 	if ((sdmac->peripheral_type != IMX_DMATYPE_MEMORY) &&
 			(sdmac->peripheral_type != IMX_DMATYPE_DSP)) {
 		/* Handle multiple event channels differently */
-		if (sdmac->event_id1) {
+		if (sdmac->direction == DMA_DEV_TO_DEV) {
 			if (sdmac->peripheral_type == IMX_DMATYPE_ASRC_SP ||
 			    sdmac->peripheral_type == IMX_DMATYPE_ASRC)
 				sdma_set_watermarklevel_for_p2p(sdmac);
@@ -1351,9 +1351,9 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
 
 	sdma_channel_synchronize(chan);
 
-	if (sdmac->event_id0 >= 0)
-		sdma_event_disable(sdmac, sdmac->event_id0);
-	if (sdmac->event_id1)
+	sdma_event_disable(sdmac, sdmac->event_id0);
+
+	if (sdmac->direction == DMA_DEV_TO_DEV)
 		sdma_event_disable(sdmac, sdmac->event_id1);
 
 	sdmac->event_id0 = 0;
@@ -1651,13 +1651,11 @@ static int sdma_config(struct dma_chan *chan,
 	memcpy(&sdmac->slave_config, dmaengine_cfg, sizeof(*dmaengine_cfg));
 
 	/* Set ENBLn earlier to make sure dma request triggered after that */
-	if (sdmac->event_id0 >= 0) {
-		if (sdmac->event_id0 >= sdmac->sdma->drvdata->num_events)
-			return -EINVAL;
-		sdma_event_enable(sdmac, sdmac->event_id0);
-	}
+	if (sdmac->event_id0 >= sdmac->sdma->drvdata->num_events)
+		return -EINVAL;
+	sdma_event_enable(sdmac, sdmac->event_id0);
 
-	if (sdmac->event_id1) {
+	if (sdmac->direction == DMA_DEV_TO_DEV) {
 		if (sdmac->event_id1 >= sdmac->sdma->drvdata->num_events)
 			return -EINVAL;
 		sdma_event_enable(sdmac, sdmac->event_id1);
-- 
2.7.4

