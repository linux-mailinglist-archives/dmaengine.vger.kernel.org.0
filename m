Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783463564F2
	for <lists+dmaengine@lfdr.de>; Wed,  7 Apr 2021 09:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346362AbhDGHQR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Apr 2021 03:16:17 -0400
Received: from mail-vi1eur05on2069.outbound.protection.outlook.com ([40.107.21.69]:41953
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237787AbhDGHQP (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 7 Apr 2021 03:16:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cl4u3Z/8QrKA9/RE7978pP4X2AaScxB3hFlOBba2tHJsnwQx3fN2cncWNuXOoL9zV6TxcWh0I5uvo9WQ/XE28qhB/KJbTE1Fo45R44SbfOHf/aaZeYcl4uuKdCbhxTV9TwWXlbRkdwQ2Pg8byqcwBC8anGijkC57MUqs2FD3MuQUH51p2NnnX9KX6sy/+w7518dyD8Zo2cjFdeKxj2VU4KFqZSfOaw7DTnQT9OcEp2PFSZxGp4N402Fq/bxZTz5/1wniNXm2QueyXfWRNPzLjZL3iu085ljdiRV4JZFL6tw3XpxpMaQ9bVOQodpdmv7cFNuX1CFGCZKBOIt0Fmv/FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIt5LKORsGd+tCRzDis7KbbsWHYFGr5ZTYZd82CoRi4=;
 b=lEvws2PBKLQC9bFOgAdJP1/kTc2mmWlqtVyr4qoRS1tnz4TuqO0eI4CKM0Ad+XLZaUDuyf8w6Mx8x/AdjLsxdWrkQiPYd/t0zSLozmSmTxbAH9hsHyJRk5OQbLmAnZrL8uQqT6haW0CPwcAVO1N1aZZCXHo1aCdn6bVvAKhSyLEiF9FjNnhgqwHLcayd/gbSXXaMF6A4ujiuJMLb7WIodntMf8+ceQJlqLq+CmkDpGd//rxFUbIWkolMb+QT6fWBgLgn/Kr75DeQMTFjONfDOYXNd4UWXOHKFkExP+FBaNFdprsFgpEEx92AmsiWBDCFTZRiuhlVCxXpZGDCfpMRxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIt5LKORsGd+tCRzDis7KbbsWHYFGr5ZTYZd82CoRi4=;
 b=mZz8lt6JWytxiBxpsQvhZebyblq+eWxdHna0VxAKfK1x8v9sowjUfc7J7WtrQx6wC0cH0/+b1qjPtmdSgJPpt3SL7NJNWxxFPmhvRUT5Uwgy3DlEERv0xRUVDPb9VGFPRX/7BkdWIIje6j35jVrJK/lDahK4oid7JBQV4KxFYZg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB7326.eurprd04.prod.outlook.com (2603:10a6:800:1b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Wed, 7 Apr
 2021 07:16:04 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::e8e2:7756:13bc:2cb3]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::e8e2:7756:13bc:2cb3%7]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 07:16:04 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        robh+dt@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, m.felsch@pengutronix.de,
        xiaoning.wang@nxp.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v14 05/12] dmaengine: dma: imx-sdma: add fw_loaded and is_ram_script
