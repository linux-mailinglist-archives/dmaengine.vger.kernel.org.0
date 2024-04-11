Return-Path: <dmaengine+bounces-1816-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 237228A0A11
	for <lists+dmaengine@lfdr.de>; Thu, 11 Apr 2024 09:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FBAE1F224F9
	for <lists+dmaengine@lfdr.de>; Thu, 11 Apr 2024 07:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68375146A9E;
	Thu, 11 Apr 2024 07:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZbATCmDX"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2042.outbound.protection.outlook.com [40.107.15.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C259140378;
	Thu, 11 Apr 2024 07:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712820957; cv=fail; b=k7+C6+zpGu9ekXvW0fezTOUs/33OXR1qr3W++CdHYnIKp42PV+F7Xyu/+QSwxsEAU20mgn4VA8TjSwjgbJmLmGT47NT/BuNQRPAddIeMbDZSLctoVwNFpLw+enkDP/RA38PGZOMg1IWH4Y3OT4eei3dSRLlcVTS6QoJstRRdn34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712820957; c=relaxed/simple;
	bh=zzMQGCJ0MHOMyk8nv1e0t+sdNkndRRi2xX/KdfMdkJc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZACIuEaFdu2pgK8UnxhwcG+gLEKN4Qr18HRrtsfu0thiwfKovQS3c/RIYyAmfPC4CNU2pkYmF0J7t3mRCQEl24mAcvnOBwOKRd8A6ub6/6Q5astjeZErG6E/1Gmo3oXv6pToIWO3oiLjBgPrlt1WtU+HCPk3aPp1RQzTycX0e0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZbATCmDX; arc=fail smtp.client-ip=40.107.15.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYBci/1H1Kbx8Vy8SFG7pFvD7B0hCT1nVRoOA6TJg9tYyPxZSMfRXWXQPggxgUmAelyyWzlXkDvkgjjhTFfcv0eOAtJPusBsDYSlOrgLR71lq2LMIpCBL98spl1NqXxAhSr51Y+r9SiNV27t7sjfEzKoGwA1r34BzPOd5hlZDcorb2FUc3VzU8oW9IP8FdZx4ehr2e6tbYei/MUxGO3hXp24u9Z7jED6+MlS93xVGazcCn/9xAP7dn5nkJ86NyPicwMt3kgjwSA9JPh3twNF4JrvWpVJLysqmuIFSPSVbYp/YHwbofhQMTtpelwjzeerWJcCgzi0+Bykr4wn9FU7jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABIq4t9w5QvkrNcsbI9RxEkButaCcxUnZwGMIqSTnUY=;
 b=kQrccpB1fV6SGiZxZp7c/7xmbDjHVHSDpOfPdcF47jXVrEAmgUf9xe56Hph9675V5yHA+X3OWdr9CneXYVaTP5mMFthOhXpzGcWUf7R9dk06On5BJf6yJVxLW7HbuKUJfTPPUqXgrWOMI8v5O9Cf1ljNZsHEuUpI8MxsOBBihYieCmB5YwYkFq928vxIwbZsVJKWloU0rZFJ8QlTXVU4bJsWckhBFB7U85TmS6T2XHJ5p1Zxesp5gdodz19joEIv8ORCN5S0+5ft3qk0bIqzcvPr/9vwUHGtMqTrN9PuePxionaBKes5p5mkkMIDdWo0q//Tg7o2fR7/D6V+Ejscmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABIq4t9w5QvkrNcsbI9RxEkButaCcxUnZwGMIqSTnUY=;
 b=ZbATCmDXSJmXfCib9pxSSqNapTYe14n6cb0mpfolgFrIOHVXdmonEsSgV/sZyXA6q84NmCsKMjD+Zdk73Sii5ToAYnxs24SON6gt1nuxCIlHRgewjpex4+x8ZFJArPwGQmNUKde4Kz9lrrKRb2Z9mD/DCz+hHt7u0TZZIXaeo6s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by AS8PR04MB9173.eurprd04.prod.outlook.com (2603:10a6:20b:448::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 07:35:51 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 07:35:51 +0000
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
Subject: [PATCH v2 1/2] dmaengine: fsl-edma: Remove unused "fsl,imx8qm-adma" compatible string
Date: Thu, 11 Apr 2024 15:43:25 +0800
Message-Id: <20240411074326.2462497-2-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240411074326.2462497-1-joy.zou@nxp.com>
References: <20240411074326.2462497-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0193.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::18) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|AS8PR04MB9173:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cc7adef-9219-47d7-65e9-08dc59fa0333
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IU4WKaO6lCLU8/flxdfVtaUEB4bqgqrqT+bp9+MX2x2UhDeGaIk6PHYUbOsyBZsILeCv8v1sMZlUdEYyYpWAKn9Kmg4NMckhkmsUE8XE8hIGWpWMjEmXEN0EJztJ4U97FAoMpiTmB+qxvHp4IYz2n42CxJCF7OWVjB3C3yiuHkcaQrHF6yKtosVGzVniGNYdZO7MrdhJzwjEq/qabgrvrqlzv+FL4eB13Jl/ygWIbzoOoM4Qga8pSI90UkWb2OfPrsAwyR2t3USpYHEbDs240z1IGSvDDI+RZw4qsQSjgHfbodK3xrJib7H+3jels6PFiB/MuwoQeQbtqKYiYKA+8JP5WNViDCMKFwJyrcF1TiYsipSPo4Fk786erV6dsym2mB+2LLVUY3q80dSlpxHZW0gxijvbQuOO+ZwtrBbBxQa43BZEDA6iAnEY1wE+OsablL5EJI5EXP79RPlALbDEDF0htMWXJRqbyu+SPy8qm5vQ1PnmiTz5SIaarrcaQU5u8NPjfES1kOmC6GrUU5Ey7VQ3biymQh8fiS7jjqUoCPT08ej6oxTfGG+wiwsPR/3NDqai3kR/V+MA+WQ5LVdtz1qdu5Ud5xxxI0r6ko5QVrUheYZJsA5yzQj/ndZiTucrQGvOToLim7N2f5J9YzV9UHW9g/kNw4vhfCRRdNzN1UOkQLiwqS0jHag/K/Ax4HoFlcTzzvRc+4uldkfv6DETeHGxG7EBRfxeghYu8pYJ2fM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L5zw1qBZnrxESwhWgqMoh3J0IHPqeKWRB2a2PJlS54Dg4ljKFSZCRK1dQA1Q?=
 =?us-ascii?Q?x33mnTuLSzUUHlbCiB8s6gMLQIbnWSXd6qOKoKgN1JQNXVRfK36YxSEqBWG9?=
 =?us-ascii?Q?VMfOVFmRtq1jEojVnRDseKOWRlMYuW7TLw6WxZ1CZKdCN38Jf+TBnOOW/N4q?=
 =?us-ascii?Q?Q5cQ1+5bjgVpbAvokPF86+/j/afXCfMn+zdzktjFE65PHG9NpRadqGUWjY05?=
 =?us-ascii?Q?Kcc6nK71G2tZ4jWoapMOSNG/ks0fP/13aB8ctfg4zGSr2tQPq4apbSs2CNdb?=
 =?us-ascii?Q?4v5jDrrRgBXJM/V068ntVhnnFYWSc5VU+I6aceLK+lQfqws7Nkd57tLXOnHF?=
 =?us-ascii?Q?rRuffItKS9XA9M4LeVIUsESf5SsHzUu4ZtzKEvBgYcy7kTmq1BomHnluxvuZ?=
 =?us-ascii?Q?A5Az0vG/wf/2H218gm7Vst9/MgRhb/XhFx7O+Durwggu4+2EWcn5XdkXMqwT?=
 =?us-ascii?Q?MxMEbRDHXxntLCb6MWMRg6bLsnBGs5BfmKmAtSUTdIOOC82X+xQu5DQ3c881?=
 =?us-ascii?Q?U3k3rNZZFLYDstt0ubzZvj6nS4QoN9DgWNwmq5qdGaw8rmzU+HT7jhuZsfaR?=
 =?us-ascii?Q?57qpTb1v8AVyQk9bheuhaDcftR71H7FaeA5teVt+vVSgouOHiiZDEPfl06T6?=
 =?us-ascii?Q?p0aj+gIeUQlAzX9OErYbIUgT5YwVh67POqEMVruTCoIj/eVvZZch24vgkKAc?=
 =?us-ascii?Q?GDbQxzZdUuc0sOPO3z4dsFOcgvFvbZhHJsQWN98nZDXvHkzQzfc7j3+2TPUL?=
 =?us-ascii?Q?58y8keaa9OF5Uar8kpPBbkeES2iG+/givHBow+JCgEJ6XjYbn+y9g5ne3lcg?=
 =?us-ascii?Q?HOizqMAvOagwP2P/oM32DWlgXsVLmPxmgtJsnzLLDhKX27Nt/tNGQgWCtK9c?=
 =?us-ascii?Q?grP++QFZZ9ClIBhz3YAohGmKfAL2uRN2CRhkzwdtfKIS8V+geNTbGgjK9LEj?=
 =?us-ascii?Q?DYqubWbMlWGlJu1IQzPcgftdFMmQa7KWZ0+feLxEw4RRXrjJYCDaBkCya5dZ?=
 =?us-ascii?Q?a/pWM4IjbFqCkX6gELKaugqpF/Ou2RtWA7W0Wxi19DurE9EwIcV7rP4M1Acx?=
 =?us-ascii?Q?DS7TdclPt983CGPXzuT+p1lMwqBHgusessAKo6REIo0vuZjH+5KRl99OHoNt?=
 =?us-ascii?Q?2Rjqc1lu+EAV6XWRRNtDkvAF6R+koYJ1klTWST5lBJXfumRuORUf0PRpJsf5?=
 =?us-ascii?Q?L/XHi1aLdKpDtTsEvtyXmMG910HmLV4sn8WzU1rfD+j47ZWGDui5TmjvGMjR?=
 =?us-ascii?Q?J0OOc7nPWJ8wvcJ/nBIfUoXaoCrFmko8SiFiK4loSJhAqVXUIAmjX58dZ6KO?=
 =?us-ascii?Q?PVhvYIBUpAddKB7uovmxfp8fyqaQLvXe8DvtdBwNSMLKROw1dnDTHuUpNKo1?=
 =?us-ascii?Q?GG6Me129soJxgdt4MLqiUcON+dJw4AY/5XR5zgw7nVh9PLsABI1WarQvcheD?=
 =?us-ascii?Q?BVZUTAKLHf+lSFO0wHuiMjd2O55nCs6vC4zyUa2aGclUjfaJR787YFYHhLqo?=
 =?us-ascii?Q?vVsGZJjmrGnY/Tj40v1hgSDDgEvEQYsOfIcewUtmyphFWq9Nrci0O+xBH0dX?=
 =?us-ascii?Q?1wBjo/MMYPSgzCGjcyiLEz9aPCMFLwlm6/V/FGdX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc7adef-9219-47d7-65e9-08dc59fa0333
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 07:35:51.2351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k1uf/6rZK/EdM6T0x2JsNcAJzIlQUwthMnG4LYSExX9SYXYhTWzLJnrFWACznPJ6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9173

The eDMA hardware issue only exist imx8QM A0. A0 never mass production.
So remove the workaround safely.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
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


