Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2CC3479F4
	for <lists+dmaengine@lfdr.de>; Wed, 24 Mar 2021 14:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbhCXNvp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Mar 2021 09:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235721AbhCXNvV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Mar 2021 09:51:21 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF48C061763;
        Wed, 24 Mar 2021 06:51:20 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id a198so32074800lfd.7;
        Wed, 24 Mar 2021 06:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ULL8Dp+sW+faCRf16Nadx1YBNh9pmv09NKFKN0zU3KY=;
        b=oZY6TocHUe+Nykws9OrY9TIMV+hyJ9DjRnhOwo4SNvAtABZArRxtRIDQoiD7OAoVCT
         O9dWUwwKXWwgO4V5dRk/5YETET2Y7J46luG0PzThbSm1Fl3OZX5h6K6pKcCGVjNlB9DB
         uvMXf+NKRhd/PEK8HoDxUnuFqzMYo4U2yscic4f5up0xQWkVBdcxppQP6Y6MgC9iSLw7
         PNxiVLOM85VS3k2Xj9NXzOopfzEary8QvLUWcLAl/9Z6xc/b+Vd7ws25+Xr2bVtonVMg
         qrwY1dD/roHy00n5gFpyLup8dym3mYDbDK/fVgJ+QwLZYOK1YTbx6mIQpLTAvSSRMj4/
         KmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ULL8Dp+sW+faCRf16Nadx1YBNh9pmv09NKFKN0zU3KY=;
        b=l67ECEQvSch5vWzfjXnMBicbvw/7lumYYXqG0eY+hy99va8UMHhHKioNwmImcwlwh8
         vv/dX9pfOhdRao7Umq63pGepXs97mahcPX92rtCZF2PCb8Q8k1C/icWUyylq9QFejbQv
         BBjA7OFSet+d6wlVSuEzAEPN3S36przCaJhEV585H8c3Uasfaue1NeN1jvdUnSzNPLL8
         De5bvEzh7aPJvXKqB6gvZkBgr+FBj0IxfNBM1lXttrz75GsViKHmG8f+CG9oBLiRdAwt
         9XK+EM7GFFGzFWvL3pvM3VXeJGe9V4rxqCuPRI9kQZ8DKn7Pbk4F3O86973ye7N10Yc1
         zMXw==
X-Gm-Message-State: AOAM530r1n8jIbj/mVDM4xYHz+1DL+KFnfWyGU6IAfGUf8YRFDWd2Oki
        2moVgPxr8cDFWxxhqcHtVXY=
X-Google-Smtp-Source: ABdhPJw2m3yi3Rw+dtcw3byi00mWDjRs1hU004rwCZ5ASzU52GofCenikesqn/ETlAzU3tCn0Lr/Rg==
X-Received: by 2002:ac2:562a:: with SMTP id b10mr2069729lff.384.1616593879220;
        Wed, 24 Mar 2021 06:51:19 -0700 (PDT)
Received: from mobilestation ([95.79.127.110])
        by smtp.gmail.com with ESMTPSA id v18sm317300ljg.85.2021.03.24.06.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 06:51:18 -0700 (PDT)
Date:   Wed, 24 Mar 2021 16:51:16 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Viresh Kumar <vireshk@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/1] dmaengine: dw: Make it dependent to HAVE_IOMEM
Message-ID: <20210324135116.z3xjyjreni24roez@mobilestation>
References: <20210324121822.18092-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324121822.18092-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Andy

On Wed, Mar 24, 2021 at 02:18:22PM +0200, Andy Shevchenko wrote:
> Some architectures do not provide devm_*() APIs. Hence make the driver
> dependent on HAVE_IOMEM.

You must have meant "HAS_IOMEM", right?

-Sergey

> 
> Fixes: dbde5c2934d1 ("dw_dmac: use devm_* functions to simplify code")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/dma/dw/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/dma/dw/Kconfig b/drivers/dma/dw/Kconfig
> index e5162690de8f..dd4b56669d9f 100644
> --- a/drivers/dma/dw/Kconfig
> +++ b/drivers/dma/dw/Kconfig
> @@ -10,6 +10,7 @@ config DW_DMAC_CORE
>  
>  config DW_DMAC
>  	tristate "Synopsys DesignWare AHB DMA platform driver"
> +	depends on HAVE_IOMEM
>  	select DW_DMAC_CORE
>  	help
>  	  Support the Synopsys DesignWare AHB DMA controller. This
> @@ -18,6 +19,7 @@ config DW_DMAC
>  config DW_DMAC_PCI
>  	tristate "Synopsys DesignWare AHB DMA PCI driver"
>  	depends on PCI
> +	depends on HAVE_IOMEM
>  	select DW_DMAC_CORE
>  	help
>  	  Support the Synopsys DesignWare AHB DMA controller on the
> -- 
> 2.30.2
> 
