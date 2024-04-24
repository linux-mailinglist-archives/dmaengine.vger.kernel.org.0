Return-Path: <dmaengine+bounces-1948-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA3E8B023B
	for <lists+dmaengine@lfdr.de>; Wed, 24 Apr 2024 08:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6CAD2831EA
	for <lists+dmaengine@lfdr.de>; Wed, 24 Apr 2024 06:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5EF158873;
	Wed, 24 Apr 2024 06:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="A/lrX3qn"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2085.outbound.protection.outlook.com [40.107.249.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D110157E87;
	Wed, 24 Apr 2024 06:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713940647; cv=fail; b=WmVueWkqTSqYxmk/bmtLh5UQXJz0ZSXjjjmuHNu5phs5YXbwURoiGk5OzzWd1ysT+AnHgnqUumvGo3QKERM2GWK9JFJe6E34dZ+k6E2JTb8CHKcbaHOoDZ/gtdYwz9r/MR0BWjPVy4s72YpG5CqPcsppYaFkHyOL+1KSqNGl9QI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713940647; c=relaxed/simple;
	bh=W3LTSyuLt21SC79pPBil468zl9dzxwwl1NyATR/v8qU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SXKBu/FKLgzWZGfJY7Dtc7c8RMfOlWgysY4w4Hzbuj+SBPrC/SlwnFiGVGs4bLttkp5Njf7ZxCl1WL1qBiXPJLxJJxjBD0JIQoVYkfViucqTqXLWZ4uiZ0uRrwmAMg+1AETqyGj/Vp9FX7I/KSfRqUwFkaMss1c8cGBB8I0GqJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=A/lrX3qn; arc=fail smtp.client-ip=40.107.249.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gkzcXxcShCjsoZggGu5YHQ0RBPcnUnX7NC8z/hhluFZp+UPR7U1Kc9XC4r0kjWmza4dXna2VyBxZR65+wGqIqdDVGQw1jc3TIY1RMXGgtOMQ5Vl7jRAjw4icr8kaLGK0Db6fKcg9JSTU3jOaKoHaZe874hnnglxht740iKDnr4HcBYU9F4vD2sUGGktE718D22JrvJKYVInu4BX9mouWPav+Lr73evplWKSri8ArWLMIpL1+cKJd8LjdoVA2M8hbOyPi2SX3qsePjVVXjgMj0dzIhVbrGrzgHy3CzFr+8kzWnHLycoxHZX9wuTTKwoX2A9ZIwgWM9cA6Cmx61CQCUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCCyHD+u9gv4KaZuIG4LHHPnIcWkqUrq1ch/K6W7oFI=;
 b=ishqLX2VcsKAcFE9mdiTHeLMoXha24dq9Bi1/h5F0cyW8xuFjN6dMpvkEIoEbQ5hbaaiJrMuPu5ofsX9iafKfshc808sCNDqek1jUQsP04gHmfzEIs1Zz6FLqVFQSzC0TOlvi2UzoIF2K7YwuKbZvXsX/oCguwlEd73XW/dWwUZzqGu6xZadXLl1uXMEL2+9LW8X9fuGsa3STPOhPgjWBjYlSUhcHLE1LAvUPVeGKymAqxQ4ERyObVLna5wPOozg+Lza7Z3TD8MaamAeKKNbCFaf+lT7EFb9acQoVRCC/CXn4/S9kLuB15wnRcRSQdJmykAztihemVd3QPIUBAFoIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCCyHD+u9gv4KaZuIG4LHHPnIcWkqUrq1ch/K6W7oFI=;
 b=A/lrX3qnFE9WiED65pgfgeW36Xk8Z0IugWNUxYdmadxzVsh+vSTbOLEcPv1XYo65dg67pMmYDTrrwfacmGGCHgEb6xFM644W5ScOIbiIPSmtkGeQSHnsfz/cUH3AmbvfdNYxbqpkGD3StWbM2a0VE10KkOnjgTbdj4vL0jD/N+E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by AS4PR04MB9483.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 06:37:23 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 06:37:23 +0000
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
Subject: [PATCH v5 1/2] dmaengine: fsl-edma: clean up unused "fsl,imx8qm-adma" compatible string
Date: Wed, 24 Apr 2024 14:45:07 +0800
Message-Id: <20240424064508.1886764-2-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240424064508.1886764-1-joy.zou@nxp.com>
References: <20240424064508.1886764-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0029.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::16)
 To AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|AS4PR04MB9483:EE_
