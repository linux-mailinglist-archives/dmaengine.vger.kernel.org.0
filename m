Return-Path: <dmaengine+bounces-2450-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9247F910DB8
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2024 18:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48A931F2175F
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2024 16:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33FB1B3721;
	Thu, 20 Jun 2024 16:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bm9r+DOm"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B611B14FA;
	Thu, 20 Jun 2024 16:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718902550; cv=none; b=mq5H+qTFp5AUbD+iDliJdXjKRNiLePyV7EcMM/XmHSnfPqs3Uu1L/aZ2unOjCYlduVoVtxzRGMNGzLg2cEW7Y44hoVtsu/B23DneeD+z/qVcxWFmWsMrmXSx8ZCKuQKMD1rmxW2RtlFjtG5CFeJ1Qb41XDyPmS1VUo2X2vOUFRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718902550; c=relaxed/simple;
	bh=A1JugA1kRbqTImg1GS9MvseGGROAflYsVVNFO9Eymkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1OIB23y+u8n5ZGgMPmk9FPXAwPaOy8IELis8G2WcWcg3Xq0F0c0OsA8PdrrHkZSOdtHHBQqJOROWAfVlChEA9Oj8TKShcZXtvZ2u7WGlYy/ZimxftnyEhj5adZwL3XN26ZC2wVjdL7sNmNXsa+t883foDXqRxrzDJ8o9Ukvimw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bm9r+DOm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2819EC2BD10;
	Thu, 20 Jun 2024 16:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718902550;
	bh=A1JugA1kRbqTImg1GS9MvseGGROAflYsVVNFO9Eymkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bm9r+DOm3vNepyZmG6ENkJXODJ4erYYCurb/sueiOicXug5YBaF/ZvsWc1kuf2Bcx
	 84y2DMPf20XLlr9NkTnq01iTYH1oalYb+0VTdEwIUt594ddvmUTF/fxe5JoXObxsVJ
	 d7cMvBf8j/iSaw3cX0DcJ0fNU2V1UZpXbRisL6NxpjIwFUcebeVUmn49MjtOvoU1Sw
	 uZjN7cj1B6rpKCAajFXds+/ZDgPokPiCJfAnV2BD57EBsEdORYnqCwmtfJ3f+TPNr/
	 z0vae4nXfKteATQ3j7XBGOFASQy28ozvvsOGctSX3IJ0p5avNpqkSYg0K3y2JRkDFJ
	 uRs1NWFNQVb7A==
Date: Thu, 20 Jun 2024 17:55:43 +0100
From: Lee Jones <lee@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: lkp@intel.com, Paul Cercueil <paul@crapouillou.net>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Vinod Koul <vkoul@kernel.org>, oe-kbuild-all@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Julia Lawall <julia.lawall@inria.fr>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v12 3/7] iio: core: Add new DMABUF interface
 infrastructure
Message-ID: <20240620165543.GR3029315@google.com>
References: <20240620122726.41232-4-paul@crapouillou.net>
 <ca3efef9-9720-46be-a59d-a9a4c5873ea2@web.de>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca3efef9-9720-46be-a59d-a9a4c5873ea2@web.de>

On Thu, 20 Jun 2024, Markus Elfring wrote:

> …
> > v11:
> …
> >     - Use guard(mutex)
> >
> > v12:
> >     - Revert to mutex_lock/mutex_unlock in iio_buffer_attach_dmabuf(),
> >       as it uses cleanup GOTOs
> …
> 
> I would find it nice if better design options could gain acceptance.
> Will the chances grow to adjust scopes another bit for involved variables
> in such function implementations?
> 
> A) Enclosing a source code part with extra curly brackets?
> 
> B) scoped_guard()?
>    https://elixir.bootlin.com/linux/v6.10-rc4/source/include/linux/cleanup.h#L137
> 
> C) Moving a locked source code part into a separate function implementation?

I think it would help your cause if you quoted the exact piece of code
you're referring to.  Then tone down the language a bit - keep it as
simple and natural as you can.

Ex 1: Please place curly brackets around this section to aid with <reason>

Ex 2: To save N lines of clean-up, please use scoped_guard()

Ex 3: Moving out this chunk to another function would help with <reason>

Etc.

-- 
Lee Jones [李琼斯]

