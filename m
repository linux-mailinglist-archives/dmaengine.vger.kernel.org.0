Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6F25BB9AF
	for <lists+dmaengine@lfdr.de>; Sat, 17 Sep 2022 19:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiIQRFe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 17 Sep 2022 13:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiIQRFd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 17 Sep 2022 13:05:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EB22CDD2
        for <dmaengine@vger.kernel.org>; Sat, 17 Sep 2022 10:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663434329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OqivvlpJg6/ySiyjgnInAXk6GYFbHby2J57McjFavBE=;
        b=KZAu7SI7k0jG0tWCPgOXGqQpQydSUpHpl6U8GN/UhXafsQnGGklCJ1cmJG5Z0isJNpQGs3
        ihrye6kPT0IgN70h8OhiDf8Mkw4qwbTulCkEvM8srGxj/Cs3VQrUNJmUWRqjlkviSti74O
        99k6NDBiOHDaCf8C64r23PWgG8S7gRA=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-600-3HAmUCSIOV2iFtuc-eWf-A-1; Sat, 17 Sep 2022 13:05:28 -0400
X-MC-Unique: 3HAmUCSIOV2iFtuc-eWf-A-1
Received: by mail-pl1-f200.google.com with SMTP id n9-20020a170902d2c900b001782ad97c7aso13036429plc.8
        for <dmaengine@vger.kernel.org>; Sat, 17 Sep 2022 10:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=OqivvlpJg6/ySiyjgnInAXk6GYFbHby2J57McjFavBE=;
        b=5z6aNpgCDpwny4YJshl8d/IBBCMAtCg6gVZhtwsW89pgWdOoH0kEhTi82guGOlE64G
         2CA/v3y5VQ97VRvdKKQGpKOGrEpp2XT5gzRH4NCJfCWIXOAiwz4XSvKZFsgGB7o+Yoqo
         Znpy2We8wQnel8TL+q1aLgPw0YkXDgc9bgiI+rzYT27G1/a12WMaJjg112sMtbOM89BY
         CkgY5mKS0TD/2mz+Q1pyitffFc4cQL6wlJtivL00zsV3HBlZ82iWQt2/DZ/TV5mhGUu8
         PTRdhn9bidA8RVOcTS5b4BheeDaTDfQDojdp7rbBg+1nn1Mli5qkCjw3qXGgzfX1P3cC
         1SEQ==
X-Gm-Message-State: ACrzQf0SO7VBEp0FYV4+mCitukZrmgcyLi9eIKWRXQtqlCJh3twJWXSc
        fe/ZbWEEpn2eLMr7H887EJIA5bGS94je1FrwlfnnAxNU9UaPJlAubuRBIEJe/1Uucr9QnB8R8Na
        DjRvLZVxQxRrrZOXf0Rvu
X-Received: by 2002:a05:6a00:170c:b0:537:27b4:ebfe with SMTP id h12-20020a056a00170c00b0053727b4ebfemr10335487pfc.19.1663434327687;
        Sat, 17 Sep 2022 10:05:27 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4qmxIWKiWEE+ryk1jMUY9v78KvKEDuYjcXratHmQQv7ToguUD6gTZWjmAKLCHHMppDmPrdrA==
X-Received: by 2002:a05:6a00:170c:b0:537:27b4:ebfe with SMTP id h12-20020a056a00170c00b0053727b4ebfemr10335467pfc.19.1663434327428;
        Sat, 17 Sep 2022 10:05:27 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b00202df748e91sm3495049pjo.16.2022.09.17.10.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 10:05:25 -0700 (PDT)
Date:   Sat, 17 Sep 2022 10:05:24 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: Set workqueue state to disabled before
 trying to re-enable
