Return-Path: <dmaengine+bounces-9265-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIKcF9oDqWlW0QAAu9opvQ
	(envelope-from <dmaengine+bounces-9265-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 05 Mar 2026 05:17:30 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0604620AB91
	for <lists+dmaengine@lfdr.de>; Thu, 05 Mar 2026 05:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51DF83013487
	for <lists+dmaengine@lfdr.de>; Thu,  5 Mar 2026 04:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788D91A4F3C;
	Thu,  5 Mar 2026 04:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jxDiZnJW"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012034.outbound.protection.outlook.com [52.101.66.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A528739FD4;
	Thu,  5 Mar 2026 04:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772684245; cv=fail; b=RPYTCi+NBKWiiuZF1z6ohNJmmR9lvHP4caExK2D9Kn5qH/UEcGc1ggpz+CpEHL2UaprDuyyeD9BL3zWIPE7VpGAfXUXEVfuZLGB45PYwmN9Vnl8WJdrlsolAgEhVmnkZuv7rgrB9LyP5jKQHRp8fVJ3OuLe1b2GYMM0GjQ7WYc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772684245; c=relaxed/simple;
	bh=BeXVInTSQw191qW8F8wCKjWNsMnrwDTN07K7Zl3EZwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MXLqqfdr8DDkiSBQ0xTeeCBohcFWei31a7RDObOHbyLXEDKqKqEro38W8XA3+JxlH1yB22+hzUT0iglshJS8kSkoI5609XwgRHxAPrFMgl9OlubbRVZ//2xsPxSkoL9mW6qN2yk7o0Izt45dbZLM0Jtl7ST00/K9TU71ziVmUv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jxDiZnJW; arc=fail smtp.client-ip=52.101.66.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XmZuXPT9GrRwwm4WHg6d1lGatrFzWNajZTXvWDAbY+3U/BZ2SEMuZzbrdgzmlg9P9q+pUrp0rgW8jpgCE7q0dODgVO7DRjnRWtPj1U3I0kd0v2YaMIHPqZ1okPvlKz0W4dKmZ6wV4h9JmtI6W99V3KqKXQFrFkg3l0PI6KP9eEM3khOuGAg49ImbqQk1XLqv+y07jJ63lRPpvZUejLiI0zVIUr2zzZdGpPKcWWEnRIOo25TnodQyOxrxBqmwuu9DUXoaOKdFTNVJ2GQ9uNJ/UmA3NEK9HBZJpGOnBcEQ65ylTzWI55GWlN5vh8FY6/o71FqjRTS6zAKsbJzLJNxnjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ifeEJJzEMR1m4PZb9h0IseCmNH0ZpLWRZMJYSrP2Bs=;
 b=A0+4bEH927rZvKl/2uCVZFxgFkdSxSL7iD4bz2cifRA/UITzmTskr4hk2453tQ38iq/k96odLhcOXObrptNaXAyd5hGgIH63I19iB1kGDgYTXwKaJWP32i5T9cDxz7gnhawkvopCTKSYf4sKJRdoNq8A886IpgE6h9c3ykkMUOYEm3sqWBQdDkyzr3Kpi0fzdi3u0gzth57MbbaYD9Nl4wE0t24Y7rfPQJbbriXt2EvummgL/C+FGINmCGZdUt8llypoPkiufm0eQgF33vOpkNWTKPhY3ONa6q8T1pM6sVBLHU04+kgfTN+IPfUmdBvHznd/vnFDrGSPs1rPjJt+OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ifeEJJzEMR1m4PZb9h0IseCmNH0ZpLWRZMJYSrP2Bs=;
 b=jxDiZnJWukkJgVnznamGv4sxLyoPTkculLWbUawVPwUYq87eXuiJ9ho04mWXPZcZiQPh7xA9pF/raymxbEZ7DqxbW6uh+ZiAOA4shg6KXW2Rgw787+CfxY2AA9pztGstmtGsdoHqtLSJyDO2KdTj45hDm3GdMof5dsbuarbAjep80NPswPOX6zVi9rVkpFfzZxPR+epMZWIwurvkhwF4Q39FocsLXPGOwqGEhxuO4KlbHsTHd9CY1yw9Ek6L2PnxwN2la9jsBoHBnlK1WDucqQOh/7puaXhKHptoHEiT5WTpQbzVSRobP8QXwSwuuSQOXtFHJgV6SIZ60PQJeCLHnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA3PR04MB11154.eurprd04.prod.outlook.com (2603:10a6:102:4b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 04:17:20 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9654.020; Thu, 5 Mar 2026
 04:17:20 +0000
Date: Wed, 4 Mar 2026 23:17:12 -0500
From: Frank Li <Frank.li@nxp.com>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 2/3] dmaengine: amlogic: Add general DMA driver for A9
Message-ID: <aakDyNdKhXdh-bnH@lizhi-Precision-Tower-5810>
References: <20260304-amlogic-dma-v5-0-aa453d14fd43@amlogic.com>
 <20260304-amlogic-dma-v5-2-aa453d14fd43@amlogic.com>
 <aahUTp3T6QWbZiaz@lizhi-Precision-Tower-5810>
 <501fe36e-a3b1-475d-ad79-8b6523fe95e7@amlogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <501fe36e-a3b1-475d-ad79-8b6523fe95e7@amlogic.com>
X-ClientProxiedBy: BYAPR07CA0105.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::46) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA3PR04MB11154:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d73c593-d844-4e04-fda2-08de7a6e183e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|19092799006|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	fX6t1PH/+SXTMVmFFJWwxM5O0jwIZxi9PhWTS6Ch2+ZhgqmahRwuwIZLvTsDVhMqs54L7s0sPP5yvtshLJBK8veZivwYC7Igqy1UwdMOItYXkWTiV/NwQp/BymmbDX7QwLsjb9IC07XK59DmHsA39YoK+Vf5tF8GtgklpO/k49lL8cdbQ9q8CkXB6p6dr7TA+UR6+Jl0vPknQTy1bqKiKiBdgcey89Vh/T+K4vwJYVAr6B3uTQt5foyM3QcSa8s8PLefN1LwPWzBELwYWPx54ujH4VcsDXVUyEFUI9GQk4HPDJaYN5QIeNL3/ClR2K6f+I7+FKABRk+OdbYAm1JfeAlJI5UfGipdTKjs2UFSUQ6I8MKyit+amMYDgcGzT60TuWUypvWCeeUGHgl7Gx80Eq2i0QoxFT16MvSN+QGs0t3qtxqPeLFu2+PGWZ1RKxabuR2WOKtKQDJmPT++FU3gf92DMEalM9QjkrlYxwmfe9RhuOdde+9I46YPfrGvcbrs/jL4by9j/AKYuDdK/KbZXpqfMEUhHGuNPkTIqEnhGMlXSYHB5h4c/9YaKUDyb5qbhS4o8P7NoLYL9GIuIpFP1yc7OF/WeZlEL2ecgI1C773p5iVA/u5JDIdwE93Iku4mgznk2EPSeb20alm/2b8pY3b/KzaGfakJQ0zd6fukFTZ3JbnVDiEFDufWAs6a3r0omBcmmi3KYp1iKrZGltbpQ9g3BI1UpD6JmKaV1MV3CtxPCw1B0Le5QYv6SPEXhP1hzBcsyCcfr8PO+ibYnZgjZ53l+xCl2OSnz0qJCshzaaA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(19092799006)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CxitvFEe/3dPMPdDUzYN1lLQ5QNyNmy84nZPnVbAFFYLojnYhi3WVVoyVQsu?=
 =?us-ascii?Q?AbqrXyVrs3A6gF1lYZrUY6p1N7rYDWq3OPKcPpPe4koPRbu7DT59xD3oCbET?=
 =?us-ascii?Q?kRDvLgtBlGd5Ps5G/dkCnh4Biae4/If5F3XA8LYiyEU8Wt68XSLOk+81eoSn?=
 =?us-ascii?Q?ePhuNPuGl4zerf/oHiYmdtlSzrH7dEV9A6Yr96aXePZpc1AZb63OLx1P2Zf4?=
 =?us-ascii?Q?Yhm2Ny6MwhW99HQkoaDZoMGtCz1cebg3XPlHJ+rUZdHZi8LKDzXGoivJu7g8?=
 =?us-ascii?Q?3DEVhtBVT5a6ZydOGtz5XyGX6XQ0YXvxnAFoj9Hhd9kukNT4XEC0yB6bP/jJ?=
 =?us-ascii?Q?N7ujo5+dZuQQ5Z4UswWRSHx3FIvPXnf22hrsyxgLG6+7yWRnY18FwjIhTVIt?=
 =?us-ascii?Q?5uuazfrBTcRsQJHZzgDFaIanDs/Q5hZQwIUL6H7g/CUk57FO447HjzD4bPNP?=
 =?us-ascii?Q?t+AgKZl7fEhWJSjaT7VHi1frhAlm3aWVRgvQSGYMSUNwK1MLTefce6B/s+fZ?=
 =?us-ascii?Q?4ceoXP1s0tftIjUZjJPNyw729f6X1dJXEzl7AO+BPq2G7xoMnjlvCKjIw+wF?=
 =?us-ascii?Q?x24loB6AjpK2hxuMEp78L1TkjaW/3oUcqgPNWptoQB1Ym1gM7VBVB4SYfjw6?=
 =?us-ascii?Q?UsaORR01R3DfFNgYqJwaPWZHUIdlsHzl6UNixqukFoT7/m4XS8ogcKS/DAXs?=
 =?us-ascii?Q?HKtDfF10uWkOhcdVHBdLWE7gh4MRpGal/tGNS2ruS5wOufyh25nBkU2EDRVD?=
 =?us-ascii?Q?k3/+Xc/TzM6pgflsuscVCDHTX14Zc/TE4I5T8tXhw1UgSb0V/jEzQ+SafGWv?=
 =?us-ascii?Q?NDlUI6+Q+cbEHDEJ22GaosdPMhx9QOGj6T975f1WdDF6rq+f0xgm7ljctbj/?=
 =?us-ascii?Q?p75XmWru7tyf5mDaDh0YrtCVSr6X1+UVn/vmETpvQWM01U1FzgIlQX7x90Su?=
 =?us-ascii?Q?ybhIlGFm2fA6Guwn+XQgvVjSfJ9HXmZu3k0bBRskA5GcRf5g+mYujp5Jmixm?=
 =?us-ascii?Q?fbeAe+NTmL0Jsxs8m+EY2nsonCdIEUefMIvC97diW53EBuefnYAD9vpVeePb?=
 =?us-ascii?Q?VHpx016CogmVsB0sj7F3o+Pi8mokDIxmHXtk8/mQnEsdUrsAKG0XfkAdel4v?=
 =?us-ascii?Q?oL4iCgHpHVMg9gz3fJkid7bikZ/dYxABOlRHxMDGydl18CglLNczFIJ3bQLV?=
 =?us-ascii?Q?IHs4CPx4Vaq1HAxB7BAiqGz95HqX4TRw0QFqj1s0Q9uZBBWjqxVWiVXI7eqX?=
 =?us-ascii?Q?71a+k4nZJOrsJIGki3FrNXFvaNMvkq7q2GNV6JwpwnMTXcFqgLlYyKANGUNp?=
 =?us-ascii?Q?3uC1vh1IGLl6kuwSllNubQRQT9jqqikwLVvi4o1qBFJAEpvtd+OqZko8bO2x?=
 =?us-ascii?Q?sdGSx3vYxsb13hrmlJFJllkNYpCJ5lmnn2otc2N96LUH+M3DFza2DVpN7h6J?=
 =?us-ascii?Q?5WU1So6a8B9TF23B+f3JS+oq0ypmO8YcH7K5aBWPG9k5PMpqZseIsLY+YnpI?=
 =?us-ascii?Q?zTgX/PLtVmqSi5sUmhCF9pU28ZarlH9FHioQS9fkyAJKKHfjnlFcNR93Sd1M?=
 =?us-ascii?Q?mmEpO9WAl1wW8gdDEMq9m4Y/UYDqXMhdJbJHZ6YoIoQd/FkZpHGa8GHfzdg6?=
 =?us-ascii?Q?KrG1mxnEjmEd09ATSFVCjwaI8rF4vH+lz/m64D4amprExcQJYNAwMAn9zf/W?=
 =?us-ascii?Q?jrUheShtnzaVqdpBPQgGsY3A661Hr1IRlBYyJ5mLlUd1aytYwysm3vEvmAc6?=
 =?us-ascii?Q?vc226l+5og=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d73c593-d844-4e04-fda2-08de7a6e183e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 04:17:20.6929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AfKJkjUbqRSHuyIvYcYTJIqETsP80LGFYDLeNAw/1TbPf/QuJN9T3PUXwGCIntsg/h4d6pOXrh4vgXAnMoyw4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11154
