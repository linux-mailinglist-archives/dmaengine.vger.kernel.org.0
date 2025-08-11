Return-Path: <dmaengine+bounces-5983-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30792B210AB
	for <lists+dmaengine@lfdr.de>; Mon, 11 Aug 2025 18:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1025118A00F0
	for <lists+dmaengine@lfdr.de>; Mon, 11 Aug 2025 15:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3480E2D23A4;
	Mon, 11 Aug 2025 15:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QvkTC3SJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97A12E7BB2;
	Mon, 11 Aug 2025 15:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754926633; cv=none; b=mvBjyKTW3upq+5Rt57NzMB4xVNZP6BDR/9myTtT0ndvoz5Lf56ppjRibGtwK3+7BRj4A3NtBaFb6VRBeJdu/4LCgU5VUPdtPwQk6ee2wdwncTD/Xb+37aLb31r0g9ZMd7zpXZxG2sn/G39uv6/rEBX4FJHT0BVPuU6He8BalepY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754926633; c=relaxed/simple;
	bh=4WkKbRe0cR206bqP9RP/XzewXYEBHdON0kv7LwS/YQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gnk6NvsTDJeR8vjT8yl5D1UJlmCrrjHuQUDb0m556c/hVjH7RYuuL8ltm4hgH2T+HQaAZ9HBypKvtWUeIAjBS2zLy07SxA8OPxcpW/A3OLAzOu2uN57ejeyZmGKzoCjnQ8aoDjNBMorQxpPzTe7xN9ajexKc8Mi8lnbXcR1jn+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QvkTC3SJ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754926632; x=1786462632;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4WkKbRe0cR206bqP9RP/XzewXYEBHdON0kv7LwS/YQM=;
  b=QvkTC3SJIo9NdKYRHKWAiGIvCiV5D5oyB6IhhMRFjv0cqY/wyCJreouN
   Bvt8X1xXJXzv2QvL/Kivrx2rntB8ZBzT3qfbCxns9sadQ+oB2iAiVgMuV
   6PcCyOK9bJp828baq8DZSPlluJt0DfWsUMI+dUDgHNYUbYNmh/ZxjtoUg
   4Nvberf9ppekVhHjbU1HuY//cfAnBeZLBhJxwZKQWe0zUlqHofNA9qHfK
   4lEfxX5Xl25d++1r+82TAqYpSpOeRwjlGLncTQEMi3uG/UEiO2TzTIsfR
   mZAt7LZ/PaZl2GZerviuI9c61dei1debZdEdQQ5R8QMujmbbJowGBO909
   Q==;
X-CSE-ConnectionGUID: r1zKfyGWRMiACbXWTntGpQ==
X-CSE-MsgGUID: T25hL+0HRSi0Hbt0aDupbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57087381"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="57087381"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 08:37:11 -0700
X-CSE-ConnectionGUID: 50Wxz5jlTRCn6OTyKBLOEg==
X-CSE-MsgGUID: bw6dKchyRW6CYwZwn0aG3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165192435"
Received: from bvivekan-mobl2.gar.corp.intel.com (HELO [10.247.119.140]) ([10.247.119.140])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 08:37:08 -0700
Message-ID: <5ecf9433-5de7-4e52-b246-bf17d0cea776@intel.com>
Date: Mon, 11 Aug 2025 08:37:02 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: idxd: Replace memset(0) + strscpy() with
 strscpy_pad()
To: Thorsten Blum <thorsten.blum@linux.dev>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250810225858.2953-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250810225858.2953-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/10/25 3:58 PM, Thorsten Blum wrote:
> Replace memset(0) followed by strscpy() with strscpy_pad() to improve
> idxd_load_iaa_device_defaults(). This avoids zeroing the memory before
> copying the strings and ensures the destination buffers are only written
> to once, simplifying the code and improving efficiency.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/dma/idxd/defaults.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/idxd/defaults.c b/drivers/dma/idxd/defaults.c
> index c607ae8dd12c..2bbbcd02a0da 100644
> --- a/drivers/dma/idxd/defaults.c
> +++ b/drivers/dma/idxd/defaults.c
> @@ -36,12 +36,10 @@ int idxd_load_iaa_device_defaults(struct idxd_device *idxd)
>  	group->num_wqs++;
>  
>  	/* set name to "iaa_crypto" */
> -	memset(wq->name, 0, WQ_NAME_SIZE + 1);
> -	strscpy(wq->name, "iaa_crypto", WQ_NAME_SIZE + 1);
> +	strscpy_pad(wq->name, "iaa_crypto");

Should also supply the max length?

>  
>  	/* set driver_name to "crypto" */
> -	memset(wq->driver_name, 0, DRIVER_NAME_SIZE + 1);
> -	strscpy(wq->driver_name, "crypto", DRIVER_NAME_SIZE + 1);
> +	strscpy_pad(wq->driver_name, "crypto");
>  
>  	engine = idxd->engines[0];
>  


