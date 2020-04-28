Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1981BC7A4
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2020 20:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbgD1SSP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Apr 2020 14:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727827AbgD1SSP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Apr 2020 14:18:15 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEA2C03C1AB
        for <dmaengine@vger.kernel.org>; Tue, 28 Apr 2020 11:18:13 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d184so11111906pfd.4
        for <dmaengine@vger.kernel.org>; Tue, 28 Apr 2020 11:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aWjUSEtM8VL/pwqd96TGANtM3JG2NeQg+1Wfmoi2z40=;
        b=Ss1DSPtwmv6ojHUBYH3RIM/TGpQMJwmWVNrv61JcwPZK+zDfwCAmMNhUw6kPxlbClj
         S03Z1elXYdzGW90wxxesFNTgOpjveQ0M7TZllOFqtAkXaqmNFxQfwPlRT/J8fGvy8JTc
         tzOgceQdRQWixpv2JWCJcwHrR5Nj5axGQ/P7rhGkkChtMnyB8j8bk2kOLVpZSRFfEKoI
         97zoiI9gUJxZKJgfDD3tiLB5pcCxF0jLhiNfxfTyNOSChvEbZdMga9a7yD9h4gS4OUi4
         7vqZZdEdQHy9GvB8JAsyff1ZO0YJ+rQsetWwWqomx1keaNWhywV/tkzdreIdqactcjXG
         PVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aWjUSEtM8VL/pwqd96TGANtM3JG2NeQg+1Wfmoi2z40=;
        b=TZLQ9/8TDOZcDUU7aBWBhJMdapSzGktJigjZVr1E4rV8YDBhCl70NBd0nqC1t8G9/f
         Z7HfE76MBNNY3fEAKdca0gV2ib0ZLRr2zvsvAV0f6rFTcleeSwvhPs6d4US6aN1yeZy4
         X8qxQIBBbzqZDh6eEqyA2FwMWqh9FeW/Rqp5TJP+wVTJ4Ei8QmfBqksgASF/pM7XzWwU
         1ZkqBcufnwrssM4BqajlHmZB0bvnsMN9DRIRxaKym6K83nN953SR9w4QoWl3ylUNi4Y7
         2ziOLV5PrkLaDg+Vtg5gbZEPjJiSLSo0EU117K7OkIP0gyHEKwQQMCEpEWM+v8Mrl/RM
         gJsw==
X-Gm-Message-State: AGi0PuZqoUQHyIymgYL/BHgDlQIpiX6o9LLN62LB/IperRu3Vavay3rk
        3GnHPv0j/pDDz5hWXk6hnCOc
X-Google-Smtp-Source: APiQypJOUABsqi4HENB6HKsGRzv2n+guO71nsjgxfB0xQtqrcjmT1vPI+RoPczAM+EJM/Jfv6BqVug==
X-Received: by 2002:a63:6f4c:: with SMTP id k73mr28964286pgc.241.1588097893019;
        Tue, 28 Apr 2020 11:18:13 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:816:a859:6d8a:8338:74e:a3d1])
        by smtp.gmail.com with ESMTPSA id 199sm4078133pgc.39.2020.04.28.11.18.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Apr 2020 11:18:12 -0700 (PDT)
Date:   Tue, 28 Apr 2020 23:48:03 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] dma: actions: Fix lockdep splat for owl-dma
Message-ID: <20200428181803.GD5259@Mani-XPS-13-9360>
References: <7d503c3dcac2b3ef29d4122a74eacfce142a8f98.1588069418.git.cristian.ciocaltea@gmail.com>
 <20200428164921.GC5259@Mani-XPS-13-9360>
 <20200428181115.GB26885@BV030612LT>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428181115.GB26885@BV030612LT>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Apr 28, 2020 at 09:11:15PM +0300, Cristian Ciocaltea wrote:
