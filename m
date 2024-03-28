Return-Path: <dmaengine+bounces-1613-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C990B88FD4A
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 11:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73A011F25C58
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 10:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1943A7CF0F;
	Thu, 28 Mar 2024 10:44:28 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D143F53818;
	Thu, 28 Mar 2024 10:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711622668; cv=none; b=oG1aN3nTFwpdYQT7MBFfwWc7gG561pTtUc/aDeTLsAozX5ixEznjg0LyfDc6tQS6f3VuVv8onEQFk9Ub3LGEPqN5i5FYzYNCu+dJd5F6rkWAw0fhUqU8ntyCKczvTVmbwHgoQ+lure/VzYRvMciAp5uM/jd4LpNGn8YLqWOlRBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711622668; c=relaxed/simple;
	bh=mhF/HUvrBvoHvRE2SKCDRMWLPtYp46iCtm+XUxhGaXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHDYp9M6Mx162fxpQ5T90uP6Aw0l2ZfWliqRdbe3G2tZTMk2OZc/TP1HI1B3/Aje6REL8wmBtGy4LgBvdQrnkiYsUrltsaPxqbI7wnVYb53xN159BOWqvqG4hJ7vOPc3uGJbJAY5Dyh3n1HvofBxnGopS4cpd44Pi6K1pat+TAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rpnF1-00C8Ar-KN; Thu, 28 Mar 2024 18:44:16 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 28 Mar 2024 18:44:32 +0800
Date: Thu, 28 Mar 2024 18:44:32 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: davem@davemloft.net, andre.glover@linux.intel.com,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: Re: [PATCH 0/4] crypto: IAA stats bugfixes and simplifications
Message-ID: <ZgVKECpfxpxyrzfR@gondor.apana.org.au>
References: <20240304212011.1525003-1-tom.zanussi@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304212011.1525003-1-tom.zanussi@linux.intel.com>

On Mon, Mar 04, 2024 at 03:20:07PM -0600, Tom Zanussi wrote:
> Hi Herbert,
> 
> While doing some testing, I noticed a discrepancy in the
> decomp_bytes_in stat, which the first patch in this series (crypto:
> iaa - fix decomp_bytes_in stats) fixes.
> 
> I also realized that there were some other problems unrelated to that
> but also that the stats code could be simplified in a number of ways
> and that some of it wasn't really useful.  The stats code is debugging
> code and has been helpful to quickly verify whether things are
> basically working, but since it's there we should make it as accurate
> and actually useful as possible.
> 
> I realize the second patch (crypto: iaa - Remove comp/decomp delay
> statistics) removes the code I just fixed up in a patch you just
> merged (crypto: iaa - Fix comp/decomp delay statistics) - let me know
> if you want me to combine those if you want to remove the latter from
> your branch...
> 
> Thanks,
> 
> Tom
> 
> 
> *** BLURB HERE ***
> 
> Tom Zanussi (4):
>   crypto: iaa - fix decomp_bytes_in stats
>   crypto: iaa - Remove comp/decomp delay statistics
>   crypto: iaa - Add global_stats file and remove individual stat files
>   crypto: iaa - Change iaa statistics to atomic64_t
> 
>  .../driver-api/crypto/iaa/iaa-crypto.rst      |  76 +++++---
>  drivers/crypto/intel/iaa/iaa_crypto.h         |  16 +-
>  drivers/crypto/intel/iaa/iaa_crypto_main.c    |  13 +-
>  drivers/crypto/intel/iaa/iaa_crypto_stats.c   | 183 ++++++++----------
>  drivers/crypto/intel/iaa/iaa_crypto_stats.h   |   8 -
>  5 files changed, 140 insertions(+), 156 deletions(-)
> 
> -- 
> 2.34.1

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

