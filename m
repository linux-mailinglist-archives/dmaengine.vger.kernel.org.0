Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CEA5324E3
	for <lists+dmaengine@lfdr.de>; Tue, 24 May 2022 10:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiEXIFh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 May 2022 04:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiEXIF1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 May 2022 04:05:27 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150080.outbound.protection.outlook.com [40.107.15.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FF09728E;
        Tue, 24 May 2022 01:05:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GdmuSgLS9vMGR8+2KH4TpFtoW+jjTrgXSQHheqgotGQSxLLWfMF9zjPvM9WQRuV3ZrjFTDA32ot4p5y9w70JkRKIO800Dj6KP6sCObKwXkPfi+70b49Pq4wb4h3bPEYUPOe3tjT76XRmJs4qS7ScIHjUb6IZIAaK61pW7TwuPTbBGyCQpoKQ5liuYbDkjQQGkSP/N3q94UHzncx0M+pMP0UOtV1QOpqnyU8qiLSrkZV8YFfW4NqzS4KUngxR/MUNNitbbOmTiHGcMQTPH4TzbfTQT0Juy1J3GI5mhCyoY/WRNF1/xw2B5YymkT5gdpDKoaasWZejyGV2pUfMtgJKig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MqQp8N60NJf6S873pcGyCZKiuP+SNSEVIVWiZsUqWlE=;
 b=k3B+W3TaVy2/vkLk5YnUvoi+/yQmTFgDIs38xagmfAck7IWwcitRYCbkumx/rusKCcXR0K8Zsx363riqyv0AMTjgZx9NX63e6Gg/FCiHrS4LeazluYvg0YMxKUwZbJihuiyX57gbhYvzPIbkmZFQ2dPD8NvXI55ZvysV9KvkX6CYAeqYsn2MwHdu4AETodfE2NJXAB0bWfr8qlcKH+lKHUZGrqz84dDBDIwLUQBOTv2aEr9PGPxe93hDnoO0FBWdjqH+hJwNL4ySuW2+fMW5KS/iN1YQVdsTPm5+sZsANm7WxJ6CcEpHoPXswpA7n2pAxTGZAjebx8dUCpSKf3CVzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqQp8N60NJf6S873pcGyCZKiuP+SNSEVIVWiZsUqWlE=;
 b=CmrNbcXcJdFjojV614VFFUQke8H1B6ovtooM+wjAk8fOwPIakG2T4i40NiOzfSDeEgB5anjDAJ8WnTILzP6BIW0hoVrEJLi9zOk5dh5QgsE1urrJCwWD517VFde50a+GmBiw1m0Z9nPMJCGPdXTHIK+pTF7XygKiYYL1pA3f0h0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by AM6PR04MB6293.eurprd04.prod.outlook.com (2603:10a6:20b:71::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23; Tue, 24 May
 2022 08:05:20 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::5062:4c9c:e6b9:d72c]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::5062:4c9c:e6b9:d72c%3]) with mapi id 15.20.5273.022; Tue, 24 May 2022
 08:05:20 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     vkoul@kernel.org
