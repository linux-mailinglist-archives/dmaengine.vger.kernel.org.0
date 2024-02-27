Return-Path: <dmaengine+bounces-1137-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D54869D80
	for <lists+dmaengine@lfdr.de>; Tue, 27 Feb 2024 18:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CBBB1C22E76
	for <lists+dmaengine@lfdr.de>; Tue, 27 Feb 2024 17:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B5814F966;
	Tue, 27 Feb 2024 17:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="a6mjFSxp"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2055.outbound.protection.outlook.com [40.107.6.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E07814EFEC;
	Tue, 27 Feb 2024 17:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054546; cv=fail; b=Y+an3t0P1SdbouRtX5b72DoZ+6UW5KCmjcx6+m7XAtnkan4BBFxnp8R6x8ZCqTqlAFOe37QtY7kasdbkYz5NYou3zA2gWJiJim5dXOFmGgLHq7BxEG7HOspzb3hTsBc924FH11jJCvSQrenZ/zdUTJxF5OI/wooCF8DKUr32g6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054546; c=relaxed/simple;
	bh=1SY1nKChJ4s31bmrpysVWazodvllDv9ahLCc/bCrYcQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=mn8mmxIrXeBoM6zb8d5b+VO2F/3AdBbQ4UfV7yCsB9fIe1KkwTZcg6azFOr/e+Dk+t1/kKSI3JgzYVe7RBe4btgX2fbUxCShK9DxyURkxL4ULrNYlDWTbnWJPwQMwFtCrIszKlEeZzODR3IYXAU0lzkPsh6Q2CqvdZBp2mCNxro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=a6mjFSxp; arc=fail smtp.client-ip=40.107.6.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XoLSCS9K9KZO/Nh3FfGUibTfKLXAvOjfZyePh/dQwpS9dvhJhLhNNV+GghZU1vQ9CHmaF268kQKTv7arPRm4pz26qAKVmI/Yu2f/wy4VkqiPbGJ8H4V6g25un1oUNyl3p7FP9FA47QmLu6TrDXm4ATODU50OxmKOS9POGpCNIfnuyd4bBzsPPUEFhlObSv9xqsEbp9AdE2hOkxXukxJTuPJazAxjcvalPeb0ayvLvGkYEG2B7xj2L2fHVYUplcIT6KuYRg49nUsmM2vFvSlyurAIlKj3eneF03pJ9ZlnlhSoc6qqXIqjm5YAfbTtU8VIuO+ulaRNNuXefRs90xbTcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3UHH8qhH5HTx8E0tLZorZnJnKCrjOdx/qvKkcds5Vg=;
 b=f9/a7ZG2PXSfw9gsM2d3YXm8GuhB3fRyrXpITKNfu6Rye1t3WoU8N7UzT/FksWwFVygs1wrKE6TTkJBvtlcfo/XnyxkU60wiXuTJrLELffvg0lVzSCtZqQSC+Bgq4VUQel8efTaS16j5gRwNqxw6OfL1cfWsH458RxEIRd3MNWK5gxePDdusXfqHKVvsgQYfQ3FMeXqRjn74SUxK+ZjUc2Yl56sQ51V2hXl6eJwNSwgLxPZBBsyxjyS/cZiarHFiwCJyc0ZlMH6CvbqgWpgXVZH8FFXSb56490ID7hjbiD7u/VjhkZs0Q+Fc774JFTO1L5BjClLPxNSRq8d0XvNzFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3UHH8qhH5HTx8E0tLZorZnJnKCrjOdx/qvKkcds5Vg=;
 b=a6mjFSxpn/kNrTXIwvhzuKp0tMreeOxL6ZHLpdJfymLcQCFqq9Skom6hNde2jw5JKYvJ7EKlxDKEJrSyFnbZdIB31dwYMiYECEl93Ngp0DDnZo4rVq5q5G8MRlb4u/Zg7ctNEShWXTn81KPL80tsZ9LIoszJytdRCztUykKUGYE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9408.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 17:22:20 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 17:22:20 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 27 Feb 2024 12:21:55 -0500
Subject: [PATCH 3/5] dmaengine: fsl-edma: clean up chclk and
 FSL_EDMA_DRV_HAS_CHCLK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240227-8ulp_edma-v1-3-7fcfe1e265c2@nxp.com>
References: <20240227-8ulp_edma-v1-0-7fcfe1e265c2@nxp.com>
In-Reply-To: <20240227-8ulp_edma-v1-0-7fcfe1e265c2@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709054529; l=1717;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=1SY1nKChJ4s31bmrpysVWazodvllDv9ahLCc/bCrYcQ=;
 b=SUHRhItUXSezjubWHAqVf5qJ/rX0X9GklyZ6dfXPFRI2EpL9uu/bCUzk8zGIHM+CqbjaL0+NO
 WQwPdHi16j9DW4K+Fmcv35VW4exNZ8FF0g/18SvmWA/tk2GgvAuBBXO
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0059.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9408:EE_
X-MS-Office365-Filtering-Correlation-Id: deaba51c-722e-4109-19de-08dc37b8a774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VeBPVa2j9ithHeMPnCgKcEMO7HeItGwsuj4ywfcK+ZeNVcwGD+ONMqxXv1KvwYTgBOKAunJhnWm8ARGTDkKY/nFi0QMekM1AOedDLfeb5Pn2/Xcz/cqxhEZ20Wrb/D8VC8/5sV3L1bR5S6XR5XbUCCG+Ar2z1s3ylc61wC5E6JO3GsxgjVyDNbO6JShEGijpSLWVx5XZahyHWIkhrFjSRHpN7U0SRmY5QvO8wyrViPCfq/cnwg9CT3D2TP1kDM/2nYfJV9VHfAyNm13fHuqaZMibMip1jK5h3W4adK8toeIczYv3pCGxZQVunsI+LGT9TEaTi5yMGhkIq5Qc31IcX4VOz3LBTqqTQv7ccDhn/df7zVXa8g8D61IIAJE9KKfjxhK7HxsoUSxgjk32G86aovyov0eT2hZPQPbMUtiGeoLI0x6gCOzSG1jYen847EmuXHZOkzG8YILel1sYgydMnzU1OU6kla4kGRY9xQ+Q1b+H2Pp4iZwyoExmz8ua+4mroOSodCALeagqVesvtjzf64nkURszSaG5WNsiwsxzsP0uD9+Zp3qmetc61uKb+t0KPx5CJedlp6TT+5LA0TSgZHyTGIUYbQdY7mnHiMoMFlV5UDuTWJFhMiDzcHxCh3nmOi5F604C8m61vRd0UnYSoDXTR5plMeOfHhaGFbxfETscYpxWDOriU505LVaVOkZ2aNJM4lyPfX01G0fnoPDrB2L57t8yuAKhKgGO/6zo53Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWpSMExJUkpVMnFHcUZvaTRzcDJkclRrOXBiVlBFZGt1UWlGdDRMZ3VRbHEv?=
 =?utf-8?B?aWUrMGZqdFhtbitSZEtCeTk2cUhMSWt6eG15V01NaHdOYkZzTnVMVGhTWm9O?=
 =?utf-8?B?MDB6YlNrS1BzSnhFeDRHaGFZVDhJSTF3eVh4V1VmWVh0N2kyQjZMTnF2Z0tR?=
 =?utf-8?B?Y1d2bmRoajFEOVNCMlVtcE5PVzllMEhkelIwZVNXaWNvVmVqUXJkZ2NUem9B?=
 =?utf-8?B?dFZYM0tEYnpVY0p0OUVEdHp3c0JDcEY4S1plWHlYSVlDd0MvbVFKb0dGbUJX?=
 =?utf-8?B?dkttWkQ2a0JCSGM2ZHFGS3FIYnhBeDdVWWp4cmdGTE0wK1cwbERUbDFhQmdt?=
 =?utf-8?B?U09VSDA5Q3NWaU9Mb2hielVpZk51Z3RCUUJ6eldsQVBGbWJKRHVmOEwzQytF?=
 =?utf-8?B?NCs4dFYybi8wL0NIMXpDTVZIYzl6VzUxUEtrL2srOWNlcEV2clNQbnVOWXps?=
 =?utf-8?B?eXJuT1llbUVYWk1lRGEwQTYxdnkwR3JtbVpzeVlNSldpK0lJU2k1MzNWMVRG?=
 =?utf-8?B?SDVCVFJ0ZWxoa2FGcjJIdytmdXdiZ1RiWG9VWXdyd0ZiTkhveVFZdlRUNjcx?=
 =?utf-8?B?WmgvWGhLdnJsSmVVSTJoY0Z3OTFyNk0reURpUk92SFVvNXN4c3h1c0Y1cHhh?=
 =?utf-8?B?ZmhMQzlkNkxRRE9wcDl2T0hQeFpkVjdINmhyQjV2SlQrQitvYkhlM0txRWxN?=
 =?utf-8?B?eVJMK2R1MzIzRWk2WXA1TThlbkVyZDBhcStZbHp6ZEJ6RjlFNzdIeitLYnF4?=
 =?utf-8?B?Z0Vvems0bGc3NHNMT0hhVkxyREZSbHZzSWo3Ri9uUTdWYnpyQlF1ZmJGd2F2?=
 =?utf-8?B?YUpuYWphT3h6azJMRFlvbE9rdVVLR3lIZGc5MFB1RnNkbTh2L0NzQ2dJUjZL?=
 =?utf-8?B?cWpnNmxGa2JKVWFMY3hRUElYakQ4OWY0QS9ZbnYxMkVLb2pXL2VyQjZQY0xP?=
 =?utf-8?B?QnJrenBPV1VFSnlHTHA0TE9hYkdYU3dEaUNUUEMyaU9mZWhrZU5WYVlEa255?=
 =?utf-8?B?cUFscEd5L0VLZ2NFUEIvZXBaRTlzRGpMb3g0S09zYkJQRTcrUGk1RXZ5c21E?=
 =?utf-8?B?UW9EeUFjMm9oY3gzUllSSEo4NU4yVys1Z0tybU1YRmYvV2t1SEhIcHNGV2l4?=
 =?utf-8?B?UndobStoYXlzNWVIb29XZ1JTaGZoMkpFeTdWNzl3d2l6UktmeW12VDRwN0ps?=
 =?utf-8?B?VjlWcHUwbVRTQmVyU1RPcnRTeEJHckNkTHpLaG8yWXJ0aTRpNDNpYms1N2hQ?=
 =?utf-8?B?UU4wSktLV2RJaU5GYmdaOWhheFh5QUFEdkRpYWtKZVBXUXFvYlJXSHhIbDBr?=
 =?utf-8?B?TU9LMmQwQk5oemNPRGoxM25ielRnYnhyWnM3VC8vMFlZWGw0NzEzaklsY3dl?=
 =?utf-8?B?REExdnh3aCtUQlpEamVaK0dQQmpFL0dRY1ZRQ0QzbVN6NTI4MlBjWE9FR1cy?=
 =?utf-8?B?aHhaS1h5SzNJdklTTmMvQXE3elRqS0RSdldncGt3aHl1UmdoZmJPYllYaGtJ?=
 =?utf-8?B?UXB4UHBpbnkwdTM3WjgwOXYwNmdSRDNQamFnN0VzV3VwWVJwbG0xUFVQc2E4?=
 =?utf-8?B?VFhNazh4clh6blU1RzdEM0UwamtvMnpPZmFQanBOUW9aS09ITlRjazU0aEo2?=
 =?utf-8?B?VWdHUzlLSXcreG9wL20wQ0RnWW5UWXZRaDQzUUVMNGpuem92L05KTDRxd0s3?=
 =?utf-8?B?bTZJU0Z4cTNPZkpCQVNCV2htSTB6YjJoUi9LdWxLbEFSL0NHeUdrR3ExRCtm?=
 =?utf-8?B?VHBROStRdTZTRy83eHc2RGVYYlBTUlZ5TFhOZzI2VzEyb29saDJzaE9waXpq?=
 =?utf-8?B?UTNGUzZobzQ4TGc0U1d0ZjJiYXR4Q1UxN1hUUEZPdnZuMUppYWVvYzYrZUNN?=
 =?utf-8?B?SzVCZFUxdWdDMG1taU5WQVh6S3kwdVRrd1lWSzNXM2FkN1VoZGFvdzVyeHha?=
 =?utf-8?B?YzI1bFhwT2NTTUU5djJzTE85Vy9TSHkzbWZ4L2JUREgxekptY1YzU2RSK1lN?=
 =?utf-8?B?RDVaUFJOakNBckRmN25meEtRbmZ3T2h5cmQwN1NzbWVlVVhMK052Q0xRK1Q2?=
 =?utf-8?B?UGgwN24xU2JxL25SMngvNXBOdXc3bHV6S1dEeTh1b0FZVVNGZmN0UmhQcGZy?=
 =?utf-8?Q?/jRU1nCVC8k6/Ebuu10kHvxgQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deaba51c-722e-4109-19de-08dc37b8a774
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 17:22:20.4362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JmdGKF/ojjGK5bDJJTKt/A1Fu59HuEXqadQmflGBS8TaB0t7WFTZCP2W/mO8b8DGRK+n58I/ihtEuyta6VbVAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9408

No device currently utilizes chclk and FSL_EDMA_DRV_HAS_CHCLK features.
Removes these unused features.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.h | 2 --
 drivers/dma/fsl-edma-main.c   | 8 --------
 2 files changed, 10 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 4cf1de9f0e512..532f647e540e7 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -192,7 +192,6 @@ struct fsl_edma_desc {
 #define FSL_EDMA_DRV_WRAP_IO		BIT(3)
 #define FSL_EDMA_DRV_EDMA64		BIT(4)
 #define FSL_EDMA_DRV_HAS_PD		BIT(5)
-#define FSL_EDMA_DRV_HAS_CHCLK		BIT(6)
 #define FSL_EDMA_DRV_HAS_CHMUX		BIT(7)
 /* imx8 QM audio edma remote local swapped */
 #define FSL_EDMA_DRV_QUIRK_SWAPPED	BIT(8)
@@ -237,7 +236,6 @@ struct fsl_edma_engine {
 	void __iomem		*muxbase[DMAMUX_NR];
 	struct clk		*muxclk[DMAMUX_NR];
 	struct clk		*dmaclk;
-	struct clk		*chclk;
 	struct mutex		fsl_edma_mutex;
 	const struct fsl_edma_drvdata *drvdata;
 	u32			n_chans;
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 2148a7f1ae843..41c71c360ff1f 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -483,14 +483,6 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (drvdata->flags & FSL_EDMA_DRV_HAS_CHCLK) {
-		fsl_edma->chclk = devm_clk_get_enabled(&pdev->dev, "mp");
-		if (IS_ERR(fsl_edma->chclk)) {
-			dev_err(&pdev->dev, "Missing MP block clock.\n");
-			return PTR_ERR(fsl_edma->chclk);
-		}
-	}
-
 	ret = of_property_read_variable_u32_array(np, "dma-channel-mask", chan_mask, 1, 2);
 
 	if (ret > 0) {

-- 
2.34.1


