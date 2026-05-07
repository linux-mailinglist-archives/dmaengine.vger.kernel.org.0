Return-Path: <dmaengine+bounces-10273-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHrwKlbb/Gl9UgAAu9opvQ
	(envelope-from <dmaengine+bounces-10273-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 20:35:02 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EFB4ED7FA
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 20:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 212C1300B749
	for <lists+dmaengine@lfdr.de>; Thu,  7 May 2026 18:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6E82F49FD;
	Thu,  7 May 2026 18:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lrALfKFt"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013012.outbound.protection.outlook.com [40.107.162.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62592BCF4C;
	Thu,  7 May 2026 18:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778178882; cv=fail; b=Pis13zF1DpCMu0x+hY2u4ywOZM9L6GhOLabtEyIjD2nLtpRgZVNPiq6FZc64JuLRqLp/xm3hf3MSVAPvtamfscNuonluhsXSFnI6RToixanbzhLTmOaHCqT9cuQPgR/oY/+GVJhxEfZyU1WhthyJSj7+Co9azc4FaZyG8RcPRi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778178882; c=relaxed/simple;
	bh=k1gztkdhwPdtYu7FIMBPMPutI2xFpAoWKidMqwKsnn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FSv5AxdaXWDTIfFtg49X6Eh5uVSC5p48+zntmcUpLgU14yams3O5QeG7YWiHtx2OnXhFba1bsKfHSBqeoRKH9jG+zFmOlrnkPTy5cxeHmcnDR/T08dWJ6ewhc56FQR2w5qadkhXTF8X4AdfMiW+CZRw97kcPbBMLz3T7R1nBVYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lrALfKFt reason="signature verification failed"; arc=fail smtp.client-ip=40.107.162.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nlzX6KdzonZzkvANmxFp6nMtq3CnNXlgBqIMo+MkUfUalmZosCxMTVqcSQ7d6yDEXNvc6vUEYjHHM+mTeskYBjVPVYyBcjY/ZV/7vylBXGGk3ZXyShD20SgYycl1MnhPFH8FXWFRUm8wonrlBQyq4FEhu2ek+lkt8+z2RS1TRMgETNoUBOYdF3rVQBJZR0SmhnSb90N2rd+ppBKOqa8x/QUBByanL3fETLHjXhxTiX7t0hUfX4FkctMsL7lR7k+/Wkxoqtz6ZXn9HLn8cvMhKF8CBtzXI/yKPuVNC4oWpdJsuBLGjiEgQ/Rsdgi7LQHQBmoHPDN+DzYANf3SLRJxbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJMnUNWNSEMoxLQZGyEtrz+tjTpXK0WYrJ03uHced7E=;
 b=ZsfKwStJEc9Sjg6s497TDVgv5cfW2imeFUl9yOsNNU/hYn+pHlaHmqHFGDRC1XNhKq1R+CFOmtqPNS1Jx78hhYztHwsSObPdms/kiR2vTDX7P05RNeUqtAFHQRlZHgfdirBP3kmYue9KqqW3Y8XPqXfvqmKNbw2XjSYNw54nUoPHNBm9VJ7f80CXIcnGTH8TNDjFGiCM19rf6nEQER/C+X/3xbLGjLMmrvOzIJVJi5ChUXThm6H/DPAFVJyCxEZnLo75W1s0DOs04IWKYmlEpO/at425AUequpcKfqxrZ1e9ramDgO+gIWA8dV2n+g5bd9kpXD85pOBCQCNnyjrIGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJMnUNWNSEMoxLQZGyEtrz+tjTpXK0WYrJ03uHced7E=;
 b=lrALfKFtHHcDxq4lWTXWjGbTw8nqjgdhtSuJL/ClXsrsJoogKQwb9SAjn9kJ/cR0nNmZdZ9ItcRUJ638mIH3uGtkvSHl+sOP8K/xTA+bnLohk4AwPJ7HBa716XB02rKoARXNy3cgAfbzBoGoivGuC7oI2xSeLhmCGX+k1oFadGL6SBwGzTpWcne0WyjyHTKnH6Twvv3twvtFZxktlQJxHpeAjyVL9NXbxlEAJbce3tLFlDEPSNVuROgVs8mPjy3cjfdVFEso2V1JORnSH+/bqQDH0lrLpp/o/JzRjE4yupp6V2lsjMFFMd+G6dch3Ne+0ezvo1sbJSntnff4Nfk1ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AMBPR04MB12614.eurprd04.prod.outlook.com (2603:10a6:20b:778::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Thu, 7 May
 2026 18:34:38 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9891.016; Thu, 7 May 2026
 18:34:38 +0000
Date: Thu, 7 May 2026 14:34:32 -0400
From: Frank Li <Frank.li@nxp.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>
Subject: Re: [PATCH v4 3/4] dmaengine: dma-axi-dmac: Drop struct clk from
 main struct
Message-ID: <afzbOPmuav2K9gE1@lizhi-Precision-Tower-5810>
References: <20260424-dma-dmac-handle-vunmap-v4-0-90f43412fdc0@analog.com>
 <20260424-dma-dmac-handle-vunmap-v4-3-90f43412fdc0@analog.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260424-dma-dmac-handle-vunmap-v4-3-90f43412fdc0@analog.com>
X-ClientProxiedBy: SA1P222CA0116.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::20) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AMBPR04MB12614:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b129473-c287-4d3a-eee7-08deac674b4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|19092799006|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	Zqhqz/ZXFGKBI1lyBYLdXC833iJQXZlD1JIOlmyMUBXpiNWY/AzDTkxSly4Sv63KrBOcGXU4Raf4nsf+NLIZVsHbAXA9K1gAM5j3gI0UCXfGycvYtR7l0SpAXsGhWDOQlL3mzstdpPYND0CIaY1NlkMglESEDcl5qdNWWYZlLF/pcGiPQCdDpULO8TZD5CcZKiD2L5PgWPYaJJCVBD75rwK//rhBlG4VerYnNOF8Q5gTeZ1gsOfIss7aX6jLj3MwDI4LfhkuxEAKTjcnag97CNAJkcVKHo55Q6mw10eq9LAQ0rU1MObvvFpzy9FEocfAvWafVLJMqlIyMLH3nA41y1I0lbkvs5ZfwsurA4DUOabr98IxJaAz5Ccaqk0unv6ZeepAUFgsBkgftLOtwY6M2RxG8TcvgVgkDw7JHXi9nSHt7Dy62ozctWM7ovuWZqryBTX+SEgvUwDpzSp7mD9LvOdwh+8koAQR5fQxu3dBj+Np9NEtsLAV39WLyEd+KOaS4e8pXH7uSIK/O+qzVsNZgFxjj1/AX7GJpYjEGrrF6hGN7I2OBtuKAs6XLGfOPm2mIZokTqdhRFFJRub9BED+Rb9vdt3N1pYgWU+VxJrI20REYq1xKI0dsE0jl6osUMKuhf9m79TrBecMKXlurDS3RQooH3NgvpKEW3vfpMnjA58QULiUMroyBOA8ELXPVMu5z7t6RNfPwpIQeR4k5Ywpe9hKrnzsvdEda3YZ47T2hh0O41rUVRsx+csW+s71feI+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(19092799006)(56012099003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?Tmf8gA6O98U4gXYUYO1BT1+X60sWGYEdVnjOxk36j+9qv3g2QKqV6N/oxd?=
 =?iso-8859-1?Q?/GBwXX/OKKijjaW4qb0+Af9U9bDvT+KsbsNRDVV6LUl5y6cEH17LxI4sG0?=
 =?iso-8859-1?Q?e6bvylfGpT+nVFZJVkYPaY87J1Qfvgl+loBtrJ2an396CVwKvvharOxL9X?=
 =?iso-8859-1?Q?uDFdO7VhMfcCtbBju21PeO/97pFvgzmFA93onxBo42fSet9Kh2to8t2mDh?=
 =?iso-8859-1?Q?yRCoj1Wz4e5Cr28aUQC9s1Gr/MP3wXeVN40DU/NQRQr10L2m5xSDnaP6US?=
 =?iso-8859-1?Q?BqqI9BATXTYZfrDQDTbvAZOvwHPBexv+nwVJ0cvHsRH/OeVMlZfSOJHLQI?=
 =?iso-8859-1?Q?H3GDKIv83zavrpFChoXcFKjN5wt568smHZPWhu5Yg3osXHZBhSQVb62hra?=
 =?iso-8859-1?Q?4DoaONl3NWO/1eegqedX53bFz482TaIvm0Y0eucKIWRkO3GiGZYWPnRkSO?=
 =?iso-8859-1?Q?hRHdfCLZgHv1EDsuTGPuboxzo4VMTTlYDdeuXmcfh3Ho4yaEfTjZHXzgoA?=
 =?iso-8859-1?Q?rLTpkNwUFtp1tos2LLlkn2WZF8Cip5wO/yFW6Av2R2p/23qmfn/yI7ERvU?=
 =?iso-8859-1?Q?aGfRTSsCp7Dt1jfQfjeZU5uHKwMm6u8KzOPt/0axNyu+muHXXHZEUKKDSd?=
 =?iso-8859-1?Q?2VwsZnLS21m3aNyZwFM1TkxSt3L0CkzKWEKoiN/dmUd0Jb9EmSTYq1vF9p?=
 =?iso-8859-1?Q?aFZ5O3dOWlB0nncVcRvhD69A1xgdU3icxKLqUTD4DNkRw1Fd+L1RWjkS/r?=
 =?iso-8859-1?Q?oNaQPd4j+HzC2F7TbPfFDidBykP1ywjnooKBBgbhgOPER0X78nJK5rOWs/?=
 =?iso-8859-1?Q?nw0+pTVIR2xUgaauM9sg+VG1pXLuxDKYX2iJqEnaapiWlLHFf3iHR2q7wJ?=
 =?iso-8859-1?Q?M39XrAHnGDMASz61s914ktm2qgQCbwYgZuBdqdkKhTqGxeIkUYOahoOjb0?=
 =?iso-8859-1?Q?9wsBebhZxK63aKGJ0StENg7+kGBa1uswO54e7ynywjWQkZdtdHA1x7CFVx?=
 =?iso-8859-1?Q?ejXEkFwQX8OpznCgJ4DDRAZiuS0EWL9wQe1bGEPY6wSA5lAnd9zuTKcplt?=
 =?iso-8859-1?Q?t3kXYBoUm+SGqs9YsvQ+WIf43+bmIUulWBIS8YJrj7xuyTi066a1HKVGU4?=
 =?iso-8859-1?Q?fZ/f1SZq840pWoXGb4F6LHIDULRmfrAioC052oILq9EQ/77/qpNaQMI0pZ?=
 =?iso-8859-1?Q?DJ0DAG0f6iirIohInheObmr97HPSDq9O8hraUruHykRvirw5riPzPknZJJ?=
 =?iso-8859-1?Q?iq12ojw69idmE1djT3jSmOVyvLIxDW/bauTNf3PGIABB3GghyWUSSGX5bP?=
 =?iso-8859-1?Q?fwIVGNRv6XVzFws8pAF0hoJZ7PKEo8Apv4e0yo3mLM+nOpN9uzIcs3fuvH?=
 =?iso-8859-1?Q?9BOOtqh1cgWv00GJ+lfb6B63ClDGf+K0rtLCY2tghpeqDuVE13qF3yKSCR?=
 =?iso-8859-1?Q?yXpxQy+4UGzfarQoqRJ+GyjmJOIvsh2AFGkR5Ldjk1hgJk6h/LXCkjfXQl?=
 =?iso-8859-1?Q?peMyEQVMlUDm9zPM9L8wvw/0mCWLY/6HnHn3L9XV9Ny73kKWwwrdIuJvYr?=
 =?iso-8859-1?Q?xMbeNDpJMFrzwUPwO7SpZVCZGgNZYjKQjfe5XZ5I0rWKjnSmbtxAo67G1u?=
 =?iso-8859-1?Q?VBmNqIzD+gFgRKSomg0zz4Oc77ZhC1bNAHx81ikBvrkh6MZ+YqEGmm5G9M?=
 =?iso-8859-1?Q?RPwMvFu7ohubMlNkL8LTxNXiqEUt7WYVle5I3setng6CsDUTQMdRL2RIZg?=
 =?iso-8859-1?Q?GrYcSQl2MThf9Pl/d03svZvxUSL1gkkd0pEfX9yWpgK8kuZhuwlaRGjSbw?=
 =?iso-8859-1?Q?ssvhSgeyyg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b129473-c287-4d3a-eee7-08deac674b4b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 18:34:37.9711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bIqI5FQwxD9l5pVQwO/vIpwnCZmqCW86lLeEPR0KBzfYD+zZzJUn1J0Dqvjhb/TRLQnefKrlgAPWWoa5GGEbIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12614
X-Rspamd-Queue-Id: 47EFB4ED7FA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.14 / 15.00];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10273-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:-];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,analog.com:email,nxp.com:email]
X-Rspamd-Action: no action