> On Tue, Apr 28, 2020 at 10:19:21PM +0530, Manivannan Sadhasivam wrote:
> > Hi,
> > 
> > On Tue, Apr 28, 2020 at 01:56:12PM +0300, Cristian Ciocaltea wrote:
> > > When the kernel is build with lockdep support and the owl-dma driver is
> > > used, the following message is shown:
> > > 
> > > [    2.496939] INFO: trying to register non-static key.
> > > [    2.501889] the code is fine but needs lockdep annotation.
> > > [    2.507357] turning off the locking correctness validator.
> > > [    2.512834] CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.6.3+ #15
> > > [    2.519084] Hardware name: Generic DT based system
> > > [    2.523878] Workqueue: events_freezable mmc_rescan
> > > [    2.528681] [<801127f0>] (unwind_backtrace) from [<8010da58>] (show_stack+0x10/0x14)
> > > [    2.536420] [<8010da58>] (show_stack) from [<8080fbe8>] (dump_stack+0xb4/0xe0)
> > > [    2.543645] [<8080fbe8>] (dump_stack) from [<8017efa4>] (register_lock_class+0x6f0/0x718)
> > > [    2.551816] [<8017efa4>] (register_lock_class) from [<8017b7d0>] (__lock_acquire+0x78/0x25f0)
> > > [    2.560330] [<8017b7d0>] (__lock_acquire) from [<8017e5e4>] (lock_acquire+0xd8/0x1f4)
> > > [    2.568159] [<8017e5e4>] (lock_acquire) from [<80831fb0>] (_raw_spin_lock_irqsave+0x3c/0x50)
> > > [    2.576589] [<80831fb0>] (_raw_spin_lock_irqsave) from [<8051b5fc>] (owl_dma_issue_pending+0xbc/0x120)
> > > [    2.585884] [<8051b5fc>] (owl_dma_issue_pending) from [<80668cbc>] (owl_mmc_request+0x1b0/0x390)
> > > [    2.594655] [<80668cbc>] (owl_mmc_request) from [<80650ce0>] (mmc_start_request+0x94/0xbc)
> > > [    2.602906] [<80650ce0>] (mmc_start_request) from [<80650ec0>] (mmc_wait_for_req+0x64/0xd0)
> > > [    2.611245] [<80650ec0>] (mmc_wait_for_req) from [<8065aa10>] (mmc_app_send_scr+0x10c/0x144)
> > > [    2.619669] [<8065aa10>] (mmc_app_send_scr) from [<80659b3c>] (mmc_sd_setup_card+0x4c/0x318)
> > > [    2.628092] [<80659b3c>] (mmc_sd_setup_card) from [<80659f0c>] (mmc_sd_init_card+0x104/0x430)
> > > [    2.636601] [<80659f0c>] (mmc_sd_init_card) from [<8065a3e0>] (mmc_attach_sd+0xcc/0x16c)
> > > [    2.644678] [<8065a3e0>] (mmc_attach_sd) from [<8065301c>] (mmc_rescan+0x3ac/0x40c)
> > > [    2.652332] [<8065301c>] (mmc_rescan) from [<80143244>] (process_one_work+0x2d8/0x780)
> > > [    2.660239] [<80143244>] (process_one_work) from [<80143730>] (worker_thread+0x44/0x598)
> > > [    2.668323] [<80143730>] (worker_thread) from [<8014b5f8>] (kthread+0x148/0x150)
> > > [    2.675708] [<8014b5f8>] (kthread) from [<801010b4>] (ret_from_fork+0x14/0x20)
> > > [    2.682912] Exception stack(0xee8fdfb0 to 0xee8fdff8)
> > > [    2.687954] dfa0:                                     00000000 00000000 00000000 00000000
> > > [    2.696118] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > > [    2.704277] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> > > 
> > > The required fix is to use spin_lock_init() on the pchan lock before
> > > attempting to call any spin_lock_irqsave() in owl_dma_get_pchan().
> > > 
> > 
> > Right, this is a bug. But while looking at the code now, I feel that we don't
> > need 'pchan->lock'. The idea was to protect 'pchan->vchan', but I think
> > 'od->lock' is the better candidate for that since it already protects it in
> > 'owl_dma_terminate_pchan'.
> > 
> > So I'd be happy if you remove the lock from 'pchan' and just directly use the
> > one in 'od'.
> > 
> > Out of curiosity, on which platform you're testing this?
> > 
> > Thanks,
> > Mani
> > 
> 
> Hi Mani,
> 
> Totally agree, I will send a new patch revision as soon as I do some
> more testing.
> 

Coo, thanks!

> I'm currently experimenting on an Actions S500 based board (Roseapple Pi)
> trying to extend, if possible, the existing mainline support for those
> SoCs.

Awesome! It's great to see that Actions platform is seeing some attention
these days :)

> I don't have much progress so far, since I started quite recently
> and I also lack experience in the kernel development area, but I do my
> best to come back with more patches once I get a consistent functionality.
> 

No worries. Feel free to reach out to me if you have any questions. There is
a lot of work to do and for sure it will be a good learning curve.

We do have an IRC channel (##linux-actions) for quick discussions. Fee free
to join!

Thanks,
Mani

> Thanks a lot for your support,
> Cristi
> 
> > > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > > ---
> > >  drivers/dma/owl-dma.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
> > > index c683051257fd..d9d0f0488e70 100644
> > > --- a/drivers/dma/owl-dma.c
> > > +++ b/drivers/dma/owl-dma.c
> > > @@ -1131,6 +1131,7 @@ static int owl_dma_probe(struct platform_device *pdev)
> > >  
> > >  		pchan->id = i;
> > >  		pchan->base = od->base + OWL_DMA_CHAN_BASE(i);
> > > +		spin_lock_init(&pchan->lock);
> > >  	}
> > >  
> > >  	/* Init virtual channel */
> > > -- 
> > > 2.26.2
> > > 
