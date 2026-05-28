Return-Path: <dmaengine+bounces-11001-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EF7mKBBJGGpSiggAu9opvQ
	(envelope-from <dmaengine+bounces-11001-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 15:54:24 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 181835F323D
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 15:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D9A531451DB
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 13:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62024280CD5;
	Thu, 28 May 2026 13:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="wkR2NAfO"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010008.outbound.protection.outlook.com [52.101.228.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5037D26A0DD;
	Thu, 28 May 2026 13:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779976083; cv=fail; b=F9B/pH9oTRMXRxJ1yX/HOet6ysb7HoEnY9u4VMmKmtdIUCiZjj47WvrCktFfGajjmo12I6yPsFotTYvSErssG6XSjqh2bcZkCcoam2/lPbW+IuHzew0A4MvXz+v9ziUrS/rLDegnAz03qavJWhtml90HSAEk/wh+d5AZX9FRqTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779976083; c=relaxed/simple;
	bh=SYN8+ueyx53p2rawRTb+hmpcrjrCZ8IvCqdSXki++3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VPjPuC0rZ3B8ZBwrOjbL8ECyBiASA0Q6lVPS1MzgTiKwlSQTGEMyhCq5v0V67UvTZZPPYqqhvvsOlDpm3LEtQgyK2kbO4lnVdnjYPRKwNCxeXPpy/ZSC2qjimIf+u4TtFiUkeE/7UKrXNzTjhMSU4kwwqRnrBUzQkOtYO1ulb60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=wkR2NAfO; arc=fail smtp.client-ip=52.101.228.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZKsfj746znkrNFFXKckn26BQcfUSYT+bCXP/LY8bGjA7LQhN0n4o9F27AAc7tV9ky9iCYIq7ug+lUwOmuJMuGv8fbTm6qikG6YNylSVA3oJwLhpoM+pqxF8cMOVwRrcRsetTfqdMjy+6TUqLBRnvOYit7HLDUps2IwZXPF/KhHLKMXZLpQlG+bYgb+I6tHMrx7buaZAC0lR8FOjWsB0orVlvcJrgsy2tqgUry0KaELiiQQst/GOh3eldEJc6fcWVmrUR4ErJyXY5QK+alhUfpvnMWQAKJnswIKO4FRVlMtWMizrBNfnlpELGVEsfnmcbI9DeXll40DxoGE5wRWXDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=autLTaq2mZTOKUQN7+sTmVM11oPl+OoQQIW2NpM9UTI=;
 b=HTkpaJCp5qKfASFfChNqQZBebaV5gtDvwqxdDhp43EyzjFNBxwz7zuNGpgUeMgoSBqjA5W0gHhDDlBD5mTiyLaimmtwo3fQqIK9P8B+ZeEgl1H2Hr0M+WifWYxTr0wYFTfMBb8XegSL//KYANsgwXPF9rNc+RMs3RGIF1wRd7rvLvg2aT7FtbHanjPXPy48rZxcl0iKZoJapnevOlNWmk/Mp5fAfnHyafLKUnMrxcu2/SoRtZbZs8pqeGkVkKn+2Bbe+2bz15LdQP2lYe6emlPfZjnMhQJZVtJQ5RV0wVIxhXlqrcMgL4y2QXSlqYxB5ECRaQYJe9DfnULXT0I60Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=autLTaq2mZTOKUQN7+sTmVM11oPl+OoQQIW2NpM9UTI=;
 b=wkR2NAfOiOTR4jRBDTp9tm/j6tKK0dZGT8seXnB5+IxwDcMDjQGElkUfT1VVCvj1r5/4f9jn2PP+R2vHIFSdpjccpAvtCzbcvSJ7rYTwyOf8Nbd/eLDu/87dV54RgWIGEMZPAnD0ZSMrD2weqBtuH2yXGuwv3oyJzCe84RagvoI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSRPR01MB11420.jpnprd01.prod.outlook.com (2603:1096:604:234::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 13:47:59 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 13:47:58 +0000
Date: Thu, 28 May 2026 15:47:45 +0200
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
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: Re: [PATCH v6 06/18] dmaengine: sh: rz-dmac: Save the start LM
 descriptor
Message-ID: <ahhHgfNQgslrDgtj@tom-desktop>
References: <20260526084710.3491480-1-claudiu.beznea@kernel.org>
 <20260526084710.3491480-7-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526084710.3491480-7-claudiu.beznea@kernel.org>
X-ClientProxiedBy: FR4P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::13) To TY3PR01MB11948.jpnprd01.prod.outlook.com
 (2603:1096:400:409::5)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSRPR01MB11420:EE_
X-MS-Office365-Filtering-Correlation-Id: eafe8765-98d6-4e36-b175-08debcbfba5c
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	lvTs7MTUUHvXrb3KgNA/ZTilH0QKKOoxVtykp8yWM84Q1O8udAfNpuXSYyTyFeDakXJPGzczcTRO+Fqj7c5UVRWyBx2SYfZt4lxnUfXoCJR513I4l/mdz6KF5dBSiqWlMtsWjn2lTlAboca6N/kuViwyaiikw3Jg7AQy1t8wzgH4T0E+bjNQKqcBf8bwm83dPMtqF9c8JaJpzCcIVNeLNtCeu2475LGldtPIT0OkSqvSS56ZEIzca8k54Mbnr/jLJUR0fBRN8xJRDbyRzD/r9eOJqMKq0SVSiuohljBimmfQEN1v8p0ruLjeO7xPt1zJ7RoGaI4bvyz7RDIin/3GgItxaNAaOCWWH5T/QH10r+RCQ2jGG7xdoJeIWQqyAUz+1HsxMSX9On+N/hlCrqYhvtPH1Fmrzy4CJ5d/Kvcoi1nUKf1K8QeZPV5+j+cHJ4ozyVR1azpBJ6gKBgzvV1s9HuUdS1wD3XQ+O6onL8v8q3FIAzEZ27ACYbvOel7pTGSv4IlBY65dR/coIVdXEa580ms8m75XWqy5ahzwp+zEVJ6M9INVVDnonh6fnzv7DZPgSthiT9/6Nw8SRhAFaQl70sDv/UJZHScfntpotCvta3A74iU3QGaGmHiaZZGVImmuV6vvu8ivw03/8XWKh65rLAK7aZ8PFm3sgiD8saR71jWjhm4UtoxXCvDcApv+8lcBIl0ikdDSok8ta8XE0phaf8me1fWh9eCO8fZ2ykCP10o7qFs4McTSDhCQMDbbeZpd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6Gc+e3yWAuGObrJnIVa6abrQmCxnZJRc2qnDhbptlNbXkOh4NplXED1LG7T+?=
 =?us-ascii?Q?SV/DV7PsPPdOSlFrINaxESdv8e12AuSbvy9eD/s5myvA3OEp7I0ZUQeWPDo0?=
 =?us-ascii?Q?jK2TvSoHLLekBmUmIsMia5f9FtFF55BRTNZ2SVkgjDryssKEXQ7Tkqg75jry?=
 =?us-ascii?Q?UJLkc6mmxIR8vDHKDMijAQPLmXY2b8w2K3Hn1cWAk2X1JGT2oQvKRHWUqatm?=
 =?us-ascii?Q?3+sn+hgcNAFsvjq3rTcqcfkjRQFkwVpeXdCZYiCbTLsPy+UL/ibXOaFEU8jn?=
 =?us-ascii?Q?lLd5ZCCMqJI3EDzxSOl/0x68un0CDATD8uI+rXX5ugYsPAxphwfLPOyMqtH3?=
 =?us-ascii?Q?O98AInP4j7VPR2XjX8z1eOrHkDqE11OKpIb/1Ubf+0E8huBU776DepTzKjEB?=
 =?us-ascii?Q?PGx455CF2Fsb/2xf4adtB7JnoZU6kOrTn8JuUSt0k8y/aZ5+2TAnPvXrkiMp?=
 =?us-ascii?Q?Wx7gmcomX/yt+HBsYqaPkhs7zbZEdxC00FvMkvzjzUw5h4pk71MlsBXhHp59?=
 =?us-ascii?Q?tY6RcGQ7Z+HTNi4LqkI4KnVEjJpeMKdDyLWnle+yvcC3CvU0KZyk3/w8lH9a?=
 =?us-ascii?Q?oaxLv5euxcuguoFBvj/xZDVBd4t7jZsNvd3n7HhxjiWdhXieTPpCGwc/Vikw?=
 =?us-ascii?Q?9cnZjch1+hPx2cpZgJ6T0Bb4vBXw+zrJ1jL7pg4X+TQOuk1BORd9ZEoRtW76?=
 =?us-ascii?Q?lsyxNtU8KQcNs6I0supmttc0S9S7xZi4qT1Hu4q21vkuLQIBzRHT7VBxyWhg?=
 =?us-ascii?Q?+b0MDc/fkYTuKH111/Ru4jMZGgCFFtWp71NLTIvflVNgrY1V0g2/UFlQSOFK?=
 =?us-ascii?Q?ED+CMPDV89ffkpCUCdfN6YMsyNY05jTD1OmQLqGy/umesjBQpvISLQ00BDP1?=
 =?us-ascii?Q?2zHEAlORZT43FLQWPa3hFHfcMpsk7j8c9sfCNdsaOaRWr3vcg4h9fDsVHU2t?=
 =?us-ascii?Q?jGgqDjIFM0wSL1xpDXq812MqMh7xYd2LMG2B5PGsdgfzONTw3W6b3hJaVBag?=
 =?us-ascii?Q?u4ITmdjpKabJQNGtLMcTVpgtE48+bivrRXez8CU0UGEmxb0vv1JTGbbJA/lh?=
 =?us-ascii?Q?+6wXys5ipXAmCkx1ARZkt+ndW4gH1zppnLJG7FijUsp2FwsA2ovt3GjoGK+d?=
 =?us-ascii?Q?8z8JOcFmQHAJ3XWty3yv0y1WV0SXAsuyVmEhooNz612TZYig7FWyINPpDeYM?=
 =?us-ascii?Q?+iSW1/7gUU/VxGzR09TRC0N1vQogXgJr+ylA/VMWos1oPODpQfMy4Z4sH3Fy?=
 =?us-ascii?Q?tU5fQhXwZ3vywT5lTDb0ZeGxo62X6Jc4lub8TDEPx7yIRmq28xzRDhmK/HO5?=
 =?us-ascii?Q?LHcG6C54p5di2yC6afNA/HCtT2mcTb66VyZOWTLgUQvHK0K4y418vzvf6U6X?=
 =?us-ascii?Q?o/UnRTyKOs3nvq9ojbeh7fgT3gB6BPkMu9EiL0xb9s9ZshaGm22fbgNKcOaM?=
 =?us-ascii?Q?5P4ZvDES8b6HRV8NaW4Q2KERbxkyiLWpxQKgzyCZoHXgaNTWdyA/SucA2Smy?=
 =?us-ascii?Q?Dp8+mVu4yGyBxAHJZrGtGo3W0lLNrNUpkqWdxYqDfrQvROeyCoUklq5UzIsU?=
 =?us-ascii?Q?4/BHETSzYjVSr8eRj8UNvgYmp0+PeGTTgKTELXGt9IZekLjJDIR/7vyni/Vf?=
 =?us-ascii?Q?To0J/BRIuZnq4mIWR0Kb1JVsZmds1WGb017zzsrp90KtDCMSp1NeOPWS/w6L?=
 =?us-ascii?Q?nzSQ9NJBy4o2lj6cAgDE4y/JMnKUsOTPqVbuSb7CoVgqu1v/PU/rciXC44Fj?=
 =?us-ascii?Q?xD9J1ugyCSkWSS0vImtwKza+f6xiH55Qe0WDswV41SnwRb83fnVY?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eafe8765-98d6-4e36-b175-08debcbfba5c
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11948.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 13:47:58.8409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NYryfVeE273oXyCS5QDyIAP3ITScR94QVOgGrEHqLO32mAkviEGZIBF63SeQbmdX6X/cceV74vq+n51OHssnRZN2gDVDBVwI97jTaSRjk/FOjAp0OpY7oWpuQ/f/TMoh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11420
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11001-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com,tuxon.dev,vger.kernel.org];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tommaso.merciai.xr@bp.renesas.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,renesas.com:email,bp.renesas.com:dkim]
X-Rspamd-Queue-Id: 181835F323D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 11:46:58AM +0300, Claudiu Beznea wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Save the start LM descriptor to avoid starting from the beginning of the
> channel's LM descriptor list in rz_dmac_calculate_residue_bytes_in_vd().
> This avoids unnecessary iterations.
> 

Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

> Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
> 
> Changes in v6:
> - updated patch description to describe better the changes
> - collected tags
> 
> Changes in v5:
> - none
> 
> Changes in v4:
> - none
> 
> Changes in v3:
> - none, this patch is new
> 
>  drivers/dma/sh/rz-dmac.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index c48858b68dee..d3926ecd63ac 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -58,6 +58,7 @@ struct rz_dmac_desc {
>  	/* For slave sg */
>  	struct scatterlist *sg;
>  	unsigned int sgcount;
> +	struct rz_lmdesc *start_lmdesc;
>  };
>  
>  #define to_rz_dmac_desc(d)	container_of(d, struct rz_dmac_desc, vd)
> @@ -343,6 +344,8 @@ static void rz_dmac_prepare_desc_for_memcpy(struct rz_dmac_chan *channel)
>  	struct rz_dmac_desc *d = channel->desc;
>  	u32 chcfg = CHCFG_MEM_COPY;
>  
> +	d->start_lmdesc = lmdesc;
> +
>  	/* prepare descriptor */
>  	lmdesc->sa = d->src;
>  	lmdesc->da = d->dest;
> @@ -377,6 +380,7 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan *channel)
>  	}
>  
>  	lmdesc = channel->lmdesc.tail;
> +	d->start_lmdesc = lmdesc;
>  
>  	for (i = 0, sg = sgl; i < sg_len; i++, sg = sg_next(sg)) {
>  		if (d->direction == DMA_DEV_TO_MEM) {
> @@ -693,9 +697,10 @@ rz_dmac_get_next_lmdesc(struct rz_lmdesc *base, struct rz_lmdesc *lmdesc)
>  	return next;
>  }
>  
> -static u32 rz_dmac_calculate_residue_bytes_in_vd(struct rz_dmac_chan *channel, u32 crla)
> +static u32 rz_dmac_calculate_residue_bytes_in_vd(struct rz_dmac_chan *channel,
> +						 struct rz_dmac_desc *desc, u32 crla)
>  {
> -	struct rz_lmdesc *lmdesc = channel->lmdesc.head;
> +	struct rz_lmdesc *lmdesc = desc->start_lmdesc;
>  	struct dma_chan *chan = &channel->vc.chan;
>  	struct rz_dmac *dmac = to_rz_dmac(chan->device);
>  	u32 residue = 0, i = 0;
> @@ -794,7 +799,7 @@ static u32 rz_dmac_chan_get_residue(struct rz_dmac_chan *channel,
>  	 * Calculate number of bytes transferred in processing virtual descriptor.
>  	 * One virtual descriptor can have many lmdesc.
>  	 */
> -	return crtb + rz_dmac_calculate_residue_bytes_in_vd(channel, crla);
> +	return crtb + rz_dmac_calculate_residue_bytes_in_vd(channel, current_desc, crla);
>  }
>  
>  static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
> -- 
> 2.43.0
> 

