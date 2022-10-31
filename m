Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3721C6133EB
	for <lists+dmaengine@lfdr.de>; Mon, 31 Oct 2022 11:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiJaKt3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Oct 2022 06:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiJaKt1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Oct 2022 06:49:27 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2040.outbound.protection.outlook.com [40.107.249.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7B52ACD;
        Mon, 31 Oct 2022 03:49:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFxStO6xSBdf9evyOoH5XEc9uPcgzZYnO1WKkoZjhqYYybx4MU2fqBHTigNrbSDyrqqK6QrAty/KlyJCGEBW2N/M0nGsEAK/TpzbQg4UllZYQVyjZfQ9Er9ku961U73s5hLyannL/hPRGA5xJtbfiXqdFGQn5Np62G/5JVOTn8Pn2dVWN6ce7f4lRoUxFkSUwiLqlYdbm/1ZFo14Ie7XwvaBerLEFXyn4Tmlih6BomTH6GZZ/lytuPbb5mPxk/5XcglcAGv09nPBPw/UwOAqyaEGlBAWBoxNZfeoHVZ10DS0M6DSwFTltgaf56hpEeR43u9Fv20jb7T/enmCgd+S5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNh9RhNK+gVdolc8RfOujvV7bD1ZX6aurSU8CsL7YAc=;
 b=i2HXuPDFtRDkwnbEi7zDSn5b5V+H/GcZNEXmXCSDLz45SM+UEQrK7U4mLsMmzYA5fDPPU8f1D51l7F4oiy/VLmfEMl1oF2kd9KvRu5GQ/vPef9GIcUgrn18BMgMCQLmkXm+V5IppmNsCDws+gN1NZNITlr8bdwAb0bL+X0QAWAnx+3kmQ0ctXA46Hl+oCmLu7eCPW20/dzR+MqtLUTM+mWcJD9hm96BIWKeNu1frXpasv4opOiis6Dplk0PVImPNuR4ZAoaq0YBK99kZIBUX3ZGic7cl4UmNrIBIegQEUkwQXp49J+mrEVVbJ7YSfkn7Q9etWSqjeVIZ+0ry1fuFSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNh9RhNK+gVdolc8RfOujvV7bD1ZX6aurSU8CsL7YAc=;
 b=Z0Zf/k0FGYYUfaz0wgre56HpmJ7hto/4dfpPKA1SxCOgPfNIg6sSoyPCxKHIzmnM040Ur7hEVPofQ+Ox3527/W2s1y4h8DMaCvm0Lx5QDSCBLmKT4eTeaIcINjbASy6G1641CtCfYTsX9vYCpfF5eDmVZaNB3nQnAFCBEeTou8w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Mon, 31 Oct
 2022 10:49:23 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::7a34:469:fd53:922c]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::7a34:469:fd53:922c%7]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 10:49:23 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Cc:     shengjiu.wang@nxp.com, martink@posteo.de, dev@lynxeye.de,
        alexander.stein@ew.tq-group.com, peng.fan@nxp.com, david@ixit.cz,
        aford173@gmail.com, hongxing.zhu@nxp.com, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 2/2] dmaengine: imx-sdma: support hdmi in sdma
