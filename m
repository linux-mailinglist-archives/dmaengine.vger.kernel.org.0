Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFB8814D868
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 10:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgA3Jvj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jan 2020 04:51:39 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44916 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgA3Jvj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Jan 2020 04:51:39 -0500
Received: by mail-ot1-f65.google.com with SMTP id h9so2501739otj.11;
        Thu, 30 Jan 2020 01:51:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lZNzSqthLHYkqAf+ynA39kr/Am6N06NLfXmilmY21PI=;
        b=plffaIm5S+vxOS/hjxxtl6OlTNg1cu8OmnP1JU5c2DVqdUmE5s0fdayrCkzoBmieba
         uGJqdKmpWZzeReAhD5WJmwm7RkBowzcD2Am7wxfNCjCuIFe6RqMMUIeRHjLa0uqt3N5X
         IctQ2+LIM53LVPFtG/H+Lq7uKIc2vguNjh2Zkn+X1cP9ruASTQrKG1S+zcMjbFu066g0
         K9rm7uamzpshWdJmMUC47D1klhXDw+J/O8A/0KzDT9bMTzhh3KMmIwhc4jRyCDRPy5V6
         7kfpj40eEx/dw8nv1hYaJ8Mvd5l5SE8qPDFSza30xZ8fFKtgjwuwgk5a4PCzWpEbq+CG
         T7rQ==
X-Gm-Message-State: APjAAAUEBJvfNUPvNusPYsbqkSTMFfH9akCPKOIAX5VSq0DAzNBH3Nsl
        a27oeoKttRPgeUtE0CYDm991JNgQ6572bQSunNQ=
X-Google-Smtp-Source: APXvYqwyg/qS8aFHHOnNRKRfBClQCFobEzaSBr7Pf+yd1CQDOhKad4sRfpmh2hkgiTFs7j6p7qwwKqxAJgjq+8QCHKQ=
X-Received: by 2002:a9d:146:: with SMTP id 64mr2859825otu.39.1580377898038;
 Thu, 30 Jan 2020 01:51:38 -0800 (PST)
MIME-Version: 1.0
References: <20200117153056.31363-1-geert+renesas@glider.be> <e219bc58-0d30-582f-4872-559097f212d2@ti.com>
In-Reply-To: <e219bc58-0d30-582f-4872-559097f212d2@ti.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Jan 2020 10:51:26 +0100
Message-ID: <CAMuHMdWim4kq=JCrprybMOA+ipaxNTm4+zgjrmoFxffM+nSnPw@mail.gmail.com>
Subject: Re: [PATCH v2] dmaengine: Create symlinks between DMA channels and slaves
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Peter,

On Thu, Jan 30, 2020 at 10:42 AM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> On 17/01/2020 17.30, Geert Uytterhoeven wrote:
> > Currently it is not easy to find out which DMA channels are in use, and
> > which slave devices are using which channels.
> >
> > Fix this by creating two symlinks between the DMA channel and the actual
> > slave device when a channel is requested:
> >   1. A "slave" symlink from DMA channel to slave device,
> >   2. A "dma:<name>" symlink slave device to DMA channel.
> > When the channel is released, the symlinks are removed again.
> > The latter requires keeping track of the slave device and the channel
> > name in the dma_chan structure.
> >
> > Note that this is limited to channel request functions for requesting an
> > exclusive slave channel that take a device pointer (dma_request_chan()
> > and dma_request_slave_channel*()).
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > --- a/drivers/dma/dmaengine.c
> > +++ b/drivers/dma/dmaengine.c
> > @@ -60,6 +60,8 @@ static long dmaengine_ref_count;
> >
> >  /* --- sysfs implementation --- */
> >
> > +#define DMA_SLAVE_NAME       "slave"
> > +
> >  /**
> >   * dev_to_dma_chan - convert a device pointer to its sysfs container object
> >   * @dev - device node
> > @@ -730,11 +732,11 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
> >       if (has_acpi_companion(dev) && !chan)
> >               chan = acpi_dma_request_slave_chan_by_name(dev, name);
> >
> > -     if (chan) {
> > -             /* Valid channel found or requester needs to be deferred */
> > -             if (!IS_ERR(chan) || PTR_ERR(chan) == -EPROBE_DEFER)
> > -                     return chan;
> > -     }
> > +     if (PTR_ERR(chan) == -EPROBE_DEFER)
> > +             return chan;
> > +
> > +     if (!IS_ERR_OR_NULL(chan))
> > +             goto found;
> >
> >       /* Try to find the channel via the DMA filter map(s) */
> >       mutex_lock(&dma_list_mutex);
> > @@ -754,7 +756,23 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
> >       }
> >       mutex_unlock(&dma_list_mutex);
> >
> > -     return chan ? chan : ERR_PTR(-EPROBE_DEFER);
> > +     if (!IS_ERR_OR_NULL(chan))
> > +             goto found;
> > +
> > +     return ERR_PTR(-EPROBE_DEFER);
> > +
> > +found:
> > +     chan->slave = dev;
> > +     chan->name = kasprintf(GFP_KERNEL, "dma:%s", name);
> > +     if (!chan->name)
> > +             return ERR_PTR(-ENOMEM);
>
> You will lock the channel... It is requested, but it is not released in
> case of failure.

True. Perhaps this error should just be ignored, cfr. below.
However, if this operation fails, chances are high the system will die very soon
anyway.

> > +
> > +     if (sysfs_create_link(&chan->dev->device.kobj, &dev->kobj,
> > +                           DMA_SLAVE_NAME))
> > +             dev_err(dev, "Cannot create DMA %s symlink\n", DMA_SLAVE_NAME);
> > +     if (sysfs_create_link(&dev->kobj, &chan->dev->device.kobj, chan->name))
> > +             dev_err(dev, "Cannot create DMA %s symlink\n", chan->name);
>
> It is not a problem if these fail?

IMHO, a failure to create these links is not fatal for the operation of
the device, and thus can be ignored.  Just like for debugfs.

> > +     return chan;
> >  }
> >  EXPORT_SYMBOL_GPL(dma_request_chan);
> >
> > @@ -812,6 +830,13 @@ void dma_release_channel(struct dma_chan *chan)
> >       /* drop PRIVATE cap enabled by __dma_request_channel() */
> >       if (--chan->device->privatecnt == 0)
> >               dma_cap_clear(DMA_PRIVATE, chan->device->cap_mask);
> > +     if (chan->slave) {
> > +             sysfs_remove_link(&chan->slave->kobj, chan->name);
> > +             kfree(chan->name);
> > +             chan->name = NULL;
> > +             chan->slave = NULL;
> > +     }
> > +     sysfs_remove_link(&chan->dev->device.kobj, DMA_SLAVE_NAME);
>
> If a non slave channel is released, then you remove the link you have
> never created?
>
> What happens if the link creation fails and here you attempt to remove
> the failed ones?

sysfs_remove_link() should handle removing non-existent links, and just
return -ENOENT.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
