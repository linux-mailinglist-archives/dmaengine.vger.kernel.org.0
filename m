Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B88F399F90
	for <lists+dmaengine@lfdr.de>; Thu,  3 Jun 2021 13:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhFCLK5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Jun 2021 07:10:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:34106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229982AbhFCLK4 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 3 Jun 2021 07:10:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B771613DC;
        Thu,  3 Jun 2021 11:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622718552;
        bh=oulCTMRij/0YKDHZtxJlmXnKJmrq738g2Nu5+8hJZhk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uEQn0pJD1PpIW/izJTVru84b4xULfY30cOgBeXGpgSr7q5q89Jf33lpwgdwsqXLlT
         biDKRwbm7WED7jPvms1Cyc5RgvtroAhrGbmW7f8W7pHWmgm97ATjGqDbGyWeG4UImp
         l2zOPwL9yFJYCiUrmaSCutPVRLYtpU2MetnIHIJ/4bEmM2qvbCf3l3kI1xvDTnLi8P
         jPQh+3lQ6ap43tRTp5K+DPtNPGiPa2l6axks1L42ELpdYspCMnQZqVtgz8sDgbFXFY
         j9cnekwJbpza7J93CZaPTIwHmIq/IEtOltSu61nImCQcYJKQKwvo8WrZhGCYEIm2FA
         tdGFp450SBXdg==
Date:   Thu, 3 Jun 2021 16:39:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     "yukuai (C)" <yukuai3@huawei.com>, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, michal.simek@xilinx.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, yi.zhang@huawei.com
Subject: Re: [PATCH 2/3] dmaengine: usb-dmac: Fix PM reference leak in
 usb_dmac_probe()
Message-ID: <YLi4VGwzrat8wJHP@vkoul-mobl>
References: <20210517081826.1564698-1-yukuai3@huawei.com>
 <20210517081826.1564698-3-yukuai3@huawei.com>
 <YLRfZfnuxc0+n/LN@vkoul-mobl.Dlink>
 <b6c340de-b0b5-6aad-94c0-03f062575b63@huawei.com>
 <YLSk/i6GmYWGEa9E@vkoul-mobl.Dlink>
 <YLSqD+9nZIWJpn+r@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLSqD+9nZIWJpn+r@hovoldconsulting.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 31-05-21, 11:19, Johan Hovold wrote:
> On Mon, May 31, 2021 at 02:27:34PM +0530, Vinod Koul wrote:
> > On 31-05-21, 14:11, yukuai (C) wrote:
> > > On 2021/05/31 12:00, Vinod Koul wrote:
> > > > On 17-05-21, 16:18, Yu Kuai wrote:
> > > > > pm_runtime_get_sync will increment pm usage counter even it failed.
> > > > > Forgetting to putting operation will result in reference leak here.
> > > > > Fix it by replacing it with pm_runtime_resume_and_get to keep usage
> > > > > counter balanced.
> > > > > 
> > > > > Reported-by: Hulk Robot <hulkci@huawei.com>
> > > > > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > > > > ---
> > > > >   drivers/dma/sh/usb-dmac.c | 2 +-
> > > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
> > > > > index 8f7ceb698226..2a6c8fd8854e 100644
> > > > > --- a/drivers/dma/sh/usb-dmac.c
> > > > > +++ b/drivers/dma/sh/usb-dmac.c
> > > > > @@ -796,7 +796,7 @@ static int usb_dmac_probe(struct platform_device *pdev)
> > > > >   	/* Enable runtime PM and initialize the device. */
> > > > >   	pm_runtime_enable(&pdev->dev);
> > > > > -	ret = pm_runtime_get_sync(&pdev->dev);
> > > > > +	ret = pm_runtime_resume_and_get(&pdev->dev);
> > > > 
> > > > This does not seem to fix anything.. the below goto goes and disables
> > > > the runtime_pm for this device and thus there wont be any leak
> > > Hi,
> > > 
> > > If pm_runtime_get_sync() fails and increments the pm.usage_count
> > > variable, pm_runtime_disable() does not reset the counter, and
> > > we still need to decrement the usage count when pm_runtime_get_sync()
> > > fails. Do I miss anthing?
> > 
> > Yes the rumtime_pm is disabled on failure here and the count would have
> > no consequence...
> 
> You should still balance the PM usage counter as it isn't reset for
> example when reloading the driver.

Should I driver trust that on load PM usage counter is balanced and not
to be reset..?

> Using pm_runtime_resume_and_get() is one way of handling this, but
> alternatively you could also move the error_pm label above the
> pm_runtime_put() in the error path.

That would be a better way I think

-- 
~Vinod
