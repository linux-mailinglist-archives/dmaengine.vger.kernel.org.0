Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A592950BA46
	for <lists+dmaengine@lfdr.de>; Fri, 22 Apr 2022 16:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448742AbiDVOkJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Apr 2022 10:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448737AbiDVOkG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Apr 2022 10:40:06 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0655BD2D;
        Fri, 22 Apr 2022 07:37:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFSt/3YrywSdOqGMOR1VedR1wmY5+y1jtY6H4SI8yuXg9gr7z8QN9jQrU45kPFgL2FuuXorQ3aXTq6kUcmgWP+eNITlNxoPnXB59SKCnfTKkdFQqAAn9OjfMF27U39tCbuxxEgDPy8S3N7jaQsoOamdnJuYyWbY8r5Q0C6I96C/rE9vJzEVQxoRNHY0m618v57VRC0hQyjHzQ3E3V0Pg+bThZHf1k85s8LF4W7Q8/JqEYrAjMdDXXu3nndTesprJZM/zdQdhDrujeXBoJpqD3sxFeUO3sv9/DG2fajjDm6TClNs0000B5MI3/yJiHBFsPglRr05GZ55l1DtGvycGpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OeQg9up3yRYaa4s60yiPI3Uu0GpexL/DaWI/DdidHhM=;
 b=AQBjyWe0wR+vPtWG5uN8e+d46IkW41FoKMxKutUvb/FgFu1bcdDviF4TdDJez6Y/jbPmBTVLtNj29KmkCcghsduKc6jugHev8+w0NdgjzyNMi67e+Hy8xiSMt8ggPjugIdak5cU2QSHTCd/FyyWEnMX2hpueRQjdh9M1d5vchzn8qXk3YvspJr2brCH00SqyScJJun8l3ZXtNzM6tJXoZDumAG1xCEnnaMiaCDSjOhfGAdV3C9RGgxg6iYanyOw+rUGSTntZR8C2StL57NGv0BJ5GGoMR4T3AH39vMTUoNBtKZifZrIrfIOxPHXUv03EKRvtn9gJXtUYKgKZmMHk8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeQg9up3yRYaa4s60yiPI3Uu0GpexL/DaWI/DdidHhM=;
 b=GTSWRdpk9n1+mX9DAeHkDFRXC3YtQ0a7a7gEjqPGbNa5t8erWbtdXVBm0bmiSNtHormYT837t2BexdZxSS30jUn0tZoIuSe4CV90g4Dgfm/rWEBlqCa7PLUioYfClWCnhno4MfrmQpsp1XsT1AVoZfXVt50ifGBh/1//+7tsHuw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by DB7PR04MB5449.eurprd04.prod.outlook.com (2603:10a6:10:8d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 14:37:10 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a%7]) with mapi id 15.20.5186.014; Fri, 22 Apr 2022
 14:37:10 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v9 3/9] dmaengine: dw-edma: Change rg_region to reg_base in struct dw_edma_chip
Date:   Fri, 22 Apr 2022 09:36:37 -0500
Message-Id: <20220422143643.727871-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422143643.727871-1-Frank.Li@nxp.com>
References: <20220422143643.727871-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0063.namprd04.prod.outlook.com
 (2603:10b6:806:121::8) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba8b6a34-f633-41cb-4d30-08da246d956d
