Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CA43C7B58
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jul 2021 04:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237413AbhGNCHq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jul 2021 22:07:46 -0400
Received: from mail-eopbgr60058.outbound.protection.outlook.com ([40.107.6.58]:59743
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237415AbhGNCHq (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 13 Jul 2021 22:07:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jm2rU8TLwi8eBYdlV7hUwNH774rM70TX16oaHvZbaHHh5LbdRd3CDY2PqCP67Dtxe8NeurzK2AcwzR4zDnzLasuclaLjr5FEyOB5FatpLj8cJLtxFIaX5MZ3tO2kXQs7yxXvdmQQTVkXgM+prCDFYkbfC+KPR3Gynp78gpjWKo9irDi6NhQX7N3QH5Ch4t5Nivd0JdDSrpJyFTdQACEf5jd4TW0IFfi/67vmJALpnaOz6vQk+Y0xshcjtfnXdSCu/6pKcTUKOhwxhFmxp6fAjFID7KpdtUFNSxW9unX7Fy6wYVAhJKHYZ3VW3Dy3+8sjt61hDo3IfvqlLWLUukU/NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckDPSsFVzv3NWjjrNqcD68iD8bHaj5KBipoUq89jOm0=;
 b=G8eSYpDDHgWfjcGyI7ppzVksf6nUKHqQmnjzQp4r2Bx+xZW9eGDh95CrffPgGuTWPfsf5SBhTUvtvB4dSJzU8aDbJ6cyi3LoA+ZP+qHp7bvyT8f12FP3/Pv996nztgct1ua5nlo6vKwUOWQxkZlButW/fNwOOIldDjdUIGcazUfXwHbDz49h9mbRdgAXSH8Kz/AVWKDvDqmjN4IcpUOzNhg2TwXtCZGuyOWHgJ5MBmvge3Qjg0yT2zQWPN0y5JFEKA1VUP8vj+3Ag5xv64XX0fn41HiJkUY9mhNIaqV83CILw9/jt/YNprmqW53cI4cBavXdwDjJjXDYbUZsU1RGpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckDPSsFVzv3NWjjrNqcD68iD8bHaj5KBipoUq89jOm0=;
 b=YbfXaLhEv4G8aJXScX6kUtLMm/DUE2Z39sKbPunZKmedh+FEr2tbH8aNqXg+VZGNOyMf9A3xkzNzzJNSxMDFUyHffpDGOIE/QW6KLkD4gUbSJ7zxkRZ5Xr7TJpO6u2Eq4BEHu+8Gx8v/+R1ueJbpjsga3bJBKafmlSaLJ+FB9Xc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR04MB4175.eurprd04.prod.outlook.com (2603:10a6:803:40::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Wed, 14 Jul
 2021 02:04:53 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076%5]) with mapi id 15.20.4331.021; Wed, 14 Jul 2021
 02:04:53 +0000
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
Subject: [PATCH v16 04/12] dmaengine: imx-sdma: remove duplicated sdma_load_context
Date:   Wed, 14 Jul 2021 18:20:44 +0800
Message-Id: <1626258052-22198-5-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626258052-22198-1-git-send-email-yibin.gong@nxp.com>
References: <1626258052-22198-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:3:17::28) To VE1PR04MB6688.eurprd04.prod.outlook.com
 (2603:10a6:803:127::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR02CA0016.apcprd02.prod.outlook.com (2603:1096:3:17::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 02:04:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68ab3e1e-78b9-4eac-c8ba-08d9466bc52a
X-MS-TrafficTypeDiagnostic: VI1PR04MB4175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB4175D85BCFB8F1E8ED33A47189139@VI1PR04MB4175.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RPrFb04//5rSgYSyqI/R4FVAcUi6NDuomAvdlcx/PGMjsjepb96Ri9099phRZiVxoIfzE91sbo4nRLVACI4QmvjHnNYYly0X6MHmA85BaK77+4TTaFGYPRqKM7U/WY++8rnofzvJ68PbqS1GRQVcFpzsqpGxzGXU7JoRODyZuIYShxDY2DReIIFF2NeUY1x3RQyitp9VVbDT6rujP6LHkdUSC+ESiCrMhk1ieIAsUTz15z9BWvX/2w91wI0AuMYFe9aX/Trj//PYOwzSw8d1K94Gklb3qJ0dj5sX1rmLdL1zqv/RsS8nd7RLGciBmd1rtkybw2OX6pz1E4cVRXBHDE4w8zJY5OzV3bJ3isvjcPqkUJr2Colwj/VKeXzCAP1k8ZElE9zPBi6rPs0+1IIV6ClksPqEmvx/8uv//wdK2Z2FsMZPvRygcFh+sglfBN7rPpK7jRXRaSmdKJ8jRgKZMD1+hBQ7OQpo7nVo71h2Uzp5C0ZpD/7pFChN4/1HKDGYVYW14vyddO6LKQgz2IxgXpOPRFnJcxUmhnd0xo8/GRvSKNZksWFNLNSSqj6ujYBzNkmPNpDnFrwfHi+l1Pk+8Ze/eIwdO3ctyWVyZZCff9ZcAnSNDLLXeRlFhOjkWySbFJtqsq6dZ0BZB+dECdngcDd1eNu7HRtq3lDHvZL8cDxTIIiJWWBTR8Eh2UP8RvnQfv7nAy3K7PIvsCF6wlFzRDOd8EAsdRGraZTc4JHb8ac=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(8936002)(7416002)(6512007)(2906002)(921005)(6636002)(6666004)(83380400001)(6506007)(86362001)(26005)(36756003)(4326008)(66476007)(478600001)(66556008)(956004)(52116002)(6486002)(8676002)(38350700002)(38100700002)(186003)(5660300002)(2616005)(316002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TZ1J8xbRyBmr5g7vOobkENJjGSTRjw5EQWfC0JXxFRjEZzcD8JHdHKNbsFkk?=
 =?us-ascii?Q?NEt1l26e2Wr5PA6WwvEziI2LLZ+8CNq49+UjSfuBntBl0oEHhUjfhVHVraAB?=
 =?us-ascii?Q?C83iCEsZusqIVymWOf5RDU1yf/U4o90BtbWQibAhWRMKwuQ9i6Ys8tn73UkX?=
 =?us-ascii?Q?o2S7/0/QekoXL/9rjy3AJ1gMyT8G/gKMpyq7MbP88kh60jRfgSKDq7Mn+eL9?=
 =?us-ascii?Q?75oxD4/2z7PvbxEwjWuvrxIjMgF3kBzjR9WpE2BA3ABGfcCQgdB73FZ2gWjC?=
 =?us-ascii?Q?TYoZsO5rGAIqqVPpRsNZ93F7lKFwlR0PnEU30N3/3xD6QOeB4IPhm0/GoD5p?=
 =?us-ascii?Q?syeussGN7JBH/TYyjs2uSyBHrNhidB7vp58vEDK+bNO0gqdfhza75VyLnUGo?=
 =?us-ascii?Q?8tSrrlrTNILoPqZn0ty4Hx9JaYGL8JTCweXTGTlcDM8aI2yENJfVO6QSKIWK?=
 =?us-ascii?Q?c3kUVZpKAWpIuLhhdKXcXQoO9xgy2T/nVBSf3O7HPyN9MmQo0OkQzxoikpaC?=
 =?us-ascii?Q?NG3XSpsKTAMSGqISHrPw1VRMtJUVwayUul9xdw+6VYi4J6LknXGoevBxIjvk?=
 =?us-ascii?Q?bjH3KYFRTkd8DkVo3YDl3QMRp/nNm2hQ6AVRJKSv4d2pNYhmqXjpjLF4WvMj?=
 =?us-ascii?Q?LQCy3pAi4EEMHBKf704kIGGMx1kGvLiW2oqnqOJ6H35/jac1lTL7HcZwKMX/?=
 =?us-ascii?Q?MCx3b8Ay2qEDK0uiTXpZLwnTKLEp8lGbxKKsZlf3ypkhRJtpF5ndGNCyzFaA?=
 =?us-ascii?Q?HKWlPCiHGAC47ecmGIq7ohnaC1PLjTqJVGH/F2aNE8BF8GyV/FNV6Re1zEj0?=
 =?us-ascii?Q?YPi7K/xKxfy0gxXoSvhajFKEGreZLLbyb0ZGO9LBIYfqxrHezn/jJud6aOPp?=
 =?us-ascii?Q?HFJ57/bq3gcDBX1wi8x/Z+tvrBv5dmbfHnuvNSaD1wXiNZA7soY2to7Y4RFA?=
 =?us-ascii?Q?wnj1py6FlW5mAdXweTbbyP3iT0AszX68663fQDDJdLZz0XsE88fw4ZcQupKf?=
 =?us-ascii?Q?x8FfknPkak6/BnGWXe5xoAX5bwV+qYkIxpStPUlRrrpm2SJICbLblafDqdRw?=
 =?us-ascii?Q?lwETj78xcRy20OcODvSa9YEcvctFzD0aQvdOj1MTYnHs3qisPt+QfWRx7WLD?=
 =?us-ascii?Q?SlLzSDmU+f9nyIJk7qmoyVp4AHArRb1uxTcJIsl/OnCl1jSH+rGd8XPcB4xW?=
 =?us-ascii?Q?GaEVw5KmqSgzpBKI903Nlp2mPcO7Pzo1eO+LOGU3Dp2DsoO/Cdf7Ys4FgePP?=
 =?us-ascii?Q?z/FgjLluVdrhbujI2gsYyxZeXBSfJ4fOyj6Hm/2YabtotFWiODn/kfS6Mo6G?=
 =?us-ascii?Q?izcmF8my2gMW/xDW25D6+Awi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ab3e1e-78b9-4eac-c8ba-08d9466bc52a
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 02:04:53.6564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S2+lgaOClQgDnd8Iq4eIG9AucPtjKQkvy5NzhD2MyJN2NnV7q+xVdTrYi8IucEzsPtpUKs0EUD0n5H7CoE9n2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4175
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
index e510df0..665ccbf 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1161,7 +1161,6 @@ static void sdma_set_watermarklevel_for_p2p(struct sdma_channel *sdmac)
 static int sdma_config_channel(struct dma_chan *chan)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
-	int ret;
 
 	sdma_disable_channel(chan);
 
@@ -1201,9 +1200,7 @@ static int sdma_config_channel(struct dma_chan *chan)
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

