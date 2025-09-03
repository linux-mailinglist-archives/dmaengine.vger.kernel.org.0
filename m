Return-Path: <dmaengine+bounces-6370-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1887AB42448
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 17:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F0267B3709
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 15:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A2C217F33;
	Wed,  3 Sep 2025 15:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AKyUnJO1"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011059.outbound.protection.outlook.com [52.101.70.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29C91EDA3C;
	Wed,  3 Sep 2025 15:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756911699; cv=fail; b=XhzePSCNNNSZO/dVURkzTI+y9C7Yj910uQ2Ap+ZsR89zsD05nOO/ODMkh8aCuVzLHMFxd9AoK4iuzdFyG13oMx8WYQKHoX0vL5FIW3RhoMRdGv0BnJRZt6c4URb4dPCKa6LmHGFT/f/3k5vhn99ExAcp8fuieQlqBGgAWbKY3ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756911699; c=relaxed/simple;
	bh=tN9LqBvKnOGjhJM7y3foNbUeOE1RJ04zPfdH3TIpdI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HbMZKqMeuccnBTx2Id41Il4AIHUrXTWX8yu9yeX6taA38kp++3j94J65+Rt8HpntiO3sMDYJRaALG+rksyzI6E+oi1myHW1sezAZxqUBL6jTW38X4gaD35wz+blpEuSSaHHxUmbXKMzbBI24d7+cnHWt8vWFgbLV7LUaMZE19tU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AKyUnJO1; arc=fail smtp.client-ip=52.101.70.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHDfeiRa6g0wJ/1gSHBH74VyBaMu8M7J59WBPg3gnkxEfuUEqMN+0hrjHWcoTZ4JWLYFjWSuhUtmSRts3fnEi+qI/vfYxJwwKYemVTefa3QKPLM9HIl8ukJv2aPEcM5KACVRCX8lTtbIZqd5I9aARTxRDBazx2Gs4C8SS/j2JfAQjTLs8lWq6BpjApg8bFUAgD28fTUG40XVypE5ucNXdE0B++YLhQRR11Fq+jPkgJDRlpUkmaZj6Vjm0IkYmFUTpyKgmvbtahQvHQImS2Wq1p3mTWGcooSjP9Gmxu1D2rhq9hDt5SOIWgetqyiPzzn+S5cWnBOGLjCRZduxFpuZCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lqvdq0riGsqifhByE68XKjVJMDzJCgg0D517yJsh/SU=;
 b=A2Paa2I7J4NHOyvdHPXJqUXXg7RwpfY1GNrCVhETd3KLFG2/cE0iBWKYGEk37t9FwBnb5aQ//hdv1B+J7mf+8OAdoIhRHh6xspZgsHLkQo2jljtIlgININbl4N2VjsJY86MUaxTrBDMc4xUR3T9Zh4qD7RYCUGJHVW/mCcLJMPfgujYwF/zwIGYbGlX2Zl/R1/ifpfDjtIGh3SW1R+rga0LZ6ZNYPHSSAdE776IUlFxjK0pMTmkHFjl183c08VOW5jD2Df42l1Jput3SlvsYBgGJZN2+5BpepBVqQNYLn6C1iX/O7XcZeT2T2Yw2KDeOAEHRcl0h5I4lOYSJdP4VHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lqvdq0riGsqifhByE68XKjVJMDzJCgg0D517yJsh/SU=;
 b=AKyUnJO1tRZAME/CThw6CdSQNsBmkzZAsP8bTzNbc61yMEXb+mrBgO2e3sEzhCOQIWRBB9YRaUbN8Q2TrCQn6SU4uJy4kOr/6095nXMV9kfLUSy3WNkmxSw8m/dB6gj0FLlBfg5meTUPP8x1LWiXDauNoUX/BWq3taqShPFWUzJQ1xTwys3g89HpudRl3s4Egnwd5QXpJfJ57UHO7ZH5ztuuSkjtOxfpnkfDBSaKL2PE/ffGRFEC3ZTw5uVU1ApGQ3jUcz+2oDVixGx6U41nXdOMeCxClX0micAQg5srkbsN/gXpjydNDvsWbcrDNKp0Jr5JtBJxdFO37sWUyT5QWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DB9PR04MB8233.eurprd04.prod.outlook.com (2603:10a6:10:24b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 15:01:32 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 15:01:32 +0000
Date: Wed, 3 Sep 2025 11:01:24 -0400
From: Frank Li <Frank.li@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jiada Wang <jiada_wang@mentor.com>, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] dmaengine: imx-sdma: make use of
 devm_clk_get_prepared()
