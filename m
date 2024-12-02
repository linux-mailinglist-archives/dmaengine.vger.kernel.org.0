Return-Path: <dmaengine+bounces-3866-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A809E0EC1
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 23:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF4EF28788E
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 22:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F191DD0F8;
	Mon,  2 Dec 2024 22:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nkrBMTB3"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9991DE3AF;
	Mon,  2 Dec 2024 22:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733177721; cv=none; b=WEe+HsvokW63xuODx3hkQoZu74MbXZ2FV0NDbWsfS8BN/59I8Jt841Vb6S6zhFrupD2ApVD8sjYgY3TkI/j4AFGSpoblVp3fZjt6aW0uS+7KeKOyoBIYlXA9UPItz3dVobS6JdtEInpteBfDBM3TtGPBaTHDIMf2YxYC+xC/qqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733177721; c=relaxed/simple;
	bh=KrjLs/JSvL6Ff2dE1q85dhEmEBCfXHRQ38VSfHrJDjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mv4t7cFJlruThfLYN6+U+uoS8bc1jSQrEXFUrv0HgTrv3bK4PoKo2+lGT1oRZEvvpid31hJKgmopfuI6EyXJJC+hDtPygnranw9KSHUItwksek9E1qTGnucGYkF2fDhUaL3RLCzpqFbodIOjii8HbPMzBnQzIpXSBxKrz9qb+9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nkrBMTB3; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733177720; x=1764713720;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KrjLs/JSvL6Ff2dE1q85dhEmEBCfXHRQ38VSfHrJDjs=;
  b=nkrBMTB3SVCqVfzO1nsOKjjFXNB9o6TvvRTaw0rB0UQqlbQtXr5K0mE3
   x3fhTv11aRf52qorDCt0E742vFgU2b2PaQFpOfWhoPw8YjR2gk2eAiR5v
   O3FXANlSf+/7I6PN3yBjNWiM4QiL0KyguYWPU4Sc5cdG68VAbCExgshOr
   Gb8jPD1gLkk2Yt9gaUJmOP2QGryTIJhtJYLr+k9Ly9Zzw29hsCbR2q9g3
   nfUggRpbAqGMGCamOOcAPt5H15voQbM7NNg8dyby9UBqxJyOCo+bz0rja
   i4IZEbK4Ep+iqT8vq2GvJkReABgVhWJ469mjoEdLFmmDm/rKH+1Dd8ky9
   g==;
X-CSE-ConnectionGUID: 3AxtQ4GGQWalszruG4V1bg==
X-CSE-MsgGUID: 8kvvlxUUQFij8gP4ni2wrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="44037764"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="44037764"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 14:15:19 -0800
X-CSE-ConnectionGUID: us5R2suqSZC0HC1KcViJXA==
X-CSE-MsgGUID: 77FODGr6S9Wew4bFAyCgaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="93703727"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.111.153]) ([10.125.111.153])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 14:15:18 -0800
Message-ID: <0dd14adb-4dfb-462e-8e35-81982c519a61@intel.com>
Date: Mon, 2 Dec 2024 15:15:17 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Enable FLR for IDXD halt
To: Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
References: <20241122233028.2762809-1-fenghua.yu@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241122233028.2762809-1-fenghua.yu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/22/24 4:30 PM, Fenghua Yu wrote:
> When IDXD device hits hardware errors, it enters halt state and triggers
> an interrupt to IDXD driver. Currently IDXD driver just prints an error
> message in the interrupt handler.
> 
> A better way to handle the interrupt is to do Function Level Reset (FLR)
> and recover the device's hardware and software configurations to its
> previous working state. The device and software can continue to run after
> the interrupt.
> 
> This series enables this FLR handling for IDXD device whose WQs are all
> user type. FLR handling for IDXD device whose WQs are kernel type
> will be implemented in a future series.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

For the series.

> 
> Change log:
> v2:
> - Patch 3: Call a free helper to free all saved configs (Dave Jiang).
> - Patch 3: Replace defined bitmap free function with existing
>   bitmpa_free().
> 
> v1:
> https://lore.kernel.org/lkml/20240705181519.4067507-1-fenghua.yu@intel.com/
> 
> Fenghua Yu (5):
>   dmaengine: idxd: Add idxd_pci_probe_alloc() helper
>   dmaengine: idxd: Binding and unbinding IDXD device and driver
>   dmaengine: idxd: Add idxd_device_config_save() and
>     idxd_device_config_restore() helpers
>   dmaengine: idxd: Refactor halt handler
>   dmaengine: idxd: Enable Function Level Reset (FLR) for halt
> 
>  drivers/dma/idxd/idxd.h |  13 ++
>  drivers/dma/idxd/init.c | 479 ++++++++++++++++++++++++++++++++++++----
>  drivers/dma/idxd/irq.c  |  85 ++++---
>  3 files changed, 507 insertions(+), 70 deletions(-)
> 


