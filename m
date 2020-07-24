Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C76922C33F
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jul 2020 12:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgGXKhb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Jul 2020 06:37:31 -0400
Received: from mail-eopbgr80079.outbound.protection.outlook.com ([40.107.8.79]:43491
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726329AbgGXKhb (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 24 Jul 2020 06:37:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DjGp9xCgvFnJkWvniYdRcUxgk0N7QaETQdoQkjk+rIV2/qE2kwyEmnY9h3ZH5uwl7Fccuao5mg+hVZ/xrmYWrUC4YKjs1mqwbENY9GjoD8EaLJG37bKo5Z2oBvOFvQEpvfFwsgwCbQh/rQI9m/tI6/eiewq1yab8y3GVJJDgZbq2Xq8vb84Chshj1IH7S0JM41eCkgWyqbhP7OqSMSTFKso9hs5fVaF12WN3/2QzjfKjsiArz7zUHnBZ59/JBKmxoYCESGJUhzp2+LrOwY0VzhywtlRwSfhp3I9PaVxBxx66Ll8WMNyo2aW6A8owXReo6Mms42EKJKH8MzGzX08aWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/QmptLzISEg8XISPPONCPgPblgFAEAKYoqgWtaOmaQ=;
 b=FAMviq5Bai87jArbqNTQLLy5B7B2TCPbk4SHQdsMzA563gj4cjPELxbg/+DcLWTBBHCGXDC1g6owb2SNwljqG2H+6gZAfzJVKHOq1J/80wdkdg3jYXOYshCaRh+3lap84yMmmUvCJbTtZdIY/20VnjaDOfxkP2AyvsMqZvzHpaQ2dZIEALCr7CKv1J8ZiZg0QQ40e6Ka4kejJK0k2F3BYvZFbuDkatvWhTBOJbEuG+EwUTMYIksUYBENRFtDVjJv4vZS1eryO4Ei/zoVRta6+93H9L6z+GOxwGibJQzIgj5LQJQe7q7fjZWZDliEMMdR3Y2la/CsuOtzzAbp5UXtLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/QmptLzISEg8XISPPONCPgPblgFAEAKYoqgWtaOmaQ=;
 b=sAsIRgNmd3+d6BSY29T3BfWdiQbanZRlW7Fl6bf4gI6PZBp0lQddJ9udX/zM4DPiE9u8ZdnCsHXWvnB33cHuA3EY+qpzKSX2fbTEguh35vk3nPUQExFkC3OEXMD/T6hMNiWeG0/vyTB+/69z2xd87+bFsgQFPR6Z24Wb+LMnXOE=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR0402MB3710.eurprd04.prod.outlook.com (2603:10a6:803:25::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 10:37:27 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3195.028; Fri, 24 Jul 2020
 10:37:27 +0000
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
Subject: [PATCH v11 03/12] Revert "dmaengine: imx-sdma: refine to load context only once"
Date:   Sat, 25 Jul 2020 02:51:16 +0800
Message-Id: <1595616685-9987-4-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595616685-9987-1-git-send-email-yibin.gong@nxp.com>
References: <1595616685-9987-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:3:18::34) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR02CA0046.apcprd02.prod.outlook.com (2603:1096:3:18::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3216.20 via Frontend Transport; Fri, 24 Jul 2020 10:37:21 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 41482e21-c99f-42e9-6c82-08d82fbd8f07
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3710:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3710E8ABCCC49158D79FCB0089770@VI1PR0402MB3710.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:119;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xDU1ctRHK3g1BjHnrjKSkm1EYYFhrochFMcdP1LAucmU2lZjNV8dtS46GZqKibgvTbXVMrGkvcSQpfLVNkdPyqoTouZThghxCr0Ud5TMpGlTvJ72wRHNflappNmlKKIR65675jsb5M8a6PR4Tq2mwJZ1higS8hH14Kv1T8jYl6vL3h4ur4WG2O7ViNAh55EAegJAqzkGt+ftDnngpjP7Wmneif4EfQRcMF++r8QLjDP+TW4+aQVBe2Xk9SLvxl/m8mIyo6qfEUAaS9/iGAZEbd5CYgO1RACoO18hNQF/pN4PzaEJ98kgzCs7VN/F2ByRLAetlo/5bJEp6rnzbFzmYl7MIUoEmm7n++KWR6MHEDXtXEluZMczf7CGX6RjyZch
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(16526019)(186003)(66476007)(2906002)(8936002)(83380400001)(66556008)(478600001)(5660300002)(7416002)(52116002)(6512007)(36756003)(316002)(2616005)(6486002)(8676002)(26005)(6666004)(86362001)(4326008)(66946007)(956004)(6506007)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: V1CDaTuM3zMycf7Hytx6WJiuUFaFZKa9RO0N3zAb64mYkFn3wFngkSwQZSuitHiPp4Y3nt0Tl7+jrfYmn6mvq3ZPqj1ExVTxhwiv3UMBR/TYz4+FnY0EibyZ9bk60u6mrv5j5y3lOHI+TBU2XgTDw5sFKO/X22vTjffHYUYWxhCl6jJaxfVxhcTsRwvRssIuskEhP4Zh2xT6j1enm10XEs72WomVjcvUDTUbV4RPnr0AtGf8XkSwNrD+pIJkAOObDFh2pXYmDrmfrJxj/5SzbeYNQSA34RGabrhxf1wAzR5GYAXrrjCPsQdgB27AZBAN/G5CT+rE3rT1uPGrM2diC9uwfgWvN21vrwdMq3nhdE+rdNnsMaVWUq4sJOpa32+z53EHgLG/70nwL4//4JWefAuhwefgkPAsUhxnKPmsSgDVGqhCBh5UzD1Wpg5MTz0ZcKGLJAT9CluYxYHTsGRAoomadI/n3bb3t++x2RQ5KXg=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41482e21-c99f-42e9-6c82-08d82fbd8f07
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 10:37:26.9477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v05JIuaxW77RugL/ASttVUwoVJC70R8hb8SUb1t2R0c1aN9cJoCLIXjCm+AegWCPzgo+M4mg9Ztu0SQhpVev1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3710
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

