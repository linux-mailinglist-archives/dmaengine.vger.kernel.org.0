Return-Path: <dmaengine+bounces-10703-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHZjCHc+D2pNIQYAu9opvQ
	(envelope-from <dmaengine+bounces-10703-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 19:18:47 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9AB5AA0EE
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 19:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DA09319B0C0
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 16:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B37037E315;
	Thu, 21 May 2026 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hxyMmbvG"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013021.outbound.protection.outlook.com [40.107.162.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922A137DAD0;
	Thu, 21 May 2026 16:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779381700; cv=fail; b=MknPVSZDbHl0gPJ47hWNRGRq41vD7/sg22uV0c5+ymlkuPfl0Bod0HwTbXrvTqzIpF32fdtz+ND+0hP3clS+G2rkUyBfncDT8J94yY+78bkwXBmPOoQ4xh+ujCiqzzgStAmZo6lG6yMR+4muE9Y1JGPKAUbiOyFuabGIu3Scm4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779381700; c=relaxed/simple;
	bh=o/YuqwoYTTjHjTFuH3CJJSIZFUVZJGDH3HQQzC33yqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tbCpkSDpXaDb4YQ7Q55I6KkfzesZCOVTg2q9hAy2IWMPfmQ0hdvyu/opndcb5SKSKikIAxVR5qNB7xsOrt6cAdETcWAu9lLIcT67CCL+8yU68KYbBfgPUKtqmhLIoJsOU/MWkRzd0dV3NCksWtwlQI2GHQ3VF/C25HyAHsrHQV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hxyMmbvG; arc=fail smtp.client-ip=40.107.162.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPCBHMoQNWmBbrPM5kVMkb+BJLX27xncWbstEspjMAd5SnrhbyLxoL695ABP06Ez+e4vIc+lQ0qn5H0AY99Zo6eR/YmYh9rSIaneJsb2/bWv8Jl6gTJMxxU7/5Kn/ddHu1WYWRDhYo1k9PwqRkJiBdQnfMh1jUrl8ANR3ygVJUgxQq99NZsR+6U1gHfmECCHi3a+DbgyxZW/UbFpnnoea3LmfOWAiJJc5uH0zJ42TAbX9AFLsAm48qxaKcTYMlyPxEmOfVXtQ3ARKg9OGZ2yOmGkpM9rCrRYEEw5bCN8qergxt2/1cyNEL2r98/RKxYOkKpxXy5AEQwkhOb6I6Zmmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVc9g2D3zKgcBVw+rn1EYayupC58TCP4/sUnzBlHxO4=;
 b=DkSYZ6VH97TUwD+nfZbGattAn42k2DlXKTbfeWJ5kWYhGCQg54OZeTRtE7mGIfjfVGLUj46C95xTGzOtkyftsxM1CSAARn/3reaClZPxaVv62x01ofJyPy8/kbRhwshTAUokkLh0CTyy6aX2rdprxlQK2LL0URgn8p0Pjy1yz13kcGELhvZm/rk60k4a+oPM5d5pR6exWNv2aa9L2NLWk4v8766CCLkcmifY0xSw07JkdB9rI3j6pcLHWzDrKGl9cn2a5gnaueYKG6iI3W4NBv+e443Z6QljDnGZuPMjJKeAzIUbQvASRwQ2EBLIFY3F4EhK2frvSpr7iOsI1RlE5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVc9g2D3zKgcBVw+rn1EYayupC58TCP4/sUnzBlHxO4=;
 b=hxyMmbvGhPIZISi6OSq6tgAdcq3pyAHOpSI6MBZ7AafiOQeOJKAs3v2rsiQ2KgysQQ1cQNaRzL2SSrDWWMIQhsQENnZf9TiixRnI2/FTpXZR75/xxvELBM9+7R/Ckk7JTDM+RNriI1jTfjLyCQP88YRej0QjZHSFuwQaXFILmle1BaSmZAz67eueW8kj3uyBWgWgpHFDSwSILlJm1iBfGpbvbsqzUOD8U5dbHY2tMJtNzyF74r94LF+PNCZMYobAMK0XTe5SbcK/L5+Kren3sZGz38ozEHZIBwZw1UbWtey17SLnGEw4MSs8nz0BuR+M8HU5Yesxt18snzBt8TymkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS1PR04MB9407.eurprd04.prod.outlook.com (2603:10a6:20b:4d9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 16:41:35 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 16:41:35 +0000
Date: Thu, 21 May 2026 12:41:29 -0400
From: Frank Li <Frank.li@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	imx@lists.linux.dev, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] dt-bindings: dma: fsl-edma: add optional iommus property
Message-ID: <ag81ufhDhE5zdIKn@lizhi-Precision-Tower-5810>
References: <20260521-edma-iommu-v1-1-6eec3f24c306@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521-edma-iommu-v1-1-6eec3f24c306@nxp.com>
X-ClientProxiedBy: SA1P222CA0162.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::13) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS1PR04MB9407:EE_
X-MS-Office365-Filtering-Correlation-Id: 147d91ca-9340-428b-c3bf-08deb757d233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|19092799006|38350700014|56012099003|18002099003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info:
	Gny1YFxW9OqoR+S0LDwbADxR3K8eT+TAeVFKjerHzKcdyB1DxDM6mVxyWIXdXGgWXsTa5n6R48vP97Fodm0AXxs2qgnK5DT6VpsU9WgckyGVcGHQ0hk7Ox75U35z9xQeiGa1+qMjA2WTHku9caR5c9w+5jdRcinypkTVc/DdvLLujgDWtBvYYe1WOR6FIraxyuuykBl/ItvzEcWJMCx0Ni+OxT0ht9tKvLkZMFKL+EyVb12c5RzUTlGlJWypnZaSGlYJ0WZoDgPIdMjbu5O2TkgNFvSlZwx4KJ/coFPJI+1SN8+Cjq8n1ADLSw7yLhhjNdLSPn4mPJwgLwUSHoWn3AiqDhqpHivLr323SWnqWv7r9/FlHVFZuxqSkFBe3p1/9q36GtAyGuE773B/NECBvU4OM4JZxoFRr1iBqDhH22ronh+fYwf+1D3u2AeI9TP7eQW0ItjnBaC64hRLQk4mlfizoMmf2lGlFtnKyoHz9AlYw6kmubfTnZjjUxnSiCslhf1VoWQ6eXq1x4VNzDnIQbU6AfVEnMF5K26jGVrQIzkaQEqxsk+xIIfOqS2PDM6NZWrbFgALMTE+/0xkxypojdaZAjDhfeDC3wTA81fGa3tS4Nm1gVHmAsJF8JnF3p6z8eD+DJ+Yxw2ZYUhlswZZW45xtOkr0PQIMUQA0uk6SJN+I1Krik7ajZu2kGOIMALtlXpl+TvMDICx8Cc7/HBfdfxwmpqbL9iLSalPDrn/fzl1BPMms5eVObdYNW6l8BaI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(19092799006)(38350700014)(56012099003)(18002099003)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UAa0j9W/MlN2mQMIBpoG3TgQekQ6YyreHoabx23p5YwRwJVNQUU52jCxptQ1?=
 =?us-ascii?Q?WprjznXikllO3X1w5vw9PkVSY+m5vSnRIWAGbMyr/vmhir3IVfSrijH+mUDp?=
 =?us-ascii?Q?CA8XlfdwiOthFXdbwY+CY1grSK/w/RGCVX0CQCAM2r0TLIKKrGfLzd+MjcAE?=
 =?us-ascii?Q?1JSoBB+pD6fOkADjSdFu8Oiq4dkcw4DFru8TR0RktN0JGjW8E3DcEg+DAI0z?=
 =?us-ascii?Q?nYDWQ/Yv3TYSYSGXb6kvtFVQ+KIyfmofTyT8871mQe2L8/g9k/7A/ddbdfze?=
 =?us-ascii?Q?Ewp4mZpUWP5eG8SBkQl0EN4vAGymclRdEqqYazkCAMK7W3W+0xjlYx4dKR+L?=
 =?us-ascii?Q?rLIQU+qEWE4Uwj6qjzKxAWXPj6Jvc2WHIsg1sp+rhcvdI2Lddtia79e5aht7?=
 =?us-ascii?Q?icCjDTfWguL7kC7ttj1UkrrjvlsX7BSWLR8dfR9JWX9F72hQO/slW5Opjc4S?=
 =?us-ascii?Q?yJeJsCkOjouRbAALaiZ0YkXFOItFkqfQzbTWLrcPEvR/8pCKy2pC+UKHsPrf?=
 =?us-ascii?Q?jfSPu7WJ5tyuPMXDP2N6ZmbdbI8aVa4BWxvHfUMOgTXFsAqCutya/hYKPr7F?=
 =?us-ascii?Q?KPW1Ho8mEZfGfvlhy8A8B6Mgghr0mZKmcZ7g08pC5g3ezfxqjF3DT/S2JwBl?=
 =?us-ascii?Q?P5P97ZYflS2fYKNyj8CJnMHv3WSFb5TDscWv78MqyTZFGPfZwDZ/a0j7MqhJ?=
 =?us-ascii?Q?9lc660Cks28YfMytOD5Z4KQNnx2pnLnLQ+04mfJorNsTcIVPI30h62ncw+oi?=
 =?us-ascii?Q?lNvam6c3ybEFCdhPSINXqiXc+vP/iXASbFtkdnr1FrQikxBceeIatCSEZpuM?=
 =?us-ascii?Q?g9VTV5JZFVU+TCezYFpIL49Pd2w1Bzq6hSSsMmWFJTLC/NYbgYlO7qbm23fw?=
 =?us-ascii?Q?SDlw4Pg+i+KyqR+aC2cW2ajeaXc171phc11LXXl9aseV58PxfLNiFPi37lsR?=
 =?us-ascii?Q?pS3VRASqLb1hk93nADzpv21T4BJhLWiT3xPOWETfF0k9yjpFs5FZDHDcPPRh?=
 =?us-ascii?Q?rz8bv/Y2fLdBgIuay6N3n3MP6FrFBwrBxiqmj6jrEoXPJdcWySUcEqZZ0Ayc?=
 =?us-ascii?Q?qS+sbs0+elKsUoUy/14HscFrz+hsPfs2JFmtFRzUsHZvnA3os6z3r1wZaJZD?=
 =?us-ascii?Q?+7+SlFF5R41ieQkrbMLE04D8heKpoB/5y+ElQsZbw5v/SXPYK9xoqPbl8T/h?=
 =?us-ascii?Q?JxXiJQ2Zp4lL8qanaO5ddM6MLsjaWcbB2nyJMU6qTQXkoJUqeiZdXHdDkFrB?=
 =?us-ascii?Q?gO6elyJI9ztlwidGDOUm5h6X0tKgIhqi0dJrHGVBhWm0EV2VRnpGU7mS+E0A?=
 =?us-ascii?Q?QYL4pfEdMZ1CEPROS8D6JzNsCmKV5Yj29qZAMKhCg+tTsLJmD7FlqMX+u87N?=
 =?us-ascii?Q?uuVqzDdL2fHbN+uWZmvORcC3JhRq3G4tpkpSBKbkvC8euIXjPTAlWf+U5CoV?=
 =?us-ascii?Q?ABWbJKUKpPQKHiGSEfqWEQ2FFzWdnJIioBg2NEQSYSSyOjr66ymmIhvnLlXG?=
 =?us-ascii?Q?LMAGpCsJCu/zHddKYjTLDVWdcPynE3DlcSThUD/gQyRau+LRnH7oHrgyDmZM?=
 =?us-ascii?Q?TX63nkCYRRGmx0nlv5kLW/1Tr6o2yxd72bstVWv1EGwLaya2Oouy0bNP6bum?=
 =?us-ascii?Q?iyVVfaEzqYdvj03lctDSYuFKpYlbG95fOgta3G8y+qSQ/uyMJp/SN4KypIDE?=
 =?us-ascii?Q?FGnD27Ee7ckrQIDNC7AckimW06+VFBR4bTMMGNgYtt+GBcrC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 147d91ca-9340-428b-c3bf-08deb757d233
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 16:41:35.1261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LbZX+SToeHhmzyG1KNhNcR4nOpUUTqM7qHcVU8h0AOlqn6QYjOtLKKzIGo4aaKl1VhBpC0CwihEKRpPaVIbSFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9407
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10703-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: 2B9AB5AA0EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 12:05:04PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> Add iommus property with each channel could use one IOMMU entry. i.MX95
> supports max 64 channels, so set [minItems,maxItems] to [1,64].
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/dma/fsl,edma.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> index fa4248e2f1b9cecd00f1535744bfe6d9ecdba613..bb8de804da53fdc47703f722f18453853742209d 100644
> --- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> @@ -54,6 +54,11 @@ properties:
>      minItems: 1
>      maxItems: 65
>
> +  iommus:
> +    minItems: 1
> +    maxItems: 64
> +    description: Up to 1 IOMMU entry per DMA channel.
> +

If difference channel use difference's iommus, should it use iommu-map?

iommus here suppose all channel share 1 IOMMU entry.

Frank

>    "#dma-cells":
>      description: |
>        Specifies the number of cells needed to encode an DMA channel.
>
> ---
> base-commit: 687da68900cd1a46549f7d9430c7d40346cb86a0
> change-id: 20260521-edma-iommu-c025e1d28eba
>
> Best regards,
> --
> Peng Fan <peng.fan@nxp.com>
>

