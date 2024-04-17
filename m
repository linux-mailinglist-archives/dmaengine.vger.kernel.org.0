Return-Path: <dmaengine+bounces-1857-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C3E8A7B05
	for <lists+dmaengine@lfdr.de>; Wed, 17 Apr 2024 05:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFA841C22532
	for <lists+dmaengine@lfdr.de>; Wed, 17 Apr 2024 03:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BF9747F;
	Wed, 17 Apr 2024 03:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fw/ncd+U"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2067.outbound.protection.outlook.com [40.107.6.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A92DEAE6;
	Wed, 17 Apr 2024 03:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713323941; cv=fail; b=I9y7lgB9rdKJZa9Obz/S3BSlcXKWV9xPvSoW2ipjW7/cG4DiVtQL1rpAmCHojlvZsgAD2f4kAAyMpMOHtnf1qNZAj+CZu3fV4TvrNszmsDt69xm8JLHqSju/BNUjZgp/bBdLe9507bjozs5csNhmPeF7CkBlYn+NbOL0pQ4a25Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713323941; c=relaxed/simple;
	bh=ijtGWbzkEpjZUz7+WhYKZNrg8+hzcCw5xzJD+xBJNFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r23jnWIPcEhDc5g3ZbUymxYeFmhLmAuQ4dgC5lUYAJDCRjU83FP17Omw6ebebumqKt+ldROym8zVM2cIPIDx5jMd3aovXp6/2DIvLsWJPTmkuYOZOrBnYuEfq0J6abygQpCMWolWfyJ7V2rauu5ZqlzeRp+9hrKrfu1V6TEQdmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=fw/ncd+U; arc=fail smtp.client-ip=40.107.6.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUY1OGr8T3O3F2I9fZ8xbkqGS096c+TDe6ZBBNPSokJHYDLnZz+eDnzI3HLPZWzQisdPiiSrNy49aZlpnDwtzKH8QHQCdhDO0Af60awweaXWsZdEKD3kpYar2o/sXT1qfcApdRdofRcvA90L9A8GyQ5rC+aG+b8Y9D54Lu9F6tx6QSL4XXlOIRIG3Gsrk30LlSrERuOj12gMb9eGphZfSbFz4EX4196DG3TY55aYzK8F/SyB8LpnSN9HHr9e9C2zUmJ3x53Lv7a1oAwS+yFbPchJTrEECXdyruVOOvQVTESJxayyo8CbrgYFGkw8WJ6KcaOh5eFRpAEKmd8xmUYngA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJsZyIkFV3tCNjQtEHR5NcjPhBI5snYeEZlOkVDDZ9s=;
 b=SWThuoBmlM5UxLZe+RusKDcojFjaY2VxiLJJPKCpkQeJdQY6rxfEBuWX+TRiTx7g66b9PE8W9utt28rlkPEe1eXxGmaa6n8LqJw4IsXIOfY7KDyRMoDcBlsMEl8siTRJra9vHDH8Llx8AjqN55qY1b0s9kUhg/nXHL9fG+ddG9F6jsTts2l65mNAzhMJVDXc/LULmgGCBdi/sV6uWVtHoo4aGJR4/Y3S6G69n6RwrRf2VWJAkf7tDVDWKcfwlDjntNsxAc13m5iVfbXW393v9/ye97EdkJBp2zcGiqhRRtB61DrwQkx9kiLogMuVD31jZb88lvGzm52oGAdwdbbNwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJsZyIkFV3tCNjQtEHR5NcjPhBI5snYeEZlOkVDDZ9s=;
 b=fw/ncd+UWdofyO4U+nyMkFZAtdL5GFhs/10NL+pKJGn3XYZ0LrbpmePWgGk4d/uXu0JWPJmM8QEXhtFTATHicabYRnlwqDJB30I2xeMONpuRH5eCa/vxdp7+x9n3OIDBESBbsrEaumVe9FQWK8qtdJ2UfxCu6jojI8nRWq2mYlE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by DB9PR04MB9305.eurprd04.prod.outlook.com (2603:10a6:10:36f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.43; Wed, 17 Apr
 2024 03:18:56 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 03:18:56 +0000
From: Joy Zou <joy.zou@nxp.com>
To: frank.li@nxp.com,
	peng.fan@nxp.com,
	vkoul@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v4 1/2] dmaengine: fsl-edma: clean up unused "fsl,imx8qm-adma" compatible string
