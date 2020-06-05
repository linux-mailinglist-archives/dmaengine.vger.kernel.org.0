Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8044D1EF925
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2020 15:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgFENcy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 5 Jun 2020 09:32:54 -0400
Received: from mail-db8eur05on2042.outbound.protection.outlook.com ([40.107.20.42]:6195
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727116AbgFENcx (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 5 Jun 2020 09:32:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AE93dS5n6iCw4595yz1+tV6PJesjmLEA8HvBLLJ5D0NDdO/6rTvbcnNsMJ8OUpBkexAmxAM5U6AoRV7nvViqw85fBxYoPN7t1F4j4H/kvwyMPnTkHtRVweC7KSY72CV3lclDTC3oIJ3zrGXAeWm098dITu7ktjnK0YDkOW6Ec+9pDAXIwa0AzlTiApV3aRqOtbVwSejO2svNxBp3KJBQB+RTkFQPhYSdbe+iZNINFTmzO3+9VC0+xmhSZMXdKupz2z4gpLmUi/61I6QebnNmwE2N+wNZPyAi37s1fJFQaNAeII0//Gg6/BDFKPyzvPMHWG+jFlxf1rzr/nnTzPhF7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sR1u5QVWcsTcn8Rv9kigsA1HCSXIoglRvxRKA0j3gMQ=;
 b=WZZTu3nzBDDH+dwXan7nyHoXaASvQHPMOZk6+pbgiO/ehkivx2ZqV04tBRJN1mQ0Mo8vJxXtVjgRSstTufcHHAmXue66kU4GdzUUTw0crwmSrQR/pTwty7Tbagh2tfLG8ajaRt1luCIgealkH+uLA0AeLnk3i1hTZ99qs4966d/DkkSOE8mfi5x6p29zB8LPLu5WGRwFd/NVeremNovNI53Fb6+eozXkPytThs3hgGzcmi6APtcgChg0xoH6MZ3S9xL5NEuIcdZQF6kLtLv7FXOHKixvSC56teZWnAiCDQXaswVrrZq1rmo4oNXD9lcNFMieUXIfSUcSPvX+qFNCzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sR1u5QVWcsTcn8Rv9kigsA1HCSXIoglRvxRKA0j3gMQ=;
 b=kSE8s1shNGO+bdeVD583+GVEPg+8q3iZRJWXTqXvWZuRTsWPr+uagV1TkZ8BRSu04mrvTylZkRw0J7OvFcpV5mhJWOhGHNCnEPsLmdCElO1RsYTxKuiomufVO+2+d0Hijznqz1/B4YugqiREj90RvkpFPeEfGcYsyrfDX+w0ATM=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6702.eurprd04.prod.outlook.com (2603:10a6:803:123::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Fri, 5 Jun
 2020 13:32:48 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3066.019; Fri, 5 Jun 2020
 13:32:48 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-imx@nxp.com, dmaengine@vger.kernel.org
Subject: [PATCH v9 04/14] dmaengine: imx-sdma: remove duplicated sdma_load_context
Date:   Sat,  6 Jun 2020 05:32:25 +0800
Message-Id: <1591392755-19136-5-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591392755-19136-1-git-send-email-yibin.gong@nxp.com>
References: <1591392755-19136-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:3:18::36) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR02CA0048.apcprd02.prod.outlook.com (2603:1096:3:18::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3066.20 via Frontend Transport; Fri, 5 Jun 2020 13:32:42 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bc510279-98f5-4f1a-407f-08d80954f001
X-MS-TrafficTypeDiagnostic: VE1PR04MB6702:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6702ACD50AD457A991E87B7189860@VE1PR04MB6702.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-Forefront-PRVS: 0425A67DEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D4v/aYdV6kNvUAQuTCzGtMjMiN51QsIzEqEETkiuVxjdf3vIMRnPfvkZm461FPag1N64MOsip31Qha6MX97rrqMzxUSy3B3jhgRWXYbrRpcG9O8z0OZdJYYc4GaXxBG8KQEjYLMQOdCfLni1Rkuee+bDZrpLfV8ZvFYRiQkxkpTZ7kz1mbUV8ZZ0zbO30GV+gHelGln+RotnoYHtoTMvK6B0jrKS90Q+sQO5wCFjHlJQfS4bAn36EvxS/36OlMdo0Aaa6pNhREyJKBbgui5HnAfGkfi3UqTQFknhxSokxuSjAXJLzHuz6tYxTVMEJtqbziUn0HTX5vut8jqRitgTCKxRsmBREJkrGQ87iBy8Qu6yvbFz0dAkODB8/K43Ce8e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(6486002)(52116002)(2906002)(316002)(4326008)(6506007)(5660300002)(26005)(66946007)(2616005)(956004)(478600001)(66556008)(186003)(8676002)(16526019)(7416002)(6512007)(6666004)(36756003)(8936002)(83380400001)(4744005)(86362001)(66476007)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: r4wWjWX5YyU8hiwJdkr8lM+XTZrJvEdQJyk0gjV2Gc9GumuqpC9LKGsFmAuyhpsBCpBdSbVdB4jYaY7DMBd8p2CA6tGENSvKf+//YA8bglXkKUmsIxqv6P0RKada5o8mJghSXjw7KZFCDlVj8Xz4o46nG8MEo94YzEPCoYb9sPeoRkuZLFl4Nyw4/w+QItTdEnReTgQsdg9RUTVKFNIT/ZHAG4ZzxmUyG5SeQJg+0/YuTecl+iTp/NHos7HoQvYk2Rf4mUMdASf9rh/o60nhWxlDl8rOnxE6ROD2U2ep3HsCGEO5WNnu/0UlERpO5W81wZW8Gd6It8xUb1+oJ+mVu1O8iiT0ECfY6RtQjR1YW8S119W6ELbT6SISSfTkBUqZ4Fe2DmGpBsf6pvZA7H3Afl0G+OB1Kj0DUGwUgumS9f07BUew8wPZSA9vb/8nULEloyrNom18BpwF5dqswZpEA1LtMNOyFwQ1+t0r9WHrknE=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc510279-98f5-4f1a-407f-08d80954f001
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2020 13:32:48.5149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9IW7nXsizrKyxB/6I4wu6hTCj9E5qEv3/ojP3y7FyTl7pC4qM/upAVqMiBLFTZqQmlLOzkTdgyIaaTSLKcL9fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6702
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
index b1f61eb..4440ddb 100644
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

