Return-Path: <dmaengine+bounces-10386-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADegCoySA2pz7gEAu9opvQ
	(envelope-from <dmaengine+bounces-10386-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 22:50:20 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85338529934
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 22:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99B843121E90
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 20:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45E43C196B;
	Tue, 12 May 2026 20:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iKjdw65d"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010032.outbound.protection.outlook.com [52.101.84.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4677B357CFF;
	Tue, 12 May 2026 20:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778618688; cv=fail; b=jUSk4yg1/7ViP4ckPy+YVfjlRzjRHO+NRQFKyDLx+Ppbk0PEMBCkDTfIZMZ3qQ4oULzOC7dV84D5OlgEn7XNm9rkQGjsRKCkCx5vtE7VlPFwDmj/GN3U773RGOe4vdBulqf9zvZsbm26AlnQ9AL8k5Op+Nw3git/hZVN8+KRvjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778618688; c=relaxed/simple;
	bh=TVSgL7izlE2nTjiTrW+pacjAg3jRJVbPfPV3JQIHw58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NfMaBFKmuDTImKeKCl/nODuLLuibN/2lr13frR7JOYElXchQxSEOB1GNikJZkaUdnkaSUrkaqqsEE7eWtdmIMvMd1MVxNvQ9uBoW61u/Hmog6hwqKTiq+BcVesIObXK4w2id1kG8mZs9fsO3/mjoa8Lb0DR9GI4AXkCERQEkcjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iKjdw65d; arc=fail smtp.client-ip=52.101.84.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVO8+QcPqAc5YXQ/FgMYJ0pGYnDnaaGbWkDeWCFhgZLkYFhlKN/vs6DywVSjq6gT4bhuSa2+IuSZgmsc0ffDoVhnFN/CuG+UUYhVXsPknWKIAjknsx8Xa6198uwu/eEVrq4qjCKVXkgUs+RfKipUYBH7+VBQyYGWpJg6foeHTezFTTHfkL0BANcR0hidfqKOz+ordSHTrY5CjhvcgIZbu/jt9V3695Jhl/i+lGkJcxTgVfPdM16uTtXfnJDXTR40wVr9jXbD5gg+yoL5IviPkIA+0p/H+R2bkYJhgzsKFzGBmdeUSg3ozUZRtL9MBnYdPSAdnj4ym3fsEiVhwpbioA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgB34ozdvi9F2HcgbhVdtLwUykwqffPbdpVuIBtQcOo=;
 b=GcVOskL3bRhMQIQ52r9nXtz+FfbQUzxnha7oynBWYYFPCjdTiZfMiXh4hPwFRIlEuUo+KBkc/bLO5iSqfqA8VsOIW6hiRHO8Ytal/hlJaabcTCb5wXYGVu8d3V04nPzpl7M9kDOEo839hIHhVuDi9zf5ODBFC/2xGlWqny6H1TLI6dQDn8LWFVJyIyFuMb7aviOdR7mbA1wig6g+35G8CJVxFn9Ie47WmnNTQENBOQpY/spe8KVdRBFwn+IvVhXR0nekClPfPzMrc4MFyhZx0u2pBcNAaOlntJaCEt+uttp8YeafJF7LyraIGibSf8gYOEPA3wvfH7/MI8EEuPux+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgB34ozdvi9F2HcgbhVdtLwUykwqffPbdpVuIBtQcOo=;
 b=iKjdw65d142qb6/+HqeDOXmWFKo0EuwYBwE1sylz0G0p6OC3ey/+kzsJp5fLPLy/4FAX+vrp2Swz+2foud8RO75mew5pblgVpjn6EGM4fa4lsHkpMK4Pl+Mw/VCgBE6nzSf7ZQPK4xlmyL/s0T8y3cOeIEhHik6V0UUyt40NeJrn8CzlVp+GVoiqxqIs7MifTMZWbRxsSebn9UaMXAyJkpCIx7Yb+S3/FvZLiuKN+YbHFQKPVxUmC+ERkq9wFscI5mgpYll5zGysytrfHAnO2rIYO1GNmQpRM9nJiZMPru/Wapl6Eb58H/2DHGucKSQQpHVQglkyjd0Ad9sbNtAWiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by PA1PR04MB10142.eurprd04.prod.outlook.com (2603:10a6:102:464::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 20:44:43 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%4]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 20:44:43 +0000
Date: Tue, 12 May 2026 16:44:33 -0400
From: Frank Li <Frank.li@nxp.com>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, lgirdwood@gmail.com,
	broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
	biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
	p.zabel@pengutronix.de, geert+renesas@glider.be,
	fabrizio.castro.jz@renesas.com, kuninori.morimoto.gx@renesas.com,
	long.luu.ur@renesas.com, claudiu.beznea@kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5 05/17] dmaengine: sh: rz-dmac: Add helper to compute
 the lmdesc address
