Return-Path: <dmaengine+bounces-1851-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB07D8A72BF
	for <lists+dmaengine@lfdr.de>; Tue, 16 Apr 2024 20:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051D81F21DCB
	for <lists+dmaengine@lfdr.de>; Tue, 16 Apr 2024 18:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1644B13440B;
	Tue, 16 Apr 2024 18:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bEUfc3NF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E2612EBCE;
	Tue, 16 Apr 2024 18:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713290458; cv=none; b=PS5P/0ZkUnmz1xJ9FkLP+2MG3+Dk5jedEvkCp4Qxr8wEioWNXPNIoSCw3ag8dpBpfyZie2sq1WVhyaKtjJsFpHejAOEU7yhzEZSmpHUNhROH3mqUZLOqvA6oTsZotrhf8CfJInGTio/z+HoFLGdRzuUbPBcoo+pGuCOo3KayVdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713290458; c=relaxed/simple;
	bh=SLEcQwrdeAyJMhsUpPs/WnfkDUuxw6+ip8W3cRvk0co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQwCjj0GhfrGUI/DLIWvT4FXQ67F0TCh/LSLYndcvUBUkg5wh+hIDWwS3x8XZYwSMyG9NTAHmu3OoGLVQ0YGE/0A9q1g5rAFC7K7ySixDkII4vulHUTBqlKNNm1uuCminw0nspFE6HmZgXn28/O7w7m/1IMYZYBxu4RwEWNeKZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bEUfc3NF; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713290457; x=1744826457;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SLEcQwrdeAyJMhsUpPs/WnfkDUuxw6+ip8W3cRvk0co=;
  b=bEUfc3NFS0M4y7Pky1k5ipynrK64UAqKGt6PSU5JpcauGMDRZdbxwMug
   YSC6y9QptD9NYt1Osrvk4Jz6Ow0/3Voh+OBVNORjevddzYaZCv+9HJKw/
   CCfDhljpj4KS2C03xX+WN5ueephWSyWMDqv2hfvqAlizC6tfok18Ne2BA
   emohluekBv3tgR8SqSmze630exkxABetFxVaJDirsoUUcMKL3vmJbeqTy
   5gEZaP5gKS8U6kAt67HOrX69GzwCCKluZlZnA+SoTeDIQ9QpYWJdpcpU7
   VJirddfwgQOGJrpZK5OzxYst9ovCvDAnhuAPTC2JjsWF69HYuLl1h0bLm
   Q==;
X-CSE-ConnectionGUID: teptYAYDQIWJfRYu5MGpQQ==
X-CSE-MsgGUID: c+XwvYTzRjq5a46ksPCwUA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8629024"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="8629024"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 11:00:56 -0700
X-CSE-ConnectionGUID: HhquDLfRQROq+SUyssmTNA==
X-CSE-MsgGUID: 8Pbg0ZewSZqGG9bjbWRyiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="27026244"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 11:00:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rwn6w-00000004mUp-3DzS;
	Tue, 16 Apr 2024 21:00:50 +0300
Date: Tue, 16 Apr 2024 21:00:50 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, dmaengine@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dmaengine: dw: Add peripheral bus width verification
Message-ID: <Zh680h4h6hURIb82@smile.fi.intel.com>
References: <20240416162908.24180-1-fancer.lancer@gmail.com>
 <20240416162908.24180-2-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416162908.24180-2-fancer.lancer@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 16, 2024 at 07:28:55PM +0300, Serge Semin wrote:
> Currently the src_addr_width and dst_addr_width fields of the
> dma_slave_config structure are mapped to the CTLx.SRC_TR_WIDTH and
> CTLx.DST_TR_WIDTH fields of the peripheral bus side in order to have the
> properly aligned data passed to the target device. It's done just by
> converting the passed peripheral bus width to the encoded value using the
> __ffs() function. This implementation has several problematic sides:
> 
> 1. __ffs() is undefined if no bit exist in the passed value. Thus if the
> specified addr-width is DMA_SLAVE_BUSWIDTH_UNDEFINED, __ffs() may return
> unexpected value depending on the platform-specific implementation.
> 
> 2. DW AHB DMA-engine permits having the power-of-2 transfer width limited
> by the DMAH_Mk_HDATA_WIDTH IP-core synthesize parameter. Specifying
> bus-width out of that constraints scope will definitely cause unexpected
> result since the destination reg will be only partly touched than the
> client driver implied.
> 
> Let's fix all of that by adding the peripheral bus width verification
> method which would make sure that the passed source or destination address
> width is valid and if undefined then the driver will just fallback to the
> 1-byte width transfer.

Please, add a word that you apply the check in the dwc_config() which is
supposed to be called before preparing any transfer?

...

> +static int dwc_verify_p_buswidth(struct dma_chan *chan)
> +{
> +	struct dw_dma_chan *dwc = to_dw_dma_chan(chan);
> +	struct dw_dma *dw = to_dw_dma(chan->device);
> +	u32 reg_width, max_width;
> +
> +	if (dwc->dma_sconfig.direction == DMA_MEM_TO_DEV)
> +		reg_width = dwc->dma_sconfig.dst_addr_width;
> +	else if (dwc->dma_sconfig.direction == DMA_DEV_TO_MEM)
> +		reg_width = dwc->dma_sconfig.src_addr_width;

> +	else /* DMA_MEM_TO_MEM */

Actually not only this direction, but TBH I do not see value in these comments.

> +		return 0;
> +
> +	max_width = dw->pdata->data_width[dwc->dws.p_master];
> +
> +	/* Fall-back to 1byte transfer width if undefined */

1-byte
(as you even used in the commit message correctly)

> +	if (reg_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
> +		reg_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
> +	else if (!is_power_of_2(reg_width) || reg_width > max_width)
> +		return -EINVAL;
> +	else /* bus width is valid */
> +		return 0;
> +
> +	/* Update undefined addr width value */
> +	if (dwc->dma_sconfig.direction == DMA_MEM_TO_DEV)
> +		dwc->dma_sconfig.dst_addr_width = reg_width;
> +	else /* DMA_DEV_TO_MEM */
> +		dwc->dma_sconfig.src_addr_width = reg_width;

So, can't you simply call clamp() for both fields in dwc_config()?

> +	return 0;
> +}

...

> +	int err;

Hmm... we have two functions one of which is using different name for this.
Can we have a patch to convert to err the other one?

-- 
With Best Regards,
Andy Shevchenko



