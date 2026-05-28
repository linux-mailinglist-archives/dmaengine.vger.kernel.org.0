Return-Path: <dmaengine+bounces-10997-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BbCCrdIGGpSiggAu9opvQ
	(envelope-from <dmaengine+bounces-10997-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 15:52:55 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 821495F3161
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 15:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CBF83113FB9
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 13:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA006233938;
	Thu, 28 May 2026 13:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="ZisFxgDp"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010055.outbound.protection.outlook.com [52.101.228.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753FD1C84A2;
	Thu, 28 May 2026 13:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779975932; cv=fail; b=eYfauTwum76wpGvc8m8mlDzNly0PIUQs8Iko5fUuPsXjYf+I/UYCQfi+VMwE6e82Ltw++YLLDaxMkFZK3ba0tP5X4bsPhgqZcVtCoUPvapXC9MhIVuU6wdacUFKIZhnj/1Sm2rwynOGjumovcTUqIuO4lhR2kS/GHO8lTW78oCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779975932; c=relaxed/simple;
	bh=EnG/vyPSBGBiYIUBI9YEuXPzvwoUxxAmcTtPFQZ6gy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=clUZ5O3ZR/soRh4hc4m6jcTfY/S54P4LKpLqPkCw94P7SWvUGFBZrb1hlNU29cwRVw/H7JecM38hL8YWcptyEz6HXm1oOCD2EEvE7a1LOA7U7g47UU6H6qgd6SbP5hWO6qlolyrx6AEOVXUi42+RhfAN/AtC3SceryGncaIoKDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=ZisFxgDp; arc=fail smtp.client-ip=52.101.228.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Df8Em8aPU+am1OA08movWbo2zkP5Wk7G4M4d+0Hy1MCpexdZSDW6gqWXfMp45+5S2jBWxi866oxp1BvilbM9errZK+d/9wDycvL3DrnxIJxJ1yE2ss1nA8MDrKitkwKP9qgsncbTELeX/1lMYX433r4NPsWiiC2qaD15qqQGg9zQQ27XMF910LpQnKnBSCSlNEAs2FyOgFtUvfIHNtP63TnelX84vg92b0mI3BNxzsChnBDoqXDvCVLlfesmbgeheTLsfJpodwUmiufHkwcdn4czTMrGZfnQXvtVanjZqOH3FwF5cltIGCR1X7+OMA7HXNwakjc3IEGWUQLB2yg5NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2e/8gg8l845Y/Vo1K7QCIGre5a2eNBxYEGnyl37+qQ=;
 b=CMcFt7zQ6sg45rxqfYqgZyplr7gWHqLDyfCpKqMHsxPkgJeofUQPAu04HqCXT+6BOP8FVAL67TL3HMmeKlgXLIWSMSga0mj0QDWyoYUOE8w2DDh5PFIrm+35pdfTNvaeS5OJYFrFm/BgDAnHpbts7+g5B9KcemoPmpvmNmRsS38t4/RgaljA4U/bccdMw2pkeFvZ0bYEnhWVvJ504oF9kUHbyr6ycTwa4C8XvDW2kuBdPqmGwiyLwq+d9InTkuhT2l0cHM550dncWAWveBVa7gylw5QUxXQkZQtmNcojO7hhTHmJ9NZrzcPYwK5Pzw+UX9znJwsMh37J2PdcpSYHWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2e/8gg8l845Y/Vo1K7QCIGre5a2eNBxYEGnyl37+qQ=;
 b=ZisFxgDp81p4vzhsWbWjLihSVyGI2DCamLFMhCe8KPrl2en2MP4Nf6ctW6VeVD89xds8h0bdUHC8PWuebwj5OxnOBNxU1jMO3m286YrVz10mpYydj2OhD+/f3T56eLzHQy7YetloIopaHsO+XJ7ZGq6ReMU+2xNW/y1WWqwdY8Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSRPR01MB11420.jpnprd01.prod.outlook.com (2603:1096:604:234::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 13:45:29 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 13:45:29 +0000
Date: Thu, 28 May 2026 15:45:14 +0200
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
	stable@vger.kernel.org, John Madieu <john.madieu.xa@bp.renesas.com>
Subject: Re: [PATCH v6 02/18] dmaengine: sh: rz-dmac: Fix incorrect NULL
 check for list_first_entry()
Message-ID: <ahhG6uoQX3s3uI_8@tom-desktop>
References: <20260526084710.3491480-1-claudiu.beznea@kernel.org>
 <20260526084710.3491480-3-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526084710.3491480-3-claudiu.beznea@kernel.org>
X-ClientProxiedBy: FR3P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::17) To TY3PR01MB11948.jpnprd01.prod.outlook.com
 (2603:1096:400:409::5)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSRPR01MB11420:EE_
X-MS-Office365-Filtering-Correlation-Id: 95a6afe0-32ed-4afc-9c98-08debcbf6131
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	4BOiKy5yI+IKYBAAcfGAbW4ElzhAd8fmfFOs+DuL2oeQhgFDZDPOougxi9kUboGMz1oksjiur5ClQ3sIOSU1akRXq5NEua1Xw0oFMUZ/kOREBIZi1J8NNdP3f2JKJUiUS6yAxeAamu393AY0s+uwseJdFSETUk/4RVyIcmLZvhl7y/7cmvMpp5xGfxFOxDYdWLKwESRq+QfHrb9S5Bd7a0g+ClfPE3HWockZClONQ/iDhzM7gAYgOdv416QQETUDz43O8l4THVWKgioJz+yyQiTjFibqV4W6J+AwHPedf1GNQZD2zdnpxQmjaPdAhlxkTzHSDDVlHgaGtu5o4S0aTUMtGOZPvT8hxSnC8atS4QRehRzgc5iu83dMgt/UmrDQTxPqVG87xMpjfPDO/7L2Cg3iS88juPSagfLHpettdoul7r7urQdyrlLKOk/GPf8WP/bL2cvkQ/QTMpRbjlhu6jvs73yf0G2PF+iN5fJa8PB7Sdo1gshhDcWa296Jhz9aFFiaDFuBzYOHQxH7yE/wOE2hmoZKtQAnx8SLzJQ415d2Stf9R5E0G+TtA3Egb+vlEnBs+xDvqV0rFBQ1kOPykSUoWFS+SZazJizq5COWYzynY/YpKJmcCh/nIqZVn9dhAGcghgSCaOLgAdCX28nU3c/rrbH+AAItGEoqKq/4GqIuHvrimXyyNmOYIbLIYV9WeRiITBpCxLDbH1jgZ+/x6ZPU5/JbnbpSz9ccwLfNtbIurih4U8E0f41Rqb6/5eZ+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?odGiv/+W4xMi3Nok1vjRJgbT8C4yLCUIV/zNHGIFRKERuW4FdPRjfjKyjpeE?=
 =?us-ascii?Q?FTtQzDGoMTMj8lnNapJzzCnubMNv8Iov/p1ycA1x2farJ4IHkZJOe7xstaos?=
 =?us-ascii?Q?YQWPtc3zau9vHlmMAoX7h0d7Tzg5maok4S2WeLHLBspT23CUO7KA12jAirkK?=
 =?us-ascii?Q?NMbI7DdDbmsXCza7ILNJwSXDAa1dBjibNcDyKH6z5KQxSNFavPKUH5wm/xyq?=
 =?us-ascii?Q?XWAbNaNVJSf+vSaenLag6LCLZVy6UpGidRtvYFSLnFmKeICGPfZgfcObO6/F?=
 =?us-ascii?Q?CWBo6qf2aSNGvd5lJ1J4e8ZZXj9MeJ3mgP1Ep5ExzRlWN/l9KnZ7N5LdH85U?=
 =?us-ascii?Q?9Bzk7nZg4YPc1nZ01k2Mql7cnL2lzeGEg5okUtHriDci/sZbZtUMD1uJV38j?=
 =?us-ascii?Q?18Kfkav3NQXGGeBW8oTfIkIeMR6A0getduyAZlE/kROtotxEtU11uVJojNLE?=
 =?us-ascii?Q?P7SHQXo7sOq0t3FvSkEhl7t/7ifsu+ybrIU4EMQOxoO8kHtEnQYTsu6arMY0?=
 =?us-ascii?Q?4cDzm1Xdg57+1vsajxHeN3A+HdQLAhn/1N0DSkMfyRgDA5lzpBrQhS/1UIOB?=
 =?us-ascii?Q?lYhxhH+mQW/poeks+5EaIILeYn6g8ho7pmxKx5iD7j1zXUBX/BLnwo+uOpWU?=
 =?us-ascii?Q?KaVPihW63Q9xKvL8oSHHHq4mtq0cycv1XUKCeXfxIEc5pVSr88X0R50DO0yc?=
 =?us-ascii?Q?J7my2rp2tbnBGQg8rBwIQ/UV1/wnjdNxCZRKFEWAMKPCgE45W4GpFrVdP/QI?=
 =?us-ascii?Q?hsJs799Ykb3UREkLG7FWKPSKQF4eNdAc9/RlIwcthT70//Y8QMnRh+v/mrD+?=
 =?us-ascii?Q?D5bzIPJRdkqWHTxE0rlZhP4bx0F/LQ4d/EHdqkEFc/0QVPubN408bNGCR60c?=
 =?us-ascii?Q?Ikcipn/1V8GPbI4CeQpnvQv1DOm8ciaGKD9ouCSManiy9zRL7bMns7LRhTv8?=
 =?us-ascii?Q?XhRVNO1MW/1KTMXbauJx0rnDIjJcyEDBsLy2UsezLzjrOn4n8GcLLz4EJe5s?=
 =?us-ascii?Q?WGPayHy2IwVXm2FnkxwUcLGFXhRxqVCFfy4HtJXvEh1AOkNftVa5csYEhh03?=
 =?us-ascii?Q?wovpaF7pjHhcNw59q5K6Wpsg1PJK/oKpldNs4aEq2Vwm/+tPb9U4E31oQvjH?=
 =?us-ascii?Q?k48f6SixaqirQv8FW2XirZ1pi00UNuLv+HmYj0HiVB6vACCW7WlrnaDBA6qb?=
 =?us-ascii?Q?R8IgmzcCsU6mizYoaqWjLOPIY11im5/dp9Rl5pgrHOujzDe6qh+gP4cnNRz/?=
 =?us-ascii?Q?SVKqHuxVX3tihMkNbJktlePq+DXCoVLdAAUEAj0G07/eVfcWRw6E88RmpeVE?=
 =?us-ascii?Q?lM7VsO57ZpaiHV/IDf6tngfO1qHY9GPNCo9ODylKSInvV8b5CMR1oe6IsZlN?=
 =?us-ascii?Q?eKCEilFozmX7hLWYDnJ0qCWDrnOmQaOZVsrXFn92/YLwrCn3zTrxFOyeYvIy?=
 =?us-ascii?Q?4pHZQ+x777LrFylGsNrhn3NzH5GhpQruISh0XmfZIOGeiIznDCFqIMJUl/W6?=
 =?us-ascii?Q?3ZpIFO10xR2uUsdzyH+PHjzGcCn9srd/MtGnzILgny6I+3psllU7jrVIQhgc?=
 =?us-ascii?Q?vhc9hJk181kHBtijbONo3x4VD1ywEl3AIJ8rZ5iGeQ2HkBo4DJEPxEpqP/EO?=
 =?us-ascii?Q?xFm6MyWxa2jIk8GYHkpr2HUEFFXvULp6SCMqj4OQpAMJWVrM1rQYKl8xP9sB?=
 =?us-ascii?Q?07gzoRxjUKW9fQuAmAWk9Y54rM2jQgdRDaAjCAfPCptbNPm4DmZ/cIfEJQ4v?=
 =?us-ascii?Q?XN+Py7vAau3qPROHxPBKDjijy/jaybP8H7rVFIqQPE+UdavmcdxK?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a6afe0-32ed-4afc-9c98-08debcbf6131
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11948.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 13:45:29.2876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sqafjf2BSyzvHymCWvqD0mAyl7O1w7A8U3dHoxmItyaq5/QQfDrGJGRmvdtPQdDZr7L+srcr69KTAHX1jwoj2R4r65qhTMnRCblA1WDZfpIpaW8bQ3vTrteK0bWVcH4K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11420
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com,tuxon.dev,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10997-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tommaso.merciai.xr@bp.renesas.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 821495F3161
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 11:46:54AM +0300, Claudiu Beznea wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> list_first_entry() does not return NULL when the list is empty,
> making the existing NULL check invalid. Use list_first_entry_or_null()
> instead.
>

Same.
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

Kind Regards,
Tommaso

> Fixes: 21323b118c16 ("dmaengine: sh: rz-dmac: Add device_tx_status() callback")
> Cc: stable@vger.kernel.org
> Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
> 
> Changes in v6:
> - collected tags
> - updated the patch title and description to reflect better the changes
> 
> Changes in v5:
> - none
> 
> Changes in v4:
> - none, this patch is new
> 
>  drivers/dma/sh/rz-dmac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 9f206a33dcc6..6d80cb668957 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -723,8 +723,8 @@ static u32 rz_dmac_chan_get_residue(struct rz_dmac_chan *channel,
>  	u32 crla, crtb, i;
>  
>  	/* Get current processing virtual descriptor */
> -	current_desc = list_first_entry(&channel->ld_active,
> -					struct rz_dmac_desc, node);
> +	current_desc = list_first_entry_or_null(&channel->ld_active,
> +						struct rz_dmac_desc, node);
>  	if (!current_desc)
>  		return 0;
>  
> -- 
> 2.43.0
> 

