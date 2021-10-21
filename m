Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31918435A3E
	for <lists+dmaengine@lfdr.de>; Thu, 21 Oct 2021 07:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbhJUFTX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Oct 2021 01:19:23 -0400
Received: from mail-am6eur05on2075.outbound.protection.outlook.com ([40.107.22.75]:24416
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229499AbhJUFTW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 21 Oct 2021 01:19:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGgz22HN+qCofgumc1M9S3wZXNCYs6dz60+N98qRlmIn/1dsAYy9AxW0CXHiZkdMom6Po0x2CnJPiyDNBzxpfNGrmz13VJ0edQqNz+16uuSqJC0lGUa+0UqXTRZzVs/WUGMg6zWYYEGj498R4ttwX6Q16sCgDZOyhAmXftq2yvYeBfw3Sn5U0CnEM8y/q/vBKIPdqJpAAKkPdMDxlujT+SP1sVQLnRdGdYXjpLNEUGXJ7UTonFGQpDlaGZ/bDUmdwPQQdG30/KXEx0z4eh5RjlM2QJAEcwvQORUcIDuEB/gxsTkJ1ZXBH04btrhoVtOivGhiRaxlOBV0MU2DNgdTsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4i7aaUEEnCFnneA3BUFW/AN3xbANpgU1ZUwb1MRIwVg=;
 b=KJeLg5RvxLDpGMLNKs/zP8EmK0S1438TPBeUZaJNSAIxGVrcwvIvCbLPIv5QQ9ZQGBlyyXAxp842UwZSKhoGnz7t18EMu03zC8O9Y4PdxHLXFaBDE2fAEyINTmJZBeqlhfNWyNDidHKoS0OnAGCRN30+CgBgUcUZyzJVHIUA2LopXFDVeECKszZ65M46qIuTljdWSwodcGvgiwiOCVI0FZn3ThjZIIymGppQo3D4H+eB0Cho8m4RlxthKiMMYwotcbbIRX5llq4D1/whg1Fk1erC446jiDAfurf/6YkggsFepQug7LT6IL4DNT2eIICi0YR5CSQ83EXKWU4shvyCCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4i7aaUEEnCFnneA3BUFW/AN3xbANpgU1ZUwb1MRIwVg=;
 b=Z1Crjf4lYBwo5glxC0ASA+T9m1eivPMwTdHJ/YPwAGCW5kmJvOX5NCSXJzUCcoj7NqQDTWezOsHA+pPUASYeUhUe3aVj7ve/6xtThrmYBGK7zEaN7BO3BkPp3+Q08P2I1pmZ9TeJR9TfZUmisCrlnHigPAqlBDqOwhu4V3xMFFM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7444.eurprd04.prod.outlook.com (2603:10a6:20b:1de::16)
 by AM9PR04MB8322.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Thu, 21 Oct
 2021 05:17:05 +0000
Received: from AM8PR04MB7444.eurprd04.prod.outlook.com
 ([fe80::6db3:208e:1a23:be9e]) by AM8PR04MB7444.eurprd04.prod.outlook.com
 ([fe80::6db3:208e:1a23:be9e%5]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 05:17:05 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     vkoul@kernel.org, yibin.gong@nxp.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dmaengine: imx-sdma: support hdmi audio
Date:   Thu, 21 Oct 2021 13:16:11 +0800
Message-Id: <20211021051611.3155385-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::17) To AM8PR04MB7444.eurprd04.prod.outlook.com
 (2603:10a6:20b:1de::16)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by SI2PR01CA0014.apcprd01.prod.exchangelabs.com (2603:1096:4:191::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend Transport; Thu, 21 Oct 2021 05:17:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a2fe10b-42bf-4fe5-3e07-08d994520554
X-MS-TrafficTypeDiagnostic: AM9PR04MB8322:
X-Microsoft-Antispam-PRVS: <AM9PR04MB8322B27EF3750CCF968FF717E1BF9@AM9PR04MB8322.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zq1zeyqixAsIo08VNd9Mzp4u52Qo0RlB64HT8PXU4nI6NI2uGSa5FmgKu5m449zG3e90wPdz3Z8+zkq+WfSrsFCsdKxz5rlvLGxiD/OJ6C7GKUO7IggwQPmR3mCN9gaFQkOJyVnn41CwRsazqMJnGW79064usd/b7a2iedQkN5fxofcMOKFcPwAs980TthF9fv5wz25xSHBwA7FzK+p9BzJ9SkwpgiPVe6s5r9udp6cXst4QbXDlDfoKpe+CONtmD8ZWhNQ/Q3pyfu43uJ1Mu89P3BcQ83ys6JEV84mdj/k+MhaajW23s/gVELs0QL3mqdgAlxKELZc+YnxHLqboYuHSeglBUu3KWPA66bk0wudwe9micFo5cJO7GeAsLQr7c6CdbNKEDphlSbg+1S4/mQVQbNBt9sYfSIap0/R/DHM2L1A9eEyl2FHdsS3cgX2pXyWH22WIi8hkJvv58PafvuoG+6dHwnebTRnJKWemz53r/4CBzTh9v8jusXZ1o0tUu3rEO0z5vF8wL6BJY95pWGVolNgIKmqmyEPjet/8WvztGNgn9Hn2cQul07l5HyHU33+nicSNzDX/et9BnKL0p//FhoEm07C3vKpCLVq8p02rvf2z7ada29SasL8wUDMU9wY4Wwdbtcglk9NbZRuehj2HYMJlNDzruabNhpmvYARtalPQKwN0kXE7picyp8Xhi68BuvOmikQBpN9lwB1mPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7444.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(38350700002)(83380400001)(316002)(36756003)(52116002)(2616005)(6506007)(66946007)(6666004)(956004)(38100700002)(26005)(86362001)(8676002)(6512007)(44832011)(6486002)(2906002)(4326008)(66476007)(5660300002)(1076003)(8936002)(66556008)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JLf7BvmiyRQ4NoohzkV8iqAxuZUfguHScLNO9HFiUpcxG7kDIJjdU9FD6tOK?=
 =?us-ascii?Q?GEeuOeKfUbJtjZdiEhOv/z5ZHIfiXOhQ3GHJ95y3yWXj7T7ftunxD9u5DVLj?=
 =?us-ascii?Q?xISjFroBo8oCGTyvA1qEe+IcsQk2A6JMemnUTaCLgq/QbQv4R4ca++bmXmUG?=
 =?us-ascii?Q?hbzfbiS6I47e6CSoQ/o7fg51vHcFCQ861jOFtvKH4JNB3anpRWp41EexZq1Z?=
 =?us-ascii?Q?M61iBNDmnFqaa+muXl1iOjCj+JTBAPhPklGhtPSqYk9qDGgy3t5IC21z/oAP?=
 =?us-ascii?Q?AhHHuv1bOFncXVbsU04PllzBq6iR4/LKKXZs1TyzxT/asEfLFonS8NxC0jBV?=
 =?us-ascii?Q?K3yuS/+gf8UiUj+h2kSmUCF/Rbz0rvhZXTx2TJjAxVH7WePePT4grMNAux8r?=
 =?us-ascii?Q?QupNo1MMgDtpQpt+UDiTiEFcrq18OMq3TlS8tOZ3D91k8IAB2vaxVOXXf96o?=
 =?us-ascii?Q?YLJBm9bclBRxlYalhwvqlDCQ8I1OzDWC9WJ724/J08hTZ6IixQaJaE/PA9v1?=
 =?us-ascii?Q?QZHTmG494Rgp+f5E0L+hFr8VetAQYk0K7NlV4M+Ak2gVyl4GjRFPLDBOClOh?=
 =?us-ascii?Q?Yy/6C5/OW/aNj8tmgXgdwL6Ank1mdI3yJ59c/KHd+RVfqayDjWe7BjcTdh+y?=
 =?us-ascii?Q?URx6i3ZfklEXU7uUXldS4dz0wnAA21Z65CQ61+Umi9FiZ/ryrgwaNKwAjB8m?=
 =?us-ascii?Q?22lpkt5/i32TOY5iyeJe+1f/ZVHA8sdS940WSRK11aN348+cKkIxbMfQZT6D?=
 =?us-ascii?Q?fDtO2N7g3fMh0v16RBPE91MRxv9c72XdP8l0fBvldujNsZwF21upgYjBcoVI?=
 =?us-ascii?Q?ZAiUJnhW09mD+sQtC4p1d2apyCSTef36oJ7RRpW8kVYjTU4qnGQYnRI/eQ2p?=
 =?us-ascii?Q?DWvV3yba6Nc6Hvw/mPkXwAh17jIwxFUBhi294mgWE5lCc5TSNKb3knYzsIzS?=
 =?us-ascii?Q?xISPEC4OuHGAad6jHZH95TIYE/0jn0XB/LDDd0X9/ErMoqOul6bvKdcIwMb2?=
 =?us-ascii?Q?2cQ7fekrizXtk5eQ4xgBuBvKzrabZlMpngt0mu5GkZkp7iBUyCQcamg0hYKa?=
 =?us-ascii?Q?SMMhvawMHjdOM+6UA7MyqJDxz+nxUICeYrgravO5M3TnGdb6GB4cMohhe5n5?=
 =?us-ascii?Q?WkanoLY/dUHsrAtBJ/PV2JEO93h8ws7CNzaqFEidtsM3DGPLdJ3LGxEqZ6oN?=
 =?us-ascii?Q?oPeLpbUe8UZor3KIuaLVGzjkfbujEncyXswcEhiZ3H6DCQcv8VxO7Z6wnOp0?=
 =?us-ascii?Q?uHm6P2qiziQhaCvVawXu8ubFhQ1yfi+RX1KUA6F27MQfHoFaBmXwS2xswu39?=
 =?us-ascii?Q?9BjBZgDNojq6doPBJQpP32i3obMkSfuHR2N26lAwvrc6F5MaPvxiuB6NeEQ9?=
 =?us-ascii?Q?wShFDQdkTfMQG/8teDUzfjMgjExJfcqamjnSmoV0wLFwu0D0Q4fN0PbrYGKl?=
 =?us-ascii?Q?5aaTAghEsjU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2fe10b-42bf-4fe5-3e07-08d994520554
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7444.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 05:17:04.9263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: joy.zou@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8322
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add hdmi audio support in sdma.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
 drivers/dma/imx-sdma.c                | 38 +++++++++++++++++++++------
 include/linux/platform_data/dma-imx.h |  1 +
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index cacc725ca545..3a0e408f7741 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -907,7 +907,10 @@ static irqreturn_t sdma_int_handler(int irq, void *dev_id)
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
@@ -1023,6 +1026,10 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
 	case IMX_DMATYPE_IPU_MEMORY:
 		emi_2_per = sdma->script_addrs->ext_mem_2_ipu_addr;
 		break;
+	case IMX_DMATYPE_HDMI:
+		emi_2_per = sdma->script_addrs->hdmi_dma_addr;
+		sdmac->is_ram_script = true;
+		break;
 	default:
 		break;
 	}
@@ -1070,11 +1077,16 @@ static int sdma_load_context(struct sdma_channel *sdmac)
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
@@ -1420,7 +1432,7 @@ static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,
 	desc->sdmac = sdmac;
 	desc->num_bd = bds;
 
-	if (sdma_alloc_bd(desc))
+	if (bds && sdma_alloc_bd(desc))
 		goto err_desc_out;
 
 	/* No slave_config called in MEMCPY case, so do here */
@@ -1585,13 +1597,16 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
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
@@ -1608,6 +1623,9 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 		goto err_bd_out;
 	}
 
+	if (sdmac->peripheral_type == IMX_DMATYPE_HDMI)
+		return vchan_tx_prep(&sdmac->vc, &desc->vd, flags);
+
 	while (buf < buf_len) {
 		struct sdma_buffer_descriptor *bd = &desc->bd[i];
 		int param;
@@ -1668,6 +1686,10 @@ static int sdma_config_write(struct dma_chan *chan,
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
diff --git a/include/linux/platform_data/dma-imx.h b/include/linux/platform_data/dma-imx.h
index 281adbb26e6b..29ac21d40f28 100644
--- a/include/linux/platform_data/dma-imx.h
+++ b/include/linux/platform_data/dma-imx.h
@@ -39,6 +39,7 @@ enum sdma_peripheral_type {
 	IMX_DMATYPE_SSI_DUAL,	/* SSI Dual FIFO */
 	IMX_DMATYPE_ASRC_SP,	/* Shared ASRC */
 	IMX_DMATYPE_SAI,	/* SAI */
+	IMX_DMATYPE_HDMI,	/* HDMI Audio */
 };
 
 enum imx_dma_prio {
-- 
2.25.1