Date:   Mon, 31 Oct 2022 18:50:28 +0800
Message-Id: <20221031105028.598502-3-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221031105028.598502-1-joy.zou@nxp.com>
References: <20221031105028.598502-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:4:186::19) To AM6PR04MB5925.eurprd04.prod.outlook.com
 (2603:10a6:20b:ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5925:EE_|AM9PR04MB8793:EE_
X-MS-Office365-Filtering-Correlation-Id: 59049ac4-6156-4185-2983-08dabb2d9246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ILxPrxd3LXxf05mCp5HoYmkQ+bqOIjgCWGP9Q345i8tUoqITmDzRUaJsNbkw0LoOyjszteq1UOQLx0voiUAMJkYq78EDPb4R9++O7t+iENaCucf9gat5bImXpS2Zrd6fnuhCpSLwPDf3kSr6cwEL+RbT7aOpmYLEvVM0wEGW5yb9/R/5qpawiwEitzKzcCFAgBE6N4lH3b8LnSkkHIxdlTTtIiHiSROl9gUYVkgyDQrJKy4P1WOQk3PyFdoXj5pjgp1E+USBz/0ia98zWeHB2rWWXjZ7zkm560HbtzN6dVdKAdEsvp5HtHR93sBUEAiVk2XwVlDSGv7/bbPAYWSEpWuK31DWYIl04rEvEDEkLl/WkG8aoCenvxoPHZLb4RMONcqbex0w2OPYv1GbfKRTJBuJ4gemO4/AHBflfRJgwuXYGrnKIw7dXN2+Hg6CIZfdK96QTfjoQ2029JP2sNNbBfq7oYFWpG3VQNEBYgdTdvgKHr2o/asQI3iJxp8kLxcO+qjYqNOrpul5oL0vF5EaymWKaLF9n3a+xis6Tpi2tQ3jBryTNvVzt9Tx1/Ssus/ehK4RajebPxEDYFHTjk0wxXFFWux2L07v4i0+Hvl+P7jRdAQAsKV3ZCkxwMbU18E2/JSMH5BdGzy3KeGNh6xoBojsG/U67HHCml1OiEb6E1vgW3aEiQ3xN7IpYLAKkZ9rrYu43T3mob9/agP5ZDqblLGNB/wQKttzSCER5d9deR/siuJKQy20w5LzgA1+icaTTltUyqn5lXoPeDar8eex0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199015)(38100700002)(44832011)(38350700002)(36756003)(86362001)(2906002)(6486002)(8676002)(478600001)(41300700001)(316002)(4326008)(66946007)(66476007)(8936002)(7416002)(5660300002)(66556008)(186003)(2616005)(1076003)(6506007)(52116002)(6512007)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vYFYUYftqs6AdMC//z6jorfl01RDQgpvpcqVaeHIA8dOTNgC7Ck09sJrOrDH?=
 =?us-ascii?Q?qVKceS0nY2iPC6D5DE887Ql+tKkcd+ItoMCeFwmY1ZgiNTO9fOGorjkRICgB?=
 =?us-ascii?Q?XRa3bLeUXBDHvZqjnnVWYNBVvCPuHlbPrxP0wWlTWm7/ZsuzqAORgaEGGjEu?=
 =?us-ascii?Q?Zx8CWm2ANTvt/v+yyl75BsHI0fVC33LuZ/yGCYAXUPQyaf/ExLTAILi+0AcW?=
 =?us-ascii?Q?QJ4jvj7riW3I87ad2X2eGlKiFwZZCNEYPyvuxYUdPwLh1LBH4Dzg6V59v2Fq?=
 =?us-ascii?Q?NmoMhQrImftp0z/Q6mlB+yPj6tBRdGDJoQlCbrSrOh8Q+hMhc8XXrmr/HBE1?=
 =?us-ascii?Q?NRPeISmDES9fe7kSFCI+4nKU8HUePrnhD7i/iPriEun0JQ/YZaT5Xg/a8fRB?=
 =?us-ascii?Q?6uoEfn2tYQ8mt+dTfYs1/cF5M9hPD1rUXkqWejBIoFu8NJyWnqWoIdbZ1sDW?=
 =?us-ascii?Q?IHi8Df3C1MMYC0oUsZkVY7ct/kp4yr4OQRQpZQCeh7G+mBgc4tY9mTT50qB/?=
 =?us-ascii?Q?JNeMwF1SlkuJN3nMx9/D//9N5fryhW+fLBk7akdQG2tUQRBCZhq0uzxagD+A?=
 =?us-ascii?Q?c1p+yQ4Vx4zDbOL0hBZFHBNuC7Xih7q/CWAKiSEnO5yolXCOMzptzjmFXmMJ?=
 =?us-ascii?Q?S+MO/1PS6UFmA3dpayUQRZj1rvJY/t3i0r4qID2/G2Rr0ECgum31OZiawgx0?=
 =?us-ascii?Q?RN88N3JhWDt8m0pY/WbjdhtdZ9F4Czn0bYO+JmcLE6wE0mhDW/bKn+NesPbe?=
 =?us-ascii?Q?tWhQO+sclTe+AkVZ1lbBtQkgzLzMhBvGZflsgj8VMuum+EhhgygJ5q8fWQHH?=
 =?us-ascii?Q?dfRCAsfMH3nMNHVFp54OrTZYJBUlTSe+7UJJFrDZ/rO/0jqVpEJfKPazFPoa?=
 =?us-ascii?Q?8c45tjvMjwt4Htw3gLt2dQZVqI9HY7fh3p5HdlmaKhEyPt5VAt9FQyzbyEOd?=
 =?us-ascii?Q?kf6p5sekB+rDM4T/XSP/Ohu/fiC4AyJyUkqR0cODTD0z6k36cVDxVHuxfokc?=
 =?us-ascii?Q?BkO7IhM7hnN063MxoPwGfRY+riE+sq2zmDcfYvUtFyBplpNHd2CyPNTxFX0N?=
 =?us-ascii?Q?VfsTgzDBEl9O2LMApSLtpMwd06Txa6Mc/U9KPZ9i1gWQ243jJJCy1ca2GCcx?=
 =?us-ascii?Q?4O0dTXYnz/1bYnHdx5G9xHWlIHtuOFYFxYA7H8NsH49Yj/PdN2iCCu6goS04?=
 =?us-ascii?Q?fi1VFJzjEYJuk/IXIgoJm2xHtwFJix4LD9foI8m9verpE/UG/tP7xhA/MAGB?=
 =?us-ascii?Q?s/qKnrtI16d578vgM0IZG174KGJThJeGt2Bu/QbJllq5ARB0DBL2XKJaIKwg?=
 =?us-ascii?Q?3LmIAEIoyBxG8CTAtAo7lmVBVxGandYYBwxvJsji6XZRmNzllFw3Wk0IcDfj?=
 =?us-ascii?Q?kgbJVmhAuPxkFYw3oj4HFK0U+ZbK/JN3zsdqwaUkdfE75h4TOFJkN0Ckd8UV?=
 =?us-ascii?Q?yXcP7xonZ5hsjtclbaQaBSFK7jSqRqzZenqlAiUIUnsPxcA/82y6RFxUkOQa?=
 =?us-ascii?Q?GTF4rIvqvU/UNAkcJshBury4icv3wHrnAjYWgWWL5GApmWva4lHx+r1Z0KtB?=
 =?us-ascii?Q?e9ANqB6T09YTHBw7FaRSWtZHMJsqgdSTKPp3FAAt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59049ac4-6156-4185-2983-08dabb2d9246
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 10:49:23.0527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6MO9fOkx2vU1DjfQvoLXLvtE6TB7imYnoyuBlIu9SOrdJ2oCIwiIoodzeLvVXGxG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8793
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The hdmi script already supported in sdma firmware. So add support hdmi
in sdma driver.

