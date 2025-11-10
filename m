Return-Path: <dmaengine+bounces-7124-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AB376C4762E
	for <lists+dmaengine@lfdr.de>; Mon, 10 Nov 2025 16:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5767B349E04
	for <lists+dmaengine@lfdr.de>; Mon, 10 Nov 2025 15:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C4F22538F;
	Mon, 10 Nov 2025 15:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONamQnDt"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3882C13D638;
	Mon, 10 Nov 2025 15:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762786882; cv=none; b=OK9j9jAPaS7HpDsxiwOVF7ABIysD0z1iDcjpgbVivCMYodA/40yOTLs04On70RwZh1iR76dlfgaC82O5NhKACIJyY1D9LVWmLzasdl9kDN2Kx769QI0bzSJXIvAyRTGR3DgVAsvHM0YFMVeq/l4YkFCZ5hsgHsSrOXMFGOtXuGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762786882; c=relaxed/simple;
	bh=Ao89H0EjkcwXVj9g8SuLAjvtSkWXCQ1U/p78QLpZKFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LaE/eN4GvzkXhosFrhGW6hZgKwhY3imWvXR5RlJYOuGGp48v5dIYXIiLIEJKt742GnzSQcgbVRngU4A0Riywyxl6Lcg+7UAzNEcbE6HAtIDplmhtCLSYZ9DMUjl7ipZEw0u7egD8SLCAHxvDgAAhRc6mZpzZLkGMAWIlDCq+o7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONamQnDt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E05C19422;
	Mon, 10 Nov 2025 15:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762786880;
	bh=Ao89H0EjkcwXVj9g8SuLAjvtSkWXCQ1U/p78QLpZKFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ONamQnDtP1ebBhZudUfAlK8M+CRqK8ZD4mj6kbsJOyUVDQW5+wxfH469PTVyALlkw
	 6ulJTJneVOsX4rFcHWwkCLPOZqSSGQt2VmPyQavms6nRr+BM9pR5XF+MIED+V6ITOL
	 rTEp4LmbSNft/8CuSctgsSSadzjPFFF/BztEUnGj8PwnOoSqOvux8pfyGFpFBCCW1l
	 5/PT35pY+zow1r1HRzrc1HyidS2Rfq0NZ1g6f/TIMouBfYGirvToaC/W4Qy34Zx1cq
	 3Qo4WgnQsO+3YDI44aiedy5Ecr/3aH0qdXrpPkEGxECDmp7uWDyP9lbqX2ZPLuGR6Y
	 7EQLiLDk8VBQg==
Date: Mon, 10 Nov 2025 09:05:26 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Stefan Wahren <wahrenst@gmx.net>, Vinod Koul <vkoul@kernel.org>, 
	Thomas Andreatta <thomasandreatta2000@gmail.com>, Caleb Sander Mateos <csander@purestorage.com>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, Olivier Dautricourt <olivierdautricourt@gmail.com>, 
	Stefan Roese <sr@denx.de>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Daniel Mack <daniel@zonque.org>, 
	Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>, 
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>, Michal Simek <michal.simek@amd.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 01/13] scatterlist: introduce sg_nents_for_dma() helper
Message-ID: <waid6zxayuxacb6sntlxwgyjia3w25sfz2tzxxzb4tkqgmx63o@ndpztxeh6o32>
References: <20251110103805.3562136-1-andriy.shevchenko@linux.intel.com>
 <20251110103805.3562136-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110103805.3562136-2-andriy.shevchenko@linux.intel.com>

On Mon, Nov 10, 2025 at 11:23:28AM +0100, Andy Shevchenko wrote:
> Sometimes the user needs to split each entry on the mapped scatter list
> due to DMA length constrains. This helper returns a number of entities
> assuming that each of them is not bigger than supplied maximum length.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/scatterlist.h |  2 ++
>  lib/scatterlist.c           | 25 +++++++++++++++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
> index 29f6ceb98d74..6de1a2434299 100644
> --- a/include/linux/scatterlist.h
> +++ b/include/linux/scatterlist.h
> @@ -441,6 +441,8 @@ static inline void sg_init_marker(struct scatterlist *sgl,
>  
>  int sg_nents(struct scatterlist *sg);
>  int sg_nents_for_len(struct scatterlist *sg, u64 len);
> +int sg_nents_for_dma(struct scatterlist *sgl, unsigned int sglen, size_t len);
> +
>  struct scatterlist *sg_last(struct scatterlist *s, unsigned int);
>  void sg_init_table(struct scatterlist *, unsigned int);
>  void sg_init_one(struct scatterlist *, const void *, unsigned int);
> diff --git a/lib/scatterlist.c b/lib/scatterlist.c
> index 4af1c8b0775a..4d1a010f863c 100644
> --- a/lib/scatterlist.c
> +++ b/lib/scatterlist.c
> @@ -64,6 +64,31 @@ int sg_nents_for_len(struct scatterlist *sg, u64 len)
>  }
>  EXPORT_SYMBOL(sg_nents_for_len);
>  
> +/**
> + * sg_nents_for_dma - return the count of DMA-capable entries in scatterlist
> + * @sgl:	The scatterlist
> + * @sglen:	The current number of entries
> + * @len:	The maximum length of DMA-capable block
> + *
> + * Description:
> + * Determines the number of entries in @sgl which would be permitted in
> + * DMA-capable transfer if list had been split accordingly, taking into
> + * account chaining as well.
> + *
> + * Returns:
> + *   the number of sgl entries needed
> + *
> + **/
> +int sg_nents_for_dma(struct scatterlist *sgl, unsigned int sglen, size_t len)
> +{
> +	struct scatterlist *sg;
> +	int i, nents = 0;
> +
> +	for_each_sg(sgl, sg, sglen, i)
> +		nents += DIV_ROUND_UP(sg_dma_len(sg), len);
> +	return nents;
> +}

We need an EXPORT_SYMBOL() here.

With that, this looks good to me.

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> +
>  /**
>   * sg_last - return the last scatterlist entry in a list
>   * @sgl:	First entry in the scatterlist
> -- 
> 2.50.1
> 
> 

