Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60AC822C34A
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jul 2020 12:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgGXKhn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Jul 2020 06:37:43 -0400
Received: from mail-eopbgr80089.outbound.protection.outlook.com ([40.107.8.89]:22003
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726329AbgGXKhm (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 24 Jul 2020 06:37:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EubkunOEWE/bEcYf6z5Y0mP9XpV4Kip23MAyMnwlp597h4I3c6ZPmdeHZCsQYdef975gREwZexZZ0S/7ar/z2vbeoNcQ9tNk9x2YQB15sRRabaCrGeynu+O9EZtreRPqPaRF2g3LaMz5hFLzwlZLLzLdmi2h3btfB5J1Um4Igbec/5d3c+nFGEJb6GDGB3s/XsMkC7hKWpeOhf1TH7vJu7GeXjOheNaohLTi/Sf6XBkiRbntWD7IZCGctSS8FwT3m0U8IvvM0jnJ3WyBku0wqtnQLSorPs5zar4nLdz8/YPsuwi+lJK0UzeyzgAaLKBml49zCyh7DkHOVKASD5Ivgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYO4eeCkCaKtyLBE/p41QWBbs0n+/LC0JXhKC1GhFac=;
 b=j7kLvO6IIFDD4SWodQHhw0zIuGh99iHpcI9E1VeU6rGJ1claqaQjWGCBkanG4/iOr/6WtS0N4pzm9ImH2xKLYYNctjwYn4/c0P7f62/a8qedE605GzuMKhUuFmaoibbXKjg9XjdDW1Av9LY2km0HSocVZFDlPqxz2/TURupOpEtMjKkP+hOQq4q9U62fOtV94hDP75W6YiPX/PBoqOjx33M2sbDkO1VjahR6qlDaqXaPf+2KDYEzRqY4GdRNJ3Y+chqq4w68oIPnNvuKj25fGhQxFWRWqKAqiChqfxUvtqDJWyS0Q/vnbLyn/uRKVktpgGTkwcTZYdgaPdEIKp0hBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYO4eeCkCaKtyLBE/p41QWBbs0n+/LC0JXhKC1GhFac=;
 b=nRxpNm0TlML03Jphmr3grtMKLH62iW1qrsLmxfPeVnUtuzuxum2Yr50ix1bxqydZHju5Gb/cpb4ZJxBQ8DFG1Cu8eXFd25veCPrqm9kspwOASZKMMYP7QbeujYX9LwCJo/cOagv8tLDQlh8D4sEUpm74Jp3bHik9VbWW/xcX2k4=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR0402MB3710.eurprd04.prod.outlook.com (2603:10a6:803:25::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 10:37:39 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3195.028; Fri, 24 Jul 2020
 10:37:38 +0000
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
Subject: [PATCH v11 05/12] dmaengine: dma: imx-sdma: add fw_loaded and is_ram_script
Date:   Sat, 25 Jul 2020 02:51:18 +0800
Message-Id: <1595616685-9987-6-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595616685-9987-1-git-send-email-yibin.gong@nxp.com>
References: <1595616685-9987-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:3:18::34) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR02CA0046.apcprd02.prod.outlook.com (2603:1096:3:18::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3216.20 via Frontend Transport; Fri, 24 Jul 2020 10:37:33 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 73733833-2d20-4ab8-2697-08d82fbd9605
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3710:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB37104E6310A12044065CB45989770@VI1PR0402MB3710.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8A/lFDoBWuGKQ3wV2ksLWXqIok4dZjHyp4Hwm+NyjUV/5Hanmxxd0E2iHLSVrhvk55i2YpZ2bYcbO9YBqbGCYr/BxNlEJvS6SxDvGeuEEH/peiiuc0NlTykfVV/a7fA6geEYlwjCJRYtczG4T6J687EUwETApu/c4a2fgxZO1nGtgvM4Pud7TwX7jPSDK15OQZS9zg7XN5q5Jfg0FL+XpGsvyyX/Ncf4PCaNyj27iqLYIwYxTaUK9TALZ/XRRoNmNAh7C3iAkW0Ih9VzasV+FFaedx6Kc2rKxr5RbXn0qk6tFANY1woWgexmfpeet3EiM4fknvdZoyvNH/hq1kyFJWo3hrBxAnlZRJtSgpaVe1TjTWKV66iFWOulcLznysqf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(16526019)(186003)(66476007)(2906002)(8936002)(83380400001)(66556008)(478600001)(5660300002)(7416002)(52116002)(6512007)(36756003)(316002)(2616005)(6486002)(8676002)(26005)(6666004)(86362001)(4326008)(66946007)(956004)(6506007)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: s4bqsUWyLXAGezzC/IwZtWed1RRnDE62xqJbbZ4MVDUzA5G/AT3uOd5UIkII97Xl1mZJ3zvdHsd2gM7hvWT4EQNYM1piZ36rs9DM5YBKindwVS1jyOvjZl1wRaQeiMXrRIGyWRyxe74YcRWUrRpsfBK7wutNvu+Do8/YbJhmiVYOSlgcY2hgxR1JjdMa4xJ8bU6edXp2+LVGgz6cgUGQBrF+Z7Yf6WRIuSCalHbJgSJVn6yl+8LgEdvzwe4D/+gCUSeuKvz8lGGfxiGu3HfH7dO9T/3AgiD1cE3xndwyvAzQYVhikYGrx3nofCnPHTPX3EsX4EVWAkNyVTah3VBGoe/98sgiIYmSjfZ9oaam0s+tnD7EZ22f44hkX77OUfptYe/9neVg4LC9BB3iS3FKKJwgYb95UWmDiJz/roOskgYpZlLxFiy790AwrOgbanTz5DtTOhu5PVu4pAu/PAGV+muGZEUR6l+hFdpVPgVYEAM=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73733833-2d20-4ab8-2697-08d82fbd9605
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 10:37:38.7927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Kh3zlLoev6yJpVZsXxGvNbdQq1Jr95yNsO7Om4Mj2TGbUyFJHZKoQxOz0fBHCMxkBL8JV+OGKJbHCaSp8HVTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3710
Sender: dmaengine-owner@vger.kernel.org
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
Acked-By: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/imx-sdma.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 5411e01e..cf02c3e 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -379,6 +379,7 @@ struct sdma_channel {
 	enum dma_status			status;
 	struct imx_dma_data		data;
 	struct work_struct		terminate_worker;
+	bool				is_ram_script;
 };
 
 #define IMX_DMA_SG_LOOP		BIT(0)
@@ -443,6 +444,7 @@ struct sdma_engine {
 	struct sdma_buffer_descriptor	*bd0;
 	/* clock ratio for AHB:SDMA core. 1:1 is 1, 2:1 is 0*/
 	bool				clk_ratio;
+	bool                            fw_loaded;
 };
 
 static int sdma_config_write(struct dma_chan *chan,
@@ -929,6 +931,7 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
 	case IMX_DMATYPE_SSI_DUAL:
 		per_2_emi = sdma->script_addrs->ssish_2_mcu_addr;
 		emi_2_per = sdma->script_addrs->mcu_2_ssish_addr;
+		sdmac->is_ram_script = true;
 		break;
 	case IMX_DMATYPE_SSI_SP:
 	case IMX_DMATYPE_MMC:
@@ -943,6 +946,7 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
 		per_2_emi = sdma->script_addrs->asrc_2_mcu_addr;
 		emi_2_per = sdma->script_addrs->asrc_2_mcu_addr;
 		per_2_per = sdma->script_addrs->per_2_per_addr;
+		sdmac->is_ram_script = true;
 		break;
 	case IMX_DMATYPE_ASRC_SP:
 		per_2_emi = sdma->script_addrs->shp_2_mcu_addr;
@@ -1339,6 +1343,11 @@ static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,
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
@@ -1589,6 +1598,8 @@ static int sdma_config_write(struct dma_chan *chan,
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
 
+	sdmac->is_ram_script = false;
+
 	if (direction == DMA_DEV_TO_MEM) {
 		sdmac->per_address = dmaengine_cfg->src_addr;
 		sdmac->watermark_level = dmaengine_cfg->src_maxburst *
@@ -1768,6 +1779,8 @@ static void sdma_load_firmware(const struct firmware *fw, void *context)
 
 	sdma_add_scripts(sdma, addr);
 
+	sdma->fw_loaded = true;
+
 	dev_info(sdma->dev, "loaded firmware %d.%d\n",
 			header->version_major,
 			header->version_minor);
-- 
2.7.4

