Return-Path: <dmaengine+bounces-7679-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24678CC410A
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 16:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8F6E30BA737
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 15:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E429D363C59;
	Tue, 16 Dec 2025 15:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZfYoZg2V"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013051.outbound.protection.outlook.com [52.101.72.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE853363C4C;
	Tue, 16 Dec 2025 15:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765899532; cv=fail; b=dq0nEx/zKFJ3Ms6PHgj/7hDty6iPNo5m8kcDbhoZyIuAUInkZd9z3yQWOcj75UEcJ0xZsX40BZ4YULbJxfwqeL+H1uaVx3KcHsUzHttC/qR6sbeTyD6appg/kSM8dcO6vs7xKbG6E5fQzHGDePvabP8iRpkwza8mkqbDcUHTXLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765899532; c=relaxed/simple;
	bh=HmiRcYjOkJLB/iVbB8WrE726tHBfARQXKkaMpNZDmNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rvVA+aEk4czfVyqqzS0S2FXfewwX/9+96zdGpZrl35v+jOy6bSbJ1O1WFItO52wo/Ew7kprZRuXkokHMyrj91+WcjuS2vg5SXIcnNpy23CV+n8arlb/DVT9uafbhMpYgvYGfYa+03RalkkAPqEF1PZpWHX8sfVjWvIhXYOdMpLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZfYoZg2V; arc=fail smtp.client-ip=52.101.72.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VUXsxB6yLbNZnonq3HpkLVxwPt/VTGGJ2DQBmCYBmqPEr+ftw1tuzdNgiI6+HYVNMHvxBXZ6cTgnaOXo/wHSs7xP+nS1lzPrY1xd2yS8QeHF1SGvmVa/LSauSk7Ejczlr/9x5oitPRd0ZwYgML1FM094htc9Nf40yGewOV5d8fHZY/aB2j5NU+61ItFGEP2rmA3syTYPXej8oASavpep8qyQHVETGi9DS4n2GT9RbZDPzzulqLnL4+GCuSFz6IPvdTeLWaozYWBJ9SZiEXqlrUr1OgZVGFo1qa09S4N+D7qSo3ySn6I2+lp2uYVWsHijBhq9Bi/nC7+HiwhLWpYXXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SKYxlRR7J59bMHXOizSVzUDWa4AJnmS7lvS4QkqqOI=;
 b=xtSy3Yu3+dcPeB3QmVjW2sc2EhKiDbnoDkfLjG/dPg739/Jt/jfrbHFpKDw8AjKKdEvtnvzRhvCDachTQAU/btGuJxVkHKkZa1HqvGLDOfovhkzamm3qEVq7kbJ1nda8HPezJ7UjU3cb0B+AhKRX8IsR7Qwetw0aOpwuUuppTcXxhiS3Dr22Y07jor9oG7ON/aEJa4qTMr9ANTez0mteNTVb4zyW3ablMyjA86AulYgxPl/rggffejMCdxSXoKpZl0fG5A2/fUtQ1y9OWSIJ+stYtkN/GuxgtoBPowY9BtIQEy9YeuTToONl1mjV+ArVRUmTXLuQ+Ur7d5Q5p0rXzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SKYxlRR7J59bMHXOizSVzUDWa4AJnmS7lvS4QkqqOI=;
 b=ZfYoZg2VeoFOQCmNsNDGSHe8LjO3GNpZ8bWNKM8BH05eJ22T+vwA6DklvOot3Ac2HznkWc35KtpKH4cZFwmLu/DPKAzo3ilzWE2/TXrR9zADdfgZDk+sjl036nTysoSGx5zryxUe+nfujt6jEVcejxvk1JhP2fPjKELaHrcUf/kK4bVdp+/mkM6OIx9dq9S63StM23DoKqtOQYPr+dROhf+44noK7R8rZJK3SECrUGSfCOB37bvJLbqwNwbmjzfoYjyukXbDdwA4gH518zCGZknA7cOm9zrGOdmID1FRWPVGkJ2dhnEsZl21H8ocrPH+aYdj5ebNs7KXiZqkvprVSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by PA4PR04MB9221.eurprd04.prod.outlook.com (2603:10a6:102:27d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 15:38:46 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 15:38:46 +0000
Date: Tue, 16 Dec 2025 10:38:38 -0500
From: Frank Li <Frank.li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: jeanmichel.hautbois@yoseli.org, Angelo Dureghello <angelo@sysam.it>,
	Greg Ungerer <gerg@linux-m68k.org>, imx@lists.linux.dev,
	dmaengine@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] dma: mcf-edma: Add per-channel IRQ naming for
 debugging
