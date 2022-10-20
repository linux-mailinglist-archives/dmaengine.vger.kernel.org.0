Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D66605BF5
	for <lists+dmaengine@lfdr.de>; Thu, 20 Oct 2022 12:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiJTKPo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Oct 2022 06:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiJTKPl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Oct 2022 06:15:41 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2062.outbound.protection.outlook.com [40.107.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5CF187098;
        Thu, 20 Oct 2022 03:15:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+vzI5fJCR5gmxCcfI/vLDsHdSeZkuPI/CJJfyxv8YvA0r9jNmKN88FDgXFoIE4d9QCOIublYNNdYVPwrexJRWLStH84aFZ5ciOno6RqsH/bZvRq1R4gj/s97UGWs6YwzC7PTi5aI8RYhxA/J5seKSk+WkYBj+UM/VdAPX1XW+ZAC8D4YDoIj9YkAWDFJTkSzR1F30UNTQC6M1vUNGUOTBoahYyR+od8Lye4kyPxOpa1zpAPJL7CLtnBq0x2CeLjgMrkuyh+2JiX8kgMBVAyn8CDuHseuxprXFsBmaeU3eCdMdZdHUL62xKJyPJZWb2jYkGq8v7UpkRRV6+Bco4e0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNh9RhNK+gVdolc8RfOujvV7bD1ZX6aurSU8CsL7YAc=;
 b=Epr110UcLqTxBUx5HGjb4YS5f1GLzkmC/T8rnRaWFf4BYv0zF2daOM9c17bUI+i/y4hpq4sxcbcz4TnXyaNEqFLW9FghNQWtf0b6AcXCuzgaCokup/sYZttldMtMRc7BWTzQIOykkk1hpnWP4INsAVcawOnUr7cuVwHUYup4elOKaJvek8gtuf95sb9UEemL3ZzQlTC5JN+esEVX0bUfMjWjOOopD2QO2MF8e+s/HACZyRk41oEGsfYuNkDkuSN383f/XYONYIT8p+v4pfhhrc7LwmhyaQf+2FTN1TM/xR3HZbYaoy2SQmu4DomD0uA4tNTy+ICV0hGtBydGqY1l6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNh9RhNK+gVdolc8RfOujvV7bD1ZX6aurSU8CsL7YAc=;
 b=W9Ockqgx/bgi9lgNkpN1WjLOliVqVvDWoCd//wzkwkH/2AOXF3OXhe7F0QAN/k4guLGmcKC8xBWOdQ4qf/FcehF3bdptcoVm3Ko7H2UhNvgxww0Cs8H6eh7DpLF7Yy77QvOX1VRQH7iSGXBM8tjf42scBsJNecy0p95w16y/6V4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by AM7PR04MB7143.eurprd04.prod.outlook.com (2603:10a6:20b:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 20 Oct
 2022 10:15:34 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::7a34:469:fd53:922c]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::7a34:469:fd53:922c%7]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 10:15:34 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Cc:     shengjiu.wang@nxp.com, martink@posteo.de, dev@lynxeye.de,
        alexander.stein@ew.tq-group.com, peng.fan@nxp.com, david@ixit.cz,
        aford173@gmail.com, hongxing.zhu@nxp.com, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/2] dmaengine: imx-sdma: support hdmi in sdma
