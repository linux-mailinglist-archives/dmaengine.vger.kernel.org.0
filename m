Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2023860C692
	for <lists+dmaengine@lfdr.de>; Tue, 25 Oct 2022 10:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbiJYIf3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Oct 2022 04:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbiJYIfY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 25 Oct 2022 04:35:24 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130075.outbound.protection.outlook.com [40.107.13.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C040B8C2F;
        Tue, 25 Oct 2022 01:35:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BE438h8D31rNF5R0iCEYFRM1U+8twoaFaHgGcryAd5cJ9l2OTF49//3nsg3N2HMA2YK91c2DFlQrIUf7uZuw+0XTqOVekbabhYsKNHmAk88I1aFddqWQ8fZ3/TWNvAc5O/8ifqQgcarxb17ZiT1FUh0WDcN3TBWQBq99haqIuiOvfjQ0VKXmgjnKrossIquapVSXhfIO771Di7tRcbiabI/eh3WpXdbn2yJ0s/A0Nemwh0iN2jUk2l5SnMv2ZSawe0qaKT5RoLdTqEjgQ72owFohbjnWvBjL9n9AzdR8GO15u6+bCTPDEBq5jXC3ULn/FFu2M9nnYlezr1cC5fThjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNh9RhNK+gVdolc8RfOujvV7bD1ZX6aurSU8CsL7YAc=;
 b=X6cwQ4Gw6qrfmrh/6bieduvQl0HFFAdpYkkVQStyADwCEbrF2evasilQMF2nhBLZWD6NHQ8F3zTTgPRtSR1dyiIcrOfbYOouieSLIHMOHs4Yo7IrneFZYrWpgbxbsKE47RU+CUwlnrBgSWgksdxfQYcjli0HGyQx2jJU7kDOa8WVHSpASeaIskxve0BMxhbqX+IXsEyCC82BvkShMBsrA2wCl8eVlI+Rz/K0HB3oLFPJOV5eLDvpU3fc/OchgWWJw1IQiXgXkb2jFCgeu6TiiKufPjAY8eXQOp/PV3BUAxAtwnf7khFJnNBLqJ9mMQZo4TNlygBfgkrDTLhCpEfK/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNh9RhNK+gVdolc8RfOujvV7bD1ZX6aurSU8CsL7YAc=;
 b=f2vyuDGRLHQEAFFBxsQY4IlYurv3bwB09F8JL6ejB1xdlE1E2y/HuBFGhR6kOSc5lKXFUrcfLgjDTFpHT/rItEWX53Be0WXB/uEL48KRACdIVoO1N1fvI+/snVvBqe3WkkgREBpL9pJ2Mq1pCsTVzXfZJ2GsSy64cACyMi5pjVU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 08:35:19 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::7a34:469:fd53:922c]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::7a34:469:fd53:922c%7]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 08:35:19 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Cc:     shengjiu.wang@nxp.com, martink@posteo.de, dev@lynxeye.de,
        alexander.stein@ew.tq-group.com, peng.fan@nxp.com, david@ixit.cz,
        aford173@gmail.com, hongxing.zhu@nxp.com, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/2] dmaengine: imx-sdma: support hdmi in sdma
