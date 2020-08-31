Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6372574B0
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 09:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgHaHvX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 03:51:23 -0400
Received: from mail-eopbgr140050.outbound.protection.outlook.com ([40.107.14.50]:27033
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725978AbgHaHvK (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 31 Aug 2020 03:51:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3SiIXo+fwazgpKaGvtKgqtABldyxp8WyG6b9hJ+qHKQHrjl0eRXPk+bTHzD+70qm1N5zU5j3JU6pXcK7MNSicj3nBhjP8unqk84YA1glTfaNkhzgA7kwpX/723OQAfHcWhzXvJ0JvQBodirXq5cQXJSB5nS/g87yRI7aiumKdndXuSU0+2izPWixfl21WwUqFNyhy/Z3YhpqLPqjKdKT+fpK7DiK0d6HfUeg9VL36VFxWQ0a0jqXV/sO3HmM57llATVbqN7fdtmepmzsO16MXqE8pHN/hFfuSHqD2PfcgDEXcLK3P/Rcmr82clAFMi/tMwz2Ia+8a1DX6+GO5JZEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keMsKGCzWbdCUSMdxBfrZoptcRTNH3hg7+HVrE2VXts=;
 b=JLMk3Xq3UXqmqjto2+/U/875QKRO6SiuNg/RU8U1Z1+miXC8IVWXTyp168FMKKKgER8Th1aD7LNZGTlLn5Qu6d62bRShoO+4QiCxvYbvtLcrWMZPJox/Lm76mllIfpI/3K8y+NTdZP4Y8i901ygD9SJtQJN3PCXbA1W4dBixBpWrGrTkbgCHYV5u1PKeSCI8XeZzri2VNBj3Wx0BtvMZZohEGKjq3KdejgDgwWUZqLPpTzg6oD7UBihIwLaQimIACcJiImA60tfG5qqIFHlFxLk3jZZfUje2NH/EGlstQwcC0UL6WaPn62toLhShR1s9ITCLqsowL4ktfu7Vsy5ILw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keMsKGCzWbdCUSMdxBfrZoptcRTNH3hg7+HVrE2VXts=;
 b=nE7fYMVlmQbXMwC+raskc39O94p+vjMLMJbKyGw7imSEE3CiSgFaypg77lB4+0g2l7MUity2ZeW+4/LGfRDgsB3Lvqn7pBfNvVsEkNkQNjNcaSL5XQtsAmMXSoqW3lBE5NlLiWN2S8o3xGLZ/ZVtYicLtDHl2FskUwocPcByTvA=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR04MB5694.eurprd04.prod.outlook.com (2603:10a6:803:e0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Mon, 31 Aug
 2020 07:51:03 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950%3]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 07:51:03 +0000
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
Subject: [PATCH v13 05/12] dmaengine: dma: imx-sdma: add fw_loaded and is_ram_script
Date:   Tue,  1 Sep 2020 00:03:18 +0800
Message-Id: <1598889805-30399-6-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598889805-30399-1-git-send-email-yibin.gong@nxp.com>
References: <1598889805-30399-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0104.apcprd02.prod.outlook.com
 (2603:1096:4:92::20) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR02CA0104.apcprd02.prod.outlook.com (2603:1096:4:92::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3326.20 via Frontend Transport; Mon, 31 Aug 2020 07:50:56 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a14b2e1d-6209-4049-cad6-08d84d829bbb
X-MS-TrafficTypeDiagnostic: VI1PR04MB5694:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB56943E4C247612E61D1C646089510@VI1PR04MB5694.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sc3Yx2QyA63LqFHUjkcMaPOeLnL+nYFjMtBpt29+MYEON+rU2wVm6b5emTcxn1YRrB7v48D8h9h4q6IRN8C/fltO53WOohs52DhQsZyIWz29ffUuIaIrN1JFsAEMXYvFyorPvm0zVpcW/RVI7vIGQtkxx0gLTmQF4AC6+RkYtYupL72gZIOmNkiLdkLhL12P8NlBMQjmAwTKx6KPOwZVTCFZ4OOzAf2iiWZjVINbksbm+RSPbWhgJO1P4jdCSuKXIyA1vOCDPVI2Rz3ecEXAzuimpD/RDZqnbqmHrUpWi8ftsuNk1puxuMsnGRNimgdI92aad6fNtkEx7enbdFNUja+G+q71t6BPrrCZHpbbFVAF82A5u8R3iVX1/lKJTWaU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(8676002)(2616005)(2906002)(36756003)(8936002)(86362001)(5660300002)(956004)(316002)(26005)(6506007)(478600001)(6666004)(83380400001)(6486002)(7416002)(66476007)(66946007)(66556008)(4326008)(186003)(16526019)(6512007)(52116002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: XCYeZ/w7RxmGW42aMpn6JuUhFj0kqyyTgBGug8t8D4uGuaZubPGyBOQpRX0OHAADhVouGzF8W3oBqvVjPZnT0k8ryS1WCFEnJaQ+7kZML3zSUewBs7Zr0KCv7LxeQnbAtbemg3ZuRjJHl5EewASpd8zC8+qWTkQhac7rpnBSj+ipySOwOmviCu10OIGUX+aGOn9aMIOFsAQ6K5ywUJaqSAgGZMHofYXZZkD8jXu1/Q2JC+I52y3ZLAhxbzEpWBt78ZKFB2rsPDl/3vz/0H41JBm1KOLhHuarSvZHmwADZjO+uXdpk+pvqKp+zgcnYgU9sSHfzsNSFt4xZoUCalrNEcf/kF19NdaWi7sXIaghf/95Z/W01gAb5STRugKnQZHMbebAUZD+7M44i7SfGK2J1K2gK3YC5a6NDYr5rM4KA6O+/hC3uGi5fYu/jLafOpDNAf2jIkdkVCwcp9YjpJHyn6/jkkh9Wv+blunr+GbxGbnEE763q1IBjS1wohq8hSUP7Jcmq3E8a4bkW6oyUn0YgIuH03UDSFitELi94wfiRwx8wEm+YAkvEFpN/1jbgvCnd3Zue6TiGTiL/Shz8PQd93scHcA3fF4nmCrOns2DxgkT2YNfsTN2q0hHn0stnZZaGH5nk44tzWz7fBkaYj8urw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a14b2e1d-6209-4049-cad6-08d84d829bbb
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 07:51:02.9376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+aC/+841EYb/VIo++1RRGVZ7xhvs2U2OQ1ypaMYNWdkfkQIlezn+ov1LJhMdSvypXjPujDA+RFwbDecIsJTWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5694
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
index f899083..10214bb 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -381,6 +381,7 @@ struct sdma_channel {
 	enum dma_status			status;
 	struct imx_dma_data		data;
 	struct work_struct		terminate_worker;
+	bool				is_ram_script;
 };
 
 #define IMX_DMA_SG_LOOP		BIT(0)
@@ -445,6 +446,7 @@ struct sdma_engine {
 	struct sdma_buffer_descriptor	*bd0;
 	/* clock ratio for AHB:SDMA core. 1:1 is 1, 2:1 is 0*/
 	bool				clk_ratio;
+	bool                            fw_loaded;
 };
 
 static int sdma_config_write(struct dma_chan *chan,
@@ -931,6 +933,7 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
 	case IMX_DMATYPE_SSI_DUAL:
 		per_2_emi = sdma->script_addrs->ssish_2_mcu_addr;
 		emi_2_per = sdma->script_addrs->mcu_2_ssish_addr;
+		sdmac->is_ram_script = true;
 		break;
 	case IMX_DMATYPE_SSI_SP:
 	case IMX_DMATYPE_MMC:
@@ -945,6 +948,7 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
 		per_2_emi = sdma->script_addrs->asrc_2_mcu_addr;
 		emi_2_per = sdma->script_addrs->asrc_2_mcu_addr;
 		per_2_per = sdma->script_addrs->per_2_per_addr;
+		sdmac->is_ram_script = true;
 		break;
 	case IMX_DMATYPE_ASRC_SP:
 		per_2_emi = sdma->script_addrs->shp_2_mcu_addr;
@@ -1341,6 +1345,11 @@ static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,
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
@@ -1591,6 +1600,8 @@ static int sdma_config_write(struct dma_chan *chan,
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
 
+	sdmac->is_ram_script = false;
+
 	if (direction == DMA_DEV_TO_MEM) {
 		sdmac->per_address = dmaengine_cfg->src_addr;
 		sdmac->watermark_level = dmaengine_cfg->src_maxburst *
@@ -1770,6 +1781,8 @@ static void sdma_load_firmware(const struct firmware *fw, void *context)
 
 	sdma_add_scripts(sdma, addr);
 
+	sdma->fw_loaded = true;
+
 	dev_info(sdma->dev, "loaded firmware %d.%d\n",
 			header->version_major,
 			header->version_minor);
-- 
2.7.4

