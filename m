Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6D771503A
	for <lists+dmaengine@lfdr.de>; Mon, 29 May 2023 22:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjE2UFg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 May 2023 16:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjE2UFd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 May 2023 16:05:33 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2044.outbound.protection.outlook.com [40.107.13.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F8BED;
        Mon, 29 May 2023 13:05:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJuO4QX9TUAqCtglIRrk/jzQqOP3ZJ/0ndfRFq+hUdH/JqjP9Vui68+sw5V5LoWcdLnlE8wDWcsY5qycNE2f/rZ2tfkdhN0iCVDZdmANTsBi1YlBXesb62T+J2L1ZqDdbaoCAqfdosfzJ167JGbTcQ/VFGt/4be1lis7jWEXWIpB8Xn90TycHNgW6DN1O9coL/VfuNMMKi2GOyc64VvD2Zxjge7zQi/4isDMd+RBVzEleOUH2hdF4avg7Ub3VkpzLoEA7YkmiblOTs0BalJnI7dVBcJFmQad84ZTnK89lJc1PCI91LFPzQKgA6Q4ua7ONp1km0otVQ+V8DbdoFNNQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5IwFxfjsLIuwWG9lLuAPQ9Ft0G9NDt16kTGP8ogl6Y=;
 b=XqtRzc+sZl+LZSNHNqud2xHYBtgy7J+8EBm6JyCuNAkRAPyR0HuHePe/RCJBlBag/y84nSiFvzptSHZfzRVOv9NS6BpUbth29L/153kUOsczpaj2QQPBU8CG+E3wUWGncwuxlWWmmqP+x3ZuaGweof3U+lsRTRlgYOxnyg30xhRmv7VFh52DyWrx2+FXtq9xtevg3Q1H8bnDpeVEYr/ihllU1ot1N8lsPL6lTHRBineFov8VFV+8C5m1ivuMFbA5OSSl8iN9R2OuMFoggAd5KM9/G2nsU5QCRiwHpGokhYjXJTRSQYlzTtYG6fXqgMXnfquovCd7cRszJl/i1RVPvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5IwFxfjsLIuwWG9lLuAPQ9Ft0G9NDt16kTGP8ogl6Y=;
 b=E2Xz48k0k7RY0xmIpqe91bL1x1jFVYZUsQ5ZS6Ehv/hbqWhtLDCdc9CnWuagFsgBr+c6hZhHiHg1iItzh7XdQa3D+E3x1AbFPnnCj74kiR8DWOo2uwdZQye6ZKDyElikqIaDWMrJY3slycLbmwN/+1JqsNaOAk7a6A4O9/pfPOE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9820.eurprd04.prod.outlook.com (2603:10a6:10:4c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 20:05:21 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 20:05:21 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, krzysztof.kozlowski+dt@linaro.org,
        peng.fan@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, shenwei.wang@nxp.com
Subject: [PATCH v2 03/12] dmaengine: fsl-edma: transition from bool fields to bitmask flags in drvdata
Date:   Mon, 29 May 2023 16:04:44 -0400
Message-Id: <20230529200453.1423796-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230529200453.1423796-1-Frank.Li@nxp.com>
References: <20230529200453.1423796-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0161.namprd03.prod.outlook.com
 (2603:10b6:a03:338::16) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB9820:EE_
X-MS-Office365-Filtering-Correlation-Id: 86251028-e8f6-4ed2-0b5a-08db608007ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kqK37TcrZceiVf/tlwJGIJw5sJlw2sciY777NgG86zm5ZgRbS0XT9xXW/ioT9s8XjcwsIseyG97rsHnklibDcJeinN3VGW16zyGQ6mtq1xleRCBxPhD1mA7lYKap2TL7ryodArOHPTRO22qillVoT7hSVNbEzzsLH1Rj0pFueP8EwgrLrAoCTyPs2JKPPIl0B3AKt55dbBuRW0n2WkQS0zqjM6uN6HrslHo0nD0sYiKi13EsBvGyqdltwRLn3OHLwQNI3d0rS+UxtTcKbXWaMnvM4gqC8h/KKzenoQ4G7u/gVoZmHYgEiW+KrNbeji3C/9oBxZIRqRSU9EQl0djBkDeN5Lt2F5OgQxcBfqMMwEN/uzuGgcPgHmHQYWvXS3KmqjFJqOwzCTpu4NEJlwp84thd+/TsQioe154+MIi4fTsDByUYnzzdvFe1EaDRojP2phY+D5jR5MRAc/KZ+ckkN+0H5ojr3z6HesfjSUj1GntzTMTMU798QPnDbdX413OASMVYF5cgC9WZGwFNTs67Gho4xw78U6VBWozGGzR74Cy/Jc7z+9YEIdu9Psa6zAaq+9sFzDlKXCOZ7HXCB+hLQs9akkZoFCJUc5ZHswSn+7uOahZg0UN5wB0nesweHLnk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199021)(83380400001)(52116002)(6666004)(5660300002)(66946007)(316002)(36756003)(66476007)(66556008)(4326008)(8676002)(38100700002)(41300700001)(6486002)(38350700002)(8936002)(86362001)(2906002)(2616005)(6512007)(6506007)(186003)(478600001)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BPP2nmANrKXzFsWHEd2Ypgm4S6dEicfXTsJQpT1P8ivMoWGrG9SdfdwWziwh?=
 =?us-ascii?Q?BXisVt+ZLg3e3Vm+/KxVgz9dqxQGRD5Q7oQNktbKPL7Mamk+yxRYhdmC3J4j?=
 =?us-ascii?Q?/EB/2zvATXG174x8AReRR2RfBludjXGvIMF0Us7ZT2AJt08xKENXwYH14tif?=
 =?us-ascii?Q?xHrHHTWOADbG+XzHm3LbhTcojQDqYaCeJ520Q+v3IDJoeYG2kWjBcwP9foZy?=
 =?us-ascii?Q?1AODh0XttXWfKn/gMhQV77mq0X3gqvGRRIuvUFroPgBH4T64KAB5QbExjUxo?=
 =?us-ascii?Q?5hovblueF03ce92MIv9n+J7no9sPNFKkZyOpbIKiesrgdNyXkklJ7LdM6UY5?=
 =?us-ascii?Q?c/RGXcNodYTifXxBMy/AuFqoZNI1IVNDme6RbZ4CXED+IcG/kILW1W5KcxR5?=
 =?us-ascii?Q?tpNeLKLiXeoF+4hsytjWojrKujMACfgSDQA+u02GsvyADtw8ZHg9wQ3+NNot?=
 =?us-ascii?Q?z/J/ldpfgM3oAsErVPa+1LmZUnYQOGWzch8wlEIEIFW5oXl7n+ruW3wAZgza?=
 =?us-ascii?Q?OFgg6h6KysQVSxkGduXbb1ruIqHIRfXs3Wp9TbiHMt1PpHIzmM9FNaPak/SZ?=
 =?us-ascii?Q?bt8/hEvcZUHGUcu9w5uVsZtbwH7jgQV92lOali+pmwPklkKg+RRY5EHz2zPK?=
 =?us-ascii?Q?JUttfxEkiQ3IC+w+LoHNpYj0VyVm+WEBYUx1H4fnjfhbYnha/BNYfHaLc87U?=
 =?us-ascii?Q?e7o+C1HTf7mCdDpoU95zFp9s66jFonuNrHiPpwzGOvpxta7jvCXZrm3ItmSp?=
 =?us-ascii?Q?x91MxcHvPB/JDbK+s+kMFlDa0wfK0QWZonR/w2scZQIbn16TKk3w2alj0ggj?=
 =?us-ascii?Q?e9V7XmIYhW9V8CfAGKJHG/NtH4HFsQSc3/BkVbDnKH/uSWo4qEsJdlTra7Bj?=
 =?us-ascii?Q?IokGiP6cE7LduAqTW3bgsiucediRLTtKPlt+6nbsx4SLAqYlCh66qDhWk6xD?=
 =?us-ascii?Q?ez5VP//nuZ1gvaY04+zkBKXHjRtOJ7rgDSVkvmj/THeIjiJS7Hv62l1K6mQV?=
 =?us-ascii?Q?XYdY5iWCYJZL+KDvWJDpS8IzstQIApHduHsUoGNdx+FXRl6YPHbGWKn9ohz1?=
 =?us-ascii?Q?VvHJfy9j5v+Mf9i8hVXdzqKE00QAfL2d1EQSpeyuYh1tkGm1zePysfTs/XZ2?=
 =?us-ascii?Q?j13goVXLtw3/1UlTJWTUBUye36DNC+2YaQx2AAlFB7if0+r+sMMjaPC7yQYC?=
 =?us-ascii?Q?Vx2I7nz/+l4VT97w1u9IiRQKViVgSCmLA4Lu/3Bzw6/5jQl47cCW8EDtq7vf?=
 =?us-ascii?Q?MAu1rOPlPFRiO5PKYCR4EZ/y20SHWiKdh6U/UbnOONKml6vMd+QxoasQ6B4H?=
 =?us-ascii?Q?SZY1sua0vhQo/Qx+G0PcHoGa62rDX5MJUfqrTTdX8zx9Qw8O/A//ExjayF7J?=
 =?us-ascii?Q?NrT9gJUxM+1i4nXpnxqZDXIJsSMnY2hpbJOOnuscg63ZJr/d0yXizVbLaHzg?=
 =?us-ascii?Q?cwnYP8Z0+vznyQMZrBYMKTpyjzq+HaLQNc3Vjgi6jMYon1VKGu7G31jpL7+p?=
 =?us-ascii?Q?QhbnU8FcEMlyevc3zwUb1e0D74H3qwVH9J23kquyeMNITXnCpyDAXFgPiI4Y?=
 =?us-ascii?Q?nimpjxdsSiBCV7m28yhKyGmVK9146KzCxK/YJfaQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86251028-e8f6-4ed2-0b5a-08db608007ef
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 20:05:21.0020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fj6PhR7Eq8bhodmoFaMsY2Ega2c7Xnhuftxm+CJo3c6N00Aw+J78GV6DSHlGuqGBeSJwYA+PiXhiF21wECZgfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9820
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Replace individual bool fields with bitmask flags within drvdata. This
will facilitate future extensions, making it easier to add more flags to
accommodate new versions of the edma IP.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 2 +-
 drivers/dma/fsl-edma-common.h | 5 +++--
 drivers/dma/fsl-edma-main.c   | 6 +++---
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index ce8d7c9eaf77..10dcc1435d37 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -114,7 +114,7 @@ void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
 	chans_per_mux = fsl_chan->edma->n_chans / dmamux_nr;
 	ch_off = fsl_chan->vchan.chan.chan_id % chans_per_mux;
 
-	if (fsl_chan->edma->drvdata->mux_swap)
+	if (fsl_chan->edma->drvdata->flags & FSL_EDMA_DRV_MUX_SWAP)
 		ch_off += endian_diff[ch_off % 4];
 
 	muxaddr = fsl_chan->edma->muxbase[ch / chans_per_mux];
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 004ec4a6bc86..db137a8c558d 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -144,11 +144,12 @@ enum edma_version {
 	v3, /* 32ch, i.mx7ulp */
 };
 
+#define FSL_EDMA_DRV_HAS_DMACLK		BIT(0)
+#define FSL_EDMA_DRV_MUX_SWAP		BIT(1)
 struct fsl_edma_drvdata {
 	enum edma_version	version;
 	u32			dmamuxs;
-	bool			has_dmaclk;
-	bool			mux_swap;
+	u32			flags;
 	int			(*setup_irq)(struct platform_device *pdev,
 					     struct fsl_edma_engine *fsl_edma);
 };
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 16305bb9a2ef..f5cf95d185f8 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -233,14 +233,14 @@ static struct fsl_edma_drvdata vf610_data = {
 static struct fsl_edma_drvdata ls1028a_data = {
 	.version = v1,
 	.dmamuxs = DMAMUX_NR,
-	.mux_swap = true,
+	.flags = FSL_EDMA_DRV_MUX_SWAP,
 	.setup_irq = fsl_edma_irq_init,
 };
 
 static struct fsl_edma_drvdata imx7ulp_data = {
 	.version = v3,
 	.dmamuxs = 1,
-	.has_dmaclk = true,
+	.flags = FSL_EDMA_DRV_HAS_DMACLK,
 	.setup_irq = fsl_edma2_irq_init,
 };
 
@@ -293,7 +293,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	fsl_edma_setup_regs(fsl_edma);
 	regs = &fsl_edma->regs;
 
-	if (drvdata->has_dmaclk) {
+	if (drvdata->flags & FSL_EDMA_DRV_HAS_DMACLK) {
 		fsl_edma->dmaclk = devm_clk_get(&pdev->dev, "dma");
 		if (IS_ERR(fsl_edma->dmaclk)) {
 			dev_err(&pdev->dev, "Missing DMA block clock.\n");
-- 
2.34.1

