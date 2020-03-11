Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3C21181327
	for <lists+dmaengine@lfdr.de>; Wed, 11 Mar 2020 09:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbgCKIfs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Mar 2020 04:35:48 -0400
Received: from mail-am6eur05on2083.outbound.protection.outlook.com ([40.107.22.83]:39520
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728514AbgCKIfs (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 11 Mar 2020 04:35:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JP/f/hAGJWdH0dRvBYNLimWJg8mGieWUccLgNw7oBsb8CLoJYcWENQ2n2VE/KZf0Ze0eHJIR+1YqpMpqQiAdNOZM6M+n2RWXzM5WSrQiYUc8d05oKU1CG4l6OM/NVR/jeXkqtaDZdDBiDwWHc868OzSNqHsLL8FNjFYWtEOb4B7mobT8HlfAgUls9C/J7oSkYpiNTdwCTQ+nMNc0tvkSN8gbV7Ec1qXs9KxzU3myX59Gacvmi0QgcQLz0oAyLPwKnIhogZEuzf/Df0RUiOxRcJ5Kuw2BgtnRrZdwjGBytXWQ440d5g3a1tfWPJwIZkmfhCzD4jcYydU3SbayQXTpcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRtb6xu+gu9ZrxAl+TPW+7oDi/VRvMarGC139iV3aBo=;
 b=cF5XPv3JeEpg3VvVdqUG9yyffJwIMltdGOFxwYMzoVz7dhpbAOlqTJ3GsGZSWvpIYWhXQBUu2yS3NHyNy+SnMBkMw18bRal+ZcYYM9kN8P1V4EWY1B3Ymcq7ppAxrJeYLBnUrzfjAi7XG+bgjm6vMtnymXCBPf2JAsa2EcMJBCcUX3dAnDO0hpd07yxkzzr89vBChIPPWTmAN3Ow3zdjY1lGBjrXMdL6VcwnS4gbUeLKh1QY5IpiBkmbvUuqpO7qODASzEiHCn6z/4h2Hfws8qMwA/X40zYnoDgtmhyHGJ+o1Ym8YIDrPqzBKGmJu5zfrBptO5gIAjzq+fzHTqSynQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRtb6xu+gu9ZrxAl+TPW+7oDi/VRvMarGC139iV3aBo=;
 b=b5hKlYyG00SBJSpGiHMhVU33JDCG5X0VNAcjDOm4pruL8pdMwTt17G1bGSzchN2i6noq1Ug8LQIjxShckOPJUA8niZyrMmSD60fwblmAGqKCY/wKCXaxbX7gal8SQwRn3rk9xwmYMk4CfeoZ2tw/wqBH8HBAluZ3BzDKB4Fzfi4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.232.15) by
 VE1PR04MB6702.eurprd04.prod.outlook.com (20.179.234.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Wed, 11 Mar 2020 08:35:43 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::490:6caa:24b:4a31]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::490:6caa:24b:4a31%6]) with mapi id 15.20.2793.018; Wed, 11 Mar 2020
 08:35:43 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     s.hauer@pengutronix.de, vkoul@kernel.org, shawnguo@kernel.org,
        u.kleine-koenig@pengutronix.de, broonie@kernel.org,
        robh+dt@kernel.org, festevam@gmail.com, dan.j.williams@intel.com,
        mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        l.stach@pengutronix.de, martin.fuzzey@flowbird.group
Cc:     kernel@pengutronix.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v7 05/13] dmaengine: imx-sdma: remove dupilicated sdma_load_context
Date:   Thu, 12 Mar 2020 00:36:28 +0800
Message-Id: <1583944596-23410-6-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583944596-23410-1-git-send-email-yibin.gong@nxp.com>
References: <1583944596-23410-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0158.apcprd04.prod.outlook.com (2603:1096:4::20)
 To VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR04CA0158.apcprd04.prod.outlook.com (2603:1096:4::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2793.15 via Frontend Transport; Wed, 11 Mar 2020 08:35:37 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 14033f02-a3b9-4467-9c09-08d7c5973000
X-MS-TrafficTypeDiagnostic: VE1PR04MB6702:|VE1PR04MB6702:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB67029E348FC521DB68BC846D89FC0@VE1PR04MB6702.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(199004)(4744005)(956004)(6486002)(2616005)(2906002)(6666004)(7416002)(66476007)(66946007)(8676002)(66556008)(316002)(86362001)(52116002)(478600001)(81166006)(6512007)(26005)(81156014)(6506007)(8936002)(36756003)(5660300002)(16526019)(4326008)(186003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6702;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Melf9OCa/R4sQM7omoDPmFN03D/UU/3a1Ag3E3XQmTzL5Uc6RScbfXJULdq/TTAv16toO0pphZXiU1XIdKyzgKP6fQqSxKoGyha/WBeKRUSKsbEv837mFzdCzGn9Fs83PlJnj3wLpowQ2pF/f7JEEFhuewd/BeTjxqXxWozTUY1HhCLpGBGs6ffEOxoOrFcVCrZqlD/IspE74MKXwWVuTi5v53kWrpxTIoUsY8B2fOJkkjxNxP1I3d2wjq+k4fT/xQq1yhK9oophPfNlx0RL1DmllIyKMTaJfIW6VPLePeooaJuBbPPIpuY4rvjXXidYy0tnlYL2EviqUPamDwvHY886+UtOHO6n6I47rJ4sOnhy/NDVxQVY8cjFAfIX2Pdf7QMttkUI8t4RRF17JqOl3Rs68u5rCbXx64NVBjFv4WYour+uA6Tijg3sYIbBintg8eUi0uYSnGibeCL7sOhRrjNcJwJFtlGmQjEKopMe+PiR1YfbVetDM0SAhWgiGv2h
X-MS-Exchange-AntiSpam-MessageData: liTbgfHsKWH7U65ocaBUnXDZb+Ee/fhJ7zdf+HJ8II+zYql6He6J9qm6O/Ox8rzJbXEr8qugQ9SuyVvDVpIBFAw4sc2TGbmTmYTznBiA6Tw7CPPIT4tbUPwmZzhn5pxSLW9ygjhyZOsD/Nz5JTNEQg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14033f02-a3b9-4467-9c09-08d7c5973000
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 08:35:43.5322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ESSkCVKl4yr6p/kqYxhmwFJaiaCbNZtgyQUkEn37hjwqSlakInKGkZZBIPl4F+0ofy4PQga0KdRlqZ7XnUtIGw==
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

