Return-Path: <dmaengine+bounces-2721-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF087937A2B
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jul 2024 17:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 740AB1F2236E
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jul 2024 15:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E537613F435;
	Fri, 19 Jul 2024 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FpxXGO0L"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511871B86D5;
	Fri, 19 Jul 2024 15:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721404189; cv=none; b=X/ymdSTr0lO5oMktlZcWyCjOMqnh3EZhDfQH3Usl+Fs/Vk8BUDvrnozyIa0dLhfvjo1k+y5aaRBoEvHVTH4ghjYY0UptQq4G3riCGhZZrehT/MObN4Ua57DzztUPFR8rICouNVI+hTfp3QQan3Ox/GLzkyxJ/VH3IGxgjY/0whU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721404189; c=relaxed/simple;
	bh=m/ltgYfftuqmFEerL6nx6AdLrB3L89t/KVEPllQcGnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DAi8/3WvPKoKyJz/2gaqT4aZlX/924UTxdsN38iQF+SyOlC7/pXpQ8aZZ/60QLmOIFFSx6ttSQGi+KXO7LSZCeWbv2jOXati3vEU+QGhbjmD2MFlercKm4vbBqDPy1P4safEPDhTQe8DrkDEkxHCaR5pWnktCJm7OWw8BCVgn50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FpxXGO0L; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721404189; x=1752940189;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m/ltgYfftuqmFEerL6nx6AdLrB3L89t/KVEPllQcGnE=;
  b=FpxXGO0Lw9SNJFeQW1eWMmTVKvAuZy6NVszJQiFZyOcGfgzDEL8UegyI
   QSTkD9VrJxA+QN3m+sarL2JNRoy/LRr0+n6xh73rmE6OE37BVT5Fj7YKS
   9khtujZv9WWNHa7/AcKuFRNExGUMuUWJJPyZeNdPusrS6IiI0mECAiM91
   SNfuZTwN49Ga6EpwgmZgmSpm0EFfy/fKS1JnDRRCD0sjLM7cGXbvEl7D/
   LvVdSf9DARtW1vz9YB01kxrk1+uqPm56evIOHixqgurfZL0YaeVak97jQ
   pEim2YA6rb+px8BZhnWAtkCaa3hBqtXHmlKXEB1UA+9PiEm2D4Ayo5Mz7
   w==;
X-CSE-ConnectionGUID: 3M2Jtet+TVmilLXrYOU+UA==
X-CSE-MsgGUID: C0ZGotjEQoKX1eyeBDMW/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11138"; a="44448001"
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800"; 
   d="scan'208";a="44448001"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 08:49:48 -0700
X-CSE-ConnectionGUID: tI/3CPMhR0O6P93n/7ONDA==
X-CSE-MsgGUID: iXdOuqlwThyUV0Bj8WKXvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800"; 
   d="scan'208";a="55699181"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.109.46]) ([10.125.109.46])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 08:49:47 -0700
Message-ID: <8ad5a485-6803-495a-98ee-9f7ad3e85946@intel.com>
Date: Fri, 19 Jul 2024 08:49:46 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: avoid non-constant format string
To: Arnd Bergmann <arnd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Yajun Deng <yajun.deng@linux.dev>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240719102319.546622-1-arnd@kernel.org>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240719102319.546622-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/19/24 3:23 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Using an arbitrary string as a printf-style format can be a security
> problem if that string contains % characters, as the optionalal
> -Wformat-security flag points out:
> 
> drivers/dma/dmaengine.c: In function '__dma_async_device_channel_register':
> drivers/dma/dmaengine.c:1073:17: error: format not a string literal and no format arguments [-Werror=format-security]
>  1073 |                 dev_set_name(&chan->dev->device, name);
>       |                 ^~~~~~~~~~~~
> 
> Change this newly added instance to use "%s" as the format instead to
> pass the actual name.
> 
> Fixes: 10b8e0fd3f72 ("dmaengine: add channel device name to channel registration")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/dma/dmaengine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index c380a4dda77a..c1357d7f3dc6 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -1070,7 +1070,7 @@ static int __dma_async_device_channel_register(struct dma_device *device,
>  	if (!name)
>  		dev_set_name(&chan->dev->device, "dma%dchan%d", device->dev_id, chan->chan_id);
>  	else
> -		dev_set_name(&chan->dev->device, name);
> +		dev_set_name(&chan->dev->device, "%s", name);
>  	rc = device_register(&chan->dev->device);
>  	if (rc)
>  		goto err_out_ida;