Message-ID: <aLhYRFM+rc2VAT3x@lizhi-Precision-Tower-5810>
References: <20250903-v6-16-topic-sdma-v1-0-ac7bab629e8b@pengutronix.de>
 <20250903-v6-16-topic-sdma-v1-5-ac7bab629e8b@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903-v6-16-topic-sdma-v1-5-ac7bab629e8b@pengutronix.de>
X-ClientProxiedBy: BY5PR17CA0057.namprd17.prod.outlook.com
 (2603:10b6:a03:167::34) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DB9PR04MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: c99131de-fad8-49e8-291f-08ddeafac51d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|19092799006|52116014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CUGLl+JJVwhaKsdpgIgG071CYC3wqvOzaMEPcQF+2yvqulZ+IW9SGyMnvDkX?=
 =?us-ascii?Q?5c8JUjFCdltANvngOvaZ9b01sBYPsYQKgnjbS7oPBU43elbqXK1rJ1NAS3SL?=
 =?us-ascii?Q?uTZ/L5ToK8hHT3gHq96CW4L5qDsGZvJpap5uV7VRY5jHQjxSCexIGToh1VDQ?=
 =?us-ascii?Q?dl3Yh+f/uTIx+0AL7pvfg4XWzLcDTx9Do+Bb6EtQ778PtqkEjDnjfcMRIh3j?=
 =?us-ascii?Q?fQ6URjiCayjkEyVplc9CcDXr9fM0P0gafn8Gwi6FHru+EAYgkpRvG6Fn2XZ/?=
 =?us-ascii?Q?Y2g8U/DrmAn5XXKxam0elfzm7St0cZn59gSI7bn2bdj9hDjuJEcsZ2DV6TJP?=
 =?us-ascii?Q?jHEvt8q8PLiCF4yrj+C14pRhDe0CjRAmmg24YL0ob62UWLo7jCJREklYsiHX?=
 =?us-ascii?Q?wlazioLz5Z63TWv0GOpNPlYlg6xjVX8lYKNjvExnuIJBY5s9Xq/QIcrO74k/?=
 =?us-ascii?Q?fqTESShuCcr3rIrIlMWized63zbzS9hkLb7CfAI7Qnr3RdK9cbNEMDF1A/gc?=
 =?us-ascii?Q?+COK5TiPt7Vi8BRIBqxdQ++sgYZFH0jqIwIGyuNDnxcKmEOKuUEmhuZcQqBv?=
 =?us-ascii?Q?HxV/1guZQamc7z0xGyRoiB6ASJKHUoEWoBzDY09nCNBVaIKfXUEYU08tOlJH?=
 =?us-ascii?Q?MEqZiDI1F1Vr8PycvwkV7DPslgPPqnoraZoiuoQty/oJbDQCHZy43SiG+YQQ?=
 =?us-ascii?Q?18DhNH6VKnAEuIcr1D230OxnvvUng1/JgJBN9ZDT2WvTPsrmaTj8el4sQIHG?=
 =?us-ascii?Q?DWBv3dmqoHkaCq2WHwjLR0enfTsF/Ip+KODGvVPN+3BHGEhpNbNrmlJzX+3K?=
 =?us-ascii?Q?rfkX1sV+UQi5EMngWeEhATNTfpghmaZ77lK+bthmsJ7eZfgBUGu4lMtEJt5W?=
 =?us-ascii?Q?H3Pd9/T9ihM6tIDCINSYMkwN3yw1VeYKYBHqf/SFHLLkkAaJ0TyQS3XXfP8D?=
 =?us-ascii?Q?92gdzG0BOhsCr8T/vQxMgayeEqexQiKZbE+sCcgwDTxbo6oh22bShfCrC6hw?=
 =?us-ascii?Q?ht3HAJ6ikM/wbGLy45TIt0k4r/lf9DanS6BsHF0ElFPR3Dl/C7RAquQw2iFn?=
 =?us-ascii?Q?e69OY2Tm2yFltU0i+5QjUUIQArLNg3LZuwvQxqYTwc3Vb+IfPH0dtK3TVcBK?=
 =?us-ascii?Q?hdDMv50tgdwQYpSDl23jRPg3qFBZExY767Q3j8shVVciem+wuMpnGdwOSJ6c?=
 =?us-ascii?Q?0yqTwDy6RUAscmGrQnW9FThXZDs7hH02NOgGsAwk49HceXyeCCa2sKnsD09U?=
 =?us-ascii?Q?PLSDObFxfs7PzUEJw74zszVh1sQh3vvUWMxtLCpdKtFRsHkkP8OZviZ0zd/9?=
 =?us-ascii?Q?QS+6HgDTXww8b5GX4UYcjHeNlChddzyLfkEz/PBNWI9NSxCkY5S5htCwwNRY?=
 =?us-ascii?Q?A2bZzrZxbOgPwmO0Dr7Tt7knhYnGqj/U2L8iZCphRADRoEx3XKbU7KfX3h+W?=
 =?us-ascii?Q?+kV3mcS7qHo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(19092799006)(52116014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3vnPN95r5i0jZ3YC0sGsbD8oHEEj5UhqxEqlmeTiGrwLcSi7DCact+3sZb5h?=
 =?us-ascii?Q?D/bpsm+Y8XZUftI1KD6ZIe3dNtCxGTV8N9KvtAs5/eeK4e53MP2tgG4UkGYL?=
 =?us-ascii?Q?+aLzQUPf3Qd/xkyu+dl/iGWxpHRe7pOAzocI5et85s52MIYFCwARBKvYuDXQ?=
 =?us-ascii?Q?sr5GN8x9HOsb9vX7FzMOyJEhFTOkozvDetQt4QuHe1LJwtgHEuE1VeAnJNNl?=
 =?us-ascii?Q?imh5PnYHhv+v78Wscd/t5yxicXPixEL6iC6w4GBIToCUepQhi9Q7yFpoNfGD?=
 =?us-ascii?Q?qkDzzEbX3pLNtEkSgYAgN9Dsdw9QjDOQOpsGOpc1ei4eCEI+YcDQ6PL57rfH?=
 =?us-ascii?Q?ODAszGL15WOaHYVjf7AJnmHyw5mo8dzrVCASrs/EFFwPgDPUO7BclnBQz0Xp?=
 =?us-ascii?Q?YCHiw0+HJ2iS12IdvonucsfjbPiU/D+plmYa+BD3/2wEaN8ZhKxuqdtbBAbn?=
 =?us-ascii?Q?TWWjTNDIgNaYEZ5+OS7XcR2qE7MCG0ccWrt1ZJSEh0U1Y38Yu8r5J+c/HWNr?=
 =?us-ascii?Q?fLFxDmM5Lrwhwv8fs7CpsC/cyvfnBSqyPjFt9MO1PFru5JkSofE5TYaaCuQl?=
 =?us-ascii?Q?KTziMlU0jiKtlj1NOY4RJfP7CcHVDjvL+kcQcjmLluW0hDaK12CcW0s81v2H?=
 =?us-ascii?Q?+FGfbomBO6gue3DmsAAcBjFNHDyDxfF3+TPvlXZkkWms/7pKAy4tMPzE5qsN?=
 =?us-ascii?Q?dTLV75RPnOyQY2YuDcU+7bxpDUNVW8Ne2PvOJpDR59jdWSaNVZEjkj+40LvW?=
 =?us-ascii?Q?9v6I359NV4bkEyzus1zeOcpGArAlQ1gwFcd+KXOL5uMcvd+sY33kdU2bKFbD?=
 =?us-ascii?Q?JPRG6rdBDj2CmP8NYqK6uaXcor3gBXhG/YmXlpNV5aWWZD+Q/c5g3I/RvUSo?=
 =?us-ascii?Q?937Ke6y5PUd9EpOyKudT0BoKzYY9OXWdecq561+VPajYzWlUKsxJt+cj1Sha?=
 =?us-ascii?Q?iJURC+ONZeZbq1CaR1OPbgEY4n4/gEbO7Ntai5PCsyU+MbyIGFqbiGFJDgcA?=
 =?us-ascii?Q?mIXGGXlHcjp6zXlpaZVjNg4HYIig1/pwBfOTNley0C+6PxfAnksoJvzRu/GV?=
 =?us-ascii?Q?QPPhwm6GtdZvkhevo3+F1OtjhZiGad7dXWQsuq+RfJ8x6jtzrbQHMlMxYrEw?=
 =?us-ascii?Q?snZa6u6kdtJOyuSFwlpldeB5XKvm03ZRPhzZvZ9Qc7Y2S36p9ykaNIHTCxjI?=
 =?us-ascii?Q?6z8tWObW/uOwGbpPOPEbRG0gZOUfSklLzNzJLoz8ASWBpcx0gxMRZMa56zMN?=
 =?us-ascii?Q?M3NXJY7Z1A37xCIVyYVWXzJvlkyKH8tjua7l5j6sM0UHxMrPhW6zkEB0TGq0?=
 =?us-ascii?Q?TTs4+VRftX/ikd4P6CsFwfkniR9VemHk5UyOFJvYDij9p/l1kvCNL0Bpkoea?=
 =?us-ascii?Q?Geiz7vM/WmsPPUTfSgqPCnBGA5JsPY+RPYhe6TAz48J/EnrpwgbeDib1b6fa?=
 =?us-ascii?Q?GV6SVuIUNh1UjTo9SV17XLnRQYFZxAgt8NADTJ38QcYJnAtQObvPn+sGFM5l?=
 =?us-ascii?Q?tCk39kfRytQg/SvZEQcw19o6MVESFQyQZV8kC2z0xAKfM0DUb79geAn6DDf8?=
 =?us-ascii?Q?iGPVfMqxLVTDfsARb/EwU/S/Su88LqMO/sEkj42ZwhdZOm6UdvIfip0JBKWV?=
 =?us-ascii?Q?blqZcqqyYGSqnqNtkjssmpZkizAb0LWbtHUKhMv7bnM1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c99131de-fad8-49e8-291f-08ddeafac51d
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 15:01:32.8160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b5qXV2EG16tpcO0TIj5lDOp/1DWW6VLZVbr65CCj2tfYnK+fvawq8uzHLj0EOx7Z684Qy4LUFoc7XFCvHmqDxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8233

On Wed, Sep 03, 2025 at 03:06:13PM +0200, Marco Felsch wrote:
> Make use of the devm_clk_get_prepared() to cleanup the error handling
> during probe() and to automatically unprepare the clock during remove.
>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/dma/imx-sdma.c | 27 +++++++--------------------
>  1 file changed, 7 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index b6e649fda71dbce12a2106c94887f90d0aaaf600..5a571d3f33158813e0c56484600a49b19a6a72e2 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -2270,26 +2270,18 @@ static int sdma_probe(struct platform_device *pdev)
>  	if (IS_ERR(sdma->regs))
>  		return PTR_ERR(sdma->regs);
>
> -	sdma->clk_ipg = devm_clk_get(dev, "ipg");
> +	sdma->clk_ipg = devm_clk_get_prepared(dev, "ipg");
>  	if (IS_ERR(sdma->clk_ipg))
>  		return PTR_ERR(sdma->clk_ipg);
>
> -	sdma->clk_ahb = devm_clk_get(dev, "ahb");
> +	sdma->clk_ahb = devm_clk_get_prepared(dev, "ahb");
>  	if (IS_ERR(sdma->clk_ahb))
>  		return PTR_ERR(sdma->clk_ahb);
>
> -	ret = clk_prepare(sdma->clk_ipg);
> -	if (ret)
> -		return ret;
> -
> -	ret = clk_prepare(sdma->clk_ahb);
> -	if (ret)
> -		goto err_clk;
> -
>  	ret = devm_request_irq(dev, irq, sdma_int_handler, 0,
>  			       dev_name(dev), sdma);
>  	if (ret)
> -		goto err_irq;
> +		return ret;
>
>  	sdma->irq = irq;
>
> @@ -2330,11 +2322,11 @@ static int sdma_probe(struct platform_device *pdev)
>
>  	ret = sdma_init(sdma);
>  	if (ret)
> -		goto err_irq;
> +		return ret;
>
>  	ret = sdma_event_remap(sdma);
>  	if (ret)
> -		goto err_irq;
> +		return ret;
>
>  	if (sdma->drvdata->script_addrs)
>  		sdma_add_scripts(sdma, sdma->drvdata->script_addrs);
> @@ -2363,7 +2355,7 @@ static int sdma_probe(struct platform_device *pdev)
>  	ret = dma_async_device_register(&sdma->dma_device);
>  	if (ret) {
>  		dev_err(dev, "unable to register\n");
> -		goto err_irq;
> +		return ret;
>  	}
>
>  	ret = of_dma_controller_register(np, sdma_xlate, sdma);
> @@ -2399,10 +2391,7 @@ static int sdma_probe(struct platform_device *pdev)
>
>  err_register:
>  	dma_async_device_unregister(&sdma->dma_device);
> -err_irq:
> -	clk_unprepare(sdma->clk_ahb);
> -err_clk:
> -	clk_unprepare(sdma->clk_ipg);
> +
>  	return ret;
>  }
>
> @@ -2413,8 +2402,6 @@ static void sdma_remove(struct platform_device *pdev)
>
>  	devm_free_irq(&pdev->dev, sdma->irq, sdma);
>  	dma_async_device_unregister(&sdma->dma_device);
> -	clk_unprepare(sdma->clk_ahb);
> -	clk_unprepare(sdma->clk_ipg);
>  	/* Kill the tasklet */
>  	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
>  		struct sdma_channel *sdmac = &sdma->channel[i];
>
> --
> 2.47.2
>

