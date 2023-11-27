Return-Path: <dmaengine+bounces-268-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7D67FADC3
	for <lists+dmaengine@lfdr.de>; Mon, 27 Nov 2023 23:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B68C1C20C93
	for <lists+dmaengine@lfdr.de>; Mon, 27 Nov 2023 22:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DB9495C5;
	Mon, 27 Nov 2023 22:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gvsuQzuQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on062b.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1e::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A0C137;
	Mon, 27 Nov 2023 14:56:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDy0poR0kzWEOHLkD1GgNlU1MwZsJkF8/DoVCW2O+wdQp6Fle5m6QhIXpMCUW8wLqqEr0X3SPMEiZgbRMBLQRuFQIefGpoX7432qacVBLlAhUMtJLHXs203xnAwlqIf0jyGI/njlqPoToEvspx03awZOaJQV/cx5Dm8xTEzxyTcq6oqYJx0lp2/u8eMzvsGldci7FPQo50A5P93o3pV7/KiyrSsr/smD9MyC2YQW07fHbzDsjjHbrVDDhWK6KdsKwoh6JmddubONF1svPkMhFO9C4+lleNaCgI098i57eFDuC9FycWTsURivMLkV+WIfCRtd8/6SWXF9kVSu3KySMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qds3eitbV+VPVhcvy3TxSQajrWZgbp8jt8fKBn/jmZg=;
 b=QZ1JX8Qgus9WFOYBfQ0WYSMDomNs+SJbA0kQfv9xu/KV211yXlxwBSOr5lH094YNEpN5hTwVK3ku3+NBj1uuYO1Zos3ljuA6i5hOw5pJGbp8nJB9YLRiBbZK8WVGpRNBrqnUtGdWdSZK316NStDZ/Yn0HNkWCgnYyJzhsn4YXwJ+ydNXIteu7NmpsZwI+SaHR2hWchqe7pPnbOHdwr5RsVXd8uzgJaZd88PikbL9lundqdMVW0n3K0hzyo2rVdko03zx2OEw3iBJtUVjE4ccRAMfJGkCfyA6uYkX9FDFiDDGOoqbnNnoAl2274g67I5vZJ2rrsR3DalzxQI/X1qcng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qds3eitbV+VPVhcvy3TxSQajrWZgbp8jt8fKBn/jmZg=;
 b=gvsuQzuQy9R07Y+CwPPYqFE89cauLz1Nmnyd6761FIFV4EZUPdB8fR7FGXCJeVsdoVVCt2VhRBYiWAqI+Vfvh8sm0zwBAreC2S40AeQjE6wegYatcGxIIPumqywCHmq6crI9EOgr+lKwEPkPP6Sw8GNL2Dh5S9F6cuor4GqrmiU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM8PR04MB7858.eurprd04.prod.outlook.com (2603:10a6:20b:237::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Mon, 27 Nov
 2023 22:56:07 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7046.015; Mon, 27 Nov 2023
 22:56:07 +0000
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
Subject: [PATCH v3 2/6] dmaengine: fsl-edma: fix spare build warning
Date: Mon, 27 Nov 2023 17:55:38 -0500
Message-Id: <20231127225542.2744711-3-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b69202a7-6150-4691-6630-08dbef9c0a96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BpzL5kr+9yYT707s0AC1FRVGw6/b/uzZ4ZFcQPV0HFSchwLArgLLJEmybRr3Y+X+n8yO8SfD2MZGffdAr32RQOkYzA8M+pfGlTWHeHpl+QfmRvWFy6/A9k+fqQ/ylFupucyf8UV2nf+mJ5AHilwOzmaiZAScuFPKGwXMJOg0JVTGAlHkIuYgGpPc2mZBfS+IkgOMZS4CqaUafRjFnPqDA+VYzYnmaTlS2uK3s1Kz8zbjEYmV1oGQJroEr0oEGQtTy3KkzrlftK2re7j76TIdrLyBDyGdWZApSkwOrybeZ+9tTHT3OIHbb6fCZxC7S6Cxmn6CsGrdwdP/1G6gRnT+evssznLHAORTAX4UR/PoXYjKMiem0co/RkQcO4C+hqcXYHxH2WrS6Bzax8JLie4TNMr174/tL/ySnO38id882s6dlaO401LovyRTbyk3IrWHQUggD3G1U5wlrREqPilKPA+tvHHbGl/FidpXcXFrAtUEVVjx10xJA75/m5v21sQLi5LjItlp7OZtRgTwNmT8ys+VQbXJyrMYDaoYWKmCvuBHmoOIvsTQwIa9umpX9Wgrnr/QkBsUp33SOfuP5kpK12vwUAn3x/z5z7Ksl28txybXhSybFjtD+iAyGHHU1rz/Tc+ZADxKrfUNYYDzDmXGmgx5D17gqVIbPJsRJpGdmXs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(230173577357003)(230273577357003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(2616005)(26005)(1076003)(6666004)(6506007)(8676002)(52116002)(4326008)(8936002)(6486002)(86362001)(5660300002)(478600001)(316002)(66946007)(66476007)(66556008)(38100700002)(83380400001)(6512007)(38350700005)(2906002)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a478hrzihM+oRmpZ+Eh7cv/0je8B6CzAVb1GAmBkkHuPOtebUaRwwlwm/pjq?=
 =?us-ascii?Q?c6Ojwame4XOI3xGlkQDEgphPTol6F0mKZTbd18QQny+vSzf3aPH0qNsLoHxh?=
 =?us-ascii?Q?AzuQEd85SzkPOy3SixF1/UOAQ2BAzDGaxBrEN97mnECkHn+rVJv5rbDwUckf?=
 =?us-ascii?Q?nJnAlVr0W6RlTazJHXsktd1B4aJ5TEW1uMQaBCwLeTC2Rcr5YqM361F8RuIf?=
 =?us-ascii?Q?5Vc5KNPhlJVU/TO2eT8PX4vZHJSmyHYK/hUa552H+h23MyX+iM5XdawNPRSs?=
 =?us-ascii?Q?dTDLqdMQPCoQYbirLmHqUxfrP7eoanv3vnnt8JH26wqIjoHINrsK7XxpYejr?=
 =?us-ascii?Q?EwZfRu9mHpjP0LcuF4AD7OuMfkozhKNIaZ2H0PveU3zOqArA2xE0wBMA5Gc/?=
 =?us-ascii?Q?MMr/xBJaKILTyva8pn1hcD4d8MRBolJRq4d9lBmGEhTe1ecf5iZo4inMM64l?=
 =?us-ascii?Q?HYo/6mstoDbA0ApVQ/1XCfaqllo1DeXKibsuM0NVMgFIY2R2zwak7Z5nNWyT?=
 =?us-ascii?Q?RUY9cqvllTD1ramSfkP1MpA88v4w+BQxjWAEygXDRIgpDKEVlFuGh4spJpuh?=
 =?us-ascii?Q?FKC6P9qCqanxdhv/ec7ljmOMYA4FFeYCAkDKhUC1AvH+YF605vWJVzuEPdAZ?=
 =?us-ascii?Q?iuNU+ga1cbMJMJZBXwqFNZFci0verLvScGO4thJgD2N7UDcBpe7Mr75gHYVY?=
 =?us-ascii?Q?PF2kwlC8ixN1j+tIHTDyouX1mRdTneJuc7hQx30j/4kHFnLQupwO6/uOJBj5?=
 =?us-ascii?Q?DEkvh8B1bsadwjwc0StY6GWmgRHbhWyAq1hvFbRFz+Xo6aGDjzVo2xtZURfP?=
 =?us-ascii?Q?fj60a2o7xlhyK8NXajZWtWgP1KICCwGccC3I5IIY6gv0U/LAoRKBni+GbBBx?=
 =?us-ascii?Q?7f08OyjgTVinuORv9EUWCNjep7qowlLY9qKe+s1QGu7mGlHawy6JvSAZfcQw?=
 =?us-ascii?Q?HK8cOkrOwPjECpthRUyLgKJmqehS/xx45Jygo3XSD06VHlKe6+R1Ey66QJFD?=
 =?us-ascii?Q?v5LTWNfF+Cpx/fpxpCR6XBoRDpOmDmsP2fHg+I/LN2D7I8Bnbocs3zpX4N6J?=
 =?us-ascii?Q?4GUp3OcKxyBU81lvktsw19t9iiTBMNH+0zWyMfWJUBbz+fvDiQDnVAMRp5Sb?=
 =?us-ascii?Q?UI9ZGVib2xI8LAj49RNnG06LCLuFGHXBxxmO9ECGKeKXlI/SRYcqxe0WTIYp?=
 =?us-ascii?Q?k9YNOsxzQKOIr9fn/x+tPuS3hXqvsMaM3Uuz9LJaKfaxref1RkFKTJ9MApH3?=
 =?us-ascii?Q?wnGiXsv9sTrj9QiOIMV39e+pH2wdqQPFccg6LPdUWcFDABFwZ2gi5ZVcz4ZV?=
 =?us-ascii?Q?6qC3OWkZ8cU7Zgd+1VNrLhK11NxyrXsUBahn1J4fIWSIVR/PLr7a1jTCwDTz?=
 =?us-ascii?Q?hHy3SHEW37xjLV5zJLLUIm539xVmEX8zBNHFOmEhmJcjyD/xa8VwFV+j3yfJ?=
 =?us-ascii?Q?YkkOhMBx6alKhTeQzelm+vMxPdbcUuj2zGxrUt9b34a9PAQZL8eNorigBGl5?=
 =?us-ascii?Q?FmmTN7Y0NnjEjclDFdyTNxwSfJbuL6ZZkugjYP1+Qui5qrXe4htffG/cCBy5?=
 =?us-ascii?Q?6EVyrK28fX8Kz/3/q4g=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b69202a7-6150-4691-6630-08dbef9c0a96
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4845.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 22:56:07.8650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lC4fXkTvtstSODC2gEa3xpsDPixkOt7z379ttgSIEmQvUdOs0rTIMuULfW2yczNvfRw97q+r12y0xU8vrdn8Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7858

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


