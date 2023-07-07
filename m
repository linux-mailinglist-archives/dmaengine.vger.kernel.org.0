Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F7774B6B7
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jul 2023 21:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbjGGTBD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Jul 2023 15:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbjGGTBC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Jul 2023 15:01:02 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2089.outbound.protection.outlook.com [40.107.8.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CCE213F;
        Fri,  7 Jul 2023 12:00:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GN5Ea46BN/AzGm11d1ztdKK2EyaVZDXlvZB6ud8eNREq02AXjETPyKb5PznE4AEZttuLq3or0h4PiQzJ/nbvUEUNrLQ1Mkn8q8xWOp3hZOB7U1YA56RCQyuP5DnSOxzwB4AgMyC7RGi8AxTFgRyMYS+qLO6Kb2zxhcMS64njdzlD4/xjObXw+np1gco/cxaJ37hUAtVpS14108LcnCm2Xf4RnPdoiomTuuy1foXNJIkGxkAgX9ZzWPFB/y/ZrrFgMUQSvCA9cpTyCCUSMKRzFjlC45Y9fg7D0Bg6Ykl2sPhmDw8yKYt7zfKDECcBrofuErYatyYYjvG4Thr7g1YPOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTlCOs+gUC7/ksEKNx8JBDZsHq+yWhWE+Hzn/rKVrxw=;
 b=HPsHtUen/vEkZLkClESbTGnXGHPHiWmLIuoF3vdLyn+umKQK5tL2FTaPbMc7PUM7qCj3tJRaQvJIE5+b1stM1QnDR3hsicyNfdm9Chkgw6EQENj3DqEic5O6qnnl3dF/OZjxInBTWq0nIyDA9HraCjn1eqLjTzIlD271xo2QpiAtgWuxJ3HMxCIn6GtNM5fW36J5kr9pFwT9CfLm9dfNuMdpKYarL/dDKe10twB4lFh5Kq36jxNEQOn6fK1xZeMVgYpgHcj0LDzPtvd9/pQQq+lYOO4WDZs2riJBVj8iJZ66zhkj3NlVUit0/WwVEoZQsUMjpwu05I/HjNAOacWjkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTlCOs+gUC7/ksEKNx8JBDZsHq+yWhWE+Hzn/rKVrxw=;
 b=QPTyx6ebE+OVsbIl19E3K57935g/FNikju2sNo5FKYyNnDkf2YB6d5fit7iIgDUFUI6uqAH7hTCFfs67bAlAAok6UiFu7c88OUPILGqBjAyR4DwkOLgGLL90HjobJju8rz3BJEo8MdKBeVnZljr8lZcQ1tAsXiSH9MPu63NM6ho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8103.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Fri, 7 Jul
 2023 19:00:56 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 19:00:56 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, robh+dt@kernel.org, shenwei.wang@nxp.com
Subject: [PATCH v10 03/12] dmaengine: fsl-edma: transition from bool fields to bitmask flags in drvdata
Date:   Fri,  7 Jul 2023 15:00:20 -0400
Message-Id: <20230707190029.476005-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707190029.476005-1-Frank.Li@nxp.com>
References: <20230707190029.476005-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0067.namprd11.prod.outlook.com
 (2603:10b6:a03:80::44) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b8ac228-3fee-4664-025f-08db7f1c7eba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cBNQVtuRAtIHPJ6zDBSMNrsTmCWXbOFHArZelDPmmt+BrAgnEsIwDR7BlNP8WAL6TWXCFqa/Svuav1E4QlKvhWRlpcQw6++NqdmLE+Pvb0K2Edn9+hl6HqwoaBNngG7B58ZtGMU1kj1qDWMRCq5aVe0LQKFZltXfWy+bexHVrhOl/sKv/hpTOmwUuRTOxVkQcqMr6GJ9H2Q2ecnUypBn65Dipe05Ks9XJBnAFilY8KOvxUuJaKdCxPRjcuEu0kMCaEPEgIddBijWPN26Ci4OK9O4vweByPzYSaCmOZgVNt0OVq8YqXLSRA39J7a2H1AIGtTv940UZOYIIxWb3iEXsgJiQ7FWA1pS9locmeZrzMPgLqPsP15++m280RAg4Guo+m/dfln6dULqWsPptd8DhdIXBCtHJ5ZQVzYf4cV7p2FXwi17+dQww9AUtrEybevmaS/qkj52gmys6u3bkoo1qT/Lisuy5FjjyswCR44si1VtYCJTduOy+q6Ru35IDuTFRm6/g7dW2mHk76EG2UnZ/Pmf4Zk5F3EdEYYKTlXKYWzcIc0TH3b959KIDzNdHmxERA9fHtWkgR0B4SMwhX8R2reZF3Nwb3YJvUdAVBLkZRUOGIxEKsmvQLr0Se/rrss8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199021)(478600001)(52116002)(6486002)(6666004)(6506007)(1076003)(26005)(6512007)(2906002)(186003)(41300700001)(316002)(4326008)(66946007)(8936002)(8676002)(5660300002)(38100700002)(38350700002)(66556008)(66476007)(86362001)(36756003)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c8ZWstpz3pp1kLPGtFP0BZxBXkqgy5ed4U29QWhw6D/qUUuKGuogmlnsW7GO?=
 =?us-ascii?Q?HjlKjXEtUeHh50hqZ4RT+RtciVyxOKgFOTP+UndouPKm7mJjGbw7jikW8vdD?=
 =?us-ascii?Q?WyhxabMPUxE9BDow7wIrl863tT82rXwAIAeahpuk4HnfWaC8yRCjBPqeW7b4?=
 =?us-ascii?Q?4l7u10YbF7Et+zGr3dciXqQV6D/S9A4V8r/2beV9ESpvFd+Wj2ttnxg1Srdy?=
 =?us-ascii?Q?zHaYuE0xklsB0rBz+Ut75G4hU4krN+7hqMaTlVidGHBJTTOB0hkQjBhdaHeU?=
 =?us-ascii?Q?qwFdVQT26vudSHDaC8TFYkkacEvg2fuwpN4QW5QS4YlESC2yUroa28lBvsiE?=
 =?us-ascii?Q?6mPGFglUY9lhASzVqlrv3QW0qRxIbBmHSiYaEu17a37WtYDOU0hIgl1NTwAi?=
 =?us-ascii?Q?pbtwFenCAEmWZRm744UXioHQ3y4oLozxzRsPRVUONWc9ChOK4j24/Uu+pqCc?=
 =?us-ascii?Q?A+Td7wCJH429RG/1tnOhKi1XPcJIO+BfgvzKekUwLV8FNKPR0MO2XGowp9Vs?=
 =?us-ascii?Q?bBHD/KqaXKLqbUlyBJrQP4WM5M9dFmasIiuQ768ISQVPOeLg8+Zq0OQ6Zgl0?=
 =?us-ascii?Q?lEUpAC5QpvgbhID+HSqqH/dNZmrUTWRDVPAGGKDFIq8Q5BR/hnO6Ves3zATn?=
 =?us-ascii?Q?kvT8OfeWG2AAYwfmIQc/3reSz7spgWJWI8sAbbamXkNvmqnxGDZ6B0unGw26?=
 =?us-ascii?Q?8oL85harhsdsvGXNtM51pHg0Fe98fqAQHjyYI2ljDfnOFKB2vMW8X8E6Q+zF?=
 =?us-ascii?Q?ZzkM41fd5/je6vhuPg7S5u1noDP5e84+Uh270alZD5LdlODJtCEBoYOv6ehA?=
 =?us-ascii?Q?YtqkMvs7vPxPVUNl8mmQA7HAhO0bnTy+85rBfsJX+i6eJ1TH9RPWkxnsynhu?=
 =?us-ascii?Q?kitbw7vLL2zTpgOA2MvQOcLr3WBA8f0RU++dLAcN8IWhSBLu4pZ7q/UcRmY6?=
 =?us-ascii?Q?UbxjkxOqUfNuBo9FxQWw0ZEd9+w8KaAs+xdxFsbv7tOdJuU5Bfyoj/bcK19N?=
 =?us-ascii?Q?9B9niJkxP3iUvxTpkymFCz4/mFY17JgXwErfESK6GSfmqdFXA2P/WPGY5ac2?=
 =?us-ascii?Q?F49O1j2kvFZuzOj5PRh/cmY3u1ygs1WSTUFAotfbDu0PYjjvqi/ge/4OTH7F?=
 =?us-ascii?Q?x9/SKYBdnRfzKEbvjs4zGE42r2Wh6eUkZdbaspKUrwzrtP8IkLs8BqWj4WNL?=
 =?us-ascii?Q?X/eONUkyvNJOjeYiJEJF8hSjV9Om7OCaAWNs8jbxaTI4P6yVyi6juJJEJ348?=
 =?us-ascii?Q?w5Yl3qZXyVHSKmJ6FVaCBuDOJEi4XXo3F0H8bsKVw34oht7L6JAS93o/rcV6?=
 =?us-ascii?Q?b5zFpaihZX+9pzLDguYJHB7WDzveMalLGkdBvIZfqKFdQetD5mlaExJumvA+?=
 =?us-ascii?Q?dPHkg8URP8ALjDEwwdr1tIZdgdQ4QVpnJx1ppqkZa6xnxhIDlqWxWj5Wo3rd?=
 =?us-ascii?Q?dbn4VOyouVEs/gW3ziIp/RLwzFpBHh8k8BI+52OrqeixSvPcqg/O7eAQL3e/?=
 =?us-ascii?Q?S6s/8JMbvHK0stpqvaBBGZ9HKnPwM5Ia0WuW4zkFXE69Vb6HGPbEj3RQXrFl?=
 =?us-ascii?Q?w76EHja5Hrii7SbBoIQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8ac228-3fee-4664-025f-08db7f1c7eba
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 19:00:56.6457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3aisnvu2Y2tfuTryzueSXpSo4wDiWrOU7ZBlL7bnluWYjRvY6Hw9rd0RvhCCqtAZRxhsleuXJWLesaKPpPUHuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8103
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Replace individual bool fields with bitmask flags within drvdata. This
will facilitate future extensions, making it easier to add more flags to
accommodate new versions of the edma IP.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 2 +-
 drivers/dma/fsl-edma-common.h | 5 +++--
 drivers/dma/fsl-edma-main.c   | 6 +++---
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 89b0d09c13ff..2549a727913f 100644
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
index e40769666e39..1e1cf0548ac7 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -244,14 +244,14 @@ static struct fsl_edma_drvdata vf610_data = {
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
 
@@ -304,7 +304,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	fsl_edma_setup_regs(fsl_edma);
 	regs = &fsl_edma->regs;
 
-	if (drvdata->has_dmaclk) {
+	if (drvdata->flags & FSL_EDMA_DRV_HAS_DMACLK) {
 		fsl_edma->dmaclk = devm_clk_get(&pdev->dev, "dma");
 		if (IS_ERR(fsl_edma->dmaclk)) {
 			dev_err(&pdev->dev, "Missing DMA block clock.\n");
-- 
2.34.1

