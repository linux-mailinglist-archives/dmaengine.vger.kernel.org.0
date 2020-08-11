Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB187241755
	for <lists+dmaengine@lfdr.de>; Tue, 11 Aug 2020 09:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgHKHkS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Aug 2020 03:40:18 -0400
Received: from mail-eopbgr130078.outbound.protection.outlook.com ([40.107.13.78]:64065
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726397AbgHKHkR (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 11 Aug 2020 03:40:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgAGv+BR86JLSG4w4Dha8F5omVMDZ2xyYXAafD6LelkXvTwIVzpIIkCCUAMgQ6LP9Zo4PGOPiPEcGSH6I0/D4/HqC4C7OUMnvY8nYxrAgB6rUCtss8pKf54IC8FSowj7iMIQhumrxeh3RLAUMs5cfQO4UOZeTm8UXAxa5aaU/uM/pDQ/Q39o2sRSj7Ua57bLaUxJMaXK5c4xm/4TKzgj1CqMVdgSNNKTIzWKE1IPVWUB+iHnb4IfDvaQEiH/Z50QEVdySVVPNiRVWe3UtimM54mN+vU6Tp1eQvToPJflgASngBNy0x/it4bOfBhfnjEo5N52L0mXSAlso0TEhR9Bng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IN1fRToEmGvcd3mguKJujHggzOr4K2gVkDIrU6mwPNY=;
 b=glNNGssq8AOkYxRYmMj1s+uQ7hL/dVgRjv0ssMI1sLoYzmlYmvElhldQxFgohl2O6gu83wvNGNCbDxDxmnllNIf+q6FwG9nsxotkxeaoFAXKEURZvXDT+mhkuHt2PzQfjKE1xzREeVYM3vJ06HfEP5dmB4nmuhTR1xOQMsZISJj3JjDy3wGSthcEK27AefA5CMiTZiootOSDH1k1uCNAOlS32Z3MZONSBbDyy54DVfWTrnWZEYz08WPhdZiObVHdqWfBOvZehxvEIaaVdCMo/KeIrBEmI97deGkwMZ1Q5XTzX3EQZfvVAzeZB6IoheSXhI1prr68XPq2V4v/QlikKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IN1fRToEmGvcd3mguKJujHggzOr4K2gVkDIrU6mwPNY=;
 b=gx8nj12TUk72xuqJVzKEPBDsfHECZjBmKVh1ntjHGDJNtlyysBOhgVbT/RoXSD0tcPfIfHuMXU6bkJhB0EVx3vioIyKNEYejh15/xAWAIKgXKesjfJrU9T7ZCgRGyEluxFOMQuB7MqdAHREmalO7JWbxMCG4WWfz0A0vTtdgrlE=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33)
 by AM6PR0402MB3464.eurprd04.prod.outlook.com (2603:10a6:209:12::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Tue, 11 Aug
 2020 07:40:11 +0000
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::c9b8:4020:7705:e3dd]) by AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::c9b8:4020:7705:e3dd%7]) with mapi id 15.20.3261.025; Tue, 11 Aug 2020
 07:40:11 +0000
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
Subject: [PATCH v12 04/12] dmaengine: imx-sdma: remove duplicated sdma_load_context
Date:   Tue, 11 Aug 2020 23:53:43 +0800
Message-Id: <1597161231-32303-5-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597161231-32303-1-git-send-email-yibin.gong@nxp.com>
References: <1597161231-32303-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) To
 AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3305.2 via Frontend Transport; Tue, 11 Aug 2020 07:40:04 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1d04907a-23c8-4539-3a9a-08d83dc9c6c4
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3464:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR0402MB3464AEB56A8D204AB86F864C89450@AM6PR0402MB3464.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Id2RyEoHTTDmzhQANEz+Iy/JI4pvtPjBn9RDI8KFw3R0pGnSk9dIPen4yRwkknn9GdqaTomWSZPmajtjsw+4q282p9BjrNnhxCOtzVUoQ9oVo2pYfU4giyBBcXzvMoB/yv39Kolx5OtZhF4h0kqIfPm3X9Iwfy/lyVrIIwR7v6RKM5n/jWeXuZ2xL1Alzd5hBtSKkNsLe7liur4oS4GN3RD9fCNt7hUTRrQIZWKu3bwhRZ7T/YS9U6CyCG9ZXG1Zmjnz+kzlewTjLyEop0mvyu99H+ZJBU3FUTqKtLerqHo3nA20nVc08e0hmsPXsyhh/RR4Kh2qfAwR0R4y/0DlCBVjPOpgD2bb/b9Lv8dPsO6FaFcumVMfvOTIdDjeF5Ad
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(4326008)(5660300002)(52116002)(66476007)(66556008)(86362001)(956004)(66946007)(6486002)(2616005)(7416002)(316002)(36756003)(186003)(2906002)(8676002)(6506007)(6666004)(6512007)(8936002)(26005)(478600001)(83380400001)(4744005)(16526019)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Bq1j8zHdILiNv03h+mTYEkmbHK7T9YH5y8A95eFFx3lBD5K2WB2exXJYhQxCmEZcVrRZLhJTJ6ABwfMW2hzYQZ5Fa8bKnGE4NzYYyGSUIo0dD1I1VDU9I8BS9dtoIUAKgsBV07z0dvof2mLd+DKW35yuJYrUWl1T1nTfIIfuna4qIxjNQ8tliMAH71tzHJOUHnGnKM6xqNX7eeo9KfUzx6anaNv7VN+Pu5ALVWXuQXq+f+XKxdcFOkvGFLxhEXREr3vURJsLvJ0/XGGyt7e+W7vBfMi5JpFV56ZS3kXF/6Pk/VdGDlKty5SQUfMje0rJ4fPGiyTbMeS73onwc7+YQHhPFJBQTqyf2ICkl1EYzYOz45gXi8ZmyVQ2wTBkEHvxbFCs0SYKaVBE2dOBbpQZAbNE1bu0bxUbrt724uyAuV5x8FgyC0OD0J4JbMAMsjb/8NuwTG4HubmUNXIAbDN0Bah0GAK5TMhOUHKo4Eva+aAx4edw5FPYic+JFaTQOH8mPgI4yie6Xmf2FyXRU9FgpwmZgy+i0xjGU7kaQa0PVZVMlEnDePzYdaTGk+16m9J+HHRP2612tYJjfJlmldCi7xoX5erN2Ctiur9BvTXAGr9qRQTJsQ3i2CEmB6wj2tPSTD4mbZMYZgjaY7/uIz+xNQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d04907a-23c8-4539-3a9a-08d83dc9c6c4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 07:40:11.2390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TSrxAgY2uThdyUnio+zbtcHGpL5TmvAl6YQ3oOGtBnBP0VJSZpozeR51so3q7Y3s1wSqIc3X3VNjslt6BgA4Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3464
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

