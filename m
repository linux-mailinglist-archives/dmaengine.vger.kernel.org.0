Return-Path: <dmaengine+bounces-3668-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D33939B8E8A
	for <lists+dmaengine@lfdr.de>; Fri,  1 Nov 2024 11:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 641DD1F263E0
	for <lists+dmaengine@lfdr.de>; Fri,  1 Nov 2024 10:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B001714D3;
	Fri,  1 Nov 2024 10:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dVXqDtpt"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2040.outbound.protection.outlook.com [40.107.103.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E051E1662F6;
	Fri,  1 Nov 2024 10:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730455460; cv=fail; b=VadEcYGFhgcPjsfQ5BNSbTNWl5DkNNKA/slUmDimPbolTWN9/ow/bFMNyCqdSpi/jUSDLE7DGRS32V9+O81mlR5tNgDIJvF8CELCKZPEKLbPuv/L97JAJJm1f3OiHh84MjBrXPrJmyaDTEw+Ph0mdWJxrIUqrPPvru0pHcROl3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730455460; c=relaxed/simple;
	bh=NXOskWM2QhLTNpRb7X/KITFT46yV8Q474IUSrhf/sOw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JASQqVwz35A13iBSkcHE80nplkoj09VzBGIafCHwTHjB3x1rwPtoxXqlj6YFbB9/iW7IhQMZmPPgmlth3wCN1gmd79mu2czXvKkpbLGW86uHCJp4IMUyaj2bnIC621QYsajDfWPNXjhTfXa8IFRHH/+GF2te1L5nlwA6EMtUZr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dVXqDtpt; arc=fail smtp.client-ip=40.107.103.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lnBfzFos8NhCRYIIsdSGQZnjtnPhBym6Rbqa+VyowMOCMW0djSbDS/INaxRAT5P3dLei41FsogEKC47OY4y3qeWwcj+gfN6cEFltFM9IEAqYwbIZLeDBlkX2FZRt+ghPq8HjRo9xsfh30CbMGoAQqwt4/h6XzLmFft/zVt92Ga8DvwHmczK5mGVD+f9jyH/fSYZnNEcgCxzbWC2q5bJmbe1GwjAyKzNKB4lxPSffOYWeKKOGS25mnqRmoUMVk2MLpZMJc7vGV1AOYm8ivjDtuRfXj1SbvEkGtDy7fouzIePJKEW+2WdS0ZaCZtBxPeHTMOYjATft6m7/0vsafV3w3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2w32KZwir+2E5o8hWSntNZYM+pmVTo2dx5HBwggLxh4=;
 b=BmxLk8mdAYMHd/Dd1HjMPYzH7A6NOblmwtcjWa+3insf+r4PP01uKMEOIORq0GPEWEGMr842b+NCfRza2h503xVTxkUN9nhd3xUlnyQvBqFKE58bJjEE08KF195/JVKNiwXLbeLLT2GflBK6pb8EY8dLOXGClTQ7evOw/edghzyeKQevauJMNmApmDnM/q+c2fh3UO4MRD532Otw7S0t3V46KdOkDqMFZn/O6ROtzLJZd607QF8bCY4rVLV4BmqmuL8SijiW+bywcNMLLQo66IAT/5QkuQN5F7wMSA1IkJ5/XOk5OtFdVojbVIR7Q5iriJ7JFCCmymgyl16MzFabDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2w32KZwir+2E5o8hWSntNZYM+pmVTo2dx5HBwggLxh4=;
 b=dVXqDtptt0alQUm6OCVPv3X+6ZD4NhemJe5FFr2Yr4jSrC4M5YZkxmxh0vhLuJIPUtiqh1N7UXc6/hnIoZ+jw1O6adycwvd10/yqX//jVGK0C8PaRlR+3YGdYhZBP71VawIcZfF3lyNbXhS8xy9wG9ECaOpejsU1bAoz8h1OZchNO56dMSTByeosNIyY3q8rs/ziBYA5k8K6pLIJC1GqGOOg6VOWu/7KsUyEWOrsbap3sezlN7If0EuyLOuidkKPVUrNJsKEH0SLW7kFlVyJyyPf3ghd95sCdvGmlN76m/lyGbA/owCoDYk9Saf4W/Et/D+FlWCEvmvW++HCL22QLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB7200.eurprd04.prod.outlook.com (2603:10a6:800:12d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Fri, 1 Nov
 2024 10:04:13 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 10:04:13 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	imx@lists.linux.dev (open list:FREESCALE eDMA DRIVER),
	dmaengine@vger.kernel.org (open list:FREESCALE eDMA DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] dmaengine: fsl-edma: free irq correctly in remove path