Message-ID: <aUF8/r6FZcPraINk@lizhi-Precision-Tower-5810>
References: <20251126-dma-coldfire-v2-0-5b1e4544d609@yoseli.org>
 <20251126-dma-coldfire-v2-2-5b1e4544d609@yoseli.org>
 <aScnArV/22L5VmxP@lizhi-Precision-Tower-5810>
 <aUF6CdS6WVZuEP24@vaman>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUF6CdS6WVZuEP24@vaman>
X-ClientProxiedBy: BYAPR01CA0038.prod.exchangelabs.com (2603:10b6:a03:94::15)
 To DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|PA4PR04MB9221:EE_
X-MS-Office365-Filtering-Correlation-Id: b191531d-c870-4a15-4c98-08de3cb9333f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jWu8jn+gnifaEnWwFUSmCQJL6fJyu3G8ag6uO5dwlXsEWrIbIYoJMXZL9fw4?=
 =?us-ascii?Q?/5S4UBQPZP7m2WfyquTjAUx3yvcAA4lDaES4rDyuyEDw7fi0I3T+VBzQECkd?=
 =?us-ascii?Q?mN/0IxudeumTK8jQJGszBOYTvyNhwEgPZyqUzliJZm0TkKGbqQoQgNmGkyK1?=
 =?us-ascii?Q?4dgDKe/a5TNX5O3UD9se8wshTcO6/JtOA+hzEHTc42yIW2yQ7G7nA7k+syTK?=
 =?us-ascii?Q?CaxDNbvyAijsnTtRq3OMHuhuq/gcZstdamQaHFzOkTTqIhvpTe0nQo9AUlcJ?=
 =?us-ascii?Q?OfXfuIixpmSXhL0chxI2pufkUWMzTqM41HsCqjxKoL3jjKw/gYRIluVZXkmm?=
 =?us-ascii?Q?8WIQJl/MBKNQAOTMxhsR/SaGYFVsC2nIim0jDIFfeuqz2wntvZ8zbykTFBZF?=
 =?us-ascii?Q?aXckGeWDXInITP40O1xbZGaTyGM5+iCWR6d/CSZ90xLNGODX8V8W7lxI4+Je?=
 =?us-ascii?Q?z0UukrCtbSNMiTB7WzlZTan3twS2wYbcKmkmBLBMJTr3hLUVBv8FwIgxumOe?=
 =?us-ascii?Q?VgIwkMC9Q/ub1rYMd56o5NBT2POiUNhhPWjuFtJAlpQDr8iEES7nC/mh3RX/?=
 =?us-ascii?Q?tBfi5QBXHZuKdvnv1wY7Q/pQp2pVvBKmb44I0xYoBMLGUDAFpSSoNw5gy20G?=
 =?us-ascii?Q?ID43uN+nf834dMXIqRFATLA+FQspFwlZoRn8UKJws+LTK1OPHTLECdYx77CA?=
 =?us-ascii?Q?1K7W36tTf8VIpXN+fs7zbl7cC+41sxSwuRsj5HtxULqdpNbcRpwB9ww+Bbmh?=
 =?us-ascii?Q?CX3ro+uYO79CFGSmiGtbF9P7fdL9KkfAVbE1QtxdTE20wLQWsu71AkZqkXqa?=
 =?us-ascii?Q?g/GcsZY6UgqFRxK01kHtBGo199jzWBQJgHWTiNSFBvpFIzfnjwUU9x9lnz99?=
 =?us-ascii?Q?7bpR9Td9iT4YbvpbtTeM/vvDdVem5x8MkV69mNBG1hUeCfVFxTCJU4T59GUE?=
 =?us-ascii?Q?OrI9g6nSI6ffjjldXzhCtQi4Ez36T5iMTcMJvOeZQ2EaU1vIssvE4ZqNkfO2?=
 =?us-ascii?Q?Iol7qugNjbBbuVTdCMdpaZ4drjWdqm9yOnkzh3o1nU75zIk5z8DNyt2wZU2W?=
 =?us-ascii?Q?9oawGXFuzkBmxmuoj6s64TwLJupIb7bSb6dSPpa4Z+gWg+l39STlMOZvJsV8?=
 =?us-ascii?Q?md7ZkhPrAJVeYtl9ZdzY8cctfJcVyFMGflkOIVtC5joQaGJ1AbY66z1hwDxv?=
 =?us-ascii?Q?R4nhuNFQKFPDf202n+8gwUUJs4f2BFFggWcXZoMhT19G28Fq90+NmAZg6UOV?=
 =?us-ascii?Q?UI+w2Fp/M3dPF9Y2+BW1bdjai6K0zrxt2wHvmxYc2BnYwLvvYeEaIZj9xrpI?=
 =?us-ascii?Q?1Lj8R0/w9Uvin/IgLdk5XO16j8Urr7nv8FhB63T6b42zH5tOb1UtXfjUkzbm?=
 =?us-ascii?Q?OCZ+qTh6EXFVHcwkRgqF18LhZds6Lw1T5qSkiyVbHkFXGdSQFVkobyp0hAWd?=
 =?us-ascii?Q?0lTIhgS5C181MvHCvRFam1m6SQJWt7iq3MOpe2QS+KBMAMSZu79H/OzUYp35?=
 =?us-ascii?Q?MJfTyIBdN2yqsYhDJmTKHNPOfeIRj8VgLd4u?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JZJO4GwJiPqS2L6bMa1VxS6DNrImXeOsQ4fY00zEIV81NkPlIxXmBHVaGleA?=
 =?us-ascii?Q?gVnn2msoyyirv40D66rNi3SjlkNH+wcIbbRJgpnZ9PdUllYtVxibAyHhKoxh?=
 =?us-ascii?Q?DL782WKp9INigU1ekz82yJVv3mFeFxeGZbJX/iK9VaqnRZ3984XaSpLbo8GP?=
 =?us-ascii?Q?lJXYmz4xQE9/LmSlwVL1wF9txE+GXxmBluNTjQkCOyvwVhyfzmpZpnW9O9xn?=
 =?us-ascii?Q?SKKs8rn4AXygH2iD+FXAmSX6qPbm6s2J80gShvggzcIJLM2Cm6kcUryajXXV?=
 =?us-ascii?Q?U06WcCW2kJNZOpIjOfHCtbfpvlGlY2ZokcXT7gHzUBHxG957uhR3Nf5DJTNL?=
 =?us-ascii?Q?0aAnbC2k+HB0pQ3dkxfFTsWL/v5taWKam9pN4K7uWB6WLKhM2SFQetGlQJyh?=
 =?us-ascii?Q?1AFyiE3Bz3NOybTmfmnMaK95sqIUMeSIprKDle0R/NqaA9mPpXNqNovcBEBP?=
 =?us-ascii?Q?h6EQjSfHWU5WFJl6Tch405eIQ219keGy2lXkYv8YA0ydHi1TVV8CvnBbApQV?=
 =?us-ascii?Q?jy4f3vOIlYQB8aYeQdSHOyU7vnnVMn61ucmtCm7m+D8bnyt2i59w9Bo1/Npc?=
 =?us-ascii?Q?8xSLIGNmFbB6+hriOeGJg3VZHEa0Hqch4+Ow+gd/OFLcIcvLZrcUytk9lKqb?=
 =?us-ascii?Q?P2n1O119ONTXDEp7l8nmDU3F+1/2hM7CqLIJhldKXcA5VSuxTdMgeZJ2+D9z?=
 =?us-ascii?Q?mYjqkw5uLjxKQXPXw9+T6J4VDHXg5VecEpa9gq3hJN0WUP9DyHd1NJa75xM9?=
 =?us-ascii?Q?ybCwSYX7Z1m3UWS1D9BiGdHTy4zuJOi0zCUH7XJahG5pzSw12fY2EPIviEu2?=
 =?us-ascii?Q?sZKqUf1Zjn7tSV0m/gZVnrQP0jv0hxUTV3UcyS9lBLP2ODAPkYSK+NnSqpJT?=
 =?us-ascii?Q?i8DOLIxowPtz00m6VlftqO2mXAw6qa5reWtJiDMUMbOBuX7V3yy9jGieYJI4?=
 =?us-ascii?Q?0GbcSyIH3kYOqYqF65MZIV05g1u/lHKHIQMIBhm+OMhg9YrgIgutE7ZUOyvT?=
 =?us-ascii?Q?sd0dZ9Zv+fXJaLud3jUarW8efXuDOgMBT3vGfaVJKlN9ILKFSmTsOtVxtyc7?=
 =?us-ascii?Q?Bjl/HKzxGl3a6WF7uxWOS77BNmWIo0qmrmKR1hPF28j6mPGVQtyzIIAlvfw7?=
 =?us-ascii?Q?NEzh9WVmUNymd9n9cerQ/fZoXEdpOrwI6INolHi0uF3AEfKEzHrp9y8r2weM?=
 =?us-ascii?Q?LFjWmOlQ9TVAJ0DnWIjkDp0EqJRHbI1NN7tHJuVVRMpLSbhMLB9QFSnu9jN4?=
 =?us-ascii?Q?FPGcmsNpBAK8JwkQg8dEhTEdvaLiH89sZ4MdN17UZ1HAACRiyGy4xGR2/b2j?=
 =?us-ascii?Q?9/YkUzvWkT8Y+BK1JdGSlaHb4zp/OrJoC8RHabCoM7dIQ8Kls8Lk8xhfCllk?=
 =?us-ascii?Q?/JWLz+LeMByEEA8PgPFWh6Ty9VvkC8gI+gT5mE/casyk5GvhGgt8N6s0qu8B?=
 =?us-ascii?Q?IIVYEFZVsUTgRYWLNoj1KXaev2BYmuvdxb/TFusmMC+dMTwhnJofNIb4bCnL?=
 =?us-ascii?Q?RrHGoEMPuFl1s1E0Eko2YxjLTCo/YbCtXkmVIKrreKFUbsP1KR+72CMogpRy?=
 =?us-ascii?Q?Zn0whc+5yd1gXa+8mLtWf0f/0/0GhHtWUDGflLOO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b191531d-c870-4a15-4c98-08de3cb9333f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 15:38:46.0859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cAZe4EW8vB5zQqbAvOyV1pEpFmusJ0GZ7ZQD9znK8WFrWV1M9fL/+1CohBRLyMPrwPp04YCOcyMzMfeLmH+E/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9221