X-MS-Office365-Filtering-Correlation-Id: 16d32ec9-ddc8-4434-d413-08dc6428ffa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pqsC/wWEzZ7TOfaHq1Pq1Sz+YCvd+/6SFMkI+rIXlQFsiQ7MqlYe1+yw3cbD?=
 =?us-ascii?Q?d4plfvTZWUlPlKv3eSivXWmIVZMC1fFfZpY/muDvSdKeH2vpykjySCLVsRYR?=
 =?us-ascii?Q?+esXQuftYklZ5i9wU8vBMwKYAbLd2ssEIb7OL5c7LzLLMsGeC1sO2NlglFwk?=
 =?us-ascii?Q?IW3darHXJOEQ6tg4a+I2bXyqtOhF5dC7tj/p38z1JVgDA0Ja5fNtqqnNXh/S?=
 =?us-ascii?Q?mBlI6m9BoxJKw8hDsRlUAHqQxW/qwnQ+e7oBYQj4sBauTQ7ef7dpVRt6WFv5?=
 =?us-ascii?Q?l6LIJeLOve8AhisY0YgyLHjETI2D7RUbiZSK+f3gge433WrlLhwjxyIHT2kG?=
 =?us-ascii?Q?g41j2kzlikvXnKX0NN1C5nU1eKn/G4UMuf2tW6XbvWxtIA7Wry4yt89N+9DI?=
 =?us-ascii?Q?WGGOER2CYiHZCm9HdX7qCYUL3cUJzpgA/f4A7o3yMT0KaTU0LASkqwSQ5KvM?=
 =?us-ascii?Q?jSl+ofndUbQFgDAk/g7nNXC+lYP9MsihTRUAktxzJJXzRybMb4DSrnl5SR0N?=
 =?us-ascii?Q?cSFwIBN0NRLVEsB/pB8Ci2hL7TYd1YmmTI0zlpQD42D7ugt1VYfVGW0co7/i?=
 =?us-ascii?Q?lBzEKrDbMAwfd2+KbmsN8NN09sVu2c0Zb0iVj87028Xkx0oz3qo8fx26/KiX?=
 =?us-ascii?Q?QXFUs5pqHzJ1l1IfAdEBjS3NWRzvWjOLWEaOaBzp6xnpBZjLWjmWiN0iziAO?=
 =?us-ascii?Q?4s7U/x1+PwkvmoUagm+jXdrIO7vk30kGDnrh2ylAVcEeFsgtKLO+MjtbzSeQ?=
 =?us-ascii?Q?24Xty5EVXoMPBRHA9YIBgKcsVLKMP8/HMh8ezker4bAerr3k9rVRUMQsLE2m?=
 =?us-ascii?Q?wo1HiSeGy+TC9N15OkzUm2d/p5gB/RnMndH2xRZkalK1iKFffJHgyhWWRpGB?=
 =?us-ascii?Q?H4JAm4OFuNF5/9/FfYTm0AogFXJ4hhuwL+aZRzH3F8cte6NyuojuFrsXgUgI?=
 =?us-ascii?Q?azV0Py87LfAAOP3iCUOjr/4lHNV+DEQicyuHJIEEPWfTSjtl6gcKZeL+kqYZ?=
 =?us-ascii?Q?RfuK5Q99Tegs54+A8MLn+4BDIWCGK93R/6MH2jNxy/uzf14yXXp46yEy/3qi?=
 =?us-ascii?Q?Y70rOs7oWLjfUjKzcIvBx3oFBvuBkSAPSEBB62B1eEjgseuYX+3lp35iOf2v?=
 =?us-ascii?Q?S6L8gCijFre/X03mvHPg7v9CvlpYaadG0y9CDBzvaBgcjpSpRAk6ix84+7lV?=
 =?us-ascii?Q?fN3dkvzejzB3XhHFW0/IYKRBDNjfZDn6veaVw5kjYdfGRapLAJasMK1I1DhN?=
 =?us-ascii?Q?Y1lwuPnYSa7EH5bDfy5LhUBudySXQp2MHPzVb+5oKuSwBQrAjSo9bxyJLgDn?=
 =?us-ascii?Q?XH4O7nmNOO4yZcvz1+ofDw19t2xHq1DmvXE8nP4AE+TeLQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gpD3V0ZXz4o5RMLdO3biNMzebdWw/iIzyJHnt7AgZhvy3kLcesEdiOpsMx7d?=
 =?us-ascii?Q?PD59nB3WP7slWbxByMq1HyCi4DZVPERspuzwLgc1DH8C4uJuTNoxmTqlxEZF?=
 =?us-ascii?Q?zrf9zFQlGvTNGbJkFyf3JMVJUh93VVQji+s4jBzQkjcqsjMQSUBH+JrSB4TX?=
 =?us-ascii?Q?LTmqDnecQCZyVbQxko2scyatUUp+v/UZ7+9ko7Dyagod825Qf9RmaFiGYmXc?=
 =?us-ascii?Q?vPvBtFb/EQf3ijpNfMwFcPXsatE52kxiPxiSLD8tdGo3cZYF2kXI2C5KSyVc?=
 =?us-ascii?Q?W6nCxbl9DYlb4K3bsTQfE+DbceZoJrmXVwY2Pkh4re41IKKY1oHU9Ls5N058?=
 =?us-ascii?Q?EqYzSS/O+8iXDCnj4b4ge+wnKV1gMYuyz9UGhou0MReQk9LwuBT80ex9Hb5V?=
 =?us-ascii?Q?UuEtpOXgCrhoHYNlj1TorRROMUol5s7YYMzTlNOpVJbtBlDTAJkLbgr5k+F0?=
 =?us-ascii?Q?GslEF0KgB5viRBY7q9kdmPPySmkh+bbPNqUBeZZuFT9IhJnOrx0dK6IPfp2T?=
 =?us-ascii?Q?oQWdjGhFFr04ccTSuqumwYxMZMS7p0JcPOvAIaCa/07kjy8z9EJ0FS28opGg?=
 =?us-ascii?Q?pZAmUFC3brePN0Fv4DiqIaMU3wj0nHrE16VXs5ZOIQmzOYNo+SUkEaYay1rs?=
 =?us-ascii?Q?BPFGZmTv05qOCd6I1UN4l0TiOOmMElDsL/I+ncXHVHXEeE5D5ZUFxRAPLqUJ?=
 =?us-ascii?Q?jEQqm8rbjZvX/YnSZivLJVPOc8H0+gThDPWzydXeFTUmpSQhR5yVKIKdy8LW?=
 =?us-ascii?Q?pp22w3M9AkahfjxhGK6jJjsd5lUa+NxOEGyT/cuxLPm2PToyiDQcVCF7Fxzk?=
 =?us-ascii?Q?Xsm1KH52KPZIICgDA9TXF5DbdSPsgYL8q9tosh15xOzH08mkeBUSBpcBOvYU?=
 =?us-ascii?Q?sJJ37GhGluiq53I3AMQtVLp1GjYBe09+zVlUACUnjenvY8Un95lgGYVb0N60?=
 =?us-ascii?Q?XlLz33GI3Nc8QZ6rK6kMTf351K0743pbHlvU3YAzO/Er0VvdyTW7KhxM2Lrp?=
 =?us-ascii?Q?Fjq0f4/x8ZLAmEyk8hwZUIWQnOXJDTPFFQFGInpCpzvonV36v5+78cc6GFQH?=
 =?us-ascii?Q?30ONRaZzmWg6CtboaRKb4Zu8al6oF9Vj4aC+vkUAvvjfj8Vnvcr9hlPU2td7?=
 =?us-ascii?Q?Zgyc9ppwx2+9DoYrBWzmJS2Qt9wOi3o0BU2raBkSC+hCOYMc7kaQ4o6gs2Rl?=
 =?us-ascii?Q?77XkYegyTcq39bH04Fq+23Zk7RzFls1pfvkTE9+Id9jER17NG1hBc2L9WlOu?=
 =?us-ascii?Q?/jfJlV2qg07zsmklYkbJK59+s5RqRlHSsIwBm524Ki21+uK6EA2HBO8c2vQF?=
 =?us-ascii?Q?9oyUZUyMy/1RUHTWXza0LJCcBTpO2Elw1xaFOznNUNaGojYj0nbhBkiTxx0l?=
 =?us-ascii?Q?9N5Q4J7Ssvepjjv/RhT9GX/T1QF5RYXdBqSjS10vf9o+Efyps3+FRa/ty3hb?=
 =?us-ascii?Q?QOxlpKansv+aurpAje1gxqWR6BDQiamzCcc/W7Bz+6p1Q2qa4n4E8uyi93Fo?=
 =?us-ascii?Q?4+oxq96OHnhHxmYmIRHdg4gEGl/ZhJlQc/LlzEL5+8D7zuvuW956m041xpfa?=
 =?us-ascii?Q?nDE8YXUn9SMsDJYDIPBy7+O+yoTJVmmn1PxR/Jh7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d32ec9-ddc8-4434-d413-08dc6428ffa9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 06:37:23.2661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: atTKMM8hFehLHPezERlqHEolNxyqmeRZS3wS1GH0fftael0cj6Dv0Z5uB49u031Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9483

