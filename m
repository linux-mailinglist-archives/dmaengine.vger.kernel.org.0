Return-Path: <dmaengine+bounces-5673-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E22AEBEA3
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jun 2025 19:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 242053AA3DE
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jun 2025 17:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835532EACE5;
	Fri, 27 Jun 2025 17:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXH39/Ji"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AD12EA148;
	Fri, 27 Jun 2025 17:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751046925; cv=none; b=Jjgma94XDT74JxoSW5sPon+gvuTjIn9LqU9owUZ+Cot74d62dlPakQRxabaMc/VQ/VObJOqSblH8uR/YJOw19w/gAlNzUxRnVURlPAKv7dlGNjswJtR4r2yIyeVDsRHQqvxJdJSU1UX+tOIS6eIhVvQmb38hzksC9mTSIy6YVPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751046925; c=relaxed/simple;
	bh=6LasMqfktwXjxLkmVFQoTEiDolHKYIMdvtywsS2PGb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtoVxXF0zk8MEzQTh4pUojo0lZIXgElNA0Z3meZ8mxskJEPpEx30S/MyPy6XmJcxnh/SuBbRn3RHVk7i7Hor2QeixoOGfufyOJ9sdlxbLTGcvuHc4nZr2rgNlPkT3wijdWlwKcH4R3ukCvav61bZlsdTRnSqR++jMxVqLYRtLBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXH39/Ji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD60BC4CEE3;
	Fri, 27 Jun 2025 17:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751046924;
	bh=6LasMqfktwXjxLkmVFQoTEiDolHKYIMdvtywsS2PGb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BXH39/Ji6dizHnDsGPPS0C82L7ZKwD30NwHJgogsYN98h3+KEFZVEzonKlgYJkLXG
	 7aimOf85Ivs5VzMmyXUAkUZ538UPgz9lAhuCG7Mfi53oJ53ArDzOP4Y1N/gepk8DdA
	 dWmFigIvflJzATOfjcnjnbdZ4h5LV56NojUjwzcnkhskTRFqbcoeAtI8ij04xIkCvj
	 fF3m82QbLoNyU1SaK7pxA2/sfQ+/7DvIehkB+X9mmn85UrooCe/guYQ9784FKQsJnj
	 zpNR91cSKdDPuDaVWkS0n/mfIYEZ4hNLqqSkzeiABdk7tEv9epU7pGN7zyiQj6FLwQ
	 6HISzP35aUoYA==
Date: Fri, 27 Jun 2025 10:55:24 -0700
From: Vinod Koul <vkoul@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yi Sun <yi.sun@intel.com>, gordon.jin@intel.com,
	yi.sun@linux.intel.com,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Fenghua Yu <fenghuay@nvidia.com>
Subject: Re: [PATCH v2] dmaengine: idxd: Remove __packed from structures
Message-ID: <aF7bDA-evv2IsMoi@vaman>
References: <20250404053614.3096769-1-yi.sun@intel.com>
 <175097809157.79884.15067500318866840512.b4-ty@kernel.org>
 <aF4YdFZnAWcZlpbW@surfacebook.localdomain>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF4YdFZnAWcZlpbW@surfacebook.localdomain>

On 27-06-25, 07:05, Andy Shevchenko wrote:
> Thu, Jun 26, 2025 at 03:48:11PM -0700, Vinod Koul kirjoitti:
> > 
> > On Fri, 04 Apr 2025 13:36:14 +0800, Yi Sun wrote:
> > > The __packed attribute introduces potential unaligned memory accesses
> > > and endianness portability issues. Instead of relying on compiler-specific
> > > packing, it's much better to explicitly fill structure gaps using padding
> > > fields, ensuring natural alignment.
> > > 
> > > Since all previously __packed structures already enforce proper alignment
> > > through manual padding, the __packed qualifiers are unnecessary and can be
> > > safely removed.
> 
> [...]
> 
> > Applied, thanks!
> 
> Please, don't or fix it ASAP. This patch is broken in the formal things,
> i.e. changelog entry must not disrupt SoB chain. I'm not sure if Stephen's
> scripts will catch this up on Linux Next integration, though.

Thanks for letting me know. My script didnt catch it, will check why.
I have fixed it up now

-- 
~Vinod

