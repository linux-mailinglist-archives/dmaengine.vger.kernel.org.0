Return-Path: <dmaengine+bounces-672-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC9281FCCB
	for <lists+dmaengine@lfdr.de>; Fri, 29 Dec 2023 04:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA2A1285918
	for <lists+dmaengine@lfdr.de>; Fri, 29 Dec 2023 03:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818388BF6;
	Fri, 29 Dec 2023 03:29:17 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003EF8BF9;
	Fri, 29 Dec 2023 03:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rJ3YA-00FG3x-O9; Fri, 29 Dec 2023 11:28:43 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 29 Dec 2023 11:28:53 +0800
Date: Fri, 29 Dec 2023 11:28:53 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: davem@davemloft.net, fenghua.yu@intel.com, dave.jiang@intel.com,
	tony.luck@intel.com, jacob.jun.pan@intel.com,
	christophe.jaillet@wanadoo.fr, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 0/2] crypto: Intel Analytics Accelerator (IAA) updates
Message-ID: <ZY489YOIyeyf8DOk@gondor.apana.org.au>
References: <20231218204715.220299-1-tom.zanussi@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218204715.220299-1-tom.zanussi@linux.intel.com>

On Mon, Dec 18, 2023 at 02:47:13PM -0600, Tom Zanussi wrote:
> Hi Herbert,
> 
> Here are a couple patches that didn't make it into the last version of
> the IAA crypto driver.
> 
> Tested using both shared and dedicated workqueues, with no problems
> seen.
> 
> Thanks,
> 
> Tom
> 
> Tom Zanussi (2):
>   crypto: iaa - Change desc->priv to 0
>   crypto: iaa - Remove unneeded newline in update_max_adecomp_delay_ns()
> 
>  drivers/crypto/intel/iaa/iaa_crypto_main.c  | 8 ++++----
>  drivers/crypto/intel/iaa/iaa_crypto_stats.c | 1 -
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> -- 
> 2.34.1

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

