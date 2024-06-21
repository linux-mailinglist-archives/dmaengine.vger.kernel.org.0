Return-Path: <dmaengine+bounces-2487-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63700911C73
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jun 2024 09:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CFF81F22E9F
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jun 2024 07:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E44016B743;
	Fri, 21 Jun 2024 07:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNq1eGwh"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE34B14038F;
	Fri, 21 Jun 2024 07:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718953755; cv=none; b=kNz81AyO+ZN1y08ONMVG3znUJ7udcceOEQr/VDWKYhn8wBbugRnzKCIHyKM+wD/S+gBnKP7WAeSrb9cEtQXpFqZ6Ep+7sjQRHvbQN+SYVmBMohWxgP7Kh1IqNDAb2cZz6NPT1qUfeaSotODsoAgVSMT4KfX9tG4NKi/f13i6cVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718953755; c=relaxed/simple;
	bh=u0vhe0zqMs5Sy8rTYox/NGGE8oBJtjiHtJOPAUxZARU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOp1h026NeLFiCw/jfUWq3+6SJV4W7fABoN9cicoHTSjFc09K4QcwdJa3hyWQQeDmNgzp/G3ZJIL8kUo4UBVvwDcPqmRf1jfz7tqgc1+fRmCJUFjufOVf9+Gwlkk5T92Mb6SawAHctMxA6D8o005CwEo1QnyXYBo2501Tmn/nw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNq1eGwh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D8AC2BBFC;
	Fri, 21 Jun 2024 07:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718953754;
	bh=u0vhe0zqMs5Sy8rTYox/NGGE8oBJtjiHtJOPAUxZARU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lNq1eGwhTNeOpkK9YsjekhMnPYqCfAedSVRmRHNMbdf4aeB/9D+zs1CrdzzASh6C4
	 Maf7DhWqeLVEpF4KQEehVBKMm1cJoVh9EPYfS+yepq3tAEjsydKxiI4rtjYFzFLCuR
	 K4G7MpuUTZdEm6yo6puU+n7u/0RTXerFzKxf55Nsf5kairPX2eyXlOQi8bBhCAYjqc
	 X/twLc6wl8sQTLvX/olSZYVRPkvixcmITIyfJDSYgj16lS797Ip960DrepCfU7mH7Q
	 6MKx+CIt1g2fhTe1olIQIEbjsh0QvACjeCVEG6doqO9oc6g6olhnMMeO5Qjbw2BTHF
	 Qcz/Pt9DgHS/w==
Date: Fri, 21 Jun 2024 12:39:09 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Markus Elfring <Markus.Elfring@web.de>, lkp@intel.com,
	Paul Cercueil <paul@crapouillou.net>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	oe-kbuild-all@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
	linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Julia Lawall <julia.lawall@inria.fr>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [v11 3/7] iio: core: Add new DMABUF interface infrastructure
Message-ID: <ZnUnFeum1Z2ahm9M@matsya>
References: <202406191014.9JAzwRV6-lkp@intel.com>
 <c25aab0d-48f6-4754-b514-d6caf8d51fd1@web.de>
 <ZnRUSaHJhz7XLcKa@matsya>
 <20240620170522.GU3029315@google.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240620170522.GU3029315@google.com>

On 20-06-24, 18:05, Lee Jones wrote:
> On Thu, 20 Jun 2024, Vinod Koul wrote:
> 
> > On 20-06-24, 12:45, Markus Elfring wrote:
> > > …
> > > > All errors (new ones prefixed by >>):
> > > >
> > > >>> drivers/iio/industrialio-buffer.c:1715:3: error: cannot jump from this goto statement to its label
> > > >     1715 |                 goto err_dmabuf_unmap_attachment;
> > > …
> > > 
> > > Which software design options would you like to try out next
> > > so that such a questionable compilation error message will be avoided finally?
> > 
> > The one where all emails from Markus go to dev/null
> 
> Play nice please.

Would love to... but Markus has been repeat offender

Sadly, I am yet to see a constructive approach or even better a helpful
patch which improve something, rather than vague suggestions on the list

-- 
~Vinod

