Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01FE620ED67
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2020 07:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbgF3FZA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Jun 2020 01:25:00 -0400
Received: from mail-am6eur05on2049.outbound.protection.outlook.com ([40.107.22.49]:6067
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729538AbgF3FY7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 30 Jun 2020 01:24:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IC8Lqz1W9RB++eD8fci7n32F7DKAljnGQu1zSt8//RmqFIrbKNIm2an5VqNBbeiNwC48VOG2RHihcKpQTVvPgvL9MQPlU9KebE4ejdNIm9Oc49nZXTDCHGrgP+YWa3UGbaNG9N0Q3h2hNLHsCutsvBT1PMazXOqtpJ/7bpHASfkWNBMuBQb6x3gKj0WAMFXFDCkA9q0snu+4IOieeLGhW7MFXi1TMuwfOtmXdpK5j58qCO+YUn0u95aPv6XPY9euNxIX4Q8NtoYsPz/pTAiDF4IzBIxmP9bLbSWDXlOCp/NUiOL9sbHhB7P+IHdqD5P2BFBM/X24UVx4rrDJ8Bv2kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MStpk4EPJXtNTPeV6Oa7h4ua/aLJgdJ4RdpWjegnnjs=;
 b=dfPZLD9uPe91EgQGuJ9DHnhn1JJ5X2kIjLAm0rF3C15HYfR+TJyqrveXyT0BL//7y2k2D8NfQfh73NcWKKRgf4XHDZRSXXGyayecujLJz5K43L1RtMjR7U4tl3gpLfmSrvWGlhURreVP+Aw1VG+r0UrX/n9pay3ivsy1SRSNi7w2YPH3OEFFF86xPb8ayaYCGeUxLwozbJy0jwl6hfx7dxa7JpTFQPpfMm09zJmxp+uG7RxhtMjSDJmrFgAilVodqbymM97DLAf766BiRl9MiqtaulLcHSapkDrQRxz78Lqbu0CTZGL1F6CvrzfDzYjSqTefMmTxcOaQV3JZAGQP2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MStpk4EPJXtNTPeV6Oa7h4ua/aLJgdJ4RdpWjegnnjs=;
 b=mK9/EDFqroe+PbUzFkAkPNxPXiKjUhYq5OKkLkx5CT4WN36/EAitKaKrB4e9ytOsANaptYdcMUdax3p7fuwmgGr11HmCw0sHYnDIMlfqrdbqYSLj7c+jhztRIcT9l+tSXQQy6bu0i3fb1gYmaQGlLdxArJ3K9fKmpVcbzoUoeD0=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6640.eurprd04.prod.outlook.com (2603:10a6:803:122::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Tue, 30 Jun
 2020 05:24:55 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3131.028; Tue, 30 Jun 2020
 05:24:55 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v10 05/12] dmaengine: dma: imx-sdma: add fw_loaded and is_ram_script
Date:   Tue, 30 Jun 2020 21:31:09 +0800
Message-Id: <1593523876-22387-6-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593523876-22387-1-git-send-email-yibin.gong@nxp.com>
References: <1593523876-22387-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0132.apcprd06.prod.outlook.com
 (2603:1096:1:1d::34) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR06CA0132.apcprd06.prod.outlook.com (2603:1096:1:1d::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3131.21 via Frontend Transport; Tue, 30 Jun 2020 05:24:49 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c5afe2f0-209b-4fb3-3f31-08d81cb5ec0f
X-MS-TrafficTypeDiagnostic: VE1PR04MB6640:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB664040CA914501002479FE17896F0@VE1PR04MB6640.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0450A714CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SpTuIJK2kzPpHVn/EX48qMH5vFsxzgv7ZoSyQsT5usNnwxQWs6RYour1YAF6zcSvml5Hg883ea/UswJnne6dLPk1LfP9uUlGFariLIKSSO2FroF3zQ8Vc5oFLVmeAQNuzC/R61/qw9rTCILfkhJq5peoJ8t2EDKfRp3zBZvCTMy8/gfnTc8Kw3BiIMyBda+dPFbYRyznbjdsmukq99vb/RoyBuIxEkwgYesWqeDhSYDs5uKaORLLOZQzvhDuk8me8jSam7he0eNsYNC5J7ZHzg/K1CbYiPHryJ0DgMYuxFYz03uhml9eU7Rf4cq/6dMqClrph82C5xmFEi8DHpKxWf+tA+nJAthXKoD+9ME8/oRQ4IFC3oDt2MGeaZS0i4FZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(86362001)(956004)(6666004)(2616005)(52116002)(7416002)(4326008)(6506007)(6486002)(2906002)(5660300002)(186003)(26005)(36756003)(16526019)(8676002)(478600001)(316002)(83380400001)(66946007)(66476007)(6512007)(8936002)(66556008)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: MHzUkd5E5I5opHL0tS7/LkPeE9qpIn5z1Y3fHBDpzLaYwTYvJ6t0IqHnWW7zTPrJsHVz/HSv/aJf+prz9g3nNCAOp3NRFOVeUBZEdkArr4sq6Gvk2A0LrBvEAtlQwsFjuy7+MMBCFsREfVyn5XApQCe2VkA9kFiZmcWM6GnwfFYJzL2tjh22D2mhzLAsyzPiZ25P4LIPU6KTSlhVbF4RsBTmy3b+J8iIl7OwXmPWALSJG+26Mya8CPdzFsWsSKaU6U3yKIpaiBAaPOac3EwF2+bSB+/tiQiSlSxlo0YAe0ddCoDdAMz57I2ixr1RN3HUR4Chydq2oQteFyTODxw6feKwylFMzYUluKwvkMo9WV/mZGXq42umytpnaLMUM/T/OUo70RWC38ibw0Spn+I4zmvr5UdHtDpv25HGVql3+VvbelepwO73L4EHvn00ryEEvXdxJidSM5H3QZyvU3XaX/lVuLqcMSyTlFYVEBL/R/g=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5afe2f0-209b-4fb3-3f31-08d81cb5ec0f
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2020 05:24:55.1573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EIV6TWgmqA3XZHpLSt5PZ6Rv0SuWkQwUBzEAoHVbVVuh89DFS1BaTmZucU+zw5n7xRJ6jxNV9/lD1rVqGPMgaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6640
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
---
 drivers/dma/imx-sdma.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 5411e01e..ce1c83e 100644
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
+		dev_err(sdmac->sdma->dev, "sdma firmware not ready!\n");
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

