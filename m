Return-Path: <dmaengine+bounces-1783-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFC889B343
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 19:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B4991F21EDB
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 17:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436A13B799;
	Sun,  7 Apr 2024 17:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="R75a5KpT"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04olkn2052.outbound.protection.outlook.com [40.92.73.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD9114293;
	Sun,  7 Apr 2024 17:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.73.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712510555; cv=fail; b=i9rfm8MWC9lQ6BfNTjYose5rHGYD9UtYcCryM9xWzjE7SJqm8T8WbZrn5OdzPCoHtigCtrGDu/cLhj8oQOlC4OLdiTvpf+Te1DE2f6r6tk4mNSMaV9IYqs97nlS0Lv86+QLFqeF/nfc/YpqMJJYiklLjYxQ/vFmz2wPLETDUUuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712510555; c=relaxed/simple;
	bh=rtwS3234yERWrXkkQ8L34K6UeyNS5WyY/AEJk3h/SZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VeI9b2DGzmIayoiW7TWDVEf6VtazRNnEuDu10ooHFpsw3FKHXDxJ9fTehl57gWVe8zL8pd6/2RookodakQ168rv1OwQEz3PzsyWUef204rUXPpNRJsYvBpUIdxoJKoInf4tmq/A68Cl0g5PRWFvlwKZX+qdheWM78bEZEbR+L9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=R75a5KpT; arc=fail smtp.client-ip=40.92.73.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABKoj0qc/1eIudKLmMo23Q0Qk+OYx2sMdxIa2pTErECzZGcQeajm03erCMTfAXepHkrX7Z0Q0a3Tb0uYJahn3WEoKw/T0ZorilhbAGFX7MEl2S/k0cbmWZi4vFYzwpkotQ/eJK1A1nnbTk9c0Qv8tR7FbmqhRMfuZALyXptncuEydg5f9YTOIfBve+3cykO57WOsDBwvljVNdGyKFchSM9L1GCkeLOHs/afNdKrkMrL6R1qspgWGMRNZedjl32RmKgfRQRtO4/uNGYaXM9d5kJDBjRd13P+vbgvQKsOhMvjxHBwlK9JQxwbIyugBjOIH88bpsk8ePd+twK2uPPzKvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEryG27I48YY54S0Zw07kg3f8WywX+HdEEHrwIPat30=;
 b=fABxphtXsrmc13NSPZc3EKIe01kL6B4ntQaD0zYO+NdjGahWtzWShFS08i2SFDddgfbwtK6C2//x7c+8lsivV0zDaUUMD303QdJBiShjmz31HPmgDztLINLbseoOtCjGY1Ms1nUmd9Rw60pPdPLnCW8h/y8Uz5Irl4WcVakqcwEJCKAyn7mSqkcGGPnwMGaDADvHg9nHG/hxqXyXQS92nz18MbOB8VomWJnpEaRzB7PPBw63ezBQ4wNUZFA39uvCG5au1qAqGurCKne1VRNgo46hE0deS78FZB37J4/+yJ1MD5OfRzNBjwnZKMp2sOGobUNZEywfP1+Jxnr83KoXHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEryG27I48YY54S0Zw07kg3f8WywX+HdEEHrwIPat30=;
 b=R75a5KpTUcuSmhMN5ba4/ISF6vFTCIb8iamsgMPssQqqt1BadVMPIebihcJDK9L5QaLgfH6Lm21dO4rYB7r1zszlPEnykT4YUq8qDqlISEh4cvRkLYm8xeOSeSKn/JH4W7+sdbnle33V++St3c3z7cSbhfx3CaOiDXjUAztIHLlAU+QNyGoY7ANdygQHldDMFtnvQvkNbp4vQXpPy/NOeHbiYI2uIFyi1C+wwmqTPY6lDQplCBGyc5mvR1dF0UALSF0MLg6pKg6wGc9Wuw9+bTPu7hIYEI18rIJ/z1wMuZIZEt1nu6raMEUR4fA/T5PZZaaCoeAG8trTK4thTw/9Ng==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by DB4PR02MB9455.eurprd02.prod.outlook.com (2603:10a6:10:3f8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 17:22:30 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::9817:eaf5:e2a7:e486]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::9817:eaf5:e2a7:e486%4]) with mapi id 15.20.7409.049; Sun, 7 Apr 2024
 17:22:30 +0000
Date: Sun, 7 Apr 2024 19:22:17 +0200
From: Erick Archer <erick.archer@outlook.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Erick Archer <erick.archer@outlook.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: pl08x: Use kcalloc() instead of kzalloc()
Message-ID:
 <AS8PR02MB72376D27AA26F19A555F78208B012@AS8PR02MB7237.eurprd02.prod.outlook.com>
