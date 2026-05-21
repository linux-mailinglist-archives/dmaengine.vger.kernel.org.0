Return-Path: <dmaengine+bounces-10670-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOwMFxslD2paGgYAu9opvQ
	(envelope-from <dmaengine+bounces-10670-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 17:30:35 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8875A85F2
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 17:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 991B3321B232
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 14:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F9228852E;
	Thu, 21 May 2026 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IKZCsEuq"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013021.outbound.protection.outlook.com [52.101.72.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2733E265CC2;
	Thu, 21 May 2026 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375404; cv=fail; b=phxxTEOVnFysVX9zh63tFTkr58g5y1p5kHg+mRRRnqfZd2tS5reniW9AfR43b+rrKSp1v6xLHLblNobqijaWRZbSG8mAP4NRgJcp58YIcl7W550O8kxH3ZF/B9ME+nEgsrlltS4CrL3NtJKjELBSXFHP8HE47y4pkkP7NSyWtOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375404; c=relaxed/simple;
	bh=QZc2rtnJ/CuNw1MYCwZJndqZ/Jroc2AEY3Vd4ymRYsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SnaSNCx+P8eYLYcsReMxrEXnhQYMfqffRDtfAMsAjwsqmKWvrE6otc4jevoms4vsZtHuse7TakWm6YTHpJPepG4iKVGKq9pcya0PGBQaFstDYtufZzkp+kAu4ytRCkRL0LMgwkFO9zSF+QFtokVpyvma0UQle2awfyi3VRWthZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IKZCsEuq reason="signature verification failed"; arc=fail smtp.client-ip=52.101.72.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xrSm6Hx99iov48EEgZaRwLhR1oiFuQocwGGiVGZnuO7edz7ERAjdpBRkoG3ZsYfx8QgXd755V39LQaoGU8rS80ao+Q7RXWlFTsYAZVurvMyTQkEh/agxUUjrooozSPZ1tJQn0easAJZqoE+FbUmI/nqlaqV587dCUh7MVUtVm8qH9/TTh08ZjSnRS49jZRyW9UfZ9TYWPvcTJ7Ku62xHCD3vopcG+F+snuI7ONcqbCK0lx5OPV0ppzp6cz/ewYnBH3wC/WW/OGShOpDz3mW7LYLsl9oIPqhso9+nftBor2jK7cfvnB980PYYw8oQtHxFaChKIpzYHa/1j4NbcDdHOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NpNIW/QFUPI5g7rAiix1KfJgYEkyrnXDMF9m2z8qhnM=;
 b=cqsAHoTP6gpCLJ4s+gjk10fOyqn+tM8cTVkWdDrGXWS6zYBQaixQFDkcjnNPs70QMcM8AbrLdxmYoEm/kVaXEZSR/xMDxm7D/UJJqCN62o9pr4xxeft4unFmzRDUBP3NbgBNkuMT2cVCeSYUZXpYRaGtLdXw48o+ekli73Fp0GaoLJmUG1Ige/O6ydacXVc02Q4cCn0d5Bv71kemzpiD86bjHvGjbKiVBC63og9jI7JA/W2TFyuCX64iLTy7IEbWc6iUUrUQGkMphfxGYcr0LJ63hMvy0KEx8W/TlbvIJ/Usx4j0+GONlSe7g3EE+JSLr1pqAXY2Lm+SOB4BtzcTgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpNIW/QFUPI5g7rAiix1KfJgYEkyrnXDMF9m2z8qhnM=;
 b=IKZCsEuqfYt3L8982B3wB7SE/kTx4wYpmPuQ1OZjqkbftgxTZZqH8lOKrNVFqgjuDc7myincZgZtsR2KPtnM7UdNnF6MgkFPDKTXM035X5Ju5nvg1oeonOycYGMpW7xHaRkMBVrq4e/gVbfH1vfXB3Uq6oN0RJnf4/vChjbQcJdnitTQqQWmcjGkoLyRmCQtaP2ggnW0kHTU26SNYUhcyF9SK/ixhuYg/TMLFw3vDfoHnPWzgl6n7ErcBmBsBOedkGMiZKlrZE/RUbaeLcSbLmXyCllL2hJhpk0Xd62JOzXWNOhbrPDOgDjWpHYyPRuN7kDLS2KWj9z4GD8uxSYL5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM9PR04MB8761.eurprd04.prod.outlook.com (2603:10a6:20b:408::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Thu, 21 May
 2026 14:56:35 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 14:56:35 +0000
Date: Thu, 21 May 2026 10:56:29 -0400
From: Frank Li <Frank.li@nxp.com>
To: sashiko-reviews@lists.linux.dev
Cc: Frank.Li@oss.nxp.com, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v6 2/9] dmaengine: Add safe API to combine configuration
 and preparation
Message-ID: <ag8dHUPZpE1q3V_S@lizhi-Precision-Tower-5810>
References: <20260520-dma_prep_config-v6-2-06e49b7acb38@nxp.com>
 <20260521000104.CC1891F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260521000104.CC1891F000E9@smtp.kernel.org>
X-ClientProxiedBy: PH7P220CA0166.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:33b::13) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM9PR04MB8761:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d0d50c4-4543-4cae-78ad-08deb7492767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|19092799006|52116014|38350700014|4143699003|22082099003|56012099003|11063799006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	iX15HFQXmvgulBVjPoY2FwnNBK1AWzeV6ta+YR21O/QzrkxWwSLNYwiKKA3Q7sYYZXhSsjZhhl8a/X+1L+okh/mWO/v9JU43McdNxnXKBasIhERbZwNx+EKxN6PTaPeJITq79UEKwigRMgiYbcIczqR/Frb2Ne2Oyj0DU5jqFiOWPijAdkzaDyzh2lnlWWjRdgFgTTmHteTMl7zjFrpcCPLGllISG5wbuUOCBuzeZMJn14Qr/EwJRifu6WAQS1pnNDtVFr6ZFNNMHvlkv2VAyds0Ehlx9FhUDkcQXkc32WpUvm+WxzhE++wYbn+rW3z63q2gMLnhUd8aVRBFiIcAsQMWHhMfrjLbKdznKJ6v6TE96zv6WqmE0nEjcemX83YIjdK2AiHdEt8CvW6gPU30ltL4ZtuxtrhBAiYEkFi9L3TqQ8/jD73PHk2MiJeoK54cmHQzg5ccS+vF4gNQirv7YGycsTuNyyos5Lm5JTwDSgYWUktZOv4p3PB5vHMMAvoIq1gupBtji0yQZnj/YQUFFsCLinrmB+K/Yo4rbJ9YE4xnvYZb7ZTOvg/L1rgqDDUXhqXp5MdWzLdkjUPVjQEeiM74d1/w35QAUz087vbv0im67wnROiVd23J0ow98MTonMgsf+6VcIpo6+487Q3Clfv/2Dhpl3rFHShry0O1YngDF6UpBhIKyWY8/PBml+Ah7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(52116014)(38350700014)(4143699003)(22082099003)(56012099003)(11063799006)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?8+MqUdCbffMlC7tCc+zaLwecMRmJz2Y1kASI9YXjQzlVlN8RMOdYBKSZGb?=
 =?iso-8859-1?Q?1LO6WaUZyYqSVko4Bx8g0SlFjnrwiu1CIwSSHcmwJ+exuJVy0hUNItrZ7/?=
 =?iso-8859-1?Q?Rpokdyb4AVQy6gGXC7ro1jEf0kKc/+IT0L9vwiMd5EnC6DtoxQcjYKgDmA?=
 =?iso-8859-1?Q?bfHYAb5J9Xl+rViuVbmpBsouhb5tCHhlz1j+UZhczuGWsiRXrJB7XVYjKx?=
 =?iso-8859-1?Q?aiC56dfjdascqmr4qy+EXcVgv6bKObpOG5DAL1BsnaeJw8cRxL8Rrjj1Qw?=
 =?iso-8859-1?Q?0I1Jm4u4lq6ZPjbaBE3sfty1e5kYjBZ9GX0BabUnZcU6C4TBYKj/04vo7T?=
 =?iso-8859-1?Q?spJxAN5beLuTXzZhWXMydJuug3PgUjtDu/FB8GVhEeRDODLi1E7Wzl/DkP?=
 =?iso-8859-1?Q?1lBmMj5uJWNQqwgH4e5sDY1wWQV2n515YptzDydS7z979AVtdPXMOQ6Bhk?=
 =?iso-8859-1?Q?t8fSpjFVRjfyrpp1TyJJ4VPJ+01Gl+9Wo5/TAQl2NSFdDWWmb6rN3wO41a?=
 =?iso-8859-1?Q?jY2EgIkUwSnN1bF4A4wlvTmRSn/g4Cz2+68nYasUDoucS+TjNmStivfbBz?=
 =?iso-8859-1?Q?gBRLuF+SRBaY8CKAz0QX9xrnQFWwQK4npyX0I7hdAsthupDi5tG3SnMG43?=
 =?iso-8859-1?Q?4KTEWqVbN2DN5Y/HFZHoKOkC3KA4DcHpRnekp0px/4TqZ3r9RsIZLE6ZW1?=
 =?iso-8859-1?Q?lTNAyfJBPaHzBcPjshcH6mwSqGLm0MTYy3Xeme3vMQhh3kD2xwU7+ej0Yk?=
 =?iso-8859-1?Q?vk2P9cycdlDCUtHFGjiEkxgl6fEUCvdXKhSJFmRGSYdehkHwcK2+RPzoR2?=
 =?iso-8859-1?Q?gFwWm6I2gNQ6G9CXZySbUY6VFeAD6QewOo8waljKzNxb7nWg1JziPKNtCC?=
 =?iso-8859-1?Q?JWRWNggfaEnOW/u7JoW690XhnCfgZ2rn6d7xfNFFE2Ya1TIiWpcPrBkdLv?=
 =?iso-8859-1?Q?OjVzdU/qU8VymfMNxpIGq9qU1+fL87SNTPjvRARVEWeZefOen4J1nH9ERO?=
 =?iso-8859-1?Q?EZRgxpxlj1zUby1UT6x9kFO4eShnV8o/8+ug1YTZghRKkr6bR5U8EEcvB2?=
 =?iso-8859-1?Q?UBXmroppayEI5IeSxhSXQqFjvRYCspE096new3q2RFZ7P+7Zgt+XQDBOsB?=
 =?iso-8859-1?Q?ELZXc0+nWkdV+mx0hcH2Pk29859BhjCr7e0gOv3a31rEAJspxfhznVsNvA?=
 =?iso-8859-1?Q?Rpv+lDLYMqU8T3s7dSySILAngAiOKN5EjoRj0XBuB+w577Wdy+sH4RWlJe?=
 =?iso-8859-1?Q?mcLpuSqDm50KO6pKzEIIa65P/aD4Bb0rwgA2CiuJ+dHp1yynmLsgZsaYjs?=
 =?iso-8859-1?Q?KdiLLxp0IhIkNnCloIM/vPGAlwUj1inm92COiCjL69JGcc9di8PtkUIHEy?=
 =?iso-8859-1?Q?hZ+JVbgFhNHiL7St8bDzRZ85qNoSEXF7kqT/OWHJnMN5cLDCol26xiQsBd?=
 =?iso-8859-1?Q?xgriY2BEY4N+yGjlC19SBy2tM1dmIYRJyTzhUVsMKQUPsBmz5MAujXxn/3?=
 =?iso-8859-1?Q?MnGuSVszAPYQScH6+IhU7xk/vMAwgGBF5rkWGOJcHieC/U98PvASMCumEN?=
 =?iso-8859-1?Q?J9JMEO6KGe6dBk/hyHp8/O4bdTjSXIhcA8kHSC6jRih0CrsUJF+yohm2KX?=
 =?iso-8859-1?Q?Y6/WXsyper4FMLx62A8qezEFTNw8bx0hd+5fHUdVe0kFWBNkr6ijgCF4GA?=
 =?iso-8859-1?Q?4Oj0CCOAg2GpEvshz+IT+qsBXGkr3eLXlIPl0OYva9DhCKBm9hzT8/8v6H?=
 =?iso-8859-1?Q?bmcmuxKW0c6HhkKXQlZ0nvU7eX8Idaw7dHUNPK6SIEb+Pi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d0d50c4-4543-4cae-78ad-08deb7492767
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 14:56:35.5649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UdhOT6r2BJvMjKFi+zYJHA3qYB/iJkwIsd9SVopKUQGUKuwL0y2um87TUSfiqAZawupdwBYfYhEvYkW3MAd9+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8761
X-Spamd-Result: default: False [2.14 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10670-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:-];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url,nxp.com:email]
X-Rspamd-Queue-Id: DE8875A85F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 12:01:04AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] Stack-allocated scatterlist in dmaengine_prep_config_single_safe() leads to use-after-free when consumed asynchronously by DMA drivers.
> --
>
> commit 7f280444e5ae16961e6f77cb674cd3ac061779a0
> Author: Frank Li <Frank.Li@nxp.com>
>
> dmaengine: Add safe API to combine configuration and preparation
>
> This commit introduces two helpers to combine DMA slave configuration and
> transfer preparation atomically. Drivers can either provide a new callback
> or the helpers will serialize the operations using a per-channel spinlock.
>
> > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > index defa377d2ef54..6fe46c0c94527 100644
> > --- a/include/linux/dmaengine.h
> > +++ b/include/linux/dmaengine.h
> [ ... ]
> > +static inline struct dma_async_tx_descriptor *
> > +dmaengine_prep_config_single_safe(struct dma_chan *chan, dma_addr_t buf,
> > +				  size_t len, enum dma_transfer_direction dir,
> > +				  unsigned long flags,
> > +				  struct dma_slave_config *config)
> > +{
> > +	struct scatterlist sg;
> > +
> > +	sg_init_table(&sg, 1);
> > +	sg_dma_address(&sg) = buf;
> > +	sg_dma_len(&sg) = len;
> > +
> > +	return dmaengine_prep_config_sg_safe(chan, &sg, 1, dir, flags, config);
>
> [Severity: Critical]
> Can this lead to a use-after-free if the DMA driver consumes the scatterlist
> asynchronously?
>
> The scatterlist sg is allocated on the stack here. While some drivers might
> process the scatterlist synchronously during the device_prep_slave_sg or
> device_prep_config_sg callbacks, others (such as qdma) may save the sgl
> pointer internally to process later during tx_submit or hardware enqueue.
>
> By the time the driver accesses the saved sgl pointer, this function will
> have returned and the stack frame will be destroyed.

This is NOT this patch's problem. exiting prep_single() use the same method.
dmaengine callback implement should save these informaiton into their
dma_async_tx_descriptor, can't direct use caller's memory.

But this point is also important and easy to be missed. suggest add it to
dmaegine documentation.

Frank

>
> > +}
> > +
> >  #ifdef CONFIG_RAPIDIO_DMA_ENGINE
>
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260520-dma_prep_config-v6-0-06e49b7acb38@nxp.com?part=2

