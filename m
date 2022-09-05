Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC845ACDB4
	for <lists+dmaengine@lfdr.de>; Mon,  5 Sep 2022 10:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237463AbiIEIeV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Sep 2022 04:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238036AbiIEId4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 5 Sep 2022 04:33:56 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5413F4DF02;
        Mon,  5 Sep 2022 01:32:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lq+/wMGXNVSsEeViA4v4Ph44gJ6i8MPbVvFPHykYoTHRsfRLrX9A7swvhhBUfERmB7GrfGu2hqe3KHEO4TjfV3nM1RFa7MInEbM52Bqxth6KveaS84HU/Zc8m/M2aJhpxqn1cRTFpU6KBxDPCaTj/fmL8fNRkyFPzNglbm8t1m9vuDW0IaKBQelmBBCSdIDskZsky0fc+pGI+yNoYxZ2wDgkRPg6UqvLRIA4Wv3sdX0/He0NRbE8d/U24aJJ45lF6tM4R5KhpEHCQy/RbnZ6sUgFp9KXmAnqHaCGMxwPXzAyFx63H8QjQWRLuWYfWMyHGQM4EVI+2AzGP46bZLRWQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IT8qLsWtASgU+jrkmCjIv4P320Habx7fIb/JbroiA8E=;
 b=U3VOzTas2OpTsl8yQZEAGuXfs46W57V7ogYZ1NRyZwi6zZrLyos3AkabEooOH3lvSGGCMGUxn//yH/UCM5QC27/3UkeOS2lMtkctFA+3Xc/Tc4e93enPQ2j0YzGTqEajhFjL7o+63krEWUOv1bfATem4Mqc9G27upWT/fM7dga7VWiuZaggG9c9+aitgomxyJjxP0sV31LS+Yanfp7krWodMo0XPzjE9/uaO/1tZOTjscu+z4guQLcp+1S8RKTQemWqv9JYeQhpVlRb3ronMNLoNNV9pCe9Mz8I4MODVL2aceegS9sKpe1KVlnVwVV3iD5/hTGGho+Dhl3zEvJSwCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IT8qLsWtASgU+jrkmCjIv4P320Habx7fIb/JbroiA8E=;
 b=X9wauvfbqSkGvjFFQPgBk4ygO0OG05FYfYEJ75XJcUJSYokBCopS91IJg/do/+Dxd0yOd03xxaoKQ/WxYTk/l93lr8lFtXgq6hiDMqI08DaMcKmMeRZErnKW49AFS/A4aFl/FLKs+yKVbUheJlvKDYgt3B4EZpEbSTD7YROlOvc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by AM8PR04MB7363.eurprd04.prod.outlook.com (2603:10a6:20b:1c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Mon, 5 Sep
 2022 08:32:26 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::704a:fa82:a28e:d198]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::704a:fa82:a28e:d198%6]) with mapi id 15.20.5588.017; Mon, 5 Sep 2022
 08:32:26 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     krzysztof.kozlowski@linaro.org, vkoul@kernel.org
