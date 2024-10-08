Return-Path: <dmaengine+bounces-3303-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 116B8995577
	for <lists+dmaengine@lfdr.de>; Tue,  8 Oct 2024 19:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD3842878FB
	for <lists+dmaengine@lfdr.de>; Tue,  8 Oct 2024 17:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D671F12F1;
	Tue,  8 Oct 2024 17:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cv4/rBQL"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77AC1F9AAA;
	Tue,  8 Oct 2024 17:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728407859; cv=none; b=hbugAWmMbujoZ85lVv+/CtDeQ4gWhI+YkrYlvYBJ3Y/ju2yPXd8R+S15KvvvCPBVcjkrs+sXN3uGWiDx9SrLMg9LqOmTiC+6l2/dqHk0uSXQhw/PcuZ7FTuV7Hshwl1I9dOtJBFKssD/mDGGHwuWgVepZGrvVnOfGJUXa6PDEJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728407859; c=relaxed/simple;
	bh=Fy+Wq9ZxfFcFigNOpkbzmgAg/wR1mFMZq7h7mkjs+gM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjLRz0qHe0kI6klh2p920uLDmOtpGfUXqThnf7GNWfLQgmwD0hyzZFXEszw5QIHiT487zX5Odz3x8AJkHdQXXhZlzuxB6mUfk+WlTYc5Zwpv6M28aO3O//NlpVFd0GRWxNLudHyPft3UZAkaXuArj0ER8USxHJ8aN5SZC5IZ5yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cv4/rBQL; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728407858; x=1759943858;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fy+Wq9ZxfFcFigNOpkbzmgAg/wR1mFMZq7h7mkjs+gM=;
  b=cv4/rBQLJDxfvh1m6OUrFqTvz+eeBPF7VFF67lBXKl4TSeAaqIS8Zonl
   e2qsmb2MLOf4f7slIvFnM4+KBPYIVzeM4vPco1t9/VqdbxvRg2WlKxmyB
   EubYXWhZFXXXTqLExBHZhb+hJIYFdxLRqtVFxBjcZq5ftQsTM+IfpmIwA
   ZaR3QJp+DjCrFAcA8+QxiY4V7j6qlXgDM6Apkza+qEhmCnkMoIybxRGBk
   rbrbMXWQBTAjRIBV09odJieQ9mFK4fd4+aFG/PM1xauhfE8ZQ1LVwVZiX
   2gYEtQcSRMriibzy/Pv8/tWOtHRKGA7OdlXh3IUqn2l/r5sQpR8BdaWfN
   g==;
X-CSE-ConnectionGUID: ndQrMn+/Rn+X2cxQRePg0g==
X-CSE-MsgGUID: YPqfRgHVQgie0aghJXSqqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="53035764"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="53035764"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 10:17:37 -0700
X-CSE-ConnectionGUID: MKR+Nn0RRaGCDY7iiRW3GA==
X-CSE-MsgGUID: 4zxQgl0fTUaE1kVU6CM4Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="75782957"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 08 Oct 2024 10:16:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id AEEA620F; Tue, 08 Oct 2024 20:16:57 +0300 (EEST)
Date: Tue, 8 Oct 2024 20:16:57 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Paul Cercueil <paul@crapouillou.net>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v1 4/4] dmaengine: Unify checks in dma_request_chan()
Message-ID: <ZwVpCYxiifl2mS65@black.fi.intel.com>
References: <20241007150852.2183722-1-andriy.shevchenko@linux.intel.com>
 <20241007150852.2183722-5-andriy.shevchenko@linux.intel.com>
 <ZwQG5II6xsOwKwxz@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwQG5II6xsOwKwxz@lizhi-Precision-Tower-5810>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Oct 07, 2024 at 12:05:56PM -0400, Frank Li wrote:
> On Mon, Oct 07, 2024 at 06:06:48PM +0300, Andy Shevchenko wrote:
> > Use firmware node and unify checks accordingly in dma_request_chan().
> > As a side effect we get rid of the node dereferencing in struct device.
> 
> suggest:
> 
> Use dev_fwnode() to simple check logic for device tree and ACPI in
> dma_request_chan().

Sure, thanks!


-- 
With Best Regards,
Andy Shevchenko