On Fri, Apr 24, 2026 at 06:40:16PM +0100, Nuno Sá wrote:
> There's no reason to keep struct clk in struct axi_dmac. Hence, use a
> local clk variable in .probe() and drop it from struct axi_dmac.
>
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/dma-axi-dmac.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> index 127c3cf80a0e..41898d594be7 100644
> --- a/drivers/dma/dma-axi-dmac.c
> +++ b/drivers/dma/dma-axi-dmac.c
> @@ -170,8 +170,6 @@ struct axi_dmac {
>  	void __iomem *base;
>  	int irq;
>
> -	struct clk *clk;
> -
>  	struct dma_device dma_dev;
>  	struct axi_dmac_chan chan;
>  };
> @@ -1198,6 +1196,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
>  {
>  	struct dma_device *dma_dev;
>  	struct axi_dmac *dmac;
> +	struct clk *clk;
>  	struct regmap *regmap;
>  	unsigned int version;
>  	u32 irq_mask = 0;
> @@ -1217,9 +1216,9 @@ static int axi_dmac_probe(struct platform_device *pdev)
>  	if (IS_ERR(dmac->base))
>  		return PTR_ERR(dmac->base);
>
> -	dmac->clk = devm_clk_get_enabled(&pdev->dev, NULL);
> -	if (IS_ERR(dmac->clk))
> -		return PTR_ERR(dmac->clk);
> +	clk = devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
>
>  	version = axi_dmac_read(dmac, ADI_AXI_REG_VERSION);
>
>
> --
> 2.54.0
>

