Return-Path: <dmaengine+bounces-1968-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DBC8B5054
	for <lists+dmaengine@lfdr.de>; Mon, 29 Apr 2024 06:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 577C21C21C0E
	for <lists+dmaengine@lfdr.de>; Mon, 29 Apr 2024 04:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8BBC144;
	Mon, 29 Apr 2024 04:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQNBQ/OW"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375C88BE2;
	Mon, 29 Apr 2024 04:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714366161; cv=none; b=L3IGEKlwunZ2lQMY5tX9YxXX59sO6QDM0+EejkvS3xKdwkP2mIIXR/2YwUT6BDtIYraIFFyDP/xJwQixVGN27GPpNCr9zLuCPKHTf5ILOMnVyEIa+Yxaf1+J8ef4Ilmz95pJG7QoQpIe/d4STIv86dAMs573H5DJBoC5NNkIM68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714366161; c=relaxed/simple;
	bh=Pe63LePjMb2wHzOe1goi1rwylL6odcnrORw6iB84RVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpgLDBi658+GR8sDnVpwXfELj0zwl7627P1pO5ZWDEj+A7NmeRfqEUK8409x/U6bnU8hQKB2a8yCNH5YFwp2yCzcNwIOQfNm+sG4lVQyJgiT7vHY5Omkll2zoZ+fI3IC32benXKVjTJXGb7n+rwKbbpl+YTy8mjbLlpU/wRFOoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQNBQ/OW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A37C113CD;
	Mon, 29 Apr 2024 04:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714366160;
	bh=Pe63LePjMb2wHzOe1goi1rwylL6odcnrORw6iB84RVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sQNBQ/OW3GPt1m4h0uwIn77iJZIryE1g05yK3qzgx8FPQusPhJkrJ6Fq11e5hPTDD
	 uhzy8xBayerts43Xz3eN+GJ728C5fVXrjQY3uXaQo2rA/qBZWBOneusS+4jtNPLT1g
	 1Q5qIRbEt1XR3rhk/HtID9modiLOCs5+J82OM0PsXWYcvmZX1wX6H6bd/GtxyUEtPO
	 8Sgoau8juqZMv3XN+thgthnHOPEo28XS7j2++BI6HjpriWfTv/t+9ZyQIwhgzQXyZ8
	 JUXqSm1K/CS7kv0HTPWj7ak3KZAEq8Wp+iLq0/6w1wqdi3xjce8XR5KBCC3BeFfYn3
	 b9BijfOI+GzHw==
Date: Mon, 29 Apr 2024 10:19:16 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	parthiban@linumiz.com, saravanan@linumiz.com,
	'karthikeyan' <karthikeyan@linumiz.com>,
	"bumyong.lee" <bumyong.lee@samsung.com>
Subject: Re: dmaengine: CPU stalls while loading bluetooth module
Message-ID: <Zi8mzMWubkfi9UiV@matsya>
References: <000001da6ecc$adb25420$0916fc60$@samsung.com>
 <12de921e-ae42-4eb3-a61a-dadc6cd640b8@leemhuis.info>
 <000001da7140$6a0f1570$3e2d4050$@samsung.com>
 <07b0c5f6-1fe2-474e-a312-5eb85a14a5c8@leemhuis.info>
 <001001da7a60$78603130$69209390$@samsung.com>
 <9490757c-4d7c-4d8b-97e2-812a237f902b@leemhuis.info>
 <8734a80b-c7a9-4cc2-91c9-123b391d468c@leemhuis.info>
 <ZgUTbiL86_bg0ZkZ@matsya>
 <2b2a6c9f-4df2-4962-b926-09adccd20715@leemhuis.info>
 <0b5da67a-7482-4f18-9246-9c118f182b8b@leemhuis.info>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b5da67a-7482-4f18-9246-9c118f182b8b@leemhuis.info>

On 25-04-24, 12:03, Thorsten Leemhuis wrote:
> On 28.03.24 16:06, Linux regression tracking (Thorsten Leemhuis) wrote:
> > On 28.03.24 07:51, Vinod Koul wrote:
> >> On 26-03-24, 14:50, Linux regression tracking (Thorsten Leemhuis) wrote:
> >>>
> >>> Vinod Koul, what's your option here? We have two reports about
> >>> regressions caused by 22a9d958581244 ("dmaengine: pl330: issue_pending
> >>> waits until WFP state") [v6.8-rc1] now:
> >>>
> >>> https://lore.kernel.org/lkml/1553a526-6f28-4a68-88a8-f35bd22d9894@linumiz.com/
> >>>
> >>> https://lore.kernel.org/all/ZYhQ2-OnjDgoqjvt@wens.tw/
> >>> [the first link points to the start of this thread]
> >>>
> >>> To me it sounds like this is a change that better should be reverted,
> >>> but you are of course the better judge here.
> >>
> >> Sure I have reverted this,
> >
> > Thx!
> 
> That revert afaics has not made it to Linus yet. Is that intentional, or
> did it just fell through the cracks?

Nope, it was sent to Linus last week and is now in -rc6...

-- 
~Vinod