Date:   Tue, 25 Oct 2022 16:36:09 +0800
Message-Id: <20221025083609.2129260-3-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221025083609.2129260-1-joy.zou@nxp.com>
References: <20221025083609.2129260-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0061.apcprd02.prod.outlook.com
 (2603:1096:4:54::25) To AM6PR04MB5925.eurprd04.prod.outlook.com
 (2603:10a6:20b:ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5925:EE_|DBBPR04MB7737:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d7ee84b-e53e-472e-e350-08dab663d96c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d18zTHBehdkAgu9t2hxF0TDTEEutBGhll1pMUKTSQRooXbh8IxTkO30tc0JMdEaeuNeW3DzAckiSUayfhndmGj/lxwD+fm7GRnxlpZqvpHloeod3w9jS1wydPyEqiTu9NzH/WN1Y1ajffRRaTDMuEe6cwaJsXC5SRK3tU7dmMweeX8slZQ9dOdbD6BTHh0YW1G0hFxr+zKotpBwj9pXdU87Kpm92BbXtapzVV8vrIVFHp7X0aR3/xekglvzEFVNNG3l78sn7KjznP9b4nXM8GtZPWsKjhpVQJikMpGev/xDNi+PUKYsAIm3ktmMSt7BuNOZq6L08NlkbPCFyQcGY2uiX6+r8SQwJOY+Vo2dXyt/+np3uPq8RGJJcuzD6FiqP1rmdWw1mR8HYvX3Vwci9qFS6sYzcbZ/eeYS9OGGd7B8+PLNnEN/8WogZrmy49aDyMNWmkCv/bGBxnUPZ7URZ28ETjZ2nYP4YxYHPcAeWjlS5RgymfiN2PU1zaT4X/j8LSXo5s9A02iXcCbrDK5A1QBgf/cwCumKZ0RaDRbSKSNpamlxuxZ7s5Pk82PVz2tIM57CDeOqtfNUebovxT3Cm7UdXIfsSHs+AyKsJV/U1lf//GYDWSqVLjK8X+OCE8emTNE19uTweuqlv23W2ePleNDEy3HgSC2vjvyAhdgoMEAxHgcqT7Ya0Vybqm6DutZMdLHtBQiO1T951vei0YTa5C5zwXIlUkpA2iM9t6G6HdXjLp+tkYtfbCQI+HTnPeTiDpHI0wu7yF0knF7wVzEsZbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(451199015)(478600001)(6666004)(52116002)(44832011)(2906002)(4326008)(8676002)(6506007)(26005)(6512007)(316002)(38350700002)(7416002)(38100700002)(8936002)(66556008)(66476007)(5660300002)(66946007)(41300700001)(6486002)(36756003)(1076003)(2616005)(83380400001)(186003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jBncPL1U8SKnEJ3rDf8KKYREQr/Cbgnkym7RcE0TZzBTuNsjUI2AgZ8pPupq?=
 =?us-ascii?Q?oCdSzbAXT0xwaBQCsX4zCXg4o13TY/FoiOokCUYTHiWV04gq9CBr1Bh9nugO?=
 =?us-ascii?Q?CBeZgOUY0cs7r0akKtw3I4brF3A1bIhUmduQxU2oU8j9GD7zSSrsHa2PZqym?=
 =?us-ascii?Q?IQsgQmV0L1jmKMC+szoIleYz4EYOoG2td+q9w96a403TUsRO3ZJVHr0eutaD?=
 =?us-ascii?Q?AYsl9BAwdQkYdIXg9adCUyzZTT7pNgHl9Mh2QsOLI0+hTfmBQcZBU57/DmE6?=
 =?us-ascii?Q?VmHYNDBWDozDSYkiB7EF2zzQ1d2ffhimLOKZ9n8My9qVpz1S1hLVd2Pqz5mr?=
 =?us-ascii?Q?XalUdwS8iQiLu+TR/YcaqO3o9wVWald/zjyRVCXbQ16tr0WBKRsEr3rJXp6Q?=
 =?us-ascii?Q?LCsuLueltREZtN7JbQHLcMJI6IePFS1AzdY8IfD30jTZ/oUaxUso4STE5dQQ?=
 =?us-ascii?Q?cm0unYEd8MlgU4H8gp0UcuEAhbkZKHLpD4VSOrGgMw6rggjMawXsj+t0JmW0?=
 =?us-ascii?Q?zXPZMstljGSyY9BOSRPIemyvWuueTsYpTlej60wtG9t6QssmlSRL4O9kPuF0?=
 =?us-ascii?Q?ONrhHNYCc/SsQBfS0T5IA6H2m/uuM9p5CTY7OPstx7E47yNBiBlV2Jes2A/B?=
 =?us-ascii?Q?+DVtknyn/ok7D7z8816CV5Hv88rXtK8k3TL/41z5rgussLeYRlfW0C/TR1Ea?=
 =?us-ascii?Q?1eJbxKSFW9afgy5kQyzS0Enjj2WV/ihhjzxjKGGxMwkrY0YtiFkkSSTu8Sys?=
 =?us-ascii?Q?yWDtQsBVIHEF6ZeaawwxHEa0N+gDGv2XZvLfIpgVE3OLkZ523y9aw28X2BaZ?=
 =?us-ascii?Q?6H6hgr8aU65RtIOgRGuSUuRV+orSZvIWdQ16j//5ga7oC6l0Fu0XENbXLAOi?=
 =?us-ascii?Q?IA58QfZxMpH0N3n8FgLJVowEQOItUiNP+A2kzZSPJbwTcWyxGYlvqA8Mleba?=
 =?us-ascii?Q?7SqLFSCj0r9k4At+O4dm3NFM1mBtrFZwBgR+eT9SEGdSxNWXCJv3W2j+Vc3f?=
 =?us-ascii?Q?KOcCVAJLKj6E/nJrigfGk7JVHmuC7efLMN1QiowTLXDBKrQQGEJQH67bkjix?=
 =?us-ascii?Q?3sqClD7w6JSBtbtSLfmTbo2h4Odb2SK3dvtD91sxQxezwYbGQXXuKXSjcM/z?=
 =?us-ascii?Q?Bi3ZujIpq9Cn71IsjFbUJqKrsTvFDh6vAjiKJLca65AhUrnH62d05amuQW44?=
 =?us-ascii?Q?97gy49Elb5Im+HFme0wQIvLuTeyqDYUWZj7EnWOpdlQHptswOV7UACECeLvi?=
 =?us-ascii?Q?XcVt0pI8UptNrb4IKeyjMavgR3lE+FNV9r4jrVUxVZtR2DotmFtSRi6GLHRm?=
 =?us-ascii?Q?gsB/gbf8GNuk7x8cGghbpQPc77gIRimChqfFwl5019mupCoHAyTpHJYhA5+c?=
 =?us-ascii?Q?dvFCEf8qeUJ7QYNuycQHJUbxeI7Gjw/Uvjr0OPlSBfDNeZds2lr940PQ/csB?=
 =?us-ascii?Q?0JE1pMrfgt1ZNCVlrLG1nuEdZFtQiDCOVUMkaniCfHVaBhTbOfi7fwpzUwvk?=
 =?us-ascii?Q?LSA4tzd3MC2gqrv7gvNtcE3H9nYJGiQvJ+pBhyV5kJKPJFlRig6uP4zLrsvH?=
 =?us-ascii?Q?4jI3kejdUEbespqq2rzBCZEyHiER7J/o/kELFZAl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d7ee84b-e53e-472e-e350-08dab663d96c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 08:35:19.4812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /vjeW8ua7uzkxebb0jMYi4T2NFHjPo0HarwizVMROoIuStqV8S9+XGDaFZ3d5v2P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7737
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
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

