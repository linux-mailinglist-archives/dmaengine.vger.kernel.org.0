Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEC3A3C7B54
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jul 2021 04:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237456AbhGNCHj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jul 2021 22:07:39 -0400
Received: from mail-eopbgr60044.outbound.protection.outlook.com ([40.107.6.44]:55091
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237441AbhGNCHj (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 13 Jul 2021 22:07:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9P4tlJETYWIyaGWVFUas/uM9sae3eAqh45fO4WqpyVR2Z0L02iuqd9T5IvBnZ5xXdzCSy1HM5VGA3nETsn3gT4FrfLcArpf548nXz/dYWRrg+HE4rnkuCH8ifFGuMyIM5V8SQSb3dGBERggELeVgBMJho8TaBeQlpRQgXd3a9dYq4K5N1rmYCHyP7pc+CKlncGke3eglEJ2je5EgLrNBWzbmyZuu4rE52XJjC5ps3cW3w+Wl8JFOlYEj5cwrKPBDWocqavuXKJdkWtlCBmP7ApJmhmOLy4BI4kkzg78aLn1v8oLTjOpnyRbGo8LSke2Gc1RAiuTDk7xBWDJ/nrpZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O26POmsGphSxwJgUL6Oe/jseTLhWb+pnxNqyrwdqNaU=;
 b=Py/moBDAO3I2rA3E4SpLv23EaNddJ8LJ+V5XzVMIkUtXYPDPUJnvX6Be1wltyBJf5ZBagsyJrfWNnsKx8J5DzqU0xcaMPpaNaKe+A0gOn4//mTDSHkIKLKeI6OuF28CVFrvVi4uYlpwL6p7weHas7SMUyOxIxEhvXRRKNNp8IOugBE7ZIr5GbvfX/ZbPu8HWH+oOokMhOG0lwpcWiWk6YDVBgmaWFvCh/CswxcYvJpaioywex/NJV0FTneeFiBShaIlL2vzXXh5yKHOw/pcU0xdEqCYJV0jNCRgeB0R5zengHf8DcT00vS/Wyr4wdDMAXy7oWiyeErh1r/5ofAp2tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O26POmsGphSxwJgUL6Oe/jseTLhWb+pnxNqyrwdqNaU=;
 b=RPuNfkWHvBpOIuoMJDEIqNQUX2GZr9XCQNBn17AhQHybgTHBexvE9q1H4eBdL9/Umlwx92khXNmSryS/plY/Yex5USVp89Dgf+ofs0MkAxwJBRZ7czvdlgsz9bG7/wseC/kNpJlcUf9Lc0kVSMSp0dfR2OiNbXhLglvBqnI7WC0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR04MB4175.eurprd04.prod.outlook.com (2603:10a6:803:40::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Wed, 14 Jul
 2021 02:04:46 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076%5]) with mapi id 15.20.4331.021; Wed, 14 Jul 2021
 02:04:46 +0000
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
Subject: [PATCH v16 03/12] Revert "dmaengine: imx-sdma: refine to load context only once"
Date:   Wed, 14 Jul 2021 18:20:43 +0800
Message-Id: <1626258052-22198-4-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626258052-22198-1-git-send-email-yibin.gong@nxp.com>
References: <1626258052-22198-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:3:17::28) To VE1PR04MB6688.eurprd04.prod.outlook.com
 (2603:10a6:803:127::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR02CA0016.apcprd02.prod.outlook.com (2603:1096:3:17::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 02:04:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 833ae4e0-22c1-4c4d-55f3-08d9466bc11b
X-MS-TrafficTypeDiagnostic: VI1PR04MB4175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB417526EE666CEEBA3FFA60E289139@VI1PR04MB4175.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:132;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sYZQbLXg1pLYGWGpzTN/xW9R6t3keS7vWHeXseghPtd7OQOwvAivnd4mYjoPFy25VT3tzXYgBcbiDYsqE2pZupi4Ymh3BevI8sGeQr3JOkS1Zx6FbB4A3kL3A+RwQyTZk8ShoNRFa6yGHG6eMsuWS6TYijK++5VQXjoP4wZ2bD2N2NDP8Z51qaviFibMM6cgGkDVTTHa+7l70wflk3wNgWeIeUmnDFA6Ivwq9WnQnqB+dT7dKOr22rX5v6qSkcxTCw0dh9HkBAKMl0iLSYg5ttHmcYRqQ7x8fGYu3In0iJgEA1fccoO9eueyWwhO2n0RHbarLYuXHHIcocMEnwCgcFJJPtJac4Y5pQ3f+bC7PT9dRivwA8TOBH8NWc9WD3076v9RYE0JMQ91clJI7pP+aSYxZJr30aAlFu5AecGiDu3bmnbnNzG13sguvxE+p393wzcY1tdUaUrf6eDrblFXn1N0OqgpgQFGphCOuWlX5fjFFJLqilARowWM6mngGymrB6eDO6/Sf7FKtDAQxfYCWWKvBY19/xionGqdsJaN4aEgWjaBF7Xu6w2wX5KPvpWrpaxPu6xwq7UMHV0DVuIlBU3//g8mz0F5SVDTyB+ms6fEsLcmdogPZWF9sbwxvUQsA5CdyE50CfDZShmZ/dhjtgPJJll3VmJh7A/2eRLb/wEKZYTzbzCpu+0tj1tVpksvgIIdf/adiAhE7JH1Xi5qCglEySxA/ArrUXTPIVfqN4g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(8936002)(7416002)(6512007)(2906002)(921005)(6636002)(83380400001)(6506007)(86362001)(26005)(36756003)(4326008)(66476007)(478600001)(66556008)(956004)(52116002)(6486002)(8676002)(38350700002)(38100700002)(186003)(5660300002)(2616005)(316002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XstRq1XgUyIKIcOgQYKraCIeQ2UVyfH0fVyefOGv8avl2LldXOc2nqt55m/5?=
 =?us-ascii?Q?J1BZlfPFdOIqxUcjSkMaGOsC/VcG7uhRZmcYUan3XzCM3+f4BclxZZY+XVvI?=
 =?us-ascii?Q?crh/l8kQDwMn4/FM+eatrW4e5tOcPPRyymbLZOWqj6ObNTXjeGD1IGCZDHrB?=
 =?us-ascii?Q?iiXswLQULag4JzA7RSkrQZC1Sh6/NJ1vmXuS9+Ie2zTFmpPZIY7fiEiTDJcx?=
 =?us-ascii?Q?NEPiseoQEPlWhoFXsjuGDOsWUr6x0SzciSZJp9GrhpfheslcRaAffqqdR1IV?=
 =?us-ascii?Q?hZ2Lg26Y28Kk6Yf6VKnyiEUk8u+lkYyIjaMgnP0g1mYhUGd3uZnYrv/I+TLk?=
 =?us-ascii?Q?VwYk1pc/udhKxIEmXgKE2/KMUMv1/3YFEXPKiW57px7lqINA3mtmJzoYMPxl?=
 =?us-ascii?Q?YOhIt94xEJUnxZfXEGlaEbA0SopODeNJhOAVP7NcrSI9ctxONaamIl+ZdySO?=
 =?us-ascii?Q?GEUC4sDcPexYq6z0qIfiSnCFRe5RFR/gHSodKxAggpFdJ1ul1qxeT9D9AABM?=
 =?us-ascii?Q?SlAq9MQHiTpr3uvIzuzWmWv9pa3Hj7v5p6F2BewBXsJ1Smpt2uM0Rq4JOWPf?=
 =?us-ascii?Q?nvQG/ehTuq5bxf5x+5oRyVGxpckdHEDCqHSdrqGuWcO1w/QK+bwkAOfj80w6?=
 =?us-ascii?Q?xsOBdlqSoE/mkexd1/KpHcSBUsfjkfG9rVp91vSN2VHG1emZfk5bmu6wz2W/?=
 =?us-ascii?Q?YEVwjoUa6aSl7555crt3fCHY1sWcNLkf2JfUDaolV7YxXkwn0ITZzPkBwpzd?=
 =?us-ascii?Q?d4FulNz7cjUPDsRpcPhXO/EMiQ6xHgConnNvOpy88HTB0AA64iHFeo6NOvpt?=
 =?us-ascii?Q?8mnCMo4T9xR1Bq1/n+NEsqGJJmNlKnWye+6Y+6gj71HPZGg1Lgu8hUWMLGEg?=
 =?us-ascii?Q?aASjGKkOwSAZPorpzcCfDzi0JRvAbskkM3jkK8grknf623QehH69Sd+nhVcW?=
 =?us-ascii?Q?qsGj8KR8vpm/knfgk/hG4PMTDLaQHdp/RW7DJs0Eye9ZJ53Jxk0bAfBn4aBI?=
 =?us-ascii?Q?r9BFEaCTdoBe1Ev62Oh4uaTbgn2wLy/cnLkdL3s32PnI685I7Lr6HZZVsTqB?=
 =?us-ascii?Q?r4PsOQx9hDkq0ZSzzUObI80c0K3vqIP7NcnzyEvUSlhkb7WmXnqHjdBAapRS?=
 =?us-ascii?Q?B2rqNMv1V5pyGpeZvOJIYbvUhV7tGDVVuAxGMGTmDO15AMLaoyQu0YmaeYIn?=
 =?us-ascii?Q?Tjqw46cdP0fCePgi9Nbo710Xbo2ACQX+p+lBLVS/+3ARVUvmG3hWwID9qPsS?=
 =?us-ascii?Q?nQba23gfOFoGKN3QwIUwQbUk3CQ5qdb4Gi9MnQxGg1GptB/lSBzMbZnHwIO2?=
 =?us-ascii?Q?iq6igNgQTnJPAvieAodQOW8U?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 833ae4e0-22c1-4c4d-55f3-08d9466bc11b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 02:04:46.7353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cwP9sr/mIEZrLjRUy/LxOQZse+GDDd8ahiXli7SOa7s7wvLoxKEMr8QqiQZFVvBqh0hYlv9EocQSDWupeFHxOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4175
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