Date: Fri,  1 Nov 2024 18:14:10 +0800
Message-Id: <20241101101410.1449891-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241101101410.1449891-1-peng.fan@oss.nxp.com>
References: <20241101101410.1449891-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0186.apcprd04.prod.outlook.com
 (2603:1096:4:14::24) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: ba2c8f62-5e9c-4cf4-08b1-08dcfa5c8994
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QBHjZvx1HKSVljaWSJp29zJP0u523fIZAvgXBFZmexPz8lWTCt71Cwc0Jrlf?=
 =?us-ascii?Q?8zP2qkRUbJZw+aUQIuVLJU44UVHABowCDAviCFJB0AMYXhLisMWQxwC71rkI?=
 =?us-ascii?Q?KBeQ3RUfMXAzWyHoPWwtWRPCzOmR0YYYBgvc4ZqisRPHiRvUcbW/bhMCam4J?=
 =?us-ascii?Q?//EgNsBGOoylGkOVsEFt0T/9vht/oTfx9JoJsklPSb7MO0XMlyxnWcjzq1uV?=
 =?us-ascii?Q?HoZtDVT+hsxZIEH0cUVdUxja8cDejMrpq+2bky+nXjc8rF0UsLvbh5pF73jV?=
 =?us-ascii?Q?Hd1VV3damKGX8Qp2sAwrkbhp574H+tH13z4BmhD4MDDIwhrD3M/UXWtPFisX?=
 =?us-ascii?Q?vo0v2HvqM9vms0LjU/BDm60mwKFJJ8njqJX9NG1K1B9Ay1PpRTxA1hcZbODX?=
 =?us-ascii?Q?Uf6ofKe3i7TMN7AlGoHY8e+sr8n7KZpsPYHbz1JrN4ujEsDBQ/vaq+ceTzae?=
 =?us-ascii?Q?hSCrZX9an3SYhD+6W/LoBO5PlI2TSCTnWPesLJub0A1lrfXp/eluShHOnCRq?=
 =?us-ascii?Q?ngfIYuKgFWXKg3003X/Bfxrpbo5J1OMvqcMSQGUhkqaCn1/ptOq7OUhj0pf0?=
 =?us-ascii?Q?8r92YP4mUxSKJDI6Z1AAa8ZwbxhBUbHIsWeDgGz4Brn+bCj1YXfyUHh68i5a?=
 =?us-ascii?Q?dJRDojOBnl9sZ+FcvDRKD5R+xoErZqw60gQWuHXxQH49c6FlOw1Irrg8+99P?=
 =?us-ascii?Q?OEn82GOZaghPGReo1TMYXtZ+D9w1jFx4mdsjB5t5XMKpyhr2ufeK72I9WC7X?=
 =?us-ascii?Q?fS9QsNrxht27dUFYsAFpjAPs172u6vd4edwkerHma5sN0BT83OY30+nvcqxq?=
 =?us-ascii?Q?dTAg2OFcm4BKAtWYXS3OMuVXYpK65+1UOlRh1Qigli3vECpGMy7hrdoTu/Vy?=
 =?us-ascii?Q?ZbChGYQMZQVFd6htbe0z2lUJhonPjvMBsZWs7tG4v1Gee4TDTT+fb08X9H43?=
 =?us-ascii?Q?X5wpCDtRZAQWmd2LLdNDbluggKd4/UNJ/r9yLB46lQj8XmD5G4qlRS1H78Re?=
 =?us-ascii?Q?ojs98KxDCM5MNaie6mJkm6JJAVXlGXP3y0Po21Bbg2mysVrH6fhU5cbRK0vh?=
 =?us-ascii?Q?OCORPE8h1BZ4PKPW9VDbcn4R1CyO0VlzNK28HE9o25zFP5KRtpZ+zD118uAg?=
 =?us-ascii?Q?JjMWMWra6VseCJyXRzr5lJN87I8dSd2pv5XE9Bwi2AkilH+kH7PDQmYK6bdz?=
 =?us-ascii?Q?qvMJfHW3C4X0cumD4E7YIqhwRlYbDP5Rjg/AmhL2ueBnOHqCSAXG3/Kvq2+4?=
 =?us-ascii?Q?vQGF7oP2rbwHhVQkxCiJ1GxQSn2OXuG2+9xVAFLeBbwQ0JB7SIN5zcFEhNwn?=
 =?us-ascii?Q?BD0BwDLSves1+xc+3RLpYXP2mPPhtLQ3TnaEvFXgl4QtghmuuSLuLYAi9PCY?=
 =?us-ascii?Q?Fcjrp9g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AvzuOvmc7kOqTATXtpnshQeS2KEUW4jMhNCvaNZNUNyp1qvT3ZZHGLiSNkTy?=
 =?us-ascii?Q?3EgHPNPxoSNGPM5+zMuw/gY22qyHAJnTcoN6Jj3UIikKLp7vQLoi7fd56hT8?=
 =?us-ascii?Q?aXEztIDAOa9SrpiX00D/s1dTjB0E1TGkOapQZmUsWYFZNHmoMyLcGOWuh+Av?=
 =?us-ascii?Q?Q8dRFfrKlVIdnmNzbQyAG0XSz9hVxEqTutJPSthrvotNTQA0J6XxpJD83y37?=
 =?us-ascii?Q?rlcCcKGIbjKqoaewlPkKYBs0p95/sOtWZBhxka1H7vvI/bydZxkf8XkvUhI2?=
 =?us-ascii?Q?5QhOmcmU/Xv4WPehT/z+O+jic6luekV8NBU2rDhEOYv1p/t1aNzLHh4Msy0D?=
 =?us-ascii?Q?LbWPwjjTH+wgNf9e1qZDh4Wvh4NFCGtwqi3meFyVY8lDL+wg8+jUdsnqOBCO?=
 =?us-ascii?Q?4aAohMlmtel06SuvetsyFf9NljaS+jV8EwWcEJX+G6uDm2Q7VF35HVXCgetb?=
 =?us-ascii?Q?JZBU15kJ7bL6fTEbbvOMZMsq+Dnzf/g2Juk+xX9o5Q0Ldc23lOOGs8p5jfsC?=
 =?us-ascii?Q?Tss+ka0zNJvn1a0+JDz7rv5Zgc2JGALpOkbIoa64bx3F2fQmZZq7gWvgmc8A?=
 =?us-ascii?Q?upZW62nogzvrOYVKPS7zK/9tmn9sFDLXgz6rz5MIjDOaYPbBCVfKgfwOG/Ym?=
 =?us-ascii?Q?tiuLePVrEi8e+pGBRmPNTXkIPJexBBCzoJayWnTmQn8ougLqcQHDwnCJJEIE?=
 =?us-ascii?Q?B+VrUgpqSFbym/3iU4jYTQWaQEvP5OKC4VZ2x7BmldBWfT60VaoOOFveug3X?=
 =?us-ascii?Q?VgAqLclry7jhMcwbCPLn07JoIZRaZ82nu+lWJ5Ah771s0eVEEWsMKiK9EAzq?=
 =?us-ascii?Q?sRpmf4TUPCyFbq60CYfR53u03lj+uylC7L94t6dueWj87VWVABu1B3IhCh8k?=
 =?us-ascii?Q?ig5YNipDbQKmSFZMH7XrUBdC3CqTpisQ7WrONn3XLNd2Fv0wQh25K5ru70HJ?=
 =?us-ascii?Q?3lRGPkVhSEt2MLpno3rRNgwN13FsjduSR4FD4CWy2RUmKbpdzrNa/4z65sPD?=
 =?us-ascii?Q?6wjFy02qydDuWrf8FHFLhzHBhUYg0VPdAeZ5k/2IbYw1fz6ATuMpfng28ZrW?=
 =?us-ascii?Q?dCWpigfqPr7enI8CGd36PGAbIHi44A7u4BqZfYIRmKpT+NIxKRax5EbGtA28?=
 =?us-ascii?Q?gyQXYRZDBVhWiEMCt1TxJY9MhorFUlxbBYFqaWP2nAf82vb6Ikm8r3npr0jq?=
 =?us-ascii?Q?f3ElHf5grzGkow3Y+wdwbDh3x7FHNLkwtVOP0/XfJbzHDWEQ2YiMYfidIU7W?=
 =?us-ascii?Q?q9Ao0Udaj/XxdwsR91HqO9ITLhQ+NUauQhCMa80r1+3sqJ7yRf8vE/MjYD0e?=
 =?us-ascii?Q?xGX6vE1ojQ7kaosbaH/vbIxPeZ+fcVZt5HW3vr2djRcMnMb3U6EoMz+LCn6a?=
 =?us-ascii?Q?xi7nT+B8h4jq4ugeYTnRkUwJoEuPrx99JZRf7KChxdavSbTf2s8LC+chC/ZM?=
 =?us-ascii?Q?TM5LajZOnFxWVa7yDSjFYFXcsYBMBI16xJCnPiljiJ2ONwrisMnY98HXYPIV?=
 =?us-ascii?Q?JfaO2cqwTp2c7kqVJRx7OML1H6J0RhDg7hFOdpSiw+vU+1tB0XThFDRKPrRo?=
 =?us-ascii?Q?gmVMtEiaqlPrqXU/YNqC6PC8EdOBf12RBYiDDjtu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2c8f62-5e9c-4cf4-08b1-08dcfa5c8994
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 10:04:13.4801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yxx4U2pLEXNCeRaY2Ad6Hqodt5Uk7qbAwEHcuik5g1Y1+UL/5qcCan9/PiWZtnP+Asgup7CuZe2jzdV58nm6+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7200

