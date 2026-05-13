Return-Path: <dmaengine+bounces-10422-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILIRK1GRBGoVLgIAu9opvQ
	(envelope-from <dmaengine+bounces-10422-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 16:57:21 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EB4535913
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 16:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6779C3003716
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 14:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5B338D3F7;
	Wed, 13 May 2026 14:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CTgjE24V"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011022.outbound.protection.outlook.com [40.107.130.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD5938758F;
	Wed, 13 May 2026 14:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778683932; cv=fail; b=G0/mSvyCczQRJV5qbeJ3YVBSiRam479qdooPfssz2CAUjlDKGDwo18jlu17gkNq9mEzshGpjRVUjUAf9KhfVQn9U/baQ8yDlhAM7WlzPuQqwXCIMfIm6XagV23zhyPOkMX8pFPHREFl/KwpTWmjP3V4NGkzwcarTvi2XMkHP6h0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778683932; c=relaxed/simple;
	bh=nNnXdkYFPTZkrrBrMQ2TlFR6u1b/XS4eNuWcWSMTWRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pwpdsewaJR4sMoaOCYWcvjuAUlqdg6OfqTYuPemwiEZp7ub39VR9hAAQvOD3sIrtq77P50YrQ99IOtLbKRKtcP5rUN1xY4C6eZqa+n2+bFbbk6WPLoD3Bwv2VBKrgiOwBznfR4QmvE+9i61ELl09xjvgn/cnUiL/TOwNGOFdXg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CTgjE24V; arc=fail smtp.client-ip=40.107.130.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SXuUXeLUncTZG2lizupNaRrkuZDcZL989atK8YrTMsN0qpwScXMd63mc2ogHsMt3Pi3f9XC8/QXBmOgeafpD5hQMBrFpgGh6IboJvkW1ejEkFKO2nyU7QslIkSsJNcKLP7zy8dQu58yntM85FWwtzwA7tALWv8GBhfZXzsihNlXHD6tredOKrNPcwKPT6pBATGPH0501l10r46Gdvi3g+f/fzNUqMDFaTnmYQTv3mcCxRtrAQjOe1NXrL/FbFo6EKEPFhrX8ArUFl6Q8cOR84tbk83t7M1c4+CN/UgeyZ22EeC4c2QjPjAQybnLOWx9qSP9gnISyi+CYqqPQ2YE9qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vyrc19Wj0gJI3X5iioPixRLY5aEpfkTxUsSlewwftk=;
 b=dw1FZzu9OZcBJIJt4THCq+PgzFI2RKYQfEHUfZKY8VxSjLiPcqZy6Qm56RTqvMNPwaDmCJVhkrRED8xktVIzqVi615adgrxad52eALqCYCl9ZD/fqAroSmEA2IbTManPHq2eySDfdBmW1Df0q69uBrlkD4Hl0G1DKa3TdQgRCi+hdM3+w6GZVF0b7tKX9YrmXZ1xg8dHt5IDopZYXe2RbKGNx1RpBj6GIozQxlOd6uAuXDerwsAnKKG8R02eaKZdVLKlgdg09pbZ7bL+IPR+9Zi/LZ74Ldarz/KCEaUkcCtkqgjYPp4Bx8RAJvsI5QeIsj2r7mbCD+cmJpAtl9uoYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vyrc19Wj0gJI3X5iioPixRLY5aEpfkTxUsSlewwftk=;
 b=CTgjE24VcVtPFrY9IJA0z4bttPSWk40ibtdwzcLNRqKiOTJRWAAEP6pv+uiFI1aFr1qQzH87zQrfMPTAMezR8wpXe1PF66iy3J7mZjtWM8wqs957vR8HrMlbMG3C79ap5bJifXQiQmMPhzPYgB+L5ewJloEC9EckikKeqOPrVahC49eq3pQwT/h2XTmUd11M4wYGKn9Wy036g3hA5HFCRstnjnpqi4ZCJTuMH+CQd5WPA44J1BCVM1yvnTOwB+C8uw2wT31WzdQ4pZwcFs+txXO76BSe8O56v4dbuuqdblpGxiMnAMHOuANeZhMo1bK4moqtAcQ2+k/3Pc9U+FWZtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU0PR04MB9657.eurprd04.prod.outlook.com (2603:10a6:10:31c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 14:52:05 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 14:52:04 +0000
Date: Wed, 13 May 2026 10:51:57 -0400
From: Frank Li <Frank.li@nxp.com>
To: Joy Zou <joy.zou@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	imx@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/4] dmaengine: fsl-edma: use
 devm_clk_get_optional_enabled() for channel clock
Message-ID: <agSQDYmwmGjugzJF@lizhi-Precision-Tower-5810>
References: <20260513-b4-b4-edma-runtime-opt-v5-0-1e595bfb8423@nxp.com>
 <20260513-b4-b4-edma-runtime-opt-v5-1-1e595bfb8423@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513-b4-b4-edma-runtime-opt-v5-1-1e595bfb8423@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0358.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::33) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU0PR04MB9657:EE_
