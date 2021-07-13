Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6126C3C6E96
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jul 2021 12:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235777AbhGMK3h (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jul 2021 06:29:37 -0400
Received: from mail-vi1eur05on2081.outbound.protection.outlook.com ([40.107.21.81]:57953
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235535AbhGMK3g (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 13 Jul 2021 06:29:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lw9JzuuB9vT4M0OTgliRus5AOFxWU6P3hmI2mRox34uIY23yxHxyXRFg2rzdmEtqqwxDPUJv19BZprfxfgYl7p/BhteOqMMohT4iZyNGLqhSeLmiP0j4dLM5vbJ/tPNuOJad5AZi9b+4fl6g6n1OI60z1VD0DcpMlrEOkj0ADwUt0IFEFGjjQaXvWcTKpzKdb9655RLc9nbvtvrLNEcyDjIOaSAkcGJLqs3wTRxcR2S4AUmdyISQQ5vg8tNQHBeiPkivO+nAHDKvuz0SJUkg5MG3b24t+5Np8nkP+F0ay62hjlBP8PuAmSJguyN/BfqDwSGfmmlJ/MqWho3yQaoM8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tW5lZMEUKTmo+F4zrVNicpKnImo9kdoACV6FdhIqYE8=;
 b=bPSvVzu1u0J1OLwgAamw9BfM/NsfPCeCaIlr1VdYf9t/YqbcalQBJV0DV2WHCt9tzMNko6SyBhpxSvUNnYmifdg3k4x/9WKb3ZHe4akgSLJ2qlQKBw2wxZF+jcRavYyi5xHaGtVQR1IzgRMBLfWKdDYcwrsHBaFpvrGLkzvXaY7YxiL9j829GOFTtvuo1KOaaAMia6As2RnpJ2CE7uQYQJl9tYcuPjEMS0tptg8agpBLqOuHSVM0mmrrme28CWt4GNCt3K9dhhd3CImi2qyyEIJkIjHn0clHznwwHsUlV9ICUlovG1vJR0I5r6Lm0lfQNs5c45mwtC8PsO6ZBa7NSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tW5lZMEUKTmo+F4zrVNicpKnImo9kdoACV6FdhIqYE8=;
 b=RM/5rz7EWZZmjThDXt9vPsoO/nvs3GpCM3hzCYsN3QIihOcAzLnAWf1jTUkTRdBqrF+UWYx2vDT/V6vMT89WTVP3xjLSSmk+ZST1yag7xFqILxgWPbbEOV7aukE13YNlL24tiNHa9wYecmNKBzwZQxCW8vpl0FQjHV2HNCOfscA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR0402MB3344.eurprd04.prod.outlook.com (2603:10a6:803:10::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Tue, 13 Jul
 2021 10:26:45 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076%5]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 10:26:45 +0000
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
Subject: [PATCH v15 12/12] dmaengine: imx-sdma: add terminated list for freed descriptor in worker
Date:   Wed, 14 Jul 2021 02:41:49 +0800
Message-Id: <1626201709-19643-13-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626201709-19643-1-git-send-email-yibin.gong@nxp.com>
References: <1626201709-19643-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0198.apcprd06.prod.outlook.com (2603:1096:4:1::30)
 To VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR06CA0198.apcprd06.prod.outlook.com (2603:1096:4:1::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 10:26:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15601e84-2593-4bb7-c239-08d945e8b695
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3344:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB33442E16099801895764934889149@VI1PR0402MB3344.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n/lmkUxoYbV/s+9mcZN9UN6Hzmk8yzE+sYF6ifJzcQO5aNKZSXEqToho+dvEWP0gNLHeOiNe0dMsiishgMVPAdWRX10eM6PX0bWNk8aXhCGmNH+RNaowHGg9SbjzuqXHlqrYfmn9qpmebf2qkcPiPfTbWXbMYS39tMsMRrA6Aj2gJyi+YJgtgkaTsle1XNxWdvy3pgmzEr1Ka7sYjYGWX/JgJ6eq+2A7aoJL6V8E/lcIkQrz8m8Jlh3q5D4SuoivrqPCuvYCDIteHo0wrXSaiTXBmvhjDrpb7hDTyGi65UOtGmxbuu+ifxCUccjVcRIC2VM3B68rGAse7f4ixInssuegImLD9jy4f1COuyOLRcr8MyUuNNchbbaRS+x9AFsGQMOD6Krn06iw1/K7RocGsrlHKnF00/4Yh7S1smw43y+xYor07ECS5vR6iGM780kr3jjfL+5l8GIEOD2nE7dfKiqI2HLtjxZmcZqPR3/zUG6WpNh7K/LqVG7WUDSyvLu7sUIUPSEX+JSA2n9fwLTofIboKgSer3QulM8e5noa0DqepWLS4/mTVa0vPz1RYV+mMdReofdrKe85oTvY0oT/x7O/QHRekYFRfs5MqhuB66hJWmmder/thdhTYxd/qBvNAP0VWSozmrYzQfiecUjQdqgZ8P93h2MsVZj1euqmNsuAOXpdjrFxCk0AEzks9c6HFDBpNeJaJ5bkg8bV72Uy3KHxaVQa+nnA7liBUw0HWJywqpS/BxJZ50oGYHyUGUhjwapeC7xSpABrc6OEfiySqPORU/vIlC2RlRzH3tDoTbwOjmEivr+RtnRteVotUwVX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(346002)(376002)(39850400004)(4326008)(26005)(66476007)(956004)(36756003)(8936002)(6486002)(478600001)(5660300002)(6512007)(86362001)(83380400001)(7416002)(2616005)(6666004)(966005)(66946007)(8676002)(66556008)(316002)(38100700002)(38350700002)(6636002)(2906002)(921005)(6506007)(186003)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oDX9Kw3I+oQ9ya6O+g2zgsMah7CU9WmeNcsPKsN9IVNS3JAXe5zUaodonXXb?=
 =?us-ascii?Q?Mlku0IY2LOVsQaUeE43gLJe2e2KqJ+vCylbAtUkEzRaeSHwoYaK2aDGJTQc6?=
 =?us-ascii?Q?dQ9VArP1P3gnIVxWKATbxpK/Tt5/Nc8LGAxcd7wxbwyLmcOMTDjeK6lVT5+N?=
 =?us-ascii?Q?ElRbXgia8LAvX7qYaZ+2740m3Wp6CQlU2/poGnS+sUdQ5JWQRCJpEEoWBnBq?=
 =?us-ascii?Q?LHfqzvn8aFMHWZ7IoNUuCzmeNvmu9VZvngVwFZHf3PkRO5ZyRrHTuRG7vGe0?=
 =?us-ascii?Q?+bb4Hv1L4D/KxTr8WhV8lFZ4NMpZ3pwiIJyCQtpFRna2jgyPPqQLQcVg2CcR?=
 =?us-ascii?Q?2rnZW+Zqut/N1RXItOYq6vprRl4nlMQbnr+rPj55wh4G7Yb0r0ccXtZhqhAL?=
 =?us-ascii?Q?HdiOgbn2ZNYjUogNTZQJ3oNjlFO2C7MwxlL9nNm2XFStCE2RqQyKFNlwklD9?=
 =?us-ascii?Q?Ct2ioIgJxbXXLA7x1m//tontxmM+iIvPfXPhAvqHyQ5HB0jfKYSABaln5fWL?=
 =?us-ascii?Q?dzS8t/15AiXuRIMjD221w2mOQaHNYHpLVyac3WGZkUAgL5Bz9NCyFTX7m5mg?=
 =?us-ascii?Q?usRtPEbZP+huYjP8iuzU2JiK1slGYuqVPivHa1MhyQHr1V95AeVYKOPY/ebZ?=
 =?us-ascii?Q?/hDcIKDbdz+hKveYQSAi62keO/tUYKr4R6OrMaBBZ7wt2p3MvPBOeQe6MbTU?=
 =?us-ascii?Q?jpeYfquhE0AiK/JtQc8qYB66Wr/RSyicDsroGwUyRsnPza5gecWnBwgof+qp?=
 =?us-ascii?Q?F//+YUzKB99jALg59VhuJ2miC7+2MySW7L4SsQJCATwE4WDdPClUQ869iGO7?=
 =?us-ascii?Q?Mj/QO/T8nMRfSn5BhihV6vikUDLomvlHpoIT7kzkfoJM/fBG/6xlAj2YSDhZ?=
 =?us-ascii?Q?aYB0UQZ7AHhSgxrLkg4osqv5G583ONA4F+V5EyfV0Uk1Bz5e4NIRhgPXO6kB?=
 =?us-ascii?Q?RJlSRNJkV8kYKJC0igQYg8vkApxhgV2/QsJ2EOji5uViOqD7HKS+HLTlpunJ?=
 =?us-ascii?Q?bhgnJ3jaeV5d56vReWIf+xtyWdfTvRGMMCMu/auec+cSErqnFz2NdUkh5efO?=
 =?us-ascii?Q?QPNxrnHZ0LTzPoHSD4Red7EWnypQxRoUeXSvCxQxBCT9dl8s/FLHCuJ7YTjC?=
 =?us-ascii?Q?ZZMA1beU17/2X7JuPuzDUVKwSan6mOsnWhXuEk26lwmqq+xfHKnvV3Gm1zOT?=
 =?us-ascii?Q?gK5AnTUhr56uwK/sQEYkDBdaUA77spiVzLvnWa2x+lnuaOh0cLt8PslOFt8m?=
 =?us-ascii?Q?+1Z1PBPnwM8W9XfjpdWl3sR8nUCxGS5teWKikJHW/2P31RHjKejQHtskiE47?=
 =?us-ascii?Q?I0KPFv4eAqerp+F+VPnaV7Y+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15601e84-2593-4bb7-c239-08d945e8b695
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 10:26:44.9232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CKfROocsmD6Ng9WVnQTop8begq4dmyfZXtZCXuP5szBcVysqKAc1v6y2pVj/o4lKiYPqQYddhVAN81Avufc6EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3344
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
index c449755..6e0490d 100644
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
@@ -2132,6 +2134,7 @@ static int sdma_probe(struct platform_device *pdev)
 
 		sdmac->channel = i;
 		sdmac->vc.desc_free = sdma_desc_free;
+		INIT_LIST_HEAD(&sdmac->terminated);
 		INIT_WORK(&sdmac->terminate_worker,
 				sdma_channel_terminate_work);
 		/*
-- 
2.7.4

