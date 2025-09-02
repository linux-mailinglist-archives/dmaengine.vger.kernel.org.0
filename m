Return-Path: <dmaengine+bounces-6329-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D57B3FD42
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 13:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B9067A8587
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 11:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D788248F69;
	Tue,  2 Sep 2025 11:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TFRLOFKJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D744E32F74A;
	Tue,  2 Sep 2025 11:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756810931; cv=none; b=YpfzxaxJvIvpyGDv5KdZwLczBBEFV4Lg+8ApbEdCsRntg5tB877jo+YpqRVZbasHmDAzqqLqtnO5GbtVeVaaoWVkwdILBoIKWw1wA9aaMrEiH4qQSXXExKR7uy6/UhZ/POuSDaFzBSIW/oIe2UDmhD9OXX4S3/u0uHTR5R4usAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756810931; c=relaxed/simple;
	bh=1tDoENWnmGpjBtGi0a89elBO2Cm6mq76PaRYMhxq2FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jmr93DAHhuFZsP+JHwSbyuVnUT5A6knPzG7wTL4SDFatUC5Ht9sNJOJ6bf0y1safJOQwDZhtMf64T0+Fdpv6kUp1aqxDLQdyqC8+0lYWsKcm/7duk+7RzYc8wEGxeK9IwlXbhxfVFCHHKYLhFQ2DISNfXEgnLhGi6vbnWTORc1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TFRLOFKJ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756810930; x=1788346930;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=1tDoENWnmGpjBtGi0a89elBO2Cm6mq76PaRYMhxq2FI=;
  b=TFRLOFKJY0TfhKEUjlYo8u/jqRn7qDEdDQ1n1oZef22hRFbWxRnvTpQr
   vPN7ZJokUh0HJccWhd/XsSzUim7SLcH+PLDmESEO3W4WOPOKWA7PIBEvZ
   iDTSiYT6MxDZdD2EFMmEea2Pwxl8ZeXILeh6NNo7YE62hLs+0o1vDt+cm
   LpgGIHx+Xj5s7arSkF4En9kgNouXoy86m8L0/8Pl8bExHlZbiyyxIRaJ/
   RhV3YtObdoJSf9ZKbKwioYtg8TdeE3EeyJbWJ2jxC4VO7Bv7tl6cE2u+z
   WH+KIzRv7ZDpADpumPRJ84U1BVqH5YZ1UBMtDVedbnxwZyimNsyO7U2mX
   g==;
X-CSE-ConnectionGUID: v5MivGngS0uPJqeOO21iZQ==
X-CSE-MsgGUID: zucM8Bj/RoyIm7Um79CQDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59029446"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59029446"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 04:02:09 -0700
X-CSE-ConnectionGUID: 6Zt99N9VSZyMzlnFpdnTzw==
X-CSE-MsgGUID: CjtlWHDXTOmtbYY9kXLIrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="170533102"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 04:02:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1utOm2-0000000AfsW-0Byw;
	Tue, 02 Sep 2025 14:02:02 +0300
Date: Tue, 2 Sep 2025 14:02:01 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?utf-8?B?5p6X5aaZ5YCp?= <linmq006@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dw: dmamux: Fix device reference leak in
 rzn1_dmamux_route_allocate
Message-ID: <aLbOqbuIVWhq4UtL@smile.fi.intel.com>
References: <20250902090358.2423285-1-linmq006@gmail.com>
 <aLa65t3j1tmyEMnp@smile.fi.intel.com>
 <CAH-r-ZHx+vcL3QY0rKP3Lo_qofYLSuxCxqyb=URPSbnStxA5cQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH-r-ZHx+vcL3QY0rKP3Lo_qofYLSuxCxqyb=URPSbnStxA5cQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 02, 2025 at 06:18:18PM +0800, 林妙倩 wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> 于2025年9月2日周二 17:37写道：
> > On Tue, Sep 02, 2025 at 05:03:58PM +0800, Miaoqian Lin wrote:
> > > The reference taken by of_find_device_by_node()
> > > must be released when not needed anymore.
> > > Add missing put_device() call to fix device reference leaks.
> >
> > How is this being found? Do you have a stacktrace or kmemleak reports?
> 
> This was found through static code analysis.
> The of_find_device_by_node() documentation states that it
> "takes a reference to the embedded struct device which needs to be
> dropped after use."
> 
> I cross-referenced other of_find_device_by_node() usage patterns to
> check the correct usage,
> then audited this code and found the problem.

You should summarise that in the commit message. But since it's already applied
it's for the future and up to Vinos if he wants this to be updated.

> I don't have a stacktrace or kmemleak reports.

-- 
With Best Regards,
Andy Shevchenko



