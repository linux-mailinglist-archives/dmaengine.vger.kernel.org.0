Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4DD5A8B21
	for <lists+dmaengine@lfdr.de>; Thu,  1 Sep 2022 04:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbiIAB7m (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 31 Aug 2022 21:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbiIAB7l (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 31 Aug 2022 21:59:41 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50064.outbound.protection.outlook.com [40.107.5.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D823911CFBB;
        Wed, 31 Aug 2022 18:59:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nghxx9rGnrmGxEAue86vVEpOXJaRlDeGQaX1o+DPKDr3rCWSQaW2nZBrn4OodJM+W80fxTA96hCIHsT1Fe5g7u35IdAZ6cnxHqWTxxQ50lQtEZtyyetTHD+LzMJlMiH72ZAorsQsb5L6swgE1+vk1laGdd4IQ5kfI628dbvCtnJSNSk00b+b1KRO66oWpaqLK7i3WW5suBvmtq0Jax8Z/xCFS0NJGYIRS95ylEhS5B31n+iWv/UCPLv6OD20g7/13NjGZCCXmHH2MsXkFAiL2tc1YR2QfDDeMXNMWJgKTiVM7mrcyJomwy1lBQvYKigUjtm0QWPRhXWFg4QafXNujA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IT8qLsWtASgU+jrkmCjIv4P320Habx7fIb/JbroiA8E=;
 b=MDRjYAPpnExH1JDwZp575I8luiKZpEt+6hzWmn6b6dNPLLr9BOYOUlEJalTFoAbK/ODWbzsGO4e0bzo8wYLIUVLiBTLJGzlznoRB63H/hxA4y2sq7PGdVbnsgpFz2y29TQepOBkGR+1mCogJ4YKcdsh84gmtc4wrZpSabDxWD3UA3CNFRke+CRkO5OhkzKRxclt3aue6zQvzvO0qAYjDP80NSFmVnxqriixLdhRlWancsDIAYRZ5JKuSbcYffVqgXB+QWvfux9LKDAFv707siiScLxuBdjvroSSSweq6gx66MjS5aaiyHYtW67jCwLuNZxsj+ggOu1g9eBnOtBnTXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IT8qLsWtASgU+jrkmCjIv4P320Habx7fIb/JbroiA8E=;
 b=abr1r2Qne2raORuqtHuzaqp3anNfr8blz6ygAlbFBnZvXU8CUf1BFjV3V/vTdgnY7YLGW/SSSpb3v8NPFGolcQbfcTXXOCD/UK0cFuRvW70y205ymL7gnBpIAH5EQzEfx5aRLBEfzdI/Fy2Vadm5hcqifkDmnDgzpIMGMCVoKPA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by AS8PR04MB8724.eurprd04.prod.outlook.com (2603:10a6:20b:42b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Thu, 1 Sep
 2022 01:59:36 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::704a:fa82:a28e:d198]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::704a:fa82:a28e:d198%6]) with mapi id 15.20.5588.010; Thu, 1 Sep 2022
 01:59:36 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     krzysztof.kozlowski@linaro.org, vkoul@kernel.org
Cc:     shengjiu.wang@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 2/4] dmaengine: imx-sdma: support hdmi audio
Date:   Thu,  1 Sep 2022 10:00:59 +0800
Message-Id: <20220901020059.50099-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:3:18::22) To AM6PR04MB5925.eurprd04.prod.outlook.com
 (2603:10a6:20b:ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5abd72d5-4998-4dd7-66fe-08da8bbd9f30
X-MS-TrafficTypeDiagnostic: AS8PR04MB8724:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pnEB2zwbi94ibr1AAKo87IhxxMd+M4JGO57bSzM1PFCIpqt14/fQGmpOSDU63eHj6eddPla0HkjKICmu6h4Z7LA9ARAq2PeCWUULIgequKLu8v1BTQNB6BmHqC7xjYDGVXa6pR1H5e5h+Jjf1bwHKn8zhEjCCinDHWEtcu+fwaqBh6ryjjB4VLtOyt/1BQw70Em9hzp5ZvdQpUCQcl5sfaSsG8L3J1XVyfjTkhAwiQ3taeQLgdQyTQIuvmksYGCMLGfVQ83qka3PtYJO3+8ZNVhACWhlMXNcB1GNH9AKtdoYxPj255IBSiMSnteWfV0ONFRYSObtfpmbmUYCJ072FSD2N37EGF9FEIDHGPQ6/isA+br7c0/O+c5jvyrvOcK69ooWEERFkODNlYpI8r2rhaBniSxee1xOLZ3ENT1c59e+39irfDNa7thAjiDQ33RQXqboTv2+9cCg4TVfervZ0m9mL8I7FUKx6iz1pamt/DDhjUo7np8CQNxQOsf2a08fuizLYPYzlcdH+2aKcK0R7zhfGv5+fxc4Nm3xUR7c5ScJX6E1W1/8blB1sqTLkwcxrodAqN5sZWhs/DAAulQFMDUwBgBvmWoAzhwaFU0rb7/CtDNTetZMN6WsiG4GMGMHJibj54GsD6aJZtp20RZ1NPS7L3vRtMRYtsFjjO08hdjUWdo3Zls/Xvd6ETu6XWIINeGesb63bft8WltGjAaVbOE+dPB7sJNX1UQ1YL9CvbAXuhJA0oOIBgZB+USlINP8fGW0P4upk/DC8iDGlKH40Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(8936002)(4326008)(8676002)(66476007)(66556008)(66946007)(6486002)(478600001)(26005)(6512007)(2616005)(1076003)(83380400001)(186003)(6666004)(44832011)(5660300002)(86362001)(52116002)(2906002)(41300700001)(316002)(6506007)(36756003)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cKM3fKASlVr8i/fmtU+T6c1XsDmLhP2alC7tn8L+1AEbNq3SodT51qKy0+gf?=
 =?us-ascii?Q?R990QH3xl7s9D/9VQ2xw6CfU9BhSNE1Iz+txEYCsTnNi0KrRjbuIh0UZ2r7v?=
 =?us-ascii?Q?0S/CIr6OvqQauaVtZBhR4wI2Wc6UlG+iPnFPAvd/9bHEZDcXTc1TEMMQls42?=
 =?us-ascii?Q?5L05ISoD+JuZU5onCGdpIsgOc0sNZQCRKxwotohMxmdprzRf/31eDQTyUxX9?=
 =?us-ascii?Q?/WM9sps+9Nm0XPG2KtUlJljDcxKnGjU8L5Bc/Jm9JMCC4NMcX7oCkiaU0eAA?=
 =?us-ascii?Q?m0qxMXLuWlHuWTebV7EhkAs4fqQjT3RYWemIY1REZokEVyUBQCn7Z3ic0vEh?=
 =?us-ascii?Q?GaOpWmcDj/szjeyQFGAzp6p4SqNG4BtwY4tycmFcbSnZ17aRgI4jK6xHaEwT?=
 =?us-ascii?Q?xxFqUN1hy7rmhiaZ9uN5SzyQhVezxlBPQ4vyEiBmAuFMV8fFE0TnF6BpV4hV?=
 =?us-ascii?Q?QECPXkJSPXuhlRWUW0FfiBwdoA86NQAGJjLujQte4t5GUThRrc7Hor3xsQvf?=
 =?us-ascii?Q?cotlAizHPSHX4iNA1zAOu5EIomRDcVwJ/fRvrQiTNNQhkrIIzuLnNqniZUPM?=
 =?us-ascii?Q?ojzQ1w75sjQ716Ko3uIcoMWRF5Mu3XIsXvisOn/9FKGoIBucPKy88CdeQ6Cx?=
 =?us-ascii?Q?8n03CTzmQyEYK23d01bI5zb+Fdb/Il2c3bWi46JuG6utNCJOt5+7JsRPxheC?=
 =?us-ascii?Q?OphXgQlNDKuEmwyxMkkWrWGOoaCJfuEDKeh2W/rrS9MjosSE0W/QF5zQwh64?=
 =?us-ascii?Q?GhbL/UWq1v5s/TDt89iTHaH86VF9JD+RL0fB2rE3pjL/qevQPL+/ee2TuDJ+?=
 =?us-ascii?Q?TYlWvNCX/bFrF45mqkErCKZX7H3RJ9Ka4G/kcu8/vNgj/T1QX8Pr9EJBEMGC?=
 =?us-ascii?Q?WhkxCYYvO7iPCSw577UetJJdxgIQUZRzuBShZwNfe2GF2bLxgxwR55UHlCqD?=
 =?us-ascii?Q?W5Yx6N3L1V9kTykzYLWXVxAMj984rQe4vEjvELnxyxotte+76MSEk3cP4RAX?=
 =?us-ascii?Q?mugsJGq49ZM33R/WfWdj39s4XImtYrEK621xDiAV4ryOUfkQg7OPfKMnFUa4?=
 =?us-ascii?Q?grEGdZ5YroTQ7jc6VbiWKjEHrQW7R1uZP9/ieBCuJYT7edG1KU9sql6YejA8?=
 =?us-ascii?Q?Q7XqUOu2U4nAq8a9hNOMIF1516+tIln3GAo7QsUMFlymOE8rA8Wvsj41o6uQ?=
 =?us-ascii?Q?YAkbPf8jpy02wFvuTAM0sgxDYIklLag1qA/FKGP03vLO3yqFV5fjiqe6zM93?=
 =?us-ascii?Q?4S76Jj18U+zX9pLclpoijp0voh3gpUSK9JHZgbdIvybjjFlVMJBYWqTN/xM1?=
 =?us-ascii?Q?MnuQ1LwtD+kQGDABjReMjClSO0nCCc6L/oM+Ky+QlsStTJJ93LI/pq8/4+B4?=
 =?us-ascii?Q?YBkEVOLvrRUk3eqMb3D5uL/WhfQAhyGJKt023e0vMDTIbj116UXFqk2GygLm?=
 =?us-ascii?Q?k+Yy0hd2zYRU70Nq8g27+an9xlLIny73XP7+auG+Mi5luS85jpg6QceBMYnO?=
 =?us-ascii?Q?V4kzKezb2eTFJLIU/At+i6eAJPHAzTJmTF16pvY8d/XEXUI2PacMQcdJAYlH?=
 =?us-ascii?Q?+DwMaEoP5yKDYlWkeougeIO+iDJuTXIHauZ7aCSO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5abd72d5-4998-4dd7-66fe-08da8bbd9f30
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 01:59:36.4519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NybkBnC4Jp23MmHNvzGjyaJ+hL/pFsM1MJD5yDxeAHFlxvSjHip44N6hMW84/DGI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8724
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