On Tue, Dec 16, 2025 at 08:56:01PM +0530, Vinod Koul wrote:
> On 26-11-25, 11:12, Frank Li wrote:
> > On Wed, Nov 26, 2025 at 09:36:03AM +0100, Jean-Michel Hautbois via B4 Relay wrote:
> > > From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> > >
> > > Add dynamic per-channel IRQ naming to make DMA interrupt identification
> > > easier in /proc/interrupts and debugging tools.
> > >
> > > Instead of all channels showing "eDMA", they now show:
> > > - "eDMA-0" through "eDMA-15" for channels 0-15
> > > - "eDMA-16" through "eDMA-55" for channels 16-55
> > > - "eDMA-tx-56" for the shared channel 56-63 interrupt
> > > - "eDMA-err" for the error interrupt
> > >
> > > This aids debugging DMA issues by making it clear which channel's
> > > interrupt is being serviced.
> > >
> > > Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> > > ---
> > >  drivers/dma/mcf-edma-main.c | 26 ++++++++++++++++++--------
> > >  1 file changed, 18 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
> > > index f95114829d80..6a7d88895501 100644
> > > --- a/drivers/dma/mcf-edma-main.c
> > > +++ b/drivers/dma/mcf-edma-main.c
> > > @@ -81,8 +81,14 @@ static int mcf_edma_irq_init(struct platform_device *pdev,
> > >  	if (!res)
> > >  		return -1;
> > >
> > > -	for (ret = 0, i = res->start; i <= res->end; ++i)
> > > -		ret |= request_irq(i, mcf_edma_tx_handler, 0, "eDMA", mcf_edma);
> > > +	for (ret = 0, i = res->start; i <= res->end; ++i) {
> > > +		char *irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
> > > +						"eDMA-%d", (int)(i - res->start));
> > > +		if (!irq_name)
> > > +			return -ENOMEM;
> > > +
> > > +		ret |= request_irq(i, mcf_edma_tx_handler, 0, irq_name, mcf_edma);
> > > +	}
> > >  	if (ret)
> > >  		return ret;
> >
> > The existing code have problem, it should use devm_request_irq(). if one
> > irq request failure, return here,  requested irq will not free.
>
> Why is that an error!

        ret = fsl_edma->drvdata->setup_irq(pdev, fsl_edma);
        if (ret)
                return ret;

if last one of request_irq() failure, mcf_edma_irq_init() return failure.
probe will return failure also without free irq.

So previous irq by request_irq() is never free at this case.

Frank

>
> >
> > You'd better add patch before this one to change to use devm_request_irq()
>
> Not really, devm_ is a not always good option.
>
> --
> ~Vinod

