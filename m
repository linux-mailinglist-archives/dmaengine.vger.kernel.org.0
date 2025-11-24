Return-Path: <dmaengine+bounces-7306-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8537C80614
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 13:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 87C1F4E4248
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 12:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F4F277C9E;
	Mon, 24 Nov 2025 12:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gUen6ELn"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F2E2248BD;
	Mon, 24 Nov 2025 12:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763986219; cv=none; b=sMrmAf648VKcpBWjZltul6ftBkhjoiuAJBGLDZ56cS8yq7uBnqbQk33gqnfIuvKc43x+N8vfkbRlfNN69b6kB5E2AQ1XPVPLaxOSH6DuB04JZzW4f1d9NKys63xlnugE5mn7oHeJnpO2Z4Jog3DaTv1VJnAGmoBIx5VwubbjfMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763986219; c=relaxed/simple;
	bh=d5nNg3j4GXG9OHJ73JYH0c5+/jyYRN1qHBQffAJxf+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ad7N6WFq/9HZY0lvZUCbcQ5IwwZLYQuVUtULjtcnKsLkBk+Nk/t+HwLlLPGaD816BeAHLFjCPSWSGUE2AO1vK4+Mcf33gy6HxLNHg3MLy0wqBiymRnJWfHsHgifS85z8V7wRUYM+vw/X62wXHB9CgYawg82NnmZz770rgRsPulM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gUen6ELn; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763986217; x=1795522217;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=d5nNg3j4GXG9OHJ73JYH0c5+/jyYRN1qHBQffAJxf+Q=;
  b=gUen6ELnFSsM6kK6YAMHMNobscoPv0yDTJQzhGw3EfX4kLYH6KRnEQeO
   4/N65JICpuu2MaW8ZJnQUMv+WbU+jSD3itTtMQ9/JagQLYAGMmF/3uIhE
   urVkG/mPnVnP3RLkHMSoe+ZHsj2LsuGyRa1YThJVgX3Xofa6vXvE8sP4B
   MITjL5na2N7InZwG+2/SlVEH6f6cew5NA8oqv+C2+9sqoCK4q9CpG0wNN
   ZOapC2n0L/y4XV2n8LDChkC34QkRFTlifjDeZNIRfeUNEhSM5W1BbSYlg
   W88aebFd4GycCH/aTa+JSV42M8yLPnOSfajnP06CR6oSBmhM/MfKnLnUx
   A==;
X-CSE-ConnectionGUID: Sy7CxMYjQXaDM8aia0/tOQ==
X-CSE-MsgGUID: TrLMyXmFRH67Wm7It8JN/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="64984403"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="64984403"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 04:10:16 -0800
X-CSE-ConnectionGUID: kCgZIcdZRl+BizAz96HPnQ==
X-CSE-MsgGUID: ATl7n97tSL2Horct6YF6tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="191986359"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 04:10:11 -0800
Date: Mon, 24 Nov 2025 14:10:09 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Stefan Wahren <wahrenst@gmx.net>,
	Thomas Andreatta <thomasandreatta2000@gmail.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	Olivier Dautricourt <olivierdautricourt@gmail.com>,
	Stefan Roese <sr@denx.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>,
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 07/13] dmaengine: lgm: use sg_nents_for_dma() helper
Message-ID: <aSRLIY4KmhAxePq1@smile.fi.intel.com>
References: <20251110103805.3562136-1-andriy.shevchenko@linux.intel.com>
 <20251110103805.3562136-8-andriy.shevchenko@linux.intel.com>
 <aSGCJQc152Y9V10E@vaman>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aSGCJQc152Y9V10E@vaman>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Nov 22, 2025 at 02:58:05PM +0530, Vinod Koul wrote:
> On 10-11-25, 11:23, Andy Shevchenko wrote:
> > Instead of open coded variant let's use recently introduced helper.

...

> > +	num = sg_nents_for_dma(sgl, sg_len, DMA_MAX_SIZE);
> 
> drivers/dma/lgm/lgm-dma.c:1176:37: error: ‘sg_len’ undeclared (first use in this function); did you mean ‘sglen’?
>          num = sg_nents_for_dma(sgl, sg_len, DMA_MAX_SIZE);
> 
> I am getting the build failure, as well as few unused warning with this,
> pls fix

Indeed, sorry for that, in v4 should be fixed.
Thanks!

-- 
With Best Regards,
Andy Shevchenko