The design of hdmi script is different from common script such as sai.
There is no need to config buffer descriptor for HDMI. The cyclic
capability is achieved by the hdmi script. The slave config is so simple,
only config src_addr, dts_addr and direction DMA_TRANS_NONE.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes in v7:
    modify the commit message.
---
 drivers/dma/imx-sdma.c      | 38 +++++++++++++++++++++++++++++--------
 include/linux/dma/imx-dma.h |  1 +
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index fbea5f62dd98..ab877ceeac3f 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -954,7 +954,10 @@ static irqreturn_t sdma_int_handler(int irq, void *dev_id)
 		desc = sdmac->desc;
 		if (desc) {
 			if (sdmac->flags & IMX_DMA_SG_LOOP) {
-				sdma_update_channel_loop(sdmac);
+				if (sdmac->peripheral_type != IMX_DMATYPE_HDMI)
+					sdma_update_channel_loop(sdmac);
+				else
+					vchan_cyclic_callback(&desc->vd);
 			} else {
 				mxc_sdma_handle_channel_normal(sdmac);
 				vchan_cookie_complete(&desc->vd);
@@ -1074,6 +1077,10 @@ static int sdma_get_pc(struct sdma_channel *sdmac,
 		per_2_emi = sdma->script_addrs->sai_2_mcu_addr;
 		emi_2_per = sdma->script_addrs->mcu_2_sai_addr;
 		break;
+	case IMX_DMATYPE_HDMI:
+		emi_2_per = sdma->script_addrs->hdmi_dma_addr;
+		sdmac->is_ram_script = true;
+		break;
 	default:
 		dev_err(sdma->dev, "Unsupported transfer type %d\n",
 			peripheral_type);
@@ -1125,11 +1132,16 @@ static int sdma_load_context(struct sdma_channel *sdmac)
 	/* Send by context the event mask,base address for peripheral
 	 * and watermark level
 	 */
-	context->gReg[0] = sdmac->event_mask[1];
-	context->gReg[1] = sdmac->event_mask[0];
-	context->gReg[2] = sdmac->per_addr;
-	context->gReg[6] = sdmac->shp_addr;
-	context->gReg[7] = sdmac->watermark_level;
+	if (sdmac->peripheral_type == IMX_DMATYPE_HDMI) {
+		context->gReg[4] = sdmac->per_addr;
+		context->gReg[6] = sdmac->shp_addr;
+	} else {
+		context->gReg[0] = sdmac->event_mask[1];
+		context->gReg[1] = sdmac->event_mask[0];
+		context->gReg[2] = sdmac->per_addr;
+		context->gReg[6] = sdmac->shp_addr;
+		context->gReg[7] = sdmac->watermark_level;
+	}
 
 	bd0->mode.command = C0_SETDM;
 	bd0->mode.status = BD_DONE | BD_WRAP | BD_EXTD;
@@ -1513,7 +1525,7 @@ static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,
 	desc->sdmac = sdmac;
 	desc->num_bd = bds;
 
-	if (sdma_alloc_bd(desc))
+	if (bds && sdma_alloc_bd(desc))
 		goto err_desc_out;
 
 	/* No slave_config called in MEMCPY case, so do here */
@@ -1678,13 +1690,16 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
 	struct sdma_engine *sdma = sdmac->sdma;
-	int num_periods = buf_len / period_len;
+	int num_periods = 0;
 	int channel = sdmac->channel;
 	int i = 0, buf = 0;
 	struct sdma_desc *desc;
 
 	dev_dbg(sdma->dev, "%s channel: %d\n", __func__, channel);
 
+	if (sdmac->peripheral_type != IMX_DMATYPE_HDMI)
+		num_periods = buf_len / period_len;
+
 	sdma_config_write(chan, &sdmac->slave_config, direction);
 
 	desc = sdma_transfer_init(sdmac, direction, num_periods);
@@ -1701,6 +1716,9 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 		goto err_bd_out;
 	}
 
+	if (sdmac->peripheral_type == IMX_DMATYPE_HDMI)
+		return vchan_tx_prep(&sdmac->vc, &desc->vd, flags);
+
 	while (buf < buf_len) {
 		struct sdma_buffer_descriptor *bd = &desc->bd[i];
 		int param;
@@ -1761,6 +1779,10 @@ static int sdma_config_write(struct dma_chan *chan,
 		sdmac->watermark_level |= (dmaengine_cfg->dst_maxburst << 16) &
 			SDMA_WATERMARK_LEVEL_HWML;
 		sdmac->word_size = dmaengine_cfg->dst_addr_width;
+	} else if (sdmac->peripheral_type == IMX_DMATYPE_HDMI) {
+		sdmac->per_address = dmaengine_cfg->dst_addr;
+		sdmac->per_address2 = dmaengine_cfg->src_addr;
+		sdmac->watermark_level = 0;
 	} else {
 		sdmac->per_address = dmaengine_cfg->dst_addr;
 		sdmac->watermark_level = dmaengine_cfg->dst_maxburst *
diff --git a/include/linux/dma/imx-dma.h b/include/linux/dma/imx-dma.h
index f487a4fa103a..cfec5f946e23 100644
--- a/include/linux/dma/imx-dma.h
+++ b/include/linux/dma/imx-dma.h
@@ -40,6 +40,7 @@ enum sdma_peripheral_type {
 	IMX_DMATYPE_ASRC_SP,	/* Shared ASRC */
 	IMX_DMATYPE_SAI,	/* SAI */
 	IMX_DMATYPE_MULTI_SAI,	/* MULTI FIFOs For Audio */
+	IMX_DMATYPE_HDMI,       /* HDMI Audio */
 };
 
 enum imx_dma_prio {
-- 
2.37.1

