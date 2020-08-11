Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96FC524174F
	for <lists+dmaengine@lfdr.de>; Tue, 11 Aug 2020 09:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgHKHkL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Aug 2020 03:40:11 -0400
Received: from mail-eopbgr130041.outbound.protection.outlook.com ([40.107.13.41]:10209
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726397AbgHKHkK (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 11 Aug 2020 03:40:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7Jun8DpPYZ8cmoAAAu6NoRZIDQ24jX5l/EE4RP2iAUs2tWxNR3MSm8zWd+f/V8yD/zu5aT1Dgj9QAYM2NhyJ6eW1wl94hC0hoc55n3oDFWFLS5FUtyONUeRl8a1B/W+CwlEiX40SGj+6g1kxkxDKZB2GnbbFzeFgn5E0Ls2p4jjEU1D8IjQb3zXBFSQuzWZagADWagidgSD+hPINOnfAWd368Hi1ubUBLKXj3xRCssw0g/F0A8LpVGaNiZ16OBeuXl+yqwINOVVoLRu0L9HD8+ODRlSkliRjgnZnhxPicmJSH/tzHLUYCMMrDp9bX8Vo5YNqigPHdFRm3jSQd1nGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/QmptLzISEg8XISPPONCPgPblgFAEAKYoqgWtaOmaQ=;
 b=Y3aWCyLR0I8pGKDBsRTp8CVkA+/MKMSEP8CtS1Y+8vISaeLjHPzZ0gOis5o6bN3ke9I8D6b7m0JNFeOzfXxy+Z9Rlyy6pAw4/hceQHaAk7OwC47XuFL/9XCLHAC/N3E2PLD1WlW3+ADubX9F60wJOdBc0Le/xssSUz+A3Z1Hdzd44Jv1av/d6AtAD+Nil0Aacyy5TLPpwB2n5R+TUIAeBRuvagYzf5loS0u4z2mvnOrm5AEBrRcqSlhZjN8KaRzLjPpc+jvfOYo1wJBEuExVW0JQSK3ZS4m7aERXgvNgm1mmVIceeIMOWOnT1sNeGLQRygjdwanztDhy1IAhZoMCwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/QmptLzISEg8XISPPONCPgPblgFAEAKYoqgWtaOmaQ=;
 b=U0fGc4PFuQ1NoYIPTW3vhHLOo3rWOZWqwiCT8mmFOwl+/iAA6edHuiHjMpGXBd3MCsTJU9epFGtwo0xpL6QqRnuEGtWuJ+gxS6WwVvn2d50gZjy+VL4H7x3JE2miwuRohEqzfyOgxGZzGxaP57gRRqwopJPZufEJi/MY8soL+bo=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33)
 by AM6PR0402MB3464.eurprd04.prod.outlook.com (2603:10a6:209:12::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Tue, 11 Aug
 2020 07:40:04 +0000
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::c9b8:4020:7705:e3dd]) by AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::c9b8:4020:7705:e3dd%7]) with mapi id 15.20.3261.025; Tue, 11 Aug 2020
 07:40:04 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, r.schwebel@pengutronix.de
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v12 03/12] Revert "dmaengine: imx-sdma: refine to load context only once"
Date:   Tue, 11 Aug 2020 23:53:42 +0800
Message-Id: <1597161231-32303-4-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597161231-32303-1-git-send-email-yibin.gong@nxp.com>
References: <1597161231-32303-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) To
 AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3305.2 via Frontend Transport; Tue, 11 Aug 2020 07:39:57 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7d11a531-25a5-4cdb-8729-08d83dc9c25f
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3464:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR0402MB3464D09A8FCA7ADBA331C94089450@AM6PR0402MB3464.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:119;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BkSrftn3pruWRwo6pw8022GkqbaQRhsuKPVZioE5/XKUqEJzJNEOvsKClatY4m+NRddyXvBohV4xG5CXQDmEled2sVABh6yWGIeNTr+HEdPhV/kcBHtvdyG5Kkd4739hxOSfBL4p6gk8mbnJcJccW+Tt/ga8IbVJ/SRJcK70aRHkL8G5c3Z27XmjFbqd7r6BJyI6w5FX+ANTYAWNL3nD4X5u4ToLm+XPqU14HH6zeHkJz03HusYwc2tPD8WmAG1IMsOTXYrRJE/LyXqqf7E+gWXLLTMHdaMsHvsFxnbNiUwmLSeMaKS1fv7WLRsXazyC+XgKVqq6Dbmo91zwGKpYY5pS78giuPalsqhd+nNiYWmrdInb2K9irBfk+zVukTDF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(4326008)(5660300002)(52116002)(66476007)(66556008)(86362001)(956004)(66946007)(6486002)(2616005)(7416002)(316002)(36756003)(186003)(2906002)(8676002)(6506007)(6666004)(6512007)(8936002)(26005)(478600001)(83380400001)(16526019)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: C+VAUbduZMlV96bkZ7xPgHvHDfRc9zqgNiMptTVQOxl+4mUkkhkgnc7OZPUVhUCgWYcjlxPLfJ0+y7bLyzYmiW+ayE8PE0E+bKdfc+9UbmXlUg4AD4R1OavAIMp3Vc0QCcs25YjkwkAhPT4b5oL6uvn+oApFj1GAk80mm1Ell65e315/IUPDV2Ty/7tig8QGoav5NMKMfD3gjqY6h1KWIBsOIASCS8SddOw2ZIifagxq6P+bOkJnMPUwNOh1g50s7QxuigRJ5300Sy/cSL/NY7bxgY7K3Gyc2pR+y72IYDBYRHZY4kDecuCa+axxoXVgSjLvu8Nq7epnVA5goNh4rtEClRLbh97d3uVAgQxVGm+Ap/3a/jHl47zl3uSjrFGbB34ENIxWqs/v+dAwtYpN3lOmxyI1Y6mLliHHRTpOYuPUrGSSgkzO9/hZQJX80fkEReVuuOJorQe1pgoWauzOKhryktZqYNNid7PjU4Y1CPnf01QQIDXLV9rIuMebrmVemrLy0yxoeI+K/QZ1Zgo+mfajpfFSz6fQlz5eEW6ud5les3lDYRjtgzrpNANmO7Mx//LyT14Lbe45URygzBOvEAHiMCfSNn/I5D7LdCZvsu/24YwBzoILmg5cm/JUXBeY5ob6m+qzuyGpE3FsjYK7hA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d11a531-25a5-4cdb-8729-08d83dc9c25f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 07:40:03.6763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WwJrd2ft0rbljO14RIIvNre6qUfNJ6izKDr8XuuLg2gS4g7CZw3j6mU5sdjRD2YQw+OVYBofdVRIDJooZR9CSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3464
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This reverts commit ad0d92d7ba6aecbe2705907c38ff8d8be4da1e9c, because
in spi-imx case, burst length may be changed dynamically.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/dma/imx-sdma.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 270992c..d305b80 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -377,7 +377,6 @@ struct sdma_channel {
 	unsigned long			watermark_level;
 	u32				shp_addr, per_addr;
 	enum dma_status			status;
-	bool				context_loaded;
 	struct imx_dma_data		data;
 	struct work_struct		terminate_worker;
 };