Message-ID: <agORMcW7Th6GOk28@lizhi-Precision-Tower-5810>
References: <20260512121219.216159-1-claudiu.beznea.uj@bp.renesas.com>
 <20260512121219.216159-6-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512121219.216159-6-claudiu.beznea.uj@bp.renesas.com>
X-ClientProxiedBy: SJ0PR03CA0354.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::29) To DU0PR04MB9372.eurprd04.prod.outlook.com
 (2603:10a6:10:35b::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|PA1PR04MB10142:EE_
X-MS-Office365-Filtering-Correlation-Id: b4205290-f190-4c88-0cea-08deb0674c0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|19092799006|52116014|366016|38350700014|56012099003|18002099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	lDYCm9sXhVLZomY9FaoNjo+Rc5BvkcWCpKarJ3K5zoPADi1qsjeK0XVY3nfZt6nA9G7/YdW7xa0zkheSZGiEdxMir97D+wYcQnCgw02fOLJhgCFMHL7mYmiF2jAvFzirnMuco8Vm81QUVyr3YRtLFN2EkPBLjmB4Kuk33+0XwrmbpyaOje1hHfxA8w1g+ENtZQnZ7uaBEld3HGteomDgQmb5bxgw4xmh8AlKGSwmRAvTX+HaPtTJbBgdyN0JHu4dksw3hXn4qmBltHfzTiNeW1fW3EnkBPTHX1fvz+3BGCKLmudk5v3xEwF0jR5hxIWfbKTQDIRzu5eAu+LHYprz5Cuxy4EeG9/nfEQmtZWN+5radUeEvW5uobfCeidBhblDJaDnOHUrDDRB8hyJt1rKzewFWiEOeyllpaY0A6LhIN4TZYA1pfoVBqDb4TVIzKmSprKkGz5n3S+c+P77NHKmas2ShSr3/1OwGOSvfL/JUs1oIUOdUslLmzE5B/V7mV2VK16KEiDawOJvE4ls1xHzmitQinYVxi8vsCxWkwhhSMy55yFstEU7klp2h/Qf5XQgVviEWIQQo1ldf1hUCjBo02LNZIrjY3e0oDOFAR/3sTA5T02An3Xe5UVFGin5oZGtw0AwUKpTRjtVbmkI1z5qOj42+R8Qxx8paEurgpH+z4GR7yy3X8NqTenQpexVCZCE7b8EGDi6ayBSRYkuzMx7+/gPclQk16kJfwGSmRsP5mTNRKAl6kBEjTu0tU/qiAK+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(19092799006)(52116014)(366016)(38350700014)(56012099003)(18002099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tpaq1RQQksI6V+seAU0Vw1IR5GY4Op6YE45/ydpgB6IN2OxQkyl2DE+g+V3d?=
 =?us-ascii?Q?6aqq+fNtkhSnkQlKpX5q+slQCHexXYHEHWPsIBUFx7AEaj0wttw7lf5iiAOz?=
 =?us-ascii?Q?3jpr3mbwzSWQ5bPa+IXzQ4GmFzul3Zdg6UmJt+76D3oP3uzEtU8qI79APAZX?=
 =?us-ascii?Q?R/Bn69yncTIjN08sDuAxmCznwd6XW9ep4uykIvHQBrHM68NsjEaEfpOn14GB?=
 =?us-ascii?Q?FVgtwg2mjbzNfRQyvDWLmGobyaGBroMEmKIKKLW9+vidvyjp9vu2klYoOit1?=
 =?us-ascii?Q?PK0BT2zUvb1a/xhi5b/5volyX0q6z9/PyOPf1eGeERJ2b6yBYNvlb1e/Ls25?=
 =?us-ascii?Q?kQYDwyTpXNdOibGZs/rJxtOZz7AVUprW+6Vc7TSCm36OkZ0O4rOErIUV7eR9?=
 =?us-ascii?Q?nwYrDNvcI7rKyhkcxQaxPXOahiArQ1kn+VBxTwU6bO/zaqrY45UJn2ob+Eoj?=
 =?us-ascii?Q?F61nQnUZHCvKfV/pifDk3mqIWwaT4enQxPUKlJLL1D9eYEafbPWqeY5OZUfS?=
 =?us-ascii?Q?JWF9/LbjXLemKcyocGIGdoQFo2vm2bR8ZLUj5M0AxQgVzXGohImPWi0BYMCi?=
 =?us-ascii?Q?HFZABziDktPraHyeYwKr12Vwlb0kNDKl7qlbcmicotiKkXMFfPRXr+6ohjGI?=
 =?us-ascii?Q?e2gMfQmK5ATDPHy5JVF/O7uwnr7oyBAeG5/AKWB4hlKsC6PNdakhr0/8FapI?=
 =?us-ascii?Q?57qMG4IejiUKrmKxSCI8jPHYYId8EqwdLGyjB++dCicy9sdMV+rSFjnsAlgz?=
 =?us-ascii?Q?/9xju0OUVtIftpz1Mj3PCkR6i4gcGVHIGawkIXmTowHzeddfuAdY7lTNSJ8R?=
 =?us-ascii?Q?Vk3I2lGoVjymCAANx+Utv1pOU0NJLmnaYOpXeWCKFEtmeDlJf60w5haat21E?=
 =?us-ascii?Q?tfgdNDj5949UjgWh/A3SEdAvqBlIn5PHRthReA1glFuNhOO1jzsz8+rz8KMc?=
 =?us-ascii?Q?Ern4Y9q/xPEd+Ep99ly24ZKukXstghQj0TO08L+qDwcYpnTb57G2mV6dH3B8?=
 =?us-ascii?Q?Pz5VafRUw0SZlnvVx7sat996PFkIMap7ooV+7Gtz94UlES3yjEw6vRIADPts?=
 =?us-ascii?Q?6h0cVHWUkaOiqFlSzxgq8zIzqwdFNU4w1NprmoI4s8aqUhQQ9eC02KW6en5O?=
 =?us-ascii?Q?ij2cqZHEhEDABFraqOW0K7VK/gVxg4DsbZ/azvZUKBcUwnktBC7vEPH2UGzD?=
 =?us-ascii?Q?O3F4sQNUU/5PFKiSgGbahQ2NPsazh/yE8p5uS+Z0iko/eUz5eXWKUhe9QXoB?=
 =?us-ascii?Q?V6O0srlQLI2BXr0jsb3QdMk7DeJyrNz6dFweY6KqnFadD25AwRRf6d3eWbJU?=
 =?us-ascii?Q?5vQVvjSjgrh/AF6z0Cwr/Zhn6JjobXT8EYvKdwCwRX5n0z2Ozi2RyTojqpGQ?=
 =?us-ascii?Q?NSr779/g97ArewRm9NgUbTwu0grNf/ZvUbL3rpdZniZKPSUoEXqDhTkpVNS5?=
 =?us-ascii?Q?Kt5AQmM2AI/yLwZ9xlww5/2PHdbmMicDZIUDtk49XaxBYBRDMtO7sWPLONFc?=
 =?us-ascii?Q?sYNUTKGHaSabx+bfDdAYTs1QTlL8Ud1hMTKezkyiUUA9X7Ofx63Uk9lwwNG6?=
 =?us-ascii?Q?azlOQXPtxhB10CW92xXCFZUllifn+uFycAUPP4F0HwsscNk9FtvHtdTy9pLG?=
 =?us-ascii?Q?V0eHq2J6UyqnstUJiblcpTxSWHUo3PVxjCBu2+KZTjBzC9YuIkJUcdCC7taA?=
 =?us-ascii?Q?LzgXvZ1v7EIfkzJTs5KUkbB6VuZXIL4e974r5wNrQ0oYIaqqXkjmGQ79F1Y6?=
 =?us-ascii?Q?CrY00Vt9eg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4205290-f190-4c88-0cea-08deb0674c0a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 20:44:43.8860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/32O+SZ3Tzn6FhQr7oYu3b1bCIf3+htVkFXa01dhGZ2N18qOIngI8QZRvNysR2VfIwp6XmaG0P92bgqGbe6tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10142
X-Rspamd-Queue-Id: 85338529934
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10386-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com,vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,renesas.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 03:12:06PM +0300, Claudiu Beznea wrote:
> Add a helper function to compute the lmdesc address. This makes the
> code easier to understand, and the helper will be used in subsequent
> patches.


Add a helper function rz_dmac_lmdesc_addr() to compute the lmdesc address
to make code easier to understand, and ...

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
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
>  drivers/dma/sh/rz-dmac.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 40ddf534c094..c48858b68dee 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -259,6 +259,12 @@ static void rz_lmdesc_setup(struct rz_dmac_chan *channel,
>   * Descriptors preparation
>   */
>
> +static u32 rz_dmac_lmdesc_addr(struct rz_dmac_chan *channel, struct rz_lmdesc *lmdesc)
> +{
> +	return channel->lmdesc.base_dma +
> +	       (sizeof(struct rz_lmdesc) * (lmdesc - channel->lmdesc.base));
> +}
> +
>  static void rz_dmac_lmdesc_recycle(struct rz_dmac_chan *channel)
>  {
>  	struct rz_lmdesc *lmdesc = channel->lmdesc.head;
> @@ -284,9 +290,7 @@ static void rz_dmac_enable_hw(struct rz_dmac_chan *channel)
>
>  	rz_dmac_lmdesc_recycle(channel);
>
> -	nxla = channel->lmdesc.base_dma +
> -		(sizeof(struct rz_lmdesc) * (channel->lmdesc.head -
> -					     channel->lmdesc.base));
> +	nxla = rz_dmac_lmdesc_addr(channel, channel->lmdesc.head);
>
>  	chstat = rz_dmac_ch_readl(channel, CHSTAT, 1);
>  	if (!(chstat & CHSTAT_EN)) {
> --
> 2.43.0
>

