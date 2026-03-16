Return-Path: <dmaengine+bounces-9455-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id y4E1ETOYuGmsgQEAu9opvQ
	(envelope-from <dmaengine+bounces-9455-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 00:54:27 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A8F2A21B4
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 00:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F2B8303674E
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 23:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F32635B639;
	Mon, 16 Mar 2026 23:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TdFfTbPk"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010004.outbound.protection.outlook.com [52.101.69.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D191037AA6D;
	Mon, 16 Mar 2026 23:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773705240; cv=fail; b=Cr0jsa7B5lahsk9VccWzhvI268fpAh7kmDoWOsmkBdK45aL12liIHocOOev/wgTIxHdlV42Z2CgboNPrPu0pI9dm4/RjSdhSZ03P19JzWqCoYpstt2b3d3ExNnunmYCq8dO0oiDlnTLDnt8K/GAgWKR3bRJ7NCOUNcWccnf0tII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773705240; c=relaxed/simple;
	bh=6n1eGal0RO9pJ4oFTFfulXNmeToCrbuJU5TlA6vbAVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cOQEjLkRN5Zx07tYUsTFzW71OS7EztIqM6QLq1NI/9lJ2rrbzu+8da8O7VBrUq4oFxy6R9HYoWrdk0GVa5pkyiDfNjj3l8xiDua03KxhOJINzslDQYHyixDP/UHgzz5XbQqlEyX/Pl7K6zQPnsk5eiCr615RR0ENeDprck7sxEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TdFfTbPk; arc=fail smtp.client-ip=52.101.69.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SjHRuA8StEAy1WhMtqeLNLvwtl1PyfzioAMLpqQVOCllO0ZhJCUgOmEiPf3ozS4kFx06kUlnrVu/MF9QEBJEcacuTWpTwQpnnp8nh064P4R6TsOwiNLlZuOeHGc8NybElhXE6SIIB/UWze3Q9ec8gdj671g+RKHIXUL7mrII0jPykOJvXItHntN65C10GkYxJ0Un94pS7u8J5IS1KPADqaBRTzXm8Sp1MF0g1kM3+DzdtZbpjZdAHe/s0r12uvDXJxQOBfjNMYdiUNzLUDAhCgwwbgoFncw6j2JSmFy4z51BUDVVNxwbOWvGcLHpCLTZuiD33eSu90h/A7pBA+nUGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YY3TgUDUaIMAXDSLbib8NhR/NzEVYSer13dnxeKXEiY=;
 b=hHxsomr2OUFf7F+sX7kcnfcBOLeM5pVFc23SxhyC9CkA+7Bo2KWg7q+epn5CoCeAhHXE8nO8z/BpLAKEF+Z4Kx/0zHmazCghY5ir35iSVpQkqDkJhISPmqSPjHeOl26mMOWA+yLRXtrxvS+WV8cz4g03krrK5bhcx1namAVWH+BSVv7yIqDWTmoa1oV8bER/jvdT16+n5StdpkopvWYzGy417JENt41keiHM1xCB93Nwoelnt0mu4NEg6eg/4NxhymJvjSF0QRxmgxHVe+1KGB4QZdXdYXkpn1sucGV5X9YgmoiQwd1oQOybEkrvRw2y512jOCQ5dzEDkmGQ0YPsMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YY3TgUDUaIMAXDSLbib8NhR/NzEVYSer13dnxeKXEiY=;
 b=TdFfTbPk8sGgFT8D96dbPYhNuOD2Cg14l7cMkGpa1GMWU/+0DY5lQ3d/s6ObygGXeHnMr5Ji/TIYx9B7UWjLUPr8pj/wpBTe+bKRa6DzZrkMknSzdm18Y+MAn3O0ocEuuVomoRWVHJDu+XVEnquCNIuOZszm6SdudlgTHOnW3Z7+PIURIEUIbrNWBwolBmIf1kII3foHjsrxRq/y8GKEqreNoYwgWa7o7KYVGjxU+XiVTup2+IhY5BWp4oUMcmtaNs2Q6v6QuPnKgqX/IW5P605bqws2oGAf9RBCLB8vF6MAHKrhCY/jsZoUZDEGLzdiBAUoulkZJ7YwoUZsLCjqjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV2PR04MB11301.eurprd04.prod.outlook.com (2603:10a6:150:2b2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Mon, 16 Mar
 2026 23:53:30 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9700.010; Mon, 16 Mar 2026
 23:53:46 +0000
Date: Mon, 16 Mar 2026 19:53:46 -0400
From: Frank Li <Frank.li@nxp.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, geert+renesas@glider.be,
	biju.das.jz@bp.renesas.com, john.madieu.xa@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v10 6/8] dmaengine: sh: rz-dmac: Use rz_lmdesc_setup() to
 invalidate descriptors
Message-ID: <abiYCmERlkzbPmyN@lizhi-Precision-Tower-5810>
References: <20260316133252.240348-1-claudiu.beznea.uj@bp.renesas.com>
 <20260316133252.240348-7-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316133252.240348-7-claudiu.beznea.uj@bp.renesas.com>
X-ClientProxiedBy: PH7PR10CA0003.namprd10.prod.outlook.com
 (2603:10b6:510:23d::24) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV2PR04MB11301:EE_
X-MS-Office365-Filtering-Correlation-Id: cef81dfc-7630-4ca3-fba8-08de83b7430e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|7416014|376014|52116014|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mw0Cfnet4wA/Xu7aJDFio2/dnHcTIZgHAxwg46aHSkVLcjeMrg2owDz3Igo6IoBz+kdphkkwKKJUfbXJbKkzxFTEHCjeFb3/9lL9jj8N2i+0qP9+QJg9TOaGci/22GDZRfIRsENHJM0hUHKHVqcDHLHSGLzrDlFdiDjqKhdd4bwxzUljSXzi001P2DbUg19r5FOxgtbhUjMaHJjFTZYoECnH0+8bF7vi56UasLDEvUnWmEHR8yM1cn7gVMygDuoP0QuIw+BKvfnUHW3Gl+bsDGBC6y8n0YFF1PJ9PPPwobVC5vVLFg6cvt4mRCI3VnomN4oF4fLYmjPFZnwK066G5JG1bOGDFIsv/gbWoJIV79YpS9A1qF6kkcxI69HWhP3g8+o5odNwIr6EHmfRPBwQW0wozahEFicP9qp4EoW9N4tUjJ5VF+k6WNp6jxi/hqn9NLJubSvj2OJjCzK1IoQDiM2ChMbWuKVPXhBIPianJw5asCTP8WoioMHKBuaj/olwnRh8V1DGl8YP5wnRSRjCL1FRhmOdubrqeCte/BGCdXevuAjqtBdSbs8Nan+ydCp+iY5N8PtttgVAFyRh1tIbomhcGNSJG5GGcrr6bJ0Zr2OHE56AppP4mlXsot/LUCfr6SlVwMGSfCPlsyd/m+Yv+n42jCYZsOjs3qaavUwnCCIhLW+X1Rb+L9eFB8c4fKN3JeIiSUZCeo8bUpcUlUC9Nj8vpe4EVp/HXVLiLqH+qHEW8vsscdEEQeTXLYjR0SwX3psjRPhXrVGbFRrWIjqKSOT7TtT6W2GeKOCZkndcjRA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Spjfh6VvMsZMUp2fFEe9fldsax44Td9ipw66JqoVvezeeGlv5Hvj8wlzqqDI?=
 =?us-ascii?Q?6hWIbQTAMvJSFlNovkPJDD0jYiHUy2lvzQZBjowLMc/Wem1pT1MMIcjApgl1?=
 =?us-ascii?Q?q0y8ktHDZuldMa/sa9ZfwIC67SE4lG24uY2Rj+c/eSEcaCqbyT9Wx1Fxupzv?=
 =?us-ascii?Q?qjlnFJykSeFkJzq4qJH+wW7A6KTcdDvxlwketzuCRlPMlSM7f0sFfluh8Lrx?=
 =?us-ascii?Q?XwEaezkRAC93npF4dj345BSYYw9M+j9/VvTsVW5A+yFw4Cp0SOyoeD0WcWHo?=
 =?us-ascii?Q?zxLco+XzkbA7GBBBKXtqNQvj524K914OpNI74R0TK6SAqlHu55YxSvmEEn+Y?=
 =?us-ascii?Q?rXZz0lbs5JiElDceR5NoiVLKzOUHVQtSy4kChN96+B9vI1QYeJ5pioHnWvVy?=
 =?us-ascii?Q?dhD8uRZtRXGjLLoYenoxxOo/JSB2QkfacFtO35uzW03+5EPgPJWoe8XwvlCG?=
 =?us-ascii?Q?FkbfVzjsKo/a/d82HIqGe+Mr4CaWcnSxSbtX2k/mibEUINyoUKvMrDkhxOGF?=
 =?us-ascii?Q?WvDgV7qDhWARE6E5DcPcO/S7NHDb9kfMYqMATAjNQ7x1qCx4HsA2OdzxBJu+?=
 =?us-ascii?Q?E2S3tj2uzdnlmNt5ExInOzoLPnaH+SN7GbpcF52+XMaEhZ2/c3sxAQIO6D4G?=
 =?us-ascii?Q?RHMyTs1uJUZeSri0Rxhy0ygwgp8mD07fmLCjEfHFflegK+FYqygweaGXQwRe?=
 =?us-ascii?Q?OSFMj1S82rxYxtnI0BIkQ9IsCeUJ3iDrE7CK8jAX0cATw+pkXMbAR0lm+g9o?=
 =?us-ascii?Q?Gm2zXUkOqV/jPSL6PNe6RO3uz/Fmz9CmA/JSCbzFyJkii7mvqrqkVvvrxpmW?=
 =?us-ascii?Q?wvg65XjTZ5nROEUT99SzBWU90HVV3FkptQW7H284acZXiDVj4T/jhX5nCdXM?=
 =?us-ascii?Q?tdBJF1rWW/sN3bz3v146B+8W4PtOJ+mWiG/pF70hvK7WDndUqkNN9n0v24Th?=
 =?us-ascii?Q?RNhNQKS4PrinZYriGThb+TtPFHTb/pVVxCHSrvIVT+/gpQaQWoPne0iHHMUm?=
 =?us-ascii?Q?RWBb02cF2ZvFpdBvPD/UKYk1nq0X+p7HmvIC4vNdfhiXxqxWZJmdigC5jYZ5?=
 =?us-ascii?Q?+7XGuVWFcVoFV1ceZIRKwEQYJVCn9T6O1dI4BnG3XYf+Iw/DhrXy9/FJKcOL?=
 =?us-ascii?Q?/pam6HSfTIrUNO88+1uBGTxFDSobKLbMoB5a8LX354sSwKGWhBW3hLPmuhDp?=
 =?us-ascii?Q?bppuMNK8JH+OOfHMJsK4gVvFGIai4IJRdt8r9YF2EnSE8pwKwDj5QrQ9M5UJ?=
 =?us-ascii?Q?cx1jFqTlt/ayLZw4iCR01UrTe1xlh8rBlCMQuS5nTwE1SVxSZOJaseJ70GCO?=
 =?us-ascii?Q?NjXKMTwemHq6UAB0lirzlXumD4kWIZgLCH2hhN0SOpaMJ1/VrRfkG0uUks73?=
 =?us-ascii?Q?zrFeBxlKq4KSTq5hyD5UdI7XRdX+TdcEYU3Xi9mKj8nECLfcn+T5uioLc6Fs?=
 =?us-ascii?Q?3zx2gX8N4QcIIvmDEnHxvkBvmfXNLjoq7uj79cW+7LSyo+qej4qX6CpSveeu?=
 =?us-ascii?Q?ZnxXOiimaiE0MlbFIIcV/or5garJyemq0zekAo72mHCyTxVX/sgdQ5GO70lw?=
 =?us-ascii?Q?P2LB/SfQDd7zw7hAS0RcgEHnfqjYaZzGKVilCwvCu1MkxtER63Sg/EWd+x5x?=
 =?us-ascii?Q?EqFajwY21BD0o7djMrchF6dnjykWT0atRlR9N1yIREC59QjCebHPt4d2qcnD?=
 =?us-ascii?Q?+kcPGXGwvXlfKARBpKDwiSkZoUVC3mU3tXAbkNkkbN2s3b6Z?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cef81dfc-7630-4ca3-fba8-08de83b7430e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 23:53:46.3237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +G9N2ls//kn3M8rUkY9NtSjluWgefLNIV8YabqfWTH3cyDR+Qx0MGA3fuL0vtAcStp+zIi72g6T1MZH/2o27qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11301
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9455-lists,dmaengine=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email]
X-Rspamd-Queue-Id: 94A8F2A21B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 03:32:50PM +0200, Claudiu Beznea wrote:
> From: John Madieu <john.madieu.xa@bp.renesas.com>
>
> rz_lmdesc_setup() invalidates DMA descriptors more comprehensively.
> It resets the base, head, and tail pointers of the descriptor list and
> clears the descriptor headers and their NXLA pointers. Use
> rz_lmdesc_setup() instead of open-coding parts of its logic.
>
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> Changes in v10:
> - none, this patch is new and replaces the patch 6/8
>   ("dmaengine: sh: rz-dmac: Add rz_dmac_invalidate_lmdesc()") from v9
>
>  drivers/dma/sh/rz-dmac.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index eca62d9e9772..6bfa77844e02 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -460,15 +460,12 @@ static void rz_dmac_free_chan_resources(struct dma_chan *chan)
>  {
>  	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
>  	struct rz_dmac *dmac = to_rz_dmac(chan->device);
> -	struct rz_lmdesc *lmdesc = channel->lmdesc.base;
>  	struct rz_dmac_desc *desc, *_desc;
>  	unsigned long flags;
> -	unsigned int i;
>
>  	spin_lock_irqsave(&channel->vc.lock, flags);
>
> -	for (i = 0; i < DMAC_NR_LMDESC; i++)
> -		lmdesc[i].header = 0;
> +	rz_lmdesc_setup(channel, channel->lmdesc.base);
>
>  	rz_dmac_disable_hw(channel);
>  	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
> @@ -560,15 +557,12 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>  static int rz_dmac_terminate_all(struct dma_chan *chan)
>  {
>  	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
> -	struct rz_lmdesc *lmdesc = channel->lmdesc.base;
>  	unsigned long flags;
> -	unsigned int i;
>  	LIST_HEAD(head);
>
>  	spin_lock_irqsave(&channel->vc.lock, flags);
>  	rz_dmac_disable_hw(channel);
> -	for (i = 0; i < DMAC_NR_LMDESC; i++)
> -		lmdesc[i].header = 0;
> +	rz_lmdesc_setup(channel, channel->lmdesc.base);
>
>  	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
>  	list_splice_tail_init(&channel->ld_queue, &channel->ld_free);
> --
> 2.43.0
>

