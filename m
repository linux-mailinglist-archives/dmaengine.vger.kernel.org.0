Return-Path: <dmaengine+bounces-1008-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390A08534EB
	for <lists+dmaengine@lfdr.de>; Tue, 13 Feb 2024 16:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68E0A1C263D4
	for <lists+dmaengine@lfdr.de>; Tue, 13 Feb 2024 15:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981715D91C;
	Tue, 13 Feb 2024 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U/nfvhss"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B17C5E3D8;
	Tue, 13 Feb 2024 15:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838839; cv=none; b=p/9jWn0Bw/KDTLsytCOD3LBw0gmdI7dP826jjuQS+wg9QztNN3uEKIwCeCXYce2a5UyURZk5u3EaiAxV+0FyVrwPZzri2kkabANvRJ4omSu+lDkfc0Rv1Lc5ofcyKlz1aTJ6Mlt98rHWE6jDq8Cvfm8GSVYNdBHHlticrx7oG4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838839; c=relaxed/simple;
	bh=cSfu80XHbT7znX6NPl5XQnfRKw6aBMa5zx+QbGgMUB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=An8NsmmQuualme40Rk4e6UayMsAixzuvpLTz0RKn7N0abDM0jCKHITlmqHL66YNkAGg4Z4cp+me2rAsKK+I4NWXG15Sdxpw226sTe9LXvvx+o1m8U2WBBckSSPQvPnz3uW3n4YamKjrrAWZhHIs6XDwR1pUTmWcUSmixv/g2URg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U/nfvhss; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707838837; x=1739374837;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cSfu80XHbT7znX6NPl5XQnfRKw6aBMa5zx+QbGgMUB0=;
  b=U/nfvhssVfqdd+Si8DxaGBXiYdQX+3Gh8O0aJXADf6A+21IDlHk0xsnf
   1d00IbfFEpllUY++6tJAD9uWatLDYv+TNnmWaxTxgc2YCBOkkhq4+beWt
   Cljld21PpatLuGO14/J89uUv8zdo9wZmrLFcZZbuQWGOTsj2aIGc/oYx/
   CTajkghgMT84XRRLxK4qLg1hQj8xTiszNzOkKG/B3+4PGKtgZ7MqkpUwU
   X9SMRfrS4kp/9T5F+tsD8K6+HmJ+HSYurItRfXwqTmgNOzsEjKhfDmpBY
   3PmTE6PdoKquLzUeqbug6WNpiq5k938ILGsfr1K/+dgJDkDs4infZOvdL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="436997070"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="436997070"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 07:40:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="935370496"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="935370496"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.246.113.145]) ([10.246.113.145])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 07:40:31 -0800
Message-ID: <7d2ca329-2f24-4673-bb8e-a692f5700b61@intel.com>
Date: Tue, 13 Feb 2024 08:40:30 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: idxd: make dsa_bus_type const
Content-Language: en-US
To: "Ricardo B. Marliere" <ricardo@marliere.net>,
 Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240213-bus_cleanup-idxd-v1-1-c3e703675387@marliere.net>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240213-bus_cleanup-idxd-v1-1-c3e703675387@marliere.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/13/24 7:43 AM, Ricardo B. Marliere wrote:
> Since commit d492cc2573a0 ("driver core: device.h: make struct
> bus_type a const *"), the driver core can properly handle constant
> struct bus_type, move the dsa_bus_type variable to be a constant
> structure as well, placing it into read-only memory which can not be
> modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/bus.c  | 2 +-
>  drivers/dma/idxd/idxd.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/idxd/bus.c b/drivers/dma/idxd/bus.c
> index 0c9e689a2e77..b83b27e04f2a 100644
> --- a/drivers/dma/idxd/bus.c
> +++ b/drivers/dma/idxd/bus.c
> @@ -72,7 +72,7 @@ static int idxd_bus_uevent(const struct device *dev, struct kobj_uevent_env *env
>  	return add_uevent_var(env, "MODALIAS=" IDXD_DEVICES_MODALIAS_FMT, 0);
>  }
>  
> -struct bus_type dsa_bus_type = {
> +const struct bus_type dsa_bus_type = {
>  	.name = "dsa",
>  	.match = idxd_config_bus_match,
>  	.probe = idxd_config_bus_probe,
> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> index 47de3f93ff1e..f14a660a2a34 100644
> --- a/drivers/dma/idxd/idxd.h
> +++ b/drivers/dma/idxd/idxd.h
> @@ -516,7 +516,7 @@ static inline void idxd_set_user_intr(struct idxd_device *idxd, bool enable)
>  	iowrite32(reg.bits, idxd->reg_base + IDXD_GENCFG_OFFSET);
>  }
>  
> -extern struct bus_type dsa_bus_type;
> +extern const struct bus_type dsa_bus_type;
>  
>  extern bool support_enqcmd;
>  extern struct ida idxd_ida;
> 
> ---
> base-commit: de7d9cb3b064fdfb2e0e7706d14ffee20b762ad2
> change-id: 20240213-bus_cleanup-idxd-8feaf2af5461
> 
> Best regards,