Date:   Wed,  7 Apr 2021 23:30:49 +0800
Message-Id: <1617809456-17693-6-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617809456-17693-1-git-send-email-yibin.gong@nxp.com>
References: <1617809456-17693-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::13) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by HK0PR01CA0049.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 07:15:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6cf7e3f-b1bd-4f5e-2c3b-08d8f99500e7
X-MS-TrafficTypeDiagnostic: VE1PR04MB7326:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB732665228713C972C075715689759@VE1PR04MB7326.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N1w1rTEykv2X22aCRhbOhxOVJr2k1aCWBWfiIJ3tF6uol8aUErIhHPo9J/auO6GZtwzEo96w6jh3Ek6+9uhr3/KLZoHisakDr/sCd4JbRs4H08nzYORD4n5u0G8dgkllbHg4npDUHQ0yRQ/TVx+Sp70ghqMW8JflwmX3fsWSVjlcFGUT2mnflzjyAukhlmathUFEqoCJ5A6bsVdEgi8yvjpvXiPoHZHGiYE7PvObyVHcnLqtnXsaPyy6uQRdQ/acru4F4tUK+wpj4507TUoLwIWK6qOX5hy9EKtq7O7MjnQqADnkF7hkYa+mUXifIEBRfon9UTPal5bvMXLLF43Deyf9iyjLjddOe62wyrAuLSDWKpKecSCOAKZD0EyDw5MXhmXg4TnpbxJGgEQ6MfCzZa+2HV2RIqC+g+1TCktB1xNvJkHRzXJ3KAN75Lp4T0HJ7UWZWonOmGCG06VxDywZQSD3tw4AW51w38+dalOT8KT4R7HuX/27+IGp7TVTgydH0MgUvjY6vk4Y+H4Hy3rShClhTzvDqy8sBQo+TY8AE+S9PeFfodWxt9uLunvzb3I0cfVG0YhmvJxN4Ka/VwAK0BJGan7aa7nlf0GjOnWh4Yqaf+i5aOYm+3L3O5Tjf0tSGQ1ZnsCe6AzbckDbRTUCfV/CxUZc/ua+POyCk3TWCqG1H1y33z8s03UwxmsGk8f2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(7416002)(83380400001)(2906002)(66476007)(5660300002)(66946007)(66556008)(6666004)(38350700001)(36756003)(6512007)(16526019)(186003)(2616005)(26005)(6486002)(6636002)(86362001)(921005)(478600001)(8676002)(38100700001)(316002)(4326008)(956004)(8936002)(6506007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?YJB9xtOKi/PlaZQpKQdJOCKd5SsbWIDFhY6kHI0aj70rTXHNKI+RBRssVb6V?=
 =?us-ascii?Q?l3bdVl4i5Bxn9BMcLp1fXyqDab/S7B8XeYMGA7GwHT3xdD+R7MdKnCDyrv/H?=
 =?us-ascii?Q?iz6tupImVt6zNsok+4g9oJBRnIwLuykabkV8vPhBu229/Nk5eaXb0pejorYq?=
 =?us-ascii?Q?hL+dKwgdzCBbqfEBoM5hm089HUgmou9jdKt7lwS+fI8x0/pP2OGKXCFRhhw5?=
 =?us-ascii?Q?rylUoiElr98iOhHtuICMv55rkfk6+NyfGbE2f0Gp3Vqui5EtghHXxZDMYt9w?=
 =?us-ascii?Q?4VR3f1uOUdqKBgyfBVNZRys3l+cgMr0azX4knEiIcy9hetGaqjIyOMo/1olc?=
 =?us-ascii?Q?JFBjM4wjfYH9j3+vZU5y9dX4R7/mbl8EOYysIGMf3DyuNPBfL3pZkoeu2NsO?=
 =?us-ascii?Q?wmQsoU21oDnWdFng+JIutUXvv0k7T3g9u+K+mJjno+TirtHwR5qGN+GxpIie?=
 =?us-ascii?Q?TTmtPP9ZDsXFr2kozVDWBV8hRn3Gam4vNDPi5gsJSswnEoc7xiX4h+8N9HVt?=
 =?us-ascii?Q?IH4gF17Tf1bEpD42r0/nFiaDJwXye3zOk4rcdBlLZttD1ZmR/FHoh9oS1yO0?=
 =?us-ascii?Q?Lm3b//i8RuGu5jUbFcZyGLUv2MaY9JPHfnYB26chymV559vDqJ9x+jV7ejQP?=
 =?us-ascii?Q?IIiSuPgMc/6vJOXQJOP94yKsHZqgctZ9qihLmklaxKnwwmY7x3Sxy987/Vxg?=
 =?us-ascii?Q?EFOrn+Cybfcc9vQbJKYTPGULx16EVMRQtkknEY7sDM6Jn55TYUcOKX43mvO2?=
 =?us-ascii?Q?NpvKc3EGtWLTT2TlxIC4lpesHUVlHHpvnUnwUyvfq7a/2HxC8qUfce/91TE+?=
 =?us-ascii?Q?rCdxRwnWE4LJj+YsvlPURj9SqNjtzsDA6XooQct2qkrQClKvZJkf1Yt3mH6k?=
 =?us-ascii?Q?wcY0GYm42fvxaia0pm0fTArydEt+YEylS2ENgvhikjyyLiImtxYstmevF7ku?=
 =?us-ascii?Q?vmkDWYOh7WUu6BvTzCLiyzFhUQiX+2BwoKPogGky55be8wRYG6yI4OCa4W1A?=
 =?us-ascii?Q?SfV2RnkFrpss5KG8i5QWO09Vsk4IfZG3cBWi6oPexJ4DfcfIai5QBMXMyO9M?=
 =?us-ascii?Q?Ic+YkxdhqWchA3WLQAIuidf/pp2Pg70AmstoDB7ABPRb4McAjPzkGJMbzhb2?=
 =?us-ascii?Q?fZkGtqeZaYXH6xCnfSCE+WnAT0CGaZPf5FhBA5rIUnv7NMJCVZWkgHNpuN8s?=
 =?us-ascii?Q?vlamXE14V3KvrnIloAlIIibdMOj8JH5MDh9mOjaNwJUVLYTSUhDWUK2OowBm?=
 =?us-ascii?Q?y8FsBYyt7B+Y3QU8JHwuQ6Khzh6UTUivU+aBIrHAGIyQKxvqoxXzAGyMtH2r?=
 =?us-ascii?Q?WFSS44mYfplw/DQgeBDVAZ8R?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6cf7e3f-b1bd-4f5e-2c3b-08d8f99500e7
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 07:16:04.0394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8XQHuVWGPkUGtgoGB2A0My5oeWbkOfSPT5U6d7yuIEJHDPdeEVRAi2LdHTqHZlecf8oNZtdWPGW7Nu9xODIXxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7326
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
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/imx-sdma.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 1c636d2..78dcfe2 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -381,6 +381,7 @@ struct sdma_channel {
 	enum dma_status			status;
 	struct imx_dma_data		data;
 	struct work_struct		terminate_worker;
+	bool				is_ram_script;
 };
 
 #define IMX_DMA_SG_LOOP		BIT(0)
@@ -444,6 +445,7 @@ struct sdma_engine {
 	struct sdma_buffer_descriptor	*bd0;
 	/* clock ratio for AHB:SDMA core. 1:1 is 1, 2:1 is 0*/
 	bool				clk_ratio;
+	bool                            fw_loaded;
 };
 
 static int sdma_config_write(struct dma_chan *chan,
@@ -899,6 +901,7 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
 	case IMX_DMATYPE_SSI_DUAL:
 		per_2_emi = sdma->script_addrs->ssish_2_mcu_addr;
 		emi_2_per = sdma->script_addrs->mcu_2_ssish_addr;
+		sdmac->is_ram_script = true;
 		break;
 	case IMX_DMATYPE_SSI_SP:
 	case IMX_DMATYPE_MMC:
@@ -913,6 +916,7 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
 		per_2_emi = sdma->script_addrs->asrc_2_mcu_addr;
 		emi_2_per = sdma->script_addrs->asrc_2_mcu_addr;
 		per_2_per = sdma->script_addrs->per_2_per_addr;
+		sdmac->is_ram_script = true;
 		break;
 	case IMX_DMATYPE_ASRC_SP:
 		per_2_emi = sdma->script_addrs->shp_2_mcu_addr;
@@ -1309,6 +1313,11 @@ static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,
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
@@ -1559,6 +1568,8 @@ static int sdma_config_write(struct dma_chan *chan,
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
 
+	sdmac->is_ram_script = false;
+
 	if (direction == DMA_DEV_TO_MEM) {
 		sdmac->per_address = dmaengine_cfg->src_addr;
 		sdmac->watermark_level = dmaengine_cfg->src_maxburst *
@@ -1738,6 +1749,8 @@ static void sdma_load_firmware(const struct firmware *fw, void *context)
 
 	sdma_add_scripts(sdma, addr);
 
+	sdma->fw_loaded = true;
+
 	dev_info(sdma->dev, "loaded firmware %d.%d\n",
 			header->version_major,
 			header->version_minor);
-- 
2.7.4

