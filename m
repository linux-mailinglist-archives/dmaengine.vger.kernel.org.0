Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED34D7128A1
	for <lists+dmaengine@lfdr.de>; Fri, 26 May 2023 16:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243958AbjEZOjD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 May 2023 10:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243944AbjEZOi7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 May 2023 10:38:59 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on20627.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1a::627])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE455199;
        Fri, 26 May 2023 07:38:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDMa5TFKHgKUjj1IuRkkyi3CMR2J1j0XBa3WmcOYmmaMdBX7xk4kqipSqO6paQ8ARrl/08Se4LNHXajV9i9swhscsUXjIGdA78ULH+akZuyGeAD+62x5y82+1ZjukiJG6AxpFjYBd1e6xxuHB/2iIlvzoG+jJG7A7onSlejXLGwHW9TvcflTS1ThdaAD/z1KSFdXQ9G2npKJzfHJMUCrc1yTbJMYNnH02AU9AlVMnjvfQ+fWOKeMlxhggV7a7ZuipWkHAwtLA73LwHJCyXIiyeNfOvBrqL2//zbjw3KUIdJkHhEHIhbVD1oGGYWlQ2dCGf2LgPZfiF8H1GmXZLHEXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYC6iFkeYIBf1sHD4vzUmRzUWEV8BcYvdT86nMRXy30=;
 b=NIEhDEbIrzIYLNP0z5KiZkOsjni8gynTzKy3BmQd5CW+g8wWIkx7v70N7T2wkthF4abWGFzqLOsli8p3dSZ6hbrGePk4CT1XyG6lUI4wscpDYU3H4Nr1ec6Y6UVNfjzwa75vyUnCNI67WgUXOCLT4UqEt5f7M/eonDdLKJgZvy+EJqgfg0Bba83gZ86I/oZhXrjdond784M6QEEOAerbF/y2KlFEiUL42Jkz5jCXsPOWK3FQ+VaEGIAzw7WAhB/LG8VSQK/S25c6gxmHyE+Wi4J6mv//XFuAyjn74xc9kqvuvxTf6ZUezIWl7Im/ICkPCVZWXuemGtn1I0RduMUUkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYC6iFkeYIBf1sHD4vzUmRzUWEV8BcYvdT86nMRXy30=;
 b=rXJZPEM/lC4cjtKcxRoHlkPkV/8KfoEk0K8+O6xzO79LoLMM8nS63Qc5uyOX1K1xQvidUGZRl0szC9LxfxTa9uhSkFaWXcLehe0JsM3GWYqY4gpfpmq2EJ1Me86TSlbx0LB+JdnJxR6i2rH1ZrmdRw+IqaN7VQNE2aj8JJKg+0E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8070.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Fri, 26 May
 2023 14:37:14 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6411.028; Fri, 26 May 2023
 14:37:14 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v1 06/12] dmaengine: fsl-edma: simply ATTR_DSIZE and ATTR_SSIZE by using ffs()
