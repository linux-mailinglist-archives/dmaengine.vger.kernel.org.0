Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC7A3DFE4E
	for <lists+dmaengine@lfdr.de>; Wed,  4 Aug 2021 11:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237178AbhHDJqZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Aug 2021 05:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237177AbhHDJqZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Aug 2021 05:46:25 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8877DC0613D5;
        Wed,  4 Aug 2021 02:46:11 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id l4so1880926ljq.4;
        Wed, 04 Aug 2021 02:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mVnJInZpn4OUvjoNvU3SZlWdiP6K+04meJVPvdzldwQ=;
        b=sF+sWnJ3H92GflZLESsLN2ti3iapm4lJ1FIgWB2/dJLKhlQa6Ex4IPy2oNPMm7URKn
         B9tNyri9vLOhG0zfn0QiSz3iLkyP8new6WIj96etpjSEIdoBfPseaqMFZLIdv85lXk+k
         LjMqfHRUsP5vXUFNe2zlc5xEPGtoRy5alvp7rWBl/mOCPTrHhayhAZpWLrSfHLN4eFO3
         aHihfQsKNCW/LnPLT1GHbvL8KVXLEEm3yftCgHuhZ2zxVQ3TantqCbzD9FnaCPF9Gtnk
         LT7gBAsYk7p5WcNZsgyIE+vvld8vIATwK+qtjacNjXEPuqstadxGHUgwyo91en98rDgK
         ujzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mVnJInZpn4OUvjoNvU3SZlWdiP6K+04meJVPvdzldwQ=;
        b=H+BZdWPt9wkUoMVdQLolCs1gZYIAKxIj0ksUD+G0BK0xrxc0HJjHY2oNhp9lUtXsYU
         eB/7RDSkWW0DbJsvLOsxq/KkzdbmvtbdmJQbm3a5sFgOyTz7nVNIyQmL6eGczkSR/SQE
         VLF9elYHOPzWHhLsfSOUBdT7ovQJsfiQXvWfocuuvmmf+K/H0F2FlipepaDrkqUfFFD+
         64Ykv0PjGczjCvqjlVMB6cB9CdfS6A0SeMMIE7K8PI6MgE6GmdXB1xMfOLY23OokcHh6
         AqpnxlGZW/0/Eyynmfk+oxc/HzW3HkcWrURwFHAbhCiNHkdAAUz7486XT0gj9P1sEGum
         JZhA==
X-Gm-Message-State: AOAM530+id3Z0IL5gWUqaj5mqfy/rWohdrUSaY8BswN9Q6noZOLb43xF
        qKN2D1RQ1PFpzm2wZI9LCrU=
X-Google-Smtp-Source: ABdhPJz36QMz/TPvyrUYFGdy+PGKoAmoP8tL+HREdgsQva7salGCDqTWz+aBJcdqfOTwsEOPEeCGbg==
X-Received: by 2002:a2e:bc1a:: with SMTP id b26mr17670696ljf.132.1628070369833;
        Wed, 04 Aug 2021 02:46:09 -0700 (PDT)
Received: from mobilestation ([95.79.127.110])
        by smtp.gmail.com with ESMTPSA id v78sm102254lfa.141.2021.08.04.02.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 02:46:09 -0700 (PDT)
Date:   Wed, 4 Aug 2021 12:46:07 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Viresh Kumar <vireshk@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v1 1/3] dmaengine: dw: Remove error message from DT
 parsing code
Message-ID: <20210804094607.ac3zxomlmu3ifpqr@mobilestation>
References: <20210802184355.49879-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802184355.49879-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Andy

On Mon, Aug 02, 2021 at 09:43:53PM +0300, Andy Shevchenko wrote:
> Users are a bit frightened of the harmless message that tells that
> DT is missed on ACPI-based platforms. Remove it for good, it will
> simplify the future conversion to fwnode and device property APIs.

Thanks for the cleanup patchset. No comments from me, just the tags
for the whole series:
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Tested-by: Serge Semin <fancer.lancer@gmail.com>
[Tested on Baikal-T1 DW DMAC with 8 channels, 12 requests, 2 masters,
no multi-block support and uneven max burst length setup]

-Sergey

> 
> Fixes: a9ddb575d6d6 ("dmaengine: dw_dmac: Enhance device tree support")
> Depends-on: f5e84eae7956 ("dmaengine: dw: platform: Split OF helpers to separate module")
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=199379
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/dma/dw/of.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/dma/dw/of.c b/drivers/dma/dw/of.c
> index c1cf7675b9d1..4d2b89142721 100644
> --- a/drivers/dma/dw/of.c
> +++ b/drivers/dma/dw/of.c
> @@ -54,11 +54,6 @@ struct dw_dma_platform_data *dw_dma_parse_dt(struct platform_device *pdev)
>  	u32 nr_masters;
>  	u32 nr_channels;
>  
> -	if (!np) {
> -		dev_err(&pdev->dev, "Missing DT data\n");
> -		return NULL;
> -	}
> -
>  	if (of_property_read_u32(np, "dma-masters", &nr_masters))
>  		return NULL;
>  	if (nr_masters < 1 || nr_masters > DW_DMA_MAX_NR_MASTERS)
> -- 
> 2.30.2
> 
