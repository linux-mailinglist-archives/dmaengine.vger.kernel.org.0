Return-Path: <dmaengine+bounces-121-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2707EE93D
	for <lists+dmaengine@lfdr.de>; Thu, 16 Nov 2023 23:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34B1F1F244E2
	for <lists+dmaengine@lfdr.de>; Thu, 16 Nov 2023 22:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40E645000;
	Thu, 16 Nov 2023 22:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SdBBIp+e"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2040.outbound.protection.outlook.com [40.107.13.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C1DCE;
	Thu, 16 Nov 2023 14:28:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WX07AjZErUI+g3JkmyLJyeeOvhmNf2HgQ+9Bso5zW/aTmYFRrcguJU6XAhPF7xuwIiXq+xB/ev7RludG6BWudi7NFAcZUQ8MUgYcKJZlw8KEByyXRYvg1uWHwvR51zNDYs2xiz8lW6ua8JdEBF5ppGslf+hBxKvODjWI5R+mPo8vc17rS8C5vqe2Qe/adlulprqUBiNFyoUwSRmRe+qUMG6b+4l7RTJiiJNJMOmjhHBa9h17CaLLacFUMumeW5x9p455pTDEJ8Csf3F4uBPdU+q/7+XUMEd3TZKlM8t8IldmlW7atVezAFXFC4mFa5JFUZjAvPuAw7idLzWwPRlSVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UyGC3FSy0kbLjFwrfabQUHL2ZBgiQKYcN8iggBLkCRo=;
 b=H8OJHlkahTgtByyuTgNXkQppkGfsYelBJzhRPato5F/Ym1NIIuoI+BOo6hz2utZ+zXNEuykGiBui1r8MQG8YPxjbt7zSxRs/6MJPR7sLWiji+X7LAYiAJ0pX/ktEhk/Titc7+Wpf8OL6+ttdRN4+/SPk4sbdTcXUmWnajPninP6sSMkYB+rJWVdEu8boxcMcSbeYycqpzw0oUj0XVKX3eC1CMzkPfSTNDCngiB2Vh39XjXCGoKRa+2ejBc8ATPZrwvs3z6jFC8egtwgC3+wWsjUNRWsHYfhv5pR+FxgNzWy6ZMk73wOqKckPqNLwMuSJOjRXqQBrrAercsGc33Cshg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyGC3FSy0kbLjFwrfabQUHL2ZBgiQKYcN8iggBLkCRo=;
 b=SdBBIp+eV3/0YJnBFFdX8klAOJLW/OJBvjpdovnQIPQoxk0FiF1+2za+YZ3fYn0/fBRmz+rjJTz9XsbQKq5j1MJGKlAupdCIQtc/PzctlRELkGgQcDcaiHZPob/d1a45n2ffekTse4Vc8vxqJR+usdYAtHeCNPhP4kgwptTcRZ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB8857.eurprd04.prod.outlook.com (2603:10a6:20b:408::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.19; Thu, 16 Nov
 2023 22:28:07 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::c048:114f:b7c2:7dcf]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::c048:114f:b7c2:7dcf%3]) with mapi id 15.20.7025.007; Thu, 16 Nov 2023
 22:28:07 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com,
	vkoul@kernel.org
Cc: devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	imx@lists.linux.dev,
	joy.zou@nxp.com,
	krzysztof.kozlowski+dt@linaro.org,
	linux-kernel@vger.kernel.org,
	peng.fan@nxp.com,
	robh+dt@kernel.org,
	shenwei.wang@nxp.com
Subject: [PATCH v2 2/5] dmaengine: fsl-edma: add address for channel mux register in fsl_edma_chan
Date: Thu, 16 Nov 2023 17:27:40 -0500
Message-Id: <20231116222743.2984776-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231116222743.2984776-1-Frank.Li@nxp.com>
References: <20231116222743.2984776-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0071.namprd02.prod.outlook.com
 (2603:10b6:a03:54::48) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB8857:EE_
