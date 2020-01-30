Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0C214DE15
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 16:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgA3Pmv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jan 2020 10:42:51 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37461 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgA3Pmv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Jan 2020 10:42:51 -0500
Received: by mail-oi1-f194.google.com with SMTP id q84so3932573oic.4;
        Thu, 30 Jan 2020 07:42:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VQ8iVu+taBZqUnlwkUuWIwHzeZjbyY5g3urtyV2lV9o=;
        b=ecy/oJLW+Zd0I+6JIFQ2mG9N4MjNJUBGTCsaznVStlApUW98qBbTxfbdImQzBLMkak
         QCAA7GtVRAV37lpSBRMWgl53QArWJMB71G65cQ68V0qEQT4fPVwnzZGPD975wuDcENVM
         0Vk3dEk5wf2Y86mz5TCbuohqH8QMsK+LZywCx4XDvXh5QuCOJxyu0WJIBo83BQStdW6e
         jm1DclR9J0ENDUgkgIOyJQf7ptOKYt1zX++hiS4jqk6NtPOD/mp7eqmKuUhUmqlCInG0
         hcbfccxZvhaSuX44SJG8cLxTdT7l+vcCOtCW+OOSPFMDZc8bcLGw1PqVs8H1wNnSGlQw
         BEsg==
X-Gm-Message-State: APjAAAWDwTWXffLXq3HT+fTLtE+fBTaxEgsmMZCUUIbZ3vZuAqATUCr+
        UYd6f2vJ+9V/wQFqSOix0v4QUkCeR8EHVdSXlxiaVrMg
X-Google-Smtp-Source: APXvYqz+AjRlTqbZxdQzzYVwfMC93c4iiDPEfuB9aBGRKmcFwlxG6osM58zpgW8n5u7569wb0pdomN1MG5J8hhkK87Y=
X-Received: by 2002:a54:4707:: with SMTP id k7mr3103799oik.153.1580398969932;
 Thu, 30 Jan 2020 07:42:49 -0800 (PST)
MIME-Version: 1.0
References: <20200130114220.23538-1-peter.ujfalusi@ti.com> <20200130114220.23538-3-peter.ujfalusi@ti.com>
In-Reply-To: <20200130114220.23538-3-peter.ujfalusi@ti.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Jan 2020 16:42:38 +0100
Message-ID: <CAMuHMdWXuoWX=AgB=RY=5At_yw6nZJGBOK_8TXjwgYQN27JcQQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] dmaengine: Add basic debugfs support
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
> Via the /sys/kernel/debug/dmaengine users can get information about the
> DMA devices and the used channels.
>
> Example output on am654-evm with audio using two channels and after running
> dmatest on 6 channels:
>
>  # cat /sys/kernel/debug/dmaengine
> dma0 (285c0000.dma-controller): number of channels: 96
>
> dma1 (31150000.dma-controller): number of channels: 267
>  dma1chan0:             2b00000.mcasp:tx
>  dma1chan1:             2b00000.mcasp:rx
>  dma1chan2:             in-use
>  dma1chan3:             in-use
>  dma1chan4:             in-use
>  dma1chan5:             in-use
>  dma1chan6:             in-use
>  dma1chan7:             in-use
>
> For slave channels we can show the device and the channel name a given
> channel is requested.
> For non slave devices the only information we know is that the channel is
> in use.
>
> DMA drivers can implement the optional dbg_show callback to provide
> controller specific information instead of the generic one.
>
> It is easy to extend the generic dmaengine_dbg_show() to print additional
> information about the used channels.
>
> I have taken the idea from gpiolib.
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Thanks for your patch!

On Salvator-XS with R-Car H3 ES2.0:

    dma0 (ec700000.dma-controller): number of channels: 15

    dma1 (ec720000.dma-controller): number of channels: 15

    dma2 (e65a0000.dma-controller): number of channels: 2
     dma2chan0: e6590000.usb:ch0
     dma2chan1: e6590000.usb:ch1

    dma3 (e65b0000.dma-controller): number of channels: 2
     dma3chan0: e6590000.usb:ch2
     dma3chan1: e6590000.usb:ch3

    dma4 (e6460000.dma-controller): number of channels: 2
     dma4chan0: e659c000.usb:ch0
     dma4chan1: e659c000.usb:ch1

    dma5 (e6470000.dma-controller): number of channels: 2
     dma5chan0: e659c000.usb:ch2
     dma5chan1: e659c000.usb:ch3

    dma6 (e6700000.dma-controller): number of channels: 15

    dma7 (e7300000.dma-controller): number of channels: 15
     dma7chan0: e6510000.i2c:tx

    dma8 (e7310000.dma-controller): number of channels: 15
     dma8chan0: e6550000.serial:tx
     dma8chan1: e6550000.serial:rx

> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -760,6 +761,13 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
>                 return chan ? chan : ERR_PTR(-EPROBE_DEFER);
>
>  found:
> +#ifdef CONFIG_DEBUG_FS
> +       chan->slave_name = kasprintf(GFP_KERNEL, "%s:%s", dev_name(dev), name);
> +       if (!chan->slave_name)
> +               dev_warn(dev,
> +                        "Cannot allocate memory for slave name (debugfs)\n");

No need to print a message, as the memory allocation core already takes
care of that.

But, do you really need chan->slave_name?
You already have chan->slave and chan->name.

> +#endif
> +
>         chan->name = kasprintf(GFP_KERNEL, "dma:%s", name);
>         if (!chan->name) {
>                 dev_warn(dev,

> @@ -1562,3 +1577,108 @@ static int __init dma_bus_init(void)
>         return class_register(&dma_devclass);
>  }
>  arch_initcall(dma_bus_init);
> +
> +#ifdef CONFIG_DEBUG_FS
> +static void *dmaengine_seq_start(struct seq_file *s, loff_t *pos)
> +{
> +       struct dma_device *dma_dev = NULL;
> +       loff_t index = *pos;
> +
> +       s->private = "";
> +
> +       mutex_lock(&dma_list_mutex);
> +       list_for_each_entry(dma_dev, &dma_device_list, global_node)
> +               if (index-- == 0) {
> +                       mutex_unlock(&dma_list_mutex);
> +                       return dma_dev;

Can the dma_device go away after unlocking the list?
Unlike dma_request_chan(), this doesn't increase a refcnt.

> +               }
> +       mutex_unlock(&dma_list_mutex);
> +
> +       return NULL;
> +}
> +
> +static void *dmaengine_seq_next(struct seq_file *s, void *v, loff_t *pos)
> +{
> +       struct dma_device *dma_dev = v;
> +       void *ret = NULL;
> +
> +       mutex_lock(&dma_list_mutex);
> +       if (list_is_last(&dma_dev->global_node, &dma_device_list))
> +               ret = NULL;
> +       else
> +               ret = list_entry(dma_dev->global_node.next,
> +                                struct dma_device, global_node);
> +       mutex_unlock(&dma_list_mutex);

Likewise.

> +
> +       s->private = "\n";
> +       ++*pos;
> +
> +       return ret;
> +}
> +
> +static void dmaengine_seq_stop(struct seq_file *s, void *v)
> +{
> +}
> +
> +static void dmaengine_dbg_show(struct seq_file *s, struct dma_device *dma_dev)
> +{
> +       struct dma_chan *chan;
> +
> +       list_for_each_entry(chan, &dma_dev->channels, device_node) {
> +               if (chan->client_count) {
> +                       seq_printf(s, " dma%dchan%d:", dma_dev->dev_id,
> +                                  chan->chan_id);
> +                       if (chan->slave_name)
> +                               seq_printf(s, "\t\t%s\n", chan->slave_name);
> +                       else
> +                               seq_printf(s, "\t\t%s\n", "in-use");

The truncated ternary operator might help here:

        seq_printf(s, "\t\t%s\n", chan->slave_name ?: "in-use");

However, you might as well just use dev_name(chan->slave) and chan->name
instead of chan->slave_name.

> +               }
> +       }
> +}
> +
> +static int dmaengine_seq_show(struct seq_file *s, void *v)
> +{
> +       struct dma_device *dma_dev = v;
> +
> +       seq_printf(s, "%sdma%d (%s): number of channels: %u\n",
> +                  (char *)s->private, dma_dev->dev_id, dev_name(dma_dev->dev),
> +                  dma_dev->chancnt);
> +
> +       if (dma_dev->dbg_show)
> +               dma_dev->dbg_show(s, dma_dev);

So providing a custom .dbg_show() means replacing the standard info, not
augmenting it?

> +       else
> +               dmaengine_dbg_show(s, dma_dev);
> +
> +       return 0;
> +}

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