Message-ID: <20220917170524.23wxvkhieroyrofd@cantor>
References: <20220824192913.2425634-1-jsnitsel@redhat.com>
 <1417f4ce-2573-5c88-6c92-fda5c57ebceb@intel.com>
 <20220824211625.mfcyefi5yvasdt4r@cantor>
 <d0dbdd27-a890-1eea-63b5-ab6aaa27583e@intel.com>
 <f59ea139533f37991e786cd8cf4a0d591133d92c.camel@redhat.com>
 <36ecf274-7be1-f50e-8ac0-9e99bc9ef556@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36ecf274-7be1-f50e-8ac0-9e99bc9ef556@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Aug 24, 2022 at 03:19:51PM -0700, Dave Jiang wrote:
> 
> On 8/24/2022 3:07 PM, Jerry Snitselaar wrote:
> > On Wed, 2022-08-24 at 14:59 -0700, Dave Jiang wrote:
> > > On 8/24/2022 2:16 PM, Jerry Snitselaar wrote:
> > > > On Wed, Aug 24, 2022 at 01:29:03PM -0700, Dave Jiang wrote:
> > > > > On 8/24/2022 12:29 PM, Jerry Snitselaar wrote:
> > > > > > For a software reset idxd_device_reinit() is called, which will
> > > > > > walk
> > > > > > the device workqueues to see which ones were enabled, and try
> > > > > > to
> > > > > > re-enable them. It keys off wq->state being iDXD_WQ_ENABLED,
> > > > > > but the
> > > > > > first thing idxd_enable_wq() will do is see that the state of
> > > > > > the
> > > > > > workqueue is enabled, and return 0 instead of attempting to
> > > > > > issue
> > > > > > a command to enable the workqueue.
> > > > > > 
> > > > > > So once a workqueue is found that needs to be re-enabled,
> > > > > > set the state to disabled prior to calling idxd_enable_wq().
> > > > > > This would accurately reflect the state if the enable fails
> > > > > > as well.
> > > > > > 
> > > > > > Cc: Fenghua Yu <fenghua.yu@intel.com>
> > > > > > Cc: Dave Jiang <dave.jiang@intel.com>
> > > > > > Cc: Vinod Koul <vkoul@kernel.org>
> > > > > > Cc: dmaengine@vger.kernel.org
> > > > > > Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel
> > > > > > data accelerators")
> > > > > > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > > > > > ---
> > > > > >     drivers/dma/idxd/irq.c | 1 +
> > > > > >     1 file changed, 1 insertion(+)
> > > > > > 
> > > > > > diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
> > > > > > index 743ead5ebc57..723eeb5328d6 100644
> > > > > > --- a/drivers/dma/idxd/irq.c
> > > > > > +++ b/drivers/dma/idxd/irq.c
> > > > > > @@ -52,6 +52,7 @@ static void idxd_device_reinit(struct
> > > > > > work_struct *work)
> > > > > >                  struct idxd_wq *wq = idxd->wqs[i];
> > > > > >                  if (wq->state == IDXD_WQ_ENABLED) {
> > > > > > +                       wq->state = IDXD_WQ_DISABLED;
> > > > > Might be better off to insert this line in
> > > > > idxd_wq_disable_cleanup(). I
> > > > > think that should put it in sane state.
> > > > I don't think that is called in the code path that I was lookng at.
> > > > I've been
> > > > looking at this bit of process_misc_interrupts():
> > > > 
> > > > halt:
> > > >          gensts.bits = ioread32(idxd->reg_base +
> > > > IDXD_GENSTATS_OFFSET);
> > > >          if (gensts.state == IDXD_DEVICE_STATE_HALT) {
> > > >                  idxd->state = IDXD_DEV_HALTED;
> > > >                  if (gensts.reset_type ==
> > > > IDXD_DEVICE_RESET_SOFTWARE) {
> > > >                          /*
> > > >                           * If we need a software reset, we will
> > > > throw the work
> > > >                           * on a system workqueue in order to allow
> > > > interrupts
> > > >                           * for the device command completions.
> > > >                           */
> > > >                          INIT_WORK(&idxd->work, idxd_device_reinit);
> > > >                          queue_work(idxd->wq, &idxd->work);
> > > >                  } else {
> > > >                          idxd->state = IDXD_DEV_HALTED;
> > > >                          idxd_wqs_quiesce(idxd);
> > > >                          idxd_wqs_unmap_portal(idxd);
> > > >                          spin_lock(&idxd->dev_lock);
> > > >                          idxd_device_clear_state(idxd);
> > > >                          dev_err(&idxd->pdev->dev,
> > > >                                  "idxd halted, need %s.\n",
> > > >                                  gensts.reset_type ==
> > > > IDXD_DEVICE_RESET_FLR ?
> > > >                                  "FLR" : "system reset");
> > > >                          spin_unlock(&idxd->dev_lock);
> > > >                          return -ENXIO;
> > > >                  }
> > > >          }
> > > > 
> > > >          return 0;
> > > > }
> > > > 
> > > > So it sees that the device is halted, and sticks
> > > > idxd_device_reinint() on that
> > > > workqueue. The idxd_device_reinit() has this loop to re-enable the
> > > > idxd wqs:
> > > idxd_device_reinit() should called idxd_device_reset() first. And
> > > that
> > > should at some point call idxd_wq_disable_cleanup() and clean up the
> > > states.
> > > 
> > > https://elixir.bootlin.com/linux/v6.0-rc2/source/drivers/dma/idxd/irq.c#L42
> > > 
> > > https://elixir.bootlin.com/linux/v6.0-rc2/source/drivers/dma/idxd/device.c#L725
> > > 
> > > https://elixir.bootlin.com/linux/v6.0-rc2/source/drivers/dma/idxd/device.c#L711
> > > 
> > > https://elixir.bootlin.com/linux/v6.0-rc2/source/drivers/dma/idxd/device.c#L376
> > > 
> > > So if we stick the wq state reset in there, it should show up as
> > > "disabled" by the time we try to enable the WQs again. Does that look
> > > reasonable?
> > > 
> > Ah, yeah I see that now. So, if it does set the state to disabled in
> > idxd_wq_disable_cleanup(), does it have another means to track which
> > wqs need to be re-enabled for that loop that happens after the
> > idxd_device_reset() call?
> 
> Oh I see what you mean... So we can either do what you did or create a mask
> and mark the WQ that are "enabled" before reset. Maybe that's cleaner rather
> than relying on the side effect of the WQ state isn't cleared? Thoughts?
> 

