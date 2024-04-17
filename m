Return-Path: <dmaengine+bounces-1858-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D47308A7B08
	for <lists+dmaengine@lfdr.de>; Wed, 17 Apr 2024 05:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF8C2850C0
	for <lists+dmaengine@lfdr.de>; Wed, 17 Apr 2024 03:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E178BF3;
	Wed, 17 Apr 2024 03:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="d6uhlPSi"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2088.outbound.protection.outlook.com [40.107.6.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB3B79FE;
	Wed, 17 Apr 2024 03:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713323947; cv=fail; b=qqVvhncedblWwWVNjTM9YsU7kROue1pebVI5dB/tmk7cur4KRBkT+chjzNALRSrPCYn3ik1yA0qCBCPFPy2vbtqkBAua4JvoC3/4C4WNEaW9EV7VklI9Haq+Cn2lmcN2ijBu0oZ0Lv576jR1Kui/U4l2+AUVAKlobtcuEbkoTao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713323947; c=relaxed/simple;
	bh=X8I0NVkB5cPgM+ewO79bZ6bG1vv+v2RmfcQqyLHUJ+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hutbQgDWG6bngsnSaZa3ogr+EzLKljyxg3zReodj/owAYQ0V1JM1fNDzTqUzCeIr/Zjf+veEXEJjbdiqOcl+phGkBlYt4IsdugUN8jENLx6R4cu0DJznCZQfBZjr/DdOW/UzFLN2zaK+ZNVnw5nUoNVgoEaF0CW9sXyyQaKiBus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=d6uhlPSi; arc=fail smtp.client-ip=40.107.6.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbZueDS+rhYdJ83SWz9vQTqv7EOe94ogmQ48xPincR8DpDwX69BTCr1GBuA/YODV2d96/5C6CKcEbbrsedUSFo47roFBc6w2nMcCn7tpWBoUGyQ57O7qM5KGoMLeruyzAKW5F7SSWtoHZKfZ598Q9q7bpu9zZM4SkhVQfCBVOyocvNgkXWZgWyISVcwkBQiv2qs4qUSap+seEx2XC6usTYCIX0m4HoqWnckOjtvPYQqzQFsBTLxixFg1gNfIesr+U0hUr72P1cwK32sq93PKhDWYPbKTFRYtcp4eunDPJq2LXDHJcKqYfrBpwIBxnRL6Dxu/ZzAgAKbK4a+c73u/BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJ/A2kIA4eK09P3pYu6HqE7psf4Y4ahFHkWHIjim5VA=;
 b=UyRLbYDL5WV0nd0I34KWy8jBBooHlwN6xMDm5/iKKVPstaRTgoijA7QClOwC+FrmqB2hcngtRo6UmRPHXDxwfzrrMWzDQws4UeCgsEya60qCkBdyJsTfvHrWwvWgVj4Y3xduEQzu2U97uIcIz6jH8JheQIHBFQDzWmJr3Qz9kOEmTajTCKanRGSR1aG5yc8o4ov9VuIb7LgGIW64XDG5sNMoDKRjeVAoccKazQa9CXw3ayvpqgSUkNe3mROWAgjoD9r9w6DHGzVkTqS7u6BC3P/WrzqfG84LXfWcX5GV4a4BHCLOwQe4hqgyZLWM6SwaBPrrk4FZx5TtGadfzaM8rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJ/A2kIA4eK09P3pYu6HqE7psf4Y4ahFHkWHIjim5VA=;
 b=d6uhlPSiaGRLJya5y8NBl3hsDGspMm3RB3eDO3n97zXpzJEXh2DP0Kktbhq/fjJNzyZr5DOc1ks+/W4nK3VlKgFC+PRpE35FPfVhyQOMNV1JC8FGO/I3vhuSgDyngl/seBvIoNbmIep3TwmnFfWUtWUDpdwQ3OMHuceTSxaizL8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by DB9PR04MB9305.eurprd04.prod.outlook.com (2603:10a6:10:36f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.43; Wed, 17 Apr
 2024 03:19:01 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 03:19:01 +0000
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
Subject: [PATCH v4 2/2] dt-bindings: fsl-dma: fsl-edma: clean up unused "fsl,imx8qm-adma" compatible string
Date: Wed, 17 Apr 2024 11:26:42 +0800
Message-Id: <20240417032642.3178669-3-joy.zou@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f67c00fb-0087-497d-076c-08dc5e8d20e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/L0pJPtYUz1Xl3NucqQlvUNUXcBGdWmmd7mL/Q4DtTd83I9DeFF9t2jLoabHbSpKV+HZrDsTtRm35UNgRFYt4RmdyK8R6i/EJJcUzwy0xiLXZv1vMv3DtHDdESLx7o62LfUz3mpv7HkTbWBtBvgEbrYq7akQBwhRDGzTFpFP4ykQAITXwTSjkKDhtUTdPX8ySdSBmxCeyDrBh5nunpW+CJ2THdK1Vs8SKHFM/wt77AXc3Z8s19S/n3LVDk3jlbgtvujpwyaxE2bZZJRoh2iv8kL7B7E9JpjTdzBIASNB+tFLBx9HToluAuULBPEGS9yNzotsQOAFa8A9HbF7x/k0FAnjYvRVdsntlGFKMpK1LfMGk5/xe59yTQqI6jFygMrlLpFvYyBUtdgPWBRiECbcbZqGFDmIJPXmGLbX5uJdX4X0hDeYGObSHwQVZnxYZY1XPUNgC68g0GymgXx4CPT2SG31bJH843C2xXr7DeAEvr4EvxQ2BJFNBYYoUfhKIlslQ1cBd81q2X0d2An2QyHzrkQsvApbeXdlu3zgTF5g7mlSDxocIe126QDTBBt+vVwrdKUz8Oyb+rwZPHd6xFpHJTs5hVQEfPhjFbozi7SMR99ZjtppHk9BUmcQu00WHoky8Yrv9XX+5XvwzOyonazsnhlqKPGc8f6dnnE/lVO29nhSdquYBEyrQs8pk/7Jr1/WLygsTYnMBCCOLIxuS1ux+/l9pJ+P3XJwumIusf8eqqs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?miwPTFFSv7wfgtL3ZzrU+iSsA8sD6R4ig/5pQdm949H+hZVWqRNi0l78CjLc?=
 =?us-ascii?Q?EMKR4VhQUVey4tWhrJWrRBg5cvitxy4kTif5NIdLBTx2vKb6Na0X5M/MqdwL?=
 =?us-ascii?Q?TarjLqmBmZa+5QiWUoBd8dSTCArQG1Zb253HIaeAh8EjKy5JERuWmdrRkmue?=
 =?us-ascii?Q?BRIIdxwdDV2eWZSUWEVQAVUrht/Xt/KR8OEa1CPC/hnNDx+ZDcLX/lMvtHXS?=
 =?us-ascii?Q?sMy+Z0xJLO5dXrseoJoJz1EhahcsuEI5Io6eCB3AlBOjJc4i3/QaMzbrB3HY?=
 =?us-ascii?Q?kDKTzIDDqRtNFUun2gKa2jyVJhy10s4Pt4p0eFVDyFKS+kIoDGeUIm8hAYSH?=
 =?us-ascii?Q?htQO93ktu7a9pCFit+EkLLYJYu1VTWya3BhKlZg81+k8YI7434eEomM/UgHP?=
 =?us-ascii?Q?QwD1b15/drSwKe3IYlIL0ZlknPegrdNEzEGGd2X10SeCexDUVyWgcN8FwuHs?=
 =?us-ascii?Q?NDGaFU8YZUkazfPGD0Ch1xYMXPE75NiNx8QcpiPkYotvPctRVGsHXHQHwSK4?=
 =?us-ascii?Q?q3Gzq22xeylo9mUtz9kKqdiLFzuIf3+wHjmW5PKj9aNxZIkTn3WvRb1au3rF?=
 =?us-ascii?Q?8WqNzW0nFPPzXp09pZdtJdI7yrXJPHT94Dc86U8i2Fo+osVIBnS38GBBSZsN?=
 =?us-ascii?Q?R0NnLRIjLksFU95krUTLbZhOA/7G5bdKC8rkE6QuajFXenseoezk9/t0He/T?=
 =?us-ascii?Q?XUM28VMypfSkSZX+4JEmrmVuJrDR2vOkiAzvoiK3feDgIqtrKsFmwri8WCrK?=
 =?us-ascii?Q?4bDPFOX4I5aqQjpGLvZowHQFQ9b4gTUNTpLJ8pTnrwEyIHf1hpAXrzomo6Xf?=
 =?us-ascii?Q?dln0fUvBG/OkJhpzwAhlQ988XHJ+V0sancmZL/ILKtVovy/mwfMLzzXKxRFj?=
 =?us-ascii?Q?95JblguCR2qmJYDu7x10xyW0DCkOK1qkIZm8fs0h5j+Vly5PUkzrsGNZz83/?=
 =?us-ascii?Q?1ZThZQNLSTV7ZvSdrjwkwbEeOGM99jSA5SzFpZ1SezNJnYu1nbvOoU23UbwN?=
 =?us-ascii?Q?Psj4i0APuPXO8YhyHMgKsWpneSQYpSbf+hEWGC6+Bn1/yJCK6W8PYTprE+AR?=
 =?us-ascii?Q?SO29Kd9ozgxBzHt1HG/47zKQl9tcvpEKXzk5iMU2ezB648I1mHz7uIJt6z5R?=
 =?us-ascii?Q?mhYlnQdq+fh1zreBF//25vGNTUkYSAfq1Qip9/+tSwcsaWUbueGga+zSzu/U?=
 =?us-ascii?Q?s6zznKNBblRkHQIcFI+pTH/VQFt7GzHkFGHTB5cbUG/xFYYQ+g2LMoFhycnE?=
 =?us-ascii?Q?Ultde1bgpxvF2/0SahHvYwolkTKCLawKZCKxwiIQfgpLmKtauOgSjngvnpn0?=
 =?us-ascii?Q?XCofbKXrS64fSGlS92AEBxhcAXzTEzFAfYqiH7hTlpM5Y0QtwTs52ieYn4dC?=
 =?us-ascii?Q?fGxyeBVWjKyG0Z/Qj3anEWFMs0Z5DdQ1ojNQpApwK2FRAyLWKeNq6GEZHgrg?=
 =?us-ascii?Q?5cKFlnxfLF0zMdJE53u2uOqEaZeqA+FdR5Xu65UtBz7+b5JyXgqajSqn1PnM?=
 =?us-ascii?Q?xnz4b4mzLOzCgfZ1ykjEddQm4uXw5brq8+M4Mc0wakVlItYAWTHr+FtzpJfc?=
 =?us-ascii?Q?blD1fAXTnZi92k6yCUfesLXsfb8xxd9Pamu1/+yl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f67c00fb-0087-497d-076c-08dc5e8d20e3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 03:19:01.7712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BHBseYmmr4Z5mfaOA60xVEvTq6Csfkx0g3OdJvguncXkNeX5QuCb6wqYG1RJYXRF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9305

The eDMA hardware issue only exist imx8QM A0. A0 never mass production.
The compatible string "fsl,imx8qm-adma" is unused. So remove the
workaround safely.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes for v4:
1. adjust the subject to keep consistent with existing patches.

Changes for v3:
1. modify the commit message.
2. remove the unused compatible string "fsl,imx8qm-adma" from allOf property.
---
 Documentation/devicetree/bindings/dma/fsl,edma.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
index 825f4715499e..cf97ea86a7a2 100644
--- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
@@ -21,7 +21,6 @@ properties:
       - enum:
           - fsl,vf610-edma
           - fsl,imx7ulp-edma
-          - fsl,imx8qm-adma
           - fsl,imx8qm-edma
           - fsl,imx8ulp-edma
           - fsl,imx93-edma3
@@ -92,7 +91,6 @@ allOf:
         compatible:
           contains:
             enum:
-              - fsl,imx8qm-adma
               - fsl,imx8qm-edma
               - fsl,imx93-edma3
               - fsl,imx93-edma4
-- 
2.37.1


