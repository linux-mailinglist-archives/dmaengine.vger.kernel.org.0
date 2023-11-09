Return-Path: <dmaengine+bounces-62-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF7B7E7385
	for <lists+dmaengine@lfdr.de>; Thu,  9 Nov 2023 22:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04A2C2813FC
	for <lists+dmaengine@lfdr.de>; Thu,  9 Nov 2023 21:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB30B38DD9;
	Thu,  9 Nov 2023 21:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JumnNJCQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8CA374FF;
	Thu,  9 Nov 2023 21:21:42 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2072.outbound.protection.outlook.com [40.107.105.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0A23C07;
	Thu,  9 Nov 2023 13:21:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZau2FZbnG0tcBRa9aZo2mgdiPoCXcHd2Ll6kmJ5wD+7S2RB2yUk+OOqpvFgeFWnHwnD7CDIlg9xer4sOsqIBLVHBFROW4WtM1/Kb6GP8VA9gwQnIX6dVmR6bu/Pmx5vO2EcaaQq22Hn8fJM+W/XoatjjpIiF6kO3M/jEOJt4f0muCID2BK166ly3vArBdeSRSfGkNUs39xeFkhL44MQpCF6n5yG/lI7Qcl9/HpFUHo59vl3vvV1m6PkmkOu/sQYPkrgDxwDE5zbMtT+9wKGDg9ESQQZHgVxcQw3rvxHrqYKVt725AtquUPvEUCTQes2/7/v+hhfAF0uVGUQnWvYIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ebDjC6WKdz4ri4or89NXecFxL+fvMRYseQbEtVB2ss=;
 b=HktUl51TWYIFXrXTCKz5TIsUCgGf40GZioEAiIUQh/tm33uc94++7/lv1quJB9D7MtHqvXjr2yXBCZgwEzXc7JKY0DFlRqEfQOWiRHVG80izio6RZd4iB2/GzOXSXO3GBI1oMqLQz0B5Yz0MQQdr04Ac8OBudhm7RG9boPz3+isCW+FRVPdvJ4jipDGDIzoHN3wPlriE8udvuZRNeXNe7PUJgLKwWais0m9AB1kksTb/+CvAGuxc/o8vVyuUnSO5Uv8z1GvD5oQIOTMFzSm6I4Br9kNl7Q1GCG0hSvzWLIe22xtO5fT6BHS1yDztiI08a0n9VocXA4VMZ9fTZ/xSaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ebDjC6WKdz4ri4or89NXecFxL+fvMRYseQbEtVB2ss=;
 b=JumnNJCQRU0CY+oRMUFt6z/bELYcwzFEOP6NTAMC+RsQZLbEXatJuGWDRDjwcVAhz7M8D0oItb4klaY1GTMdo7OD1EkujHqjPDn1nm8L2PGXI2h9+lxi/n3PCPTGtGDAY2pouuwXgf8v1orbA0H4vyZNL9TNmvlOLXz0znFkM8E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DBBPR04MB7836.eurprd04.prod.outlook.com (2603:10a6:10:1f3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.7; Thu, 9 Nov
 2023 21:21:39 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::55e7:3fd0:68f4:8885]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::55e7:3fd0:68f4:8885%4]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 21:21:39 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com
Cc: devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	imx@lists.linux.dev,
	joy.zou@nxp.com,
	krzysztof.kozlowski+dt@linaro.org,
	linux-kernel@vger.kernel.org,
	peng.fan@nxp.com,
	robh+dt@kernel.org,
	shenwei.wang@nxp.com,
	vkoul@kernel.org
