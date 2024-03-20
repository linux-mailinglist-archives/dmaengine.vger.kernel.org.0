Return-Path: <dmaengine+bounces-1454-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3751F8815B9
	for <lists+dmaengine@lfdr.de>; Wed, 20 Mar 2024 17:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68BA01C22D69
	for <lists+dmaengine@lfdr.de>; Wed, 20 Mar 2024 16:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8073328F8;
	Wed, 20 Mar 2024 16:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RQbqhAni"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961EF23B0;
	Wed, 20 Mar 2024 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710952577; cv=none; b=p4ZfuasTDZWTOu52TXlLIFUdWHD/1rrhom2cOG+XlkNDUYEbV8DC2o26gNp8TkfmHTwNMjFVJq78AdHIszAjzSJy/bnVNX/MByjEhpGfs6q7dBj9tV8gEi/iB5C98XM8gei62xjygcIRfk8VXkoRZAgPvDbjdDfOy7XWlpcHi98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710952577; c=relaxed/simple;
	bh=IZWzUcUQSGNwdaxYBiV+HfK0sSMW26jM8b/iVcIFLzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcTHoTL5DhKRTnz0+KcGFi5vbFEQKkKpeodgvLmb/GX1LSb1/n1I+PR3qnRHHCvDWZKij0c5EYU2hDpj97Ne16egQC36C3s1zk9cYGlqcR+MFcn/p20Ix1mbrMY89F9xVBP9/sLtYdOcZm9bn10Acsyw8q9oPfNi4FwC+7o/IfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RQbqhAni; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710952576; x=1742488576;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IZWzUcUQSGNwdaxYBiV+HfK0sSMW26jM8b/iVcIFLzY=;
  b=RQbqhAniAN0KKUnpILdGLkhdjNzW9vNYbYqtuhkc4G6jbZIAnmX9Lxet
   d7zRK/1Csf864AcQKDtPJz50fuCTcf8iXMEAVO5breDl5VmycnHxB1Gjk
   Uuh7yD5pO5OQVvJGJ9NtThLXTPR+HSfWN9gwnWcOKqAA7zkJdrR+DQkjO
   J4Klm6K7KHiY7TCGdSy1WDp/zEyh/g4NF9I+01KGjBPu7vKycoPKFR4WA
   aEpN3mI5H1nHg6VPBohCkxgiV7BLYBOlb5yNcS6eiO5Dy3hNk6Idqbsx0
   0sPesK9Pw1qVZkAJe8GFv3fIg1mebl3e4EC74qGqkARhdZfrKHd538T0I
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="31324666"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="31324666"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 09:36:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="914672869"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="914672869"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 09:36:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rmyvC-0000000Ecch-3gnt;
	Wed, 20 Mar 2024 18:36:10 +0200
Date: Wed, 20 Mar 2024 18:36:10 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v1 1/1] idma64: Don't try to serve interrupts when device
 is powered off
Message-ID: <ZfsQeo8NxOuHVbfE@smile.fi.intel.com>
References: <20240320163210.1153679-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320163210.1153679-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 20, 2024 at 06:32:10PM +0200, Andy Shevchenko wrote:
> When iDMA 64-bit device is powered off, the IRQ status register
> is all 1:s. This is never happen in real case and signalling that
> the device is simply powered off. Don't try to serve interrupts
> that are not ours.

...

>  	dev_vdbg(idma64->dma.dev, "%s: status=%#x\n", __func__, status);

Dunno if I actually also need to move this message to after the checks...

> +	/* Since IRQ may be shared, check if DMA controller is powered on */
> +	if (status == GENMASK(31, 0))
> +		return IRQ_NONE;
> +
>  	/* Check if we have any interrupt from the DMA controller */
>  	if (!status)
>  		return IRQ_NONE;

-- 
With Best Regards,
Andy Shevchenko



