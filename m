Return-Path: <dmaengine+bounces-7657-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8EECC2E93
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 13:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9FBA311CAB2
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 12:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C29436A01C;
	Tue, 16 Dec 2025 12:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlpuBszh"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF3F36A018;
	Tue, 16 Dec 2025 12:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765887396; cv=none; b=ll1GnqI3FYphkiGc47tvorXO9m/CeU03H+KsLSHfVVjJWIRkBsLBYmLDE+x/YMgbzNCK+St1jOQEXKhrb6Kogs3FaW+DxkbemRBXCSFCd2ogWCvCLhrOf96npvgVZ0zYnfhEKabQX7cWegmXPpiZ0YZiFWAh4ROrOGdE+Z09VUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765887396; c=relaxed/simple;
	bh=Zu5Gma5Zt2VzwDhbpUgcuuudvUUPpSU4LYW8vUhb1dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEfjmWrGFWIAiDm4hl/G52uMQlhf0TxE8mxeeNeqJFgmSdwzkfrvRuyOt0JKk0HvrabP9ibhEeKMItdlmPsP++4V3X2FTABCcH5iJknxaioLUHu5jV3xXyOXYPmYHY+Bs3emifuNPOkl8JzxFC0RsrbwCOrrm+wOt7eC0mB6qBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlpuBszh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88F4C4CEF1;
	Tue, 16 Dec 2025 12:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765887396;
	bh=Zu5Gma5Zt2VzwDhbpUgcuuudvUUPpSU4LYW8vUhb1dY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MlpuBszhXWPTG/ykRC8Uc0PaSiD7zcoA+ORsynBjv8yNzazr7lyj3C7YuSo+M0k2G
	 dRIY/exJg6a2p+y5QGj01iNbkYabKEo6EFqS+dtZloArxeUATDKDtQN4kJyJTU5mSz
	 NhrAr319HrNISIV2ieHE+gzBywcXPcHk76fi9ThhjSBT6uLDMRXxMuHSevncbpO8mJ
	 r6f7wPzQic02XPHK79wUHyzthP7pB10Sipfb3QunKmJGPO+v4M3o6IdiAhNocgxH7n
	 OYKgKsIerCxnR7LI1W3LK510pc4pJ2Re3/eC+56hK0W0aUmV98FSixoAig1C1vBRUu
	 /d6DYrm/ildoQ==
Date: Tue, 16 Dec 2025 17:46:32 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ma Ke <make24@iscas.ac.cn>, peter.ujfalusi@gmail.com,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, stable@vger.kernel.org
Subject: Re: [PATCH RESEND] dmaengine: ti-dma-crossbar: Fix error handling in
 ti_am335x_xbar_route_allocate
Message-ID: <aUFNoIzaGjAi_4SP@vaman>
References: <20251215014249.11495-1-make24@iscas.ac.cn>
 <c0cc4abd-4000-4487-9837-e55c442c4d0d@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0cc4abd-4000-4487-9837-e55c442c4d0d@kernel.org>

On 15-12-25, 12:52, Krzysztof Kozlowski wrote:
> On 15/12/2025 02:42, Ma Ke wrote:
> > ti_am335x_xbar_route_allocate() calls of_find_device_by_node() which
> > increments the reference count of the platform device, but fails to
> > call put_device() to decrement the reference count before returning.
> > This could cause a reference count leak each time the function is
> > called, preventing the platform device from being properly cleaned up
> > and leading to memory leakage.
> > 
> > Add proper put_device() calls in all exit paths to fix the reference
> > count imbalance.
> > 
> > Found by code review.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 42dbdcc6bf96 ("dmaengine: ti-dma-crossbar: Add support for crossbar on AM33xx/AM43xx")
> > Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> > ---
> >  drivers/dma/ti/dma-crossbar.c | 24 ++++++++++++++++++------
> >  1 file changed, 18 insertions(+), 6 deletions(-)
> > 
> 
> 
> Just a note, author sends and resends same patches without addressing
> feedback. At least one case was very dubious or just incorrect code, and
> author just ignored it and sent it again to hide the previous
> discussion, so I suspect LLM generated content.
> 
> I did not review the code here, but please carefully review all patches
> from this author before applying and simply do not trust that this looks
> like a fix.

Right, I am very skeptical of random fixes coming in. Sometimes they
just follow a boilerplate pattern and fix, not attempt seems to be made
to check the environment and logic of fix..

> 
> Best regards,
> Krzysztof

-- 
~Vinod

