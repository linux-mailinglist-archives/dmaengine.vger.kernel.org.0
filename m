Return-Path: <dmaengine+bounces-604-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C8E81BAE6
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 16:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96C9A1F277DA
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 15:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8351E55E53;
	Thu, 21 Dec 2023 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kAkrHm3b"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2072.outbound.protection.outlook.com [40.107.20.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E87F53A02;
	Thu, 21 Dec 2023 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/2nwBNOe1yVO+0+z410JLkLkxZ7c0alGwr7I0y7N8hHMbUSi8QVVLyhX4uBfNfzB5ywldIFIF4NCAbP+Pb4npSrWfW2wFxN9wamqVHKQ7OglEPfxdAfZUIE1zqkTviboT1zcEMDhcPaLIJC1WmAOZkvW5jDMUigD16+JRX3CNViT8l3ozBdYbhxKDZY4vI9wNyT8BxTu2uuoNNcSlaXKVqSiU4kS2kvHMoSt8FlTMQHNIWEsvw7RpxdwmHFGkrR7edP2sK5ygvWOAq5kg0/QtKwLLYCvEBxwRSP9NNZKtr0LvhbeVwx2NJP/E+T+wFYNnuhjpp0nudHY2c/geceOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qds3eitbV+VPVhcvy3TxSQajrWZgbp8jt8fKBn/jmZg=;
 b=kKEe95sLHA05/xQiragSCZUOkxIQp8MK5It0zfevZGZWobltiec1zZANAuswWSZ696s4SUlPg8+JkdQnvgwRoNcB0IyNvQkySUcApSgResoYEjggibBOFYZrF7N4D9eFpCf8OuRwWvI/kPwAIkR0qL7lTKH45xSLbuPE6Hw0xzGmmFbossG0MtiqyiLLDM5TKUIvLHJyogZZMIZvCaafQI8xtGvmV+12MSEME9cNBYIDKzadVaV51SPiYSp3QWjpfF1U9LSlJ1wMz2fM8Q4NqsebzWzinFhUpWNZ7L0z5oHvIazBhbqzd1It5ueUgGK9scM2TEV6ef70HU2HaAl9eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qds3eitbV+VPVhcvy3TxSQajrWZgbp8jt8fKBn/jmZg=;
 b=kAkrHm3bZ4FTYX9r1UpaE4reollbylIJCf5ELoQuB8vv36SrYfWU2DXygd7wR6lLB34wU9HSL0PS7HsYIzreAeFvuqbh7y68pzXtj843JR/lV7GbQSn5oh/h2bbnOhb8iPcj9xjGFk8RrPt/rhCWwbemduVj/7T3DWxRwClYOkQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB8194.eurprd04.prod.outlook.com (2603:10a6:20b:3e6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 15:35:51 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 15:35:51 +0000
From: Frank Li <Frank.Li@nxp.com>
To: joy.zou@nxp.com,
	vkoul@kernel.org
Cc: devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	frank.li@nxp.com,
	imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org,
	linux-kernel@vger.kernel.org,
	peng.fan@nxp.com,
	robh+dt@kernel.org,
	shenwei.wang@nxp.com
Subject: [PATCH v4 2/6] dmaengine: fsl-edma: fix spare build warning
Date: Thu, 21 Dec 2023 10:35:24 -0500
Message-Id: <20231221153528.1588049-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221153528.1588049-1-Frank.Li@nxp.com>
References: <20231221153528.1588049-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0057.namprd17.prod.outlook.com
 (2603:10b6:a03:167::34) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: a5a32d75-4a75-497b-20e6-08dc023a8376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FjquVtBwTm+nf/HOE2BwKSLWQr4Oj1Yt7B1BFWj9cqrfnUuE2MMkJTQVnJ4Qg+in1LVByk9RsLfI6etOx0KHpoMsBC8bMk3vRqgbAew30OgOTJ6YJzXHCQxo+PM7eVOqNVKBPHk1OmdKc65AbWbTlB6y7IJmTUMF39HimX8xLA1PfOvl/hVhnH/1heQPfOeKQSxRUsgXnDDHWroa3Dzpg1gLZFUZYhCiLsK8WwL1FzOEi47tiQO5y4QbDLwT+Q6FvCMcHyeloEU61qu1/OZsgieniVXreYm3L3gG+OH6Ck9odRfrgW8vl+hNGLflBiRM06c1m1a+jQOn6GwgLPeSXypHrAZffCidrxhCfpxbVYYWangId2AdpBdsr3RhmNwpugjW5pOppc7cXxz+znRfFldth4e2/LjvGw4XZN7dAx1gMUumWmlT0y+AF53eIKlpcyizxWknpElKA8AmWOI/DSodAn4Wd14w0LHhDdu0/m4CIubdrWo1WuoVVovFCf8CMzJ6PrrA0iq8+gHpIovbAUmfl8FJ75yL1jGh1x3ooUl1RS2Pry4DEFLxT4z3mK02Nv8fT7XKSddRTxaz5+YuDRMhptLI52TzV+laGXQrBlVbgRSgaoHpRfpS8HESEK2qiURuxlH03Bw/3iGrb8KCcLMpX/nA4xH/nXTYsM7FwuE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(136003)(376002)(230922051799003)(230273577357003)(230173577357003)(64100799003)(451199024)(186009)(1800799012)(6506007)(6512007)(1076003)(2616005)(26005)(6666004)(52116002)(4326008)(83380400001)(8676002)(8936002)(41300700001)(2906002)(6486002)(478600001)(316002)(5660300002)(66946007)(66556008)(66476007)(36756003)(86362001)(38100700002)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8I+jrJq7gLQjhkI6n0EFPR0j3TGdOnRYth4L1IBg/zyg49+iGpc+AUlU0KSF?=
 =?us-ascii?Q?5G2eywZmfhtaZS8aj6TL2ra8bdwEjg2k9JigSIeJvCeLfmFhhjnzaW/y7p1Z?=
 =?us-ascii?Q?8sbF8DuC3+avLn4zVTCXQ28Jw5clVvnAMIyAFYG2FViRtpujPtrc7OxTIf4L?=
 =?us-ascii?Q?jFAjkFNJZTtn56aP4OpmllVhZ6oV9iUTdz/JOvE9gi7NNLrf698LjCBEvWhf?=
 =?us-ascii?Q?swLo368cBPb1DkJOL4lS04mEYzZOZMISAszXXjwKfClvzriUG8QTKULgooGV?=
 =?us-ascii?Q?Pi3DGDkgfEDJ6hW1J3dBHkbbSVjSzWNpIByl1l+jNJ3+xg6UvDbR+pD+Xem2?=
 =?us-ascii?Q?rjB0FHO+pDBBOwerXbP5wy58ihFBPo4+weaGNU6IFlojLYeGRGeMJv+8vl06?=
 =?us-ascii?Q?2GxiOmienBMfHHc145iy/JWqIO8B3N/9JQmbyt3jrk0TC0QrKpRJykpryju2?=
 =?us-ascii?Q?72O5uvkdOBqWe1z0oLET+SdMl0jElLSsqsupUIriLNZiq+uw/qDCZlCSUYC6?=
 =?us-ascii?Q?jCeKGJ2kklI4r3Ym6CBXTdWI1slSUytgguNi+UorJHuIJBY/KSroXJ/gVUzQ?=
 =?us-ascii?Q?DFVkt2JD/C+Y6etPeT/vt5HILOLVE5vtlsfHBIBt4uuwW0CNu4sXbZsiVUnY?=
 =?us-ascii?Q?QI/IDmpNUxZVUJGiBNlaFJpK5VEVip6ZwwSmRMryt3iMKXp/lyVXz2aZtRWo?=
 =?us-ascii?Q?HHB/4ns64D6BVFGx3hf8x6B1jSABprYss2m3TyGwH16pmSOUOHHXSM0yD/9e?=
 =?us-ascii?Q?Xvdgh5mmU7I0Qs18emQ6mZgqDnlRUqPuPXs6TskmtYvzmVxeVfM7H4RREXix?=
 =?us-ascii?Q?3CRUNFJbzL2lPI2op0eKO54Rsbb/p/82DQTNznkT6pJh5UZVkbghdVSs+nND?=
 =?us-ascii?Q?WU53jW/zwGYLO8KgkHzrHZinwnYsndKE5HEJmfdR6eRShKiSf9rHovCizrRQ?=
 =?us-ascii?Q?CLY85msOdSN1RRHOonwEYe6g/2jPmTOqPklWx5lsH5bnftV+LTL/n+MxHm1w?=
 =?us-ascii?Q?7k4upU7uMk5sZykG5WtjIbDQWyKZSWIEGSKd8kQYqAjuNJjvF83dkLCUKY4h?=
 =?us-ascii?Q?4mB/zjdfA4vVRWk9TFZ+Jbz2qpVxtxGqdOBJkHyg7Y12/8wGE+/SeW3uI4Rw?=
 =?us-ascii?Q?UBxdpNbeYZgxYdyLXa1O3jDFEUtb/SsmE8ji4YAA2GRoLeH4UE1gUxSFLNlL?=
 =?us-ascii?Q?qynNrwRWIQJkpy+O992ZTLfqNlq1e+rpfMwDWRsxXuS4F4QYqZtHEUr36ojJ?=
 =?us-ascii?Q?VjF4gyXsOFIH77nCYtuG3e9fvr4l7ETOSNi5cwDUUUB7yGUwb6Yz/VZW26Lv?=
 =?us-ascii?Q?q97NeAilnsPbmYm62Jte2XbiJu0rhWfrVuYxTCpLw6eHHudsiIwabnPganqG?=
 =?us-ascii?Q?G7jLUqx11P71SRbFqX4PqfuDHDyGVWObRO/i1FkLaFP0CVc4hmYAaVnFgddS?=
 =?us-ascii?Q?NLj771L6voYXYm05k48FLsGsim/BuiUZgi81cSQeQx5MN2GEXV8tlY4GNQ0s?=
 =?us-ascii?Q?8mBPGMy57q0qfQaTbUiB8K3mAan1qLCv70amGXH8Vk3ntSqM4jchNTpBckhP?=
 =?us-ascii?Q?jjnjQBi0MCyeFdg8iEdxvNMIMbxQZmuz9cmt3QzE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a32d75-4a75-497b-20e6-08dc023a8376
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 15:35:51.8399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m6fT9mapuaSdxlcLTJ8hYYrKdliGPv3ciYZ0Trlg/+lUY1KtOsNgzzqsAPZFx7ChEa3rYoq8gO/Vew2qyuQkXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8194

../drivers/dma/fsl-edma-common.c:93:9: sparse: warning: cast removes address space '__iomem' of expression
../drivers/dma/fsl-edma-common.c:101:25: sparse: warning: cast removes address space '__iomem' of expression
...
../drivers/dma/fsl-edma-main.c:557:17: sparse:    got restricted __le32 [usertype]

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.h | 6 ++++--
 drivers/dma/fsl-edma-main.c   | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index ce779274d81e5..fb45c7d4c1f4c 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -243,11 +243,13 @@ struct fsl_edma_engine {
 
 #define edma_readl_chreg(chan, __name)				\
 	edma_readl(chan->edma,					\
-		   (void __iomem *)&(container_of(chan->tcd, struct fsl_edma3_ch_reg, tcd)->__name))
+		   (void __iomem *)&(container_of(((__force void *)chan->tcd),\
+						  struct fsl_edma3_ch_reg, tcd)->__name))
 
 #define edma_writel_chreg(chan, val,  __name)			\
 	edma_writel(chan->edma, val,				\
-		   (void __iomem *)&(container_of(chan->tcd, struct fsl_edma3_ch_reg, tcd)->__name))
+		   (void __iomem *)&(container_of(((__force void *)chan->tcd),\
+						  struct fsl_edma3_ch_reg, tcd)->__name))
 
 #define fsl_edma_get_tcd(_chan, _tcd, _field) ((_tcd)->_field)
 
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index f53b0ec17bcbc..86b293eba27c2 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -537,7 +537,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		fsl_chan->pdev = pdev;
 		vchan_init(&fsl_chan->vchan, &fsl_edma->dma_dev);
 
-		edma_write_tcdreg(fsl_chan, 0, csr);
+		edma_write_tcdreg(fsl_chan, cpu_to_le32(0), csr);
 		fsl_edma_chan_mux(fsl_chan, 0, false);
 	}
 
-- 
2.34.1


