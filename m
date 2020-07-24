Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F68822C347
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jul 2020 12:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgGXKhh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Jul 2020 06:37:37 -0400
Received: from mail-eopbgr70059.outbound.protection.outlook.com ([40.107.7.59]:51008
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726329AbgGXKhh (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 24 Jul 2020 06:37:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GB6jWf5dSlX5Q+I9i9iMRSxBfSTOM3hehfhdcHsQtX1PSP4pDgLqi/bxuJow9auinb3ses77l+VKFNH2VJ1wlueU5a8Z+eRU6J8j+0V2VAMFQWtx/AL65aHV7Sf0qqLhTllVSELx+5khF0NS985dFgdhWryQ+j4hjwRgjlBKrYtzpzbAUdDT8+H7ErwzTFOhvME3IbAcqhQLDn9LLd0oytWUZynD0cnTq9BMJ97kNnJCrVtnbgyG4YUA762taFZuL9rICOy2elyWBVXSEfn0pd2fgziU3CWb6EMdz7VuU0tAD6lVBKccz+CVRjnduyOfaR9tcsaftKPOSHlOcbv9iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IN1fRToEmGvcd3mguKJujHggzOr4K2gVkDIrU6mwPNY=;
 b=NbO+JuOa1/ZPMEdExc3ayL1+TLBkW3nMXWT8gqzNwV2mBsqwQkeogLqhmzuleH3NMIlf8GNW6h+qZK+I27Awiul/fEvh4jVoDjujvQ93ncL41XgakDURg8rUYT0uVW0/imFGyGPje6kEejRF1TRsKpBLL6LxB9sTe98VhWU5t02Q8CrYwYK/2u4NT9T/xJKk+X3xgIr0oERz3fGaPxZD5pXf+rAVjXwUTeoqsZrJkZ9ORxaHmGokYQjgz2nJZ09dAdxdAD8fGXgUlL1yoZ4krNTzlRsZuu78vzf0CIdw7GkpGAAVsnD6L/KFzPD9UOiUQOgD0j4XGV4D15yoAXPoGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IN1fRToEmGvcd3mguKJujHggzOr4K2gVkDIrU6mwPNY=;
 b=ftEdCj7uEd2I1p/eXpinN7idfVX6IfBIi90lFKF7zAFezZEu2b5svheLha3GTZGKXhDvIf3W5+VFXJ92kus8G4BczyIHPdb8/IFynWcDCr6SX5aKlnQg7KsMWlW6Eu35Kw+e72VnRzHOXs+NY13scB3PJF+BT89B6d4q8nqcvzU=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR0402MB3710.eurprd04.prod.outlook.com (2603:10a6:803:25::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 10:37:33 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3195.028; Fri, 24 Jul 2020
 10:37:33 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v11 04/12] dmaengine: imx-sdma: remove duplicated sdma_load_context
Date:   Sat, 25 Jul 2020 02:51:17 +0800
Message-Id: <1595616685-9987-5-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595616685-9987-1-git-send-email-yibin.gong@nxp.com>
References: <1595616685-9987-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:3:18::34) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR02CA0046.apcprd02.prod.outlook.com (2603:1096:3:18::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3216.20 via Frontend Transport; Fri, 24 Jul 2020 10:37:27 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 98dd6f75-e829-4579-8adc-08d82fbd9283
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3710:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB37100932CCC43AA3EF2C79E989770@VI1PR0402MB3710.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ppS25ZMcLl7lltffqimFBngXQvu7EZYUqcCWScHq16Qx6ysRBUYETkAPcb6g5VV06rQABTMYfG/DQNnkut3hGhy38iLornrluiKJYzKi9G89V8wTtZnzDQOO89FWJ2fT+jWw0qkkwmKFFpeb3CHnqtH+hoBiwUnw5UyErbalqNvsuc/AdySMIabWV0q3F9ea0sUHs7vrTBmAGq3GrUa5YyiybZn5byY3nYSO56JWReedfLxH+y1Rp+xYkXdJYeQWUgrxFGSebcDxBBg+v/lXvHq3Se0sYapyD4o/2uSv/v5EMjNmCad7yfcYZJRHdi4TpgWHwnUCw1Y6YHl441nV6esiymh7m3BiEKU/uqZ0txi3hRrCojwp0IqvfkcC3D2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(16526019)(186003)(66476007)(2906002)(8936002)(4744005)(83380400001)(66556008)(478600001)(5660300002)(7416002)(52116002)(6512007)(36756003)(316002)(2616005)(6486002)(8676002)(26005)(6666004)(86362001)(4326008)(66946007)(956004)(6506007)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: TsVOVuaTviZl4To/WmmEoI6xDhhPmgFv7vV6ShREi2mSf9hEQAagEBAgdsY/MicBJW1+V3qiOOH9v23uwC21q86gdnh/lHifrLCzgJb9ABJ/jT89fh6XhLcQHoyXl0S0emNiSHoe62N6W3uqU4h9i+CcT1tCe3MBFfFMC44Tnj4aY4IdkkgBHbwSuvhk1cTN+w7VFFVxapnk0FBCs3lOEkX8HVZtSEq2mMNuju7gd10ugBejt/b19Xrh++daZnAFgRNOv7xmgx3td8gdMu+L56QNoe4jkXEJzNoiLi9FLL/g9+6bV2nnrInkqzog2pGgaOs+oaAqr+LqydbrbQ6YUlkwq+5YkihYN1gBogFl1Mea92KUU7T5myzyYHdfmfOvcfa/eeCQsyDyxqL+RzxOo5WyUm8pVangA2c/LjAEP+n3Ikxses7geSKkXS32pnwWA/O23ROTNtC+j8yZpu0+2nfIUb4Y3xcy25R6jJvP0Hk=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98dd6f75-e829-4579-8adc-08d82fbd9283
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 10:37:32.9292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sh6doN2ZdREhAr74gMU0UeTsAx/Smlck9IobOCqek+hiE6NwhMG3NYa7HcEv1jyhteSI2elkg1Y/m4QL1wEE3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3710
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Since sdma_transfer_init() will do sdma_load_context before any
sdma transfer, no need once more in sdma_config_channel().

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/imx-sdma.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index d305b80..5411e01e 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1137,7 +1137,6 @@ static void sdma_set_watermarklevel_for_p2p(struct sdma_channel *sdmac)
 static int sdma_config_channel(struct dma_chan *chan)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
-	int ret;
 
 	sdma_disable_channel(chan);
 
@@ -1177,9 +1176,7 @@ static int sdma_config_channel(struct dma_chan *chan)
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

