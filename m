Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1254322EB0A
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jul 2020 13:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbgG0LTb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jul 2020 07:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbgG0LT3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Jul 2020 07:19:29 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6D8C061794;
        Mon, 27 Jul 2020 04:19:29 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id il6so3397502pjb.0;
        Mon, 27 Jul 2020 04:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WlZG7+7DASiAzqRKJZMw2+Puq2+bYr5zSYxEeHcy5yE=;
        b=tnPmAVCazQgMI6svqYEuWU5taBJyw947KUxPTAau0I/QZbDyWIrbIpF91LGxjwuXGS
         LRPhm0xQXCIHj6tLs3yJMPYfYpDu6C2ECNaIk4i+MVZtfJSrr3XrrO8UUwTiZNve2FKx
         tt61tOCsJ7vzFAXkYye3SH7Ypg93rIZ6DSgW08NfmYPzTXpbStrm3Apl1ZWnrYNHLvWD
         OBldOrdbRoK6cSzFCmd5prG6Tm8BCV2/TP0GPyY4scENzh9f169OGou9zJOOMnO77e2T
         BtfzRoDkSg4mYSwTZbYir+6sEgEO3hafKHhPd/Dxho5+HIiA0vuqcDXdyTYNzbfldbHo
         Wldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WlZG7+7DASiAzqRKJZMw2+Puq2+bYr5zSYxEeHcy5yE=;
        b=cj2GAMnw6cpsEmp7YZMMbhUUeU9x0CGTpVvuOocr3plvA2onphV6HKZExUugHM11Ak
         ufvwoUPQvufz/tirZ8Zz6ZFccOAZgLt/dXVD9boNhS7sqGvMfEPYG6kyCVhdZmyDKpA6
         ME1QN5BI+OvvaTVDhdQCw0c4M7VR2g0BCf8vH/Z26m+oXwudrrm+Pj7sazqbVyMHZuub
         Yn+77KTwmpPrWpMVrbCNreaaV5/oBA1EqOVUM5cSCcoembfz0/oN0dHbbSc2fPa82hQN
         zmtI23KbBUKS6cJGWvXxLtdIvnfT6hTUm2CquVYRcCd/IxRyf1YEBE5PZowXdG7DkA75
         3ldA==
X-Gm-Message-State: AOAM5336Qy8o5nOZVkKMTxdSL3qSDXkq0brp9Ejstj+WacUFNOIfd5z5
        xqnXfMIb0Np5PhyYaCNY2cqmvzcZ9F8ryyyQ6kI=
X-Google-Smtp-Source: ABdhPJyXz/W9tfXLQ1P01pH1D/POYketJG+WWNnTcbGfmsPrhZC3owwch/SJ3tmfvaxowkKhGEHHRFKy/88Ks6iHGfQ=
X-Received: by 2002:a17:90a:8985:: with SMTP id v5mr2785017pjn.181.1595848769238;
 Mon, 27 Jul 2020 04:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200720113740.353479-1-vaibhavgupta40@gmail.com> <20200727085621.GL12965@vkoul-mobl>
In-Reply-To: <20200727085621.GL12965@vkoul-mobl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 27 Jul 2020 14:19:14 +0300
Message-ID: <CAHp75VesTCOffxiy6=HG=g2t4=js3SnTm4LcdrgAGYiNvSS65Q@mail.gmail.com>
Subject: Re: [PATCH v1] dmaengine: pch_dma: use generic power management
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        dmaengine <dmaengine@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jul 27, 2020 at 1:16 PM Vinod Koul <vkoul@kernel.org> wrote:
> On 20-07-20, 17:07, Vaibhav Gupta wrote:
> > Drivers using legacy PM have to manage PCI states and device's PM states
> > themselves. They also need to take care of configuration registers.
> >
> > With improved and powerful support of generic PM, PCI Core takes care of
> > above mentioned, device-independent, jobs.
> >
> > This driver makes use of PCI helper functions like
> > pci_save/restore_state(), pci_enable/disable_device(),
> > and pci_set_power_state() to do required operations. In generic mode, they
> > are no longer needed.
> >
> > Change function parameter in both .suspend() and .resume() to
> > "struct device*" type. Use dev_get_drvdata() to get drv data.
>
> You are doing too many things in One patch. Do consider splitting them
> up to a change per patch. for example using __maybe could be one patch,
> removing code is suspend-resume callbacks would be other one.

Vinod, while I completely agree with you in general, in this case it
would make more unnecessary churn and will be rather unhelpful in all
ways: for the contributor to do this work, for the reader to collect
all the pieces. It also will be a bisectability issue, because the
#ifdeffery replacement (IIRC you need to move from CONFIG_PM to
CONFIG_PM_SLEEP). I really don't see any advantages of the splitting
here.

