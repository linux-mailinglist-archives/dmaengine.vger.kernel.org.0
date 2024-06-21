Return-Path: <dmaengine+bounces-2492-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 168D0911D50
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jun 2024 09:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4ED8283DC2
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jun 2024 07:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E6216C865;
	Fri, 21 Jun 2024 07:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1hdrIkF"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32EC16C863;
	Fri, 21 Jun 2024 07:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956290; cv=none; b=ADDBXCttKrEFGMRwoYiqzeZRoIIVq9WQ0/4L+GxvFh6ChxdNm5DdlIkQT7vp68eoMHWo/c4fF8ZBNHO+KoiOa6TvAr+9+rjuHMAaopPmxnmVOP+Srx/JzRC53biwWyt3rTMjliQSwP0L3iUVOhbVjEgpFcc4Hbw6MW7xqFq9e78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956290; c=relaxed/simple;
	bh=1HCwf6TJ72c4wbSMsx0ToW1GLnhJDNJ8Afp1KOu+icw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rx35nSm/bIk/F2gMpukKUlLjpnhK3lNS3InMyfKO9BwLYMJMSpn8nAz/2IeJwEWlhop/kPBeM6LbGnW9vqPhJDTAnybCE13upazWHcMClJsJp9rt+LqwxOTe2u47X3f3/1E4aNt38fMy/LDqZFTDiCjIDr7/MQpTIRGq8wO7AX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1hdrIkF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC14C2BBFC;
	Fri, 21 Jun 2024 07:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718956289;
	bh=1HCwf6TJ72c4wbSMsx0ToW1GLnhJDNJ8Afp1KOu+icw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c1hdrIkFymyDz2jm9julINVwJdVh0apoGK/wOJgAfzgQciUyMpXO11gJeobnhyj/O
	 HN7aNcc5+7PxztjUyqA062UCdYMiPoQvViog8Xrv0y9bIxvqxsagAzJMmuVrgQIUup
	 I/cVid0PV0daHpnlqjFuqXeIQ2YCGm/gHAcyVU/o1rfRtE7Ii0RAwhucR+x/mYN8TM
	 XMF4h1coHHcuTt0dpExaF0Yl8kWq7sY0nbsfmm++caCX3/fl21wh20/1GCKj4vllQa
	 xuvf8a9Q3PYkXssVcn5yqcT7rOChpgLgCUWb09KCofzKUmVkGhexjOXcqgDrZIGyxv
	 1zwNw8HQda1fg==
Date: Fri, 21 Jun 2024 08:51:23 +0100
From: Lee Jones <lee@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Vinod Koul <vkoul@kernel.org>, lkp@intel.com, linux-iio@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
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
Subject: Re: [v11 3/7] iio: core: Add new DMABUF interface infrastructure
Message-ID: <20240621075123.GG1318296@google.com>
References: <202406191014.9JAzwRV6-lkp@intel.com>
 <c25aab0d-48f6-4754-b514-d6caf8d51fd1@web.de>
 <ZnRUSaHJhz7XLcKa@matsya>
 <20240620170522.GU3029315@google.com>
 <ZnUnFeum1Z2ahm9M@matsya>
 <ebddd644-b9b1-4a87-a2e7-dcf255f4184d@web.de>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ebddd644-b9b1-4a87-a2e7-dcf255f4184d@web.de>

On Fri, 21 Jun 2024, Markus Elfring wrote:

> > Sadly, I am yet to see a constructive approach or even better a helpful
> > patch which improve something, rather than vague suggestions on the list
> 
> Can you get any more constructive impressions from another data representation?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?qt=author&q=Elfring
> 
> Are you aware how many change suggestions (also from my selection) are still
> in various waiting queues?

No one is doubting your overall contributions Markus.

The issue is one of communication and the way reviews are conducted.

Reviewing other people's work is challenging and requires a certain
skill-set, of which _excellent_ communication skills are non-negotiable.

Why not concentrate on more complex submissions for a while and grow
your repertoire of common review points, rather than repeating the same
few over and over?  Reading other, more experienced maintainer's reviews
would also be a good use of your time.

-- 
Lee Jones [李琼斯]