Date: Wed, 17 Apr 2024 11:26:41 +0800
Message-Id: <20240417032642.3178669-2-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240417032642.3178669-1-joy.zou@nxp.com>
References: <20240417032642.3178669-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:194::14) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|DB9PR04MB9305:EE_
X-MS-Office365-Filtering-Correlation-Id: b945b778-24e4-4c4c-a167-08dc5e8d1e0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0nv2SAysOaeOJIl/5KvsSe7k8PdKs0EfytVhZ9aup2EyOqGvWaLxS/WkuY0glRztThbmzm+H19g29fZtdi4OdqwVexa7wbB21E3r0ZZTRAkCe/lB/QMAIGBcUrSX2HoSXImM8s94M3CwHjpcS/ydVwsqoN3AhleyJeft3QJUK72YK3oGBMeZb8PhB2nvFIu7AnjGi0QIrJ0m8DIODRfodVxaNQ7hx0uLIy/i/vefQffbBScDnUpYH9V/AfRn5jIUY37/SKhJXj2hZ5x1s+pGMc8N598ij50ELHNz/hqPI5y7t8q/qVVlldNudwZX+g9sN2EBdfF58kJSCkGC5+1//uha4zhnWJiwmJ/YHOqfdJSk8s5LARpwsJ36+GFIQteTcLALS6jtOdOrk3eF1FmouwdEhBpCDQTZ0YCVy4wsfxzARSdyitJ2qBRwwNNklL6mxz+XksXEXmyA+b1wmZEX3fEID0sNvOhB/pcRWOlN65zxHWKMo5nq4+eG4QiUx4Q8SD7t8SZWXfLPlvM+lWe4DCB4UBWylgbyeQcCaRnBRM+pGUanhtU309HjAz5XMNgAuBAz1lJkLc/lLVYHtLBFfDd4We4zi/nyWbCSWqj7Da7xm4z59b1HP0iXshgS4p7j9CBhRDge5p9TKCCk1FBb8FAINkjfx37xZ5WrIgl0opGH4KCADDLsMVT+ayYUwBTnfBg5AF2iU2KB0QFnKFtdB8W3Ig8hdIkWHixnvv/xv2A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R0IxBM/j7KaVK7lrIuYDTcaZ+qUJP1kJ0IuCUIF4SXlM2tMWpbV7bh1lQnlV?=
 =?us-ascii?Q?rwVuolfK4Jbhf2o+woK+kiVNaoPCvjtbLlpWEyb4Qi5tTuKxgXKlD9MhMBwU?=
 =?us-ascii?Q?AvgJ657aEtyLykzHoxV/Syl1ODyEIcFxEbP/ZQGTvQVBevXt+YcrxX11xSxa?=
 =?us-ascii?Q?APXG1jmqs++C7HMGNlXGkgZLJHTuDVCNGUTpe7YeR9FzTgr0KSNVFtrcnTCb?=
 =?us-ascii?Q?HgNOLwd+AHkYsRdFJawiKGqu4jCE5jJnzxCizj12YeYpD/DguAiVqqxtLFGy?=
 =?us-ascii?Q?nA59r/oFLjMqBB6WpOxrGGCXgLwTNoJTYf9Lip+ogoIQgV9aGMw9qL67w9us?=
 =?us-ascii?Q?ygB3/8orUVVSj5AENmiOG33aBHHbM5SFptf8NvxheavuV/JUIuujsP/YZZ2I?=
 =?us-ascii?Q?wM/3ubfiYCaMzLwRvdPV0sxp/dWEObiBqilqgyG33GMpL3UePKWIN9LAMb9j?=
 =?us-ascii?Q?dmXhgB8hFQvORl+l0G1Rfa/n67c/jVIPX3WPdFddO4b2TdK0tWkYSH8WtxIF?=
 =?us-ascii?Q?86ZwcUB6BDuoFb4zvXy6TNXHPwLjXHotCfQq/CKlrfOFtVZLMNxT6anC6V4h?=
 =?us-ascii?Q?gvTI1xfHEQaQClZ0fgEJ+vnA1wKVsh3UY0VQFm5oexpPcdJh2IGg/cOad+B0?=
 =?us-ascii?Q?HUOP8Cc7B8rORnf8MbTQNrzkXsCCVzQuwZo47zwqe55RywGoMrIZBTJGdgp8?=
 =?us-ascii?Q?yhUjs7QIRxQX3I/rg+TuQ2x5FbUuYdiZw8HfdMNAxF/UJ6mBJOxqvv5uGKoI?=
 =?us-ascii?Q?VdGxgf4i9QTinOXYArKvtVKne/Y48A2ZeAfFAI0HWb9B949ZYgRX7OonMJab?=
 =?us-ascii?Q?ViYxlsoOKDu6iX2L7V9ZWj/+4lctPOqaLD3K3mjQy9Y3HfQv+eTw0VOWUCor?=
 =?us-ascii?Q?7amIh2bY7t9F+5QMtRC2nSAp0992zRMpwxzoNcCu/+jBhIyVajxLC4ngxB+f?=
 =?us-ascii?Q?wlqA3DDt2AiA/tkx6lCo2N1ladsKdtKO1QXRzeVkWnwzDFtR89sC2GU5X44P?=
 =?us-ascii?Q?lVwMqcpDhMZv8HWe7XH/CIyNbGd6q45PYZWUbtEM8Dskb956lDl1z+SWBiVh?=
 =?us-ascii?Q?lsxAWwHcq6bprk7obDfkPpp9cmcqWsra1A6SX2TiLkTeN+WdB2V7GP4nEupX?=
 =?us-ascii?Q?iLgLYnuE6L04yU6taeepkH3s6neWI5pgHClR2VFcmTV3rEKwwKRW5MRSUxek?=
 =?us-ascii?Q?RlyHsePFuMwl7bwbfMshyj8JsVTfUUkoilbYlqy/zITo1KTre2QNN1HMsJMp?=
 =?us-ascii?Q?onfVxAzKjex58GLf5bdHmEkLgSqEVFx8ZN1dFaFlBAAB51Y/4fs80Q0fD0jQ?=
 =?us-ascii?Q?emEQ2R5VqNCxPREwjNK8RJi3rWHAyLcXYh+WxbmfE8TXhKDhxMkUOMgC1+N9?=
 =?us-ascii?Q?ctuJEHvGuzLFv8fmZioRIKGGDtS1vyEW0d61YBBrxC2rSt3RPTEK38WbASQA?=
 =?us-ascii?Q?H0bf5WtixvJBf9JjQUbRqGHhTi8cSklTi7hO5d6tDVOUiNzOrgGj9NQ8cKxR?=
 =?us-ascii?Q?t/p3M5RFqyUYJ1eUsKpX1OUlcl/2PhxcMs84rnqntdd1dFt6DX/+dpGcoMlf?=
 =?us-ascii?Q?bQrtuMJdIV46OidoKJiQ9ofo/xnq9Ve/u7Sc10fA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b945b778-24e4-4c4c-a167-08dc5e8d1e0f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 03:18:56.8935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MB+ux2KkLZLcP71AHKu3lUcC0KbwjITcrROHcekVeyvHR7+kD8Sqfxe8lysvx6iO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9305

