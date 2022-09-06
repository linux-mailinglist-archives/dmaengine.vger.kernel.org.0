Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855C75AE4B1
	for <lists+dmaengine@lfdr.de>; Tue,  6 Sep 2022 11:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239017AbiIFJs0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Sep 2022 05:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbiIFJsV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 6 Sep 2022 05:48:21 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2074.outbound.protection.outlook.com [40.107.104.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4403477E9E;
        Tue,  6 Sep 2022 02:48:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARlHqEkeARIERdqvipmWDyTxI1DpRCZ0RBMqu/Kx3jUD5WHrceiU58lKA+Oil8l42Vwj81k1MYuuv5JQWzHnLGK6DzVQlEMV1+XMxPtTZuZ+JgsIAqxDbiDrQF3GJ8jgzhfvL7P0nBFJKOvdlrheb6pkXm5W4EMbpy55TxwbTds6JSeIge6LU03GZMWz0W5nvJKC4MXibhGah/A4eLqy823if5/L1HVDvplhWZyn2tD5PRuKipVH32S9BJCrIuqYKq8Bh/Fxc2OY0U5grvdy323Ewxy5/7dmjwREa6O5Dc3TlMnhM352bTT5/l3RvzSHRSTelMO0BRQg9xZxNP8iYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IT8qLsWtASgU+jrkmCjIv4P320Habx7fIb/JbroiA8E=;
 b=DzfVILUnbUj8JMx47Fs02BBLKq/zPWop5+hqVYpH5lnoSRRmX9ti4O1hUZBetpf121tTx0RneuQK5Voh8LcEKhaOx/3VKObjD2fwPGVyrK3FoMs+BzC/v2UIsQqKV5PqW6RXkk5+JUnHk5jRdzGRoKX21+y5l6ANB01OJVeO+dKO5rVMnfKIua3epgVdKFG153naQEy20715TXTa6bslBcFFsyTL7/efnZHCGugxavUqLO/CqwFcLEKk0X+tbb+YhK7s2gZtuJsxD10B5iZjUyH3VkQ4IsKoEaHMYofyPwfPllGGYFOjcqbuF5VYyq+J2V/YfLfK1y5OyDNCYH768w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IT8qLsWtASgU+jrkmCjIv4P320Habx7fIb/JbroiA8E=;
 b=PznoXhoGi41YHIcpoe1iKTvjiNm3zn1B2uwCn+/CuS5DFzapZKaXBCadn/y45FJR/2mLsSbfyLc2Uzqdwc5kwqzHNb3uYWh0zK9lQtTaUq2s70DzXOMiZfH23vEZWhN6LfR3kBm0d+o1769ljiPWvsF/eElF9zfYpuTQioffnXE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by PR3PR04MB7305.eurprd04.prod.outlook.com (2603:10a6:102:83::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 6 Sep
 2022 09:48:18 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::704a:fa82:a28e:d198]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::704a:fa82:a28e:d198%6]) with mapi id 15.20.5588.017; Tue, 6 Sep 2022
 09:48:17 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Cc:     shengjiu.wang@nxp.com, martink@posteo.de, dev@lynxeye.de,
        alexander.stein@ew.tq-group.com, peng.fan@nxp.com, david@ixit.cz,
        aford173@gmail.com, hongxing.zhu@nxp.com, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/4] dmaengine: imx-sdma: support hdmi audio
