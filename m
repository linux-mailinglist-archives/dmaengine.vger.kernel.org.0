Return-Path: <dmaengine+bounces-9087-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACs7MAwkn2mPZAQAu9opvQ
	(envelope-from <dmaengine+bounces-9087-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 17:32:12 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E6519AB2B
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 17:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 397A53009F30
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 16:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06961263C7F;
	Wed, 25 Feb 2026 16:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LzR/t6yq"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011031.outbound.protection.outlook.com [40.107.130.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5D31F37D4;
	Wed, 25 Feb 2026 16:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772036468; cv=fail; b=dAG1cO86h5sUjNwoshS6fkOx7rV71KwC8kT1OBI3sA8YoIigIo7KFsw880HwPxl4M05taNfKScyZHD6SUUqms3ffHCmaNZm8uEg4OBtBqszI/lP8t5bwEmIu6WuR8DkJyoNAaIn2duUaWeL66KFuMa6IRfFAx/bpiof1fSmNBAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772036468; c=relaxed/simple;
	bh=c3xeT6+5Jb4HpyhYf3HttmgICVqhy3q0ObOrSiQm2/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BYfANtzNtYFVNJMYQl/eSgXoumRClPFxCSbssg947zPPhJvfcm4X4m0kyPkzjjS/OGGjPfTHkaJtOiZ3RjV6ojr++6pzc79ckL78MLjOvQcBXTgVaduBqxQorfhk/xIjMmgYbgM3OCjBTX3qCNacXG7aO6J/cx5w7CWgSYEnnfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LzR/t6yq; arc=fail smtp.client-ip=40.107.130.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fb/kdkSGCHsck9h8PT8eti3vabRB8dzNTHLD+B87JZbomwdhnmovGHd0dvNMs39hu1NNCVpzE8I+1B0J0GxF9t5PpWCMWQLpZofcVsf0UFP38PB+MyuZZ8cFPtTDac34l1w+9vC4VDhNfzxgQTl9szoR35wbVoLbRFrtyg+OyStPlG7AIzBbWT84yBVqu4iKlADYpFaAc8+FJGd8bnloUgKBj/2JINVHSlXpPXLsjmH4o6EX3CRcekrbHSt0roB6PZPHa8HpgvUFNSVIeOZ/5ROzzgNYJtjvPcSxlIagJCLOjRYRUwrgYB8M+gpOtb8UW88Nj3Ti5iCLfCUWPDmiWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cm8cuDFyvRyF8e/ysZdXFG5+LligsbhBhRQpSMM6O4s=;
 b=J3xlwATr1CisOKFBD/Kg0+fdTdOHMmKWd0biXyKZxy5SfVxNfy97QYlavVVv4saHjW6yBMXSuFHz80dJ+d6qEgzTiCqkdMhbyY0E0KpEbasRAC1X3909xOgNx1EsyQR5wyKXYYicsD3nGDbGn/Smg0MLQes1vl+IGssR2+tVjJhmmesHhkTokoXq+yX6e3vuDvROcQU6LnBbtKPJ04Omod5ndZehI00f8JHnp0rCJChmjkVYK/yyvRVaKjjeKNIOv/OCYE5vjhIEhxtG8QxU2DEIReOgYu5vBDPLGiTuxZ7+IM79wUG8jSjokR58XAvnGjgQmvcN2/XhNViY/+l7Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cm8cuDFyvRyF8e/ysZdXFG5+LligsbhBhRQpSMM6O4s=;
 b=LzR/t6yq6+fC/gfnqpRV/iLmBLJjc5n6o0bi88jPyfWqmsPyHAkcvn0kcfxoUjz4F3nmUJxZB/rN6QJ7fHhb9K0Z5mRdHJVDd1ulMKQixd9OXBIfwOuHNEmOg1YvuGxx93RJhCagzKv4CCMaL25A5OYzkoEX/DObNB4F2RfXf1n+3aFJ4nq+ABP0hb6TwixjGs/kD2aLnY4neKJjC08FHfKbiQMkqDOGmwPLS/axFtqftGSgpQMmctvRBsMqKBvA7RjDK1rq4Oqav4pnSGrM+q1mHwA4HerqHjEH0vU3qiyErXa55XvE/Y5Kmaf++Dqs1wBebSikLqF4PMRXYpEggA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM9PR04MB8649.eurprd04.prod.outlook.com (2603:10a6:20b:43c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 16:21:04 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 16:21:04 +0000
Date: Wed, 25 Feb 2026 11:20:58 -0500
From: Frank Li <Frank.li@nxp.com>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: vkoul@kernel.org, geert+renesas@glider.be, biju.das.jz@bp.renesas.com,
	fabrizio.castro.jz@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v8 3/8] dmaengine: sh: rz-dmac: Drop read of CHCTRL
 register
Message-ID: <aZ8haq7RLgmxsifK@lizhi-Precision-Tower-5810>
References: <20260120133330.3738850-1-claudiu.beznea.uj@bp.renesas.com>
 <20260120133330.3738850-4-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120133330.3738850-4-claudiu.beznea.uj@bp.renesas.com>
X-ClientProxiedBy: PH8P220CA0032.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::10) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM9PR04MB8649:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ef16df4-bcc2-4873-034e-08de7489df96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	9KHfD8FYIaTnWk5EdZz4+8WL8EBTd3C5DBI0dJWRd9z0P1SwH4WN/irSeondNAaoLZdHGDA7dyTLBZeDFwW8CK/ITe8Fko1zzs0NSOaGYZ4GncixX6WWvdcXIIrYl557/GPlyX0sxXO7r3+qFDEOMjoWO0GsiWtkY7wBue4SWY7a0oa3+qasbpDcJzEWtaPAbSTFKZYmh1gbcu5aXTUJv+CAQXVqS5ecVVvND2Fz3zoQ6fcsoxxb0PYjtlaYG93k9GMoKEJokBk2uI4AsYyvuPtC0+p7c36Dj1Z/R5tA6VpZufMRFwKJn9ACniu3p2AU27ZnutmFneeDM7ymrhyJx/KuruDYlYL7aRfpyJZ85ZicVb9Pi1sUOONkkP/rTsg9USOPI0qLkcZ24xBfB5dsX7oKDgfo7eCC1rK6NdpOK3JRBS+t/Z64jtKGIxhOIxrU4MuKl63eveeEnVTdg5uNUKP2G5VFe0DrbZ6ZzLAstGUv4JxS+yPr34y2TFPVGJXOQZgzGP81LXPvOTK8oySgn+wOCv7rOlQjo07lD3CHp4WTBDKfauICi83bRRn8O0E7QdXl8zgUCKqk0S7oJntY2M2lJf27ekWrnH3bZbOxAqDtVUy1hsoMFi0PrAZRnGsmRUSQ/XVJWL13KozdOaPN/JPK3c4k+U/JLD9JnPVY1nGK4+m4zeUl0vH4iDF7RNsqwAT3EnrKkZqsAoxJMh4YAOHnMNjfkXdfKS4d60ppy+Z7VIDP+qcY1+L2lh4/rfDxXB9JV7UOS/ROLmPzWql620Eqq7VUUQsg56l2pTEyZ8Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R1AOCrzpyiPulScTjEsQAewxjEZxiwTYAkmUTnvsIu9ajC1wq0TRXYBCQsgw?=
 =?us-ascii?Q?FRBM6Gp2lXkA+BAR5fn3NN+quCLyHCZWl/S91qr8uzoWdzE9LdUD4UDVMFyQ?=
 =?us-ascii?Q?F1EsoBnqh35aS1VZWakiirJeTAHB5Ivth8qFVY1syKtWkeYCjSboZ31Cs5dN?=
 =?us-ascii?Q?3gc47+VnQxz/4/uF+UpFGqKZ7sUXuZJe8MFgj/uIRqAWda5v/1rOM89S2ixD?=
 =?us-ascii?Q?h8kEFD6JtQ1EHBvYhm9HzYVtUk95WrI6J2XJ/sSS6zRg3rXqjYzpy1CFvZnb?=
 =?us-ascii?Q?TbMVzoSNBWHG4dSL9E4Zd7IEZI9TPhJe36aMoDBnawQ/yQMQFLGjBqKxS6wK?=
 =?us-ascii?Q?BOTeuK9orCxoe7MSCL17Uwx9MFz93Mgg1blBKNifFY6xXVkSRPcMfdC/9fQ8?=
 =?us-ascii?Q?FkSuwb5OTeSlCsoV7xNz2qev+UJtBST8HqBdm+HTuiLfaQ+Lp0B7X6+ofGg7?=
 =?us-ascii?Q?e4sNk55SrGr3eWdF7LOfRyaKlE9HH3p1qLTXWeGLmbfc73b4ZgqVH7l2959h?=
 =?us-ascii?Q?Nm8lv4TK5PVpoaHF/AdwtsS2Txc74ZEM0waOfV5aN8MkPFKiT0zuq7a5ioGr?=
 =?us-ascii?Q?lsmGJEKccSNnr0bDzTNotVeNbiV91jmkeSnPIgeD62elGdI2s8actQ2vNoss?=
 =?us-ascii?Q?Zaj1RXvqSojkBEiSeT3caR3xObE0xOasXELEGlXnYix+o3darg8zAAfYhLd0?=
 =?us-ascii?Q?2iZ4FCqggFIrxWpdhmEntJO3D2VAY9bB9ji2u97xw/m/AV9fgwuDyQ7SId43?=
 =?us-ascii?Q?QnYEBhJysyUgSdEALPD9mEgr8uE6MYmYl6UT2YHSfXVKB/RA+skF5mBh8nW1?=
 =?us-ascii?Q?94OYHvqcw23Gqor3ELxYF6o0BQFZQ7r/V2uShtjpikG/YGZw7j/+6aDA/uuK?=
 =?us-ascii?Q?1h0Cyti87vPUlsE+Ca8yjlDjJZkZ6nZ9uQZVQmBLaqRwZ0xrQQU+y29so4nF?=
 =?us-ascii?Q?ddbGUpfjCwpG6HXwxIhZjAchz/hDC9GcW2719Pc5OiQlK5fkV+Jr8cifFWxS?=
 =?us-ascii?Q?JpT4G0LRY1fvQwdN5JlGx0EjuDUQQn3VzwnGjODBhASfKgDmpIlB9ZH9xhsg?=
 =?us-ascii?Q?N55YqHv1Kq9DEQqLgCag+ERfajm9L2IJZcDNwpno8zzlbcco1FEDzoygwKw1?=
 =?us-ascii?Q?sHv7VdNQuj8jJiFpqFsnkG8TIJqvwm/aSQYaJ8ZK1C8I4h4XhiKBEdBTNDxQ?=
 =?us-ascii?Q?674gZXWKYVjcNjvCCqMQdf10ey+avBpzcmgIfa+leXc+SmiWEfxr1oGZIaB0?=
 =?us-ascii?Q?esAHGA6akaVHuSutAGTPTgUbtLlEEdepvGeTLAyWJxIqkxBuHhefTvpNn80G?=
 =?us-ascii?Q?vmhowSj1DdE0lk5QeWGiwrft3gsdWe5gLfUX83pvvgtDaJbWT5uKqtudgdT5?=
 =?us-ascii?Q?M0m/I24aNlWJAIf+zDdzHCxqsn+IlbogpxVI0djtC+XnFqVGEaogV/QhQd50?=
 =?us-ascii?Q?uGRSKsJNKyCqS0+FmESjYO3TDRGISsrrEA2hxq5Aj1EM7hx5DYf1EGn9MAcV?=
 =?us-ascii?Q?HikSdrqdOP9psJZY6IJia624JKTYKuRjl3UY2Usf1nuZkByZYLJeZ5T6UHoD?=
 =?us-ascii?Q?rqTKO5+w26W1X0NoDq1yOvhgewlHaXOALAFH2epK4F7WCMhrnCwsYQHaDmVl?=
 =?us-ascii?Q?Yp5qwGDsJAJw15m3UUjoiqSBzQ1wIGoA9lNQLEJ9lRPQn/RvnWzP/yCXXCkf?=
 =?us-ascii?Q?1txTnsaRNxulBXhLwvV55xpe7Dp4++xYddt/5X+NZCzPPlpE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef16df4-bcc2-4873-034e-08de7489df96
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 16:21:04.7457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: af2I5wHSUbi6ZLNtyriliK2qxfBD0j0LRCMCPJREg3IRPIdT52cHyuBzPOHMkHIIXUe8ZM2h7C0USh2pHUPlQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8649
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9087-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,renesas.com:email,nxp.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: 87E6519AB2B
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 03:33:25PM +0200, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The CHCTRL register has 11 bits that can be updated by software. The
> documentation for all these bits states the following:
> - A read operation results in 0 being read
> - Writing zero does not affect the operation
>
> All bits in the CHCTRL register accessible by software are set and clear
> bits.
>
> The documentation for the CLREND bit of CHCTRL states:
> Setting this bit to 1 can clear the END bit of the CHSTAT_n/nS register.
> Also, the DMA transfer end interrupt is cleared. An attempt to read this
> bit results in 0 being read.
> 1: Clears the END bit.
> 0: Does not affect the operation.
>
> Since writing zero to any bit in this register does not affect controller
> operation and reads always return zero, there is no need to perform
> read-modify-write accesses to set the CLREND bit. Drop the read of the
> CHCTRL register.
>
> Also, since setting the CLREND bit does not interact with other
> functionalities exposed through this register and only clears the END
> interrupt, there is no need to lock around this operation. Add a comment
> to document this.
>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> Changes in v8:
> - none
>
> Changes in v7:
> - collected tags
>
> Changes in v6:
> - none, this patch is new
>
>  drivers/dma/sh/rz-dmac.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index c0f1e77996bd..bb9ca19cf784 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -697,7 +697,7 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_chan *channel)
>  {
>  	struct dma_chan *chan = &channel->vc.chan;
>  	struct rz_dmac *dmac = to_rz_dmac(chan->device);
> -	u32 chstat, chctrl;
> +	u32 chstat;
>
>  	chstat = rz_dmac_ch_readl(channel, CHSTAT, 1);
>  	if (chstat & CHSTAT_ER) {
> @@ -709,8 +709,11 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_chan *channel)
>  		goto done;
>  	}
>
> -	chctrl = rz_dmac_ch_readl(channel, CHCTRL, 1);
> -	rz_dmac_ch_writel(channel, chctrl | CHCTRL_CLREND, CHCTRL, 1);
> +	/*
> +	 * No need to lock. This just clears the END interrupt. Writing
> +	 * zeros to CHCTRL is just ignored by HW.
> +	 */
> +	rz_dmac_ch_writel(channel, CHCTRL_CLREND, CHCTRL, 1);
>  done:
>  	return;
>  }
> --
> 2.43.0
>

