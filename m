Return-Path: <dmaengine+bounces-5608-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D8EAE58BE
	for <lists+dmaengine@lfdr.de>; Tue, 24 Jun 2025 02:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71069446B9D
	for <lists+dmaengine@lfdr.de>; Tue, 24 Jun 2025 00:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A4E17332C;
	Tue, 24 Jun 2025 00:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NYnbFlMD"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1719E176ADE;
	Tue, 24 Jun 2025 00:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750725642; cv=none; b=gsmIu7p/7Unv1C4dvN4HgsrJHVCNdJIf8VKDARmAQ4XZFCdqwST/ZKVe04ISEJy5tllQbiteaqGvCIJmjoXUCL4xAwptdRq7BmRnad5Fn4H0xRbu0Kpsisf0wuK5FonXckLNeBzFjw82HAH/NlL3tiSMSTxVkj66jDdPRkADbc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750725642; c=relaxed/simple;
	bh=7zG8s1HTXnImX23EOH8ogeopBUgZJRBGe/aweUfthkI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NEuTRd8LdfOJesjr6/kHLzHfSktsTXz/O1jUci8AOkMs0YmRor7Nhgff88icgBC/ZzFahat9igz9kk4hXbwAClyLFakFH++6ddher96onQzM8gF+oE5Dd3nsc79OuYp8sHxJXmrUBHAYdq9VCMzuR5hBncJKNe5LpibDYEioDA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NYnbFlMD; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750725642; x=1782261642;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=7zG8s1HTXnImX23EOH8ogeopBUgZJRBGe/aweUfthkI=;
  b=NYnbFlMD1No/NBUjGx0m1qJgeYedJGh2NU+faOG5ED1ZVfAGwEznGDWB
   4etqDCZi+UClFoFTy9VkCwC69tGRhmBpO2q8ba7CePdm3ifoYIjIvTNp2
   wMuGYBFrjQAISpDrT7h+XYlZLjV/6NXEu888kPaBJQty/2g5FgvYP7n4x
   fnBmIdBBM6CSUuFu4wCio1gXdex5Mitk/xX/DGkiV+Ag8jWr60I+a4cRE
   3uv6eqHeOHrWU46j63h8N9W5M1yspzB1XlkFOHXRaf8lfMEDPLNnJiim2
   WzVgAktVU0f9ln70xQV+zbScwhD3ZU7LRmSDn3w3Tp5WzZMqTfAiPRHzB
   w==;
X-CSE-ConnectionGUID: 3oOcPUkARcGS8eIJg2sXFQ==
X-CSE-MsgGUID: eVN3PHpGR6+ZHxrCE4qVaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="75488167"
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="75488167"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 17:40:41 -0700
X-CSE-ConnectionGUID: yv/YS85sSx+eJP8zzig3Aw==
X-CSE-MsgGUID: +udptMSWTlu9aqwQJ9E+1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="152449190"
Received: from unknown (HELO vcostago-mobl3) ([10.241.226.49])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 17:40:40 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Yi Sun <yi.sun@intel.com>, dave.jiang@intel.com,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 fenghuay@nvidia.com, philip.lantz@intel.com
Cc: yi.sun@intel.com, gordon.jin@intel.com, anil.s.keshavamurthy@intel.com
Subject: Re: [PATCH v2 1/2] dmaengine: idxd: Expose DSA3.0 capabilities
 through sysfs
In-Reply-To: <20250620130953.1943703-2-yi.sun@intel.com>
References: <20250620130953.1943703-1-yi.sun@intel.com>
 <20250620130953.1943703-2-yi.sun@intel.com>
Date: Mon, 23 Jun 2025 17:40:39 -0700
Message-ID: <87tt466kfs.fsf@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yi Sun <yi.sun@intel.com> writes:

> Introduce sysfs interfaces for 3 new Data Streaming Accelerator (DSA)
> capability registers (dsacap0-2) to enable userspace awareness of hardware
> features in DSA version 3 and later devices.
>
> Userspace components (e.g. configure libraries, workload Apps) require this
> information to:
> 1. Select optimal data transfer strategies based on SGL capabilities
> 2. Enable hardware-specific optimizations for floating-point operations
> 3. Configure memory operations with proper numerical handling
> 4. Verify compute operation compatibility before submitting jobs
>
> The output format is <dsacap2>,<dsacap1>,<dsacap0>, where each DSA
> capability value is a 64-bit hexadecimal number, separated by commas.
> The ordering follows the DSA 3.0 specification layout:
>  Offset:    0x190    0x188    0x180
>  Reg:       dsacap2  dsacap1  dsacap0
>
> Example:
> cat /sys/bus/dsa/devices/dsa0/dsacaps
>  000000000000f18d,0014000e000007aa,00fa01ff01ff03ff
>
> According to the DSA 3.0 specification, there are 15 fields defined for
> the three dsacap registers. However, there's no need to define all
> register structures unless a use case requires them. At this point,
> support for the Scatter-Gather List (SGL) located in dsacap0 is necessary,
> so only dsacap0 is defined accordingly.
>
> For reference, the DSA 3.0 specification is available at:
> Link: https://software.intel.com/content/www/us/en/develop/articles/intel-data-streaming-accelerator-architecture-specification.html
>
> Signed-off-by: Yi Sun <yi.sun@intel.com>
> Co-developed-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


Cheers,
-- 
Vinicius

