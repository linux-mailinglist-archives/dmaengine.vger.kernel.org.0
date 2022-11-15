Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A390462947F
	for <lists+dmaengine@lfdr.de>; Tue, 15 Nov 2022 10:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiKOJh0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Nov 2022 04:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbiKOJhY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Nov 2022 04:37:24 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70074.outbound.protection.outlook.com [40.107.7.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1F917428;
        Tue, 15 Nov 2022 01:37:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDIAxhndZrDOIxRVj/EpAK9FKK9/MM5LKlWhdmRzVwExir3x2VOnaEA1AW5XRGkvREAz6jOxYJdira8m9pjsdi+0N/36NZDxpBj/58B7+IQ1gLlNoplL81GYftmw4JJGvPbc/XXDJVuHXZO9hHO2SBp3ui64fA79jXeF2s8xIxVagKHT3rLMWHxOPXsG5PaXqvwvAWHP8Pnxys4Ahxn/HfsZMxOUg8Z1M4dESl/zw+cYOtRD5He9m5Iwt5nynqFppgd3knTaWmHOqNstOFHtk9BAb9CiQ3YF37bmPmisRx27qZcL6fpBbeKp/8Af1oQRyWGZpyPKGzuW2dTw7n3uCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNh9RhNK+gVdolc8RfOujvV7bD1ZX6aurSU8CsL7YAc=;
 b=ogOd9B2Gz/T/xHmB3PU8raH0qC0IrCsEJaQm6CxhqMcK1D493y1hMKRjHlGBv+GTiADfSGmBo/3Cz9LIuMs8JfSyV7O9ULgF0hD4tT2EYa9FlJtQ26ABikUfGWL/dJ3V8HNYY9JFKe7Myfz/+taAcrBwtyUqizWqYcU2h1dHD5MlWRS1f8ZXct3ZtepisfAUMUXaAlaXTpYuAxW9uGpVQmFG1eX2w/qQ8IySSiK7TGgI7zVUzS8nLSOos66BIvm6cJxOgGwON+PncA/7e9+ubLDqLU+nVRCuNMu7S+GnMyXhraXEZCYukIUMf7nsslSqhj5NDbCWa9V5+q0Rzlf07Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNh9RhNK+gVdolc8RfOujvV7bD1ZX6aurSU8CsL7YAc=;
 b=VdPQqBXh/GCD6JH2E/XB/3C+6oUUbjoAuNEUjyJ2yU6LESCYh2gg/IuFX6V9GK/qpjaEnK0SOlKTxZyiQN6y9csY63VG9NXFwac+mVVYsfoayQ8IqNi3GCgFppOmacE6EecwkSahJwFi7uwAdhyZxYejk1NOeu8VHOXJfihB5vA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by PA4PR04MB9462.eurprd04.prod.outlook.com (2603:10a6:102:2aa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 09:37:19 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::7a34:469:fd53:922c]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::7a34:469:fd53:922c%7]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 09:37:19 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Cc:     shengjiu.wang@nxp.com, martink@posteo.de, dev@lynxeye.de,
        alexander.stein@ew.tq-group.com, peng.fan@nxp.com, david@ixit.cz,
        aford173@gmail.com, hongxing.zhu@nxp.com, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 2/2] dmaengine: imx-sdma: support hdmi in sdma
