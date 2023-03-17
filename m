Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E286BEFBA
	for <lists+dmaengine@lfdr.de>; Fri, 17 Mar 2023 18:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCQRdO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Mar 2023 13:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjCQRdN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Mar 2023 13:33:13 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD65631BF9;
        Fri, 17 Mar 2023 10:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679074391; x=1710610391;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5rNY2RmHj7L3TPWtuhEkMv/m7O6qV6mo4BcSFDQOaqc=;
  b=KyMQF++ZcODPMMUc4l4OBkBdtqZG0azqIWK/6S19ndmk4lBHwooKBt5t
   b4lVgrPuUGkVnVfyh2qhpOGq0wlae7soE27RA0VXkS0X0oHnirFaq5fik
   7mp1sKg4bO1Wj4dodwZxmvPWKxm3MXCq0lHmitC+qKAIp7EOBXA8XXaAx
   7Rhdva7Ot6hanexFZ2UhV3w7A5vFrBqww1VZS4ideRVx0+1dMxL39wjTi
   6UyAd4xzZA7zrUMrEYelH9Y0PbdkxJ6EKLsixFNI130rLtG0PyNk/fjSc
   anraX1kCpZpnBfJWMCEx7TNGe66xDIWZfTCfLDcSMxF/S62zMGia6jZGq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="337022698"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="337022698"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 10:33:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="823746849"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="823746849"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.209.169.16]) ([10.209.169.16])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 10:33:11 -0700
Message-ID: <74d2559e-eb27-f9e4-2287-66c857032652@intel.com>
Date:   Fri, 17 Mar 2023 10:33:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH 32/36] dmaengine: idxd: use const struct bus_type *
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
 <20230313182918.1312597-32-gregkh@linuxfoundation.org>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230313182918.1312597-32-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 3/13/23 11:29 AM, Greg Kroah-Hartman wrote:
> In the functions unbind_store() and bind_store(), a struct bus_type *
> should be a const one, as the driver core bus functions used by this
> variable are expecting the pointer to be constant, and these functions
> do not modify the pointer at all.
> 
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Dave Jiang <dave.jiang@intel.com>

> ---
> Note, this is a patch that is a prepatory cleanup as part of a larger
> series of patches that is working on resolving some old driver core
> design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
> its own, but I'd prefer if I could take it through my driver-core tree
> so that the driver core changes can be taken through there for 6.4-rc1.
> 
>   drivers/dma/idxd/compat.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/idxd/compat.c b/drivers/dma/idxd/compat.c
> index 3df21615f888..5fd38d1b9d28 100644
> --- a/drivers/dma/idxd/compat.c
> +++ b/drivers/dma/idxd/compat.c
> @@ -16,7 +16,7 @@ extern void device_driver_detach(struct device *dev);
>   
>   static ssize_t unbind_store(struct device_driver *drv, const char *buf, size_t count)
>   {
> -	struct bus_type *bus = drv->bus;
> +	const struct bus_type *bus = drv->bus;
>   	struct device *dev;
>   	int rc = -ENODEV;
>   
> @@ -32,7 +32,7 @@ static DRIVER_ATTR_IGNORE_LOCKDEP(unbind, 0200, NULL, unbind_store);
>   
>   static ssize_t bind_store(struct device_driver *drv, const char *buf, size_t count)
>   {
> -	struct bus_type *bus = drv->bus;
> +	const struct bus_type *bus = drv->bus;
>   	struct device *dev;
>   	struct device_driver *alt_drv = NULL;
>   	int rc = -ENODEV;
