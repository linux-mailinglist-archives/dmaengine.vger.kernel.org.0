Return-Path: <dmaengine+bounces-10575-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBtrFTNCDmrV9QUAu9opvQ
	(envelope-from <dmaengine+bounces-10575-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 01:22:27 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B051759CB1E
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 01:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5267232A788D
	for <lists+dmaengine@lfdr.de>; Wed, 20 May 2026 21:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58A233A9E2;
	Wed, 20 May 2026 21:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DkzKKYMO"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011008.outbound.protection.outlook.com [52.101.70.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D5232FA29;
	Wed, 20 May 2026 21:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779312607; cv=fail; b=QTyBAqyACbBLfvzSxto/kGs6/pW+aTqSCtpZXb15pAEfp4Ks/TBJY0S6VKt2qwYAlDZpMlWRligPyoaZDKWBBmYxSjyVZgeg5ZamKBCBLqlAWiqsCrONwFjPoDZNYTuCPpFlye/PABMdG86SwXKDhSoVG7BKWlLKIZCUyo731Jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779312607; c=relaxed/simple;
	bh=fwJW8cgChL1c9xmaC1cjb6w+ro+ubwVuknSEnOrzb/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XgQMCewPjND6kclXSa8axgfrkf8H2PboJ+a/T7AYQseFfEZWmeaWCBuROhJM4N83B+SeWrI+ue9UnzrmSlTmyfEHiHkj+XMcYXUXSB9L81T/sRZNoJPNWZow5yYO0+Phm+NLJ0cfSNlhNW4Prv51NADrKPrBqfE9cKSrUMsYSnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DkzKKYMO; arc=fail smtp.client-ip=52.101.70.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RB4JxSh+2WmLXzzZmXbn+UdK3x++Msxkf3KIJLJ/GqxYxfPwcumDsrHOp2B70WLIjSGcvJ2n9AP+vOGw34t2wYxzT+q5FZVnPh8hKeask51/g5ffv7O6XZnx+455es9MJFRZUjs/RopdYrj3xzW4yRNL4QDFsv/W3VgX3a/RaNTK9cPxDE5YlgPizSBbTqv8kEAYBhTi2K+1RJj+ZOkqBDBj7IVaCfGiH9h5nNyEMg5tfPrCPesactOrQ7KvXZifHPVBwR//6+xhgz2CKBYNv3F50N2DQLx4DUHDfXQt9vYvaUWTscwjSWYoJ37le6kTzL+eeCI8I6lgbuExjCEpMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pg5XhWa1MrS737/cCTIVGgj2u7NaKiLQHypPkGeMQmw=;
 b=Px/Zq0OzxTBJXUhcUx9m0qGEeQ9EbgGXWjUaBIqhn5JlRIPrKfF4Q7OtkM2RO1h06eYzHcAUgYhSu/XEmo2jQ8Hsgi95B4O7pH6Ha0uyEa3c+BfKzUNxcZsW/f3CJACE2eR488QdIcwKHLT39rhgnPHL66dJHjpzHF3FdzcT2ggOXQLATA8tuVaST3MlEXRtw/mNtZwwg9UcSAI9P6h6TuglFyHXITlDW3pkypesup3nuyMHUGsLuCEETQ00bQS1L11B9457C5mXz8GO9ht5+riB5hQuMXZ1ELbbG1RgsSLB+4zxetrVsC6JnFSTCpbJsksjupJ65p3OYabCYJQm4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pg5XhWa1MrS737/cCTIVGgj2u7NaKiLQHypPkGeMQmw=;
 b=DkzKKYMO8ko4xRBkuYCyiSckEsP7tH8VA/iCtzl/zHTpE2V87R1Zky345O6SlwAYnBH8mzZ/5Aq8T9AC3X3r4MBtv78amv7iGHP5YXFBCYHF6bgZax++gcwtJVhUQEJ/VYfuEnh4gFV5L9uj2yPGmBPOHdbMLqB5HtsaoO5x5e1VPis91U1d17OXUm+d4f03w3IQNGVk3yknnDSLm0XSek07emGzHMJEpTnmXZg/vRmt5WwGXuO4lTI9+5oWVO973fofwITDvpDEsp0Gur0vC6+gnFtvuAVyfqXmaLbcJBIdgGjQyz7BLBkZgVG8OJ4/BDrhl/Pt/fiSJWZComBbRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS8PR04MB8468.eurprd04.prod.outlook.com (2603:10a6:20b:34b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Wed, 20 May
 2026 21:30:02 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 21:30:01 +0000
Date: Wed, 20 May 2026 17:29:55 -0400
From: Frank Li <Frank.li@nxp.com>
To: tze.yee.ng@altera.com
Cc: Olivier Dautricourt <olivierdautricourt@gmail.com>,
	Stefan Roese <sr@denx.de>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>,
	Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
Subject: Re: [PATCH] dma: altera-msgdma: Replace memcpy with io32write in
 msgdma_copy_one
Message-ID: <ag4n0ycl1KB3p0hP@lizhi-Precision-Tower-5810>
References: <4586c39b43aa3b9480989940fe905dac40c8cefc.1779173156.git.tze.yee.ng@altera.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4586c39b43aa3b9480989940fe905dac40c8cefc.1779173156.git.tze.yee.ng@altera.com>
X-ClientProxiedBy: SN7PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:806:f2::31) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS8PR04MB8468:EE_
X-MS-Office365-Filtering-Correlation-Id: fb7031d1-09da-4d1b-744d-08deb6b6f35a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|19092799006|1800799024|366016|11063799006|18002099003|22082099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	XETckHOeBu1L1V4WdoOSxvcrQmLQGykaw7Dw1IN9ZZ15kBKTMSpvfXzyjt3EDbI8e7TTIqCyrS6ClE66Dxj4zBLObg5cuhwa83vGjK1WFoR9iMsOBCST/w5+Cou/781YmTCXWeYnihvUO2X8k8OMODQxxhq6D/aNWdTdLh4eG+HFMcKZz8mVFU/4BSqoBytwKWVxoZaTQWsZvgHeCopKoj5mxh4axJYa/dT0HnCQbui0QAMYh3YS+d5BEguY4OgviXksTvHPPV+gUheyjnTkg0GpGPNJ21yIEyM8KkjUUSktebc3NYxjCCK11qUQQMrtNHSFKX77vD7wRJb4dF9wf85H4/5CxI3G1fk8SSDK2Z/Qepg9RHoIdF1Oxtt7+7rUzt7kWH02TDX9yDCqMuavEOxZJnHXCD0ZkJG5so5qVuIFy6wI5wegfSXyNUHw7Gp/RYNRXJX5icYY2m3yNJPacJOH72NJdBIlcQk9zjDKPA1aNiC4vSEE1anJ+ySlI4au/mUwJdbSNl1nRkRqnUvuMZeoGT6SgfmbDs32f31LHtwJgQ4td/E2ZYV9773cRjKNRQ9ygKuUanXBCPNLX7qhTm/tsIDTZrvURWqP7UZE4vGrC4QhGjetaa6TULQYdVJLBJ70rq1z6rcqkDEprP7eDFgj2BX9v1bo1zXNQaOtnSpckism5eVOSRdCzsboqUyKRkcLgR/yu6+cGprdRKBx9AZkHWZrBmoayIgKhRn/Gk404YTeN9GOt2nXTOqiQJCw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(1800799024)(366016)(11063799006)(18002099003)(22082099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rWGfFGcQ278CkMKuItkyEMIg2MLhIWZZvi3bd+NQ+5c1HNV/W7Oxj4GIZ/Nk?=
 =?us-ascii?Q?goIYUJL+H+KF+7SrWWjWJ0EzVFkM/eR/wY23Eb4rp7hbUb3Tx2kz6BF9SJp9?=
 =?us-ascii?Q?5akGE4I97K0ifgKcDUi4rD9R5DQ3m6CUH3H9yL81sxmwPOt4GErHvS/KI+dU?=
 =?us-ascii?Q?MI6/ctyYSAbtUHEvdtujsmfdpW0GIhCzTU2Rc7G36Ut04fYjdFHaHhFaJKeY?=
 =?us-ascii?Q?CayraedAao1JHc+Kgkw1BlWz+v/hZG27hpEYTEmLGhCNGkxWeeBCI36k0IZT?=
 =?us-ascii?Q?zemC+Mv2iOK64VuZ5hoxGrBKGarqRkISF8qzPlJ/oUEF038NMbZwwgfJpwl4?=
 =?us-ascii?Q?aKHFBiGbdVA05qFEQ6K49ovUkfuBLAlWPDeMKLIgKNXNbXOrFn1zdFCo/xe1?=
 =?us-ascii?Q?ThPpTalcoNEe+CrUNlVPiuW85fL+V6SqaSpsOAA0Xzns8/YgEFa3POX9QVnN?=
 =?us-ascii?Q?cSKJcQ5iccxc28qfPnF++v9eP44W3KheQsKG/wXlGVz81nGOXKtQbpjeTPX9?=
 =?us-ascii?Q?tnepDgn4Xag4ONW7a0wrtn9klQtAAAxfuZso0opE6lEe5T2uArh5kBddzesG?=
 =?us-ascii?Q?J2sxzgy9YHGLB2I7Sb270cVhtTVtgvPYsDM/iLxmOHmQi6q4QruGU111//Ye?=
 =?us-ascii?Q?yeK5Ub7I51pklikcxWI6pX2fn2+0Wn9KFBspHLXg98rdKguZ6Sx331iKqXlc?=
 =?us-ascii?Q?WybfB7liMjaqSfmek6iBIZGJwx9wkJY7UBjVnAI6+43tTQh7SUPBVm8vDqGG?=
 =?us-ascii?Q?Lq5rrkliQv6Eeko73ulwTP0+/AZ105VzAe7eVbkpFXxAPOrzeZboeTbRLFWN?=
 =?us-ascii?Q?uvgjt7LBQzs66KGBk0bLg/SwIgRgQqK7IPGaxfZ7s9xbM9sMzNldaMNf9qWc?=
 =?us-ascii?Q?dpjq7WDkPLyQ6bv0xKnBSZ3/HZagpoAu5YB2qCVTF6u7mS1q5f+ImCM5g1Jq?=
 =?us-ascii?Q?ImtGoDh98dT3CxMbrjLFwXIBWObhoqecIbx5lYnKtaWqMfosYHxGYcXisdVa?=
 =?us-ascii?Q?Wn/OQsE17kwVnU1PWXdtAVZ4/PdXr3EYkJtdz5kdLoCQKiYUQRZVp/x06J0B?=
 =?us-ascii?Q?aL5FsE6f0m0l/WGMWYK4h0cCozNigT94ycWZDm5jZrD5RlQmCUxv8LkzB8Hk?=
 =?us-ascii?Q?XK/LqqGbSePAF2NWBZRxovkAC49XQ9AGC/FcQpw6SqEoEPGKRdCwI5bMm0XU?=
 =?us-ascii?Q?onQPHvgFZ+ehyc+frzLY6WeFzesuixzo//siXZus8TTd4jy2lnZ8b2A5rRH6?=
 =?us-ascii?Q?8BdjWh3wJW18COraL/g6tw6Ea6R3ouGz7YOA9ou0wJ6JKDE4EyI8EHuICHu8?=
 =?us-ascii?Q?GoV0exUqZuDmTBQCG7Wjz9a4KFT46IVOjlQx2HVUYsCagXAFf6BGXxL/NRzd?=
 =?us-ascii?Q?7kFftGwxEbXlmxp7z+mXKEUwoM/pxvNaHiapfXP23v2L+kmXJ7bY8f+UUC2S?=
 =?us-ascii?Q?WE3rOP9FE+/GdJhxg/vn+H2Y750qtlPCx4EOmVUU02Q4cELrxR/z06R9rxys?=
 =?us-ascii?Q?8jPU31h3Xs3iHUY6pZnDCsHYNQ4FYvt2J0kwIebNivQfpUQYUjOySKlNC1uj?=
 =?us-ascii?Q?rfIvPiT6UKz/9JtSq7fAv+yk7rKBoeLcmWyDaAup+xEksJdA9zccS96Z2Cgg?=
 =?us-ascii?Q?AL9ywMKzNNSoYYWAWypchveb+aJZFmp9hW642002I2KCnFQJIkL0H+Aoelpu?=
 =?us-ascii?Q?9D03tdNkN3Agn3i+l1ihBtZCOZP+kiSYcPmeZx8Wu66yCb3C?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7031d1-09da-4d1b-744d-08deb6b6f35a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 21:30:01.8563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MOJGmTpLQT3ae1cIYUBB6vjncYDVs8HMs47ooYCwb0OS/yG2IeuMMK1OpyKErkNxdjrioNRVAe3Cmu8O4fK3+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8468
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10575-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,denx.de,kernel.org,vger.kernel.org,altera.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B051759CB1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 11:47:20PM -0700, tze.yee.ng@altera.com wrote:
> From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
>
> The descriptor FIFO requires that all words of a descriptor are written
> in order, with the control word written last to flush it into the DMA
> engine. Using memcpy() is unsafe since it does not guarantee ordering of
> MMIO writes across all architectures.
>
> Replace memcpy() with an explicit iowrite32() loop for each 32-bit word
> (except the control word). The control word is still written separately,
> with write barriers, to ensure it is always the final word pushed into
> the FIFO.
>
> This makes the programming of descriptors fully deterministic and
> portable across different architectures.
>
> Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
> ---
>  drivers/dma/altera-msgdma.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
> index b46999c81df0..5816973d2c70 100644
> --- a/drivers/dma/altera-msgdma.c
> +++ b/drivers/dma/altera-msgdma.c
> @@ -495,6 +495,9 @@ static void msgdma_copy_one(struct msgdma_device *mdev,
>  			    struct msgdma_sw_desc *desc)
>  {
>  	void __iomem *hw_desc = mdev->desc;
> +	const u32 *src = (const u32 *)&desc->hw_desc;
> +	unsigned int i, nwords = offsetof(struct msgdma_extended_desc, control) /
> +				 sizeof(u32);
>
>  	/*
>  	 * Check if the DESC FIFO it not full. If its full, we need to wait
> @@ -505,16 +508,16 @@ static void msgdma_copy_one(struct msgdma_device *mdev,
>  		mdelay(1);
>
>  	/*
> -	 * The descriptor needs to get copied into the descriptor FIFO
> -	 * of the DMA controller. The descriptor will get flushed to the
> -	 * FIFO, once the last word (control word) is written. Since we
> -	 * are not 100% sure that memcpy() writes all word in the "correct"
> -	 * order (address from low to high) on all architectures, we make
> -	 * sure this control word is written last by single coding it and
> -	 * adding some write-barriers here.
> +	 * The descriptor must be written into the descriptor FIFO of the DMA
> +	 * controller. The FIFO is flushed and the descriptor becomes valid once
> +	 * the last word (the control word) is written. To guarantee the ordering
> +	 * of MMIO writes across all architectures, we write each 32-bit word
> +	 * individually using iowrite32(), and handle the control word separately
> +	 * at the end. This ensures the control word is always written last and
> +	 * prevents memcpy() or the compiler from reordering accesses.
>  	 */
> -	memcpy((void __force *)hw_desc, &desc->hw_desc,
> -	       sizeof(desc->hw_desc) - sizeof(u32));
> +	for (i = 0; i < nwords; i++)
> +		iowrite32(src[i], hw_desc + i * sizeof(u32));

why not use memcpy_toio()?

Frank
>
>  	/* Write control word last to flush this descriptor into the FIFO */
>  	mdev->idle = false;
> --
> 2.43.7
>