X-MS-Office365-Filtering-Correlation-Id: df53e86f-0f45-4d3b-49e4-08deb0ff32a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|19092799006|18002099003|56012099003|22082099003|11063799003|38350700014;
X-Microsoft-Antispam-Message-Info:
	llz1T9+n2RS0JT4focn5mg+gh7NdJejEtqbx/5oIw+QCw4z6oENQBmYdufLCRj+BavKGeBR0hPeW3xY1cszbItEvQNVWnkUvqRboixUKDGfOX3OppOTH1nw9aBKs7mqdY81LpDKMtnVCKmM2MaE2oI5l4VFYxK1ttrIacahzrouN6ykuyuuxeiRC89PoVpCXPQAplhkpbkjhojmYt/IFtkqKHtTj+xQXOXiPOCFtOpd/txB1tzhXhVdCdnh2cknfVHIXDIxP2/FU9tulCRZFe/NoaK/Dzx0tg9iUCO/ufgAI0GuwXBxzWhQhhYfA+0P04NqB+cX23rdH31gNX93t1HW8ryRGQYg4pTLAIXabtVemZvYM/pBVxLwfry6Epj2HlRuVfbDzz9qPvzF3jqeWbhcdWExkuZzYVIfq69867cD2/KqaWfilPT44M9bOVNH0vdhe6c0Q4ve4e+9sekdnpnh0NAEOOFPVUffX+Hk9UVUNsO67FpMoBZ+xilVYRRvemBnWtuUK1+PPbbjSNJZHW7HuZAcXD0U2pfUTeUQy84ZmkeCMVkT84Hc7EtDHiKBRhXtDe623RCxXyjltLYDW3cH+4l/GV2KvKsseYBq/5ACpBNQN6AWrnOwFRdA+N8p9uaQAAA6pqzqUtudNX3/JqzkA1377uiQRol/WJsCSNgcccpbmgTBHOTON4Ws6OmI7U2ynmJ8/8NC0+2jOxRi5yBKKywc/AmOEEMUV5Kk+oAAIgmoaxGn79htMXKdI0M2T
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(19092799006)(18002099003)(56012099003)(22082099003)(11063799003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?64ffAU6THPuw3hGDRA90QkSme1qSCp+2n45ZMD3+D7kftIMC86gApQWJFuq+?=
 =?us-ascii?Q?aMJTmdMNbIayOgl0St74bcV80MzPI/CFUWJf1E2z+hDzsqZ8NQmP1vxmvxRl?=
 =?us-ascii?Q?fRCGZIBcxxO/j4i4LYixQnPe3esTMr8obpe9od8O5kZOOd9Oy6vc3obf4wXg?=
 =?us-ascii?Q?jvz2MZzg1yaQ8wXFDwoggnjvwldmewmkKYC/c4y5IFBrmqN0ZKOFeRxJN+vl?=
 =?us-ascii?Q?N0fPGq8EIh4yYrHy0tyuOPN8lSdP2B0Y+Dx3cZRqkovGtr8oRGaZmSYKq7mD?=
 =?us-ascii?Q?nQIJxhA04alfav7Ekf+KcJdGzgzwr3tbjVgWAtFUPI7Bli7p6GHQXZUUiM0s?=
 =?us-ascii?Q?yRQN4Ee8sRXoKKxp747BDd1ORYAB0FziuWmdY2h1dhL0KweRGH1+uZPcpzc7?=
 =?us-ascii?Q?VJrSJq3CiVzFRmVpHAzQF5PI+JiX7dP1UckkVRFWpS3zHH3namTOZAnFMDA5?=
 =?us-ascii?Q?5K8KQIbInGh2UirETI9MtFS+XNEur49ylHy0RyIc3Q/ZfLoou9DAuhxiJLeT?=
 =?us-ascii?Q?L4NgrTQ8XNpoufAmFhapiuPkx3AH9Uxy0zpgKR4Dvk74GgjZUvVUvzVc8cF7?=
 =?us-ascii?Q?ZLTohCl/HmMUFdKNUQZCtiYX9ReiTGsWhTtIiAZQ4nYJm2v9/K3QE5JCrnel?=
 =?us-ascii?Q?0PSdIVIBzgzcTkakKUdKfUmtiXXyMPTJOKujyDkZyticu7vOq7aw0AMJaRmx?=
 =?us-ascii?Q?AaEO6wzRroklS+xh/MKVboSWy40aw/u5GEpd6FmF83eF1Yu10TKEOHb0rlEY?=
 =?us-ascii?Q?WQxwwhnHG9cF/d2BPuS75vk2V/zLhbjaI2bv9YlHwgSnqfv/aIF2zZmL0mrJ?=
 =?us-ascii?Q?Ogm4BoEXHFrnOFVTrWESYgGdHyHzAVHObto+viO4IV/5QCcsUIhoIrEnXSDq?=
 =?us-ascii?Q?+unj/RV+6H9MjhBB2dxhszArbQLKAR3v7V4k8+0X3gZREM8KfhY3WspjJv5D?=
 =?us-ascii?Q?X/1WvOfCVQSisZV9LBu3Laf1HhRfccU0GZKlOVEuei9yj3qMR7IKdDI4NnHf?=
 =?us-ascii?Q?ByIWW0RLM/lhNbYL1KA0UYmTsBbUjd1YSlMzhZAut2uqOS7qTZ2mMSNTUM1i?=
 =?us-ascii?Q?YyiYu50aUtiDWQ3kSfJq/86DHlV0EMejGFg7dAph9f6Fh/d4t6I7SEZ4Pz5n?=
 =?us-ascii?Q?t5F2ih4Wtxnl+CHkxj4CN3SZZDFXL4UYTPLM33RqPBIzc+E3R9uyPzIve1c0?=
 =?us-ascii?Q?5JNysJ94bPEijm/CxQtWDQS1mLNJsmoitMIhw+U5t9wp2RUS599NpQNbAC3T?=
 =?us-ascii?Q?oqaTiIuK6NI8Yp8RudTWNaPytGAM1BpMR8xdAzuF4fXLvS7VUQ7nOKqCuU1x?=
 =?us-ascii?Q?Yf2VXodONJaywnBDQaxn65NjR+qwFNLXlQn5nkq+2mKWu7+VJYcX8ZzFTs3l?=
 =?us-ascii?Q?5M9KZ1RVv4h+ebVoEMRoLB2hkbpcOmc3r62zzgBT/VXLJRdWfVYqAci7phXT?=
 =?us-ascii?Q?ZVuvoiZ3a50K38KaSfl9hDbPKWiRp4UGSins9NoTAfo3zJSPO9XmZASNh2A2?=
 =?us-ascii?Q?jFHrEBgW2niKlH0pzGEQsSRGLrsfGdPu+4KikNKwrBxzbF8Vh/1AgFA1j1qE?=
 =?us-ascii?Q?UtvvfroX3NRs2d79OgkAoG7oXRvb8N6LaBygFGs1xKSvgHqA9Iht49wxUpFa?=
 =?us-ascii?Q?ZWD9mPIXp+SzTw2MdZ9OkwJ0nVah2kVyisiBOe/feoJ30Qq6swR8xOTUwpVR?=
 =?us-ascii?Q?sWD0LgWHn4TsCON+LKFXEXl+WkEMg+HEPT1EvV7sGsgbM/xqcC8xXMniLcwf?=
 =?us-ascii?Q?6OniyhzLUA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df53e86f-0f45-4d3b-49e4-08deb0ff32a3
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:52:04.7379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V/+M8jYF+FEGpatjtJe9rFsnzioZVbKkGBJElhMGbfb+UPuoGZQ/DyGFaqq8+YrWYw3oj1X9w6FeWfuDf17Daw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9657
X-Rspamd-Queue-Id: A8EB4535913
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10422-lists,dmaengine=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 07:23:47PM +0800, Joy Zou wrote:
> The channel clock is optional and not present on all platforms. Replace
> devm_clk_get_enabled() with devm_clk_get_optional_enabled() and remove
> FSL_EDMA_DRV_HAS_CHCLK flag to simplify clock handling.
>
> Prepare to add channel runtime pm support.
>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/fsl-edma-common.c |  4 +---
>  drivers/dma/fsl-edma-common.h |  1 -
>  drivers/dma/fsl-edma-main.c   | 18 ++++++------------
>  3 files changed, 7 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> index bb7531c456dfa0a8812883a2cf3e9e2e23b0f55e..e1ca25ff228dbe392bb800f6ecac5a85ca326bf1 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -844,9 +844,7 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
>  	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
>  	int ret = 0;
>
> -	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_CHCLK)
> -		clk_prepare_enable(fsl_chan->clk);
> -
> +	clk_prepare_enable(fsl_chan->clk);
>  	fsl_chan->tcd_pool = dma_pool_create("tcd_pool", chan->device->dev,
>  				fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_TCD64 ?
>  				sizeof(struct fsl_edma_hw_tcd64) : sizeof(struct fsl_edma_hw_tcd),
> diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
> index 205a96489094805aa728b72a51ae101cd88fa003..f4354b586746d64faf375cc9ce04e15a7b6d86ab 100644
> --- a/drivers/dma/fsl-edma-common.h
> +++ b/drivers/dma/fsl-edma-common.h
> @@ -210,7 +210,6 @@ struct fsl_edma_desc {
>  #define FSL_EDMA_DRV_WRAP_IO		BIT(3)
>  #define FSL_EDMA_DRV_EDMA64		BIT(4)
>  #define FSL_EDMA_DRV_HAS_PD		BIT(5)
> -#define FSL_EDMA_DRV_HAS_CHCLK		BIT(6)
>  #define FSL_EDMA_DRV_HAS_CHMUX		BIT(7)
>  #define FSL_EDMA_DRV_MEM_REMOTE		BIT(8)
>  /* control and status register is in tcd address space, edma3 reg layout */
> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index 36155ab1602a9b264df73dbde3ec2b3aa6cc27c0..87f575d6ccafff455d47f8c794a503abf97e2af1 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -567,8 +567,7 @@ static struct fsl_edma_drvdata imx8qm_data = {
>  };
>
>  static struct fsl_edma_drvdata imx8ulp_data = {
> -	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_HAS_CHCLK | FSL_EDMA_DRV_HAS_DMACLK |
> -		 FSL_EDMA_DRV_EDMA3,
> +	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_EDMA3,
>  	.chreg_space_sz = 0x10000,
>  	.chreg_off = 0x10000,
>  	.mux_off = 0x10000 + offsetof(struct fsl_edma3_ch_reg, ch_mux),
> @@ -808,22 +807,17 @@ static int fsl_edma_probe(struct platform_device *pdev)
>  		fsl_chan->tcd = fsl_edma->membase
>  				+ i * drvdata->chreg_space_sz + drvdata->chreg_off + len;
>  		fsl_chan->mux_addr = fsl_edma->membase + drvdata->mux_off + i * drvdata->mux_skip;
> +		snprintf(clk_name, sizeof(clk_name), "ch%02d", i);
> +		fsl_chan->clk = devm_clk_get_optional_enabled(&pdev->dev, (const char *)clk_name);
>
> -		if (drvdata->flags & FSL_EDMA_DRV_HAS_CHCLK) {
> -			snprintf(clk_name, sizeof(clk_name), "ch%02d", i);
> -			fsl_chan->clk = devm_clk_get_enabled(&pdev->dev,
> -							     (const char *)clk_name);
> -
> -			if (IS_ERR(fsl_chan->clk))
> -				return PTR_ERR(fsl_chan->clk);
> -		}
> +		if (IS_ERR(fsl_chan->clk))
> +			return PTR_ERR(fsl_chan->clk);
>  		fsl_chan->pdev = pdev;
>  		vchan_init(&fsl_chan->vchan, &fsl_edma->dma_dev);
>
>  		edma_write_tcdreg(fsl_chan, cpu_to_le32(0), csr);
>  		fsl_edma_chan_mux(fsl_chan, 0, false);
> -		if (fsl_chan->edma->drvdata->flags & FSL_EDMA_DRV_HAS_CHCLK)
> -			clk_disable_unprepare(fsl_chan->clk);
> +		clk_disable_unprepare(fsl_chan->clk);
>  	}
>
>  	ret = fsl_edma->drvdata->setup_irq(pdev, fsl_edma);
>
> --
> 2.37.1
>

