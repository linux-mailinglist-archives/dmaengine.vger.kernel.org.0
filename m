Return-Path: <dmaengine+bounces-3199-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 700BE97D7E3
	for <lists+dmaengine@lfdr.de>; Fri, 20 Sep 2024 17:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F40FAB2430A
	for <lists+dmaengine@lfdr.de>; Fri, 20 Sep 2024 15:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9674C17BEC8;
	Fri, 20 Sep 2024 15:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UTa8SC+N"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB1961FCF;
	Fri, 20 Sep 2024 15:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726847487; cv=none; b=fXDYjCfMLRbhZbhIjDN0Vwts5/l6sgLSIjkaP2suzd3M0S9rte6aUx5nLzbB0IH8DAdoeYnTSrvxEYDtyLayVgtxWvvYwqT2rKfZutsd7n6JS31iBNCCmHtgelOEwsq00bHEhiL0Pv7kf0aiAZ9Oy7JbnptR1bVaG38jp2Ohfbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726847487; c=relaxed/simple;
	bh=wqyug4XUddrN+NJhKaXRgld45uzsP6gN++oYCHgIWAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=taVcfmDVCURYO77VoBSJC6RtjTXhnjEabdCPULam5gfZ7ZCleYBg8y1CWDCeMPlYL9ZSAdj/SwMELnbL9ImPYpAl0dQppSgq0F5lW1p7XQ3/fAwYrun7kYNVm1Gg9jMXiy5bMpKHZD6yxqzkrO5H3fBBftFOC/63VDjPeG1PYK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UTa8SC+N; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726847486; x=1758383486;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=wqyug4XUddrN+NJhKaXRgld45uzsP6gN++oYCHgIWAg=;
  b=UTa8SC+NAAAiAWhdfxzTjdbRV+X58giLtjSkwzOV40QXk7kkhY8cibou
   1amuGZE0QpN3vZIOvhe8oVlZhrJvK07lcBXZCHczcRmSucvyUDbF/mmMi
   giRrwY/H69SDkMvzVPPV+63RxXHR3R4o20bVFSLeNnJhY89m9kDEy8u3f
   rmnDfA+AV/ihRCXhTjk0HUj6aSd5Ig2Rx2ndiPn740ZpP7xEwkwpgG6O8
   hwcJj5WGUb+RlPgMPu6xYFoIDQ+O0Ed/uwkY1Sgu6B0NCYRrJ5rkZz1dh
   AIbuEB1XP54me0X8Xq4C6Ov2vs2peGKkCjeUCItDBnaVlNRyTfT1ezqZ2
   g==;
X-CSE-ConnectionGUID: juC1zPuAQICA8wK1E7j5YA==
X-CSE-MsgGUID: rPK5dpyYT5m5vo97mMT+0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11201"; a="26006596"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="26006596"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 08:51:26 -0700
X-CSE-ConnectionGUID: Rw+Pb09dTJe2pmxKPGMZDg==
X-CSE-MsgGUID: 4x24elq4T5Wi+SomsuX8Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="101197302"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 08:51:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1srfui-0000000Axr7-06Xo;
	Fri, 20 Sep 2024 18:51:20 +0300
Date: Fri, 20 Sep 2024 18:51:19 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ferry Toth <fntoth@gmail.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: dw: Select only supported masters for ACPI
 devices
Message-ID: <Zu2Z99pULL_m66Dm@smile.fi.intel.com>
References: <20240919135854.16124-1-fancer.lancer@gmail.com>
 <20240919185151.7331-1-fancer.lancer@gmail.com>
 <ZuyEQOIztvUrO0gO@smile.fi.intel.com>
 <2627811.Lt9SDvczpP@ferry-quad>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2627811.Lt9SDvczpP@ferry-quad>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Sep 20, 2024 at 10:52:18AM +0200, Ferry Toth wrote:
> Op donderdag 19 september 2024 22:06:24 CEST schreef Andy Shevchenko:
> > On Thu, Sep 19, 2024 at 09:51:48PM +0300, Serge Semin wrote:

...

> > > Fix the problem by specifying a single master ID for both memory and
> > > peripheral devices on the ACPI-based platforms if there is only one master
> > > available on the controller. Thus the issue noticed for the iDMA32
> > > controllers will be eliminated and the ACPI-probed DW DMA controllers will
> > > be configured with the correct master ID by default.
> > 
> > Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Seems this fixes the bug I have seen.
> > Ferry, can you confirm?
> I was testing something else and broke my setup :-(
> I’ll fix that and test this patch this weekend.

Thinking about this more I believe it's not the best what we can do.
Because this leaves a potential gap for the devices of more than one
master but in different order.

I'll send another patch after my testing.

-- 
With Best Regards,
Andy Shevchenko