X-MS-TrafficTypeDiagnostic: DB7PR04MB5449:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB544990CD56B24DC5D445768288F79@DB7PR04MB5449.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Of6+9R/BoOcHjH3DdMF1YOa1v8qTMq9RHK035qE3D4eg32q8CBcpbknrNcMOg9ZXb5obCzCLDwIzDccGwWC0nautoveFDt4aItmbaTCMKtaR+lSyXn5d0hcZ+Y4bZR9RhSmEh4xjpyyx2trMRrfv1Mg4xOTshygVpbdpuruMeHpQ53zi0OK/ao6cQdrDxdSu7YX15A3Ss8Rj2eLb3BToOcfS+F8UiHyUSsnN8eLLSLzz7r5ZQDlBskoHdFPMOkutKODJIqIkQthH6GNrAL2y4gHU1Ar8BivpUxp/fR2qY+p8LF+jgwyPis5gjZFh/rnIjfQ3IQ5ALe1tsvKsYkuTPDujh1zk52rKOOs0Sizz3SxnP9VJNlaT/tpQc/q997603CcRFYIEbf+bfK92h0SwcMkiiT12n4AM9roLIqjX5eZrNJaumni7QxEkpVLYnYxh1VCyM9xoXwlJkCmhULx99GVu6xRJtnbd6tY/OuPRSHsOrbe5ShevZnTg69GexAifi5f6DLWb8m+dvfyHydSvHmlfocyVwe6431yet9inTS/yXesn9vNxFpPJ82w2VUqaEX61/a8gWieuTPe1BK8+U3I7VprEVB6TV3z1UMyeNRY0PaID6KCO/t3KpGFUl/+3z4BgDNcqp2ML8+TeyglsDEXkTesJTdgt+0aprQIYH5OcAuobhn39IS45bOLJluZ9QYyZ5ytFgFy1rMpPczuLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(4326008)(8676002)(66476007)(508600001)(316002)(2616005)(6666004)(6506007)(52116002)(26005)(6512007)(8936002)(38100700002)(66946007)(6486002)(86362001)(66556008)(38350700002)(83380400001)(2906002)(36756003)(186003)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TVrqKQZ0YHDyW/tiqB+TIyZXC4cGEfivuIZCdQ86iC7INYOgBPiaV4DdUzcT?=
 =?us-ascii?Q?E4Q2O5xAfKcve0CcOkt0b/9EGRdR6A6M76kh9OgORBGaUbMxZfq8LLJUVSpA?=
 =?us-ascii?Q?6UzyK8PWHBFKuoxmeg/x/D4E/enx68W1gCmjZ8OGO4RA7jblJWrRDpcBAVoJ?=
 =?us-ascii?Q?xAohJELoW7o9zsc4RdG4paM52vJTc8HBLxQZOHX/GfWNRLWNgh0He+eOqrjx?=
 =?us-ascii?Q?b7zyrM4lmVvduh7SO2cheLiTJWqA1LYIppL8Vm/LcQKn+bV5f2h/QRdTjuTB?=
 =?us-ascii?Q?OmpDYBIKqD8NaKl8piIqEPng8fByvTlFrMVD/XnTNWwIrhPuxK1y1qYM0z7L?=
 =?us-ascii?Q?R50TCduRZppxN/9R/nIYyEAKsIBMY5zQItOh6bC8wG8yjgJMZ7OwGvwfT+kb?=
 =?us-ascii?Q?SVYi+Mqu4FlEPuDKstLukj6fgJ00vOOZ3j1ThEK97V8Plv8SuTWVP+1Xdyy7?=
 =?us-ascii?Q?rN2CMqnEBJ5h1NnQhJTzZS6xxf3xPYQsrIl8Y1HCQ4+9CfLqv9jZ26CY1/Vl?=
 =?us-ascii?Q?0NvLd5T+q+hBpBW0pt+Dy4ZfwW72Az7ywlZdro/CsRQ48srg/Q9+GwXLxVya?=
 =?us-ascii?Q?4TbcsBdNU4mv17Y7uiKwJB7jjZjoXaqo7bONNBS4iBdzbCvzf5W0quesCQ6A?=
 =?us-ascii?Q?o9OOmcw7ynqOGeuSepyva3YzIc1UmfJc+9Vyicw9eqLShRiaMjHGhei6LpI0?=
 =?us-ascii?Q?0kYkwzRrG2eo8bXR4cL4kMn5kGIvwGYR7+yxkOfPqjh3I5D1S3p1lhRdWsGp?=
 =?us-ascii?Q?PV8FCicMaUl19AJy4j9Nxqs+Gs72xtZ5oUYOR9E3IoTCTtCcDVPSNm8a30Yy?=
 =?us-ascii?Q?imnAjAUtDudy4Uz2jGS7ZDNImM6w6sdippU6lanoidZ2Cibcw3QozkSw207i?=
 =?us-ascii?Q?hr3sNkfGwUiB3uyn37BtVwg3iZYlj5iNyYIounSLuziDVT6hn5gjkn1q+TyL?=
 =?us-ascii?Q?v3Go+L8+ZtnJUgmrCAnkzNjXNFgbd6eOcQcFLjN2a8a4MUrYpdBOqZe7MitD?=
 =?us-ascii?Q?J7uF2cNqHH51LUjmCY4tLgtVSlig7hGES4mgeS9uTEf36e+qA96fZGgM1xnu?=
 =?us-ascii?Q?sRsLiHJHv+mSZsIwk2vswWXVfEmE5xpiIOoCXz6mz+QmJDIJruAwTtOVs+/e?=
 =?us-ascii?Q?3XcsgwCVAyk2t6Lx0zOvy+ozAjb+PSuGFcj2NeSb2WkKu30w1hP67g/mDsGX?=
 =?us-ascii?Q?2UlnInFIf6BSwdiD1KvcYi8JNgehhoF2iw5SswIgT/Mso8sOiFVVn8CzUZIc?=
 =?us-ascii?Q?CLHfL0mlO3MgwKtQ3sc1/OiyW7ErwfFNcmCSiPhq5jgBwTH3MlBS5bnZJl5Y?=
 =?us-ascii?Q?S41pH1sP23iKIn1EG1TPVnCnQYU9iezYG/ex/279argpI3gBeBicQoMODVM9?=
 =?us-ascii?Q?FnPhs6bI/mZ0hd+bYq/66f1t7W+My8dAD/mCPc567Q4NiSMChkvjqf1h+/rM?=
 =?us-ascii?Q?r5YJthQhJFZVdmkg41jGQM+r+DDueITWUu21nSRLDUySOtG4DAk5E3Co4CHK?=
 =?us-ascii?Q?mQeRO9o4kTq9lLjqh/wy/8aZpoP9zUTJ3B+flDgKzaGgnrLh4t3Q4qp2JYvX?=
 =?us-ascii?Q?8fSNNGsUn5rCh9HDkOCx9oZ8uIwlw8TaC82PIAHD3mu+zBiBJP8ojw37zB9z?=
 =?us-ascii?Q?TtIIskaMEQrT6zHySd0GQIir92XIsHd77NBKFbyU3qn5F4369y7SFZCIxu52?=
 =?us-ascii?Q?ipq57+pj2JuZU621vv1KeukbGB/Z7eIgzCGCWzpSmJmb12omx9tybLTOLKXC?=
 =?us-ascii?Q?GColDzGaLA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8b6a34-f633-41cb-4d30-08da246d956d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 14:37:10.4756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qArWW1tnSuKLsJ5siDkZpTSQ8ypHza3QEQodNyTFVtLuae2tTmxwJaeoTj6acjHSamS6T7Yk5XSnV/nulWw4rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5449
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

