Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145F15BD560
	for <lists+dmaengine@lfdr.de>; Mon, 19 Sep 2022 21:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiISTwc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Sep 2022 15:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiISTwb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Sep 2022 15:52:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15CE3F32F
        for <dmaengine@vger.kernel.org>; Mon, 19 Sep 2022 12:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663617149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WX14iRG7ZVtvtKHxv2P49yZ6fj5huVf8kE/pP0HHdXU=;
        b=V3HXtEi94bLM8G9WykdTb81ark4v9DEu6BOtPyVm+g2rcROBR5ZrImHSBDKSfRQGX+BXD3
        +vzfptEimLTrzZD9rOg9teQCSw2gIzU+0ChXeXJcRBF1ZlioWOijPxLbBRbJGLPsIXkaYI
        9h6yh30yquQGJYKQo0fT/cFu9WyFmqM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-563-HQLtsvjtOKWbwT3fE5SD0w-1; Mon, 19 Sep 2022 15:52:27 -0400
X-MC-Unique: HQLtsvjtOKWbwT3fE5SD0w-1
Received: by mail-qt1-f197.google.com with SMTP id fz10-20020a05622a5a8a00b0035ce18717daso232478qtb.11
        for <dmaengine@vger.kernel.org>; Mon, 19 Sep 2022 12:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=WX14iRG7ZVtvtKHxv2P49yZ6fj5huVf8kE/pP0HHdXU=;
        b=WM2WfqREoXXwIMMCnJHsRKZ7efX09I7D5BHFF7O77NLz9m8KqIzBBwaeJdsMQtoXRR
         2/s41ioxF0prfXkbeIzjYHTq1FZBTXrECf8JepfvKvyTle8gR8kaWL8x77iZzvd/+U+6
         qMHUSmZVv6bD+hmoJb53Enoats6LflFYahdukGchZkfq/SvrLDMoOwKMOpV2CmAoErKD
         4UJ2ObpQI78NT23CZ/IHETpxinowUyDU/8moxfhmwBQoXuWb8ohaeFN6Wz0baND9B5Zg
         L3eQ/oNqyXOn1+2XBBXjb2mqnXVrsmJR4t35pyPtWN66qWvdojKLoOH9YlwgICeN5SGM
         0rQQ==
X-Gm-Message-State: ACrzQf0vcFtKJ2YrOb9ihAw8zDy0VYB6l4NcyT2AWbeqioMePDHPNbW3
        hZo0tlP/kfc3CpdfLySialVYgZh6jHgdCTY6TRYrwpcBQkasnQyo0qJQRNbSlsW/YS9vVH42gum
        nihbHLqALtetR0V4BWhRG
X-Received: by 2002:a05:620a:29c8:b0:6ce:ab64:7020 with SMTP id s8-20020a05620a29c800b006ceab647020mr14412885qkp.220.1663617147451;
        Mon, 19 Sep 2022 12:52:27 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7BTj7KPQHwcadvhis3QkFdVqLXCtnvZ2jj+eUban2uUHZcW8+AQPru2sS1EKdPQJkx0SudGQ==
X-Received: by 2002:a05:620a:29c8:b0:6ce:ab64:7020 with SMTP id s8-20020a05620a29c800b006ceab647020mr14412876qkp.220.1663617147241;
        Mon, 19 Sep 2022 12:52:27 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id z11-20020a05622a124b00b0033b30e8e7a5sm11170991qtx.58.2022.09.19.12.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 12:52:26 -0700 (PDT)
Date:   Mon, 19 Sep 2022 12:52:25 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Fengqian Gao <fengqian.gao@intel.com>,
        "Shen, Xiaochen" <xiaochen.shen@intel.com>
Subject: Re: [PATCH] dmaengine: idxd: Set workqueue state to disabled before
 trying to re-enable
Message-ID: <20220919195225.eobw3vnwnxvuctkj@cantor>
References: <20220824192913.2425634-1-jsnitsel@redhat.com>
 <1417f4ce-2573-5c88-6c92-fda5c57ebceb@intel.com>
 <20220824211625.mfcyefi5yvasdt4r@cantor>
 <d0dbdd27-a890-1eea-63b5-ab6aaa27583e@intel.com>
 <f59ea139533f37991e786cd8cf4a0d591133d92c.camel@redhat.com>
 <36ecf274-7be1-f50e-8ac0-9e99bc9ef556@intel.com>
 <20220917170524.23wxvkhieroyrofd@cantor>
 <ca0bb678-1ffd-42e1-4056-30c3a5b74f10@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca0bb678-1ffd-42e1-4056-30c3a5b74f10@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Sep 19, 2022 at 08:28:04AM -0700, Dave Jiang wrote:
