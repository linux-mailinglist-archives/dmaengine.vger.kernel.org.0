Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C8B2574B6
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 09:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgHaHw6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 03:52:58 -0400
Received: from mail-eopbgr140050.outbound.protection.outlook.com ([40.107.14.50]:27033
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727844AbgHaHwm (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 31 Aug 2020 03:52:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehHMzt5WjanCjqIR9KoRfN5e1q8UGRdYlTDbLYugKpxCy4CYiwczQpsacP4c96t2Ubdj1CUsJm8ItX5FaJZeSzFTv7H4wxdOfjwRYknm/H8rYf664LRKUU2zV8d65KH/wD9PTqsC2Fc3u759Wv7w27jCsiq+Z3AOaq0NsZlsFngVAhhzuHkT39RUdOAzzj8X8BUBQtk9jfUdRhPtSyXZ7jeiGqUAUMmW+SJusQGj+kSFxaDNKXtGICCU1ru3UNARIECMcSv2fh9JchCRdHm+iGHr68nXOVoSeRHgB1h9Pn4ResgadT8eAZEpdIavTz3oUneArFT77ZoFIeCKZa0yNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsjAevpr1iYIElTQ5w3YAoNPjTaoMSMAT5iDRdSZtzU=;
 b=fwOw6B6S1XQEfO8YkUl4WSpGLJAYTJ+0xVw46geNAA0RRej5z4rgUl68KDTj+vsjcd8yYCKn+bG8+6pdmNDx1XoNS4a6Mri1sllIVb5y+DDpX4XU0eXxmNP3RzzwQNlcFmRnzNeKqDBRxlGOEE//YlHJv1k0WHnbjaSk5Ls+ayTV9lWDqEmHyBoaaxsNpZGA3aOH7YgAuX5Lc4Uku+TAbpVgL/MHIp6W30xzmqqtfmVPpNC6Ib7r+FBjNbodQTKwVOPFdk0iBL80IMraMElZTvTRjzO8dS56pnXpAf153IQErHA0x26SlpysHfCedqMQw3mn5DTzV1KlHAW1mPZPGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsjAevpr1iYIElTQ5w3YAoNPjTaoMSMAT5iDRdSZtzU=;
 b=kvs/V/OfsnQbAR9A01oUPIziikFos5BWkHokcX835axt3vXgGPcwDhEvYobmP0OtQR8eQ5kH/yHYb0OPPCVhrSDOxf19eG7qGqjtXVRRvqSxURCXknEd6iUO/KJ66Sac80rI10Quv+IxWajikbpuII1S16us8tEyngFJfXLgFB0=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR04MB5694.eurprd04.prod.outlook.com (2603:10a6:803:e0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Mon, 31 Aug
 2020 07:51:49 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950%3]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 07:51:49 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, r.schwebel@pengutronix.de,
        Benjamin.Bara@skidata.com, Richard.Leitner@skidata.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v13 12/12] dmaengine: imx-sdma: add terminated list for freed descriptor in worker
Date:   Tue,  1 Sep 2020 00:03:25 +0800
Message-Id: <1598889805-30399-13-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598889805-30399-1-git-send-email-yibin.gong@nxp.com>
References: <1598889805-30399-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0104.apcprd02.prod.outlook.com
 (2603:1096:4:92::20) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR02CA0104.apcprd02.prod.outlook.com (2603:1096:4:92::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3326.20 via Frontend Transport; Mon, 31 Aug 2020 07:51:43 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: adaeed96-9aeb-4452-bbca-08d84d82b795
X-MS-TrafficTypeDiagnostic: VI1PR04MB5694:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB5694FE09B1B5FF206A9A872C89510@VI1PR04MB5694.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o6ChJwAur8QXQvhl13MRCwfhTrONR+ywP0D7vUZvXeBHDpPjIIaBBuX6TA+L1maB5D4dnud9mhjV3bSh82JGITYTc106iTlJ72VrvcopOOB0pS7qTrlhcYbBz7zfd7HvAEDO0r+zSh2aYrcZXh4F85Snxjl8G19bKNCYGd/1GTHiUQxxYgpo4b4xWnyJ1xbA3szVhGE3ZB/cc/6q82sMD9qV8XMH5WmFyZI/Om9n/1AXnMn/ekNqyuIwz4IOfdfzoJX6zdw2IaM4Yq6cSIhiYyEQbUqat6o1N/j/s5uuBMs3UtpJlWXx8clyKivqsRa3RNcFchpqDmxpgoFLPPnWS2EqlcV/vKdVzJzDN63spJoNCciBegJlrB1Tf2NGrrxABSdMn36YjaQ+AEJBfhctxhcVca8VmdmvT61kIBO/9a3RDmaKeBl9E/tYa9fhSwv8JEOGuZYnHWVOOx2W2AOgqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(8676002)(2616005)(2906002)(36756003)(8936002)(86362001)(5660300002)(956004)(316002)(26005)(6506007)(478600001)(6666004)(83380400001)(6486002)(7416002)(66476007)(66946007)(66556008)(4326008)(186003)(16526019)(966005)(6512007)(52116002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 1+ZqAqunm5qB0NJM/BPQBTk5Gvg1htuu1OluJOS9W0rnrvm+pQ5k67+rRx0ELQPDFJ6p7Z2GrgQcaceMDNN6dvlZwZt40fu6OAHhL2T63fEnseVHSaH2QSnblciM3tJtaz7bgOwEY3OZG+OPVrnVXVPeYa5x62IJg+DRDqcj62S4ret/zRVZyxVKunAPHn74IXYk9uIRl/qJspHbu1KvzH4LYNwtA3zT2gYxowFV6gCNmsmYlg31xJiF1Dq+Q6lOsIQiGKCx54Rj9sFiPri9DJe/L7/oR/7ZkU0bm+Q2bVcTR+JpTgn0fzebX1MeOh6vl5p132lAJ/fJ810tbW2I99eFNQOEf+EmOLQT7A50BR7g0kqlaJcB1uIpBbfUcR8Ofvpwdj5EEb6/d1fgREhTvG/WC5ZBvmPv44nHeFxhkjJTwnxaMqVlg6h0F/GUw6ZWOaUJDR+u5tLVelCbecsAOztMtdzrg/ppmWgFPEbXxwl5DjAimPFcPhzHr8hKBHCt/spQc7VqvWveAxD2DnPhSQs6oJ4flDVCZBiSAoqeXSILdVAPXBNlP/dphA6xaqyVc/sYFddb8qeYF/lVNYHzwh60UDOPsCetitl9r8xkCeUkV8DyfJ3KY6P8G+2dvkUiF1DFQJKggljb/2f8xxbNiQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adaeed96-9aeb-4452-bbca-08d84d82b795
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 07:51:49.6804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xFcnaYsfq+DCRL7/qC2/tBTOohst/Kzd95qHwHa1NyUW8fqs98b/oRVFE2ijCKCWsxDJ+fdf7qCH0d0wRIoXIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5694
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add terminated list for keeping descriptor so that it could be freed in
worker without any potential involving next descriptor raised up before
this descriptor freed, because vchan_get_all_descriptors get all
descriptors including the last terminated descriptor and the next
descriptor, hence, the next descriptor maybe freed unexpectly when it's
done in worker without this patch.
https://www.spinics.net/lists/dmaengine/msg23367.html

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Reported-by: Richard Leitner <richard.leitner@skidata.com>
---
 drivers/dma/imx-sdma.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 9bb6270..2fa8733 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -381,6 +381,7 @@ struct sdma_channel {
 	enum dma_status			status;
 	struct imx_dma_data		data;
 	struct work_struct		terminate_worker;
+	struct list_head                terminated;
 	bool				is_ram_script;
 };
 
@@ -1076,9 +1077,6 @@ static void sdma_channel_terminate_work(struct work_struct *work)
 {
 	struct sdma_channel *sdmac = container_of(work, struct sdma_channel,
 						  terminate_worker);
-	unsigned long flags;
-	LIST_HEAD(head);
-
 	/*
 	 * According to NXP R&D team a delay of one BD SDMA cost time
 	 * (maximum is 1ms) should be added after disable of the channel
@@ -1087,10 +1085,7 @@ static void sdma_channel_terminate_work(struct work_struct *work)
 	 */
 	usleep_range(1000, 2000);
 
-	spin_lock_irqsave(&sdmac->vc.lock, flags);
-	vchan_get_all_descriptors(&sdmac->vc, &head);
-	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
-	vchan_dma_desc_free_list(&sdmac->vc, &head);
+	vchan_dma_desc_free_list(&sdmac->vc, &sdmac->terminated);
 }
 
 static int sdma_terminate_all(struct dma_chan *chan)
@@ -1104,6 +1099,13 @@ static int sdma_terminate_all(struct dma_chan *chan)
 
 	if (sdmac->desc) {
 		vchan_terminate_vdesc(&sdmac->desc->vd);
+		/*
+		 * move out current descriptor into terminated list so that
+		 * it could be free in sdma_channel_terminate_work alone
+		 * later without potential involving next descriptor raised
+		 * up before the last descriptor terminated.
+		 */
+		vchan_get_all_descriptors(&sdmac->vc, &sdmac->terminated);
 		sdmac->desc = NULL;
 		schedule_work(&sdmac->terminate_worker);
 	}
@@ -2124,6 +2126,7 @@ static int sdma_probe(struct platform_device *pdev)
 
 		sdmac->channel = i;
 		sdmac->vc.desc_free = sdma_desc_free;
+		INIT_LIST_HEAD(&sdmac->terminated);
 		INIT_WORK(&sdmac->terminate_worker,
 				sdma_channel_terminate_work);
 		/*
-- 
2.7.4

