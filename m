Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD162E280F
	for <lists+dmaengine@lfdr.de>; Thu, 24 Dec 2020 17:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbgLXQ0R (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Dec 2020 11:26:17 -0500
Received: from mga05.intel.com ([192.55.52.43]:19019 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727081AbgLXQ0R (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 24 Dec 2020 11:26:17 -0500
IronPort-SDR: AqhAzPm+MFJ/pRHAzCAeuTcn6Vnvemu/X5fyixNWG6kMfQPKeF7ZEzrIwOGYsWIOw/AWxJOxCv
 oRndu/mlow3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9845"; a="260897467"
X-IronPort-AV: E=Sophos;i="5.78,444,1599548400"; 
   d="scan'208";a="260897467"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2020 08:25:35 -0800
IronPort-SDR: NX07vGkLBhulOSQKGUdAvtJ3m0Y1g03ow4ChOY95OnjUoIppghtXIGNr9jNbLqJCLAouyFun03
 Uk869OBjpz2w==
X-IronPort-AV: E=Sophos;i="5.78,444,1599548400"; 
   d="scan'208";a="345607656"
Received: from ccazan-mobl.amr.corp.intel.com (HELO localhost) ([10.209.102.30])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2020 08:25:34 -0800
Date:   Thu, 24 Dec 2020 09:25:29 -0700
From:   Dave Jiang <dave.jiang@intel.com>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 -next] dma: idxd: use DEFINE_MUTEX() for mutex lock
Message-ID: <20201224092529.00006a63@intel.com>
In-Reply-To: <20201224132254.30961-1-zhengyongjun3@huawei.com>
References: <20201224132254.30961-1-zhengyongjun3@huawei.com>
Organization: Intel Corp
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, 24 Dec 2020 21:22:54 +0800
Zheng Yongjun <zhengyongjun3@huawei.com> wrote:

> mutex lock can be initialized automatically with DEFINE_MUTEX()
> rather than explicitly calling mutex_init().
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
Acked-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/dma/idxd/init.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 0a4432b063b5..2297c93dd527 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -27,7 +27,7 @@ MODULE_AUTHOR("Intel Corporation");
>  #define DRV_NAME "idxd"
>  
>  static struct idr idxd_idrs[IDXD_TYPE_MAX];
> -static struct mutex idxd_idr_lock;
> +static DEFINE_MUTEX(idxd_idr_lock);
>  
>  static struct pci_device_id idxd_pci_tbl[] = {
>  	/* DSA ver 1.0 platforms */
> @@ -481,7 +481,6 @@ static int __init idxd_init_module(void)
>  	pr_info("%s: Intel(R) Accelerator Devices Driver %s\n",
>  		DRV_NAME, IDXD_DRIVER_VERSION);
>  
> -	mutex_init(&idxd_idr_lock);
>  	for (i = 0; i < IDXD_TYPE_MAX; i++)
>  		idr_init(&idxd_idrs[i]);
>  

