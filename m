Return-Path: <dmaengine+bounces-10672-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJEKGfUmD2paGgYAu9opvQ
	(envelope-from <dmaengine+bounces-10672-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 17:38:29 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C8B5A87BE
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 17:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7B883332458
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 15:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52383345CBD;
	Thu, 21 May 2026 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BgNH50kk"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012065.outbound.protection.outlook.com [52.101.66.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDA4325491;
	Thu, 21 May 2026 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375764; cv=fail; b=EKdRcs2J0WqgDDYBXPMkPp8Yi0WiZVcc/RDpz75x/iNEYWweEGYckCDp8xvskXWvg5YOLPMCSUhC3ZBQJX/wlysJzuqr43JeSr34cnWHjswq71ltCQCqw8XY+BRYcOM/sKLVyWl6dY7Z9DFKoyFuWzHhU4wpfwSsWuVeaQIe5Fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375764; c=relaxed/simple;
	bh=1siBt7qO7gm8Q0awbeqMog7gWuRWybMoc6AVOQbniR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dTwL6K5lC+a45KIDBDYMkMk5HJos7/7iw8HQXK/8r0IUXISp9HatLFZqaDC8gniHNgxQf3mybs52YcOxWvg/g101KbGH79gKbGjcgPkeyRM+kHiE9I5/kimNyW80JQEgb9jVEM5jSrQsf5tAtKZr/GbqBhT148b1SyGwWAp1y1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BgNH50kk reason="signature verification failed"; arc=fail smtp.client-ip=52.101.66.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C3cBHPA/y8ui4KZdTVWiGzxgCw/hslUfYPbU17iV4VVbgkKoJQQxaI1ziIHcK/ov7YnVlfln2aSCHKDdSuJ12jFubl8PW8dz0jQqZrG14yvDoRfqtJ7IVhvz28EvMVZXMEfkI6ROVc0fvh+vsRskM0Jm0re4jmHWwcdZXFdHt7rJQeeT0BGDBCx9sRCTHU7xsfp+uYF2jH+o067WPoedrJ+qsdKgON5wtEyGb3jLyeus/aaVJyt97BaGOP65Iz65V4iyo3ZhrthHd3q3mHPUcXytbasdbpCPB0V6+koLlhoXIYdQ1VNuX+gASTUKcpf5R7C8T+eZHudiSjaVaS8buw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DJR71LW01cang4Y2dm7+vYOnKS+cbLXUL7RIxXVhZc=;
 b=OUtEVHTBO8OiZsKFwZEMUcMLODsx8Xr1IBI98CN+IL8Dbo8iIJnnmzgJzrITe2esWDhLj4UrvX+9Og08tCn6HfTXrSQIx0yKhuM1PnpxanBJSN8CxlNa6D1aTfc7/YYHablHhLJK00Uw02gId6dMDcHrv4BzJuAZc9mwNoSPlZieSU//019xYmvrsVOcOjM88mCZzJRW6qRW7DKLNiIZKSmaSePBKAJ6o4pWDRzovyST/aBlSJ3KjXIrQGRI3s/2YOzg+C/zoaF8UDd2h51+TNNHw7k6EDqM2rcmhq8QK46Puso+V9yfr4rakns2QINYU/SQPO/+qdcv5fSfH3nAvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DJR71LW01cang4Y2dm7+vYOnKS+cbLXUL7RIxXVhZc=;
 b=BgNH50kk5bxeiAiKhB2UCifEunssbkJ/MXUGvQGVYZHVE0AK4iv9M2tB2T7pJzT4849a569zgdwiC6td0FU0ldxP+hieuFBlUoqtMmcnNkFOCCYsGz5/phm0xaCsRS4qswlflu/0KVxwGbKJKsfYyjp3L/9uMsx8bgEpIqvoQ2mt40kopEwzFQfK7qhCeLL9iwGdnceiRsYdfLqkOAiDzPCYfAVE13gz71exeOXKxDNYzrzV7QkNCJ0Anjc9xC6m3JLo8RzwqbBSCND8ZJEBuJSPhkrH+kPqMG3O6kOX3k3fd67dw2tZVqMTrPoavahBWteLrzLMfFOlLOQHoMdQuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA1PR04MB10580.eurprd04.prod.outlook.com (2603:10a6:102:482::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 15:02:39 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 15:02:39 +0000
Date: Thu, 21 May 2026 11:02:34 -0400
From: Frank Li <Frank.li@nxp.com>
To: sashiko-reviews@lists.linux.dev
Cc: Frank.Li@oss.nxp.com, vkoul@kernel.org, Frank.Li@kernel.org,
	imx@lists.linux.dev, linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: Re: [PATCH v6 5/9] dmaengine: dw-edma: Pass dma_slave_config to
 dw_edma_device_transfer()
Message-ID: <ag8eilTSSe_Jvi9I@lizhi-Precision-Tower-5810>
References: <20260520-dma_prep_config-v6-5-06e49b7acb38@nxp.com>
 <20260521005127.586F91F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260521005127.586F91F000E9@smtp.kernel.org>
X-ClientProxiedBy: SA1P222CA0124.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::12) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA1PR04MB10580:EE_
X-MS-Office365-Filtering-Correlation-Id: bb5f8481-6eb3-48c4-04bf-08deb74a0043
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|366016|38350700014|4143699003|56012099003|18002099003|22082099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	CAt9eg/oPlxpGQSKNeMag5wvtWXUEjk64X0AE9ej3XK62xcz9YtiFpjQ9b+TEkYUG7WfVyZ3NW/kCAdda282udCKo6DFuL8oE0gcdJ+2hUYZ1MxSNu1ALP78aawKqxL0erkJ6langGKi6j277XPgp9HgVWgAXnx+vg1G9MDlMNTYhIiunjie3lsWWdbZao5zAJSi0M/xI6zUsXZtuX3FQ7jIcylwtt6Zv86n2TMQE8oGnwe3i6Jm+M3xrY+dRkE/1ndE+1Y6GQI48Xtmz7ASSwJ6cjmZjdyCAUqK3phnoIAAyy4Cet7uM8HFz7HeGywkR5KYBOVadSdkCxv8BBiFsaTIUTOatWx0k7d4KYZrwOzPMPhh1ab0WY3Gnez/G3Uhj7Y5HqbMcDpKK9oTdhIT7vKrM/svdFUCVdzcz0zSfvGAWXKbz4Rn/lZyDjv539kAr5Hr4iPPopiKV3HX0j+FwLyALdrY267bUV0o/RwTdY6zKw2ckLK5PgVpGREMDIpv21DVzDIXYsEtiabEBBS1lBftRaB1F6IQR1oU8D7Spt5jX6SNJRuZF8Z+oVkf9GfHI+XZyh9UfC5i4/MCXA9hgrwKdkeznX6vOULczAr5/jYJt+J3swXiTWnsdKHITspOilMe+o7Mus4U1Fecto+ks8g9akj4tcost0+ppnF+p/08h5EwcX234W2dlTy/jHQY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(366016)(38350700014)(4143699003)(56012099003)(18002099003)(22082099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?bKv19MaugjJRWokWFRt7NTASfoftsBjTS7/Wa8BYxa+JmOHxeZ755qIcWW?=
 =?iso-8859-1?Q?jrKUyN12t1uOGXiV51vcIxn8QjT6IOSErGVTXzH6vNuWh0m9mTW4zGP0Xc?=
 =?iso-8859-1?Q?OJsB0QcA29AFe4nxZc1DXotNxvG76yzxqlDrkyV8bOPquTUmZJ8Ubm9nEe?=
 =?iso-8859-1?Q?5sCXJEf3OPHMiBhd1zbC4rlgIl3f3lG5iX7lvVdjo+61xbk4P35b56QAMc?=
 =?iso-8859-1?Q?rrcfF9KUTwIu8xp5A3NX9MwenoATAvjhu7p0Fe7PlXM6R4y47LZ1UKw8Oh?=
 =?iso-8859-1?Q?W6kwvbxr3dUz8FxwXRC3SKj3yBjXmBlZijy7dvAOhmg9Dvlbftq77Kmsyd?=
 =?iso-8859-1?Q?7M0XjbtKG71MLLWaW/RUcTOEb8FUuR7v9nTD2iHrJq6kz4H3cWCPuEqNYe?=
 =?iso-8859-1?Q?yLRJy7mOJvBHw/tu1j81uKAZHfY91lKoDRmDY963hPf37JjHVTg98mOvph?=
 =?iso-8859-1?Q?WIvNOMW7PcZXPgflejfAswfvGLtQOYnZi1fOeTcFP0WREYLcIKrG6un4zS?=
 =?iso-8859-1?Q?fk1LHNqMoRqfzf2/uxXJoGkVNtvZfTZ0slA0XzajSNbT3SOj802PdSNyqj?=
 =?iso-8859-1?Q?Ov6eHeSXUbpxF0X9aPTOy+B4YiaYVMyRhtl5tlHmBcl8uhkPbh5V3PGM6t?=
 =?iso-8859-1?Q?TYZ/ImjSgiifd+GfJ4A96/KwC3vLxtAXhP9xQyqbxtp+b6RAWHVJ9TGV6Y?=
 =?iso-8859-1?Q?RRDRDVgcwDvEZ1dUGgAd5COCbvMdFEYbWXnfhE0uU34sWH5dxHfS+gxBJQ?=
 =?iso-8859-1?Q?hwFR4S4Vp0AE9IFWq8fJtrSJn8goNOXnsmkSjAlohqeHQ+2emawEf3WSRS?=
 =?iso-8859-1?Q?wt1EOyCk6TYa3yjsO59W9seOF/6betOW+q619admSMLzGqWZIl0qsrM1xl?=
 =?iso-8859-1?Q?LTR9I9gO7V6IEp95JFIMu5NTxEd43NoEVcZgC7dmVWh+l5C+vmxBKAMsFn?=
 =?iso-8859-1?Q?GaFxJVtry0N7n8rEEOqRLsLz0Fx0CHegXRRypNttUkVOwBXK8NzlZwnmwD?=
 =?iso-8859-1?Q?xACYvcZUN8K/OVH6pAdr5xWAYW/wfXDqVWDpsvT5X/0cO/rHzeJoxz70CC?=
 =?iso-8859-1?Q?zo6U7Y4BOafI1iDVrflG4hTSNi2/nCDLxvswsdDVFpOM1Tu/uhPIlCR3JB?=
 =?iso-8859-1?Q?GVTG5/ahmfkOL99AaDJM5Ilz2I8h4NZaC6/REMHYdZ8Vb+7izoPB9pfaaa?=
 =?iso-8859-1?Q?z7aIvMTimlzzboWvg+/cYtXPOE9tmnv/mzuTDsqDy6uMkKu6g058+lxNSe?=
 =?iso-8859-1?Q?xX5y4e1frjw7fDNtG+BG1phFvY0bbRFXj9oIuoc5jCo4i7yqP9gaDeFKE5?=
 =?iso-8859-1?Q?gI/rue/GWja1Bmms1ioXCGB7YVpTUOQkZ3WRTMud2sSSk7Htubm2Km0tv1?=
 =?iso-8859-1?Q?niDasD4SEFpFIicVdQu6LEln7INh6njKgHojNee4xDzCp0un+qhwOdo0wl?=
 =?iso-8859-1?Q?XL8BDi/Lj96cyGyD8K2PnrAn3nSSQO/Pne4/3MGYogxBtKBi1MH+oO8ULN?=
 =?iso-8859-1?Q?E+Wv4VI6QlizB3TiYfSPGrcWspBqGLKIychbS2POnlRROfg2Pu0nkmOfIL?=
 =?iso-8859-1?Q?GoKDeCNpyXUyGB6Fs8sAyvEI1waBokPJHNJ5us797n7gdMb3l08qL8411z?=
 =?iso-8859-1?Q?B6yFACCyn41NkyoVvr4VA5AyJ58MlG8mS9OR0y49p0OYYNkk24gf2kqiJt?=
 =?iso-8859-1?Q?sVPSoHmc3MSjj92E6jNltcO1kAay3MQINun9Sd8cdSOq+u93mUUvKmEBvO?=
 =?iso-8859-1?Q?ZuumF88vuYBVlLSy/+QjgnfUZmeeTvI7x0NCBFJTK2ox4b?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb5f8481-6eb3-48c4-04bf-08deb74a0043
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 15:02:39.4039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hr4JDnoUJQQokNQ8bCncuC0Z3Fl6sbTQJ+RKdPX2pnl8J0Q0Ry2DlFQh2e2p+atNpfxszMh+/tmTYb3flpAAAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10580
X-Spamd-Result: default: False [2.14 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10672-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:-];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sashiko.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E3C8B5A87BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 12:51:26AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> New issues:
> - [High] The patch fails to provide atomic configuration because dw_edma_device_prep_config_sg() calls dw_edma_device_config(), mutating global channel state without synchronization.
>
> Pre-existing issues:
> - [High] Channel control functions like dw_edma_device_pause() modify state without vc.lock, causing a TOCTOU race that permanently hangs the channel.
> --
>
> commit 248bbd394732f32660b56f83243ae2005c3e1952
> Author: Frank Li <Frank.Li@nxp.com>
>
> dmaengine: dw-edma: Pass dma_slave_config to dw_edma_device_transfer()
>
> This commit passes dma_slave_config to dw_edma_device_transfer() to enable
> atomic configuration and descriptor preparation when a non-NULL config is
> provided to device_prep_config_sg().
>
> Tested-by: Niklas Cassel <cassel@kernel.org>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
>
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index 92572dd8131e6..ba37bc983dcd2 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> [ ... ]
> > @@ -267,6 +267,20 @@ static int dw_edma_device_config(struct dma_chan *dchan,
> >  	return 0;
> >  }
> >
> > +static struct dma_slave_config *
> > +dw_edma_device_get_config(struct dma_chan *dchan,
> > +			  struct dma_slave_config *config)
> > +{
> > +	struct dw_edma_chan *chan;
> > +
> > +	if (config)
> > +		return config;
> > +
> > +	chan = dchan2dw_edma_chan(dchan);
> > +
> > +	return &chan->config;
> > +}
> > +
> >  static int dw_edma_device_pause(struct dma_chan *dchan)
> >  {
> >  	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
>
> [Severity: High]
> This is a pre-existing issue, but does this function have a TOCTOU race
> condition?


Need fix later.

>
> Because chan->status and chan->request are checked and modified without
> acquiring chan->vc.lock:
>
> drivers/dma/dw-edma/dw-edma-core.c:dw_edma_device_pause() {
>     ...
>     if (!chan->configured)
>         err = -EPERM;
>     else if (chan->status != EDMA_ST_BUSY)
>         err = -EPERM;
>     else if (chan->request != EDMA_REQ_NONE)
>         err = -EPERM;
>     else
>         chan->request = EDMA_REQ_PAUSE;
>     ...
> }
>
> Could the interrupt handler dw_edma_done_interrupt() run concurrently
> (with vc.lock held) and transition chan->status to EDMA_ST_IDLE before
> chan->request is set to EDMA_REQ_PAUSE?
>
> If that happens, the channel would be left in an invalid state (IDLE with a
> PAUSE request), which would cause subsequent calls to dw_edma_device_resume()
> and dw_edma_device_issue_pending() to fail permanently.
>
> [ ... ]
> > @@ -595,7 +610,7 @@ dw_edma_device_prep_config_sg(struct dma_chan *dchan, struct scatterlist *sgl,
> >  	if (config && dw_edma_device_config(dchan, config))
> >  		return NULL;
> >
> > -	return dw_edma_device_transfer(&xfer);
> > +	return dw_edma_device_transfer(&xfer, dw_edma_device_get_config(dchan, config));
> >  }
>
> [Severity: High]
> Is a lockless mutation of global channel state still occurring here?
>
> The commit message mentions supporting atomic configuration, but
> dw_edma_device_config() is still called here before dw_edma_device_transfer().
>
> Looking at dw_edma_device_config(), it modifies chan->non_ll and performs
> a lockless memcpy over chan->config:
>
> drivers/dma/dw-edma/dw-edma-core.c:dw_edma_device_config() {
>     ...
>     if (cfg_non_ll || non_ll)
>         chan->non_ll = true;
>     ...
>     memcpy(&chan->config, config, sizeof(*config));
>     chan->configured = true;
>     ...
> }
>
> Will concurrent calls to prepare descriptors data race on chan->config and
> chan->non_ll, corrupting the transfer configuration?

Never happen. Change non_ll only happen once after request channel.

Frank

>
> Additionally, dw_edma_device_transfer() still incorrectly relies on the
> mutated chan->non_ll to calculate bursts_max.
>
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260520-dma_prep_config-v6-0-06e49b7acb38@nxp.com?part=5