struct dw_edma_region rg_region included virtual address, physical
address and size informaiton. But only virtual address is used by EDMA
driver. Change it to void __iomem *reg_base to clean up code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
---
Change from v6 to v9:
 - none
Change from v5 to v6:
 -s/change/Change at subject
New patch at v4


 drivers/dma/dw-edma/dw-edma-pcie.c       | 6 +++---
 drivers/dma/dw-edma/dw-edma-v0-core.c    | 2 +-
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 2 +-
 include/linux/dma/edma.h                 | 3 ++-
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 2c1c5fa4e9f28..ae42bad24dd5a 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -233,8 +233,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->wr_ch_cnt = vsec_data.wr_ch_cnt;
 	chip->rd_ch_cnt = vsec_data.rd_ch_cnt;
 
-	chip->rg_region.vaddr = pcim_iomap_table(pdev)[vsec_data.rg.bar];
-	if (!chip->rg_region.vaddr)
+	chip->reg_base = pcim_iomap_table(pdev)[vsec_data.rg.bar];
+	if (!chip->reg_base)
 		return -ENOMEM;
 
 	for (i = 0; i < chip->wr_ch_cnt; i++) {
@@ -299,7 +299,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 
 	pci_dbg(pdev, "Registers:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p)\n",
 		vsec_data.rg.bar, vsec_data.rg.off, vsec_data.rg.sz,
-		chip->rg_region.vaddr);
+		chip->reg_base);
 
 
 	for (i = 0; i < chip->wr_ch_cnt; i++) {
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 6cf6c28ce0cc9..c59e23b9f9fdb 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -25,7 +25,7 @@ enum dw_edma_control {
 
 static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
 {
-	return dw->chip->rg_region.vaddr;
+	return dw->chip->reg_base;
 }
 
 #define SET_32(dw, name, value)				\
diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
index da88958399a95..f59e7c37feac3 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
@@ -287,7 +287,7 @@ void dw_edma_v0_debugfs_on(struct dw_edma *dw)
 	if (!dw)
 		return;
 
-	regs = dw->chip->rg_region.vaddr;
+	regs = dw->chip->reg_base;
 	if (!regs)
 		return;
 
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 6fd374cc72c8e..e9ce652b88233 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -39,6 +39,7 @@ enum dw_edma_map_format {
  * @id:			 instance ID
  * @nr_irqs:		 total dma irq number
  * @ops			 DMA channel to IRQ number mapping
+ * @reg_base		 DMA register base address
  * @wr_ch_cnt		 DMA write channel number
  * @rd_ch_cnt		 DMA read channel number
  * @rg_region		 DMA register region
@@ -53,7 +54,7 @@ struct dw_edma_chip {
 	int			nr_irqs;
 	const struct dw_edma_core_ops   *ops;
 
-	struct dw_edma_region	rg_region;
+	void __iomem		*reg_base;
 
 	u16			wr_ch_cnt;
 	u16			rd_ch_cnt;
-- 
2.35.1

