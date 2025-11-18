Return-Path: <dmaengine+bounces-7246-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C94C688D8
	for <lists+dmaengine@lfdr.de>; Tue, 18 Nov 2025 10:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C97434EBA84
	for <lists+dmaengine@lfdr.de>; Tue, 18 Nov 2025 09:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395BB30E85C;
	Tue, 18 Nov 2025 09:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cB7/7yKs"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE7730E844;
	Tue, 18 Nov 2025 09:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763458268; cv=none; b=cO4Hfn5wbniFGBoj/Y+8nIMqFA4vwk5ScD8JubTKFJh2VAjR5Izi9+fRhiX9yd24ChjbnCx911quyjiJPKIcgnYSfMWu26wn6JViADdcN5i/QiKNOEQ3PkHM/zdMT0YbhVa6/RFPYvVU2gpf2Z0Rq0W75HLqzBfGT3h7piTmOi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763458268; c=relaxed/simple;
	bh=4TNZaT8r5tzBuSY3hFUraN8mTq+40kMaWLjGphPl704=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2ZyiYN6NP0pnMFxdKr+7gXvAb63eK1Y/ppOJkEhaJMvAEtx6bksKUGumuM9f8+sWCpoUZG/YObqW2Zmm0kw5ZKswhkXgtS/hKzfWYas7VLRSczfi18jWhxNbMEdAwOBxBfWisNQYgOzZ6Utv4Do8ayqQ/YuIyS0O64tBmDRr1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cB7/7yKs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA20C2BCF5;
	Tue, 18 Nov 2025 09:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763458265;
	bh=4TNZaT8r5tzBuSY3hFUraN8mTq+40kMaWLjGphPl704=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cB7/7yKsYW5zcoNXxPLoosK5pEYjRXemT9O5ORibCxixJHPDGRtCu0muXPWVoV+VM
	 nNPVF6KDW84fesz7WWm1zpDTOU7aUk0wLqDwj4wC3SB60FMSgB4R0u51hv8V7h6mAS
	 EA/JPH4gtXylKs16griK4l6rovEaPLGGhS7Xe4sjRlvMD3lwWJ4M1hZUAJtn+aEACl
	 tEEezdOEQtK81XJnlQU1XPNQLYmGwbjIDj/rHuvc/Mqda0mbyCUPbUxuEapYH0dfLz
	 /e4J2EGqVWuxcE7uvDTF5sg5EuUsXUKuE0feZjdSxK/q9Iyh92dG1fWq0CHGnmASSa
	 qq3lXte8SBFyg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vLI3C-000000000eb-3pHg;
	Tue, 18 Nov 2025 10:31:02 +0100
Date: Tue, 18 Nov 2025 10:31:02 +0100
From: Johan Hovold <johan@kernel.org>
To: Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Ludovic Desroches <ludovic.desroches@microchip.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>
Subject: Re: [PATCH 09/15] dmaengine: stm32: dmamux: fix device leak on route
 allocation
Message-ID: <aRw81nFwZv3I0gq_@hovoldconsulting.com>
References: <20251117161258.10679-1-johan@kernel.org>
 <20251117161258.10679-11-johan@kernel.org>
 <ec4001b1-e7b5-4d7d-8665-2b5d5a843c8c@foss.st.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec4001b1-e7b5-4d7d-8665-2b5d5a843c8c@foss.st.com>

On Tue, Nov 18, 2025 at 09:11:30AM +0100, Amelie Delaunay wrote:
> On 11/17/25 17:12, Johan Hovold wrote:
> > Make sure to drop the reference taken when looking up the DMA mux
> > platform device during route allocation.
> > 
> > Note that holding a reference to a device does not prevent its driver
> > data from going away so there is no point in keeping the reference.
> > 
> > Fixes: df7e762db5f6 ("dmaengine: Add STM32 DMAMUX driver")
> > Cc: stable@vger.kernel.org	# 4.15
> > Cc: Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> 
> Reviewed-by: Amelie Delaunay <amelie.delaunay@foss.st.com>

Thanks for reviewing.

Johan

