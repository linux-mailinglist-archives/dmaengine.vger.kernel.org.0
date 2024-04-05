Return-Path: <dmaengine+bounces-1741-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA6B899639
	for <lists+dmaengine@lfdr.de>; Fri,  5 Apr 2024 09:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE2722817E4
	for <lists+dmaengine@lfdr.de>; Fri,  5 Apr 2024 07:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030FD364A0;
	Fri,  5 Apr 2024 07:07:28 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3942C69E;
	Fri,  5 Apr 2024 07:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712300847; cv=none; b=XHm2fqUfDQ9WGEvJ225lNnnC9KwLprKWU2bk8bfMx2wwYBogA5A21YXsvuks+YugGaX1vRitS8fdzncnIOg45rvcEXmRtBAetKd0EXfRW0QuR2HyJn4lLafv9PTlQ+lvYwD50hj24gwZf8rugNPAQBlvi6zyOlmgFlfADyOZliE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712300847; c=relaxed/simple;
	bh=EnBfKJNKx8Lb92ksB092SRIblL3m9D2Eg+W82HiE+Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jn9UolZpPeKzlH/lD9JaJ3YGbS7NX10Z/NBEV1CISoSYVmzAPaz0ft+sQnVy7N5VGr4klSMjLF8nxipJ3pjxyrkUZaLi2IV3ZCJWpnj2kTM0PfM6GKnl8Jx+PE7//JF2xhtpT3uSBVJdtX1YRj188/WdfFeaWn4zl5uPEEAYExo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rsdfM-00FT5L-3A; Fri, 05 Apr 2024 15:07:13 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 05 Apr 2024 15:07:29 +0800
Date: Fri, 5 Apr 2024 15:07:29 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Andre Glover <andre.glover@linux.intel.com>
Cc: tom.zanussi@linux.intel.com, davem@davemloft.net, dave.jiang@intel.com,
	fenghua.yu@intel.com, wajdi.k.feghali@intel.com,
	james.guilford@intel.com, vinodh.gopal@intel.com,
	tony.luck@intel.com, linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: Re: [PATCH 0/4] crypto: Add new compression modes for zlib and IAA
Message-ID: <Zg+jMc/shIgX11lP@gondor.apana.org.au>
References: <cover.1710969449.git.andre.glover@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710969449.git.andre.glover@linux.intel.com>

On Thu, Mar 28, 2024 at 10:44:41AM -0700, Andre Glover wrote:
>
> Below is a table showing the latency improvements with zlib, between
> zlib dynamic and zlib canned modes, and the compression ratio for 
> each mode while using a set of 4300 4KB pages sampled from SPEC 
> CPU17 workloads:
> _________________________________________________________
> | Zlib Level |  Canned Latency Gain  |    Comp Ratio    |
> |------------|-----------------------|------------------|
> |            | compress | decompress | dynamic | canned |
> |____________|__________|____________|_________|________|
> |     1      |    49%   |    29%     |  3.16   |  2.92  |
> |------------|----------|------------|---------|--------|
> |     6	     |    27%   |    28%     |  3.35   |  3.09  |
> |------------|----------|------------|---------|--------|
> |     9      |    12%   |    29%     |  3.36   |  3.11  |
> |____________|__________|____________|_________|________|

So which kernel user (zswap I presume) is clamouring for this
feature? We don't add new algorithms that have no in-kernel
users.  So we need to be sure that the kernel user actually
want this.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

