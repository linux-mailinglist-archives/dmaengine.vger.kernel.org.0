Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C555A620C
	for <lists+dmaengine@lfdr.de>; Tue, 30 Aug 2022 13:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiH3LgD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Aug 2022 07:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbiH3Lfe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 Aug 2022 07:35:34 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on20621.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaf::621])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B43FCA27;
        Tue, 30 Aug 2022 04:34:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6Z5QAffiH14fLVV044k6vduT6+3j32qRfPbivUS2dCpOFPlycox+nolRIZ2Guqrl7D+dLa2MSnm5jVCFVQnivn7LUBTOmxzWKs5knuSuNVzURFjHIJ1I4j4+orfAj/r9fEzYOkYyhYobW/QECmAaE7iq8AJDABdyZXfPwIKvJiN2/nhYCRjIauh9FNaJXculRxyf+ugIluYeslhpEW6oJZz7ZydM1YOuRPYy7nYMZLpCEgn6wA1eamFNl8CXBOpcHfcrIdTmpCCT9/I6dv6so0AdbxXHDWazC13I9/MUrMm8ECgOxYe/hAZ/snz/CNk7DfhlpZYSf16IHx7Wxnv6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IT8qLsWtASgU+jrkmCjIv4P320Habx7fIb/JbroiA8E=;
 b=d6XIXHJlQbKm/okjQW7751pvv/Y7mpJwE9bSGKdLhRPCWhNRgZ1UBejV3W83slkocgrlOTa8Wk2Y7Qx18uF7R+54cw1oOXK+2Dr0//FQiAIc8ldTaLyVGqwNGghpqyRyk4HG+ROL2ddwK3B4RcwPQg/yD/6wKovG65YUG0zqKGgsJyzCTmWXmWzr6ikpoEecsdl9U20LOz7sOORoe0pa/DuOwGhlzq0K4Yuwcb9wd9geqv8Zu6DCxYU7gOPC0FUMnCuAx6IRGdipSId/5baE6GB7asfMYtSmPjWoC755lfuIaJHm8ErZgtP5e07qNZDw7a+TdQVijUmmejSVWSQfXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IT8qLsWtASgU+jrkmCjIv4P320Habx7fIb/JbroiA8E=;
 b=Eq3RKkD1vN0Ll66A1A8xCzAaofap1rV/Q1bWBGpwSLTA+Uj/95MaiGWzWOhjrrXx2gpdjgJNKal5R+w7eD+NyzA5SUPdjZ/OX+AncnOXufRFePMec0fuLgikOF7fAxhPB9mTUpjJcG8mv6FIRKoEBGzu+dMdUGW3V88gongEaho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5936.eurprd04.prod.outlook.com (2603:10a6:803:e1::18)
 by VE1PR04MB6365.eurprd04.prod.outlook.com (2603:10a6:803:120::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 11:32:17 +0000
Received: from VI1PR04MB5936.eurprd04.prod.outlook.com
 ([fe80::41bc:4ee:98cf:efcb]) by VI1PR04MB5936.eurprd04.prod.outlook.com
 ([fe80::41bc:4ee:98cf:efcb%5]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 11:32:17 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     krzysztof.kozlowski@linaro.org, vkoul@kernel.org
Cc:     shengjiu.wang@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/2] dmaengine: imx-sdma: support hdmi audio
Date:   Tue, 30 Aug 2022 19:33:39 +0800
Message-Id: <20220830113339.1875760-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To VI1PR04MB5936.eurprd04.prod.outlook.com
 (2603:10a6:803:e1::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 123aaefe-015f-4f33-f579-08da8a7b4b0f
X-MS-TrafficTypeDiagnostic: VE1PR04MB6365:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KqBRLdza/ys8YOKKSbchJ1rSIuhz2ncLMwsXtfx9Qp4dVDx1fWA5Tr1FGxSmmRGm/E4ajJLJiUV2m/XrO3GmYBUFXUusCGhOXQxGFYnXIupWNlZ7FN3r2oT+qoJNhDiFaSH9gxOYwgW2fZI+VEDV1LtDWlhTuNzD+eaEGVAszEuYdrnv55qYJP/gZDkJS0kVduxSfBR/gHVIDCCEtCi36lWUFeiJrQFXYtq6efo9owRnaD61K95Xc8fVi+1O/O4eed2EHUBwmmKIT5F3b8VuUpTbkqIzWI0hIchCH4FLbxfmuVKxgao2w36XvKAAifMDN/X91ywwezuKEspfKDvts+8JhVupxqQLjmtDSS/tqAsN+eNflROoAvumSYGfImYbxaLnMvycJEPgMpjG3qcwtU0j3mcIyq6DYHpDWW2nqKYjVNT38vtR348GWTbI8J4xPdMe+IbsFgiSjfJnHLuagFKBKzoZc9ioOnqAYlYEPrut/5HYu+/pAcn1wUSo+ym2VIbso7602GRhvpyb7Fm6S6AwJvDJIlBmnsLCLw4z3FkFYnbBKEmGY6u0mmYI9xXGBCh04Idi+JdAGuYMsziLdOp1WGuV+/aTBAIR57fFZqZh/d3dLUloDIyl3R1xtk+neXTrOl0ph0cPV+1U/C/sz860dYc4tElYaVZ6IVfMXtLDi99ux/ux4GxvRjsN6v6UQwTwUmTPNIrbtHRxNdfIo3XbTotC1r2Q6f0qEH8EheDbHIxjcSEb1FXbkW436qzJu8ZOp0Hyy5WNH3dIRvDSfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5936.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(66946007)(66476007)(66556008)(8676002)(4326008)(6486002)(52116002)(6506007)(83380400001)(2906002)(8936002)(5660300002)(26005)(6512007)(478600001)(6666004)(44832011)(41300700001)(316002)(186003)(2616005)(86362001)(1076003)(36756003)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4Ec94Dg/XdOhJoMJ6VuhTnnuULNnslFQkvPCTiDw5qAgNQiC5WLMIYoQgAPW?=
 =?us-ascii?Q?5YuDOOlxLsRBbXszWr+ncqmNKrdmrax1+tDHlU8xRUG5VwkjN2KGgokW6TQT?=
 =?us-ascii?Q?El4L4J8iCx29FzaLdR4ijIIPDeeM1jxDQ8n1wrZVMPeZrEpwAKbl/wQoL+gh?=
 =?us-ascii?Q?z4yJwni62s62i7TVnZIatcMiPHpPfR2BxXdhTElWv2S51qe55pWoRWby/2xo?=
 =?us-ascii?Q?Kk4fr96xYZzO7GOUVslJZmzAxvmHfWeUTdiKGb0xgDMw7S1cfJV/0xRxoUvI?=
 =?us-ascii?Q?Hk9SMbzbJG37pJOQBzwiVXWkYWtqbbI3Vd9dDI7Drhk67nZgx+3qEwYPbTcG?=
 =?us-ascii?Q?yqcXu3xHWqZ8tTKsky7U4NsscLRfHE6PzlxrO8rWExR8/thsT8fYEOffFnEi?=
 =?us-ascii?Q?3dTBTo3SjMn4KiOJSZGMwk/GwnhQcviyQOb4TlVFAtgoW9rUo+vjxNgHOlpl?=
 =?us-ascii?Q?j5xSis6W1r8OR3wCBnXfpJcDBa78icmxHauPGD/dy8UOvFfcet5xj/915Ev4?=
 =?us-ascii?Q?k7dDvf/J0I1mWTyPHi6SDxfbYKxF+a3YE3RXRmCt2W6VwRdQfz/xE6tnFvcE?=
 =?us-ascii?Q?hkk+yjlpJSPdSdQs2XGI2CJgYjiZ5iIXIZX8GUyW1sS2rwPFK7NAVAffOVIK?=
 =?us-ascii?Q?NUHOB5sfFLTzTaj+VgcAJajmDt7IE3Mjeb3XW7sI5DfxSIxMPphA53d9igMY?=
 =?us-ascii?Q?mTaTdfg1fa+QdJSqcoFelZ8Ducr+Rhn3YVQSh9P3Yhs0UWRQIWoweaJzkW37?=
 =?us-ascii?Q?E0BB9kTblG7jAVcJphM104tYuv4jqud1HLlpo0TmEkoq24aMynvt6hAsl4+G?=
 =?us-ascii?Q?4HWP1GP6syjHdrAuCCtGQenPyy2X8uBu+s/P2zpRqNAHF6R8HMm7x5Eajq4U?=
 =?us-ascii?Q?o0bt4pfTRI4StfccxLQUKOixli/Bob/QzpzFDuPdORdDK6asdWTbpjmpLUoz?=
 =?us-ascii?Q?i9Xh6ZhAqRvxtDsaM2Kt7mcKxBw9Q9t5deAuEOh6PGeBslKXEM+WFPdV8T+v?=
 =?us-ascii?Q?jGMVHfs5SD8Rq32EcjppVSQUzRIwaXhWI7xrtm2rss4eFUPpIH61RZTdOum0?=
 =?us-ascii?Q?6FXqn7FjJ9iItm76bQzqi8/3f+EJYGUIK60e31FhWparymA351LmeciiFI6b?=
 =?us-ascii?Q?LFF0rcnouDO/237E0ao5rfknWC7k4R/emlWmyTVdMvGTaDUJki91WkGXxkuu?=
 =?us-ascii?Q?BWil0g5AOGXDgNfsYVf+TZbMZb+xVGuFsOJkB5iWRr5RYeqMQXVETenORxCq?=
 =?us-ascii?Q?F96ME7N+4ChU3GkVM+GZHmHGxoxyxdgjPbYF6+HTVtSEGNjw9o14o4ED8oB2?=
 =?us-ascii?Q?oKDbPWvKlazgpjxFe0T9iTmSGsolQs4K1lvoJS6YOMWjFQdMaJ25otc3ygbg?=
 =?us-ascii?Q?GInWGvv/2a+rdCQJklg7k5f0CeUwetomZDUnwQ0+OIBbeuJ+9+wEYzEGobZ9?=
 =?us-ascii?Q?9H6bxXacCgKN0xTYJX+7roomgm4GO7Adn5v4B5hK7XVFOEAroNquVe5pT6P+?=
 =?us-ascii?Q?pvcybasZxG9nhhhz94WYRSVWHOejlXLRQ8DCG/Rqv2ivDQ/BH+CtM3oXAie4?=
 =?us-ascii?Q?hUlv9ed/DAX8xmF/KVdLWowSChgJuqKg92uUzov6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 123aaefe-015f-4f33-f579-08da8a7b4b0f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5936.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 11:32:17.4262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1SDdE79VgPG5xcCsT85xj1QLTuJgaqA/aQBwC2G3LSIyiBghTlHalFIIeKLraqLP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6365
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no autolearn_force=no
        version=3.4.6
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

