Return-Path: <dmaengine+bounces-269-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4677FADC9
	for <lists+dmaengine@lfdr.de>; Mon, 27 Nov 2023 23:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63E95B2105C
	for <lists+dmaengine@lfdr.de>; Mon, 27 Nov 2023 22:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BE148CD9;
	Mon, 27 Nov 2023 22:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="L+Q7jJLL"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2087.outbound.protection.outlook.com [40.107.13.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7B51B6;
	Mon, 27 Nov 2023 14:56:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0YYhXOGmbbXa502h5dr5/Mv3dehK4PAdcrngh8/S3hz4HGNobmiq2Jq/GH1dMX9woXxS5fbqGLm7dBR27s/CR+sAQQRO3CAebYqi6on25sf5frH64vOzGF3GViV8uiJhTb6Cesi1LJvrG6Mwp7gLnW9NVKF6v+qgtF4DfzKMZUoLgWU/VZaZrz+eOu3iS2tlsNp+GctJ/xMLkXalrlQPTD3qp6NwIIWY34PhIDVU7uOqIl+QvRubTElQ861Im3qYMieTK6JcWszYodisb7Jzp3fKVQGRx185M+jCbxeGCUuIekh46oWUqpv0utWGFUXJ9Y9vW6mmL9ArhZtHfHPCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBP5q908Ng9LIH/wfPFsI3Scpoy1m/sgOEiCWyttsb4=;
 b=E5o8TtmNwBXiPeWV5e2SxhmibufXxBa3/6bnoSxLxvOdWIXsgf6P3sD5IlnmE9Vimedh7Y+OEgQGuFq3Vs7Pyy/TN24M21nY5OLo7ATtZbbbshEIvfT76X26U+N7ufqeonldfq196M5YqVCa+ljVZyRdCMUGLuU/2/Y4JOTfOqk7RboTEI0gmkf6xx3I1yxqxWRfwZ/6CAwIHjE1X9QIhVIVn7HQfyblt2WspQ+H6cGLJTuCBWVTz1bCMvBTsnHoIXTSZuia2Rdf3ZeWehzF3qC2Wfn3+KOmXYO1EXRZDXsf5vxtd3rqw3porKlBpRH+8aY5YlBggWorfhpARSzkKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBP5q908Ng9LIH/wfPFsI3Scpoy1m/sgOEiCWyttsb4=;
 b=L+Q7jJLLbjaXlvNzuGRvmKLHaCWgfVQBFmlEKTlyTmQ43d6r7rkK1LNAJSyQGpkT6TguMf2t3VJPc5uXoCbVr8UOsqXAv2gxv/2ukGcwPOtOLSve43SBkhxfJhVFPLWIw6/N/W6IJlyXkf+l2tvWWnQnb2UzsJxQekBdB3S8UrU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM8PR04MB7858.eurprd04.prod.outlook.com (2603:10a6:20b:237::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Mon, 27 Nov
 2023 22:56:11 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7046.015; Mon, 27 Nov 2023
 22:56:11 +0000
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
Subject: [PATCH v3 3/6] dmaengine: fsl-edma: add address for channel mux register in fsl_edma_chan
Date: Mon, 27 Nov 2023 17:55:39 -0500
Message-Id: <20231127225542.2744711-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127225542.2744711-1-Frank.Li@nxp.com>
References: <20231127225542.2744711-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0116.namprd05.prod.outlook.com
 (2603:10b6:a03:334::31) To VI1PR04MB4845.eurprd04.prod.outlook.com
 (2603:10a6:803:51::30)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM8PR04MB7858:EE_
X-MS-Office365-Filtering-Correlation-Id: 03b9308c-5989-4e31-d4d9-08dbef9c0ccd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/B4jBi6CYUz9hdJqBA9Ywpv9plc486xKzPSqGCH9C5fUWtjWohfUFLuV7sHzuGsunQDBTsLniRuGMIAMOAMBKLS44km84xebSxaXHbXQwJObLNpJaI3Xo8I407bOrsMJ5ixp4oS8J0q+bJujeGvyqS0ciMdJQ6/NzD3EfB1eDH4RgjEOJexFoSjv7bhPYbZcvgiYgaepBZNRyzaS6+xRof86Y0+WuQJagbcbTqVwxTAFH8GD484mU6xGa/NDepMm2nyy7NikpqMEYp/xGeC48lm4eBtQm6Qggfh5fGIT7h0K1BQYaPA8x5d87mU7c1TRpqWDQTxzOwn620W7FoT5gxO05VUuVlmAoS6ANKKNh3G2MH7Mv1K05/KFyHZzGASfWkhmibhbCGrRNwt2IyERV9Oi6L5pzH/eBV1KaI6JWXUPspNXIYqZhvRVOsWVh9UUR2+zRHDio6/s/A/BJ8GLEp1aS+lH/CFBlbKqFBGECjRsx31LcgGfWencWr8jd518ZRyaA57HpEBVUUSRFYffEdbO1OaSUWrzxfOBKUxfDBbE5OgP7xOqi5Rz/MuKJfLLM8rz/5WYJXuZl5UCdL4mc6hc/alphsCi1aototGogF/D9MkhBp6ILKBU3iqEqiMO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(2616005)(26005)(1076003)(6666004)(6506007)(8676002)(52116002)(4326008)(8936002)(6486002)(86362001)(5660300002)(478600001)(316002)(66946007)(66476007)(66556008)(38100700002)(83380400001)(6512007)(38350700005)(2906002)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WrqBtUZbVVZZajgLDblA4F+JyPEujvneT0j+/+ID0WtToulkrbkrabghxDT4?=
 =?us-ascii?Q?SBSe6b/xAYO9oc2R9ibMkDqqUTecesAg4Ja9hypRMhAIzH21qQA6+2Wd2fz2?=
 =?us-ascii?Q?qFN0vILHqe7HlHxqrxrWh2hpJlQl9/PSIW6RGS1O0Cmf1a98ATmwlvE0jjZe?=
 =?us-ascii?Q?BdXIogaQvL/MxbljMZ4T6dz0bVynVT5mCYlICg4xadv8KNZiuHAiZib4FUBZ?=
 =?us-ascii?Q?dmF9HD/gpmtOKR5nNwVyMl+8oMW0DkkesqhmDh7esqz3zuLqH+OSKMWD3OCy?=
 =?us-ascii?Q?4T2o66h43mmJPwdL/zBf967yP3m1tfgTxhyO6IUktnpOd13W+DkMkTiPTpWo?=
 =?us-ascii?Q?XnSyii8BDe53V3SSNmpCIPPdz+mTnxaXNVD79syQz6TDW96whUN3nnDhejLY?=
 =?us-ascii?Q?mbX7d8tgDLVHKQOe4Slse/bcYp+vUsv3NM2LOwAU3nhHjbuuvx0bsKnU/d5/?=
 =?us-ascii?Q?tIxVgaIO23M1DDo00nIgngWqNYUzojl9smdjfiL4vG3wgff1qzaNd3ALL9Kq?=
 =?us-ascii?Q?agRQjuPOTRl1d8lmCZq5HTtt6kkQ+yC9XnwX8xRbFrMNQq83RX+0Rpg1hHBk?=
 =?us-ascii?Q?6dZNpCd/zM/dchLKTd4BV06ETg0XI3g8WV9VRbLLN2of3LQy8hIGOKMekOOf?=
 =?us-ascii?Q?tz6U1N7QNoMbjG8vlydtnGtlKXO86XvFTqGVXcgY7N91cf/EP1bjGSsW1/rB?=
 =?us-ascii?Q?LtQr4aSboezTc6KQf9QkKoGKlnZ9e8enbuBvbFCAefwTBkxQAe6eVj/oPyeQ?=
 =?us-ascii?Q?hPRBiWjJG2+oeWSStr399hNwoZ/+oMm2/WheVHxo7beQEbu1iInPAQwlnqce?=
 =?us-ascii?Q?oEBwdOpq6OpE1QSP1WPrj5nz8QjERtVFSArl4z8nVB7CuXAExpA+OLT8XPr7?=
 =?us-ascii?Q?2soaiq4Z9GpaFTA3Es+js7JSS8btQWRWU6If39kZaV2iWdAAGnIsxNjHy85I?=
 =?us-ascii?Q?NNFZ7YHOc8W3XnANwIjqMw3pi68YKyQ2SiMPqS0UJyrFlL0nLZys0dXXTbuz?=
 =?us-ascii?Q?/vIO0nLP82M9dToDuKRZaF6Wlcf/HSkzJdWn9bp0ZGCEm2AFBbrmU8ftF5yY?=
 =?us-ascii?Q?ELXE6BSDQx2D6dC9wK+O0OSPGuXir1GyipIyhzn2I5hpnnid3J77d9ublEmK?=
 =?us-ascii?Q?3lTFCwNZ8atj3AVOFaLpjP9iOt7xP2urL8AOMItr6Tof5scGObMxwlndE2Pq?=
 =?us-ascii?Q?eIyL7uJxs8bzmjBrATSa4Jsjz50cPbpSuo8blCA8h+vwaruwrBCy4J9W1ZRU?=
 =?us-ascii?Q?1QWppo1E49GNFr/Ixduv9QPsSBDRNhc+nKrKW4FrSnTNm9Mc3c7QfIa4a+7d?=
 =?us-ascii?Q?tCm8OXaVIA10asiXmm6C3lyd2fT5/jB889AVVPx4Q344IL8T6lxwNeL2VU/E?=
 =?us-ascii?Q?dBSizipzRYPJP2bgBjfIj3kBhSoaT4SRbwN9BBTDE2yOVF72b9v4+0tuTPSc?=
 =?us-ascii?Q?pafNMf2VanPw4TO90vLbP3VSOkkQrnfmk+9bv/rWtYrWHFxYJ+uFNsy4QlQx?=
 =?us-ascii?Q?fKI7nE3gJ91iP1gnVd0bwrxQfG3TekUawgkI0XBrBPuc+DS5soTZkoegZwUx?=
 =?us-ascii?Q?9DDfmJulXwFr27kvtiQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b9308c-5989-4e31-d4d9-08dbef9c0ccd
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4845.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 22:56:11.5696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B8x8YrbREG8KRG4eOXB7TECK+TiHMHzo4pPTnUH8sVfyOpx5p86Zp2atWqYTXQj4Myf3S9ya5mfMOs6ck/jxDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7858

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
index 50f55d7566a33..65f466ab9d4da 100644
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
index fb45c7d4c1f4c..4f39a548547a6 100644
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
index 86b293eba27c2..d767c89973b69 100644
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


