Return-Path: <dmaengine+bounces-5238-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EA7ABFC03
	for <lists+dmaengine@lfdr.de>; Wed, 21 May 2025 19:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2B2500F49
	for <lists+dmaengine@lfdr.de>; Wed, 21 May 2025 17:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3242C22B8AD;
	Wed, 21 May 2025 17:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrwU0zOU"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BBE1804A;
	Wed, 21 May 2025 17:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747847419; cv=none; b=FXFVSHrkjtNorx3NXujqG2PeJorirpzOQj1eTOWwXjU/OcPOFv5NAjv2HA4UW+3vLCUVUlnEUha5V693/Dnj09ORoy6MhPoDvyOnfUdksLbJqcpcs85sScwVKNSXwDhTRsMqL+sVYwe6aQ3UQs/F/279IgrIfUVKdGCNGQ0g2ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747847419; c=relaxed/simple;
	bh=3iZ5XlrgSAzvl+Df3Xaebobi0tSpgqE1kaPbxKLo3ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGmCWPvLaU8XelkO2+zaXV0q595msHP8ZfBEEg0VC63Oqm5U/6czDNvleF7pmISTHI34GdSeCB0MShnf29gw9QkvrXvwCVvwIZ3dCqtS+Uzvj51vojSUa4ClQ3hJk6U64LPaQuC1QddUAegxjS+xIGaXVQOMYvbpKIZrMfLKsOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrwU0zOU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C80C4CEE4;
	Wed, 21 May 2025 17:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747847417;
	bh=3iZ5XlrgSAzvl+Df3Xaebobi0tSpgqE1kaPbxKLo3ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YrwU0zOUlqwws9gChusShZmks40qBF657KzzjrCttxjoH1V8Y36OVHER0wbPevG6Q
	 +UwQNKVzAA8Ma/hYctVKg+ZQpa51uX8HtW3e9LoXsHUo6586bJ/fEQB3VI05WJ/iEh
	 Ap2LiteMU6PNd9y9nt44kkAyibgYgyrcAdNvcQoJ/5T+SB/e2yMxYgkD/e4a8epSy0
	 BL3MAXHI7Fxj98KusJCnkN9MwF7wlxCfRuALNjqCNE/eo2eapz5pVsbxkB0kiSyLtf
	 TQVULgK4OHGpsUmZC9Ojm9utIlq4HL3SR6N6U8ftGId75NZCJ1si5uXvuYQUjYW7w2
	 RYccPWYtwgCag==
Date: Wed, 21 May 2025 10:10:15 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: vkoul@kernel.org, chenxiang66@hisilicon.com, m.szyprowski@samsung.com,
	leon@kernel.org, jgg@nvidia.com, alex.williamson@redhat.com,
	joel.granados@kernel.org, iommu@lists.linux.dev,
	dmaengine@vger.kernel.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com
Subject: Re: [PATCH 3/6] dmatest: move printing to its own routine
Message-ID: <aC4I9zsJwA-zmx66@bombadil.infradead.org>
References: <20250520223913.3407136-1-mcgrof@kernel.org>
 <20250520223913.3407136-4-mcgrof@kernel.org>
 <ea9543a9-36ec-47e3-9fb9-21ea350cbd93@arm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea9543a9-36ec-47e3-9fb9-21ea350cbd93@arm.com>

On Wed, May 21, 2025 at 03:41:38PM +0100, Robin Murphy wrote:
> On 2025-05-20 11:39 pm, Luis Chamberlain wrote:
> > Move statistics printing to its own routine, and while at it, put
> > the test counters into the struct dmatest_thread for the streaming DMA
> > API to allow us to later add IOVA DMA API support and be able to
> > differentiate.
> > 
> > While at it, use a mutex to serialize output so we don't get garbled
> > messages between different threads.
> > 
> > This makes no functional changes other than serializing the output
> > and prepping us for IOVA DMA API support.
> 
> Um, what about subtly changing the test timing and total runtime
> calculation, and significantly changing the output format enough to almost
> certainly break any scripts parsing it? What definition of "functional" are
> we using here, exactly? :/

Sure, we can keep the old format if that is the preference.

> Also the
> mutex doesn't prevent *other* kernel messages from being interspersed, so
> multi-line output still isn't really stable.

*other* sure -- but for this test it makes things legible, otherwise its
quite re-ordered.

  Luis

