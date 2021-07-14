Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA1C3C7B78
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jul 2021 04:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237529AbhGNCIn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jul 2021 22:08:43 -0400
Received: from mail-eopbgr60054.outbound.protection.outlook.com ([40.107.6.54]:64190
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237317AbhGNCIm (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 13 Jul 2021 22:08:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=di1p67DxNIgNxv5Bx3wHS2VESHUicbhC9njb72ZTHG1HP6XlTRMRgWKqILluPLdg4Idieq0Pc9yqZkLwoEEidBApEPZLLtaC0FhBjeiwMXGRtX7fWVFJgeBpczv0/SIKoMsJjZn+U0036gQNiv9XaqZriOuNDKdYbin9gE4+Wa6SLUNNuNi3Xs7fDnV1nAg+4j0N/Ry/mU90K//OPZYLU0SmgO8qMfStcqOQ0Hun1XnGxz43ROhiFi8SFgb1tCYFoDntKq9+IXAt6UyWCRE2ZtmwaF0bdISeHWsTSqfqXk8K+W3IahXBO+V2S8/8CnBElIdoQI1JdK8KZXQ915walw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tijq09AUBuAAT+hQVwjjuto6CEluVVVcs2l0lwoJQPs=;
 b=f3gXlNQi2hB1JfedqUa/FF6067JmkidK83RBSob6X7qJBs/FTxBPc8wkeBzT8Jy/l14jwXrL4ONkd+qtHz5S4C7tv/EvV4k4/fJnok78R4ANa5rxavt2BJoV/CzFi9Oa0X833hbv0eXYCzbwjDIkX9CbSmRh50fKttJYX9MI1BQtKpBJPV7Tu6SRVJt3u0eX8sgSxvCOCAem5jdMRxs5oU0oZb712/c8PiXh9VUaPVOAHu1kXU6+o5zUHXIWOfcswZuLbmaYb7vaqLb8Px59dx1xSKbZLHNS7UFygiyCKgPSJfSZCPsIC4You3ZeI1bgqI7RhtbzwZJR5kPe+YbD1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tijq09AUBuAAT+hQVwjjuto6CEluVVVcs2l0lwoJQPs=;
 b=BHxpO9hqQme2SyA52iaWJYhb7QoaI2Q9esNh0MCe/vjkGG6S4wBSR8MyX2nON7nQXoSn8bvCl6KGqL7L/X1tXyKSZAjidP8g7YLLMBHKPN5LNuOuzp8XrVhZ17WMHWdJ4loSYdefqNjQbw0lVMOG61eouMKfPFCCtoUHr340FBU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR04MB5773.eurprd04.prod.outlook.com (2603:10a6:803:e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Wed, 14 Jul
 2021 02:05:50 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076%5]) with mapi id 15.20.4331.021; Wed, 14 Jul 2021
 02:05:49 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        robh+dt@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, m.felsch@pengutronix.de,
        l.stach@pengutronix.de, xiaoning.wang@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v16 12/12] dmaengine: imx-sdma: add terminated list for freed descriptor in worker