Date:   Fri, 26 May 2023 10:36:33 -0400
Message-Id: <20230526143639.1037099-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230526143639.1037099-1-Frank.Li@nxp.com>
References: <20230526143639.1037099-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0212.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::7) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a3ef78e-1f01-4dce-d3f4-08db5df6b285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FH0E8l6jJuw7fVZes4ft+bRHwrXao5OF2pY80N1x9WwnB3n1xOtSAO+jb4n9ztcs4BrSMpTLWA3Q7ovVKsrPnVR8EyzsVjF0cN7AbOWyIc840A6ex5XiXbAYWKkhQjvYckf2M/9Kc0Q5f0WsfcvnyBuWDmc80R6mXu52sStXtIPU0re7O8d6GR3nag6keMOqigd/DKPA2HTbUTN6GS/N+0J2ZstFhYn/r0XpQnYCx7e849jlAkGfMbEtQcIcIri+m9lA2tRYHiuYHlE5XFoOosfweggk9LgbADAFwMpYsHxVmjp0mgTV+CzuAwToiP8IprVCfbSX4k3GCoCve2wC0BLwNp5IIOrPMwzM46sxEGQ4FIUrmVEsL9NPPHihDD6V9kzyecx277BSKZjRPRWKwSaCYCXSujwEmtDExKa4XSTydFjJLG2Zm222uBxkSf7A3MgFINOdd/KLqoXLMen3WYfmqj2etvY+YkxHDglcvaAORAsCrD+tYgAq+aC60s+nGhEuUUZu4DMVsrCsvft76BF72D/TyYI2Y7LDqm9UNjWv0Ncw3qmW89qrXJRPoAtrrLjxkvrgqr3MxWmb32j3BKuiuBuhcVaUqIzzZYdEje7dSnw3x9kZ4MJLUF3KrPm1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199021)(38350700002)(38100700002)(8936002)(8676002)(5660300002)(478600001)(6486002)(316002)(6666004)(52116002)(41300700001)(921005)(66946007)(66556008)(66476007)(36756003)(2616005)(86362001)(186003)(2906002)(83380400001)(6506007)(6512007)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RFfbAdAKudUID3VEaEvVujY22b/OeVZMwoEtkXDO7+Uk1EiljNjZyo07yTjM?=
 =?us-ascii?Q?JCK6GaCHq8f0knCZW5k5RFyFVnwsdIqitrz3jt6Oe8zOaaR3wTyN94FyRBzB?=
 =?us-ascii?Q?Cn/PuAbMLNVz5Gm8QjNg0JGIS1E75QNOKiHs9OqD5LR456kIjELAVlWogO6x?=
 =?us-ascii?Q?PNAwM9RMx9FsXSq/8TzzPnMqCnwKCxC7Raf+m1ZQ/tLuqqth04qDiUP0COis?=
 =?us-ascii?Q?kqQKCz81BGK1jTGhzP6LKLQncNXf/HDYx34UAxnzzKKdEV/yoEAOW/j0RKIT?=
 =?us-ascii?Q?Z1l4ICLWXDBPvgn5VqI3WnLs0dDitsAPfoeMA+aKKZnOSZjKhDAepTk0l5p9?=
 =?us-ascii?Q?taKgmxwSftYJ6RZXL77gs/r2cWDVxUjK9GAFfeKgqNmliyy3Yced94udCp3p?=
 =?us-ascii?Q?oIkzcH5bu8SNpTOQPSj7QyljWjyFbntE9KYWQ8L+vAOjwuA+TilWxApc5+Fz?=
 =?us-ascii?Q?n4WOmi96CDYkNLRINmg5qJEUSW7VFE2cMkjJ2lhz2mbTcZ/zNR0IfHsm0R0z?=
 =?us-ascii?Q?vQsHlMQpbVw/Rt6PngZgmmlbUKmueiONDjhim8GGSzNlsyu+t35ZvKZjzbbP?=
 =?us-ascii?Q?sP3CF3VMU/1nP5YpOHpDgjCqKOoYlCV/E4sm1OwBkYpka65YwylTKnpzzmUd?=
 =?us-ascii?Q?Gw3iAW4o7BqY4PRMZf24NKPl+ck0MjIbYPkiTyv5L5TSe8hihlIOvsn1+PKr?=
 =?us-ascii?Q?Yaw7TrndWl12TabljjZMFBd9DWH+x/MBlSzYbPcbLp0umiYYCQG6QclDmXc2?=
 =?us-ascii?Q?ep0DWewQDx6mmEmV/pWcaGLxjaIGaCI1E1/LZ9gv2JUmV5vwbiYHgIUALQR0?=
 =?us-ascii?Q?pFQUku6yUzIntITOb7E3F8DRp6i/lFmD4v7XI81Y5vXiGUC3FfFz8k2Cq/Eu?=
 =?us-ascii?Q?QoiWTbEhDF9/DIzcTuBmRsRZzcAcUhFWd82IfTLJVF8o2LrLdYMRrgQa+yvY?=
 =?us-ascii?Q?Xd/N/P+/D2S1rymmRAl4HLopYe2lhNY+O5H8q2EL9UB/RWqqoyrICfVSh0Tm?=
 =?us-ascii?Q?u7FgK1hAjOW/ppnc73TAtiVbfgsFopy2rmRHFyWIOJLIluI0LixmXoY8C8WI?=
 =?us-ascii?Q?+hlcUW4clFiLTav5E40ud9fKOfRP9WozU1ccDoNh4FIpa8SWyMTSIobYGkFK?=
 =?us-ascii?Q?21juWrdDBi9NZFopKyWc93xzikoJCcrZDEzc9upBCgQRB9v3ImByggX5i7Xc?=
 =?us-ascii?Q?K/uw2s5kQjrqFZdCWj6tEYJZAkVC3/uEYoOUyskaRoDhnUYu1aPb1cZ9HA/t?=
 =?us-ascii?Q?0GTUnUyesNBtDsCa+FooysmkXYLifN6xFZ9/Q2S5AShemrjoIExAkukU/K0+?=
 =?us-ascii?Q?kMBNYbmDSqtEcLYZ2j+dAU9+ECUa7Ttq7l3cSepLEDY18Qu2mjkxzTWltJls?=
 =?us-ascii?Q?mUUkUiaGwYpzsMgREK4kmTrz/YyP+QSjQpVx+oyAAMQbNxoxR4hsi/dqfh2v?=
 =?us-ascii?Q?ffkuJEhvGEW/PO25StH3BePnUyPV0A9kX8avA+NYM+o3TsKT9dft/ROIfLaD?=
 =?us-ascii?Q?cMzHxO9YdFzqZtT3IDVH/Rx5Q5p5WVuVCglObBgKQxpagN0l1vGaFCbCcU5i?=
 =?us-ascii?Q?9TXyTaV0+39nM43/6AC7xBByXKsSs3Ip1W0pH+n0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3ef78e-1f01-4dce-d3f4-08db5df6b285
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 14:37:14.3177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w5zSCaahuJEfy/HMYjKXdujHbBGYybS1aPncwVaddWyTSroN8sdiz2xh9io503eWtCb8cvFHtCw6nmEW00u7qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8070
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Removes all ATTR_DSIZE_*BIT(BYTE) and ATTR_SSIZE_*BIT(BYTE) definitions
in edma. Uses ffs() instead, as it gives identical results. This simplifies
the code and avoids adding more similar definitions in future V3 version.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 21 ++++++++-------------
 drivers/dma/fsl-edma-common.h | 10 ----------
 2 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 839471c42758..659bef4a3b23 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -154,18 +154,13 @@ void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
 
 static unsigned int fsl_edma_get_tcd_attr(enum dma_slave_buswidth addr_width)
 {
-	switch (addr_width) {
-	case 1:
-		return EDMA_TCD_ATTR_SSIZE_8BIT | EDMA_TCD_ATTR_DSIZE_8BIT;
-	case 2:
-		return EDMA_TCD_ATTR_SSIZE_16BIT | EDMA_TCD_ATTR_DSIZE_16BIT;
-	case 4:
-		return EDMA_TCD_ATTR_SSIZE_32BIT | EDMA_TCD_ATTR_DSIZE_32BIT;
-	case 8:
-		return EDMA_TCD_ATTR_SSIZE_64BIT | EDMA_TCD_ATTR_DSIZE_64BIT;
-	default:
-		return EDMA_TCD_ATTR_SSIZE_32BIT | EDMA_TCD_ATTR_DSIZE_32BIT;
-	}
+	u32 val;
+
+	if (addr_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
+		addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+
+	val = ffs(addr_width) - 1;
+	return val | (val << 8);
 }
 
 void fsl_edma_free_desc(struct virt_dma_desc *vdesc)
@@ -623,7 +618,7 @@ struct dma_async_tx_descriptor *fsl_edma_prep_memcpy(struct dma_chan *chan,
 
 	/* To match with copy_align and max_seg_size so 1 tcd is enough */
 	fsl_edma_fill_tcd(fsl_desc->tcd[0].vtcd, dma_src, dma_dst,
-			EDMA_TCD_ATTR_SSIZE_32BYTE | EDMA_TCD_ATTR_DSIZE_32BYTE,
+			fsl_edma_get_tcd_attr(DMA_SLAVE_BUSWIDTH_32_BYTES),
 			32, len, 0, 1, 1, 32, 0, true, true, false);
 
 	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 71e19e20f1cb..3991956dbc11 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -29,16 +29,6 @@
 #define EDMA_TCD_ATTR_DMOD(x)		(((x) & GENMASK(4, 0)) << 3)
 #define EDMA_TCD_ATTR_SSIZE(x)		(((x) & GENMASK(2, 0)) << 8)
 #define EDMA_TCD_ATTR_SMOD(x)		(((x) & GENMASK(4, 0)) << 11)
-#define EDMA_TCD_ATTR_DSIZE_8BIT	0
-#define EDMA_TCD_ATTR_DSIZE_16BIT	BIT(0)
-#define EDMA_TCD_ATTR_DSIZE_32BIT	BIT(1)
-#define EDMA_TCD_ATTR_DSIZE_64BIT	(BIT(0) | BIT(1))
-#define EDMA_TCD_ATTR_DSIZE_32BYTE	(BIT(2) | BIT(0))
-#define EDMA_TCD_ATTR_SSIZE_8BIT	0
-#define EDMA_TCD_ATTR_SSIZE_16BIT	(EDMA_TCD_ATTR_DSIZE_16BIT << 8)
-#define EDMA_TCD_ATTR_SSIZE_32BIT	(EDMA_TCD_ATTR_DSIZE_32BIT << 8)
-#define EDMA_TCD_ATTR_SSIZE_64BIT	(EDMA_TCD_ATTR_DSIZE_64BIT << 8)
-#define EDMA_TCD_ATTR_SSIZE_32BYTE	(EDMA_TCD_ATTR_DSIZE_32BYTE << 8)
 
 #define EDMA_TCD_CITER_CITER(x)		((x) & GENMASK(14, 0))
 #define EDMA_TCD_BITER_BITER(x)		((x) & GENMASK(14, 0))
-- 
2.34.1

