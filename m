Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A4A22ECDE
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jul 2020 15:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgG0NJg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jul 2020 09:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbgG0NJg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Jul 2020 09:09:36 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2D9C061794;
        Mon, 27 Jul 2020 06:09:35 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id s26so9034153pfm.4;
        Mon, 27 Jul 2020 06:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V2H1tlMLXxYxucqE7fzBGTDFcMq1gtGJ4rquGrh2ZhI=;
        b=MIlJM9Xzo58AFvW6Fy6A5plY/aankHz0/bF/5QpI8pCOSRwmmQKZQgxfbewFXSFRqq
         auBb7mhhQlZ6SBlipvkDLaKNatoNYi+OTmFFv9YmJhx6iUvtJ4Qn/XTafA9G3Q+cNVZm
         4pal2Pq4R9UPMuXTZT6yQuuRw8TB9VCAsuExrFjE/wa3sCCEljimv6dXXE1vkwwvoVrr
         nEY9rFTTZjQZqXAYSxxioJGLu/42ONwmbgUqAAi2pujPg8HIv9Br8V3AHMEE5eZjeSkm
         HK6v7wGsRcT0pi5nrfdHcHOX24htw+bi3aGtXFG2jcESmlrz3qWpqR+RviABgdKwns7W
         alHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V2H1tlMLXxYxucqE7fzBGTDFcMq1gtGJ4rquGrh2ZhI=;
        b=j/YtD35N6tLu7LzJQBR/kLvJsHbHrPf8I0pwhYEHXLKdQaKna/iR1obrCBUdAF1ewS
         StycepV52eekvXG4kxPDToVJzgwu8cDehqQsjAQjIzN/WTyC7P7/i1wPASTGiDx7DXEV
         xyQMBseu6GAx3dxmzdzn2gaF/zO/5ylJzRNwF6LeQH/pxxoYe8gbPSA+GBIA6ooSKKVj
         6kp0AojrPLomZ7sNDvlOkBORfjvv3VVxIgKeU1IcIS6NtALK6pAiI2w+F4JaggtQJgZk
         sAurFPoxVAmrXvMORK3WhhYfpp8NsYT7PERfGC/3AfyqWXQRdzGSh2SPddAoPsvHkF3T
         J90A==
X-Gm-Message-State: AOAM530o6TuDtFV8+XyQGY+8wQ8PcFLaPfug38vMTBc4wCuli3SOx/0J
        upNCcVkpC5BNL2aeV+po7oA=
X-Google-Smtp-Source: ABdhPJzmW4MB+8kyEVPNT2dKVYcXMow76EuwUPI+GPmwmKEC003b4GlrTMTumZ3rTmpPvjb2voj96Q==
X-Received: by 2002:a63:7b15:: with SMTP id w21mr20524655pgc.386.1595855374446;
        Mon, 27 Jul 2020 06:09:34 -0700 (PDT)
Received: from gmail.com ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id 186sm14925807pfe.1.2020.07.27.06.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 06:09:33 -0700 (PDT)
Date:   Mon, 27 Jul 2020 18:38:09 +0530
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        dmaengine <dmaengine@vger.kernel.org>
Subject: Re: [PATCH v1] dmaengine: pch_dma: use generic power management
Message-ID: <20200727130809.GA82098@gmail.com>
References: <20200720113740.353479-1-vaibhavgupta40@gmail.com>
 <20200727085621.GL12965@vkoul-mobl>
 <CAHp75VesTCOffxiy6=HG=g2t4=js3SnTm4LcdrgAGYiNvSS65Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75VesTCOffxiy6=HG=g2t4=js3SnTm4LcdrgAGYiNvSS65Q@mail.gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jul 27, 2020 at 02:19:14PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 27, 2020 at 1:16 PM Vinod Koul <vkoul@kernel.org> wrote:
> > On 20-07-20, 17:07, Vaibhav Gupta wrote:
> > > Drivers using legacy PM have to manage PCI states and device's PM states
> > > themselves. They also need to take care of configuration registers.
> > >
> > > With improved and powerful support of generic PM, PCI Core takes care of
> > > above mentioned, device-independent, jobs.
> > >
> > > This driver makes use of PCI helper functions like
> > > pci_save/restore_state(), pci_enable/disable_device(),
> > > and pci_set_power_state() to do required operations. In generic mode, they
> > > are no longer needed.
> > >
> > > Change function parameter in both .suspend() and .resume() to
> > > "struct device*" type. Use dev_get_drvdata() to get drv data.
> >
> > You are doing too many things in One patch. Do consider splitting them
> > up to a change per patch. for example using __maybe could be one patch,
> > removing code is suspend-resume callbacks would be other one.
> 
> Vinod, while I completely agree with you in general, in this case it
> would make more unnecessary churn and will be rather unhelpful in all
> ways: for the contributor to do this work, for the reader to collect
> all the pieces. It also will be a bisectability issue, because the
> #ifdeffery replacement (IIRC you need to move from CONFIG_PM to
> CONFIG_PM_SLEEP). I really don't see any advantages of the splitting
> here.
> 
> > > Compile-tested only.
> >
> > I would like to see some testing before we merge this
> 
> I have hardware to test (Intel Minnowboard v1) but have no time. And
> taking into account that I did similar changes for many other drivers,
> I can give my
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> and take responsibility if somebody complains in the future (I don't
> believe it will be one).
>
Thanks! :D 
> P.S. Another scenario if Vaibhav can find that board (there were
> dozens of thousands at least produced and floating on the second hand
> market) and test himself. It may be good since he touches the full lot
> of PCH (EGT20) drivers.
> 
I cannot promise, but surely will try to get my hands on it :)