Date:   Wed, 14 Jul 2021 18:20:52 +0800
Message-Id: <1626258052-22198-13-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626258052-22198-1-git-send-email-yibin.gong@nxp.com>
References: <1626258052-22198-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:3:17::28) To VE1PR04MB6688.eurprd04.prod.outlook.com
 (2603:10a6:803:127::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR02CA0016.apcprd02.prod.outlook.com (2603:1096:3:17::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 02:05:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9403ecbc-56b2-4029-d957-08d9466be6c3
X-MS-TrafficTypeDiagnostic: VI1PR04MB5773:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB5773E01104F66AD4F0AE1FB989139@VI1PR04MB5773.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TTXjcM+JTcP4JQv2QFyBy2Fs2E2H53ypzvR4zFnEB2Bo97n+3Qk6WfNIqN37fKW9lRC91S0TD08H0k9MWDCDEWdWKPRbpgPgoegTVqlJMCJrvDtpRuyIKXM6e/ITjfgP0PfFVUt8A7sf+hfyJv0EJwKPcTwzkek8yXoNu04wCh6s1crNa7+RY6m1HwLaN147/CYQcw6YNlI3ksoJ+BqgK0882NATEt+kQAL1M92LCMMEuMWi+//NbCgZ4cgRomGLQ294dj29TvmzZ52dlAuj48Unq4/JN5TiE3p9pLi/rqQz39WX7n4V9XujsnsvAN69BYcyJU3IIBJgJbmMjUyeoM37eofrFz4yfqn/m0PUG3eaZx2W9Osgy+QmeGoW/uwkFntS3e3obubiMqjB76lvZOfq7W5iw+cDwrLzk99qkeknhFC4wCV8qag4+Wunqo+Vz/VZ/2fi3IWAVxtWX+EuHzjuUkx7J1QCg24RoQ4iGujrYw4PEI0s0NACYUDuTP+0sqZTNlbuerzM3mMgV/lbcDaUrSuqotn7KinybMkwbmbQ3f6vobpZ0dfkwkdM8qhgJRuTmtgwmy/G1U7dSGK+d7A1w7vB2/jOy5jfKZ0djT0taBXgMSpRlXb5Yjw3pBiClKcM5zO7geU7hhorHKiwVeVu5JZYB7ZY7HRIlnFjHMmD4xnd1zx+XW3lXXZHEK4SE8lDYilgYhhBI+FGrVygh05xNnTarSmpGscRQmDuW5L3mJJJe0Z3Lh1Zzlq53uyXcRPxEpbxfMLJ1BJXiQ24xiILfo4tnlCX+UyRsvT0z6iQKtTiHc/25Tbf5+NsJre3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(7416002)(2906002)(316002)(6636002)(921005)(6666004)(83380400001)(38100700002)(186003)(6506007)(52116002)(26005)(4326008)(8676002)(478600001)(66556008)(2616005)(956004)(66476007)(36756003)(86362001)(66946007)(8936002)(5660300002)(38350700002)(966005)(6512007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1CZlzsHGrsr+SHpfj7b67mNBMDj4K/Em1qxKZDjOyiOQkJUlPpFwUXyJCRBx?=
 =?us-ascii?Q?YIvVxH74HXb1BGWobM91ITxA3FI2GT34+kJEnewHm+O5/D9Q078Oa6tJJ8VN?=
 =?us-ascii?Q?RL/AljR6+Cr1sl35Bdu3naZpTsBKPC2ervikY+L2Rv7WirQL18aC4KWimE11?=
 =?us-ascii?Q?kYJmvXOELb8Nb4ZHNV0ZuuyF/FDL3YazaojGjQz/XeNPP400MGjVcyU/GmMt?=
 =?us-ascii?Q?iEiMbPyohPJsb6hMK+y7W3VM0ZW9yOmuKfb/js/qZI8AAoBOUMwEbyMyEJS4?=
 =?us-ascii?Q?XP5ayF4bj+Ju/xpdHYxK1tIhoKOnxT4ICh4IFY+zmXBeydvDP/J+XDIrPEik?=
 =?us-ascii?Q?VAcc5nnim2AyA9D49YIXrGtARclQgFU3U/Dsn7eQsfPoCk5wd2XsAAQPt6ie?=
 =?us-ascii?Q?OqfakK7eau9CrSBNg+ww1N9RnI4H4eg00bECYs+G3NPZeHRtPqAbPMuUXhgp?=
 =?us-ascii?Q?FdbBMpaPQdo19Q9YR/X0mxwlHAgKDDdbehgu4kCceHvTFdfm9d2JLXrmcUlJ?=
 =?us-ascii?Q?YxP3WR4PA0L7H+rWXrUNrTSC79HKJdwZ+3zWsBn1tAFlSt8QMOZwazy8TPSs?=
 =?us-ascii?Q?OrxP1tEWnTSJRfKsqhXTJFwaXz1Vbi6AC6k937kroNSgtbMpyAVZlmmHFvYy?=
 =?us-ascii?Q?lDefHxSBqyqeVHCjk5Q+dU64zatFjpMw+Ljr1yxwOF1JKB24l6lu1V5+y3D9?=
 =?us-ascii?Q?rzMzs2FHzmdQDr46H8+scaG1DdWijNGnvGcHlXocmrf4k5eahBP16qFBy++Q?=
 =?us-ascii?Q?WtVciaFPW87RpzczW4WfH5AoHQOb4kBa47rBZH4+gLJh8U3X++IWivdLqv0W?=
 =?us-ascii?Q?j2hGY+Syeho4cg3BWK1gu+4uN7BKghjeH+2tuY8ndvvzaMzIximyru2CDRxd?=
 =?us-ascii?Q?zxx5Smkr80icCDW8wqWAti9owCt/YhqHRXS9yRMn0VvN0TrrmCU+AxvnOI86?=
 =?us-ascii?Q?i74Xh+IjptgI0PLV748+8mEUl5+DqKoEkd03C308+lpQ3SZdfz9Z5hCK5sFV?=
 =?us-ascii?Q?jXj5a+3k1dpu6f7tHTdI0c//gR+lzk29EeBqCP93zDeOxbXxkbVfiT2dFX77?=
 =?us-ascii?Q?SPTcFCP0CZCgk1LKIaqe32AnsuB2AQwfWqO3JXVbTPcAUHC408hpPLLS9PLF?=
 =?us-ascii?Q?bGPw47j80Sf7lDJFvRYjOUgZl0BBHg0yW0eJp+bN1CQmIg7g2cF9DeUa1uLN?=
 =?us-ascii?Q?iu8QClshdAttqWaL8CQJq8jzwhQFHKWWxPmdvTgihQ9gmO+GxA8E3wUFx8B4?=
 =?us-ascii?Q?9CLAxmL5Ww/eGKqq/hUXGd/wx7Br4hRIBTc7qGsQPVV6W8HzAhoxUeMSs7pv?=
 =?us-ascii?Q?10v/oAwFhyesP9JU8NOQ/sBX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9403ecbc-56b2-4029-d957-08d9466be6c3
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 02:05:49.8874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xb3wuVoqQwC+ckXSJaEoyNxS6LuHYgy7KCay1rk9b5b6di/41AitUpAMKYtcIbX8GTaZDXsNWLX8zk/iPFVvUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5773
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
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/dma/imx-sdma.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 9ec1edf..cacc725 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -439,6 +439,7 @@ struct sdma_channel {
 	enum dma_status			status;
 	struct imx_dma_data		data;
 	struct work_struct		terminate_worker;
+	struct list_head                terminated;
 	bool				is_ram_script;
 };
 
@@ -1107,9 +1108,6 @@ static void sdma_channel_terminate_work(struct work_struct *work)
 {
 	struct sdma_channel *sdmac = container_of(work, struct sdma_channel,
 						  terminate_worker);
-	unsigned long flags;
-	LIST_HEAD(head);
-
 	/*
 	 * According to NXP R&D team a delay of one BD SDMA cost time
 	 * (maximum is 1ms) should be added after disable of the channel
@@ -1118,10 +1116,7 @@ static void sdma_channel_terminate_work(struct work_struct *work)
 	 */
 	usleep_range(1000, 2000);
 
-	spin_lock_irqsave(&sdmac->vc.lock, flags);
-	vchan_get_all_descriptors(&sdmac->vc, &head);
-	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
-	vchan_dma_desc_free_list(&sdmac->vc, &head);
+	vchan_dma_desc_free_list(&sdmac->vc, &sdmac->terminated);
 }
 
 static int sdma_terminate_all(struct dma_chan *chan)
@@ -1135,6 +1130,13 @@ static int sdma_terminate_all(struct dma_chan *chan)
 
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
@@ -2130,6 +2132,7 @@ static int sdma_probe(struct platform_device *pdev)
 
 		sdmac->channel = i;
 		sdmac->vc.desc_free = sdma_desc_free;
+		INIT_LIST_HEAD(&sdmac->terminated);
 		INIT_WORK(&sdmac->terminate_worker,
 				sdma_channel_terminate_work);
 		/*
-- 
2.7.4