From: Peng Fan <peng.fan@nxp.com>

To i.MX9, there is no valid fsl_edma->txirq/errirq, so add a check in
fsl_edma_irq_exit to avoid issues.

Fixes: 44eb827264de ("dmaengine: fsl-edma: request per-channel IRQ only when channel is allocated")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/dma/fsl-edma-main.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 01bd5cb24a49..89c54eeb4925 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -303,6 +303,7 @@ fsl_edma2_irq_init(struct platform_device *pdev,
 
 		/* The last IRQ is for eDMA err */
 		if (i == count - 1) {
+			fsl_edma->errirq = irq;
 			ret = devm_request_irq(&pdev->dev, irq,
 						fsl_edma_err_handler,
 						0, "eDMA2-ERR", fsl_edma);
@@ -322,10 +323,13 @@ static void fsl_edma_irq_exit(
 		struct platform_device *pdev, struct fsl_edma_engine *fsl_edma)
 {
 	if (fsl_edma->txirq == fsl_edma->errirq) {
-		devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
+		if (fsl_edma->txirq >= 0)
+			devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
 	} else {
-		devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
-		devm_free_irq(&pdev->dev, fsl_edma->errirq, fsl_edma);
+		if (fsl_edma->txirq >= 0)
+			devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
+		if (fsl_edma->errirq >= 0)
+			devm_free_irq(&pdev->dev, fsl_edma->errirq, fsl_edma);
 	}
 }
 
@@ -485,6 +489,8 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	if (!fsl_edma)
 		return -ENOMEM;
 
+	fsl_edma->errirq = -EINVAL;
+	fsl_edma->txirq = -EINVAL;
 	fsl_edma->drvdata = drvdata;
 	fsl_edma->n_chans = chans;
 	mutex_init(&fsl_edma->fsl_edma_mutex);
-- 
2.37.1


