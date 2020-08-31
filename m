Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34B22574AD
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 09:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgHaHu7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 03:50:59 -0400
Received: from mail-eopbgr140050.outbound.protection.outlook.com ([40.107.14.50]:27033
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725978AbgHaHux (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 31 Aug 2020 03:50:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePycxlQb5KsTbK1no4vx9AgcXQF1BG9Mitut4URKuV3vqLKluy2RUVo0mEl7MmPSv6uUvUtxjmtKbmMCUxtfwHiAp2xCJ5DHME9ZJQryIM/67706qqqMsuEl3aGylEMlP2hVrda2lbv5wsSdHx8SqFWIlFmt44eBxXK9R0McUOlxJtbPwcJciFPZn3D6/6sKfmRCdd15nn2JIiTy6QPFiMFSzRYkW3Xk94qt6aar5Llza/Xs1Ty0HNmLFAMfRgceS2ezEPHJH+hT1sAJ5/RvDoYXVn/W8JWm9OKU17Y5TVaFQFF2TI7tQ8f8iEoF/JTRY7dIcxmhIuca26AOCJgXmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Q3ARDhbX3rbrZlYek/XpjdKznvOXTWnaLL2FJFyNLI=;
 b=PlRTG0wIbR6CjrPBNbVxjtEI/buOE+muGZWn5mZWJVDl4fCREkun3/HknQrHtkqYuwXiQkqYcFiGDGThKp8aubkTKTxKanm/LsO6C4biCzvjaa2vISfk3E0QoAbiNe+b1ywuiNtcZzMro3e+iQaExYIQsYdlhAnTSOx0Jm4UdbgJ2WQJ6vWQOjVc5VzKZCF2OEkTEvNTPPlSnOlEN2aj4zTjNQxjqMmjA1T3HYElLJAr88v+80bndQY94hoOxsIF1J7dovcBaDYIfAJlqT1W3D0D33r1i8RrRQkPVu5Gkynm1+RtL0YYJunnxSjoEkmy4bmkqru9Hhxo6mhBlQgY4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Q3ARDhbX3rbrZlYek/XpjdKznvOXTWnaLL2FJFyNLI=;
 b=RZmjTOt5PCfISRIjrKc5zd6rEjX+9j4t1Oj37d34gQ3cFzzI1HlgviBV7jDd7ppxt47mGyftMG+1/jQ6Mcz6dNnys4fJfBSBAiYQEtF4Ik24jz4O0xDnrPPJyyzijTO9LAU90VfxZ/WczRtaMO/AnGU63osxDAmD5N1MZOlBX8s=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR04MB5694.eurprd04.prod.outlook.com (2603:10a6:803:e0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Mon, 31 Aug
 2020 07:50:49 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950%3]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 07:50:49 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, r.schwebel@pengutronix.de,
        Benjamin.Bara@skidata.com, Richard.Leitner@skidata.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v13 03/12] Revert "dmaengine: imx-sdma: refine to load context only once"
Date:   Tue,  1 Sep 2020 00:03:16 +0800
Message-Id: <1598889805-30399-4-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598889805-30399-1-git-send-email-yibin.gong@nxp.com>
References: <1598889805-30399-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0104.apcprd02.prod.outlook.com
 (2603:1096:4:92::20) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR02CA0104.apcprd02.prod.outlook.com (2603:1096:4:92::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3326.20 via Frontend Transport; Mon, 31 Aug 2020 07:50:41 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fe0b75cf-4ba5-421d-7c39-08d84d82935d
X-MS-TrafficTypeDiagnostic: VI1PR04MB5694:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB5694AAF617929850A6969A0389510@VI1PR04MB5694.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:132;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: shPbDigghUCfhcOGFNdRWdRFF381rzqWiXlaReB/Q4SKls91vsYZXHolRP25+UF4/0/sQxqekpC9vUy7AonITLj+OGDtwPe6RnViN/EeZ3iMuGC+jYLOjCgTokzOHrEFN5GQO7D+9YHDJMUEGw0oga1Yx/YJ5LrahJ8AmZVT4bvCHVfHmOL6K2Z6ua1DxCzTUjRaZM0vIPjfOyTeOu8qqbMVqk/wJIjVrRXSigdvAQob3lgLlOep502du4E6TPiE4fEkKCqFNLktZyL60SMvUQwW2o/kesQfjcmwqQO/s3H+y/dKZPKvp3oqYmqSlPdiEve22Fx3tzr+VEoARfmZ12TO32WsMWpOVyTnZVAe22wayLjjzCmN5pA+5PnveZ0/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(8676002)(2616005)(2906002)(36756003)(8936002)(86362001)(5660300002)(956004)(316002)(26005)(6506007)(478600001)(6666004)(83380400001)(6486002)(7416002)(66476007)(66946007)(66556008)(4326008)(186003)(16526019)(6512007)(52116002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: bN5P8KQIxf6qqXWedEYXT+932ldNsSTqbCMo1Es5OWcBe7P5VAFmKU4W1DERylsWCToax6Javz/NAvn0K9akQcfnlXEPvgYMEjQvTECn+VFs440FdECb7zFjFIINz20OAm4Uu4WvJl4Cet+vrFwUB7U8fVhWTxEY0moUYWHAvs5K+gpP2giV8ruJ5jYTMLJtYpVBOPptRn4KNQposqedNbDm56vrZQ1pxSR+zBUn7phYX+bJG2V0nhhK3jc+XEsB5pQKYE9E49081WPwpUJFSiReisCLZiamfVYzivibV2eRg8fC0075YyeeeVs2hpM+bWhrmSGQBRY0mcAbTxqGDvtvhJWTG4Sj/m/LDsttTrJohWP1g+hECX9YSeGcOZ4y64GIuLqpC24HNO9PG2XxZ543NhYSjCFCwxrPLU4NQ0NCkYte4aNQSAw0RI1Jza8DnLE6f/RQpj75bvtFoGgHGxy3ojgYhXZma0CH0O6lH9in9g0MbjyZDVVjraTuprVSnqLwZ4R3ysOO7ccUFnHtttov/E4A0pVn1nfpHyyyLiWPK3QaVLWCpGcRcjRkVWlOtr7/xksd3D4sFa6vuqAVL+CcA3Vdni7vtFdVFNUVF/DzOG26N9y7ioarO4Vs9IPyB3TxPwUorfksQxcdedbAUQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0b75cf-4ba5-421d-7c39-08d84d82935d
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 07:50:48.9158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ByRxUAkJXPGWn+rNsYMezUxOT4KQfnV20cqjQrMME1tb2LNiOrPOwU7iReDDvcqswzw07Cfbi3e6JVGNTDP+Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5694
Sender: dmaengine-owner@vger.kernel.org
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
index 4f8d8f5..22be370 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -379,7 +379,6 @@ struct sdma_channel {
 	unsigned long			watermark_level;
 	u32				shp_addr, per_addr;
 	enum dma_status			status;
-	bool				context_loaded;
 	struct imx_dma_data		data;
 	struct work_struct		terminate_worker;
 };
@@ -986,9 +985,6 @@ static int sdma_load_context(struct sdma_channel *sdmac)
 	int ret;
 	unsigned long flags;
 
-	if (sdmac->context_loaded)
-		return 0;
-
 	if (sdmac->direction == DMA_DEV_TO_MEM)
 		load_address = sdmac->pc_from_device;
 	else if (sdmac->direction == DMA_DEV_TO_DEV)
@@ -1031,8 +1027,6 @@ static int sdma_load_context(struct sdma_channel *sdmac)
 
 	spin_unlock_irqrestore(&sdma->channel_0_lock, flags);
 
-	sdmac->context_loaded = true;
-
 	return ret;
 }
 
@@ -1071,7 +1065,6 @@ static void sdma_channel_terminate_work(struct work_struct *work)
 	vchan_get_all_descriptors(&sdmac->vc, &head);
 	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
 	vchan_dma_desc_free_list(&sdmac->vc, &head);
-	sdmac->context_loaded = false;
 }
 
 static int sdma_terminate_all(struct dma_chan *chan)
@@ -1339,7 +1332,6 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
 
 	sdmac->event_id0 = 0;
 	sdmac->event_id1 = 0;
-	sdmac->context_loaded = false;
 
 	sdma_set_channel_priority(sdmac, 0);
 
-- 
2.7.4