Circling back to this. Since max_wqs could theoretically go up to 2^8, I guess
this would need to be done with the bitmap_* functions?

Regards,
Jerry

> 
> > 
> > > >          for (i = 0; i < idxd->max_wqs; i++) {
> > > >                  struct idxd_wq *wq = idxd->wqs[i];
> > > > 
> > > >                  if (wq->state == IDXD_WQ_ENABLED) {
> > > >                          wq->state = IDXD_WQ_DISABLED;
> > > >                          rc = idxd_wq_enable(wq);
> > > >                          if (rc < 0) {
> > > >                                  dev_warn(dev, "Unable to re-enable
> > > > wq %s\n",
> > > >                                           dev_name(wq_confdev(wq)));
> > > >                          }
> > > >                  }
> > > >          }
> > > > 
> > > > Once you go into idxd_wq_enable() though you get this check at the
> > > > beginning:
> > > > 
> > > >          if (wq->state == IDXD_WQ_ENABLED) {
> > > >                  dev_dbg(dev, "WQ %d already enabled\n", wq->id);
> > > >                  return 0;
> > > >          }
> > > > 
> > > > So IIUC it sees the device is halted, goes to reset it, figures out
> > > > a wq
> > > > should be re-enabled, calls idxd_wq_enable() which hits the check,
> > > > returns
> > > > 0 and the wq is never really re-enabled, though it will still have
> > > > wq state
> > > > set to IDXD_WQ_ENABLED.
> > > > 
> > > > Or am I missing something?
> > > > 
> > > > Regards,
> > > > Jerry
> > > > 
> > > > > >                          rc = idxd_wq_enable(wq);
> > > > > >                          if (rc < 0) {
> > > > > >                                  dev_warn(dev, "Unable to re-
> > > > > > enable wq %s\n",

