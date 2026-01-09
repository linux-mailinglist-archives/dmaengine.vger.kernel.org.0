Return-Path: <dmaengine+bounces-8184-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6D7D0BB70
	for <lists+dmaengine@lfdr.de>; Fri, 09 Jan 2026 18:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6754130742AD
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jan 2026 17:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9B53385BC;
	Fri,  9 Jan 2026 17:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="myYaSikY"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465A918AE3;
	Fri,  9 Jan 2026 17:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767980262; cv=none; b=UAtvZ6gSEEs7AmNvrRwgJ2PVmhvpyJ6auWuAyhMeWGujTuN4yii8F0cFUZIzgRoZ4MXYmu4WWUK5gvM5fxe9/rP/e82FeXp1U8N0SvQrA0+iQugBMhI/pYW+dEdURPE9Mcnm9/E2kogL0tGw0dNva+1iiBzPByI9qy40sV5nSh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767980262; c=relaxed/simple;
	bh=Z18RHSSBPTzW6Kple2YtNtUN59hVbuBOiaazsf0hV2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1WjDIYDM8EbslmsoyMu9CVp6BdC4YImDy8SUgyUjn837iselUtM7U+f2pf10pYIXAnHXVg/KHjacXvmDlH8PiBiYt0mTveWUGMEww/9tZOfL+gGLA2mX7BjKJJCFeLoDrcxDIEwM0k/8EoaDgNkMe9xQdczhWokosi7RJPhbCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=myYaSikY; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767980261; x=1799516261;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z18RHSSBPTzW6Kple2YtNtUN59hVbuBOiaazsf0hV2o=;
  b=myYaSikYMV0igvAlOhyvh5cHbjVX5uLjx4VxSo3Rn3I7ob3clBSVxMfr
   p6P5v+YWVT6iDS858yV85bK4keWUhYHTdZnyRLCwoZmjfZ7MNqqJ0bxIV
   12Kye+boyRKrHTpjPDmghGvA8sl/kJArptX0tB82zVtt6WeVm/kHfZcWV
   YxBy546LWmgeDs7J76RkFhcWVtrGU17zYClFI8A77WK25p2ujkWSsrj22
   D0Hj3T317AQFkm43nk94KenYrUMsgIuccu5XAkWKWlXK8HEKrAvnH6jc5
   m1iL7qH4vdwxVqM/jVd3fQ5xeUdrkOK6mBn9XNNJcUF/wIA9jcFJJ5dLF
   Q==;
X-CSE-ConnectionGUID: mDEbEvwzQ/ONDqIEjGf8aA==
X-CSE-MsgGUID: yN+EZzVqQ/6n5gAW0Pr8pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="56917746"
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="56917746"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 09:37:41 -0800
X-CSE-ConnectionGUID: +m/fh8CuQIeByN5QlNwWmA==
X-CSE-MsgGUID: FOQfcpKmS7O4nsoktAG5Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="203591055"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.157])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 09:37:39 -0800
Date: Fri, 9 Jan 2026 19:37:37 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] dmaengine: A little cleanup and refactoring
Message-ID: <aWE84dcQn8K54X8X@smile.fi.intel.com>
References: <20251110085349.3414507-1-andriy.shevchenko@linux.intel.com>
 <aV9SJrOpQvRsJ3nA@smile.fi.intel.com>
 <aWBpC3un9BmJ6dYU@vaman>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWBpC3un9BmJ6dYU@vaman>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 09, 2026 at 08:03:47AM +0530, Vinod Koul wrote:
> On 08-01-26, 08:43, Andy Shevchenko wrote:
> > On Mon, Nov 10, 2025 at 09:47:42AM +0100, Andy Shevchenko wrote:
> > > This just a set of small almost ad-hoc cleanups and refactoring.
> > > Nothing special and nothing that changes behaviour.
> > 
> > Any comments on this series?
> 
> Looks good mostly, seems to have a small checkpatch error, pls fix that
> and update

Thanks. v3 has just been sent.

-- 
With Best Regards,
Andy Shevchenko



