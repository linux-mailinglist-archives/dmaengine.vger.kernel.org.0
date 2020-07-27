Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D22822E9FD
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jul 2020 12:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgG0K03 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jul 2020 06:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbgG0K03 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Jul 2020 06:26:29 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082F6C061794;
        Mon, 27 Jul 2020 03:26:29 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id q17so7770444pls.9;
        Mon, 27 Jul 2020 03:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mIbgqGp5MHZMjDC7erbJ1Rt5TOVChIklfPVrDvY14LE=;
        b=Hl1MZrCAMbdwuH66+INdibLCKo1F5WaU6Wzbw1CxFVM2/CC6eXpakmuU2zctfwPKUA
         iXI3IKDljPUoa9TZLpOUEi6bnEWomQyorlKflg3VEU1h/EN9iCI5oKYH72OSm5fN9dav
         Ft6Zx1+9I1skoUVpqVPBB9NxT+zQk/70gWHVzcHs/YTUcL48DsFlqkHfweg0TSpUlCMY
         ck2S8tlJCe39gYSVuCahnrgkdU6pQ8Negd8HCEvMwoxKRHBtfTZiCiGRTjLvuUvT+gVq
         kWc3zXYoq2sN18WJS1fmoy4sT0JeDNmnpHuRtMSHrkQp1dAHWn5vqRDy1U0l4XJPH22l
         5xHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mIbgqGp5MHZMjDC7erbJ1Rt5TOVChIklfPVrDvY14LE=;
        b=oNxDq8wqc8AzjEOtZTYe6uRkN850DXyMm6TRyngslzFK65yBP+H3nZdgoTBEIhAGfu
         h87/rRHYIaet4ZQ9LDk9C/r1N5JEWCQzNMg6rMUUdyH87JvlOcLHLccXRX+Eccd5eEnQ
         6oTkW4Te/ISo0lhg+lJ7asIFOoUbFKdtDqusY7PyPqUJk40X+xabrk4qG35C2ZNDxPuz
         KbyJN+DtbgpU1r9LcG8E+rIQqxJi+m00htdZ75jQWnb0ibJnpstbNibGUNSVljn+oKGk
         SN73U2rV0TCENDrzgFbAMhxzFzkLh7f/3Isp1fbOgbr5w629/DtVq9AsCHVBEOjeoc9p
         wZeA==
X-Gm-Message-State: AOAM532t/oJQQrn6mnIQAIxLDzelJMlfE3UA9fROnvmFXQwOFFhU48Cs
        sOerhaUZE38TLln0UGJV+7E=
X-Google-Smtp-Source: ABdhPJwvy/WOl/w2WDv1Ka8d4q2k+6ieoSAP+9ozI85rk/XR45FfGfn+17WzdJQvOpACbwFBJhlq7g==
X-Received: by 2002:a17:902:8bc6:: with SMTP id r6mr5839446plo.289.1595845588420;
        Mon, 27 Jul 2020 03:26:28 -0700 (PDT)
Received: from gmail.com ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id g3sm14217345pfq.19.2020.07.27.03.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 03:26:27 -0700 (PDT)
Date:   Mon, 27 Jul 2020 15:55:03 +0530
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v1] dmaengine: pch_dma: use generic power management
Message-ID: <20200727102503.GA7767@gmail.com>
References: <20200720113740.353479-1-vaibhavgupta40@gmail.com>
 <20200727085621.GL12965@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200727085621.GL12965@vkoul-mobl>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jul 27, 2020 at 02:26:21PM +0530, Vinod Koul wrote:
> Hi Vaibhav,
> 
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
>
Sure. But I guess just marking of "__maybe_unused" is not some significant
change. All the legacy PCI drivers have .suspend() and .resume() inside
"#ifdef CONFIG_PM" container.
It is only when I am upgrading them one by one to generic, I remove the
container and mark them with the attribute. So it is like a part of complete
generic upgrade.

Thanks
Vaibhav Gupta
> > Compile-tested only.
> 
> I would like to see some testing before we merge this
> 
> > 
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
> >  	return ret0 | ret2;
> >  }
> >  
> > -#ifdef	CONFIG_PM
> > -static void pch_dma_save_regs(struct pch_dma *pd)
> > +static void __maybe_unused pch_dma_save_regs(struct pch_dma *pd)
> >  {
> >  	struct pch_dma_chan *pd_chan;
> >  	struct dma_chan *chan, *_c;
> > @@ -759,7 +758,7 @@ static void pch_dma_save_regs(struct pch_dma *pd)
> >  	}
> >  }
> >  
> > -static void pch_dma_restore_regs(struct pch_dma *pd)
> > +static void __maybe_unused pch_dma_restore_regs(struct pch_dma *pd)
> >  {
> >  	struct pch_dma_chan *pd_chan;
> >  	struct dma_chan *chan, *_c;
> > @@ -782,40 +781,25 @@ static void pch_dma_restore_regs(struct pch_dma *pd)
> >  	}
> >  }
> >  
> > -static int pch_dma_suspend(struct pci_dev *pdev, pm_message_t state)
> > +static int __maybe_unused pch_dma_suspend(struct device *dev)
> >  {
> > -	struct pch_dma *pd = pci_get_drvdata(pdev);
> > +	struct pch_dma *pd = dev_get_drvdata(dev);
> >  
> >  	if (pd)
> >  		pch_dma_save_regs(pd);
> >  
> > -	pci_save_state(pdev);
> > -	pci_disable_device(pdev);
> > -	pci_set_power_state(pdev, pci_choose_state(pdev, state));
> > -
> >  	return 0;
> >  }
> >  
> > -static int pch_dma_resume(struct pci_dev *pdev)
> > +static int __maybe_unused pch_dma_resume(struct device *dev)
> >  {
> > -	struct pch_dma *pd = pci_get_drvdata(pdev);
> > -	int err;
> > -
> > -	pci_set_power_state(pdev, PCI_D0);
> > -	pci_restore_state(pdev);
> > -
> > -	err = pci_enable_device(pdev);
> > -	if (err) {
> > -		dev_dbg(&pdev->dev, "failed to enable device\n");
> > -		return err;
> > -	}
> > +	struct pch_dma *pd = dev_get_drvdata(dev);
> >  
> >  	if (pd)
> >  		pch_dma_restore_regs(pd);
> >  
> >  	return 0;
> >  }
> > -#endif
> >  
> >  static int pch_dma_probe(struct pci_dev *pdev,
> >  				   const struct pci_device_id *id)
> > @@ -993,15 +977,14 @@ static const struct pci_device_id pch_dma_id_table[] = {
> >  	{ 0, },
> >  };
> >  
> > +static SIMPLE_DEV_PM_OPS(pch_dma_pm_ops, pch_dma_suspend, pch_dma_resume);
> > +
> >  static struct pci_driver pch_dma_driver = {
> >  	.name		= DRV_NAME,
> >  	.id_table	= pch_dma_id_table,
> >  	.probe		= pch_dma_probe,
> >  	.remove		= pch_dma_remove,
> > -#ifdef CONFIG_PM
> > -	.suspend	= pch_dma_suspend,
> > -	.resume		= pch_dma_resume,
> > -#endif
> > +	.driver.pm	= &pch_dma_pm_ops,
> >  };
> >  
> >  module_pci_driver(pch_dma_driver);
> > -- 
> > 2.27.0
> 
> -- 
> ~Vinod