Cc:     shengjiu.wang@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 2/4] dmaengine: imx-sdma: support hdmi audio
Date:   Mon,  5 Sep 2022 16:33:52 +0800
Message-Id: <20220905083352.89583-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0249.apcprd06.prod.outlook.com
 (2603:1096:4:ac::33) To AM6PR04MB5925.eurprd04.prod.outlook.com
 (2603:10a6:20b:ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4354d69e-6f71-43ad-7e40-08da8f192962
X-MS-TrafficTypeDiagnostic: AM8PR04MB7363:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nGI0tO5lqoZVggB5wTIFirpMKkvgvzqbc5OynHflHBQUhdTlGF2pASDRElUolW/n77aIFt7x+dbfl9pAmevZkQrOsLIu4lePTNPLnlYI9XDlA4uQ3ECWLA06po3Jmz3xIUQ4GxG4VRGbcGoBY+xe9zEY3qOnPthBTkMREuwUfcP5Onnlvq0VzjhA24Z9ZWzuJlD8myxbc+Mb8QAxfJV/8lHcHE1bBOGMuOLe05vhDnlcLm5V5UVf/Wtlnkfph+euAvx8zvg2JPod67V3EWEvVCk1Ol/Kg0WmNrv4eae6gnNGz4OnarnmFEtKlbs3fdHQWl5CX5Ca0cTwcU8/qrJoU/o8Ij1xaQ3bkU6vbwUoFoIC1+ADfUHyaVB5C7568EsBMVMeOtuLttVJDotKfzPv/SjGqT8kLbO12R5Si4u6WL2PciJD8WXDLDhz2ts2xqviVFFWUSmaX2epBdQxB4G5HydQNoQLAfRIY8mNGGtQ+FwR/FQHvUA+73yWvEPznIwFz19vzxAw3FxygGGUwho8wDRWduCrHzxqJVAkZRsYnsexKN3kNynQGPVMVRdXmp1oettSZ9FgXL1g0ELXpVRoN55TEf9wbchD0hxKliWM6NVNtRUOT1BmZO/LTgf77xXZIxk12YGVLi+yyscuMDkUEgy+seSqwtdJzwLbzlv9amvLWeWz3kSA4U+fzSGtYMiR+pT5tEIgdWAHVbbKzQDsS3a6TMBjmvXdWbSuJFv8I2nO2ecu/GbGPIS6JpolziacUZQqRedXmbuaAE4mu194aQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(186003)(1076003)(2616005)(83380400001)(316002)(8936002)(26005)(6486002)(2906002)(5660300002)(36756003)(6512007)(41300700001)(6506007)(52116002)(4326008)(8676002)(38100700002)(44832011)(38350700002)(478600001)(66946007)(86362001)(66476007)(66556008)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F9HH20JrguEL+yAY7zYCRlWgnq+uW0UrY3fFAIPbKKFMpTg4Yb1jmbL4dguF?=
 =?us-ascii?Q?Kcx9wAPy2qa79jleU9Kw4pcakUhSkWGGdFR7DtWcFS3kMoIMh5a9GFZaeoW7?=
 =?us-ascii?Q?+J+UjpC2WXx8e9DMXluCI5Ur7EvaywvW55e2CqtKdQhS8QCTuRhUyFJhOixU?=
 =?us-ascii?Q?lAvjLGjRYzgA1HvhNa7jZY2je/9Xg0MR1U/4uS5MY1sy49lhLztAvzdhJiel?=
 =?us-ascii?Q?NlQrEbDdcEp3RoGyRlxIdEbvM42hoQ+LeaMBnvAtP82ENsK1kdD3M3zdnUv9?=
 =?us-ascii?Q?t8+nfy6eqt/6lraG0Ks5c9CNp7NY0RxWTxscGsqQQPkZJbtqG1ljXoJjsPk5?=
 =?us-ascii?Q?5Oj0e0FutTuOsw2URKLEnYJIhwjOkYZzEx2e9T5Oed4n6kAkjZkxJlB47vi/?=
 =?us-ascii?Q?P0HAxOCRB+8xkH6AHIOU2xG1rTM0635guafxL2Uw3NY55EBSU3IQlGbj7wHy?=
 =?us-ascii?Q?vEQnbet4VdMh6ZoRIk1NfOIm2chh4IP5WfjfVQtpjrq0/F88bqf9wRejrPA0?=
 =?us-ascii?Q?XZp8GeoIqTTfpKd49v/uDIGqO8HOW53JRZJkYzDnzL/OlGhjZjFaSSYoHSQl?=
 =?us-ascii?Q?q4I9E1LWcyGmJJaS4H/dWgviOWiriL7H4TJR9MOaokHd2tu6ZZjvoAun/aiG?=
 =?us-ascii?Q?IB6XBf2cMAOscOGlPjKmD+PZwJc8XtUWUhXOwUuCLMlMKObjZnw/b6W3a2oW?=
 =?us-ascii?Q?2aVrAzb7KBCPz2AtxRps4ilOxAGaRJ4FkrXT9udOzTOklR5pk4+pjOScx5hS?=
 =?us-ascii?Q?34jRReQPITOlmDK4CRMWhR2gyDJXiyiRJ72lPn16ByFdMzbOxqM510wr4KAb?=
 =?us-ascii?Q?RDjg6/WzGTMsBvhiY+f+nOH7eVNM4/wKXffqTvEn9f1UwAERa8tOFBGVF4Qz?=
 =?us-ascii?Q?3EIsUcEZKEcIbfXoVqZ3MVwTDrlvA73ub+Yfgl/ahPCo4uUzE5ZlJfeldDfc?=
 =?us-ascii?Q?DfoT9jnHtCCfXla2bvuFs/fIy6VtTTGbtpuH1YqS6yJ5bXE9EeJ7z32EaU3d?=
 =?us-ascii?Q?RTJ80YfQ1rrQSnEU4xEGS5Dhi6RWe0glyLnA7VTpB+CQzF3+9iXCxYR9/NPi?=
 =?us-ascii?Q?tNjowE0uFZ86+QQgV3tOth9nbio2mPscensXuJx6vTDmu2IY3YA3oN71ekGf?=
 =?us-ascii?Q?769wowCc9jPKsGJaDknvSHGsmt+c1T1PIX4zswd6n0J0eernuaqh7SXg8Ozb?=
 =?us-ascii?Q?A06KdJvjjkyju4rh7UuKP+ucoPCYfTr1/5HsUu/xY0srNs3L1K1p2SBP4mg2?=
 =?us-ascii?Q?Oz7tw3kw2Z9iP+2lXufhrGI7jCm8UtFnpsu13Q/iwxlz0iGt2EUCUXkCmsBH?=
 =?us-ascii?Q?pRJL+Ym7NepgTFQkknCVfCkLVOQgle5QSuDAa2cQX4+iTIP7clnTdLVda3VU?=
 =?us-ascii?Q?q7EDivDjg1KiGR2Fp/gGjEF+EBtrx9UBN8W2SNDXWY12/Phvjhi3LJu1vcOy?=
 =?us-ascii?Q?y40v+TojUZ9fr9wwvHmjwEfFJu6lOXwMlg9+E+PhkfSeIYDrOhcXuZIqB5Zz?=
 =?us-ascii?Q?ZTsFydTOBZygQ/EjVrUzFgylvYAibZmjZZEf13rk7w/V8YxmBo94hqRjisb6?=
 =?us-ascii?Q?R8ZbO+/nDeePnFoB53EZtRTY9lwy9sUpgLPvwKtz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4354d69e-6f71-43ad-7e40-08da8f192962
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 08:32:26.0121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /A6lAx2kg4drX+SZ74VkTM/kW4YpdJBTy+QrOclvePOKcw0hUsUFn3i5m+ABPB2H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7363
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add hdmi audio support in sdma.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
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