X-MS-Office365-Filtering-Correlation-Id: 28139047-169a-43ad-7dd9-08dbe6f34ea6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BR4sWnU99bLflQRfJefgJuLdJv+fPfKGq+5LLmZEJMrFa0HO86+6vBVcEferjgwxf3Rx2MWi38psn56i+Ye0CcVdtC23S7YGIwR0Bp73U0W78o4wRv3Jw+6LoR+2KOroy8uXn9KP9zr0OWVp5VGB8t8hSd7nYXy2R5WSX0sMOmnq5XpYdbs8u3dlG2ST2CmPY0QFHY/Y7dJCHTnVc14eSAJ9LmbkusVQhlx2D+Q8JS8RHdevcj9WmEH6mBlyoaKG3RmI6R5XTA7evGdKT/XzfXx1z0WSM+Mi2XMs3ySOgSzxaNwL8SQ11szpd9daXz4N8BR/9F9Ba+GX46QHlW2gPZDMFc0aIIyuj0Wrs4g9EZFPgtuqiwfZKOuG4U0S2RXph4xYq2zRtzg5Wa8QTcu2vpJqojYZe6GKcPEsRYU1DB2qumtDXTNHn+6877ANpKEHGVkRNEKDYVg/lS8R6DmUivvuWKSEi6Xn/JPCf/4H05ZseTg5HY44qCBDzUPJCVPqOyIF8gs+oCD9luIzVt2ejRmMx/05tvevJhfQKaUA+sN7ikKvIXQgDT3IXirhHVWHrDvGOId7TexIIRM0JTKbj1lP/kcIMQTFxzJT99zS262ACRiPD41mi1BrKTMRIFRQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(6486002)(478600001)(6666004)(2906002)(2616005)(6506007)(5660300002)(52116002)(86362001)(8676002)(4326008)(8936002)(6512007)(66476007)(66946007)(66556008)(316002)(41300700001)(83380400001)(38100700002)(26005)(36756003)(38350700005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s0OiQRrbPQhAm6Gwwauc1/BqC608kSKxp8gTwvTyibJZ7cF18w7HWn5Qv8SN?=
 =?us-ascii?Q?sMXjx6udjkQTs3cFz+7lMNGmGzFMczfGTA04KFXeIFww4gSq5IreH09RUqRA?=
 =?us-ascii?Q?/e4nqY1dLp2esoEMbtEY2l114Z2cJWFXaua66kEY+lSN0bcZlqN8YGQmq8+E?=
 =?us-ascii?Q?eXGmCOy3wVP8qExIAeJ5VeTbqoxZ8neZxa0DxfftlJmwBNtoKv9lOY+kqWe4?=
 =?us-ascii?Q?9zv+p5Raiz/PLUQ9EHGpQiI7qO98a/10xZ6mtOVJa9OI3/6SM4UR5exfwrYQ?=
 =?us-ascii?Q?NYWV0b17twvmCfmGYwAIY4PhzXQb5fmBh1i1eRDCWEjhGdtF1e3WMwnw3apX?=
 =?us-ascii?Q?6mMewZyhS6jGo+hVyD/XPrzKGVeTfWVyLrXyBI4MKA+TRzPZ/VVb2W7t/L1R?=
 =?us-ascii?Q?lWwExOW8aFu3yx/0fdvd3lneBbhGp9OiCgyQ2LtKeHiSEq0m6esd4YDot79U?=
 =?us-ascii?Q?qD63bg2N1nNObRPzFKi/mQD/huOc7RTvQB/U+d1uH8CCJebt59KOQxYNnth+?=
 =?us-ascii?Q?NXEY1AuUJpGsosT+KEwmVNDvKVcl8rIdVvWWsgANyteyY84IMkNVFHTDh9NW?=
 =?us-ascii?Q?T6LgRGgIrmQ8PiVKdDuQM9gbqfMirr+fgOAqJzajwL+qIs6EpmdxaVZDEhXU?=
 =?us-ascii?Q?xxpRW7qHlikMznyQ0ArLg9xWwmJM+KJtUmpo39m2tTktH9hRJYSGDnDi+eIL?=
 =?us-ascii?Q?ovxQ99JqiBVGejiE6ulXCKIQhJarUutBxhTf1ZGAH83y7G70NRbm9E8Y09W2?=
 =?us-ascii?Q?tNdVss/wneviPnmcb2Su1831E649zGqgICNmK1I6byQk1SCCJG1bqeCNxbB1?=
 =?us-ascii?Q?sFw+EsGLWljyDGDPeLsRRIYx7R00HNzPpG+wzQ3DBpQtedBak8ZXYmfI7zU6?=
 =?us-ascii?Q?2iAgM434HIoO0RTs7BuOceAAe8YD9WcBpLm7GzIcKZVUuPNOf/ixrBLfaYwk?=
 =?us-ascii?Q?fHMtUI1RVZYaCGYVKUDAB5AhvELYLuKrXLJiSxL8vNaN7DtMwhB8apg4wuqq?=
 =?us-ascii?Q?VxxMXGBpBaMcoLaCh3OQ6uYH6QAhhWYNpfjc8zszfoNouOF6VNT+1zFok+Xz?=
 =?us-ascii?Q?5ll78Euw67Mmj0zMaHb8TDx45JxczVXER4e+kQe7YGVCcR+v0Y0TG/wRFJ5x?=
 =?us-ascii?Q?XwzV83BwEsGuYyv6kyNfbDS8W3e/W+Co/TKBo30BtYDL2GMjXllDOW0qvOGH?=
 =?us-ascii?Q?ZVwuQJ6ZUp0eqBE+9rZpQ56WNaCn9/LDR0JlOsTfV4BStakXfRw1R4O02EcY?=
 =?us-ascii?Q?1thP2hQ7dYuIYcRCI0T3gb3M9K3RMEwX7If8PomAe9udatORao30yXTnMXrE?=
 =?us-ascii?Q?IytTv5ncXIpvCtpHlgW+qG9bPcI467Y6bpw8sgUPQanMDZTEzQN4YSAXWlX6?=
 =?us-ascii?Q?ET8x8dMmOh76nWvya24OLwtTpFbxbiXIghf4Wp3Q0INDk3mUAAjQUrGx9QJU?=
 =?us-ascii?Q?nEd1PMFidvEJiucuwkR0VT6SQgly/FVJAEm6tKUq4I/OCFLM2DyJHQi9qRbk?=
 =?us-ascii?Q?4mqDL7rTZrhC4hBRbs1HyMsH2jC2hCWymvf6KdE78ToZoGlUn3wSSXul3T9t?=
 =?us-ascii?Q?Qekurcjq5tBKz3iUW9MlzN6/9h+su2J/AeASWe8j?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28139047-169a-43ad-7dd9-08dbe6f34ea6
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 22:28:07.5487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kfPJwxNhHxWLpkM9rru0zuunMeFwFroMIFk7D0imGE4Dk4tQhV6hGuGaFRnwAY5H8iuly7IZH+MkVQpUhanNWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8857

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
index f53b0ec17bcbc..e7a847e010dd9 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -359,6 +359,8 @@ static struct fsl_edma_drvdata imx93_data4 = {
 	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_EDMA4,
 	.chreg_space_sz = 0x8000,
 	.chreg_off = 0x10000,
+	.mux_off = 0x10000 + offsetof(struct fsl_edma3_ch_reg, ch_mux),
+	.mux_skip = 0x8000,
 	.setup_irq = fsl_edma3_irq_init,
 };
 
@@ -533,6 +535,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 				offsetof(struct fsl_edma3_ch_reg, tcd) : 0;
 		fsl_chan->tcd = fsl_edma->membase
 				+ i * drvdata->chreg_space_sz + drvdata->chreg_off + len;
+		fsl_chan->mux_addr = fsl_edma->membase + drvdata->mux_off + i * drvdata->mux_skip;
 
 		fsl_chan->pdev = pdev;
 		vchan_init(&fsl_chan->vchan, &fsl_edma->dma_dev);
-- 
2.34.1