> > Compile-tested only.
>
> I would like to see some testing before we merge this

I have hardware to test (Intel Minnowboard v1) but have no time. And
taking into account that I did similar changes for many other drivers,
I can give my
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
and take responsibility if somebody complains in the future (I don't
believe it will be one).

P.S. Another scenario if Vaibhav can find that board (there were
dozens of thousands at least produced and floating on the second hand
market) and test himself. It may be good since he touches the full lot
of PCH (EGT20) drivers.

> > Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> > ---
> >  drivers/dma/pch_dma.c | 35 +++++++++--------------------------
> >  1 file changed, 9 insertions(+), 26 deletions(-)
> >
> > diff --git a/drivers/dma/pch_dma.c b/drivers/dma/pch_dma.c
> > index a3b0b4c56a19..e93005837e3f 100644
> > --- a/drivers/dma/pch_dma.c
> > +++ b/drivers/dma/pch_dma.c
> > @@ -735,8 +735,7 @@ static irqreturn_t pd_irq(int irq, void *devid)
> >       return ret0 | ret2;
> >  }
> >
> > -#ifdef       CONFIG_PM
> > -static void pch_dma_save_regs(struct pch_dma *pd)
> > +static void __maybe_unused pch_dma_save_regs(struct pch_dma *pd)
> >  {
> >       struct pch_dma_chan *pd_chan;
> >       struct dma_chan *chan, *_c;
> > @@ -759,7 +758,7 @@ static void pch_dma_save_regs(struct pch_dma *pd)
> >       }
> >  }
> >
> > -static void pch_dma_restore_regs(struct pch_dma *pd)
> > +static void __maybe_unused pch_dma_restore_regs(struct pch_dma *pd)
> >  {
> >       struct pch_dma_chan *pd_chan;
> >       struct dma_chan *chan, *_c;
> > @@ -782,40 +781,25 @@ static void pch_dma_restore_regs(struct pch_dma *pd)
> >       }
> >  }
> >
> > -static int pch_dma_suspend(struct pci_dev *pdev, pm_message_t state)
> > +static int __maybe_unused pch_dma_suspend(struct device *dev)
> >  {
> > -     struct pch_dma *pd = pci_get_drvdata(pdev);
> > +     struct pch_dma *pd = dev_get_drvdata(dev);
> >
> >       if (pd)
> >               pch_dma_save_regs(pd);
> >
> > -     pci_save_state(pdev);
> > -     pci_disable_device(pdev);
> > -     pci_set_power_state(pdev, pci_choose_state(pdev, state));
> > -
> >       return 0;
> >  }
> >
> > -static int pch_dma_resume(struct pci_dev *pdev)
> > +static int __maybe_unused pch_dma_resume(struct device *dev)
> >  {
> > -     struct pch_dma *pd = pci_get_drvdata(pdev);
> > -     int err;
> > -
> > -     pci_set_power_state(pdev, PCI_D0);
> > -     pci_restore_state(pdev);
> > -
> > -     err = pci_enable_device(pdev);
> > -     if (err) {
> > -             dev_dbg(&pdev->dev, "failed to enable device\n");
> > -             return err;
> > -     }
> > +     struct pch_dma *pd = dev_get_drvdata(dev);
> >
> >       if (pd)
> >               pch_dma_restore_regs(pd);
> >
> >       return 0;
> >  }
> > -#endif
> >
> >  static int pch_dma_probe(struct pci_dev *pdev,
> >                                  const struct pci_device_id *id)
> > @@ -993,15 +977,14 @@ static const struct pci_device_id pch_dma_id_table[] = {
> >       { 0, },
> >  };
> >
> > +static SIMPLE_DEV_PM_OPS(pch_dma_pm_ops, pch_dma_suspend, pch_dma_resume);
> > +
> >  static struct pci_driver pch_dma_driver = {
> >       .name           = DRV_NAME,
> >       .id_table       = pch_dma_id_table,
> >       .probe          = pch_dma_probe,
> >       .remove         = pch_dma_remove,
> > -#ifdef CONFIG_PM
> > -     .suspend        = pch_dma_suspend,
> > -     .resume         = pch_dma_resume,
> > -#endif
> > +     .driver.pm      = &pch_dma_pm_ops,
> >  };
> >
> >  module_pci_driver(pch_dma_driver);
> > --
> > 2.27.0
>
> --
> ~Vinod



-- 
With Best Regards,
Andy Shevchenko
