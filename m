Return-Path: <dmaengine+bounces-9191-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FD4MLL8pWkOIwAAu9opvQ
	(envelope-from <dmaengine+bounces-9191-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 22:10:10 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 297701E1E63
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 22:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E7B032A05FD
	for <lists+dmaengine@lfdr.de>; Mon,  2 Mar 2026 20:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1632748C8D2;
	Mon,  2 Mar 2026 20:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LwQjl4ux"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013002.outbound.protection.outlook.com [40.107.159.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9533347DD48;
	Mon,  2 Mar 2026 20:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772483529; cv=fail; b=rk4htH8ydYEuJetKLb9DhZISv9ieNuxZGe9+G8RlU31zX/wlVGvHvjujWMeGiSCzXLSj75K6Fi70/PQ38AQrAbImqW8sidLQC9LzXTb8P/FBrRXzH9rqVW9NX3bNg9Q6Ftiihs+FfNgfx0GteLDpEhV7GvbLOEuqnMLnT2zYgV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772483529; c=relaxed/simple;
	bh=RcUNp+iX+BOvTb7q62Hzd8lmnbqQJx6Pp8CEqS9phdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sk0KrUYVHJnuBJZCl2O3qouuISr//eVvdP261FnALroMj9U94veAOrTOGjpFAfn54WUCsuuWkY/BcqhhRi9OQkDkFLSc8oizp9c/8sgXmmGHrDqsv7uWW9iLyRSFKUgoPycoqvYIdqnhF4oJNbVFamk+xjI7OP5Ca/2YSOGTvus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LwQjl4ux; arc=fail smtp.client-ip=40.107.159.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S6eU23HIgHpPRzR7sVQEaS41LGWM/f2irBVsyEmbge4DoAYfeyknlA3uXsC0HifTU8JCFvosj7VFlEpoqCDuq75L1qYbPafQ95k3kshrUgLSmfQWQFgG1UAhx5KIFJb6nWbQA2MUUryWQSBkBPuM4nNKIM+wwe9ompol8Yd129pH5SjKjkqpu1hHFuRu6C24xfaqp1Cg0KlgZE3doXRgGWKkAZzrTpq56FOmySjWKvKnVK+3B/88AiVdOor8ljVCDNmoJYKIpMBjZbO/5FrkgFln3OC85DtvVBWd2LpuaEcQglotvOt4vqkMYGk74v4FAQbcMU5Q4Cr/BIXVUos2Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2GRgNyS3Dh+1bU8Id1UQ+rVIhA7V8sWy+MjRZ/OJJkc=;
 b=fBm48d65TzQRAnRHvjwFw+GZN/2JxfoPjqmNKaQQTyw3hNrc1G74ltHolYYR09+9k4UBM+HyDwWA9Lrx/S57ItHYrhoLOqWDYMqbkP8ywQoGwQlA7dMpYNVtWiG+/OzmEXpOPMM6BwEtkQJ2u64+33CMZLVxZ9NQbhbn8l4QhxLtnUJ4eERH2mAeSADKLGeH4lQI7n8C5U3YDCMFWVybMCOdeULmHm4AEtDqQSpeMdqZibC0DtwO+8MyIPIBINZyNDD34Ni16M9YclM5wGpnQT/l/Pd3b4aFm291yCr4W5n8lqCNdOYiXOIM4yZ57+9w3wv78dsHkgx93bdM9jGnJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GRgNyS3Dh+1bU8Id1UQ+rVIhA7V8sWy+MjRZ/OJJkc=;
 b=LwQjl4uxb9CZAflfRh41vy+D7tfV40jNGiobSxFBNIcn7uTncQAJUEgVm8GgKBxm4ZMnzVMeSCTJfrMNYF6v/dTqfe/hOq4hMxzBOajAbfkxDgCLy8+wsHJuh9ht1IN/QsZhV2mtg1ujPf/PPQdDF7WRnu0BXZ8sMxHNNgBQDCF4E13G5BD31W0j+pVhrlkytuY9rr9dWuuWDb1xHJFdou7OQnK37fbJUKpOYk7ai/ScUg9zb3hVsrgi7pw0GCianS4hrjCAbfPkGn5XM2iPhTwedLmCM6CHGOycsg3lpSoWEoxncH9E73jNPZsGshLY1PSALAScxBW5OkRfIZ8PQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM8PR04MB7905.eurprd04.prod.outlook.com (2603:10a6:20b:235::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 20:32:03 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 20:32:03 +0000
Date: Mon, 2 Mar 2026 15:31:56 -0500
From: Frank Li <Frank.li@nxp.com>
To: Akhil R <akhilrajeev@nvidia.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/9] dmaengine: tegra: Make reset control optional
Message-ID: <aaXzvPYFF4euUTEY@lizhi-Precision-Tower-5810>
References: <20260302123239.68441-1-akhilrajeev@nvidia.com>
 <20260302123239.68441-4-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302123239.68441-4-akhilrajeev@nvidia.com>
X-ClientProxiedBy: PH5P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::12) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM8PR04MB7905:EE_
X-MS-Office365-Filtering-Correlation-Id: f9f77c41-9e43-4fe5-2f35-08de789ac3a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|19092799006|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	mYwDjKs44K3xrTB3oPRk6wOyjSXSZxRf+O1Hm85lk/JNPfoaIGoST1MNqshTn55Q5rfYOIAnPIs80EtPr9UWvf210ya0gdtChka8U9w7euDrD4QrKZ/B1rKmcByEdSSkHRAg/GTEq9D+R/ECPWCpVM3Nfut0g7jcmmhu9upjoVGrP/ZqKUesfl56SnqhZE+s7Ud0SH5EJznOpK0Pw0H6DD41Sh3kGM0XknTepavpel8OGF1YfJrIyC/UHaO641SgJq0hv+/nTpYq32jgFUhvoNw1vD8KMwEn+Yq6YNVJfxv/l3/ml+5Gmjj91pCjRdlwdZc4KHdnW2VQaA2v8qPa+M/YpbvmHVd320i8FTaluoM/3ZYYcB6MjP6hCOAiVCb1Rjn46F6nq1+sJh5vrSDrLqO5uATG8WT58vvr4lBKcAQVwheWM9UnSq9m3GWEABGNOjjJqMB+yyqbPBMwrWPeGfxjdFKET0Xky9feCINe2xMPlKOTDbcPln5Yk0h6uM2ml0i7QQriL6H8UjowFKx2HpOrt7kRxhM4CSgkqPDPUQGyvmg8s9DL/jxFq4iHtNen02fFJr5g19KHQMwEnctzUDWwSDqbAmm6c20HxlKhf1cK+r5KNW3+kXRlXTRIQNZPEC3K0DWy4DIfYI8eYhNlUQdIeiNL3n7r98fJTrKNRQ1FxTfYMxun6KH6mvkU12WeTunHVlPj+uklAWTTXIoeIf5nLJPNiWouDqlWn8LkrZN1hf4726Es+r22vMt2WBNKqN7xKcGd+MjjAaHv6IDqfKX0GheQukOTBFmbCZMY0i4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DdDDClA7ItTuOuJ+ETy8GkUphobvm93CXamR9YzFQmDo/KtEvDj4+Ssu1fjo?=
 =?us-ascii?Q?rhJmkV+S0HRvESEyMiAOnnzc/z16bu0NlumiLQI7iWN85IGPqkVetnd+Q7To?=
 =?us-ascii?Q?FQlb8YpPwQHM7dmgYT2nrhsIH9ues8rgnDU9rDYLkKSBXBpWZLdX4AUj4j9W?=
 =?us-ascii?Q?I91H56+AtXo3/eIoMpoLlfGhOTy0pf4rSOow88ySu7UKtmGx7RtG41shyXNq?=
 =?us-ascii?Q?31MZyooExx9Ojj+JznFe+s3Nj3rFx1lWeyp9A/x4Tt6WEaT6CXHtH8RKf2vU?=
 =?us-ascii?Q?mEze9ozMVcvuqkfPimdMpDeUdkA3ZpTU3kpDXSNDabcS6nrJVSRrUrI/AX1P?=
 =?us-ascii?Q?/jDSQQqegOkuxvav1+CA3Mx7twc0NzH1QT7B99SUHORzhtZVVQdwgZ5IY4bh?=
 =?us-ascii?Q?S0d/r5BLAiMkKz/ADMcpHZvsp89jxG4yqPAy5S/QpxlHkhqAot/rw1C8Eamc?=
 =?us-ascii?Q?uxkNFszPYvcRSVSMx/oZLiXJHHHKGZ1r+3uOhOhYdFRzVT6CjVCP6Jg0wezB?=
 =?us-ascii?Q?pTKzqqMwnncvi4v5xDYsG2WgbebmoYsv0m1ksRObB3XTGespWykOsGhXPzO3?=
 =?us-ascii?Q?jTd70fjdLX60Up4m68pQoCEmZbgs50zVJWO13aHo35U2QbW/8t/r7erZBb2e?=
 =?us-ascii?Q?YB/H0wPxJMRf4spMHy9Ol34W8idiPdNpTNLRLww0OOrmQ/K+S+/Pr4lMCRiF?=
 =?us-ascii?Q?E1GgFU2X2QtC40nL84SxZDaI8zkWpq+boxHrr5D+1cocw0R5Efg/aGEARfqm?=
 =?us-ascii?Q?oYyoanR2JJaE5J89wySZ7xRS0ML5nMyFBpjb0rOyd9EqG+LX8GpsKQ/km7e2?=
 =?us-ascii?Q?gdHitCMI1vV5e49rjqIrMlS11aUJTEGHA0XCrWXnVyVMPamob8El9zMLiuYk?=
 =?us-ascii?Q?r2Tyk+7d6MSMFbfWAaSQZ6Bu0Wlz9b24MMX4K78JIQ2NFBUd7a0NJTk1KSnO?=
 =?us-ascii?Q?+yb5Q2Sgmp+B3hCE7Nn3NNR2G0oFcTtD1+kB5U71/Hg2CC2JKIcPR0pmFMj+?=
 =?us-ascii?Q?I48c0kdWA8aYXkiQFx3l2oey91C5OQUr/KdlQ5OMr3g/+VuDcOyYawx7t1Uz?=
 =?us-ascii?Q?p9fKky1dOvTY72+FnYTY7XVyZdluNFAdnco/e1vb1CKt013wrIPxyLEDXxI9?=
 =?us-ascii?Q?HUhb8Cedd9gL4iK3kQCzgCn9fBUPjuZlW330ZTJwsNhialEF6s99VUXZjP/b?=
 =?us-ascii?Q?oJ0Io0sWCJwtFxppu2+F1Wvq+ysLmH+p6GVXs+oI2wfIAyN+9W9+m6i5IyOh?=
 =?us-ascii?Q?1Jni97+w6KaXuCn4nBedndz/ZMlCFItcbud9Vut7zZtKQ33WFtToCB0Q7D7T?=
 =?us-ascii?Q?oAA1YyXBZIBEJKuBHKOrikloBlc+f1AtQ/piTlpUQJqGpVzd0qhGu+wyxLmw?=
 =?us-ascii?Q?ExyonU0YFbwAdUohaH5r2+J6Ljf87kXMkMIpZ2r7AMrFypUeKpBI3FxInkNf?=
 =?us-ascii?Q?EZ9LbPh9WLbxFZUy0EEiDYpyIzR1nElCr88z3y+/pELWksUDWSlPG7mlO/tw?=
 =?us-ascii?Q?YEqKnx7xfrzmNU/ufHK3lCmyq91lLow67JCs//exr8yllf6pbxzESj6oQTyF?=
 =?us-ascii?Q?2vKmFTwcyknj8kfqkUzqleremFwIHzCJq2kJkz5xbbC611iOJwFd8fyu8Ikr?=
 =?us-ascii?Q?kFL6TODVe0by3ugvAcqXNnskwluiu/3thKJCnskh8XrOYpznIZPUULSivyw8?=
 =?us-ascii?Q?S70tA9xFczkRFxsUMH3BNYoEFDUH1d9Q02akLc/EAvlEjlvN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f77c41-9e43-4fe5-2f35-08de789ac3a1
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 20:32:03.6890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VW2HYHsHc2CnbasK/hlgDToknsyMIedSI1/38ra3wM26XFxWipKcdFg2/K+9QpEMIVyIddjy3xZZzFjq8oT9aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7905
X-Rspamd-Queue-Id: 297701E1E63
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9191-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 06:02:33PM +0530, Akhil R wrote:
> In Tegra264, reset is not available for the driver to control as
> this is handled by the boot firmware. Hence make the reset control
> optional and update the error message to reflect the correct error.
>
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/dma/tegra186-gpc-dma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
> index 4d6fe0efa76e..09a1717aa808 100644
> --- a/drivers/dma/tegra186-gpc-dma.c
> +++ b/drivers/dma/tegra186-gpc-dma.c
> @@ -1382,10 +1382,10 @@ static int tegra_dma_probe(struct platform_device *pdev)
>  	if (IS_ERR(tdma->base_addr))
>  		return PTR_ERR(tdma->base_addr);
>
> -	tdma->rst = devm_reset_control_get_exclusive(&pdev->dev, "gpcdma");
> +	tdma->rst = devm_reset_control_get_optional_exclusive(&pdev->dev, "gpcdma");
>  	if (IS_ERR(tdma->rst)) {
>  		return dev_err_probe(&pdev->dev, PTR_ERR(tdma->rst),
> -			      "Missing controller reset\n");
> +			      "Failed to get controller reset\n");
>  	}
>  	reset_control_reset(tdma->rst);
>
> --
> 2.50.1
>