Date:   Thu, 20 Oct 2022 18:14:02 +0800
Message-Id: <20221020101402.1856818-3-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221020101402.1856818-1-joy.zou@nxp.com>
References: <20221020101402.1856818-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::15) To AM6PR04MB5925.eurprd04.prod.outlook.com
 (2603:10a6:20b:ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5925:EE_|AM7PR04MB7143:EE_
X-MS-Office365-Filtering-Correlation-Id: 2da5b376-58d0-4583-4e3d-08dab28406c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WaCbg6Zzs0GuQuIA7u+y75dCy/+SMG3LwWOcEDO6QXidok7lL9KIOTxrVFSPy//y7brnVfpxHoo2OTcP/2c63OT916oC34cN1xOlbYH2liXH7pPNXlo42Od/H2x+bZLVjbHrc1qMzNVxL+RFCdLYriUSOi02Plq7YC9cgB08sT48ilxYeybm4qFayWpiEaLsXGcZqr0zV26Gs3GdfTJ9sCj4vjvVJzTP/CEtAAHCJXBMT8OSZ9OfmTfyPjW/lL+XfgsrZ+JT4nAPMEswOKdPto6owwIlxjBiLFZp6Hxxt2CWlqXkYJuexDnuJ2qVjSbrkgb3dRKy4spP48Ui0seFvxU92YjIegcLnPoRmJlQMsuyI7Zj3UJIZ0wk6DhDfEih71aDfTSPspdF0E57KMzppFfMOv/2CY8chipvjPE1oCWnXFEBSa/e0ew/jIWIMUaJcTL7fv2TGHaWlBfv8YowiBCvR2e0C7xSmz4SH+CEVEduJ4LyNaism5Xd5pBonkGWI3zGLaS5k9GQnCD5QhN+H+kEZIOnvHT7U0hk4mqP5DBxiZaf7OpzsqbFtAERsZVrux4fVdeINEhhOu+nAPbLJLCEqo7HW61OVC9MQ15AdhyolxAU6AmpZXhBrRjM9SjUeMvf6dyl2EOwo2KzkBczrtmnpqcNPqY9wVikEohIB77dar6gYwejeB6RMcZjMK/F8A4wBFwSQiVkD5SYICETVGGwk7XoflP8wXtkkzdjJa2BuJcBMhq9XWNnUuD2XwaIC3THBQa7J6+B5MSEf2xk1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(451199015)(186003)(2616005)(6666004)(52116002)(1076003)(6506007)(66556008)(316002)(26005)(83380400001)(44832011)(6512007)(5660300002)(8676002)(478600001)(41300700001)(66476007)(4326008)(8936002)(2906002)(6486002)(66946007)(7416002)(86362001)(36756003)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fybAhuyPAWC6lNJ4Py1xF/leoaxLMNOZnw0OIb+T2Vf5sSYi4JnmImaHBM2g?=
 =?us-ascii?Q?EnHX+a+jJPFNr2EtcvoOQPElMPJTlaUjoQrxiTuBsI4mqUQT/lrbXJ5wZWyL?=
 =?us-ascii?Q?DKkB7FFiATbnwR7W3KLi9VggYboLdRGbmJnuBpEWyW6rpdGjP77jbO014QLc?=
 =?us-ascii?Q?FtBJNFQnhqgR+/fGOlrqyqJgw88RKDJS2wtgl0Ca0JT2rAr8JawloN+A2DYi?=
 =?us-ascii?Q?sQidZydCSBMPr+BA95ulBA8Z9xIQt6864SQch7cC27ZHgbJM2/sexyMsGJgz?=
 =?us-ascii?Q?9jVHKOBcwUVRJut3NFCZUjWM7xyGsLP7r3hdq0DHM8o6jv7nzCehJ9SAYfc/?=
 =?us-ascii?Q?IYQDW6DeicbALZOjU9P9NaY9Au+QVgheGPxMM1GFGKkpAcnzBC0VmMFNV4yv?=
 =?us-ascii?Q?xxYBkf/sxSLU5W2iNPU8FRKtFP0Onb8kE2ZTZknKMQ9yVm+x6F89dpk/FM8W?=
 =?us-ascii?Q?pSKJ2wsXKdaI72IB0RbU9hXCOHe1aMETppA23PNrgNZ0bhaU77AgqWSu27pH?=
 =?us-ascii?Q?4MKb7h/sXfu1FXX+0HbSBtRsctWF+UalEOZ2tcwhoVxrX/vWjBoRdvdKiwNO?=
 =?us-ascii?Q?o6Xr7JdBRHzeXYTmxAzgH8TcL27P8Jd5t3RinBmEk5M4uArYq4YEGVkUBDah?=
 =?us-ascii?Q?4oo6g9VG/1UczKSXURavcW9PFm9Op4X65ybgDepkkuEiFOxu4tPHYur5jDQ7?=
 =?us-ascii?Q?UaYoiO33bjIyjzESUYr2Y9wStltz8jJi2jQZP8XLuiAejUUPQh42WnMZc8Yh?=
 =?us-ascii?Q?gNR0NXeuhy6IpT486iYIGRXACmlH3ll/Xg6H7FPdjbeane9INM6xkIbKpD/q?=
 =?us-ascii?Q?in+ZdEP2VmVMsUrJDdxzBta8gDvIkb/lAsTOAR8o5v559VC1Ep/MiIhXwFLg?=
 =?us-ascii?Q?X4htkwsatfORBtZYXufIr/PjztzFFVVGI1n06c3P94RMipGAKbDrkoH0aI7T?=
 =?us-ascii?Q?dTSEME2vOzIvFglcB9GMeo4Ne13JT9XKFhwHvqx42uE/TIFYxWqt5onelWhT?=
 =?us-ascii?Q?IVOb/T+SAchjHhX+aGv5NUttDDQqtaJoUtLJHxb10T8mVDbgQ9KG6Cu7uypi?=
 =?us-ascii?Q?vNmGH2tcdWug8UIOWIGxSIJrejjbJKak7aafi84lEdrl5qvuFC+e4iE3bgD7?=
 =?us-ascii?Q?mgRV/yx1Kg5X0OsmmTi+tWTjoaQ2vxWC0HCRy0FnehpEwaPc92+bpQTErbbJ?=
 =?us-ascii?Q?iipgQdJROnUWSiMQEdgsYFFtDCpZ6Idd6qOqyUEmDsGa1PoxL8dSGaFutSdd?=
 =?us-ascii?Q?8x/667ojtpO9sSTMFk8TUYy6g4aMm9+96TdT8/8sjhzDTmvGGCl+iq027TuI?=
 =?us-ascii?Q?zZGfJ0QwbqKjQBH3bT227wMkhx/7DFAYph5d67vV6EAGqdO61LYE/vd0Wk74?=
 =?us-ascii?Q?KacntyUgG1kkqyY0ahpqU8VOwHydXYr7IqXjrumG6QW+ZPiR45feteD68Qns?=
 =?us-ascii?Q?p9m3mnkL+k31F7q9DwvfzqgHthrlChhSMCFFXC9sBVpkcsXGU+sMRWgzI29/?=
 =?us-ascii?Q?QWNDoWpbHOAuoTeEdrtCAuZFNNEpc1pEr2VIyS1dyiN/53s/RA+cEWr4R5yz?=
 =?us-ascii?Q?J4yYn7kBIc+FImAvSDNIjKmSyOKO9rzW+xWhbYRJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da5b376-58d0-4583-4e3d-08dab28406c1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 10:15:34.6667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rbpLKuJ97OnljC4dBtRMUxYYZAfW1Z1iioeusN7Gj3e6tkbachY6z6L6LUdpKW0G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
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

