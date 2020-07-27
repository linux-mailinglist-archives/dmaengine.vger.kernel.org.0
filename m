Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2012922E840
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jul 2020 10:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgG0I40 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jul 2020 04:56:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbgG0I40 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 Jul 2020 04:56:26 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64F0520719;
        Mon, 27 Jul 2020 08:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595840185;
        bh=ckrzN6x1hBtNGks7Ouqr9lQX/r6n4nBW5be26Bg/ZCg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w7V0Rk7+G2pBeE7TNO5yE9PaBiyD86DJaUifty8MDZfy+IcqnRFn9vsAJ6HkBKvem
         LMWb4s/DDoTTlgCDZ441WzPrgoF4YKM+WQN+vdf3p5zfG8oFY5AWxnxXa5oG63KfoQ
         kdIgLCe+0H3myAnjbOEWhgyxExwtjjsBLmm17jPE=
Date:   Mon, 27 Jul 2020 14:26:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Vaibhav Gupta <vaibhavgupta40@gmail.com>
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
Message-ID: <20200727085621.GL12965@vkoul-mobl>
References: <20200720113740.353479-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720113740.353479-1-vaibhavgupta40@gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vaibhav,

On 20-07-20, 17:07, Vaibhav Gupta wrote:
> Drivers using legacy PM have to manage PCI states and device's PM states
> themselves. They also need to take care of configuration registers.
> 
> With improved and powerful support of generic PM, PCI Core takes care of
> above mentioned, device-independent, jobs.
> 
> This driver makes use of PCI helper functions like
> pci_save/restore_state(), pci_enable/disable_device(),
> and pci_set_power_state() to do required operations. In generic mode, they
> are no longer needed.
> 
> Change function parameter in both .suspend() and .resume() to
> "struct device*" type. Use dev_get_drvdata() to get drv data.

You are doing too many things in One patch. Do consider splitting them
up to a change per patch. for example using __maybe could be one patch,
removing code is suspend-resume callbacks would be other one.
> 
> Compile-tested only.

I would like to see some testing before we merge this

> 
> Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> ---
>  drivers/dma/pch_dma.c | 35 +++++++++--------------------------
>  1 file changed, 9 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/dma/pch_dma.c b/drivers/dma/pch_dma.c
> index a3b0b4c56a19..e93005837e3f 100644
> --- a/drivers/dma/pch_dma.c
> +++ b/drivers/dma/pch_dma.c
> @@ -735,8 +735,7 @@ static irqreturn_t pd_irq(int irq, void *devid)
>  	return ret0 | ret2;
>  }
>  
> -#ifdef	CONFIG_PM
> -static void pch_dma_save_regs(struct pch_dma *pd)
> +static void __maybe_unused pch_dma_save_regs(struct pch_dma *pd)
>  {
>  	struct pch_dma_chan *pd_chan;
>  	struct dma_chan *chan, *_c;
> @@ -759,7 +758,7 @@ static void pch_dma_save_regs(struct pch_dma *pd)
>  	}
>  }
>  
> -static void pch_dma_restore_regs(struct pch_dma *pd)
> +static void __maybe_unused pch_dma_restore_regs(struct pch_dma *pd)
>  {
>  	struct pch_dma_chan *pd_chan;
>  	struct dma_chan *chan, *_c;
> @@ -782,40 +781,25 @@ static void pch_dma_restore_regs(struct pch_dma *pd)
>  	}
>  }
>  
> -static int pch_dma_suspend(struct pci_dev *pdev, pm_message_t state)
> +static int __maybe_unused pch_dma_suspend(struct device *dev)
>  {
> -	struct pch_dma *pd = pci_get_drvdata(pdev);
> +	struct pch_dma *pd = dev_get_drvdata(dev);
>  
>  	if (pd)
>  		pch_dma_save_regs(pd);
>  
> -	pci_save_state(pdev);
> -	pci_disable_device(pdev);
> -	pci_set_power_state(pdev, pci_choose_state(pdev, state));
> -
>  	return 0;
>  }
>  
> -static int pch_dma_resume(struct pci_dev *pdev)
> +static int __maybe_unused pch_dma_resume(struct device *dev)
>  {
> -	struct pch_dma *pd = pci_get_drvdata(pdev);
> -	int err;
> -
> -	pci_set_power_state(pdev, PCI_D0);
> -	pci_restore_state(pdev);
> -
> -	err = pci_enable_device(pdev);
> -	if (err) {
> -		dev_dbg(&pdev->dev, "failed to enable device\n");
> -		return err;
> -	}
> +	struct pch_dma *pd = dev_get_drvdata(dev);
>  
>  	if (pd)
>  		pch_dma_restore_regs(pd);
>  
>  	return 0;
>  }
> -#endif
>  
>  static int pch_dma_probe(struct pci_dev *pdev,
>  				   const struct pci_device_id *id)
> @@ -993,15 +977,14 @@ static const struct pci_device_id pch_dma_id_table[] = {
>  	{ 0, },
>  };
>  
> +static SIMPLE_DEV_PM_OPS(pch_dma_pm_ops, pch_dma_suspend, pch_dma_resume);
> +
>  static struct pci_driver pch_dma_driver = {
>  	.name		= DRV_NAME,
>  	.id_table	= pch_dma_id_table,
>  	.probe		= pch_dma_probe,
>  	.remove		= pch_dma_remove,
> -#ifdef CONFIG_PM
> -	.suspend	= pch_dma_suspend,
> -	.resume		= pch_dma_resume,
> -#endif
> +	.driver.pm	= &pch_dma_pm_ops,
>  };
>  
>  module_pci_driver(pch_dma_driver);
> -- 
> 2.27.0

-- 
~Vinod
