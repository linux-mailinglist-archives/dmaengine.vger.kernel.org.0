Return-Path: <dmaengine+bounces-1351-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8504879B0B
	for <lists+dmaengine@lfdr.de>; Tue, 12 Mar 2024 19:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92CAD283E3D
	for <lists+dmaengine@lfdr.de>; Tue, 12 Mar 2024 18:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536561386D8;
	Tue, 12 Mar 2024 18:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="tPNTFeWN"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D58953BE;
	Tue, 12 Mar 2024 18:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710267218; cv=none; b=CmeAj5cqQNCDjTlJufY6kBc9A94w1hlbmrzyDDJHEGm9Zmw5BPkvC1+mjqR4QB/FTkhcK+3bPIFoNGx9CK2vGp9hsfUwfWVErDX+k+MxCFW1bmp0bnqE1ka2CfIH1ktVvEaDpb8kNuI929O2ZANZN+Hy715NFwhtzydTESP2zeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710267218; c=relaxed/simple;
	bh=hxc39IxN819loZctbVccpqyWI+eMyY9INPmx5WaPeB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2yyONppB8aLHiuBJ+/4IpSb8y6kve5MYKTFO//y/9sGdDGSOZTPsvBnI+i/xnXUQQawgRNauKWYllHOqU1Cv0pHKdwnFQnUN05j5kW8qKuHT1pn0kSBTnJfgET+o8bNaSjjXqovtj9ysBkSxuVBw8j5jZRn2wpMv4xFoHXXPKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=tPNTFeWN; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id F18AE1F9EC;
	Tue, 12 Mar 2024 19:13:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1710267210;
	bh=biCYnQaSdIzs0N3kKvy+q3IdU7pUealwzctrdSLzqsc=; h=From:To:Subject;
	b=tPNTFeWN/WZKdC5cmw0WP7Kv8PM+xX6I4nz6sJ6LLFgyOi4DVQis3c3aQHCZJkuv/
	 gfq/j5tfQ7yCI2UBeWT5faIts+ZNcYZCCei4UJiGQOGXwZC9bTMRGQEu4VDalE5TWz
	 q6VxghgXTab+/aVp1zP4pHJZcKy5xcFSnzxsf1/QAvPxcz5uyU0AsGYtU0WIqFT/0k
	 6yfp1JP7aTW7QkJRpUCxFr7GquJYDbVf9i78yGB8PpV9zrAvkeOEKRXV6oUJYO/42E
	 i7+tMhr3/f+TD1oIQQYd27E2Togd9hv5GYyXV8xuAARWjXApgtAXc00wfwsCHnM3mc
	 UnqH+V87oxdSw==
Date: Tue, 12 Mar 2024 19:13:25 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	j-luthra@ti.com, j-choudhary@ti.com, francesco@dolcini.it
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Fix teardown timeout for cyclic
 mode
Message-ID: <20240312181325.GA4602@francesco-nb>
References: <20230821104003.3001021-1-vigneshr@ti.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821104003.3001021-1-vigneshr@ti.com>

Hello Vignesh,

On Mon, Aug 21, 2023 at 04:10:03PM +0530, Vignesh Raghavendra wrote:
> In cyclic mode, last descriptor needs to have EOP flag set so that
> teardown flushes data towards PDMA in case of MEM_TO_DMA.  Else,
> operation will not complete successfully leading to spurious timeout on
> channel terminate.
> 
> Without this terminating aplay cmd outputs false error msg like:
> [116.402800] ti-bcdma 485c0100.dma-controller: chan1 teardown timeout!
> 
> This doesn't seem to be problem with UDMA-P on J7xx devices (although is
> a requirement as per spec) but shows up easily on BCDMA + McASP. Fix
> this by setting the appropriate flag
> 
> Fixes: 017794739702 ("dmaengine: ti: k3-udma: Initial support for K3 BCDMA")
> Suggested-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>

Any update on this? Not sure what's the current status here.
How can I help?

Francesco


