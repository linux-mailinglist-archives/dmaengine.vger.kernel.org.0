Return-Path: <dmaengine+bounces-1811-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C11B8A0604
	for <lists+dmaengine@lfdr.de>; Thu, 11 Apr 2024 04:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 896A8B24DAB
	for <lists+dmaengine@lfdr.de>; Thu, 11 Apr 2024 02:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5EE13B2B2;
	Thu, 11 Apr 2024 02:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DG8H3Z8r"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2128.outbound.protection.outlook.com [40.107.7.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE49313B286;
	Thu, 11 Apr 2024 02:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712803007; cv=fail; b=DB2kxynY3A8/WDJKhyM8qpDMCXd+voMucy/XYZMgJ8QcyxmLoiDTPDXg1GbKSnPcjKrx4wDGMF5szbJDWRqB+KrIx9kG1zKWlylVMV+o9ZwzzwAIC5hIegxUyIhP4IaP4/yZeQYg0xp2JcvMM80VjUG+eASCmN/r8ViVyo5T6Ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712803007; c=relaxed/simple;
	bh=bj4pB8+218cnpHMfnNF9yQ1KB0Bl1TGwCnE5YPiqrFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RFVvhrpAxK0sdUiiypAp7bpe5mpTSOjPpx56Y29/UwpP9LHfXroBWlWjejtCCXC6WEngD5FCMoaYDdm5pKaRoQnZax7zNbGiPxeUaxEXpBx2NSjDXNM0pf7AasDE6kmWL2oz9VBu3n+s/tV9jLSiaMDBeEDrgmpuGLTqcdK4aWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=DG8H3Z8r; arc=fail smtp.client-ip=40.107.7.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYSPmk4jdfQxb7hlQBS468eNg4LhEsEE4SBPtTrlRwjwwOASnBRKoWbLuMMWp7HWsElgZRYgA/AuKFJ8PFElGPASVTe/Y3Zl1THj6AHhDvzGOX6VURAdwh+01lZzuu0fHXGgYmbUG4k61XuGdNC6gPgQ0PjQwLbC+Vc7YWOO2iSP5yhvAiyiFsPkqkzTfXyVfxXNTbu5/TpW3hXOi0o7EPTF9yYcrE9P/YBCvyM5Ztu0lrVZm9x1JXYf1mD9ieUFj51/YFyLpT+Urz5PPZ6i//c/ghFJSU6FViZJ27IxUrS6A7uwaofxVHvP/soV2o1GksNVqeAz2PyfVSOMsAoSOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKEcQ5zdv05WNMbO5o+K54yaNLvFCLsqJ4WUxP42BQ0=;
 b=aXmCeyn6HbTiRuuRKASCxaujB7JGnrkNI1CS5aC6iFKtl8Hf8Ru5xl5WwcsN9L5+3AWU4mDUCK6rW5/I1AWyw/JSb9tXN1vLOXULlcVJjvlilTqAae8Gkl8OV1PIfxrVlVvj8/3RYy3Q8KyR9NFYAJzYwxd7uBsoAs6ycahCiX1wNe9ighRimYUy5LvKfHVxb45AjeG5KNqS/VnOibC5rBfPpEHWEUARoVAaY7LiRmNRdvHO3yykWaFVusrq3/VCDcNdddqVrifOCVIQpW4W1fNqLuLueW16/J/fIgoBRvvEUhvm74O3fzZ93VB9zzUDD9zO4kuIHRfCeikhxH+oCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKEcQ5zdv05WNMbO5o+K54yaNLvFCLsqJ4WUxP42BQ0=;
 b=DG8H3Z8r6oGYvxDhiP7MjbI/pEMfw8fBLaWPiDfKYQvw+wtuBVFJDAXVd3YS3qLiLz5XiO91PVGIpCJJgmDGRyersT+0+kucfinbm5RGTaSvJUMjzL50IKdNYj33UGAiu+/bJG3Ib2Hsm8IMa2xzrhi3NER+J4ab4Efw3/+1b4I=
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by DU2PR04MB8599.eurprd04.prod.outlook.com (2603:10a6:10:2da::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 02:36:41 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 02:36:41 +0000
From: Joy Zou <joy.zou@nxp.com>
To: frank.li@nxp.com,
	peng.fan@nxp.com,
	vkoul@kernel.org
Cc: imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] dmaengine: fsl-edma: optimize edma driver for imx8QM
Date: Thu, 11 Apr 2024 10:44:17 +0800
Message-Id: <20240411024417.2170609-2-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240411024417.2170609-1-joy.zou@nxp.com>
References: <20240411024417.2170609-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:3:18::16) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|DU2PR04MB8599:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SlIwEa2r932priNscJddHiBsAUv7SeJRLj5QgpDLNK4tOHIw0KtlvGF6pPbiLT4mcLL4itZhBc1FuaRg/smvY/UkCmGy07RyGXnD24R3meEqp25XUcdcYlP3njTGCGJvIYM0drqrOYNkrbRE9wxWxt8VlHuFcTd1osFfTK5mAcO0NrdQ57qOVHHrZmXm8UQc7nM9WGmVM6IGbVRmcUrqhGSIOy1nlOBcVJhULeZYKee/xhI6BLuEQpa67i2DtvVIoiBhSmPiiprME+7rxKz513IBdcFhbev3wmi/1NsLVdW9DCObaX4L/j1e1GZx6tdh+hvI3XBlXVJRrIv33LfrwXgJ5yJs62zE6IIMwKVui/TkuQwWzGVNCGNsMND1qCO4QT2aWBm2RevqSIU+xAX4pvyX4qHQq/z5S+Mra8WxF4jXJUzaQ1Cox9rZ86AZcCugJhLKlJRdgPyN0MljEle2iU8Y9+WNVbMb3pj2sJuxzo52+Ef3QGS5Lbuic564IPJdPWzHfxY5WTnYmE8vawIukiI8Hy8EtqNdqBsyxR0OPDHkxN/iaD499wVk3Y8iJ48VtDeDSd7Lnj7ACtJABNS+cvs1Da5kBUUp5PAQP2BEBfVZbI4534yGmzQKjoFUCCyP6XrUiBznbdtCKgKji4lptS4A7C35x9SF29MympP+a2C++4VdxHEw7rV4KuqJmMRoZiBYibxomaolLGGVka3WZAP8xm5OPp9m8WYqb7Y4/tQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JxLyoPtBMhznzirIOW7jLB5CHRORfnLWvaWdPFKSTogavCFTYKsIw29dhM59?=
 =?us-ascii?Q?SJpu/2g8y3uFsnp9OL867XJuxbYVKGtzgziUoUA1G+8XXbc52nkaL2rCGTky?=
 =?us-ascii?Q?RyKvgu7kZ+4E0bwuryV7k0s14Ladf8XVLRVSimy1vdwcMammPfw+G4q+IwbF?=
 =?us-ascii?Q?QHiLR18VgkIX2kCeWusTqy/14PcTAnXJKtUL0lIYwaoiST3R9f1RkDPXxVz6?=
 =?us-ascii?Q?x5i/ZHNGo0BaIjoGSx0jg2xsDcdrzmIlbKJ7qez8B6TRmSpnG4nJ1T5DCoJY?=
 =?us-ascii?Q?yGlysNGSF2W24qq+TKBvhlo6caDFaY532qBPhXoeAz85HJke61EaAAMmGasl?=
 =?us-ascii?Q?ZPl8EyE9REe1jSxhLBenAiRTS6awWQXTTDm9JuXXuYm/vVPsQ1Pbh8InMxch?=
 =?us-ascii?Q?6UYTiJP6dp5ftCAJSy8lnNSLmPTdFGOBL/A3NPZOpzcksGGkiRxROWpBDmbo?=
 =?us-ascii?Q?wzDgsAwDWhUJjwfgDdWa9WZLFagyJWppNeZoeX/ab76oxF8kmSpkhAdPfXrr?=
 =?us-ascii?Q?upeqwkLya66rQKVCF9wjm0mPXQqhrWpGY5J3U9/XZ7yMgu0QGtFFUNZtARuV?=
 =?us-ascii?Q?b1tlmakwGnfFM99AxLHkAI93bVMLWKzfmtYdEBPNvk1a2klPYRjhOzRi6WZ0?=
 =?us-ascii?Q?bit45VBs0YDBkmxFfCHpcLzb0XWdCCjbBX6iloHenigHgvhTiLj9XLzqGz2z?=
 =?us-ascii?Q?MH02h5D3ZhOOI76MJ/MWW5vq9/YXJfUwkH4Njqp0KoW/+ug18sCb00DJdA5U?=
 =?us-ascii?Q?odEvJsZSicOu4u0Eo5MW+v4doswS9plQTiX8SsHe5lGho+sM4Dkr/m9DA2V4?=
 =?us-ascii?Q?VdUW/nv3KZQGeLX7v1652WYVlcK3/8M9NVYju0ob2X92eaMOFtxujA4go2Qy?=
 =?us-ascii?Q?HreVPC+2n1zLzW0ri1x49ET81O8iVhLMbBTJF6ydNmQAoDvDYiIKn01RH8KL?=
 =?us-ascii?Q?EmLUmuiZnSYLP8ari4jJo7u8m2/X+uxJTmW0tItIas9+k+AMs/wBm2oY37E/?=
 =?us-ascii?Q?vNIvoLVDq3FcGxb+BU5K6zPpEstqxI5Sdyoxtc0B8fcDeePTU+oS9cg66ADu?=
 =?us-ascii?Q?98EAsefgwiKeAzr78MW18XgZqrvKZtnHQAEUVr9cW0RI6pFQxf8616CiITcx?=
 =?us-ascii?Q?PDnKCl7KLAVDFsSSiGdWvQTcn5cPVWdsRgKSVAevPM6JfcDrzJQffAHM+a2O?=
 =?us-ascii?Q?NmiHoK4P39n33TgT9146U/GWqLH3ObOHiwGbuc9wnALtKn43hAjgRQzR7HaY?=
 =?us-ascii?Q?P5sl7L6dCIeVqiUMw7w4xrBTobUxZl2okQcrfA9mUZqplH94I7NUcVvI5xuf?=
 =?us-ascii?Q?rzRFOpjVbH0uqnLjmSmaxOcscFcjB9lgiQqepkdrQCJgWKOLTYD/QaOmkAUH?=
 =?us-ascii?Q?xh0jXLspaKhcXqNXkfhYEHOBgo6GlxNvJPZgjzPhkdK2MNf5t/BUMRY3t6iZ?=
 =?us-ascii?Q?TTz65nCJW+jWgY09LduSc+RadUsYpKnB6KIMMj01pX+iiX1RNMpAoZA2DKHZ?=
 =?us-ascii?Q?fGD6eaGqxgmzSL4LomqqecTRCQyYQ8BCr9zyrV1ZjK1VGs8R11l5NBvny4pn?=
 =?us-ascii?Q?K3r/VNbwach1dmFQXmK3H/J0J4swQk7YH//cOYjb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e570bf5-3446-4155-168e-08dc59d03877
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 02:36:41.6798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zPm7ihz9iPhGhDPvbmbJCGckPFVPcNJSRCGbR8f3TELgQhn/JyHDdV4+90q6N6ST
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8599

The eDMA hardware issue only exist imx8QM A0. A0 never mass production.
So remove the workaround safely.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
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