Date:   Tue,  6 Sep 2022 17:42:54 +0800
Message-Id: <20220906094256.3787384-3-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220906094256.3787384-1-joy.zou@nxp.com>
References: <20220906094256.3787384-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0128.apcprd03.prod.outlook.com
 (2603:1096:4:91::32) To AM6PR04MB5925.eurprd04.prod.outlook.com
 (2603:10a6:20b:ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8ee2195-86c8-4387-0679-08da8fececef
X-MS-TrafficTypeDiagnostic: PR3PR04MB7305:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zx3ZgPyF6+8Bx0SEXx5kGx0mibsU8bAGP5UoZlVIWOMgVBph+4nOzU/bVR1/GoY7TdzCSw6P5vm5+Up94qoi7oiwuNppd5fe6Egj0p2mTdHKWfa/CudDwfE1cy+tedTCeTwntnxiWalnnaKRZ9yp9gcuaM3t90ZGMRIxtdD7AOduB3kR8v9aDK+25GIQe2LtLW0yzUSPp8/ztvNwgfpYuI245+5bL1K/4cp6BdFu1pGIW9Y7Ok1HGiRTUv6p02elR6M7njvujdvcvotjgfkD0StQ3S3ggB4Z3lvDrN1s8FXEHTT4ZYD134eFEYDHgrJTngtRWg/Bu6krffriyvkAZmkkCh8s8HJvQ/pBBxKy4mi2hQWk6YkTE+Dqt9oAphfDoa6MVopXdhXG7x3bu0pPf1zCFCdbB8Y0G91F4DWG6GRwSALvodTGDbokuH0MFfPjKwmJqmY6DCPbHbZ8YnoRKncV4ibaZtKkrfbz/sER26x5BkEvrU6Q60OFhqA6xQqQb4JMP07izDDmb4G2gBOz/Mqvneg0T2ecUKdS83lNapDuX1YIYkBAeVjfiAumPXZsItD/+e1QfSgV9u80Zckmb/vIn9xFDBijtfHkRAjaK1ceTXkOPvUG4L+vWHWfTAmW3fkzUgP7NcFMHoVdc0SdusOiS69iISZPp+3Cwz86Fq2yhvgJzA5HsbNAEMRn+ohiP4CUghzfEzK4sIfs7jiiGCI7eqqWuXKIrtd+USoZaaqlsnyOu6FntSS5F0Y7kR40HvARQZOfjkV5b1z1akl6PA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(7416002)(8936002)(5660300002)(44832011)(2906002)(83380400001)(38350700002)(66476007)(36756003)(8676002)(38100700002)(66946007)(4326008)(66556008)(316002)(6666004)(86362001)(2616005)(6506007)(26005)(1076003)(186003)(41300700001)(6486002)(52116002)(478600001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ch5fYqUJTfq3Jdl2a5LjDYse71X8m/vrp87GyBPnQiF1ZC9deLWV4OETl9ES?=
 =?us-ascii?Q?qQAFAw8SUr4C+0zWG725moBEtxxdIvfCGWawNz8Y0RBWfirwxL+RGAu6lJey?=
 =?us-ascii?Q?lRsG6NDBUJ8n8WaQdQtX727jQtQ8J1BeSCoBOUk7XZWaRgOBvhIhCS5CSI6n?=
 =?us-ascii?Q?Oj+gqNlF6dVszkL7lSdzHVegKoSZhF7PlfqNSJ6uIGjHL+dL8T4DmdvQGj6l?=
 =?us-ascii?Q?6jao/5hCNwxob8cDYCAsXS1uCaCDQipTAgaBm5zve7FbI3sl6Vwkwt8t2Atu?=
 =?us-ascii?Q?+EjGVCWuRiyAiBBsdx5VGxoKck+wJub+P08Y0fWmICvB0DWPHekajkHoDqwe?=
 =?us-ascii?Q?nxKkoK06I/wj+ds5nFU+yIzfXQPjTegrdnglW1s/lF199kw4Ve/XW2pcRbfM?=
 =?us-ascii?Q?xWQJmQPka8A8Q0pRYOyBbphv4wKIoN4Zs+tD9B6vdf7bno0pv5BE+3HTC/mu?=
 =?us-ascii?Q?VMemiXzrCmgICXSvjzfK6ejtsuW9RP/T8aVUaN9a3ts39fdteTMirz+Tha9w?=
 =?us-ascii?Q?hgiJ/XSDYDuO7vzkENNqxDs0nR5PLL1RHBBqMEsEzKpvFoXOmCpp+1KDbcJJ?=
 =?us-ascii?Q?2tpywcE1inYSTV/RLuhBVkm//ZV/0dIT+61Gx4OOm+WLqyb/r9Efsf5AYvn6?=
 =?us-ascii?Q?4OgJ82kEF05bH/ccvXY0gIJtkoiO6BhXm5ZsOGsqtdjyz+YaW0zXPnHMYlgp?=
 =?us-ascii?Q?Sz/kxVAyIjfdYNwIbOUpefuzD0oLSLecBwTrOuhrjvnxkaZ8mhZOFffYic/n?=
 =?us-ascii?Q?zcSs1p/UbntpKfEcE/Snt1h5kyWvc1Jjp6o6sxAd+hzcpYdX9UAY/KQEugJK?=
 =?us-ascii?Q?UeJVcVa43KBI1O3rV1yAUj/uOsTxW7b0PFSGq18eT0q6rY58iV1SbZvlk1RV?=
 =?us-ascii?Q?Q1hb2wEL3ouxbvIW6oP/Gc2OEbUvYdPO6+0OScMyFF6wHCfEI6OyQk2gKzuP?=
 =?us-ascii?Q?BbYM+uVZGLI0Vqex+jXGytXzrpVcYbTmQrIqdtwg96S5XuccNvddqGozLrNl?=
 =?us-ascii?Q?CYaBATCMwQhlKKtDng5zdjUNBC+cmqQVdivDsElU0isKSZpiEJfj6rvKoq6j?=
 =?us-ascii?Q?f0xXpqPuP70dql8zPXDAahgQhixGTQQK4qHxpJCwnvaI3Z/3YtJ6r+DpTwAJ?=
 =?us-ascii?Q?YKAVQZr1m+6LZSBJfmaLBkCsqQrcNPEzsHKcWXvswXv611BxchuiywdP2X/D?=
 =?us-ascii?Q?4Bu4DDUTG220kiExelywQfqDvbA8jC5kPm77sc6d2BO6G0s1QC0v2O7C9Cm4?=
 =?us-ascii?Q?zaKlnAn8SonR10LWrepgSvmJ7RaYCWaaevBLxnY/DwhPguH1QtzO/VyULTUp?=
 =?us-ascii?Q?PdzkT9lvAgzfeVCTVdQUcWP0YBKYmkfLKZkT60sewtgDd40otKObQQszWtkX?=
 =?us-ascii?Q?Typw69EhoIHuHmjJNoE4BI18vCB1YLtn1bTaUG/MvyBV5uHNiACSrc9lPC86?=
 =?us-ascii?Q?bHYP03IqvXB7BcR24vrvYolpgWefXbiXQ9YF4BekdbWxk7Oz5CVsJS49/970?=
 =?us-ascii?Q?r611dFl36mDnspnZyNomgdDEVCOIWdmBSPlZPkLRfb0ZguHl9noif0Up+fyy?=
 =?us-ascii?Q?7h321GKFzaeVp6tyKvzfRyDaRokQrApFMy2rWrxW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ee2195-86c8-4387-0679-08da8fececef
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 09:48:17.8050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LcjfyFJz0EYyW/fShKgpsfOzQkn5WrPHnM9ipaTOnMwHDDjy2xW4gH9niWChQROq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7305
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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