Subject: [PATCH 2/4] dmaengine: fsl-edma: add address for channel mux register in fsl_edma_chan
Date: Thu,  9 Nov 2023 16:20:57 -0500
Message-Id: <20231109212059.1894646-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109212059.1894646-1-Frank.Li@nxp.com>
References: <20231109212059.1894646-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0013.namprd17.prod.outlook.com
 (2603:10b6:510:324::6) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DBBPR04MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: c0ced4e5-6023-492d-6641-08dbe169dca2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+Kw00kegAalyN5bBsPc/LkOU9oHHt9Lv0saMA4mwybp7PXdjjd506N/H1DQuUQVHAy8+jGTJER3iU5COjbKxW9U8IaUh1oYy5sbr/pgRi5ddmiWNZ4ij9xhpuxUWCNP+7gjla3UX14zZATq1v+CGx89QhxgJ+CoAGZKXOgCdQrycI7s9I9wByIPoCUF2lFdkWh+LYCl5q63qYS/hy/511GS3yB8Cc8T683kV7Dw7GcemwzBuKP0yV0F/aiK8zXuLDPMRePMsATfAQBhCNK5g7ypordCltRR2Ge4vBQqAtXZsO0yPMiPly9iWzAYSK94ZMxOmeN00SkRdEmfNxlvQJyQiI8+UAn0h7NSqSYy96qKP0XUvaDATcz6iobt7a5OTgxED4wAXEeZohp8xjORKQxKLdJWYWrdKz2ZahlDo58nVxhw8GamIrLvkLCEegUFE4p7J5jIh4BA41BWbXc/+9jiLP+/mQQWboifMfLy1MLvZU/cL3BNzkyVmS0kPjxlNlwyKmtPqRblHhgs0uRCK/+JApDKGRso2babFj81sogCBVjPfE+xA5OPjPacKU7uUmF6sno/7FnANvCE3jraaxkrW53GJSgwkpb+NugZj44fScXo94MpflKZwv1hHQYFW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(66556008)(66476007)(316002)(37006003)(1076003)(6512007)(6486002)(52116002)(26005)(66946007)(6666004)(8676002)(83380400001)(8936002)(6506007)(4326008)(34206002)(2616005)(478600001)(5660300002)(86362001)(38100700002)(41300700001)(2906002)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uw5KX8qYlk0/mTdq0NPN467og+qs19wAPfDdQu9vHYuGgs26YwUFahQ7Phvj?=
 =?us-ascii?Q?n2HiFiBHtyTvpyj66G538VKrSHHl0hqwTglkZOwM4rL9wkTOVwkWaMGu0Bcz?=
 =?us-ascii?Q?yB7/J4xE4ORAJ24jOdl6BurYIpV6GakyH2MB4RmRxlUto3oXnL6ZcpqjVxXu?=
 =?us-ascii?Q?hNweUbmhzS/ZRf653HF405xt9BFgAGNTYoye+p0Gigueh6tltZ+7L8WSBxvx?=
 =?us-ascii?Q?E1nH7mEDFSvNVbuediNXPEl/IByperK4t7K4L/1o98CwcWrm3T2g1nFID5rt?=
 =?us-ascii?Q?TZrw9zrqoeQaR1C3VpV2jWB2KeQMTfX6yTBArcFpJLrcpgOieO9O/uR+zxwY?=
 =?us-ascii?Q?jBkj7sCCeg1JYAKEngQUzTAz2cFCqCSoZrBy1Elf925EzhOEVsaI+DhCuoCx?=
 =?us-ascii?Q?oZQmhLTtJO+zKZKhGDkL1NWYx4OYoxum5xE4eB8nw/0DF7scvPM9PUc9vEjS?=
 =?us-ascii?Q?piCAm57AED8oWKlLwq1+Sz2yAFnU3phG2Wl6ysJKpzKQkjPwP5iLxGBwTe48?=
 =?us-ascii?Q?hN6UUt70VovPZBz/QiRt1vVvZXh7hAYT9zNz5J+ZHrsN3bin5q9jg0VcT2V9?=
 =?us-ascii?Q?0oHK8DCMDDLnHFYMizA4yFhz/0NVDzB+ddvjBtOjl1/zpYmgpcRAr6lXNS+I?=
 =?us-ascii?Q?vptJzBSkwfVgqWu8NHhAzMFB24ppgpBQMxtwzkZD7R4XB8NfCWUU+pVco2iU?=
 =?us-ascii?Q?srgtk+OSzqeGAwiW4kKEnFbGtRgUVOwZYrQFE2OOFqorhQQYD/us+nQqv+3E?=
 =?us-ascii?Q?qpC7ARRlVcXvYCh5oIBhYGu/cmFpNjz0vvWuJs88AFBrZ6u89WGLK7EJbHKR?=
 =?us-ascii?Q?3UFhWiAf4525QpOWyMF3dTK4gt+FpWnb2adazZWThJka8MJyErRcJuIHKIpn?=
 =?us-ascii?Q?JtFR5MD1oAzhRIiZq+n4bmKjfWOdjlTZrtQ4JU6AUpIUTThDOG6gVLEHuwX8?=
 =?us-ascii?Q?mSngGvss+HUgTVNxdV5RcuweQaxq+5jsAdqoJNYUPhFOtRVMeqXOYPMfAADI?=
 =?us-ascii?Q?Y40p9PbCB1T191aOdVFj42Q+Xz8Nu/n2wiEs/lFfgJffwDLlbk+lJkUKSsjb?=
 =?us-ascii?Q?PmdGrr9mHrj51DokCJE4CNNyMA92yoRWZV7bJTSGUwCwoaGFgRnjjvSBWfZ3?=
 =?us-ascii?Q?MQDT5FkCE4MIRAIXsh8g872gGF4qKx1trA4F9nD5M2rLyVgFM70m9uJWTBc9?=
 =?us-ascii?Q?j2K8hBCPMlbkWK0ziXwUmdJdv8YLmNAiC341NHcm48uFok+CMxus292P1fec?=
 =?us-ascii?Q?/WIPPV30o16nwMq83pVdin0Bhqp0a/Uq/PYtTcfH8QG8uQ0KyN8wB4Jw2ukw?=
 =?us-ascii?Q?nvH1RmS2XxVechAill4ZbIl58GPrSXZrHFFJ25l/JR2skVHGyX3Wyn6DjeLa?=
 =?us-ascii?Q?9lSylEx6PGrwThfB2a4b0duvz5mF3JqUt6eVzXVc50T1Yl0KRp7hCCWaiT2F?=
 =?us-ascii?Q?OKGuMUddLKs41pVo+ZTq/IWH7jmLi4Jnn9Xpgg0w1AYp6/lr/s77I8i3lrG1?=
 =?us-ascii?Q?HZdLkNLTszEmw7yEpjUbfVOJdKvMptIBbzHo3Yitqic2nffBnU/Ft0bcmsrZ?=
 =?us-ascii?Q?ytmUSaj9IVmRiaDaI2R9yszW8YsWr9dmdjbjzSXH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ced4e5-6023-492d-6641-08dbe169dca2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 21:21:39.4061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AO/NGGYunwvKBLY8aRLQhaXogaHa00fgRq0q4/Rm9Y73/c2PuM2b430dxU4bsUjdLJsO/D5bRzJNHVIuChj6Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7836