@@ -984,9 +983,6 @@ static int sdma_load_context(struct sdma_channel *sdmac)
 	int ret;
 	unsigned long flags;
 
-	if (sdmac->context_loaded)
-		return 0;
-
 	if (sdmac->direction == DMA_DEV_TO_MEM)
 		load_address = sdmac->pc_from_device;
 	else if (sdmac->direction == DMA_DEV_TO_DEV)
@@ -1029,8 +1025,6 @@ static int sdma_load_context(struct sdma_channel *sdmac)
 
 	spin_unlock_irqrestore(&sdma->channel_0_lock, flags);
 
-	sdmac->context_loaded = true;
-
 	return ret;
 }
 
@@ -1069,7 +1063,6 @@ static void sdma_channel_terminate_work(struct work_struct *work)
 	vchan_get_all_descriptors(&sdmac->vc, &head);
 	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
 	vchan_dma_desc_free_list(&sdmac->vc, &head);
-	sdmac->context_loaded = false;
 }
 
 static int sdma_terminate_all(struct dma_chan *chan)
@@ -1337,7 +1330,6 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
 
 	sdmac->event_id0 = 0;
 	sdmac->event_id1 = 0;
-	sdmac->context_loaded = false;
 
 	sdma_set_channel_priority(sdmac, 0);
 
-- 
2.7.4

