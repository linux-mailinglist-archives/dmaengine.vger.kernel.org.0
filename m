Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A222E3DA89E
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jul 2021 18:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhG2QNl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Jul 2021 12:13:41 -0400
Received: from mga04.intel.com ([192.55.52.120]:42247 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229485AbhG2QNl (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 29 Jul 2021 12:13:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10060"; a="211035522"
X-IronPort-AV: E=Sophos;i="5.84,278,1620716400"; 
   d="scan'208";a="211035522"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2021 09:12:04 -0700
X-IronPort-AV: E=Sophos;i="5.84,278,1620716400"; 
   d="scan'208";a="465130370"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.209.170.107]) ([10.209.170.107])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2021 09:12:04 -0700
Subject: Re: [PATCH] dmaengine: idxd: Fix a possible NULL pointer dereference
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        vkoul@kernel.org, dan.j.williams@intel.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <77f0dc4f3966591d1f0cffb614a94085f8895a85.1627560174.git.christophe.jaillet@wanadoo.fr>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <44c9607e-2cde-02b9-7e4e-68578a775fb3@intel.com>
Date:   Thu, 29 Jul 2021 09:12:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <77f0dc4f3966591d1f0cffb614a94085f8895a85.1627560174.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 7/29/2021 5:04 AM, Christophe JAILLET wrote:
> 'device_driver_attach()' dereferences its first argument (i.e. 'alt_drv')
> so it must not be NULL.
> Simplify the error handling logic about NULL 'alt_drv' in order to be
> more robust and future-proof.
>
> Fixes: 568b2126466f ("dmaengine: idxd: fix uninit var for alt_drv")
> Fixes: 6e7f3ee97bbe ("dmaengine: idxd: move dsa_drv support to compatible mode")
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>


Thanks for the cleanup.

Acked-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/dma/idxd/compat.c | 15 ++++-----------
>   1 file changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/dma/idxd/compat.c b/drivers/dma/idxd/compat.c
> index d7616c240dcd..3df21615f888 100644
> --- a/drivers/dma/idxd/compat.c
> +++ b/drivers/dma/idxd/compat.c
> @@ -45,23 +45,16 @@ static ssize_t bind_store(struct device_driver *drv, const char *buf, size_t cou
>   	idxd_dev = confdev_to_idxd_dev(dev);
>   	if (is_idxd_dev(idxd_dev)) {
>   		alt_drv = driver_find("idxd", bus);
> -		if (!alt_drv)
> -			return -ENODEV;
>   	} else if (is_idxd_wq_dev(idxd_dev)) {
>   		struct idxd_wq *wq = confdev_to_wq(dev);
>   
> -		if (is_idxd_wq_kernel(wq)) {
> +		if (is_idxd_wq_kernel(wq))
>   			alt_drv = driver_find("dmaengine", bus);
> -			if (!alt_drv)
> -				return -ENODEV;
> -		} else if (is_idxd_wq_user(wq)) {
> +		else if (is_idxd_wq_user(wq))
>   			alt_drv = driver_find("user", bus);
> -			if (!alt_drv)
> -				return -ENODEV;
> -		} else {
> -			return -ENODEV;
> -		}
>   	}
> +	if (!alt_drv)
> +		return -ENODEV;
>   
>   	rc = device_driver_attach(alt_drv, dev);
>   	if (rc < 0)