iMX95 move channel mux register to management page address space. This
prepare to support iMX95.

Add mux_addr in struct fsl_edma_chan. No function change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 6 +++---
 drivers/dma/fsl-edma-common.h | 3 +++
 drivers/dma/fsl-edma-main.c   | 3 +++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 1cd9cf51b16eb..d29824ed7c80f 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -97,8 +97,8 @@ static void fsl_edma3_enable_request(struct fsl_edma_chan *fsl_chan)
 		 * ch_mux: With the exception of 0, attempts to write a value
 		 * already in use will be forced to 0.
 		 */
-		if (!edma_readl_chreg(fsl_chan, ch_mux))
-			edma_writel_chreg(fsl_chan, fsl_chan->srcid, ch_mux);
+		if (!edma_readl(fsl_chan->edma, fsl_chan->mux_addr))
+			edma_writel(fsl_chan->edma, fsl_chan->srcid, fsl_chan->mux_addr);
 	}
 
 	val = edma_readl_chreg(fsl_chan, ch_csr);
@@ -134,7 +134,7 @@ static void fsl_edma3_disable_request(struct fsl_edma_chan *fsl_chan)
 	flags = fsl_edma_drvflags(fsl_chan);
 
 	if (flags & FSL_EDMA_DRV_HAS_CHMUX)
-		edma_writel_chreg(fsl_chan, 0, ch_mux);
+		edma_writel(fsl_chan->edma, 0, fsl_chan->mux_addr);
 
 	val &= ~EDMA_V3_CH_CSR_ERQ;
 	edma_writel_chreg(fsl_chan, val, ch_csr);
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 72104d775e562..6c738c5cad118 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -145,6 +145,7 @@ struct fsl_edma_chan {
 	enum dma_data_direction		dma_dir;
 	char				chan_name[32];
 	struct fsl_edma_hw_tcd __iomem *tcd;
+	void __iomem			*mux_addr;
 	u32				real_count;
 	struct work_struct		issue_worker;
 	struct platform_device		*pdev;
@@ -206,6 +207,8 @@ struct fsl_edma_drvdata {
 	u32			chreg_off;
 	u32			chreg_space_sz;
 	u32			flags;
+	u32			mux_off;	/* channel mux register offset */
+	u32			mux_skip;	/* how much skip for each channel */
 	int			(*setup_irq)(struct platform_device *pdev,
 					     struct fsl_edma_engine *fsl_edma);
 };
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 4635e16d7705e..8e5ddeb5e887f 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -356,6 +356,8 @@ static struct fsl_edma_drvdata imx93_data4 = {
 	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_EDMA4,
 	.chreg_space_sz = 0x8000,
 	.chreg_off = 0x10000,
+	.mux_off = 0x10000 + offsetof(struct fsl_edma3_ch_reg, ch_mux),
+	.mux_skip = 0x8000,
 	.setup_irq = fsl_edma3_irq_init,
 };
 
@@ -530,6 +532,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 				offsetof(struct fsl_edma3_ch_reg, tcd) : 0;
 		fsl_chan->tcd = fsl_edma->membase
 				+ i * drvdata->chreg_space_sz + drvdata->chreg_off + len;
+		fsl_chan->mux_addr = fsl_edma->membase + drvdata->mux_off + i * drvdata->mux_skip;
 
 		fsl_chan->pdev = pdev;
 		vchan_init(&fsl_chan->vchan, &fsl_edma->dma_dev);
-- 
2.34.1