Date:   Tue, 15 Nov 2022 17:38:23 +0800
Message-Id: <20221115093823.2879128-3-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221115093823.2879128-1-joy.zou@nxp.com>
References: <20221115093823.2879128-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0017.APCP153.PROD.OUTLOOK.COM (2603:1096::27) To
 AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5925:EE_|PA4PR04MB9462:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c536565-aa0f-44bb-c15d-08dac6ecfd93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qd21CLnqaqVQtTTHP4RHxBkOkU168mieaDlCFr36xjIdngJnxZUWibVc7eYUv+VHnMZpRYc3MVx5IghYONQlRSLIbOkev6M2PDJCSU9LOm7f7bZFjAielmalaL0E6+RkWK/Z6WdkCvpZlTKgRhlcp9FDhPVa4Dz/f/bg506SkhLbKnBBLEC3Q3f5wS4TBSrX2g1zcBlkAwIjCJmiHJsE5V9Cf1S/8ye3tMHtc2zRDoRnu+fIw7397YNc2eJMax4YDcsO+qxH5ke2le+xcwUzO7EasEwb7UkNl0/oxl+Mp424kLNi+Hq+Vfv7fMlHsQ87UoR8Nso6cFdhH1fmoaoCnCN7/79OugDOwqCeWeCipBTt6a6T4LM3egnQZ5u6ncLARBwUn6/bbaCsTiRWuwPZa6vtsBznBtug0tYaDWfd7REKgPZDQiMl4MRuuKmue5EI7MXwg6Fftyi1FTadO3CoE7iWwcvizKclmUb4W/SfXGepnpJJ7wG8tt2MalbIceYhRmSXdBQwJmcFSQJuVY9mz6VMx+5xBGNZvlAujF57CaNztpGPDmN4hBig6V88P/7zeW4qRqOVv8W/OLPI4aOYbTHWV+JWp708MZarpDhPQ/6kJfnaa8DxNKblZz4XPpn1kvrKHJ23aFRBhKzmxqa91PlAIWsKfdtCUl5XtwizPdFfUp0FqhvqH59eVHGe+s/tTBy7Xbe1SWJSqAaHZKx6eLCGiP3U6tclfH8ubETo+Qr++WO0kYHcTTmAGSQ9DLhV6uYolHeCkHA3sKUg/4sfkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(451199015)(6666004)(478600001)(6486002)(5660300002)(8936002)(7416002)(66556008)(36756003)(6506007)(41300700001)(2616005)(52116002)(44832011)(2906002)(1076003)(66476007)(316002)(6512007)(26005)(8676002)(4326008)(66946007)(186003)(83380400001)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3x6cbpUI1BwZgTw213i9Fuj+UrdmGST08Ph/l+SaTBrjdQeiciFeJsC4zYz6?=
 =?us-ascii?Q?kzoFOjQ3/60w6NnQXS3H8JZRk0skPKaKwX316FtUv6+PlL2W1bvpximxFI7K?=
 =?us-ascii?Q?P5RrIehjfN/HcaO5dynSMUQHFbdruaJZfpXeY/CNJLRuo9xP8zOvepssjmo5?=
 =?us-ascii?Q?271CRY7R+kY8DKSqy6UqQk0c4xrGTTSjKnElQzEDixlolRqLUrOtx99TQOBh?=
 =?us-ascii?Q?AJg/ZW99umlaeSCkmPyWfij1kchXo8rJnUi61By/CL28JiLLLE2Xj4ciqL9k?=
 =?us-ascii?Q?4QG5ealJBXqp1xiV1cItoORpvrAKC058OWbfFNnvQBhy+XXPibd9SQSZd7mS?=
 =?us-ascii?Q?e1peshIdhQqZPKej8zbtKD4nChHB988aeWska1OpSM5m5vgQxhXeN/yNzuBx?=
 =?us-ascii?Q?/K+dSaKrqxZDOk5rhLAL3VmwwlohNx1oUimlaL5Nz9XcEiCWisrSPJHZtbZQ?=
 =?us-ascii?Q?Mp798HpGem7De4Mn9RlT7fN+6xMNNCvBtHb387X+gULUvorsSe66IlG+Mvvw?=
 =?us-ascii?Q?jDKwb7rbvt+8S9dQviRFz4qRWgpskVIXkv4EfArNITpPwyzZMcVJGSnlaf6t?=
 =?us-ascii?Q?hhjcmLzaZnwYrNc7Z/b8Rx79E2z0kL5TrzAJTD4kIdGgnMAWJcxS2TTo7FXp?=
 =?us-ascii?Q?K5nS9UpdXsQJJxHvy6JG/Zl8v1ijKSmIlLNqg01xLUpM//7+rBxorsmZkEZM?=
 =?us-ascii?Q?XSPa+U2kRSjbbEzcd97ESmx3G7OlxiL26ixYOHuumkWkrBC1lKradXCuXo82?=
 =?us-ascii?Q?Nwe+yntR4fMWn6e2+25PY3eRrLb7FMivvZw/gZUf5m+6V5WE/7fHcHmXvrKl?=
 =?us-ascii?Q?sxTFFnOR/8RllyVHaE5puEycdCTFRMrKvlBbNeMi3qOKY5gB6DT3UuDz6guE?=
 =?us-ascii?Q?6kKLPpR0oJDN8YodG4NQzFgz8xMJiu4ErAah+hO6hAZeKRwHnQPsFJrsmkRD?=
 =?us-ascii?Q?CLbPrQUs9CYJgC2eZk14L3MIgxr5YqyYE8broHKlUIfKlFFx9Qom6vAEB/Bt?=
 =?us-ascii?Q?n9M+e81LkVgV7JuAiEss0teHtqMO+mirHlzCOkOtXrxGvkuoUwbHjHc4iWaV?=
 =?us-ascii?Q?oEAeS6aUvAiDu77wynBVhggl2CtmVabZENNZm7Uqu+PAFXjR83Qidbz3du1z?=
 =?us-ascii?Q?JONuEYarimo7XHygct4SVwePpvRtyniLACfvzAHK+CoAvOpZzlojR47/gsBf?=
 =?us-ascii?Q?+TRjQcqR4pvusSdeimflgmhWYXtoT54Re5J3/kSSCYqDOdT4CaJrUAFCmKrl?=
 =?us-ascii?Q?GnXPNQBpsBm6zFEd0LbNVqpm6xJt7IoyHQn+JHfK1wNSBefkl9T40N8/LFG9?=
 =?us-ascii?Q?eY4kzX/peNdBoahL+yQ0YkUJFfM2PQQ4NBcA5dE5uRPzYzNLZeZn+OMTolWa?=
 =?us-ascii?Q?0y0oBh2Xh5HSFe6n9JNO6foBt7gbBiOPAbhzul3tVJ2+n6NsmzPuNn7KDRPb?=
 =?us-ascii?Q?XZznv22YEItRcV1lqGYGdCgGdWDWbqwVVBwGNrutR4/6UI0AsCf0hSZD2HIp?=
 =?us-ascii?Q?lDQ8e21l2h2H02wI01d6MOlTPdFd23HdQ6lWTcwSz/rr/rN2OF887KelI0PB?=
 =?us-ascii?Q?zJE69f+Hzcoz1G1ijmbVeu/6XWANf3EcqIAHngs5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c536565-aa0f-44bb-c15d-08dac6ecfd93
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 09:37:19.6809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sUbukpO1lgUw5kCdkjRv0Cg/kd4j9fcrNewdzPSQZSx5W/MiPuBA6Lxx3tvzfpDx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9462
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

