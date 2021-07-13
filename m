Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673B03C6E72
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jul 2021 12:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbhGMK2h (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jul 2021 06:28:37 -0400
Received: from mail-eopbgr20070.outbound.protection.outlook.com ([40.107.2.70]:45159
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235595AbhGMK2g (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 13 Jul 2021 06:28:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jt+4RxfFQBy3YX2myUSs1D/UpOuN+dLEZdhDo6uDh4bvR03aOwwASm4lFp2uYRM2R+Ho7WB0pEVVt+1V8znLp9qDAu7MFX8sEgI9erBM46ZkKWmAwo23BRee2FFhoKsUULbPZc0cU6qTX35E9WI5q2by2vUyQf76WTqtVdBThzvGafGE3ogRaaODAenc3SDkTup4dZr0LEfHwkqog5OE0TfQCtQ93dg0OuMwL1Ssxv2m3TfQnq8IP1KMliZA17AK3INuaLNGXGKWDN3PfZTfvUJzZNV4WPuJzmDh8UapObw5pS8InxQbDijMXbxH7suBFovAMT4S4eIy4JtWk/dNsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O26POmsGphSxwJgUL6Oe/jseTLhWb+pnxNqyrwdqNaU=;
 b=MoAGHgn5l6EL0nTWedX/4NodJ+e/FJ+9Bi8zSFb0egZpLjc7f7EQ+Jf2qsM+8rgrFwdCZLe6j+R7Wma5xiyuEMmOmXOR78Xq5jBocqs3nC1f5j5N4pbnS00/lMUz8NsrgkZh6ez6bofFc3aVzcnhKWw2NzYNV0EVbcYFtkOUnMBh3vptq2nBwE8woUHF5oJlVd7iSKzNTS027W5i53ymlMXGWZv/qT/1oANar8O9qi0/1KIWCTXiTGydcuaKv6DhaoIgNFEkm/giap64IRFIoUrx6yR8TtYao58GOKNkxqt9MLuaqJvVn6Dnkwv9VQgjwNeAsNjTu+kJ3B15aYvbAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O26POmsGphSxwJgUL6Oe/jseTLhWb+pnxNqyrwdqNaU=;
 b=GXOIGyZ7bZ+yCZjfHxNIQcucnw8q8GK29iAzVsswy8kUK2p3FGCye3SCZnnCIUwhkiHus/8/muaNuBMaHKGBAQ4IKNt97cCUYZgRLXIqoOhl/2b4nK8NjSxUl0aYkFsGZaSxXhk8uGTJwd0uQiKr5Ryp7cwsY7N40GXZ155Bv4g=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR0401MB2288.eurprd04.prod.outlook.com (2603:10a6:800:28::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.25; Tue, 13 Jul
 2021 10:25:44 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076%5]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 10:25:44 +0000
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
Subject: [PATCH v15 03/12] Revert "dmaengine: imx-sdma: refine to load context only once"
Date:   Wed, 14 Jul 2021 02:41:40 +0800
Message-Id: <1626201709-19643-4-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626201709-19643-1-git-send-email-yibin.gong@nxp.com>
References: <1626201709-19643-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0198.apcprd06.prod.outlook.com (2603:1096:4:1::30)
 To VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR06CA0198.apcprd06.prod.outlook.com (2603:1096:4:1::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 10:25:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3db4daf-d977-4143-6ab0-08d945e892ad
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2288:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB22886643FEA088721FED7C9C89149@VI1PR0401MB2288.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:132;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YYqsSnLDhJB+B/oVnI8UCQsoNTtVUM7LPD9KtEp+mSwcshlYjrDeFnBuU+MVa2WiZ5a3OJ+BHf7kQzmXyJs1ubTMvfRiuDJC4zIWV2bfvi9O8nppX5K6668fAblRa7AaoK/UihlbIqEWhSIDN1WsV7rAqka4mGB7jbpIOjGGJTEYa3RjzWiSgLvSG5QehAjz+nw78O/VrkOMbo8/wkG+QKLiBfUcnHIsDrmZD0S+W/Grk9YLKx5yPEz/kLMuNiNaSuZlRb5TDmldiOAHDO88FGwRIHiY+o9fEiQDUlzubwJkpphdvE5Z/pl0Z/8ESanNipf5MA1kWJxa0A3UPwNHRU3iClCtEz1N5/8jZmUZT8nB01Ygr6WdjbgbIayFQ2Lg3dz1xuBErmy+15ktMCPWkruE2gOWwd4ROnZqPVZu9MUANYTMD82/oyLAw7E32vQTT6/PqZcLhx8mxg8et5Ut1iRG/vC3fmfqnRqR5zxs0U2kBt8kO4NqgSCnA9gdiD9H1Y7DTH/tzU8H8LX6DrIFbL0PTAdkW2hMfAWkiPAYxDypAkGth9yNGGFGkRhzg7oGjNRZ997DO0KgsA2aAGnniBS+PCmDNriayC8a/jqwxcGizU/csNYiCdg2g2A7Dw4n18PMv5YpQ5FaNq3aFglZMtH8I1lyXYIqB0JeJTNuG9cVMSpGdCZLc74EdDkYNd6gfq4adHOMWGTyREAXa7VEJLDzItWV+6QVz+CTFLM7Lng=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(396003)(39840400004)(376002)(6666004)(6512007)(316002)(83380400001)(66476007)(38350700002)(52116002)(86362001)(6506007)(8936002)(5660300002)(921005)(8676002)(36756003)(66556008)(186003)(26005)(66946007)(38100700002)(2616005)(2906002)(6636002)(4326008)(478600001)(6486002)(7416002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uykudO1djcQB4KAMJimxSqVSL95HMZOlc2i2pHElgTR8ZRFM6fStWbravtGt?=
 =?us-ascii?Q?r4nGVgqYFcN2Dg/4ZxYQ+whTvpsDG6N76zTS1w2vuHgloLt2+axmCfzlps+s?=
 =?us-ascii?Q?m3IlIvK5SpdNGPKznzPTzx8FmCYXzW0AT5ICILN2b2YroGmvCfulmPDWZYwk?=
 =?us-ascii?Q?lsLk68YUEMlRhULWennifDjjKuzL9RhLLv/a+WHqU7psSDJTilyLKh41My/n?=
 =?us-ascii?Q?PopuvWLdABQK5iNBm0eS2Tu883tbC5hcwCfJMU2xPJnkVQSbf5F82fJgybOg?=
 =?us-ascii?Q?JXTBcXbl+ynxYwM10bfD9UaLdBdtg7E9WmBbYeSHR9Dnry/hiLtYJoSwed/K?=
 =?us-ascii?Q?lVcRnGXERsPYiyYPPPSd6libLvqC2Is4wTAdJXrf9+1+gMS0uB4F5lm4AKnT?=
 =?us-ascii?Q?awP3HGeR53CKMZMIcw0/egE94rAp8W8xWZnbiCHV8DjSH0T4toRPY0lmKOxU?=
 =?us-ascii?Q?HB7Yjwz3sJwav+ve9Mv5/9sG/QvB40Nc5EPwONdfdESLdBqrDd9n9IMghX78?=
 =?us-ascii?Q?MDQmlrIFy+FlNJG/1COBF3wqhTb6m/0/Qhe5IgvA1Q9faA7w2yTR/DdTX8B+?=
 =?us-ascii?Q?gNlrQKd1siwC3qaC7u6gSHsCJmvQSz2LpmQLeO3XYRU9UxQnhSiyT3kL0OTS?=
 =?us-ascii?Q?82RagYAPuvNXtULtn2hjMIXjahL20004EcM2I315jIdLGJ636WufOVzpBoyD?=
 =?us-ascii?Q?UR5QgOIbmIAyKMrSspK495yeu6JZ7yevxbsLaMbioxBtS6w+TyipwvHYB9xf?=
 =?us-ascii?Q?yb7/wNzJSLcUTPiFiH0AD200MX1qOFt9Yk9ZwFiQKPlIXFVvEh7VhQOdO2rd?=
 =?us-ascii?Q?tNJfvBiGeu7b/Pr+K+ACMUZOrpLGrmcqv8HdYArVU12nsW35I+isX29ZdW+d?=
 =?us-ascii?Q?6KTigBbYEq1xfYWJFq8k2Y5idNciHS3PuzFDllR519s69edrwEJhAKXFVvsX?=
 =?us-ascii?Q?A4XdeE0Pve/QmYsOPpKlcP4GmvXpWSINQVPxNXF7hP9Pbla8NULeQnnzlYH+?=
 =?us-ascii?Q?8MHdnNqqFMdvazf1kMvmmQsZDX4qgX+VPvOK2UUOjFIZpHKj8r28ez+3tbLc?=
 =?us-ascii?Q?Gk3CLfLgeqqvnhPzSN9pPQYLEhr/Kny/z1eh5m5isCMqRdaYg+C/rhLwSnDT?=
 =?us-ascii?Q?zIX69UTHjhzna0nJqfzlWjnYDRUnOB6DXeUdJvd1hfwSpR/WOiF1pshacI+i?=
 =?us-ascii?Q?z0hhZhYvpG3cjuTrKIQNn7frCWE2SNQ/vfw70NjQKPWmIH4vEIvZWLxNAc4m?=
 =?us-ascii?Q?OP5QCSldTlxPcHbNm8JkUERiF7R35V0PpF2i1p8lhmOWm3wd2o+aS4dZnLv2?=
 =?us-ascii?Q?zig0MgIvGfda7othap4G1wwk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3db4daf-d977-4143-6ab0-08d945e892ad
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 10:25:44.6812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8M6IQFngskmyfneFms7Gn8do9DQJcxEv349goatILFcp2/Ey1WxUxqHRDCMAtGZ21gZ1nB+ssWLUxhU998uneA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2288
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This reverts commit ad0d92d7ba6aecbe2705907c38ff8d8be4da1e9c, because
in spi-imx case, burst length may be changed dynamically.

Fixes: ad0d92d7ba6a ("dmaengine: imx-sdma: refine to load context only once")
Cc: <stable@vger.kernel.org>
Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
Tested-by: Richard Leitner <richard.leitner@skidata.com>
---
 drivers/dma/imx-sdma.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 8070fd6..e510df0 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -433,7 +433,6 @@ struct sdma_channel {
 	unsigned long			watermark_level;
 	u32				shp_addr, per_addr;
 	enum dma_status			status;
-	bool				context_loaded;
 	struct imx_dma_data		data;
 	struct work_struct		terminate_worker;
 };
@@ -1008,9 +1007,6 @@ static int sdma_load_context(struct sdma_channel *sdmac)
 	int ret;
 	unsigned long flags;
 
-	if (sdmac->context_loaded)
-		return 0;
-
 	if (sdmac->direction == DMA_DEV_TO_MEM)
 		load_address = sdmac->pc_from_device;
 	else if (sdmac->direction == DMA_DEV_TO_DEV)
@@ -1053,8 +1049,6 @@ static int sdma_load_context(struct sdma_channel *sdmac)
 
 	spin_unlock_irqrestore(&sdma->channel_0_lock, flags);
 
-	sdmac->context_loaded = true;
-
 	return ret;
 }
 
@@ -1093,7 +1087,6 @@ static void sdma_channel_terminate_work(struct work_struct *work)
 	vchan_get_all_descriptors(&sdmac->vc, &head);
 	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
 	vchan_dma_desc_free_list(&sdmac->vc, &head);
-	sdmac->context_loaded = false;
 }
 
 static int sdma_terminate_all(struct dma_chan *chan)
@@ -1361,7 +1354,6 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
 
 	sdmac->event_id0 = 0;
 	sdmac->event_id1 = 0;
-	sdmac->context_loaded = false;
 
 	sdma_set_channel_priority(sdmac, 0);
 
-- 
2.7.4

