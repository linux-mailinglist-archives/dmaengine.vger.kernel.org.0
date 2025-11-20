Return-Path: <dmaengine+bounces-7268-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B45C74601
	for <lists+dmaengine@lfdr.de>; Thu, 20 Nov 2025 14:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 20D02344229
	for <lists+dmaengine@lfdr.de>; Thu, 20 Nov 2025 13:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DCD334C32;
	Thu, 20 Nov 2025 13:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d4SifthZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A624273D81;
	Thu, 20 Nov 2025 13:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763646643; cv=none; b=Wwa2YDTH9StocUmObG7hVchCO1o/zGeFLgMTKyiBhJg/aiIJA2ursB0GeX1e6KK1GiBiMlb5q+/4K5CObr8k3++4Zbtg4EiyHA+FQMC0w+I7dtiDFp+g045v5ge1HgkPhCOI77Y80yy2PtlTnsqjERrKoBPCydizDmEx/mL4Qn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763646643; c=relaxed/simple;
	bh=f6dzq/NIpjVQyLlGtUWbFmiK5tIV3dgFV6O+w3odjzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQIRnMUvJiIcNw2DM4TkpcCtynPyS9LbHX5TjqugeQsxOs88aUfKNXXy6UJOz8Klp98UCUrCWL/Isim96s/9MhlNyCuyoy8yYpTQC9YDfl/zRL8pbJ6ujob2IEJzClDm3a32AWowSHm2MLJaGHoyexy0K260nvs1Bo9OG71TKrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d4SifthZ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763646642; x=1795182642;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f6dzq/NIpjVQyLlGtUWbFmiK5tIV3dgFV6O+w3odjzw=;
  b=d4SifthZR0Sbe4MBVzllO61f+94js9Bk+6o9dMvfkVaKO8D8xGzsbJ5Q
   dE/wP3/ZZvx3HQgKLApf7Hds7bntSfDwimDfjeH69lXWbD8UEmXoKDjb/
   qsx2MuRoDG/F7dFUUikd0xLZRuRL6Ywl11KCjYgpbslncbGmbyQvlbLbu
   ACtxyJ25Q0TgmQ5ejWxe+qv2PfTvSDxKgB+lDU+nMnQjcT9lS34HNK2us
   9wB+n6p4YbtrFEa6IpasgbsJqJBUpSBXL1T0h1wUicy/QtOAela6mcN9t
   fRCrF/CDHqz6m+soNNjaopWMwKubE4ofjE876G5Nf+fQOhjbyZabCQCHG
   g==;
X-CSE-ConnectionGUID: sh6FBBzuSeu6v0uwk7sc7g==
X-CSE-MsgGUID: 5WjdWEFrR3iTnpcfnKIqPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="64907766"
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="64907766"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 05:50:42 -0800
X-CSE-ConnectionGUID: UGnnW5/OR+6m7Q/2XxaAwg==
X-CSE-MsgGUID: lbhYApv0R2yNh57O1g0GFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="195514119"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.97])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 05:50:39 -0800
Date: Thu, 20 Nov 2025 15:50:36 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Johan Hovold <johan@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Viresh Kumar <vireshk@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] dmaengine: dw: drop unused module alias
Message-ID: <aR8crOrJOu1EAbVe@smile.fi.intel.com>
References: <20251120114524.8431-1-johan@kernel.org>
 <20251120114524.8431-3-johan@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120114524.8431-3-johan@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 20, 2025 at 12:45:17PM +0100, Johan Hovold wrote:
> The driver does not support anything but OF and ACPI probe since commit
> b3757413b91e ("dmaengine: dw: platform: Use struct dw_dma_chip_pdata")
> so drop the unused platform module alias along with the now unnecessary
> driver name define.

I think de facto it happened earlier, but whatever.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks for the contribution to this driver!

-- 
With Best Regards,
Andy Shevchenko



