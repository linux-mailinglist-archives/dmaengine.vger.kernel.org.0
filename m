Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B0E2DC3FD
	for <lists+dmaengine@lfdr.de>; Wed, 16 Dec 2020 17:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgLPQW7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Dec 2020 11:22:59 -0500
Received: from mga01.intel.com ([192.55.52.88]:64599 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbgLPQW7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 16 Dec 2020 11:22:59 -0500
IronPort-SDR: hfGiN8SALici98Wzdyrn6EzL+xR34Px54mozyu8VUuUlrabEh5iyRVnCDiqRiyqw2hP/J+xLMj
 Hk6Rs5iqF+ow==
X-IronPort-AV: E=McAfee;i="6000,8403,9837"; a="193475554"
X-IronPort-AV: E=Sophos;i="5.78,424,1599548400"; 
   d="scan'208";a="193475554"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 08:22:18 -0800
IronPort-SDR: VETua8fxWHr/CeIooreX6c+iVQLzE+ovXAJm6vDZGzLbFLieJpIkeqXraEvdRe3zWV6SO9kF+9
 gTt+BpkHUVNA==
X-IronPort-AV: E=Sophos;i="5.78,424,1599548400"; 
   d="scan'208";a="369160262"
Received: from anagallo-mobl.amr.corp.intel.com (HELO localhost) ([10.209.99.164])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 08:22:17 -0800
Date:   Wed, 16 Dec 2020 09:22:15 -0700
From:   Dave Jiang <dave.jiang@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: off by one in cleanup code
Message-ID: <20201216092215.000061b6@intel.com>
In-Reply-To: <X9nFeojulsNqUSnG@mwanda>
References: <X9nFeojulsNqUSnG@mwanda>
Organization: Intel Corp
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 16 Dec 2020 11:29:46 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The clean up is off by one so this will start at "i" and it should
> start with "i - 1" and then it doesn't unregister the zeroeth
> elements in the array.
> 
> Fixes: c52ca478233c ("dmaengine: idxd: add configuration component of
> driver") Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Dave Jiang <dave.jiang@intel.com>

Thanks Dan!

> ---
>  drivers/dma/idxd/sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
> index 266423a2cabc..4dbb03c545e4 100644
> --- a/drivers/dma/idxd/sysfs.c
> +++ b/drivers/dma/idxd/sysfs.c
> @@ -434,7 +434,7 @@ int idxd_register_driver(void)
>  	return 0;
>  
>  drv_fail:
> -	for (; i > 0; i--)
> +	while (--i >= 0)
>  		driver_unregister(&idxd_drvs[i]->drv);
>  	return rc;
>  }
> @@ -1840,7 +1840,7 @@ int idxd_register_bus_type(void)
>  	return 0;
>  
>  bus_err:
> -	for (; i > 0; i--)
> +	while (--i >= 0)
>  		bus_unregister(idxd_bus_types[i]);
>  	return rc;
>  }

