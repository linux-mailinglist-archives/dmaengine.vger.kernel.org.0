Return-Path: <dmaengine+bounces-1890-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0478C8A98FC
	for <lists+dmaengine@lfdr.de>; Thu, 18 Apr 2024 13:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF9B21F2355D
	for <lists+dmaengine@lfdr.de>; Thu, 18 Apr 2024 11:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF9615ECE7;
	Thu, 18 Apr 2024 11:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kmDKo+Uz"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC8E15ECD6;
	Thu, 18 Apr 2024 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713440974; cv=none; b=PibL8D/ZGqwjsCy9SHJaZ9mF9pS6v4OWaLyljwALotWQ9JLLJErV8CriAVrTwNe3R0rzdcC6Ud7VpLSgXyVhLV/FtGVTZyZp195yFCOJEZscHBqb1Pxc1KXfIT0E+UeHR9bWgPhHUHeeNZxm5iJhpGGsr4HEWqjxsoCPNIbfeuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713440974; c=relaxed/simple;
	bh=SU/rfWhGkYqdubvUaSDF/Y16iMQ9TRP/vqT/hswgmIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bF8oO+XENZubo0jrLKMqeyjEO7EpNocWBNhtf9Mdohr+wzWST6XK6GNJotj76k0tG174FvNqPCClqsacW+1kxPlD1Kfog2NrXlDlfIGdZMZOAHLiLIOW93aLoHH7ThgPHr0X9bz1yXCyrGfTi0o6SjeU4CQaMrMtiMdUn/dWA88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kmDKo+Uz; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713440973; x=1744976973;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SU/rfWhGkYqdubvUaSDF/Y16iMQ9TRP/vqT/hswgmIo=;
  b=kmDKo+Uz/MgY75XBrdCNCVfsdubZBQ00M9nP3uo4qDvHWx0BAdGIBAK3
   74VGcQ/5d5iqiIYgs8J1wBxjmmoWynqG6ZNwCHRe1P/IZ77IBTE+qrHzq
   gLojW6NSbwRY/8ZwAoz/HdpMvTc7+kYBDXcBDhYdovLGjiSYtE6CdWydo
   I7XanrP0+ZqnZxDOTq3xXwPm0gt+C9E0Nx0DngxIV+avyrCgS22kKPLeX
   yxBePoFrKw+qBx3QPV/XADhbE6wGCSzJIt+1YVLLz36eXkXdCHSi0Ei3u
   uVJXgfPAuY3kbbk4aZjYDP/qf7zH1OUDgVT3VitEtqWPOHkZ7pahY/w9N
   Q==;
X-CSE-ConnectionGUID: rPz8DEp5R7qXmBnvBa7h7Q==
X-CSE-MsgGUID: Gs8JqNGXQAKcihxUDlsi8A==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="20372827"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="20372827"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 04:49:31 -0700
X-CSE-ConnectionGUID: HiZ7wehvTC6AdQrzuj4B/A==
X-CSE-MsgGUID: z5uToZu3TTqQwTvyFQQ1eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="22941834"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 04:49:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rxQGc-00000000JaB-2Bwo;
	Thu, 18 Apr 2024 14:49:26 +0300
Date: Thu, 18 Apr 2024 14:49:26 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, dmaengine@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] dmaengine: dw: Simplify max-burst calculation
 procedure
Message-ID: <ZiEIxq8dHxObrYZx@smile.fi.intel.com>
References: <20240416162908.24180-1-fancer.lancer@gmail.com>
 <20240416162908.24180-5-fancer.lancer@gmail.com>
 <Zh7NfmffgSBSjVWv@smile.fi.intel.com>
 <tez5uqt4lg2qf5nooxuqo2rqhkqzzzbpeysdcbljokznbztkhj@j5t7cy4gd4pd>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tez5uqt4lg2qf5nooxuqo2rqhkqzzzbpeysdcbljokznbztkhj@j5t7cy4gd4pd>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 17, 2024 at 11:35:39PM +0300, Serge Semin wrote:
> On Tue, Apr 16, 2024 at 10:11:58PM +0300, Andy Shevchenko wrote:
> > On Tue, Apr 16, 2024 at 07:28:58PM +0300, Serge Semin wrote:

...

> > > +static void dwc_verify_maxburst(struct dma_chan *chan)
> 
> > It's inconsistent to the rest of _verify methods. It doesn't verify as it
> > doesn't return anything. Make it int or rename the function.
> 
> Making it int won't make much sense since currently the method doesn't
> imply returning an error status. IMO using "verify" was ok, but since
> you don't see it suitable please suggest a better alternative. mend,
> fix, align?

My suggestion is (and was) to have it return 0 for now.

-- 
With Best Regards,
Andy Shevchenko