References: <AS8PR02MB72373D9261B3B166048A8E218B392@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <ZhKF-5P7O4rh_q2W@matsya>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhKF-5P7O4rh_q2W@matsya>
X-TMN: [Tbuv3V/atCinQnl1WQhNQyO4Ak2Vj4x4]
X-ClientProxiedBy: MA2P292CA0004.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:1::16) To AS8PR02MB7237.eurprd02.prod.outlook.com
 (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID: <20240407172217.GA1669@titan>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|DB4PR02MB9455:EE_
X-MS-Office365-Filtering-Correlation-Id: 4db6b77b-b9fc-44d2-c8d6-08dc57274d68
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VxkW0FrZ9irtZLxFPYpcRJJLV7FbrZoG/XPYrBQzT6dYrc5vA/i55R69gzv7Leqq38qdnhhawjx5fKg65llYhRNxdnKpYwgTdBUGnyMh7Hm7Pqvt9BasfUuMEkehJJwJepS1f4Yrcd0NI+unmF7g7UahAkObOG+PDOKzgiut19Os78f1NWPpuat5jkZX5mPY2POtk+stQppptPCePQTIt6ZYl4OR/1Zt2wIdFcWhz7u7hyiAI6MhOmt/fCbLwBJActAo7aI7njyXcWDqQYQW4n25a3cYb+x9a/HGfm9HzGxXoEl0B75GjI+iwS77Ym8m0UyyWz2ew6rX++tbBNX8Tf1vkK0dnxlPbJAre/N5cMCO8QDril2GhxUwWq9xBm+CKVmnPndoCmNfXOiiMEfke4Lo5wlQ2sq/BbjU1+w7KnGSyCPIYHbEOnLRqVvqIhZEVt821MAqnKAoWqWzNWdsJK5XyJyixlXly4TaCfZ9yZURlO5dfCfqGU8O332KDMNMD9siKUKuE7xXBk5HUuygFHrfmh28yf2E5g+C0PKv7sRc92J0nY7b+DiENVmPFoM1oJ6WyOhxRJAb8YT7bgh4tu0xEKjO8qz10dJH7AeJrL8NYTxG4PQrGR42w3Zz7oUDBDC8J72JZrsk95WzrXcc38FcM+0ocbdougyitU1CryKGXcPBOlM7pkj2MHS0EYwGTUyJrXerJHycuVRLm7gkaQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TWM8kk7wzJuCQxCsMfsz7m1l+M9x9SiN2lAM18X5t3tFd0G/JeR9oZb1CN7u?=
 =?us-ascii?Q?Dc3kxS+YVLeMR6mwm34Zqd2BLaxj7Q+BrTdQEwp/KYfihXGcy9+rps5c4/Ba?=
 =?us-ascii?Q?VOeIqabeX9S8sAVm/+K3/5t2w5/oZEQeqnhYhbW6PrDJrbxF5Cr4PBVBmPg6?=
 =?us-ascii?Q?anjceTGYsRDUZVTEowadSm0KcdU9P0i1XNZePsBMDVP6GxYGVpLXh5t8INa+?=
 =?us-ascii?Q?D6IRAZh1qDCODrG8ui85oNdg/zhhf+ab0WGtzwARyNS7m9hikxpNoFuNJAIG?=
 =?us-ascii?Q?ae3MsDJ2LhPdyTR3CnduOsvTCpnhKrPYUbBKjKMzPnzhYXPlakh3CL0sX75p?=
 =?us-ascii?Q?HSAHoCfGj0SmQBzUds4i/O903kyozONfQNlWehnhOzyWiYNQmb/Yq3LkgpXk?=
 =?us-ascii?Q?acqnCW4jDA2L8n4h4N0jXMGZmSikW/62IbHN3ZXBxx9MjrEABmr69DUBf8N6?=
 =?us-ascii?Q?/Ulbfq+Kl6a7p+PPoI9pNNVF2ew0FiOyq0QauQzOOKS/pDaV7U+shlCjjnj6?=
 =?us-ascii?Q?W5cPLyjwsMT4ZWCqrSFB6/UIAmQqy3FlKLpoQOxyPNo7NpCU2W0SAmp7hN5W?=
 =?us-ascii?Q?Q7C8+wUsHqAy8cm0/tPvDzf7QvrPDCaUAnOGyK+GTxOB7tGwQrViOR0vPvr6?=
 =?us-ascii?Q?cIysebrG1oi/bX4F8U81xZ/lu/nJNmeryIiBfxuf3PjgNKZhAb7Zf0ScZTjF?=
 =?us-ascii?Q?QxH+KzMazI03h6IsQv26OVqB98ectDRHojrwaa2/sL0syUw7k+khe0cZgd/3?=
 =?us-ascii?Q?syy75ysc3FFN50T20WFJE7qj/vldpBRjVv3BTenSnQQc7+ru0sODSW8zPch8?=
 =?us-ascii?Q?6aUhnibPygSGesjEWBUgEO9l656YEF6sTmRJ58YnuOVhEHxcZBHMH3Udz6qy?=
 =?us-ascii?Q?GfKn7tf1qPLL4PvZj2B8Q8BKPfJKSzX9ewbPCrg4CpphnaNw2XDSNVMM3jSm?=
 =?us-ascii?Q?p3Jbt5X4MZizCgtq2TnmUsrfe7p5kUazFCxLLsqfPDTyeau4qcMdHwsMeO1T?=
 =?us-ascii?Q?32tdIygCyNvvWhfXJMDd+J8QhenwHCkHixFOsu3wjB7GqtRxTkwP1ArKwlZB?=
 =?us-ascii?Q?YAiw/vjSQyM4bHMPC4DC9Carsn+zCeLS7b9sTeIz/03IUTU4siTZyb2UWYek?=
 =?us-ascii?Q?qaljBJkgjuMlJdqsGpZWrWv6lCUC3kv9cexk5sJAHy0eeub0b8w8YNCHnhfi?=
 =?us-ascii?Q?I2l/yZU9XaSLq4uwUL4unj5trqNS7+X6mzq1joAzN9RG7dbgpfR5vT1Yv8dA?=
 =?us-ascii?Q?EP6SZtjSBdwwcCkc2gUI?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db6b77b-b9fc-44d2-c8d6-08dc57274d68
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2024 17:22:29.9734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR02MB9455

Hi Vinod,

On Sun, Apr 07, 2024 at 05:09:39PM +0530, Vinod Koul wrote:
> On 30-03-24, 16:23, Erick Archer wrote:
> > This is an effort to get rid of all multiplications from allocation
> > functions in order to prevent integer overflows [1].
> > 
> > Here the multiplication is obviously safe because the "channels"
> > member can only be 8 or 2. This value is set when the "vendor_data"
> > structs are initialized.
> > 
> > static struct vendor_data vendor_pl080 = {
> > 	[...]
> > 	.channels = 8,
> > 	[...]
> > };
> > 
> > static struct vendor_data vendor_nomadik = {
> > 	[...]
> > 	.channels = 8,
> > 	[...]
> > };
> > 
> > static struct vendor_data vendor_pl080s = {
> > 	[...]
> > 	.channels = 8,
> > 	[...]
> > };
> > 
> > static struct vendor_data vendor_pl081 = {
> > 	[...]
> > 	.channels = 2,
> > 	[...]
> > };
> > 
> > However, using kcalloc() is more appropriate [1] and improves
> > readability. This patch has no effect on runtime behavior.
> > 
> > Link: https://github.com/KSPP/linux/issues/162 [1]
> > Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> > Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > Signed-off-by: Erick Archer <erick.archer@outlook.com>
> > ---
> > Changes in v2:
> > - Add the "Reviewed-by:" tag.
> > - Rebase against linux-next.
> > 
> > Previous versions:
> > v1 -> https://lore.kernel.org/linux-hardening/20240128115236.4791-1-erick.archer@gmx.com/
> > 
> > Hi everyone,
> > 
> > This patch seems to be lost. Gustavo reviewed it on January 30, 2024
> > but the patch has not been applied since.
> > 
> > Thanks,
> > Erick
> > ---
> >  drivers/dma/amba-pl08x.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
> > index fbf048f432bf..73a5cfb4da8a 100644
> > --- a/drivers/dma/amba-pl08x.c
> > +++ b/drivers/dma/amba-pl08x.c
> > @@ -2855,8 +2855,8 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
> >  	}
> >  
> >  	/* Initialize physical channels */
> > -	pl08x->phy_chans = kzalloc((vd->channels * sizeof(*pl08x->phy_chans)),
> > -			GFP_KERNEL);
> > +	pl08x->phy_chans = kcalloc(vd->channels, sizeof(*pl08x->phy_chans),
> > +				   GFP_KERNEL);
> 
> How is one better than the other?
> 
The advantage of kcalloc is that it will prevent integer overflows that
could result from the multiplication of number of elements and size, and
it is also a bit nicer to read.

However, in this case the multiplication is obviously safe but the best
practice is to use the two factor form if available (as explained in the
section "open-coded arithmetic in allocator arguments" of the "Deprecated
Interfaces, Language Features, Attributes, and Conventions [1]"

[1] https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments

Regards,
Erick
> 
> >  	if (!pl08x->phy_chans) {
> >  		ret = -ENOMEM;
> >  		goto out_no_phychans;
> > -- 
> > 2.25.1
> 
> -- 
> ~Vinod

