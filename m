Return-Path: <dmaengine+bounces-2494-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A428911E79
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jun 2024 10:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F19B28209D
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jun 2024 08:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3580C16C856;
	Fri, 21 Jun 2024 08:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZFGUieu"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D84155C82;
	Fri, 21 Jun 2024 08:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718958081; cv=none; b=uvR69YPPPOthDPfPWxtY+NiN/Bj6sxTf/wqtojvFGN1tvUSgwnuhZnG9rDXU9iMVbJ9FyMOnS5+ibEX5C7y5XQNribDwRf9xLmqhdi+8pimTsWaQVUTgdUP6uLRHWVc72U6PYhe7EQgD+LBE2e8hvZwnS5UHT3I8vxvt+hTyOdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718958081; c=relaxed/simple;
	bh=QMtf0T6uDNCP6ThgxIUGFi47LfMO2/ulDirJ4mXjisY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHkfZjYs+MKj7nwMqD2vGeW2c3pbILR8EAr3bE83VLXzpSd9z6/XdkVyHOjTDvDFI5UfFi1wVCp33Dtf6Qgtl4mFl67nKMjqUIDrVNfoZ/KppQ8QlxYiFOkQaXIiF3LKApsfB6MJfTKUavDgkslqkflDjjai0sk63OaAxIRFl8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZFGUieu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9536C4AF08;
	Fri, 21 Jun 2024 08:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718958080;
	bh=QMtf0T6uDNCP6ThgxIUGFi47LfMO2/ulDirJ4mXjisY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VZFGUieuixjnwWRarKrkMmWzTsHwOPQHkDnxJwsAOSI5Jhnj99ryVH33FrLocz8Vn
	 ajhhezpNAxlr4qrsLKoW8egu3wGklMisIPIGR7fvy4gfhGh2kxFSubfki8EmLTGeqC
	 FyNF6c+n9pHbcHgwI9omP7yG8Dbu5r7NL+bHQnZpXGWmAiNXQIhI61MO4uI4v+LAfB
	 xgTleMqki5tjcafqHOsHci8B6Shewb4T8SEsWCMvgeQoX2/IGg/+pD/hxyZbRFdj/5
	 60fqXFWW8FllRMXbMhWzg2/S3kF8EDze2ZQgoDbnj5FdlGcCcVmJHaUnZsK3Nklji7
	 ujcmBQOVYa8Nw==
Date: Fri, 21 Jun 2024 09:21:14 +0100
From: Lee Jones <lee@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: lkp@intel.com, linux-iio@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, Vinod Koul <vkoul@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	oe-kbuild-all@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
	linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Julia Lawall <julia.lawall@inria.fr>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [RFC] Patch review challenges
Message-ID: <20240621082114.GH1318296@google.com>
References: <202406191014.9JAzwRV6-lkp@intel.com>
 <c25aab0d-48f6-4754-b514-d6caf8d51fd1@web.de>
 <ZnRUSaHJhz7XLcKa@matsya>
 <20240620170522.GU3029315@google.com>
 <ZnUnFeum1Z2ahm9M@matsya>
 <ebddd644-b9b1-4a87-a2e7-dcf255f4184d@web.de>
 <20240621075123.GG1318296@google.com>
 <302ce128-a0ef-41b4-9808-210a83bc6a48@web.de>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <302ce128-a0ef-41b4-9808-210a83bc6a48@web.de>

On Fri, 21 Jun 2024, Markus Elfring wrote:

> > The issue is one of communication and the way reviews are conducted.
> >
> > Reviewing other people's work is challenging and requires a certain
> > skill-set, of which _excellent_ communication skills are non-negotiable.
> 
> Patch feedback and change tolerance can vary also according to involved communities.

Agreed.

For this community, I suggest you build your skills for a while longer.

> > Why not concentrate on more complex submissions for a while and grow
> > your repertoire of common review points,
> 
> Further collateral evolution can be considered there depending on
> corresponding development resources.
> 
> > rather than repeating the same few over and over?
> 
> Some factors are probably known also according to corresponding statistics.
> Several contributors are stumbling on recurring improvement possibilities
> in published information.

Right, this will always be true, however the few you've picked up on
are not important enough to keep reiterating.  By doing so, you're
receiving undesirable attention.

> > Reading other, more experienced maintainer's reviews would also be a good use
> > of your time.
> 
> I am trying to influence adjustments in desirable directions for a while.

Never stop trying to improve.


These are only my opinions of course.  Take the advice or leave it.

There's no need to reply to this.

-- 
Lee Jones [李琼斯]

