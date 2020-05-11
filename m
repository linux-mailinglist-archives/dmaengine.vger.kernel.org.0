Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189191CD507
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2020 11:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbgEKJcv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 May 2020 05:32:51 -0400
Received: from mail-eopbgr00053.outbound.protection.outlook.com ([40.107.0.53]:51937
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729459AbgEKJcu (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 11 May 2020 05:32:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAp/GoHUXdz0qpLuUXearEoI06lLCoyKGqBeWGqjWEsvAjvtMjM5m7EM1PQ5ySFXDrAvRN4qIccm1JFijaL1YiPDugD1vz4Hww72E9rH99bhqMW2IX8GTZbM6iJaM73qHujuUL8dpVWFhM/4YdbwanSkScBfj0yiPiKKOTiY5Sv4DocOg37zeNyf/hH1TetypRFbjLYpNANzaHP5oWSUH98FHABC71G3YOycNPA3Q0sEpnKk5amZ5bvm3yITpDtN1piUXeglvS4zdAWLkb9d4J0ky9thiwKFtBbeZ49aCfLjPYXMa7z9+cR2l71G41NENrUjsPglefOvL1XjN8e5cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRtb6xu+gu9ZrxAl+TPW+7oDi/VRvMarGC139iV3aBo=;
 b=TIwXTs/0hNYJnVcrqhHQMpTRxYYIELAPp/S59PP4R+oM+TZB1l5Z9Nl3A6YJdbdp+kq12Wp+5wiQzC5FXi43QJ8jjkv2uWqQd3udwkllpsPW3xVDTDGHPAO6VYPx7QSPi6/zhvBx6uDeYSgd2NobEjUuPuP5HFyjs55tCunzvo7URsRuV7iG2XXnBM9bFTRXyxnZqdcPa6BW5mL2vqe/vlfkr7y72Bppi2S+YB0/w7H7wUTJ9rl+pFjsV2FOXS4P3suVTSZS4kzqcTFBJQgumime1o7TROWF5h2SQD4UnKetbrPwEEiXHe0QPxRULWI8k1tr+4QzyZLany/i0O1sJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRtb6xu+gu9ZrxAl+TPW+7oDi/VRvMarGC139iV3aBo=;
 b=OOXYQOcKvGZYEpLxjYi3to0DSUzYq9f5m+p4EmmkXJ1tLSfvNXqeSXLvFSTGvYKr+TCt7BdPU3YKbiMEwXHsVm9CRPZU16UAmCX/tRcNKgBTFIVI9V1ahI+X3fp5yV1+VpRGU5yBMey2QRbWwyAj3iZFpg4Bw/iEh6NrTltHbBM=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6637.eurprd04.prod.outlook.com (2603:10a6:803:126::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Mon, 11 May
 2020 09:32:46 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa%4]) with mapi id 15.20.2979.033; Mon, 11 May 2020
 09:32:46 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     s.hauer@pengutronix.de, vkoul@kernel.org, shawnguo@kernel.org,
        u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        festevam@gmail.com, dan.j.williams@intel.com, mark.rutland@arm.com,
        catalin.marinas@arm.com
Cc:     will.deacon@arm.com, l.stach@pengutronix.de,
        martin.fuzzey@flowbird.group, kernel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v7 RESEND 05/13] dmaengine: imx-sdma: remove dupilicated sdma_load_context
Date:   Tue, 12 May 2020 01:32:28 +0800
Message-Id: <1589218356-17475-6-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589218356-17475-1-git-send-email-yibin.gong@nxp.com>
References: <1589218356-17475-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0141.apcprd06.prod.outlook.com
 (2603:1096:1:1f::19) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR06CA0141.apcprd06.prod.outlook.com (2603:1096:1:1f::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2979.27 via Frontend Transport; Mon, 11 May 2020 09:32:41 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1a082271-e689-4689-9d5b-08d7f58e434e
X-MS-TrafficTypeDiagnostic: VE1PR04MB6637:|VE1PR04MB6637:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB663727B8AD66E232719D11D189A10@VE1PR04MB6637.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-Forefront-PRVS: 04004D94E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X/KmZUUm4zdrAS18EzTXfwNdiOwfKBZ41hXO/9p+V/EUWqLRAokP5YOgOZKxE4V4uSgRkK+rpBG8AN7BUheXiqX6oKNUspWH+JwjM8ahcptLk6zdzwclV+FlS6I4XaDfSdSOvpi35T23aZkEpmz+vWi2d4JFnNaumaveDvc4tdy3vfDc2RxtZ7spqhrLDhO3q0s0MhTCGHitAfbiagxsEguFepv7PRL2DRi5P0cfYiZ1uLYPXiYufDud5QFXSv5cIST0BwXOdwUHUXRK+OvyAzBYpe4Bh0x7UZbbcwwop46S+jJRrynsaSK03exipFYKZnC2gRZr9DVJ7ETl/4nsj7Zb7iXvzCpYkKDIsoR/+WBh6lPfXv1DSbdNUfFkxVVl+azm5P86VuSoA7wnv0UjUNe3vI6Xj0pa1HjLkIwkbmB1gNx27VbZGzBYZF2BXMpuKkUare6IOWxwkn/1KCqjhFnjWjpyKjJgUycE2CqSPPDMu4gkyX/LI9RvCXWf9thevMDwQEXKbrtPfDe48YqSzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(33430700001)(8936002)(26005)(52116002)(6506007)(16526019)(2616005)(186003)(956004)(6666004)(6512007)(7416002)(5660300002)(2906002)(4326008)(6486002)(33440700001)(66476007)(8676002)(4744005)(66946007)(66556008)(478600001)(86362001)(316002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: pKWfMmo5bg4hkVgmSIqqWI2oEPqEI+V3M+yji7NOUID9iSc9a6KDFy8XoF4DHOKi61CL+iIcKsY/646MWN4RIa/xCLNqeOq2fbVaTKb3VO2NwoXQKA9IoAv2AtqFZitO/KIyaflWyzqfHdnralbbd/ay2R/GyNJugUfV3gW2pwCrjbXRJk+ijrP0QRlhtCSvziUpzOmfe92JPu3JdhrgcNS3itajGI1JQIFYLF7ndb7fvi00Ujc0HBbUDla9mVLWhq+uiydVbeWwcBl+wVw8m4mlc8mRSTdmPjMvKBe8DEh5TtWXyH89eQOSAcBtCbiPqJ+OxqFx0BoWzbmPr+Q2a15Yt/+5JjerTV4LVlDq9ElWVkUDJaGRiMQud6+lcHQBf1nQWpi78xhE427RamCCYNzrb3hgLVFI0sIJHbEZ6kQvIZV03WN5BubYWpVkvgthWc9Qtv9OGp5y2RomkWM0F4DiOlf7mdYIyksFXaHcyzk=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a082271-e689-4689-9d5b-08d7f58e434e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2020 09:32:46.2539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1OhbURJ5p1dFm1CcOXH2cut+ULfoAVKaYxAMmSWdFqcNcNYcQsQDslOf10Jyy/KzvON7l8s5B7D0r0hns22Ftw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6637
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
index 397f11d..69ea44d 100644
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