> 
> On 9/17/2022 10:05 AM, Jerry Snitselaar wrote:
> > On Wed, Aug 24, 2022 at 03:19:51PM -0700, Dave Jiang wrote:
> > > On 8/24/2022 3:07 PM, Jerry Snitselaar wrote:
> > > > On Wed, 2022-08-24 at 14:59 -0700, Dave Jiang wrote:
> > > > > On 8/24/2022 2:16 PM, Jerry Snitselaar wrote:
> > > > > > On Wed, Aug 24, 2022 at 01:29:03PM -0700, Dave Jiang wrote:
> > > > > > > On 8/24/2022 12:29 PM, Jerry Snitselaar wrote:
> > > > > > > > For a software reset idxd_device_reinit() is called, which will
> > > > > > > > walk
> > > > > > > > the device workqueues to see which ones were enabled, and try
> > > > > > > > to
> > > > > > > > re-enable them. It keys off wq->state being iDXD_WQ_ENABLED,
> > > > > > > > but the
> > > > > > > > first thing idxd_enable_wq() will do is see that the state of
> > > > > > > > the
> > > > > > > > workqueue is enabled, and return 0 instead of attempting to
> > > > > > > > issue
> > > > > > > > a command to enable the workqueue.
> > > > > > > > 
> > > > > > > > So once a workqueue is found that needs to be re-enabled,
> > > > > > > > set the state to disabled prior to calling idxd_enable_wq().
> > > > > > > > This would accurately reflect the state if the enable fails
> > > > > > > > as well.
> > > > > > > > 
> > > > > > > > Cc: Fenghua Yu <fenghua.yu@intel.com>
> > > > > > > > Cc: Dave Jiang <dave.jiang@intel.com>
> > > > > > > > Cc: Vinod Koul <vkoul@kernel.org>
> > > > > > > > Cc: dmaengine@vger.kernel.org
> > > > > > > > Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel
> > > > > > > > data accelerators")
> > > > > > > > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > > > > > > > ---
> > > > > > > >      drivers/dma/idxd/irq.c | 1 +
> > > > > > > >      1 file changed, 1 insertion(+)
> > > > > > > > 
> > > > > > > > diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
> > > > > > > > index 743ead5ebc57..723eeb5328d6 100644
> > > > > > > > --- a/drivers/dma/idxd/irq.c
> > > > > > > > +++ b/drivers/dma/idxd/irq.c
> > > > > > > > @@ -52,6 +52,7 @@ static void idxd_device_reinit(struct
> > > > > > > > work_struct *work)
> > > > > > > >                   struct idxd_wq *wq = idxd->wqs[i];
> > > > > > > >                   if (wq->state == IDXD_WQ_ENABLED) {
> > > > > > > > +                       wq->state = IDXD_WQ_DISABLED;
> > > > > > > Might be better off to insert this line in
> > > > > > > idxd_wq_disable_cleanup(). I
> > > > > > > think that should put it in sane state.
> > > > > > I don't think that is called in the code path that I was lookng at.
> > > > > > I've been
> > > > > > looking at this bit of process_misc_interrupts():
> > > > > > 
> > > > > > halt:
> > > > > >           gensts.bits = ioread32(idxd->reg_base +
> > > > > > IDXD_GENSTATS_OFFSET);
> > > > > >           if (gensts.state == IDXD_DEVICE_STATE_HALT) {
> > > > > >                   idxd->state = IDXD_DEV_HALTED;
> > > > > >                   if (gensts.reset_type ==
> > > > > > IDXD_DEVICE_RESET_SOFTWARE) {
> > > > > >                           /*
> > > > > >                            * If we need a software reset, we will
> > > > > > throw the work
> > > > > >                            * on a system workqueue in order to allow
> > > > > > interrupts
> > > > > >                            * for the device command completions.
> > > > > >                            */
> > > > > >                           INIT_WORK(&idxd->work, idxd_device_reinit);
> > > > > >                           queue_work(idxd->wq, &idxd->work);
> > > > > >                   } else {
> > > > > >                           idxd->state = IDXD_DEV_HALTED;
> > > > > >                           idxd_wqs_quiesce(idxd);
> > > > > >                           idxd_wqs_unmap_portal(idxd);
> > > > > >                           spin_lock(&idxd->dev_lock);
> > > > > >                           idxd_device_clear_state(idxd);
> > > > > >                           dev_err(&idxd->pdev->dev,
> > > > > >                                   "idxd halted, need %s.\n",
> > > > > >                                   gensts.reset_type ==
> > > > > > IDXD_DEVICE_RESET_FLR ?
> > > > > >                                   "FLR" : "system reset");
> > > > > >                           spin_unlock(&idxd->dev_lock);
> > > > > >                           return -ENXIO;
> > > > > >                   }
> > > > > >           }
> > > > > > 
> > > > > >           return 0;
> > > > > > }
> > > > > > 
> > > > > > So it sees that the device is halted, and sticks
> > > > > > idxd_device_reinint() on that
> > > > > > workqueue. The idxd_device_reinit() has this loop to re-enable the
> > > > > > idxd wqs:
> > > > > idxd_device_reinit() should called idxd_device_reset() first. And
> > > > > that
> > > > > should at some point call idxd_wq_disable_cleanup() and clean up the
> > > > > states.
> > > > > 
> > > > > https://elixir.bootlin.com/linux/v6.0-rc2/source/drivers/dma/idxd/irq.c#L42
> > > > > 
> > > > > https://elixir.bootlin.com/linux/v6.0-rc2/source/drivers/dma/idxd/device.c#L725
> > > > > 
> > > > > https://elixir.bootlin.com/linux/v6.0-rc2/source/drivers/dma/idxd/device.c#L711
> > > > > 
> > > > > https://elixir.bootlin.com/linux/v6.0-rc2/source/drivers/dma/idxd/device.c#L376
> > > > > 
> > > > > So if we stick the wq state reset in there, it should show up as
> > > > > "disabled" by the time we try to enable the WQs again. Does that look
> > > > > reasonable?
> > > > > 
> > > > Ah, yeah I see that now. So, if it does set the state to disabled in
> > > > idxd_wq_disable_cleanup(), does it have another means to track which
> > > > wqs need to be re-enabled for that loop that happens after the
> > > > idxd_device_reset() call?
> > > Oh I see what you mean... So we can either do what you did or create a mask
> > > and mark the WQ that are "enabled" before reset. Maybe that's cleaner rather
> > > than relying on the side effect of the WQ state isn't cleared? Thoughts?
> > > 
> > Circling back to this. Since max_wqs could theoretically go up to 2^8, I guess
> > this would need to be done with the bitmap_* functions?
> 
> Hi Jerry,
> 
> I wouldn't say never but I doubt any time soon for 2^8. DSA 1.0 has 8 WQs,
> and 2.0 (spec just went public) has 16. But yes we can use bitmap to be
> future proof. Are you currently working on a fix for this? Just don't want
> to duplicate effort if you already have something going. Thank you!
> 

