Return-Path: <dmaengine+bounces-3656-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8259B792A
	for <lists+dmaengine@lfdr.de>; Thu, 31 Oct 2024 11:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86C581F21650
	for <lists+dmaengine@lfdr.de>; Thu, 31 Oct 2024 10:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA900199E81;
	Thu, 31 Oct 2024 10:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hKvZ12SP"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F016813A25F;
	Thu, 31 Oct 2024 10:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730372231; cv=none; b=Z2NBAoHy4Iwk2WbmK4S9lXPkuKDUHRGoF3tk4z53RJOospX+AQsu47sqBPARcbl9bxV5RWTT3u+eDu79WKrDaoORCWKtApafuGPo0mqKUy0myJpYvLmOhlbsc95weaWj7TROW3tlaB/W8M33v4YQ4O7f2nziFNrcNjvhrT8Oi7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730372231; c=relaxed/simple;
	bh=tVuyw/2mK57aTALxTRXWhHaWAaydpe9xSAAGsUudOsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8mcBEidC/fWo9v/mFv4jruXdOK+w+muiGjNbNf3AwppIYOrGluw+eIfDR8k7AzDIC2MhvJaQgVp7Tf3hDJITFmxqLcYybQojUxnGhk3Gy2hAkToRpwT1OXjqzMfA0uJbdZXA5KGuGIFclwshiMfLSLW/R75Y6TN3musbBB0Nl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hKvZ12SP; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730372230; x=1761908230;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tVuyw/2mK57aTALxTRXWhHaWAaydpe9xSAAGsUudOsk=;
  b=hKvZ12SPrlf9Jouyf2UaWC89vO9Dw4G44ZkjBfavM5n3m3Yb6rNtRog+
   TS9AhKEHYGt+789f8adKj81euFUe668bGbcIp3x8GdoXoemPtjoPvispj
   9UKRPzMGK5On4IPtahZZc2Jw1wYWo+jlQ1yyROqHTF89ErD8JvLUDarqk
   lCVtp/EDM6JMoaMFrtXc/DWKX2PhAH6GvLgk/pade0aWVF8ydiGXUSKYa
   MwUR8cvrA/IClzmhHQWgG/o1+DL5MLY/qnIhEhKEUzMjijhjG9U3qbzxg
   JIkEfppT3eOFJ2Adcfy1NF8Y6rJlFFbFYYhIur9sE8I8iDA8v6aVEB7O/
   g==;
X-CSE-ConnectionGUID: qMJ5SdrLSPKx4U+vbBT4jw==
X-CSE-MsgGUID: XG2wDP0aTbOZfYHBr9Swmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="40714318"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="40714318"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 03:57:09 -0700
X-CSE-ConnectionGUID: H+bgwwtSSsiF/gliVd+ZGw==
X-CSE-MsgGUID: 7CjK28aHSzCapN3igqZRyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="82698733"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 03:57:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t6SrQ-00000009cBm-2eBN;
	Thu, 31 Oct 2024 12:57:04 +0200
Date: Thu, 31 Oct 2024 12:57:04 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vinod Koul <vkoul@kernel.org>, Paul Cercueil <paul@crapouillou.net>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2 0/4] dmaengine: dma_request_chan*() amendments
Message-ID: <ZyNigG_hoFFArNii@smile.fi.intel.com>
References: <20241008173351.2246796-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008173351.2246796-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Oct 08, 2024 at 08:27:43PM +0300, Andy Shevchenko wrote:
> Reduce the scope of the use of some rarely used DMA request channel APIs
> in order to make the step of their removal or making static in the
> future. No functional changes intended.
> 
> In v2:
> - updated the commit messages (Frank)

Hmm, any comments on this?

-- 
With Best Regards,
Andy Shevchenko



