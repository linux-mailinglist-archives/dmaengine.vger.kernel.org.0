Return-Path: <dmaengine+bounces-828-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C3783D6DF
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jan 2024 10:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13DAB295E03
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jan 2024 09:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E687412B7C;
	Fri, 26 Jan 2024 09:00:12 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A0A51C26;
	Fri, 26 Jan 2024 09:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259612; cv=none; b=B/TBkjI6zsW2r+WMc5TSpPJFZILkdN5z/K1cSznLYhXZ6iJX8SWjXbi/VHCR+XK1uqFhQ8g3RJIRE6V7mHOFEXUs4QkkktN83wqxRKB0Xn1WUqkWGqQhbAiVNSOK765mdjCi4+veS0mQK3yiXRqrvIBxndJ0t6TGa0ujGI7xisk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259612; c=relaxed/simple;
	bh=kOkPe13PZ9nRiXrBdZLTfIKaB5agjBUgj++JJpMbqb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1E8W/Nw7TgcQ2Crps84XiuTMF6NP2UfVeT+hUoA68JWZeUunPFl0PsaJLubA7FGptFbrEK/L4n5cDe+1dNJcjQU7AJU6HdQJg2u6abx4/rgJq5dTuJQ8PsgVyckP9mY7/o2bC/nrBe2HHKHr7n5ceQV1n1/5IVwE2pvZAe7FQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rTI49-006EdX-8S; Fri, 26 Jan 2024 17:00:02 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 26 Jan 2024 17:00:13 +0800
Date: Fri, 26 Jan 2024 17:00:13 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: davem@davemloft.net, fenghua.yu@intel.com, dan.carpenter@linaro.org,
	dave.jiang@intel.com, tony.luck@intel.com,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: Re: [PATCH] crypto: iaa - Remove header table code
Message-ID: <ZbN0nS0krktSqB51@gondor.apana.org.au>
References: <8bde35bf981a1e490114c6b50fc4755a64da55a5.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bde35bf981a1e490114c6b50fc4755a64da55a5.camel@linux.intel.com>

On Mon, Jan 08, 2024 at 04:53:48PM -0600, Tom Zanussi wrote:
> The header table and related code is currently unused - it was
> included and used for canned mode, but canned mode has been removed,
> so this code can be safely removed as well.
> 
> This indirectly fixes a bug reported by Dan Carpenter.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-crypto/b2e0bd974981291e16882686a2b9b1db3986abe4.camel@linux.intel.com/T/#m4403253d6a4347a925fab4fc1cdb4ef7c095fb86
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>  drivers/crypto/intel/iaa/iaa_crypto.h         |  25 ----
>  .../crypto/intel/iaa/iaa_crypto_comp_fixed.c  |   1 -
>  drivers/crypto/intel/iaa/iaa_crypto_main.c    | 108 +-----------------
>  3 files changed, 3 insertions(+), 131 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

