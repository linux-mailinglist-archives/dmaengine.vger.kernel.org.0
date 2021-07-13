Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27C63C6E7A
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jul 2021 12:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbhGMK2u (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jul 2021 06:28:50 -0400
Received: from mail-eopbgr20051.outbound.protection.outlook.com ([40.107.2.51]:45636
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235671AbhGMK2u (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 13 Jul 2021 06:28:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFBpxIOsxuzGpsbDRROK6PK7wuLZa3M93rieZVpaX3UmBGgbg2Juuo0KY1S11dEKL829JDw9vn58aqapCQPW49gXc1LkW3KeDET6Y5Ra6mtjPOOmzReb9k37lSdFD9knVOq+tnMgfHkM9XTRVQ0te2eJgbXR63zpIGhhgtyDKCFJgV9ZLUt+OtqO7k8z58fy6/gYEPqHUDh0PuL4XFOlqUPBuPGkjZuOmHivbUYDoX41kwh7OIkcztIb7FBwNrlWtvq+Knz4XxgF9QNWcgCj5JCHN6UzoNZmyJ84BpacS7x/MgXToLezrcDnhf2vA4Phvjo8xh3LCGZW26hOiSKO7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tV8I4JjD3gMWnLgtLxtbyH9vZk1nNnZoDf9p2hXRPBw=;
 b=Bcr5XYY8u79ZQVKSXmA+EncCOyCGPQx6u73FO0asHpbZE3EuMdlf1Wlf6t1raS5rIi910eqE3iVu2uP7YLXxhAZ9YFl/FP8vFbW0zVjYxtzeaa7aAGLcOdIp135RSxHIR4Mp2dckAVDWXVbmzvHoz/C0NBqwIXIrHXZXliU5dhQgPeuJO8BSPlD6LJiLW/u8DUpCnoFd2o10AU/czMgWog41HJoj3SdKPylJL5ONHdh7tL5uqyDu8SNLDQImYQ7lBuyRUjC8/fqPzd/7iwIsTOo/+qF00ffYBscB7Muf/gKooP3QFIVX9YRXRvIg7Pu8AigBgT13RGc9ORpOFSIQcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tV8I4JjD3gMWnLgtLxtbyH9vZk1nNnZoDf9p2hXRPBw=;
 b=EL/XZqNrdJlggrJQsWg/IEy3jZG/ds2Wl6OefKzXL1DZwSfvjjOslImPcHl/ISexlpwgj2yEgpC5ePsrrViVgkQgUuNX60tVLYDjNDHLahuJ5MiAkyPTHFP44VTttEN1q8m2oz2WHxikKKHe+iEPRGUTjD/KHRotPAV2CJj/P9E=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR0401MB2288.eurprd04.prod.outlook.com (2603:10a6:800:28::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.25; Tue, 13 Jul
 2021 10:25:58 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076%5]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 10:25:58 +0000
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
Subject: [PATCH v15 05/12] dmaengine: dma: imx-sdma: add fw_loaded and is_ram_script
Date:   Wed, 14 Jul 2021 02:41:42 +0800
Message-Id: <1626201709-19643-6-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626201709-19643-1-git-send-email-yibin.gong@nxp.com>
References: <1626201709-19643-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0198.apcprd06.prod.outlook.com (2603:1096:4:1::30)
 To VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR06CA0198.apcprd06.prod.outlook.com (2603:1096:4:1::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 10:25:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e639e16b-ce30-4ae7-4bde-08d945e89aa3
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2288:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2288681D146621BFF5E094CC89149@VI1PR0401MB2288.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: djmkMflvliSP/Mz4eB9shgfsKjSJ/Wkn26GKN2Pr1cNiWxBe8xHQlbhkS4yhK3+O1OVuKyQsU8Vzf+53TG0w+G49SWoI3Kyjv8kpwoGdtdjj86CMIDwECYtngwaEOYdLxRAb8TmSd8HUZO8ypSny4kS9XMm6fa4VVWvOprwALkxshd0bKMy1f2YZLuIilt+oK9+b7AHO4lxKucrzwNIqxaSPL1LZQaIgiixOiNOVBieayaSCuUrQP3z0qmjp+pYIr3hNxswOriRB/xdzc6mJlYFuXyJ9sIqV/Fhyn+kok+GiZzlFizZEQlYCF+iRxr8F+4o8bLnFhk+xJemZ8VPu4c8bpdTDWuSr4mgJE2KTVbrWlD/U7WVht7gxYi8PdNVTAYLnnt9FnHAiZM54w9NALgnONJkGWQcUH2Swk9ud3XPZsjQZRd9De2yjAtZ6qWsewAyCRe4u3oBPVKaCdvbiskaS4tHcUGhj0CP0nV81IeqcQuXF5VfpvKfb2mwY+m/gAVBfsfB6FutKZRCGLDHULkR/+EkMASZPIjvZnMYvPzBjXFXDoyLsYwl4TqBpledwil7lJ3lyeRdfO7I1+eUYoMXpjDXzq1a3NqulphKv321t+/34QTQ6d4o4i4filf88D263T4fRqZLMrYv9jVtWlrEsrwZG/zgxhJQZpAL9UL7umrtIja8r+ZW8Bj66wylgEAbzYoAi0BIKJtQljpB9jPdDqaSF+Gxb2EnN+PbDTWQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(396003)(39840400004)(376002)(6666004)(6512007)(316002)(83380400001)(66476007)(38350700002)(52116002)(86362001)(6506007)(8936002)(5660300002)(921005)(8676002)(36756003)(66556008)(186003)(26005)(66946007)(38100700002)(2616005)(2906002)(6636002)(4326008)(478600001)(6486002)(7416002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7xOK2Sr6nz/XI0z2oGDeBvaKTwmkd/BjRpeXvR9EQ1nOwAf99BNtKC7We92+?=
 =?us-ascii?Q?JfzdkfdyheSjBAAVQy+943N6Treb0y4GOzvVjCKeJG/zGoyrRTme23yE0lbg?=
 =?us-ascii?Q?bDddCPokGzc8ricRzum1Pw793wwLk0wy/i0jz1X07l0rtXAJbCYHxa1wrwg4?=
 =?us-ascii?Q?I18WuC5ZuXYUskbAlXmmPHxR8fQE2qTFKJ/U5yDkbCPnrWU8T/ikS0Jxa1QO?=
 =?us-ascii?Q?wMca8/TJLlH791wP8L+BDX0gXJLg3P0fJMcB58PexQ3J9bnPBD+HdsBgzWtW?=
 =?us-ascii?Q?cmRNyvBeJzSQJXT8f1dbMr5SwHNJh9JCusKWfMGgWrJCuhwyzeW2roXvBGGj?=
 =?us-ascii?Q?RFX2nct0qhPMZeTnVfstt7EfCq2Clv1WLzL8PLqk9W7HggPJI4EiOFQuPd/B?=
 =?us-ascii?Q?Thy4OAYbRmorhSfvNnKnrjZqQChNnBE1d/UqM8bNTxFY+ZiIJSEc3bTB8TwK?=
 =?us-ascii?Q?+JeVU3XlYZFPApBbk0rce+C25394LApPjbYbsrqPwASjctGGK5mkAcJj0OkJ?=
 =?us-ascii?Q?z3d4hcnrVIA5H2hjSn8hymoTIfHdCTnLBKVNjRg10pvhn9NI+tsQvfDW19z4?=
 =?us-ascii?Q?qDb/FW9N+5+C1ol1G3lGyPOyMWk56qhYUbEdpNcZgsutIQHYvF4dzc/d5ed1?=
 =?us-ascii?Q?FrKnI7BkWtmubmMphDzoQXU9njFDZjc7rWVMxoW5YyFnD+R3fJSQS/VTc5VG?=
 =?us-ascii?Q?v2kvRNb+PJ46niMk4umXGHNGG3PFfdmDeQTCRq6+fLMuv7dEMjFaOwWw/M1V?=
 =?us-ascii?Q?g9sYtIuLxv1Y1CSxbZU5V0HtAch1Q3ICbyKiOqxhaeN3EovA9G2XjY8/EtYD?=
 =?us-ascii?Q?NXqz0fiGX93HveMK0Jf4SCeI+H89+0qUidOeKjm0GYhjRT19FE++iAMFU1FZ?=
 =?us-ascii?Q?m5c4scVbdyS5uccyTNfSkwkYKS8RWXKHTdk+E+BKMC3zAq7F8oB9glQAMwXM?=
 =?us-ascii?Q?dexFF0UQ6lwWUyBeyfpYxg8fjOWUlYzUyTh3DSlQEzxJk6qCMMeN2HvZ/eOx?=
 =?us-ascii?Q?44tYYSQc68ACbeWXZEKuzWsYuEvIz+rif7XPGhrTKQZ6kq3KfcP8DevRuvQk?=
 =?us-ascii?Q?Bl3Z/16FF4P8d9rDmxHaiyRJQz8WwZH5+k0tXldebHW/kPYLo0l32SifwJlH?=
 =?us-ascii?Q?l7p9IBjzpPMfnh9j4kbtJuhIgnOVqgfyUk1z2qtPuHkG4HQHXAHW5bJN7oSN?=
 =?us-ascii?Q?ClnNlfLHGPsMJ7ei1yeRRK/6L0+1FM4VvHp1SWCHHtNYwn3/r4J83PPJJRHf?=
 =?us-ascii?Q?b47Mi+LICLy9pSOTgylmRke3sbzXaIB1pFN744GuCyY3VxK1vM9ejokL7uQC?=
 =?us-ascii?Q?dKJLE1k56pTn6k8IHoCbwfq0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e639e16b-ce30-4ae7-4bde-08d945e89aa3
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 10:25:58.0507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2/L+WaCjJUAZQw/4v2NfELC79J8DpZoIlZkBrnjVS5kjko7ob4PqGMRxZGtJ02pD2kA22ScF3+tyUM/RlyUYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2288
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add 'fw_loaded' and 'is_ram_script' to check if the script used by channel
is ram script and it's loaded or not, so that could prevent meaningless
following malloc dma descriptor and bd allocate in sdma_transfer_init(),
otherwise memory may be consumed out potentially without free in case
that spi fallback into pio while dma transfer failed by sdma firmware not
ready(next ERR009165 patch depends on sdma RAM scripts/firmware).

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/imx-sdma.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 665ccbf..639a783 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -435,6 +435,7 @@ struct sdma_channel {
 	enum dma_status			status;
 	struct imx_dma_data		data;
 	struct work_struct		terminate_worker;
+	bool				is_ram_script;
 };
 
 #define IMX_DMA_SG_LOOP		BIT(0)
@@ -498,6 +499,7 @@ struct sdma_engine {
 	struct sdma_buffer_descriptor	*bd0;
 	/* clock ratio for AHB:SDMA core. 1:1 is 1, 2:1 is 0*/
 	bool				clk_ratio;
+	bool                            fw_loaded;
 };
 
 static int sdma_config_write(struct dma_chan *chan,
@@ -953,6 +955,7 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
 	case IMX_DMATYPE_SSI_DUAL:
 		per_2_emi = sdma->script_addrs->ssish_2_mcu_addr;
 		emi_2_per = sdma->script_addrs->mcu_2_ssish_addr;
+		sdmac->is_ram_script = true;
 		break;
 	case IMX_DMATYPE_SSI_SP:
 	case IMX_DMATYPE_MMC:
@@ -967,6 +970,7 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
 		per_2_emi = sdma->script_addrs->asrc_2_mcu_addr;
 		emi_2_per = sdma->script_addrs->asrc_2_mcu_addr;
 		per_2_per = sdma->script_addrs->per_2_per_addr;
+		sdmac->is_ram_script = true;
 		break;
 	case IMX_DMATYPE_ASRC_SP:
 		per_2_emi = sdma->script_addrs->shp_2_mcu_addr;
@@ -1363,6 +1367,11 @@ static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,
 {
 	struct sdma_desc *desc;
 
+	if (!sdmac->sdma->fw_loaded && sdmac->is_ram_script) {
+		dev_warn_once(sdmac->sdma->dev, "sdma firmware not ready!\n");
+		goto err_out;
+	}
+
 	desc = kzalloc((sizeof(*desc)), GFP_NOWAIT);
 	if (!desc)
 		goto err_out;
@@ -1613,6 +1622,8 @@ static int sdma_config_write(struct dma_chan *chan,
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
 
+	sdmac->is_ram_script = false;
+
 	if (direction == DMA_DEV_TO_MEM) {
 		sdmac->per_address = dmaengine_cfg->src_addr;
 		sdmac->watermark_level = dmaengine_cfg->src_maxburst *
@@ -1792,6 +1803,8 @@ static void sdma_load_firmware(const struct firmware *fw, void *context)
 
 	sdma_add_scripts(sdma, addr);
 
+	sdma->fw_loaded = true;
+
 	dev_info(sdma->dev, "loaded firmware %d.%d\n",
 			header->version_major,
 			header->version_minor);
-- 
2.7.4

