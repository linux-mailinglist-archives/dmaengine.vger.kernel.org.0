Return-Path: <dmaengine+bounces-1853-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C7B8A7446
	for <lists+dmaengine@lfdr.de>; Tue, 16 Apr 2024 21:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 009BC2829EC
	for <lists+dmaengine@lfdr.de>; Tue, 16 Apr 2024 19:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD34D137751;
	Tue, 16 Apr 2024 19:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LH8EjPjQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E81D132C37;
	Tue, 16 Apr 2024 19:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713294289; cv=none; b=i5ihKY1n1e4AEFImh+c7SUA68fsZ4R2Hu+zh7lHrtjxfhuTa8C77njB5Nc735IH1IEYsjVaRTdZ2dMsKa+9UvVJwlbc2IDfx5ySXzmtLTSj9YEUdldyC5zUFLPmspBLLgQPog5AEOsDnI8PqIQQav1GrND9fEvaP9NGP8tcbpVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713294289; c=relaxed/simple;
	bh=TMgqpUZdUJ/5xkRqaF/IXDu8yPiNOalFJmukz9JW/U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bgi3vd58WznM7vHYHSHz6+W8Y0A5dO59brLS2NHOMLzsnkrzXzrnTPCp2Zc5vkCM9sOvaZs9VcAvhvNiR33PEnPA5dz/RyI16WEg/sGLt3tMd/uPOjvKaAMpBE65z3xizZZrEmutHVyptTFqiYnLr+V9s4Oj3jVyZqyBOgL27ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LH8EjPjQ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713294288; x=1744830288;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TMgqpUZdUJ/5xkRqaF/IXDu8yPiNOalFJmukz9JW/U4=;
  b=LH8EjPjQ9kMnqcHC/0Thf2BNYoOLRSNnlstHO+TyGEiQ5S/7UQTxfdMz
   ATWegAk0Ob7kOFS0gONdiBZqixpDripkDNdGPm+Dcf9yeJz32y5LPL4OM
   BVGaE4Kf04frlHOw+P/dTXGqrCV9iFff2Um1p98mzUKixLvLFVDy6D6fm
   yIHAPZzJJejhIKBrHCPgJ81NKWPWwxZqPZjI90PQ9CeI321RdA80evK1j
   JrWg2XjocGI3okwLgm2MXWxhetIXUMwVVjmvzC5Y5zoF6KENAjDC3FJli
   xy3FFUeVagrF3bCQosYD1C0v0ZI2mHD/4I6V/UxHP+0OHa9Hrt7irvUO+
   A==;
X-CSE-ConnectionGUID: Q8klQHeTREiOBR5QPDL28w==
X-CSE-MsgGUID: BvxwkojESieeRMBf3LdJwA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="31239003"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="31239003"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 12:04:48 -0700
X-CSE-ConnectionGUID: 9g7G1PcwQDi+S9kVsWu9VQ==
X-CSE-MsgGUID: v4QV+caiSqyWtOBvrTsaCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="22833773"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 12:04:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rwo6k-00000004nZa-2j6x;
	Tue, 16 Apr 2024 22:04:42 +0300
Date: Tue, 16 Apr 2024 22:04:42 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, dmaengine@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dmaengine: dw: Simplify prepare CTL_LO methods
Message-ID: <Zh7LyszPd2sNfWRm@smile.fi.intel.com>
References: <20240416162908.24180-1-fancer.lancer@gmail.com>
 <20240416162908.24180-4-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416162908.24180-4-fancer.lancer@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 16, 2024 at 07:28:57PM +0300, Serge Semin wrote:
> Currently the CTL LO fields are calculated on the platform-specific basis.
> It's implemented by means of the prepare_ctllo() callbacks using the
> ternary operator within the local variables init block at the beginning of
> the block scope. The functions code currently is relatively hard to
> comprehend and isn't that optimal since implies four conditional
> statements executed and two additional local variables defined. Let's
> simplify the DW AHB DMA prepare_ctllo() method by unrolling the ternary
> operators into the normal if-else statement, dropping redundant
> master-interface ID variables and initializing the local variables based
> on the singly evaluated DMA-transfer direction check. Thus the method will
> look much more readable since now the fields content can be easily
> inferred right from the if-else branch. Provide the same update in the
> Intel DMA32 core driver for sake of the driver code unification.
> 
> Note besides of the effects described above this update is basically a
> preparation before dropping the max burst encoding callback. It will
> require calling the burst fields calculation methods right in the
> prepare_ctllo() callbacks, which would have made the later function code
> even more complex.

Yeah, this is inherited from the original driver where it used to be a macro.

...

> +	if (dwc->direction == DMA_MEM_TO_DEV) {
> +		sms = dwc->dws.m_master;
> +		smsize = 0;
> +		dms = dwc->dws.p_master;
> +		dmsize = sconfig->dst_maxburst;

I would group it differently, i.e.

		sms = dwc->dws.m_master;
		dms = dwc->dws.p_master;
		smsize = 0;
		dmsize = sconfig->dst_maxburst;

> +	} else if (dwc->direction == DMA_DEV_TO_MEM) {
> +		sms = dwc->dws.p_master;
> +		smsize = sconfig->src_maxburst;
> +		dms = dwc->dws.m_master;
> +		dmsize = 0;
> +	} else /* DMA_MEM_TO_MEM */ {
> +		sms = dwc->dws.m_master;
> +		smsize = 0;
> +		dms = dwc->dws.m_master;
> +		dmsize = 0;
> +	}

Ditto for two above cases.

>  static u32 idma32_prepare_ctllo(struct dw_dma_chan *dwc)
>  {
>  	struct dma_slave_config	*sconfig = &dwc->dma_sconfig;
> -	u8 smsize = (dwc->direction == DMA_DEV_TO_MEM) ? sconfig->src_maxburst : 0;
> -	u8 dmsize = (dwc->direction == DMA_MEM_TO_DEV) ? sconfig->dst_maxburst : 0;
> +	u8 smsize, dmsize;
> +
> +	if (dwc->direction == DMA_MEM_TO_DEV) {
> +		smsize = 0;
> +		dmsize = sconfig->dst_maxburst;
> +	} else if (dwc->direction == DMA_DEV_TO_MEM) {
> +		smsize = sconfig->src_maxburst;
> +		dmsize = 0;
> +	} else /* DMA_MEM_TO_MEM */ {
> +		smsize = 0;
> +		dmsize = 0;
> +	}

	u8 smsize = 0, dmsize = 0;

	if (dwc->direction == DMA_MEM_TO_DEV)
		dmsize = sconfig->dst_maxburst;
	else if (dwc->direction == DMA_DEV_TO_MEM)
		smsize = sconfig->src_maxburst;

?

Something similar also can be done in the Synopsys case above, no?

-- 
With Best Regards,
Andy Shevchenko



