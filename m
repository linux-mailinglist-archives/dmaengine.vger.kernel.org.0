Return-Path: <dmaengine+bounces-3172-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2A797A2A9
	for <lists+dmaengine@lfdr.de>; Mon, 16 Sep 2024 15:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60C0A282195
	for <lists+dmaengine@lfdr.de>; Mon, 16 Sep 2024 13:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C159F149C57;
	Mon, 16 Sep 2024 13:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TNj0vtnW"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F99B5258;
	Mon, 16 Sep 2024 13:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726491675; cv=none; b=TW4wUJQp9ZgtYnhjvxc7Svdx8+uNEgfOCm57q/oEVRsihA94RG0n3yGnGCq4qqrusiGzs2z749sNRMtkyVwDIRP1Q8mIbYk6OF4AkyK9ubigtib/pQSlahZ9t2l6hNLJYDZmnTHnivS8IxoEsdNMnNoYq6DwXaByFHB8dc1KfPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726491675; c=relaxed/simple;
	bh=j7bSUys93ObWt3OtvDUnT0xDtlaBv+KVRugKt1kf19g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8rbhfGorH7teCbULNxBobNHrgzgJl+1+PDUPdTRtluWUagqW1v57mJ71rS9F/1XEIp+k9BXVytEG97fGwvm7aFWJCcqlCaBfZE0mMN8QxXHP4KZIY/+9ZU740lXEo+T+ZhRyZpbzYcWmoRsEDpsvgnxIezMCgr4+FwDqsssmO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TNj0vtnW; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726491674; x=1758027674;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j7bSUys93ObWt3OtvDUnT0xDtlaBv+KVRugKt1kf19g=;
  b=TNj0vtnWZUldXWcHLosR3h40OvvM8SdXQc7KsXLYIblB3HpWIweuSy1Q
   31INbAYuyUffbiy77nonPLzoQavUsqnBkl9GXO8lwyWG7z0TJqU7nycIq
   Ia+/lMrv1HXsh7L4AJzp0VgDZB+ABLldRKMTHBRAjHdMERuIKTCKrAbIT
   kj85mGB0+GtRI8fU1Yehn7/lOS1BqAUuIno8wy+UsizWd7TWADv8kPYDI
   96BfVHqWsnG9xegY4pyY1qSeiaptWpryRU4JVjvSGgCVnaWEjd67l57oo
   w6T9i0ijyMo7EIt5YRwjXaWSotc1kin0Bhm2VhJEBhGDK9fr9dWfBHt6J
   Q==;
X-CSE-ConnectionGUID: +wS5mDScTJisbZ4rFLLUww==
X-CSE-MsgGUID: YM6dGbKYTUalHRfzQT9F/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11197"; a="25515162"
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="25515162"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 06:01:13 -0700
X-CSE-ConnectionGUID: 6OyAobFTRV+Fx5THtpB0rw==
X-CSE-MsgGUID: xIK6dYO9Sbaf6Rw/pl9pmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="68966109"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 06:01:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sqBLo-00000009SuL-2gGh;
	Mon, 16 Sep 2024 16:01:08 +0300
Date: Mon, 16 Sep 2024 16:01:08 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Serge Semin <fancer.lancer@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, dmaengine@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] dmaengine: dw: Fix sys freeze and XFER-bit set error
 for UARTs
Message-ID: <ZugsFPWRZQnH9RaS@smile.fi.intel.com>
References: <20240911184710.4207-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911184710.4207-1-fancer.lancer@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Sep 11, 2024 at 09:46:08PM +0300, Serge Semin wrote:
> The main goal of the series is to fix the DW DMAC driver to be working
> better with the serial 8250 device driver implementation. In particular it
> was discovered that there is a random system freeze (caused by a
> deadlock) and an occasional "BUG: XFER bit set, but channel not idle"
> error printed to the log when the DW APB UART interface is used in
> conjunction with the DW DMA controller. Although I guess the problem can
> be found for any 8250 device using DW DMAC for the Tx/Rx-transfers
> execution. Anyway this short series contains two patches fixing these
> bugs. Please see the respective patches log for details.
> 
> Link: https://lore.kernel.org/dmaengine/20240802080756.7415-1-fancer.lancer@gmail.com/
> Changelog RFC:
> - Add a new patch:
>   [PATCH 2/2] dmaengine: dw: Fix XFER bit set, but channel not idle error
>   fixing the "XFER bit set, but channel not idle" error.
> - Instead of just dropping the dwc_scan_descriptors() method invocation
>   calculate the residue in the Tx-status getter.

FWIW, this series does not regress on Intel Merrifield (SPI case),
Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

P.S.
However it might need an additional tests for the DW UART based platforms.
Cc'ed to Hans just in case (it might that he can add this to his repo for
testing on Bay Trail and Cherry Trail that may have use of DW UART for BT
operations).

-- 
With Best Regards,
Andy Shevchenko