The eDMA hardware issue only exist imx8QM A0. A0 never mass production.
So remove the workaround safely.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes for v4:
1.change the subject to keep consistent with the patchset.

Changes for v2:
1. Change the subject.
---
 drivers/dma/fsl-edma-common.c | 16 ++++------------
 drivers/dma/fsl-edma-main.c   |  8 --------
 2 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index f9144b015439..ed93e01282d5 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -75,18 +75,10 @@ static void fsl_edma3_enable_request(struct fsl_edma_chan *fsl_chan)
 
 	flags = fsl_edma_drvflags(fsl_chan);
 	val = edma_readl_chreg(fsl_chan, ch_sbr);
-	/* Remote/local swapped wrongly on iMX8 QM Audio edma */
-	if (flags & FSL_EDMA_DRV_QUIRK_SWAPPED) {
-		if (!fsl_chan->is_rxchan)
-			val |= EDMA_V3_CH_SBR_RD;
-		else
-			val |= EDMA_V3_CH_SBR_WR;
-	} else {
-		if (fsl_chan->is_rxchan)
-			val |= EDMA_V3_CH_SBR_RD;
-		else
-			val |= EDMA_V3_CH_SBR_WR;
-	}
+	if (fsl_chan->is_rxchan)
+		val |= EDMA_V3_CH_SBR_RD;
+	else
+		val |= EDMA_V3_CH_SBR_WR;
 
 	if (fsl_chan->is_remote)
 		val &= ~(EDMA_V3_CH_SBR_RD | EDMA_V3_CH_SBR_WR);
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 755a3dc3b0a7..b06fa147d6ba 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -349,13 +349,6 @@ static struct fsl_edma_drvdata imx8qm_data = {
 	.setup_irq = fsl_edma3_irq_init,
 };
 
-static struct fsl_edma_drvdata imx8qm_audio_data = {
-	.flags = FSL_EDMA_DRV_QUIRK_SWAPPED | FSL_EDMA_DRV_HAS_PD | FSL_EDMA_DRV_EDMA3,
-	.chreg_space_sz = 0x10000,
-	.chreg_off = 0x10000,
-	.setup_irq = fsl_edma3_irq_init,
-};
-
 static struct fsl_edma_drvdata imx8ulp_data = {
 	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_HAS_CHCLK | FSL_EDMA_DRV_HAS_DMACLK |
 		 FSL_EDMA_DRV_EDMA3,
@@ -397,7 +390,6 @@ static const struct of_device_id fsl_edma_dt_ids[] = {
 	{ .compatible = "fsl,ls1028a-edma", .data = &ls1028a_data},
 	{ .compatible = "fsl,imx7ulp-edma", .data = &imx7ulp_data},
 	{ .compatible = "fsl,imx8qm-edma", .data = &imx8qm_data},
-	{ .compatible = "fsl,imx8qm-adma", .data = &imx8qm_audio_data},
 	{ .compatible = "fsl,imx8ulp-edma", .data = &imx8ulp_data},
 	{ .compatible = "fsl,imx93-edma3", .data = &imx93_data3},
 	{ .compatible = "fsl,imx93-edma4", .data = &imx93_data4},
-- 
2.37.1


