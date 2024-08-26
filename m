Return-Path: <dmaengine+bounces-2967-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BB195F693
	for <lists+dmaengine@lfdr.de>; Mon, 26 Aug 2024 18:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3AB7282182
	for <lists+dmaengine@lfdr.de>; Mon, 26 Aug 2024 16:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D891946B0;
	Mon, 26 Aug 2024 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PpbCKo1p"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012004.outbound.protection.outlook.com [52.101.66.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1672D1865E7;
	Mon, 26 Aug 2024 16:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724689879; cv=fail; b=qJ0T7yrhgGxT3Ccue4cHViV+xfexc31GhqkoehESf2AhkkGLE3w1Oy3xkGHEQVlA8Yj9L0yjRi1IiAg2D1vHxtiXmsL7Z/EEKPxYmTidxFr8A4ueDkNS5N8wa+OZZ0rvvDQsUXC8JQKmtgAP5eILnHQfQdNlM+SGIc290VE41+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724689879; c=relaxed/simple;
	bh=M7lFVx2F0doGFe8D1YzxNTQdjPNG+u62950YGLi2w7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QjoODWkV6CDE4ytaEre42B/CVHMHK7kFMfignKBvIrty+86M+rtWWL83XfcYWrCiCmK9A/1bsO2+fLTiMlBoq2grIARabkMyAPPZF7glz787yRbzlw4EZpRbpG1TSYba4J2WOduWZGweHqYHctCv8Ic0IcZY0zlLqMEwAefAXpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PpbCKo1p; arc=fail smtp.client-ip=52.101.66.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XW7r5wxSXiR7zqyGunM9FFwrubSWhiUp2UbLxz0rQmPYoREGzw+SCHG/eyNKasSPOYeab5v7ovWBDbMzwHZqJUf22qCDd89mgtTLdusiNg3rpzr3uO71Nmcyn8r3qzgGKQtLR/bUVqrrLyPVoP5q6TdSxqvCDPuBUfIQfxftc17hU5udKxuQ4PNevKFOY5ehUwyOPbl6XO2lsBPffzxvl7mQhzfPeB4p/4WzJnPD/FT8UlI/yKuTnIBETr+ea8G46iSkSswFznPCdzYhUoDmuefZWApRCaxN21xjh0RAddVZ4ClqwUNZqjkCc/C207Hst38jqXK3isYnnFSbTbRzhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0u089mwEQFQc5YPfD0eArkFQhi+AYchIVRea6dPbxQ=;
 b=RvwufiraItvL1MPp6z19CBqCrRJDVv94WGC24cnw7CCheJ/48tDWVxFjMPjJEwTwTF3Nsn6NgVdKub47DMRMvxLd19fD+TmFo5rCa5o6khx3d8QF9PKWXXaTsnRGYJOp4RW673fKjx454L6FUD1FKxYDKKDek8JgHewPo0VywS7UQ1iUwnkc4M45A0Gu1al2nXLKIv+yE+yHd6BXnK8kmgcFoAaYoLwTc5sOVRfJLl0oC/pXQx54JeNFvevO2CvDQVoXJy2I4pUzX9dLkbNrVS5ofEC4Efyeq3Wz2xmh1Z0Hg/wfoJqunBnvxmXY0NDl+g4ez6VGTsAXy6ABJpE/6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0u089mwEQFQc5YPfD0eArkFQhi+AYchIVRea6dPbxQ=;
 b=PpbCKo1pR7Vk3nXm6nGRLw5Z1D5k69HqiUw/ke9ZZTsgzSR3SxH70xE/dZB24DJg2rsFB0HRsfNEYFdYOLo/keYcvfAZvTfLkSQJz9dM+dsGLHLtwctrTqj1F3UHNa3YjwD+T1dnkDlQ72s4mRO3lZzHSLIvjwgVsChtOixE3zEU+OoiQrCCg7Ipq2GhRs21UD5vwx8Gtf5lMdIGJcMGql5KFO8GWEhB0Fn7W9Q1SV2B7Diqx154bSVNh/VoO4qeBJRIdMaEqzrs1eezGALY9ENj69WeYkfce+rU73303h+pXD6zOOdV6gjO/FO4l6QsRPFvbUX5IJYVdANcwgt2hA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8371.eurprd04.prod.outlook.com (2603:10a6:20b:3b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 16:31:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7875.019; Mon, 26 Aug 2024
 16:31:10 +0000
Date: Mon, 26 Aug 2024 12:31:01 -0400
From: Frank Li <Frank.li@nxp.com>
To: miquel.raynal@bootlin.com, vkoul@kernel.org
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org, festevam@gmail.com, han.xu@nxp.com,
	imx@lists.linux.dev, kernel@pengutronix.de, krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org, marex@denx.de, richard@nod.at,
	robh@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org,
	vigneshr@ti.com
Subject: Re: [PATCH v3 1/1] dt-bindings: dma: fsl-mxs-dma: Add compatible
 string "fsl,imx8qxp-dma-apbh"
Message-ID: <ZsytxXE/4Binsl26@lizhi-Precision-Tower-5810>
References: <20240801214601.2620843-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801214601.2620843-1-Frank.Li@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0148.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fb3cd7f-0efe-444e-397f-08dcc5ec7e9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KkCMRrNMPnGFjs/XiSBWjIklRNwuW498WBCD8w/NzIbFsNEecr4HIhB7uMAP?=
 =?us-ascii?Q?aGVJUAmvAMnj0q7g8xuYY9SbshwjPASQT5g2HFZ5LylwNFKElDMyFS352cnw?=
 =?us-ascii?Q?wwojKquzj3uoTAmB4EsqL8d2dPvWuyQ8/MgvNEvUy8xbXX5AgbIrXY7baONE?=
 =?us-ascii?Q?v7Mz7GH/oJ6f1OuCBCzWyi63FTWtkTFrMzeM+Sr9L4Bl2r1Rka/RbUnNNJzX?=
 =?us-ascii?Q?lwxJa6UsmTnZ4fZ71ByHrqDCx6aYIODBSIlUGEGiD4V8n4QDfvGq81RtzCKI?=
 =?us-ascii?Q?y1grzpY8YGt3UxAKYA+syK7tiry0+2UoLenoJwmiGN2KyRD+Zyyl9ZEr8B/l?=
 =?us-ascii?Q?VR8EkuvuwTAYZICG+HCyKksxigT5P9qVAQJOl0qeycLdEj2eacJLoa7GgLcR?=
 =?us-ascii?Q?ZyIbs6LMZ4ON6Jgf/Q3J5+2dItxTiVs8fjex66IvbHsyfnNAEMJIZA8yHfOm?=
 =?us-ascii?Q?dgzD8Em/yrCO4Jy6uvH9AgqlmE2XZpdkkcxgTHCyJYHPl2B4B/FsNapOOy9c?=
 =?us-ascii?Q?KtlYhXgYXpWU6OMD1pP0LYf/0K3wYRDwmiaw4Ydu2vgKaSR7cSKnK2hYXY3q?=
 =?us-ascii?Q?Uq7nT9tNV03E2Qti8rgnl1jciKeZkoBtMaGRuHJ2ck3BycogfFP16Ix+Zuc+?=
 =?us-ascii?Q?yvQJQNZC9xN+1jZu/9Nhh1HpAgVKVcihWtTXoTeKYzZzp0sPk7IM6xyN7yDs?=
 =?us-ascii?Q?i8Usmz2ScJmmiOaNpYVZD/dR1Nv2Xo6JYN2ceE5nHnf1nZ5/CYCDl25zpuAF?=
 =?us-ascii?Q?Aa7NB9e2VPqHOW/+6ww1X+IWwVvA2quWKD9pv73WSGQLgfa7ywMPA1a7u/id?=
 =?us-ascii?Q?bRBrGnAD1I8im00Q98v0U85h7IkWPWCBTUW5HKg8e7N8oAx7HkhbNu/U7sXW?=
 =?us-ascii?Q?tfGAdFzRfqQyr3ZE84yNWSDm/V5sVZis5NC+0ihFnYD/p6Nlxl0Fs40A7xZa?=
 =?us-ascii?Q?JwD1fB3tUwBrZLHfypEstV84KA9E99fnVkasha2F8r6eMIsjddpYHCQp3tBg?=
 =?us-ascii?Q?dPCCZKiQ+TEr42RAJcKsaivfaHlNQAwe+qmgffyyJUz0vM6RV6cY5COYsUdv?=
 =?us-ascii?Q?qnJTloSPovkulbcOqE5wGr06cTvJpJ1B9D8LTijbVtv/RMfZLhVbs6bes0uY?=
 =?us-ascii?Q?0oT7fALhm4PLKtxc+JQOqas+5XGVL1BdLkmqdi0ApdVzllzpiLaMFSjH17fP?=
 =?us-ascii?Q?KC4If4y1YMRgE3K3p1O3ryXTg1+fdVIouqviEKuypQZ0csQn7+D6P77jhD6U?=
 =?us-ascii?Q?mCvIdx9yCB1zvA0pUNR10zJMejqVQWo1KmXSFwjlOOykjQVilKdsWdKInbVM?=
 =?us-ascii?Q?OwcIX7Ch4baqFM28d5bRo3X0Ns5D0Ramt420ke2E7Wr82xBo0DT8Gdf1VHAP?=
 =?us-ascii?Q?spq2J5X1wylrIBVeJQT93dNAOxspFf2PZjpshNckF6gD3KMCMg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YcY90YGaHdz56L3TvJ/PZt05qndc5tS96obMcetrss5Qwxjg7dy5xxDxvgDK?=
 =?us-ascii?Q?tuy4RLecB0+TFIxrKuPbY/q9qsZfH3AeaHaAy7mfFobDmKyvh83v4J4zfSAd?=
 =?us-ascii?Q?puGq5u+9i3RQDZ19MruM5q0x1Dw/Pm9D+PkA+ham5YIjU0IByWzHWTja+RQd?=
 =?us-ascii?Q?Fp4hoAkYCt5HX3/HnYvn6OEvxJP4GIFee6mHnNfkqF9DKu6foWiO8I/pv2Om?=
 =?us-ascii?Q?JoWNQFgYYunGk1ZBz4FoAU7qImTgAsZRH1aPklZTpyFb0lr2U50EwdyRwHms?=
 =?us-ascii?Q?q7C6KeitjwZXgFMCqGOXY1Z+Cs6SBGWEPUOiUYdJOUlcSe01Hbk8WwtC++01?=
 =?us-ascii?Q?eKaegUWcsMccvNrjVrtsCFHiTlN9gL9ZSTo15KCgFXy3skDIqtdSvDcCUTNQ?=
 =?us-ascii?Q?PcxoXpACdXyGfC6p0ebA8LXsdVhlZHRdZmkUcs3RIN20MLF8GqEUE/lnlSvI?=
 =?us-ascii?Q?nZCThywFFOridH8xfjZCK3wyWf5F/ueUYS8SELlgJV2dBOkMFKQmEobFI67h?=
 =?us-ascii?Q?5TYOPYULs0TR/tJMgFNiClE/nLatTCXwdrhBWVy3jJNNeXwA9o1WbSw5rhfw?=
 =?us-ascii?Q?Wf723tjU10FoD+z8ifrc2rEP/okmHyYJEgDcqynBCe4SvFQSVsPGBDcUlknk?=
 =?us-ascii?Q?zpVGzD0Srhm3ZGngSGD/IxgqzWJ8Q5NsTlB2uPEm/eKmAxjtQhD7VTDZU53L?=
 =?us-ascii?Q?b6bjRM/qpAsW7n6U7pPC5n1HbdVdjH463KnQoO4nxg3YfSYfwijedRi5CWVa?=
 =?us-ascii?Q?GK7c72OKo9mXGdM9AVGefo4uq9mdu4AjrWGXM6QVEcGu9ZZM/WBkeBE/yIBS?=
 =?us-ascii?Q?NmxmWznf30fd3qNchDtWIPY1SYFaF50gbZaSRb/j8xlHRN1lMPL5+yDnvN7l?=
 =?us-ascii?Q?BE3LWCQKxwdhH3n6GBXXV8PoWJkTPIZei1IWLLe+EhYbFMP9z1g9tqOH1MyK?=
 =?us-ascii?Q?Cx3cVyeZa76h6lxjbEu4SHfS6U9Nw5NGhyB4DavYhOQF3yVs8oWirH5wOaCQ?=
 =?us-ascii?Q?MtKEzzzr4IAOL/Bb8a/wyzpst3h/Bs98fUULSbd5oIACzfigPxizqsVXxpH3?=
 =?us-ascii?Q?VftxtCEGF5PgZ/vRO+vJmalG6P3IRcc1zMMDnq18JICbSufgtFyyouEYyfYb?=
 =?us-ascii?Q?omJDACrGy6rjtDdyy2GE3VDPoXjFuqRyj1Wem6PkSgaKzwJ4rmFYuseFIky9?=
 =?us-ascii?Q?tK5MylQ7iNcajbEM4CA8HLtOa8PbR5fSgsz2VJe+3BjC9YLAER7n5dACK+D+?=
 =?us-ascii?Q?EbbNtJoqk9DCVyfhiu7rlk+ZlegRMEFP9PTSV7NZA+ktd1Ebqcxqog+9m4lu?=
 =?us-ascii?Q?xObrglGM0xhHgWtUGh1kIHbNNIjTNKCSJa/J1tv/3/pvKe2CVXnV2+yVWTip?=
 =?us-ascii?Q?9vWZBhFky1K1JMmQ8DoickFlkFz2bA/j0kT65d2wUzSZk5FbfQz4tdH2lQUk?=
 =?us-ascii?Q?TVQI4Iww619hV8zfnut6z9Uf5E5zT5buEXbr0zXeQQnzPemUw0jypGdCjY6F?=
 =?us-ascii?Q?od4au9zSLVlYnf6wlQelIiKan5Mdl2WNjsLMotOfHUPOtF1xFulX3e27V6/d?=
 =?us-ascii?Q?/dEiQigJd4dNvBmHFY2UnAAV+VEdC80JLLEASjlB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb3cd7f-0efe-444e-397f-08dcc5ec7e9d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 16:31:10.8168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YeIyIBheDfESNuYRReKF1Uxpzd8ocG3M5UD455+g7zkbgKIwfhrTlyJaidzl1ELfWiIDGKkaYR9tLdAq5t0Y5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8371

On Thu, Aug 01, 2024 at 05:46:01PM -0400, Frank Li wrote:
> Add compatible string "fsl,imx8qxp-dma-apbh". It requires power-domains
> compared with "fsl,imx28-dma-apbh".
>
> Allow 'power-domains' property because i.MX8DXL i.MX8QM and i.MX8QXP need
> it.
>
> Keep the same restriction about 'power-domains' for other compatible
> strings.
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

vkoul:

    Could you please take care this patch?

Frank

> Change from v2 to v3
> - Add rob's review tag
> - resend because it is dropped from mtd tree at
> https://lore.kernel.org/imx/20240717103846.306bf9fd@xps-13/
> ---
>  .../devicetree/bindings/dma/fsl,mxs-dma.yaml      | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/dma/fsl,mxs-dma.yaml b/Documentation/devicetree/bindings/dma/fsl,mxs-dma.yaml
> index add9c77e8b52a..a17cf2360dd4a 100644
> --- a/Documentation/devicetree/bindings/dma/fsl,mxs-dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/fsl,mxs-dma.yaml
> @@ -11,6 +11,17 @@ maintainers:
>
>  allOf:
>    - $ref: dma-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fsl,imx8qxp-dma-apbh
> +    then:
> +      required:
> +        - power-domains
> +    else:
> +      properties:
> +        power-domains: false
>
>  properties:
>    compatible:
> @@ -20,6 +31,7 @@ properties:
>                - fsl,imx6q-dma-apbh
>                - fsl,imx6sx-dma-apbh
>                - fsl,imx7d-dma-apbh
> +              - fsl,imx8qxp-dma-apbh
>            - const: fsl,imx28-dma-apbh
>        - enum:
>            - fsl,imx23-dma-apbh
> @@ -42,6 +54,9 @@ properties:
>    dma-channels:
>      enum: [4, 8, 16]
>
> +  power-domains:
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
> --
> 2.34.1
>

