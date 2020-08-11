Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2352241759
	for <lists+dmaengine@lfdr.de>; Tue, 11 Aug 2020 09:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgHKHkY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Aug 2020 03:40:24 -0400
Received: from mail-eopbgr00042.outbound.protection.outlook.com ([40.107.0.42]:37583
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728275AbgHKHkY (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 11 Aug 2020 03:40:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xbrqi/b1T+Do0OC5tvrLdX7ha2UNOKC74V6jC215ay+z0JMGNuNEJulxjuuDO1aXtPNGdF9pyzucvDHZuVEd8X1Qgt3k4fpJE3bcSEji4CrK2mfWZzRhrM7LFtdviFlKMQNVVH7yBAY4XeY73/hHe5wsv3AwmoaL4JSVaW9XIJV+P0Q4T2/oiAByZs3eqfD1Xx0bMyJArBgLc7EACLCZrpRizcOYx6W8osXe75VmHQuL9HPCeaeshBBlemgd2ScU/xH7FCD7tkiUgwmwXk9vJ0Ds3+C6kJvRdhIuqtGL6oA/GqvZu9hz0U86nczZnsDpHueW9N6R/gG+HG+FuQ8R1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYO4eeCkCaKtyLBE/p41QWBbs0n+/LC0JXhKC1GhFac=;
 b=lC/ok5XlP229BX6SObOHwxA5qZzRVijmUIA+0nZ907BYIAEs9cLaiMOW4PGeUVoMe3Yya8f4LtvXvdbUSSjVMtMl2kim0gSy4K7j6Rc4UL8WdH2/Yr6/PS8fStxCDUrL2ubE3rPjVV0O60XtcJqgG/Ea0FHDGmAPk0xEGAdDlQCIkOLyw2wUaukQ8nJsN7+7YHgq19PpfmbKQtUwwph63s7SEKX9599LkD6rxxG4NVFMJOnhLDC7qBKb3y3ZctwvxnaRHZUaHckpalXA1qhLiQn3H6hKLdDk96yA+RW+J1kH3YSWshXaRlTwgNMsZdIERbUh6Rx0HJ2s87L6g44ncQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYO4eeCkCaKtyLBE/p41QWBbs0n+/LC0JXhKC1GhFac=;
 b=QZg+Pdp8xM61fpJJ+U7IpGUJqRmP8xDt5+vOgpmVBdtMRR+xQU3b0wp4taFcLFEBZCULb7OEwTwShdTt2qkMW5KRifAMfrfr97/0ZG/GCi6ydXLY2MvMRVrQ9t+qC/gfW9K6S9EQC37ZyWupTq51XDeuWPg5/trGoJIlKHhF7QQ=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33)
 by AM6PR0402MB3464.eurprd04.prod.outlook.com (2603:10a6:209:12::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Tue, 11 Aug
 2020 07:40:18 +0000
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::c9b8:4020:7705:e3dd]) by AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::c9b8:4020:7705:e3dd%7]) with mapi id 15.20.3261.025; Tue, 11 Aug 2020
 07:40:18 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, r.schwebel@pengutronix.de
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v12 05/12] dmaengine: dma: imx-sdma: add fw_loaded and is_ram_script
Date:   Tue, 11 Aug 2020 23:53:44 +0800
Message-Id: <1597161231-32303-6-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597161231-32303-1-git-send-email-yibin.gong@nxp.com>
References: <1597161231-32303-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) To
 AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3305.2 via Frontend Transport; Tue, 11 Aug 2020 07:40:11 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 65d42803-d3e1-4039-3436-08d83dc9cade
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3464:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR0402MB346448C906BA651C87681B6A89450@AM6PR0402MB3464.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2AMXFGkgM6Hrrynfilg+XSbAA8QClWNdD/QPxPM4J5NWFx0humpwE8vNvrQn4+7sxsEfFzemVIO43k8IhFXJ2/4kpxRJCWi73XMVYTXvOmLvW4sKNR42ATUADn2Ul66j5L8o00IMDaWaFCns9Gg15xga2kxa4/4fkXDxTE8tirFkjOMclRG1kTW4WHogFEl9RuWyeCHvMgIGZT/RhvXUs76Net7qr0iWIGgjO76JGGEtXG9zI33AD2ercCfRWDZznuU5LwMVDygkpUG0YD62kH11GfEFZgF4dqQh5ZLL/CLVV2hlfknLX+H+WkeoQ5jCA7i+TJlkx/0Tg8TWYxD477iuIdbVNFWcdlljtlrrvlZN6ke/bGzN1E/HsielkAU2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(4326008)(5660300002)(52116002)(66476007)(66556008)(86362001)(956004)(66946007)(6486002)(2616005)(7416002)(316002)(36756003)(186003)(2906002)(8676002)(6506007)(6666004)(6512007)(8936002)(26005)(478600001)(83380400001)(16526019)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: mP+9ROooT7Br+dn6AEhLs3eKoPVnj9dxgU9AoWuxjGWzi+cOnUiu2YEOeM+aRXe9zLkCDhFGedpXQwrXTpcADycNOAFzivVnAuFGV1WUMKDzdRk53KpWiK/RZ6o6+t5wRYJH5Fhv1sBmyYDjGPLFlun9tvenCqXi9aCJz0gUioP8aI4hC3TmrkAiKcM8Ma5p2SvFBRwn9CpIsf/iKTPK1Ajl6eCImD9kxWF8AgZCX2+0pH4kVxWHO7vhxmgkIguHH0D24w9+UbUsMgR7Fcbp+3urbGSmS30xr6t2gUWCANGVv/3STnl3BeMiLXF4Z5HpTgNkjfMdM+5zu1ooXKoAf9kElap5IB/SLEcF60A4HkrFBfMEQM0oJbvSAsnHy4ZzI6j8IEJk8UTOUwmM9jJk7WV+ehE2SmWWw/fwAg7umQ1nUr78vK307tn5YM1QA9xVrY83sBd2ppOyu8w81mmMDOBYCsZrjkJEEKP/GfBHZo2d8xq9GmiEhSMx1Vps0zH76mScmKD1/a3OSLU0EXLwj4jYiuKshARHEtgaAnG9FkCLrWLTPwN738onCXmewbbNKN/4ZaGQidLY3dc4m25YavYeRGovNtYpM+j4Oqa0vwNNYAv2+H0PKddWicrknaWbUtsBzMBNb5KAAkeuoQAqbg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d42803-d3e1-4039-3436-08d83dc9cade
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 07:40:17.9283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MkEJgc++KmHgJ7sG7uNtAkqVOksw2PxSnbZtawPGtmQ77EnWmdVY8RKNSoMZUaBF3vP/UOCDeUWMFpg5+Dnl4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3464
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