X-Rspamd-Queue-Id: 0604620AB91
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9265-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 11:35:15AM +0800, Xianwei Zhao wrote:
> Hi Frank,
>    Thanks for your review.
>
> On 2026/3/4 23:48, Frank Li wrote:
> > On Wed, Mar 04, 2026 at 06:14:13AM +0000, Xianwei Zhao wrote:
> > > Amlogic A9 SoCs include a general-purpose DMA controller that can be used
> > > by multiple peripherals, such as I2C PIO and I3C. Each peripheral group
> > > is associated with a dedicated DMA channel in hardware.
> > >
> > > Signed-off-by: Xianwei Zhao<xianwei.zhao@amlogic.com>
> > > ---
> > >   drivers/dma/Kconfig       |   9 +
> > >   drivers/dma/Makefile      |   1 +
> > >   drivers/dma/amlogic-dma.c | 585 ++++++++++++++++++++++++++++++++++++++++++++++
> > >   3 files changed, 595 insertions(+)
> > >
> > ...
> > > +
> > > +static int aml_dma_alloc_chan_resources(struct dma_chan *chan)
> > > +{
> > > +     struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
> > > +     struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
> > > +     size_t size = size_mul(sizeof(struct aml_dma_sg_link), DMA_MAX_LINK);
> > > +
> > > +     aml_chan->sg_link = dma_alloc_coherent(aml_dma->dma_device.dev, size,
> > > +                                            &aml_chan->sg_link_phys, GFP_KERNEL);
> > > +     if (!aml_chan->sg_link)
> > > +             return  -ENOMEM;
> > > +
> > > +     /* offset is the same RCH_CFG and WCH_CFG */
> > > +     regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_CLEAR, CFG_CLEAR);
> > regmap_set_bits()
> >
> > > +     aml_chan->status = DMA_COMPLETE;
> > > +     dma_async_tx_descriptor_init(&aml_chan->desc, chan);
> > > +     aml_chan->desc.tx_submit = aml_dma_tx_submit;
> > > +     regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_CLEAR, 0);
> > regmap_clear_bits();
> >
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static void aml_dma_free_chan_resources(struct dma_chan *chan)
> > > +{
> > > +     struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
> > > +     struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
> > > +
> > > +     aml_chan->status = DMA_COMPLETE;
> > > +     dma_free_coherent(aml_dma->dma_device.dev,
> > > +                       sizeof(struct aml_dma_sg_link) * DMA_MAX_LINK,
> > > +                       aml_chan->sg_link, aml_chan->sg_link_phys);
> > > +}
> > > +
> > ...
> > > +
> > > +static struct dma_async_tx_descriptor *aml_dma_prep_slave_sg
> > > +             (struct dma_chan *chan, struct scatterlist *sgl,
> > > +             unsigned int sg_len, enum dma_transfer_direction direction,
> > > +             unsigned long flags, void *context)
> > > +{
> > > +     struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
> > > +     struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
> > > +     struct aml_dma_sg_link *sg_link;
> > > +     struct scatterlist *sg;
> > > +     int idx = 0;
> > > +     u64 paddr;
> > > +     u32 reg, link_count, avail, chan_id;
> > > +     u32 i;
> > > +
> > > +     if (aml_chan->direction != direction) {
> > > +             dev_err(aml_dma->dma_device.dev, "direction not support\n");
> > > +             return NULL;
> > > +     }
> > > +
> > > +     switch (aml_chan->status) {
> > > +     case DMA_IN_PROGRESS:
> > > +             dev_err(aml_dma->dma_device.dev, "not support multi tx_desciptor\n");
> > > +             return NULL;
> > > +
> > > +     case DMA_COMPLETE:
> > > +             aml_chan->data_len = 0;
> > > +             chan_id = aml_chan->chan_id;
> > > +             reg = (direction == DMA_DEV_TO_MEM) ? WCH_INT_MASK : RCH_INT_MASK;
> > > +             regmap_update_bits(aml_dma->regmap, reg, BIT(chan_id), BIT(chan_id));
> > > +
> > > +             break;
> > > +     default:
> > > +             dev_err(aml_dma->dma_device.dev, "status error\n");
> > > +             return NULL;
> > > +     }
> > > +
> > > +     link_count = sg_nents_for_dma(sgl, sg_len, SG_MAX_LEN);
> > > +
> > > +     if (link_count > DMA_MAX_LINK) {
> > > +             dev_err(aml_dma->dma_device.dev,
> > > +                     "maximum number of sg exceeded: %d > %d\n",
> > > +                     sg_len, DMA_MAX_LINK);
> > > +             aml_chan->status = DMA_ERROR;
> > > +             return NULL;
> > > +     }
> > > +
> > > +     aml_chan->status = DMA_IN_PROGRESS;
> > > +
> > > +     for_each_sg(sgl, sg, sg_len, i) {
> > > +             avail = sg_dma_len(sg);
> > > +             paddr = sg->dma_address;
> > > +             while (avail > SG_MAX_LEN) {
> > > +                     sg_link = &aml_chan->sg_link[idx++];
> > > +                     /* set dma address and len  to sglink*/
> > > +                     sg_link->address = paddr;
> > > +                     sg_link->ctl = FIELD_PREP(LINK_LEN, SG_MAX_LEN);
> > > +                     paddr = paddr + SG_MAX_LEN;
> > > +                     avail = avail - SG_MAX_LEN;
> > > +             }
> > > +             sg_link = &aml_chan->sg_link[idx++];
> > > +             /* set dma address and len  to sglink*/
> > > +             sg_link->address = paddr;
> > Support here dma_wmb() to make previous write complete before update
> > OWNER BIT.
> >
> > Where update OWNER bit to tall DMA engine sg_link ready?
> >
>
> This DMA hardware does not have OWNER BIT.
>
> DMA working steps:
> The first step is to prepare the corresponding link memory.
> (This is what the aml_dma_prep_slave_sg work involves.)
>
> The second step is to write link phy address into the control register, and
> data length into the control register. THis will trigger DMA work.

Is data length total transfer size?

then DMA decrease when process one item in link?

Frank

> For the memory-to-device channel, an additional register needs to be written
> to trigger the transfer
> (This part is implemented in aml_enable_dma_channel function.)
>
> In v1 and v2 I placed dma_wmb() at the beginning of aml_enable_dma_channel.
> You said it was okay not to use it, so I drop it.
>
> > > +             sg_link->ctl = FIELD_PREP(LINK_LEN, avail);
> > > +
> > > +             aml_chan->data_len += sg_dma_len(sg);
> > > +     }
> > > +     aml_chan->sg_link_cnt = idx;
> > > +
> > > +     return &aml_chan->desc;
> > > +}
> > > +
> > > +static int aml_dma_pause_chan(struct dma_chan *chan)
> > > +{
> > > +     struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
> > > +     struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
> > > +
> > > +     regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_PAUSE, CFG_PAUSE);
> > regmap_set_bits(), check others
> >
> > > +     aml_chan->pre_status = aml_chan->status;
> > > +     aml_chan->status = DMA_PAUSED;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > ...
> > > +
> > > +     dma_set_max_seg_size(dma_dev->dev, SG_MAX_LEN);
> > > +
> > > +     dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
> > > +     dma_dev->device_alloc_chan_resources = aml_dma_alloc_chan_resources;
> > > +     dma_dev->device_free_chan_resources = aml_dma_free_chan_resources;
> > > +     dma_dev->device_tx_status = aml_dma_tx_status;
> > > +     dma_dev->device_prep_slave_sg = aml_dma_prep_slave_sg;
> > > +
> > > +     dma_dev->device_pause = aml_dma_pause_chan;
> > > +     dma_dev->device_resume = aml_dma_resume_chan;
> > align callback name, aml_dma_chan_resume()
> >
> > > +     dma_dev->device_terminate_all = aml_dma_terminate_all;
> > > +     dma_dev->device_issue_pending = aml_dma_enable_chan;
> > aml_dma_issue_pending()
> >
> > Frank
> > > +     /* PIO 4 bytes and I2C 1 byte */
> > > +     dma_dev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) | BIT(DMA_SLAVE_BUSWIDTH_1_BYTE);
> > > +     dma_dev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
> > > +     dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
> > > +
> > ...
> > > --
> > > 2.52.0