Cc:     shengjiu.wang@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/2] dmaengine: imx-sdma: support hdmi audio
Date:   Tue, 24 May 2022 16:06:40 +0800
Message-Id: <20220524080640.1322388-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0198.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::7) To AM6PR04MB5925.eurprd04.prod.outlook.com
 (2603:10a6:20b:ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8957f47-256d-4301-afc6-08da3d5c256b
X-MS-TrafficTypeDiagnostic: AM6PR04MB6293:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB62933FCAE8FB8AB35F2B758DE1D79@AM6PR04MB6293.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qwhtX7xeT7MQjrRJSh3jaRYugQ2cR/cIIjCl8AxVQ6R+P+wXOEHG+dMPB2KJvJGnptLuvoX80Nd9cNcbAd+KcKpyiyUVEL4xIWHQoKzmnqGhyMT7kUHgYrJEnhbxaQWHvx2dv5OjQx/lhEl/BPMC2lSHVWSX0EvQMNqGlo+NiUrClAf+OkS8XLt21l5Qt0yXsWUsfSagjaDiS44OCzmk+m3ByT5jY2NdnmRu/UnOmlxV7/VuoRXaozKmavXocDf0GGYQmgeP3sZkpCfIdgGgHSlxRnZ9xFXFCXFP87hSFWAEYzjlAyMQPFoS++KSPMbHVOx5G52pyf2ppcEDftIjzUnMdLoTSmiSsyGz2AT/BmsIQ2iHOz9L9eIOclBB28obuX7UDVsQKCbORm4M0yB761raZ6ngXIQmLe8WRHy2wDdSVAA5vb1ctAN//jzejvI7SFhYV5FBet4STSCTaI6rTPbhN2fFqxVK8LrBZoKExxdABI/ljU96NI5B044gybkpitwrtOQtCcjzvLeXRN2VqTbzAfqmoQykMSH9iWyLa1T1GERpV3sgbSF/kufCVqbpMIMu0TkXsaBmCdReAASL8kR/7ufGV6nI+cdqYT1BfS/am4FgihPPOS86iGfMO4ySL0qrvXk+g1VBTMsglUGYnEBDVSwcQpOvVrKHquhBd1R2d4h50pUSnmOePrytR9wVG1ko48AS6kZe4mfshEJsag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(6666004)(6512007)(6506007)(36756003)(2906002)(5660300002)(44832011)(2616005)(52116002)(83380400001)(1076003)(8676002)(186003)(8936002)(38350700002)(86362001)(38100700002)(6916009)(316002)(6486002)(66946007)(66556008)(4326008)(508600001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/mKD1l7BRW9UI2mIzCYxsBtdq3XZ3DrOPylpAepWnwKaObDSZeFOGE+K6G0B?=
 =?us-ascii?Q?F6BDb/DrT/8yxlZVbBArZz8IAiPT5MmxJpJi6q/sDxfCcpKcT7hP9qmcVEkM?=
 =?us-ascii?Q?/7wr5g6Ji9tu0DCavdmmPfpY24L2zKPhfEyEjGzbKwLb6Ye8gj1g0K5+I3Tc?=
 =?us-ascii?Q?q3qan/20SVow1lN6xGXBNGo4jID4xvRu2TcubtAYfZJll8GqyR8XsGc3JLuG?=
 =?us-ascii?Q?N6+zWucwDohQurH1x8lLkSnV5FcQTynM6ZUBhnlBFRys5GauTGuPXiaMGtRZ?=
 =?us-ascii?Q?XnbX/1g2CCRKHZ3zdGeBVO8Q3Z6z5+yXMkm2fTIm/CYd/YxQ0LrrGciL+JN8?=
 =?us-ascii?Q?TCg8CusSl+fpYMD/a08qAflCI+KFIHnieXWK0g1JpXNu3wAA3V1ld5hmtrGs?=
 =?us-ascii?Q?gasqE8jvFcN44Uo9J54PcqeC4YNgn1rggVPfYcX13PA48m/oha1hQRDy2oIi?=
 =?us-ascii?Q?LSX45HO0AODAer8KnzU6ghp0xM8Sa/bKe7lw+uxdEGT5xKkmwEekLkoAm5Us?=
 =?us-ascii?Q?jtnKTEGQxjPKLklnFLLw6Ov/Dbe/u0qpv3sW5z/Ki1Uk9wUN++Af9lQgxwmI?=
 =?us-ascii?Q?yCLSXGEwxgQjA7au2BLGfPOAf1sWy3w3k0sFkBePOy0oYpAKtg79RLwXaFcx?=
 =?us-ascii?Q?Jd76wqeT+BYh/5rbk9lJWTBUHW5LAnANXn3tFM23KT+T363ryLx9oGrHrQu/?=
 =?us-ascii?Q?icVvDerAb7TKeNFUfL5bzlD02nFac+tpx8d3T6AvLkfXHmMLkpVx2a0CpPYc?=
 =?us-ascii?Q?haGmaY4tQqqm+6VnjLxaAsA7PkTeynPP0h0pCm1nmOdCkJUgxzo2bNmaEhcO?=
 =?us-ascii?Q?xK9rivPdM/HcQE+zr1NsR6V45eKbBlFXTC6toqc1k7Hz9DiLtbT3gdpRkmA+?=
 =?us-ascii?Q?V/pHRekSDQke2ozCWBLvWRzBl+A2iNcqFognNi1+ETfZSDbe4DTbnp3rGKmS?=
 =?us-ascii?Q?OOwrF4xyTrzKGhgepq/AWG1IY0lTpieqalUUdaSXu0D8zxoyOG5fmJwVbWMk?=
 =?us-ascii?Q?gGhvNCGzVSCer3DNcMXMkPQl4WA8x4GgyxrHztf2/ZU86Y5ZVndQq7NJOIRD?=
 =?us-ascii?Q?mVs/dpSOA8dUkgjvvH67aQAjETXpxc6hlq2GEAZWHWNGZTkJ//bx7n4CSQjL?=
 =?us-ascii?Q?x1Il8q4/o0yLT7UgNHEXo9V/9s/+2ib9SEOPtZCEtxtLaWOUlzoF0+xT2Frs?=
 =?us-ascii?Q?GTMm4laRcbVi7xG2AkH8x9kGaGJBml13sLzj/HLs2NSIprnwz235GDaYjlT7?=
 =?us-ascii?Q?n+7UrIMLkChcR2loKmCYjVyMHZRliFkz1vbumnG3jsS8sXHVAkm+YLALknk2?=
 =?us-ascii?Q?Io+OCPmtwoDfkvAAXZkaeo09j/NljuIETJ89zp5lzKjhcq9bz59HL/AH7vDm?=
 =?us-ascii?Q?4nCmjmmBKwCc5SvVjzkl8fvjsEn7s6hJ3WvQ0Dk3jS7M7A/Zc9DBe/K3lw/l?=
 =?us-ascii?Q?t0PsL70QGqOW9G3h2cxK5sZZDEuas7JyPloadyC1/MTgvEqlRBSvYP+ScBJ9?=
 =?us-ascii?Q?N8XSM9LOKB19wjggjxo4g5UmjFlxm6g4JelCn53y7pAw5TqqQUd3lbHCX31z?=
 =?us-ascii?Q?c9Wy1cza3r0MUrid0RrEr5CKwGk9VE7CFcVJujqiAd51Nu7gRHZ1TC009y8f?=
 =?us-ascii?Q?Um2b/ZgV3LvlERasfNSROpgWWoOv9AcRuV229piSQI/D8+D8mYrGJpq1u12y?=
 =?us-ascii?Q?bDdjO1R7DQsIP+XD2zbjzF3I0q1BeO6xq28zvXxnpuiDwAiMJKSaohF1jyp3?=
 =?us-ascii?Q?Fpw/nFpCZw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8957f47-256d-4301-afc6-08da3d5c256b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 08:05:20.2946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jMDZ0hboGr17ob9BTiIuRIzbUK6d9NijylLdXymVONA+3q6pgWGCNb1PoCcKi1KY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6293
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
Changes since v1:
moved data type to include/linux/dma/imx-dma.h
---
 drivers/dma/imx-sdma.c      | 38 +++++++++++++++++++++++++++++--------
 include/linux/dma/imx-dma.h |  1 +
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 8535018ee7a2..e9b8b2e9f7c9 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -941,7 +941,10 @@ static irqreturn_t sdma_int_handler(int irq, void *dev_id)
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
@@ -1061,6 +1064,10 @@ static int sdma_get_pc(struct sdma_channel *sdmac,
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
@@ -1112,11 +1119,16 @@ static int sdma_load_context(struct sdma_channel *sdmac)
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
@@ -1488,7 +1500,7 @@ static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,
 	desc->sdmac = sdmac;
 	desc->num_bd = bds;
 
-	if (sdma_alloc_bd(desc))
+	if (bds && sdma_alloc_bd(desc))
 		goto err_desc_out;
 
 	/* No slave_config called in MEMCPY case, so do here */
@@ -1653,13 +1665,16 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
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
@@ -1676,6 +1691,9 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 		goto err_bd_out;
 	}
 
+	if (sdmac->peripheral_type == IMX_DMATYPE_HDMI)
+		return vchan_tx_prep(&sdmac->vc, &desc->vd, flags);
+
 	while (buf < buf_len) {
 		struct sdma_buffer_descriptor *bd = &desc->bd[i];
 		int param;
@@ -1736,6 +1754,10 @@ static int sdma_config_write(struct dma_chan *chan,
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
index 8887762360d4..ef72e00fb55e 100644
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
2.25.1

