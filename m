Return-Path: <dmaengine+bounces-2031-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6B48C58DF
	for <lists+dmaengine@lfdr.de>; Tue, 14 May 2024 17:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC11B282903
	for <lists+dmaengine@lfdr.de>; Tue, 14 May 2024 15:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C074262BD;
	Tue, 14 May 2024 15:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZdtjMG4F"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AB717EB8B;
	Tue, 14 May 2024 15:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715701103; cv=none; b=dj5ds2xC2UvVd1aUXc2vENuF0fpjZdfcuLnYfPXaUCZVyusNEXRi/a2OMpu6+TDcy1HX6JRCJR52NA0WPPBuCHV4e0jtLnymY4J0tjHtZ9HPDPYBY403HU4I/tQ06asqsglDHRassp+g0oPj1hUo5fnuUx6x01aCO1ip1g9NfVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715701103; c=relaxed/simple;
	bh=55SJBWuI/ff5O+lbvxWeBOb/Th9bY0EC7I7Em2Nutz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uLgXfx99eO+meCvQiT6a/6fAjahtl1odcJqymt3jbYIX/fXikr3IwDGjkZ96ys3oQkP9GCYmKEw/PxJmxn9kEGgn7sFuN0bZXggTSTYbJpH4sMX+GGnMknvPNXRBIU4k56mAXgHpIvRFhc/V4Rauo3O5eBfHjWeKjvLChxsNJ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZdtjMG4F; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715701098; x=1747237098;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=55SJBWuI/ff5O+lbvxWeBOb/Th9bY0EC7I7Em2Nutz4=;
  b=ZdtjMG4F/HAXidJm8fIadSt4G0mB09fdIhJOQSH9Ty2xd/dP63S7nuXA
   t1UGhv9xpeXPY/o3pyYWtHtgafGU6akS6X/GPG+Dcw4TXPWxTpLQlQ7P7
   9kQ9QFqBTR9c8ntLjiV3Z2jXk7hj9y4OrqBEaobmOOTVHKWO7UduXsFDa
   e+3TS4kfcAAeUekmqqZGBFOsXlNSm2pdtO+M+9gODsbfQAhqJmSL487Gm
   ClZG0Xub64FSTpg6/l/k8bug+CmkHLOpLvE39eDYe1vQtrvqL2MNfh4Io
   XFUeBq3Rb8v3Zd7w9bHR3NfQ/Bq+cDPkmBzhNZqWX4R9VSG0yj3BYnDqm
   A==;
X-CSE-ConnectionGUID: 3cMRBRS9RfCxbzr3mkjPCw==
X-CSE-MsgGUID: dzniUQLXQmunfo+I4kBgcQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11905186"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="11905186"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 08:38:18 -0700
X-CSE-ConnectionGUID: 6c65Iz38RsWilCr/WlqusQ==
X-CSE-MsgGUID: hJAAmKmYQ1GymOdFCHndKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="31132707"
Received: from nntecmew158.ccr.corp.intel.com (HELO [10.125.111.233]) ([10.125.111.233])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 08:38:17 -0700
Message-ID: <85cd8e12-261f-4fa0-aa83-75c7f692d8f3@intel.com>
Date: Tue, 14 May 2024 08:38:16 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: ioatdma: Fix missing kmem_cache_destroy()
To: n.shubin@yadro.com, Vinod Koul <vkoul@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nikita Shubin <nikita.shubin@maquefel.me>
References: <20240514-ioatdma_fixes-v1-1-2776a0913254@yadro.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240514-ioatdma_fixes-v1-1-2776a0913254@yadro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/14/24 3:52 AM, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <n.shubin@yadro.com>
> 
> Fix missing kmem_cache_destroy() for ioat_sed_cache in
> ioat_exit_module().
> 
> Noticed via:
> 
> ```
> modprobe ioatdma
> rmmod ioatdma
> modprobe ioatdma
> debugfs: Directory 'ioat_sed_ent' with parent 'slab' already present!
> ```
> 
> Fixes: c0f28ce66ecf ("dmaengine: ioatdma: move all the init routines")
> Signed-off-by: Nikita Shubin <n.shubin@yadro.com>

Thanks!

Acked-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/dma/ioat/init.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
> index 9c364e92cb82..61329c279040 100644
> --- a/drivers/dma/ioat/init.c
> +++ b/drivers/dma/ioat/init.c
> @@ -1445,6 +1445,7 @@ module_init(ioat_init_module);
>  static void __exit ioat_exit_module(void)
>  {
>  	pci_unregister_driver(&ioat_pci_driver);
> +	kmem_cache_destroy(ioat_sed_cache);
>  	kmem_cache_destroy(ioat_cache);
>  }
>  module_exit(ioat_exit_module);
> 
> ---
> base-commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
> change-id: 20240514-ioatdma_fixes-7460f4fd7d51
> 
> Best regards,