Thanks
Vaibhav Gupta
> > > Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> > > ---
> > >  drivers/dma/pch_dma.c | 35 +++++++++--------------------------
> > >  1 file changed, 9 insertions(+), 26 deletions(-)
> > >
> > > diff --git a/drivers/dma/pch_dma.c b/drivers/dma/pch_dma.c
> > > index a3b0b4c56a19..e93005837e3f 100644
> > > --- a/drivers/dma/pch_dma.c
> > > +++ b/drivers/dma/pch_dma.c
> > > @@ -735,8 +735,7 @@ static irqreturn_t pd_irq(int irq, void *devid)
> > >       return ret0 | ret2;
> > >  }
> > >
> > > -#ifdef       CONFIG_PM
> > > -static void pch_dma_save_regs(struct pch_dma *pd)
> > > +static void __maybe_unused pch_dma_save_regs(struct pch_dma *pd)
> > >  {
> > >       struct pch_dma_chan *pd_chan;
> > >       struct dma_chan *chan, *_c;
> > > @@ -759,7 +758,7 @@ static void pch_dma_save_regs(struct pch_dma *pd)
> > >       }
> > >  }
> > >
> > > -static void pch_dma_restore_regs(struct pch_dma *pd)
> > > +static void __maybe_unused pch_dma_restore_regs(struct pch_dma *pd)
> > >  {
> > >       struct pch_dma_chan *pd_chan;
> > >       struct dma_chan *chan, *_c;
> > > @@ -782,40 +781,25 @@ static void pch_dma_restore_regs(struct pch_dma *pd)
> > >       }
> > >  }
> > >
> > > -static int pch_dma_suspend(struct pci_dev *pdev, pm_message_t state)
> > > +static int __maybe_unused pch_dma_suspend(struct device *dev)
> > >  {
> > > -     struct pch_dma *pd = pci_get_drvdata(pdev);
> > > +     struct pch_dma *pd = dev_get_drvdata(dev);
> > >
> > >       if (pd)
> > >               pch_dma_save_regs(pd);
> > >
> > > -     pci_save_state(pdev);
> > > -     pci_disable_device(pdev);
> > > -     pci_set_power_state(pdev, pci_choose_state(pdev, state));
> > > -
> > >       return 0;
> > >  }
> > >
> > > -static int pch_dma_resume(struct pci_dev *pdev)
> > > +static int __maybe_unused pch_dma_resume(struct device *dev)
> > >  {
> > > -     struct pch_dma *pd = pci_get_drvdata(pdev);
> > > -     int err;
> > > -
> > > -     pci_set_power_state(pdev, PCI_D0);
> > > -     pci_restore_state(pdev);
> > > -
> > > -     err = pci_enable_device(pdev);
> > > -     if (err) {
> > > -             dev_dbg(&pdev->dev, "failed to enable device\n");
> > > -             return err;
> > > -     }
> > > +     struct pch_dma *pd = dev_get_drvdata(dev);
> > >
> > >       if (pd)
> > >               pch_dma_restore_regs(pd);
> > >
> > >       return 0;
> > >  }
> > > -#endif
> > >
> > >  static int pch_dma_probe(struct pci_dev *pdev,
> > >                                  const struct pci_device_id *id)
> > > @@ -993,15 +977,14 @@ static const struct pci_device_id pch_dma_id_table[] = {
> > >       { 0, },
> > >  };
> > >
> > > +static SIMPLE_DEV_PM_OPS(pch_dma_pm_ops, pch_dma_suspend, pch_dma_resume);
> > > +
> > >  static struct pci_driver pch_dma_driver = {
> > >       .name           = DRV_NAME,
> > >       .id_table       = pch_dma_id_table,
> > >       .probe          = pch_dma_probe,
> > >       .remove         = pch_dma_remove,
> > > -#ifdef CONFIG_PM
> > > -     .suspend        = pch_dma_suspend,
> > > -     .resume         = pch_dma_resume,
> > > -#endif
> > > +     .driver.pm      = &pch_dma_pm_ops,
> > >  };
> > >
> > >  module_pci_driver(pch_dma_driver);
> > > --
> > > 2.27.0
> >
> > --
> > ~Vinod
> 
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
