Return-Path: <dmaengine+bounces-10999-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCwrLARJGGpSiggAu9opvQ
	(envelope-from <dmaengine+bounces-10999-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 15:54:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 578995F3218
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 15:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A5BA30E3D76
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 13:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA53C246774;
	Thu, 28 May 2026 13:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Vys5BnVA"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010044.outbound.protection.outlook.com [52.101.228.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6E323EAB7;
	Thu, 28 May 2026 13:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779976001; cv=fail; b=ZO+0usmSgWy0wZ5PfsElamlITLB6frPcbmOmPmwPyrZtvXREHAu9bOLM8t1Pdht6hyTe3DKDmYCuSgZekacBT895ddu0Nqw6x7C+ADwj88yrnWpqPEfmHry/cErDsxGl16oDNh9k0Se4DgLO6B8H0wK5x4rieAO9deNNsTbIiAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779976001; c=relaxed/simple;
	bh=iodqJw8yPc3SLc+9dPHJA1k58HaNzsBKv+oRcytgN9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j3XYfNNztH4zzcy8VingeuZOGzJwo9Zc6AvidNG0Hq2/5Ts7twPXEjE1JbvJxHWcyIizvQqNjkm6pb5kb120LBIMFwtsp1PXw+Gan7w/RB/Vrz619/1dUfSYrOSv9I6nptjVt8JMQdb4L65lI3eZU6WwIPJN5f7Tvj6UF7NUuiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=Vys5BnVA; arc=fail smtp.client-ip=52.101.228.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NV309cNV8pka9jPirj9Qfvm7Ai1sZE2dZ3YZVGB6hz6+VyHkflEmhXaWoHucMtsSfTMOYlqwVu0ah1cxI3yioHRhKOgyx7WnoHwwHJZrhHSal+emCLH8J8Pgy6k4y4D5cwzY8qmc0HOdyuYlXiWu4k4s1bnqFM/vTn09LaD/8YxYu3QEpgQ3nqmoAF3dOJ+T18lh4YKjW/TaEoDivnPeS9I6wYHuvvmpb5XUm+6bSghidOgVoF+tzhEDkSkK+0faVQPLHd3r2mht81qBKC6liU76PjWvGKKIp3tNle14rqAJi2f2XUkR+hm2at24hs0uuuw4lPapafQI7R9drNANbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6btfzoavA2Om1hYppkD4y8mKUP5UIRelQGCv/ZykXh8=;
 b=cDnpxrRsTK7LIJUV3OlnplSaYJbsi2aigWjYL5X/RiNnq1CoSGM6DgoxSSgP98sZiRM5Vhu3QJNOhlKQi5u6tKGClrFxRWAp7XU7wHi5kNv1rlU0/YRakYsW5WtovkQA8HKbf0pZCQMj8oucA/Di+bqryGirdwINkvWP4XK6xRbhWEEwAxLQZZB6KhZCUCMztWIrvknmnm09m3RQ1XVNsAgriCb3XQZO0j7fk2G7rHiLff5DZdpoWLGN7DE3sZWQDyJwtFBJoeOc3JZVP0FKOTDkY/VGHdTDZ2joDrbh37lLzgatmgMuXiAs0ekxRofg17HmoE0u7i9d2nHN0gxhiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6btfzoavA2Om1hYppkD4y8mKUP5UIRelQGCv/ZykXh8=;
 b=Vys5BnVAtF9+zvq8IjHgnZdJ2DKIiQeugWxSB3yhQPn8und0V1NXN4yj0eKFoWyMFfyl6knX71ZseMCAyBMvIl3mGk/csBft4s5+a1jlqNBMygYGKh34SlaLa+CSw6r2sIub/8ZiZVUw8JZEl+YmTB00HKh93EbAA3Pwlgyvg1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSRPR01MB11420.jpnprd01.prod.outlook.com (2603:1096:604:234::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 13:46:38 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 13:46:37 +0000
Date: Thu, 28 May 2026 15:46:25 +0200
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Claudiu Beznea <claudiu.beznea@kernel.org>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, lgirdwood@gmail.com,
	broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
	biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
	p.zabel@pengutronix.de, geert+renesas@glider.be,
	kuninori.morimoto.gx@renesas.com, long.luu.ur@renesas.com,
	claudiu.beznea@tuxon.dev, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Frank Li <Frank.Li@nxp.com>,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: Re: [PATCH v6 04/18] dmaengine: sh: rz-dmac: Use rz_dmac_disable_hw()
Message-ID: <ahhHMadRdY4NRHx8@tom-desktop>
References: <20260526084710.3491480-1-claudiu.beznea@kernel.org>
 <20260526084710.3491480-5-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526084710.3491480-5-claudiu.beznea@kernel.org>
X-ClientProxiedBy: FR3P281CA0205.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::17) To TY3PR01MB11948.jpnprd01.prod.outlook.com
 (2603:1096:400:409::5)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSRPR01MB11420:EE_
X-MS-Office365-Filtering-Correlation-Id: 1df41382-7afc-4cf0-b4fe-08debcbf8a35
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	fBN8z5xFuFCHVVz59+zYj+upBMV/zcvVOEC9s7jwgEI34iVqLLRwmSmfJmA8lV9lMovCKPmHEJwRv3varWM3xTGHDgZF9dMt/2QzOG7sVARalZglYtWwXTJkuO8fHhXywYNuyi0jvqNO9umDBh0dJvMEAnLl8DkQ+aTgyFsuPtcyv1sUe0IOPjzrsE66z95uBl+cvCvD3bUPiSZp9Xiw2yvRSYiccMIXoQpAkilmGcFGmiXZNXUmF8muhmX1UM3pnqfRh8g5TduCPX5EDacANF+1PAKCf2D1h98nSVQa3r6UIAArI1jDPZOLE2Sqy5VZigKWXmSnsl8LLelj8zDEQ+8Y7BdpgoN1XUR4Z3ODdw289LUZbvSt8pK+KaFeFAZUjqtOG9yU+KyjkHoLIxOvvXD1KaVFmMR4BK2vja0+cc4JKClXCd4yeKXnSgdP2c6GaUtbTdNJ5kDREfc68Ph5mYJ4/GakOalhJuO2hJyzlCcvOrpZOo+fY5W7v7pa0PCrlkPwxWr3MXBwnFWCdjUXhabp40if2LwG5E8rnj+0EYLxybZN6W2Peu6qf0eF1ZP9SaUyi0TaqP3HeKntSJQfcsOApPtzUU43fMY3Cx815xctscsNPA2RJhM/vteXlc01Z+MatBK/xNm402MGf5irRNfANIcUuFdDbRIdgPg1B5e98auq074ZsmjZWyhHFx3hwbn03qaZHvOMA179Ev3dUj4T5+Mw43dWMAhoulOrXBjLm2Dk82mdCNuGbDxz1SpC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?72sXcv2weEdgKVG0PjDpwreFpJ6szNEVLiB5MeI1m6mPakPzZPl6zJBajyQO?=
 =?us-ascii?Q?v4i9EjkEzoqe4dis9rYZZ/vMjB3d+cgj1oMBiBctmisyD5N7DSt9KS17/1J5?=
 =?us-ascii?Q?qzmRCUrlyjQTEzEZBJigpPXr6NdnCa93ifXWDXV0kzCboCXHSifQ/LjXPzXQ?=
 =?us-ascii?Q?Sc+c/9Lh8x78LmFjE3m3xe0fGFibBLWY5gEfpka9G8I7Bf8gEcQPcoPTFrOk?=
 =?us-ascii?Q?XrsvK8eHN+aoeeJJKMuS79bsp8glQ+WIsx2nwVw/PlbayWKRf0wA4k+ja8Cc?=
 =?us-ascii?Q?J86fqyUBvrPXAV4uAzGeq64OTjkQgRTuDe34QQjfWYNyv/6ZC9Qmy4s04bWP?=
 =?us-ascii?Q?PgroxxOug0Wkqvu7rBehE71ArFTqNIMJU8qy45Tary0v5u5Pcc20aOKzmOKP?=
 =?us-ascii?Q?VFoK7/fqJgJC/8P5yX5oJxSeGJvAaARps3o3ZspkTlHZDDRXYDWrIHgZrNjg?=
 =?us-ascii?Q?VBgQqhu7H+3JPF7qJl/Pu5WURo/XOdR4OTOK9pbAmHH3+Uy2GrH5A/bvwJSP?=
 =?us-ascii?Q?BwWUsArkVwajuZ9OHxW95uKMo/vH69SXzXy7Lvpx+qt8l5Rr9ktXFgAGIGp7?=
 =?us-ascii?Q?xsulBLTaWthlg8G05ZADsCWU2tm76xWq/c2h4nBoJjgETB5LBhitoALdnEKY?=
 =?us-ascii?Q?Dl5XQMKnJbSNa8J9EDHdKNmyycXpZyr3vSMdGYPAlu6uaRguNq4zqWZFJWfT?=
 =?us-ascii?Q?t0LW9FWbfsGtNpsFysu6w/nbQdft3LWCwuZJMu3z6dr/UbXLtr/hxY5Xtzhd?=
 =?us-ascii?Q?b64/XsqdS8AqB+n15E4otpZWnaJJ9h9/gOW8rpMQGjjxFslX+92Nj4idy2On?=
 =?us-ascii?Q?5tMM8MvP5RbG0U2AWI+wz94oAvqRteZhzps7MMyX2y4DdKiwGIV87Cw16faP?=
 =?us-ascii?Q?myTFYMOjbcsTl0vw06pRBc4kn4Ed1UJVutuhkD+Fqi7UGejRMJRX5p0koeyW?=
 =?us-ascii?Q?jq6pn2nQ+Qssay8sdabniXFHlJ51ipnFdTiRyEWrD/tT1a+n8IeXOFsG7N9D?=
 =?us-ascii?Q?Gb73TQg8+Pzht4iwvAMqi+QXiVDDGtt6Hd13q05DirtUFwdVRPc3dBKHC47m?=
 =?us-ascii?Q?+wajj+E1DaO8W5bfiJ6RQqtL5B+GluvoDFbdsHzMHYVlU6NjO1+AMTEgqCQ/?=
 =?us-ascii?Q?udfEWioLFuNMkNoetKYwWZsWHw2JGkQgCtKUmOFk8DaSXXQyfdi1GuhLIdFO?=
 =?us-ascii?Q?IZYOtKICMMYRQauuJSQYplQoNCqpVWTACCJL8pp+QtUyZgAqAGiTvP7XtzZO?=
 =?us-ascii?Q?ErQli0mtxTnlCFnfPpwLdxqgMrowDgF0lpccNWKj4qg/G5ciWbzb2o0HvPTV?=
 =?us-ascii?Q?MZELxm16SBgKJ5nJLXEbXbcisHlJlm5TfKR5c0m7QKbQhBVsGMnhbqFK/i83?=
 =?us-ascii?Q?g9NNoyuZphogWDWKnFEX3cW4F/k2mpLDkRvAQvGChXiedDYOQMyVz+L8Ws7i?=
 =?us-ascii?Q?lLiTHxAMTx3NcQog1g7xEIqTggglPU/it0C9eeMSAHBbWdQkKE7Q7+IEWwTE?=
 =?us-ascii?Q?Vjk+/ZVS7m+c7LOoEkbwPgGkwHgTbPm/2VoTwhteeThM1hmEBA1we86xs9LF?=
 =?us-ascii?Q?d+LusoRlnC9HyInEZdrSavKhUk60BZwl7FBWw2QnR4SrFDEaoDnXck6S3h4b?=
 =?us-ascii?Q?+JNe8PTar6rzpxAipfj+lr6DPjSJnhIebkhcNUYHSTJsaHMj+sUyW/ZVRPie?=
 =?us-ascii?Q?3yvfyprPQ5wkl9Dip+YRDnGUtKvT5416HqQhFL6XE7kF4Is7jbHfI6nF1WHr?=
 =?us-ascii?Q?D9QSeq9J5XjSOBtm+j1ZqWk9K54sdCRSGp+aB6zYCWjZIWnEctUG?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df41382-7afc-4cf0-b4fe-08debcbf8a35
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11948.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 13:46:37.8808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pJ8rlRGaVLSmNLsow4DC1CglpTGFE5zLNwi/PuebBBugK3qpKVdVSweubXaqcDG2SpSnsRNpjXqSePTMDqizqSria0Ovsxqyod3QfLhRjJ9ZpYPAFIFiQScHiocib+Oi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11420
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10999-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com,tuxon.dev,vger.kernel.org,nxp.com];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tommaso.merciai.xr@bp.renesas.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,renesas.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bp.renesas.com:dkim]
X-Rspamd-Queue-Id: 578995F3218
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 11:46:56AM +0300, Claudiu Beznea wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Use rz_dmac_disable_hw() instead of open coding it. This unifies the
> code and prepares it for the addition of suspend to RAM and cyclic DMA.
> 
> The rz_dmac_disable_hw() from rz_dmac_chan_probe() was moved after
> vchan_init() as it initializes the channel->vc.chan.device used in
> rz_dmac_disable_hw().
>

Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
> 
> Changes in v6:
> - fixed typo in patch description
> - collected tags
> 
> Changes in v5:
> - none
> 
> Changes in v4:
> - in rz_dmac_chan_probe(): moved rz_dmac_disable_hw() after the
>   vchan_init(&channel->vc, &dmac->engine) call as this is the one which
>   initializes data structures used by the debug code from
>   rz_dmac_disable_hw(); updated the patch description to reflect this
>  
> Changes in v3:
> - none, this patch is new
> 
>  drivers/dma/sh/rz-dmac.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 1717b407ab9e..40ddf534c094 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -873,7 +873,7 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_chan *channel)
>  			channel->index, chstat);
>  
>  		scoped_guard(spinlock_irqsave, &channel->vc.lock)
> -			rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
> +			rz_dmac_disable_hw(channel);
>  		return;
>  	}
>  
> @@ -1000,15 +1000,15 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
>  	}
>  	rz_lmdesc_setup(channel, lmdesc);
>  
> -	/* Initialize register for each channel */
> -	rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
> -
>  	channel->vc.desc_free = rz_dmac_virt_desc_free;
>  	vchan_init(&channel->vc, &dmac->engine);
>  	INIT_LIST_HEAD(&channel->ld_queue);
>  	INIT_LIST_HEAD(&channel->ld_free);
>  	INIT_LIST_HEAD(&channel->ld_active);
>  
> +	/* Initialize register for each channel */
> +	rz_dmac_disable_hw(channel);
> +
>  	/* Request the channel interrupt. */
>  	scnprintf(pdev_irqname, sizeof(pdev_irqname), "ch%u", index);
>  	irq = platform_get_irq_byname(pdev, pdev_irqname);
> -- 
> 2.43.0
> 

