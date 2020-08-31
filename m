Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22BC257490
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 09:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgHaHvK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 03:51:10 -0400
Received: from mail-eopbgr140050.outbound.protection.outlook.com ([40.107.14.50]:27033
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728033AbgHaHvB (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 31 Aug 2020 03:51:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpqYOD9jamTZy0532v6ywnwwwWnFkyZPP5/AdtPd7TFAdGdOeEf2u8rE5r6r+nIzJzWCxa61HOMqOHH1dexqE8M1pAQREUEcsqyqT3iQ+PN/iK34UbBW7gUdAqfYrJHjVmptlUHWBDexGyW2RIqym471TjqsKO5al90YT7MvkpniNg5VXn8Ppm+ZUKq2wFn01cG+7MC50jci3J4/bjEyh7VtbKg6R8wsoKLz4hKzn6VE+hrWiU+/dE3aLCbbjFLMrmISt4FiUKvJ2tgeB0xFQ7oZfyjUusf4Ar66r9bMdmmlD7KUJBXMLvsuAKUYSp0X7qRbxJOkopXfgZfkkR6Vvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dkg5DnG4yJ94c0pUQ/YYJmVs+9WpM6Ry5D8lwtIxv6Y=;
 b=BxAOdq81vNLtBhxSy68l+mc4ViHlmdUv5RctJl6VgH2CIbrAcLjjBgMS0OtEdiY6VRCR+mW4GScFfsZGydShvIXijvwxzAxt0JehfVXmyQXjhW3pMwrdFLigKL5O0LOI4qKaOPcpDRKixsbotXKkfN70SnSBJ7dDZ64xWsq44hyIpw8sauWBoOCW7RfS71snjVEiQ3GISH03eRS6+mqbCjbZyP8I5RNsUqMrSDUwoP8hN36HqTYIXXBL0A3CrBiQTKMzJ116cFFFW1DQmSOMlXRVYhV8/i6/L75IXMtFmmSKiDe70Ksxzy7Ol08jjyjFixMiv2r5BADyLirI5q3yvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dkg5DnG4yJ94c0pUQ/YYJmVs+9WpM6Ry5D8lwtIxv6Y=;
 b=m3l/BF/NC83lUISSOxKCA12qwDjbAwzrZV9y6tOJaMuf9fy+nReXoEIU8OMJXamtxmfcCXYID25iZaaChjPFpblaS6UI8+1uBFIMOIdJ7mk39yI9jPI1PWHoOo1++/cE+VvehXapih9+cfzGIpAaZWePs1QK3OKLEtb/GS/TDVU=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR04MB5694.eurprd04.prod.outlook.com (2603:10a6:803:e0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Mon, 31 Aug
 2020 07:50:56 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950%3]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 07:50:56 +0000
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
Subject: [PATCH v13 04/12] dmaengine: imx-sdma: remove duplicated sdma_load_context
Date:   Tue,  1 Sep 2020 00:03:17 +0800
Message-Id: <1598889805-30399-5-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598889805-30399-1-git-send-email-yibin.gong@nxp.com>
References: <1598889805-30399-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0104.apcprd02.prod.outlook.com
 (2603:1096:4:92::20) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR02CA0104.apcprd02.prod.outlook.com (2603:1096:4:92::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3326.20 via Frontend Transport; Mon, 31 Aug 2020 07:50:49 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6b1e818c-8c76-41dc-e2f1-08d84d829767
X-MS-TrafficTypeDiagnostic: VI1PR04MB5694:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB56942F956D6E92933BE5C27D89510@VI1PR04MB5694.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i3jN3uMoEAHk3xJVsv/udf7bGqRRmLQF5x679sYhUyAiRHlwmDskbps+TEYehyjtmdmZtrvlQyT2wd633cJqqY2MXG412E+BJjAnEfUypInJkwgzh1ZfIFfp7UpKJTMectRf1o4G6/KoU3BpcnMQdUNgpO0KJnecWYn8YaPx7R99cTq6I/54f+1X611umd5yVayt26xlqc3bJr0Q0BEQTivQQjYA5upXVaI/E9QuPgl87DMzTNwdU30tkMjLBXNNbp9mBJZZ9qt0irGlIkvzBY+gUyaw9MKJFEkJbxYKlr7eOrQ7iQiQjz/qUqbPuuDItgbSkuzSDB+VEAIYekChRHtcHI8pGlU8Icy7OG7i3y4F++L6GKS1oVTvk1DyX86e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(8676002)(2616005)(2906002)(36756003)(8936002)(86362001)(5660300002)(956004)(316002)(26005)(6506007)(478600001)(6666004)(83380400001)(6486002)(7416002)(66476007)(66946007)(66556008)(4326008)(186003)(16526019)(6512007)(52116002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 46LzD8+/rUb/4lceR6M9brKLhvF4R/anEgAx4RwgZwPU88pVMk82Me+ouDb9kjaDrsOtxCYEZtMny1ASTq8gbllPwGdjnHG/+L80b3wnSGmIDPfxZR9S3rGpeOdK5tuNyaDmxWnYhRwXRIt49ZUhc4rWkRtuo7waLlOvDwNOSmy6HT70LS7CNGAIRIel4WPnkfNBMpeYnDJPCaIc6mUBywYMQnlRJjunya75VhxR3Y/8fkzbwf2zIkxc4E8LbgNGkU/K6xejmFRUp5pySbWU+XRt9dk+5UPTy2mdKJtzTeKWSNSBSvjAs1/RabDEckOdCMzsDZJTF8cxImXGBgn5M30+rt+bJAPFU5yhAmddz8hZdwsXBBED8vBnWBRSwNWf3Ul97XJMZyw3/pNCevN3SA4HkNs3D8lCLybycQ6DO/OqF1+Kv8ZI/CTjJzlWyoKf0v/0lGkcAPlgmrg1bGg33lPyrqEWfvipCWfpNi2VcTp6HoQFNJjH6OROofNjFIQDuAc9zZVcBnp/dnFrTwkAYxfO1t0CtBx419z0U5c6rLJpZRFrVLjM6eXYKbvCvKOPFn0O3sd/GMQjQIMdsJuyIVJG8QCZ0I7FrgIHhoKS+w0y/nWyj/Zx47lnqu+96/wCR2059YWHRR1XOJ4PNnbUDA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b1e818c-8c76-41dc-e2f1-08d84d829767
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 07:50:55.8178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N7wqh8GRolEqNJA5q0VtX+aPUTw5rODju7+MHbLP/FdvARXFCNFkG32WLhwYFJ3QmsM4naJuT29vX411wXGwog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5694
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Since sdma_transfer_init() will do sdma_load_context before any
sdma transfer, no need once more in sdma_config_channel().

Fixes: ad0d92d7ba6a ("dmaengine: imx-sdma: refine to load context only once")
Cc: <stable@vger.kernel.org>
Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
Tested-by: Richard Leitner <richard.leitner@skidata.com>
---
 drivers/dma/imx-sdma.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 22be370..f899083 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1139,7 +1139,6 @@ static void sdma_set_watermarklevel_for_p2p(struct sdma_channel *sdmac)
 static int sdma_config_channel(struct dma_chan *chan)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
-	int ret;
 
 	sdma_disable_channel(chan);
 
@@ -1179,9 +1178,7 @@ static int sdma_config_channel(struct dma_chan *chan)
 		sdmac->watermark_level = 0; /* FIXME: M3_BASE_ADDRESS */
 	}
 
-	ret = sdma_load_context(sdmac);
-
-	return ret;
+	return 0;
 }
 
 static int sdma_set_channel_priority(struct sdma_channel *sdmac,
-- 
2.7.4

