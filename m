Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0992614DDAB
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 16:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbgA3PU1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jan 2020 10:20:27 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36825 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbgA3PU1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Jan 2020 10:20:27 -0500
Received: by mail-oi1-f193.google.com with SMTP id c16so3854605oic.3;
        Thu, 30 Jan 2020 07:20:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WNCJ3fFv9afjpgEKz2nnXpr6o0yqcMYAfDjKIFMFbPk=;
        b=UZAcda68ZlhBz0gYSrdXvd7vCkRcvYA4Smhf1ZeBglpNiEmtH1raqW3yN+4VQEc8HK
         VSQlbuXpvPOCFQbzPNgUy3pkaLKDf/51+HUW++88v+4RIIqy4TCwWHMv29JoR17mPRN9
         1glnehhfBG0b/reFhnCuz/Hp5uNBvEbaBUckjFYbpGkhkLsugYt9/Cn1V+JkjdFyl+rY
         vkO6s4znuLZXvHfKbFYQv7zJjCPEeA3MuyXzuYebTPQW0vh9KKnmZ6tOT48i5e1x5e1J
         YvX18rq97IMF2avJg9enTwEJBUIBIpiDrY70d6a0vwEyXR6yN4dhCUmlO48hxk9xhjVZ
         s3xw==
X-Gm-Message-State: APjAAAWJgpZjrwVUBMCDyVIsgkOjkEoQgsf4wN322/3JSvt7lz22Kd/U
        aHWNrS9q1gjEABl2rLLiaUttSVAC140tkLIkqCEYpw==
X-Google-Smtp-Source: APXvYqzflHsnCYgt2AkRBdP//1sUvjzQS+np1ftDhBuTxCldM9jiXd3IEqtcMaVn2eBdR5zrXJ8b1XAluhqMR5mSnXY=
X-Received: by 2002:aca:1a06:: with SMTP id a6mr3096312oia.148.1580397626036;
 Thu, 30 Jan 2020 07:20:26 -0800 (PST)
MIME-Version: 1.0
References: <20200130114220.23538-1-peter.ujfalusi@ti.com> <20200130114220.23538-2-peter.ujfalusi@ti.com>
In-Reply-To: <20200130114220.23538-2-peter.ujfalusi@ti.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Jan 2020 16:20:14 +0100
Message-ID: <CAMuHMdUdhqRU8NmHrcgKQpiVDsuFosWUykZs47HdF9RRCDv-KA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dmaengine: Cleanups for the slave <-> channel symlink support
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Vinod <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Peter,

On Thu, Jan 30, 2020 at 12:41 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> No need to use goto to jump over the
> return chan ? chan : ERR_PTR(-EPROBE_DEFER);
> We can just revert the check and return right there.
>
> Do not fail the channel request if the chan->name allocation fails, but
> print a warning about it.
>
> Change the dev_err to dev_warn if sysfs_create_link() fails as it is not
> fatal.
>
> Only attempt to remove the DMA_SLAVE_NAME symlink if it is created - or it
> was attempted to be created.
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Thanks for your patch!

> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -756,22 +756,24 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
>         }
>         mutex_unlock(&dma_list_mutex);
>
> -       if (!IS_ERR_OR_NULL(chan))
> -               goto found;
> -
> -       return chan ? chan : ERR_PTR(-EPROBE_DEFER);
> +       if (IS_ERR_OR_NULL(chan))
> +               return chan ? chan : ERR_PTR(-EPROBE_DEFER);
>
>  found:
> -       chan->slave = dev;
>         chan->name = kasprintf(GFP_KERNEL, "dma:%s", name);
> -       if (!chan->name)
> -               return ERR_PTR(-ENOMEM);
> +       if (!chan->name) {
> +               dev_warn(dev,
> +                        "Cannot allocate memory for slave symlink name\n");

No need to print a message, as the memory allocator core will have
screamed already.

> +               return chan;
> +       }
> +       chan->slave = dev;
>
>         if (sysfs_create_link(&chan->dev->device.kobj, &dev->kobj,
>                               DMA_SLAVE_NAME))
> -               dev_err(dev, "Cannot create DMA %s symlink\n", DMA_SLAVE_NAME);
> +               dev_warn(dev, "Cannot create DMA %s symlink\n", DMA_SLAVE_NAME);
>         if (sysfs_create_link(&dev->kobj, &chan->dev->device.kobj, chan->name))
> -               dev_err(dev, "Cannot create DMA %s symlink\n", chan->name);
> +               dev_warn(dev, "Cannot create DMA %s symlink\n", chan->name);
> +
>         return chan;
>  }
>  EXPORT_SYMBOL_GPL(dma_request_chan);

With the above fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