The eDMA hardware issue only exist imx8QM A0. A0 never mass production.
So remove the workaround safely.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes for v5:
1.remove FSL_EDMA_DRV_QUIRK_SWAPPED in fsl-edma-common.h

Changes for v4:
1.change the subject to keep consistent with the patchset.

Changes for v2:
1. Change the subject.
---
 drivers/dma/fsl-edma-common.c | 16 ++++------------
 drivers/dma/fsl-edma-common.h |  2 --
 drivers/dma/fsl-edma-main.c   |  8 --------
 3 files changed, 4 insertions(+), 22 deletions(-)

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
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 01157912bfd5..3f93ebb890b3 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -194,8 +194,6 @@ struct fsl_edma_desc {
 #define FSL_EDMA_DRV_HAS_PD		BIT(5)
 #define FSL_EDMA_DRV_HAS_CHCLK		BIT(6)
 #define FSL_EDMA_DRV_HAS_CHMUX		BIT(7)
-/* imx8 QM audio edma remote local swapped */
-#define FSL_EDMA_DRV_QUIRK_SWAPPED	BIT(8)
 /* control and status register is in tcd address space, edma3 reg layout */
 #define FSL_EDMA_DRV_SPLIT_REG		BIT(9)
 #define FSL_EDMA_DRV_BUS_8BYTE		BIT(10)
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


