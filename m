Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 983C11AE062
	for <lists+dmaengine@lfdr.de>; Fri, 17 Apr 2020 17:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgDQPCa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Apr 2020 11:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbgDQPC3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Apr 2020 11:02:29 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB84EC061A41
        for <dmaengine@vger.kernel.org>; Fri, 17 Apr 2020 08:02:28 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id u13so3433532wrp.3
        for <dmaengine@vger.kernel.org>; Fri, 17 Apr 2020 08:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=MZOx11K7BVkb9vfDngpczKG72DuQTl/mUltDtknINYM=;
        b=Co8VCB7jRRt1O8+H04fdcxwEtJQvvJ85wW4SvxgTv/mHipUFj+ltqVgCL7M0LxDbBm
         Pb7tEFjXMUdCDK1W7VoRTpT556UNIZvUATsFGTDHXX4ngalCQfdP4rjg3fEM8Y0uLOUu
         QsIi+ueZ6e8w8tapH3hrUwyBDQ4rCmAD5wsU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=MZOx11K7BVkb9vfDngpczKG72DuQTl/mUltDtknINYM=;
        b=IEOt8rVDp2V1lNKFlo0sDijqnWYySnj0DiqEpRjG9eCizZMPTXZBZL64s5ioedt9B3
         Ldr5pfT3FJQOSujmJaRgwsv8ZmNof4+HXWuQaNwZKZU30+Og3cD+VT1FLd1ULbVg/O9g
         5xrTdYp9Wec+vRsKs4SXQ+ehdXks8GaASUuqiMqaQf2uIjW1/gJHL6RDYQv9b7Hdx6be
         Q0ITFAO00tqmj220JPr0xDFCEP6MSB4laxdEjLU2ZuYWLt4/mVCMQx28rxAylnvHqTNy
         r952WJgfGsLsUJpDfTKfAqDrMkjwLzVL5xhk7bb7kRJTK0xAE3B6wKU5C4lzEhVCad/S
         dycA==
X-Gm-Message-State: AGi0PuaBpjxggwmJzyTAl85NWcJMJ3Mvu9sB3bTVWGcYtzFLnsZp/ImU
        XmmuLPyCdodWuB0/giC0fgu2zQ==
X-Google-Smtp-Source: APiQypJc7M6g4SJSxadMb830ZLUuNjVyEPZxJsFHSeWGeY7zkoZSsxwQWcW79Vv6OwRGwssTlFoC0w==
X-Received: by 2002:a5d:438c:: with SMTP id i12mr4404415wrq.14.1587135747372;
        Fri, 17 Apr 2020 08:02:27 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id e5sm33270104wru.92.2020.04.17.08.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 08:02:26 -0700 (PDT)
Date:   Fri, 17 Apr 2020 17:02:24 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jiri Kosina <trivial@kernel.org>, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH trivial 3/6] drm: Fix misspellings of "Analog Devices"
Message-ID: <20200417150224.GO3456981@phenom.ffwll.local>
Mail-Followup-To: Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Jiri Kosina <trivial@kernel.org>,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-iio@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20200416103058.15269-1-geert+renesas@glider.be>
 <20200416103058.15269-4-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416103058.15269-4-geert+renesas@glider.be>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Apr 16, 2020 at 12:30:55PM +0200, Geert Uytterhoeven wrote:
> According to https://www.analog.com/, the company name is spelled
> "Analog Devices".
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Queued for 5.8 in drm-misc-next, thanks for your patch.
-Daniel

> ---
>  drivers/gpu/drm/bridge/adv7511/Kconfig | 2 +-
>  drivers/gpu/drm/drm_fb_cma_helper.c    | 2 +-
>  drivers/gpu/drm/tegra/fb.c             | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/adv7511/Kconfig b/drivers/gpu/drm/bridge/adv7511/Kconfig
> index 47d4eb9e845d085c..f46a5e26b5dd6406 100644
> --- a/drivers/gpu/drm/bridge/adv7511/Kconfig
> +++ b/drivers/gpu/drm/bridge/adv7511/Kconfig
> @@ -6,7 +6,7 @@ config DRM_I2C_ADV7511
>  	select REGMAP_I2C
>  	select DRM_MIPI_DSI
>  	help
> -	  Support for the Analog Device ADV7511(W)/13/33/35 HDMI encoders.
> +	  Support for the Analog Devices ADV7511(W)/13/33/35 HDMI encoders.
>  
>  config DRM_I2C_ADV7511_AUDIO
>  	bool "ADV7511 HDMI Audio driver"
> diff --git a/drivers/gpu/drm/drm_fb_cma_helper.c b/drivers/gpu/drm/drm_fb_cma_helper.c
> index 9801c0333eca29e9..cb2349ad338d953b 100644
> --- a/drivers/gpu/drm/drm_fb_cma_helper.c
> +++ b/drivers/gpu/drm/drm_fb_cma_helper.c
> @@ -2,7 +2,7 @@
>  /*
>   * drm kms/fb cma (contiguous memory allocator) helper functions
>   *
> - * Copyright (C) 2012 Analog Device Inc.
> + * Copyright (C) 2012 Analog Devices Inc.
>   *   Author: Lars-Peter Clausen <lars@metafoo.de>
>   *
>   * Based on udl_fbdev.c
> diff --git a/drivers/gpu/drm/tegra/fb.c b/drivers/gpu/drm/tegra/fb.c
> index b8a328f538626e7a..2b0666ac681b8721 100644
> --- a/drivers/gpu/drm/tegra/fb.c
> +++ b/drivers/gpu/drm/tegra/fb.c
> @@ -4,7 +4,7 @@
>   * Copyright (C) 2012 NVIDIA CORPORATION.  All rights reserved.
>   *
>   * Based on the KMS/FB CMA helpers
> - *   Copyright (C) 2012 Analog Device Inc.
> + *   Copyright (C) 2012 Analog Devices Inc.
>   */
>  
>  #include <linux/console.h>
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