Hi Dave,

Yes, I will try to send it this afternoon.

Regards,
Jerry

> 
> > 
> > Regards,
> > Jerry
> > 
> > > > > >           for (i = 0; i < idxd->max_wqs; i++) {
> > > > > >                   struct idxd_wq *wq = idxd->wqs[i];
> > > > > > 
> > > > > >                   if (wq->state == IDXD_WQ_ENABLED) {
> > > > > >                           wq->state = IDXD_WQ_DISABLED;
> > > > > >                           rc = idxd_wq_enable(wq);
> > > > > >                           if (rc < 0) {
> > > > > >                                   dev_warn(dev, "Unable to re-enable
> > > > > > wq %s\n",
> > > > > >                                            dev_name(wq_confdev(wq)));
> > > > > >                           }
> > > > > >                   }
> > > > > >           }
> > > > > > 
> > > > > > Once you go into idxd_wq_enable() though you get this check at the
> > > > > > beginning:
> > > > > > 
> > > > > >           if (wq->state == IDXD_WQ_ENABLED) {
> > > > > >                   dev_dbg(dev, "WQ %d already enabled\n", wq->id);
> > > > > >                   return 0;
> > > > > >           }
> > > > > > 
> > > > > > So IIUC it sees the device is halted, goes to reset it, figures out
> > > > > > a wq
> > > > > > should be re-enabled, calls idxd_wq_enable() which hits the check,
> > > > > > returns
> > > > > > 0 and the wq is never really re-enabled, though it will still have
> > > > > > wq state
> > > > > > set to IDXD_WQ_ENABLED.
> > > > > > 
> > > > > > Or am I missing something?
> > > > > > 
> > > > > > Regards,
> > > > > > Jerry
> > > > > > 
> > > > > > > >                           rc = idxd_wq_enable(wq);
> > > > > > > >                           if (rc < 0) {
> > > > > > > >                                   dev_warn(dev, "Unable to re-
> > > > > > > > enable wq %s\n",

