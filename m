Return-Path: <dmaengine+bounces-8101-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D04BAD014C1
	for <lists+dmaengine@lfdr.de>; Thu, 08 Jan 2026 07:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7272D30B735C
	for <lists+dmaengine@lfdr.de>; Thu,  8 Jan 2026 06:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDF13242A9;
	Thu,  8 Jan 2026 06:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fffuiajo"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EB3330B07;
	Thu,  8 Jan 2026 06:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767854825; cv=none; b=hxlQ+bt0ExTOpzQ4JMo1wXhCKeiir196VyyCEiz6YUDuPitlyZ0OJ+oRbDFpJhjiF+ptpdVajNtddx+Q3dS1hz4T9qvz0z2REWf8D/8CJcHIEo0nLidTjuORppRZTEO1StRqi0pZSSumKn6MJmjcOR7lo4poI9Ot4qjUBuBbmZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767854825; c=relaxed/simple;
	bh=tilklIxwMEG7LlBNKkCVNunz2O6wIypo2AidPBlAcXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1W/fn8Ob2EjBuvMnlPO9/TgKNTSul/QeLRYTXeonLq8/2VilVzFeaHW5Qw0DxfUMUz6b+RrtSiwWfX0DYoTWHz/4QTcpl8C4BUJkcAUpIvcut/9cUdUdoPoOubpte1Ic/LcaaE/gCv6wj6sb1TNEVoY64PAgDlbsLnEq2DIWDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fffuiajo; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767854824; x=1799390824;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tilklIxwMEG7LlBNKkCVNunz2O6wIypo2AidPBlAcXA=;
  b=FffuiajouYyC85BTm/g04A8ZxiPLMWmTpo9OkilhqMRzFAEN1iM7wk7H
   JIDRsfY5Vwr0N2KCooYSj8rlUS2V7ApkrD5pC4cy/1XHmdkNnOF3m7YdR
   d33jba828NZkYsM9u9+cv3x5em6zfrRHEgfQm4VJJYw4+lGbPwyFOJIQs
   tv9IQbCTP3M6Y8zERGC1WAJOP9iw+EWR4v1Z8X7dI3v48wIgxXT2qQ9dT
   ms8lB5XIijB/MpIWUl3cMnr/f67+s6Oxc5+dje8sv+mT6wBbrKCrWFqag
   B2KtPZZDtuL4pVM9gX7l13ol28Jde6x3NyTErsOsZ8J4G6vbaQmMyXOW8
   A==;
X-CSE-ConnectionGUID: 7DFMpVIkS5ulGUIf84E0YA==
X-CSE-MsgGUID: he3a24FoSTaNB8shPBl7WA==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="71805421"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="71805421"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 22:46:58 -0800
X-CSE-ConnectionGUID: /s35aiAwRTa/0aYKBclYQA==
X-CSE-MsgGUID: OsRC/1eHSSCTlgJZipdTHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="233826495"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.185])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 22:46:52 -0800
Date: Thu, 8 Jan 2026 08:46:50 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Thomas Andreatta <thomasandreatta2000@gmail.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	Olivier Dautricourt <olivierdautricourt@gmail.com>,
	Stefan Roese <sr@denx.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>,
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 0/13] dmaengine: introduce sg_nents_for_dma() and
 convert users
Message-ID: <aV9S2oAsIIIZoYnR@smile.fi.intel.com>
References: <20251124121202.424072-1-andriy.shevchenko@linux.intel.com>
 <aUFakHZL8viMN3WR@vaman>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aUFakHZL8viMN3WR@vaman>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Dec 16, 2025 at 06:41:44PM +0530, Vinod Koul wrote:
> On 24-11-25, 13:09, Andy Shevchenko wrote:
> > A handful of the DMAengine drivers use same routine to calculate the number of
> > SG entries needed for the given DMA transfer. Provide a common helper for them
> > and convert.
> > 
> > I left the new helper on SG level of API because brief grepping shows potential
> > candidates outside of DMA engine, e.g.:
> > 
> >   drivers/crypto/chelsio/chcr_algo.c:154:  nents += DIV_ROUND_UP(less, entlen);
> >   drivers/spi/spi-stm32.c:1495:  /* Count the number of entries needed */
> > 
> > Changelog v4:
> > - fixed compilation errors (Vinod)
> 
> :-(
> 
> drivers/dma/altera-msgdma.c: In function ‘msgdma_prep_slave_sg’:
> drivers/dma/altera-msgdma.c:399:29: error: unused variable ‘sg’ [-Werror=unused-variable]
> 
> Clearly your script is not working. I am surprised that you are not able
> to compile these changes. Bit disappointed tbh!

This is W=1 build with WERROR=y, yet I agree that I must have tested this as
well. Sorry, I will do v5 with carefully tested all modules to be compiled
with `make W=1`.

-- 
With Best Regards,
Andy Shevchenko



