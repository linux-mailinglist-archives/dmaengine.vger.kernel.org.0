Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F40B5A0331
	for <lists+dmaengine@lfdr.de>; Wed, 24 Aug 2022 23:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240607AbiHXVQe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Aug 2022 17:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240202AbiHXVQc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Aug 2022 17:16:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188A67CA84
        for <dmaengine@vger.kernel.org>; Wed, 24 Aug 2022 14:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661375789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bcpFLCMYxGIt3iRk0HaBGWWHYdpJpPCMV+cfqoFaZl0=;
        b=UUpA8frIPnB7UXk/XzDFDltnSs9KXjykqYoYTWEcsPfoaV2fNp/PbeV3EfoxLBczlPPu0n
        FhzvkWW5AtgIENbiX8FGcyZjeaxmMWiTt8VQKuDmN322F/D/UIlI8auERJYg7EFThn4Ce4
        mDBlg4rUroP1qneJ9aglH4TOQI8j3Lw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-654-j6dYeGyaMHa6wIo0olmSZw-1; Wed, 24 Aug 2022 17:16:28 -0400
X-MC-Unique: j6dYeGyaMHa6wIo0olmSZw-1
Received: by mail-qk1-f199.google.com with SMTP id ay10-20020a05620a178a00b006bbcab9d554so14685541qkb.13
        for <dmaengine@vger.kernel.org>; Wed, 24 Aug 2022 14:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=bcpFLCMYxGIt3iRk0HaBGWWHYdpJpPCMV+cfqoFaZl0=;
        b=grRZwdwcrWYCBPzGiMoeGMpWfM4u4DJLGbNVM8SKb9mfSYTooVLIW0OYeFQiTQCOb/
         vNVJLVg3LqEV0hqizf7wM0xJMwNsDZwEmGnBRrtaUt2hy6yMKktxVLJvxxopCFUKM2hY
         ZLuPjDs8oglrvRRsW+idNzYK1qeyCnhyRLD6wsPMlkYJO5Xqb3oWFU1ImFEC8PUHQAAQ
         YmEh//cdfdUfqVdC+9pK3oUjgABFhUUGC6bfS3zwuC8Naj3e1QNeOFChu5sIwvnSqZW5
         P7x9etwRtDwbw+kNeU95P+g6b97pJBXrMCgtGKshib/ZuGAa3igF0Id7NmG20aRQ74hM
         Nu8A==
X-Gm-Message-State: ACgBeo05/2texgfLNuGFnH10uL9BVBz33cekFYFL2uKgtUmWjZ8DIsAe
        42X3PK0o3FtsgYIEp8yCTSEFxHg1n5v1n+cdu8kbzspITs/Mhf+eDXmxwUsLBzJDYz5q8nR1msN
        14JKrKYfAPEBakH3nbvqK
X-Received: by 2002:a05:622a:552:b0:342:f82f:c389 with SMTP id m18-20020a05622a055200b00342f82fc389mr1084230qtx.646.1661375787079;
        Wed, 24 Aug 2022 14:16:27 -0700 (PDT)
X-Google-Smtp-Source: AA6agR47fhpmPIvpUXIxGTEBSikRZShccfuyNjiZZBz7xLjIU3J2Fa26+Ik9OapkF++B6m3qG3UKzg==
X-Received: by 2002:a05:622a:552:b0:342:f82f:c389 with SMTP id m18-20020a05622a055200b00342f82fc389mr1084218qtx.646.1661375786886;
        Wed, 24 Aug 2022 14:16:26 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id bj21-20020a05620a191500b006bbfc742511sm10713557qkb.12.2022.08.24.14.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 14:16:26 -0700 (PDT)
Date:   Wed, 24 Aug 2022 14:16:25 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: Set workqueue state to disabled before
 trying to re-enable
Message-ID: <20220824211625.mfcyefi5yvasdt4r@cantor>
References: <20220824192913.2425634-1-jsnitsel@redhat.com>
 <1417f4ce-2573-5c88-6c92-fda5c57ebceb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1417f4ce-2573-5c88-6c92-fda5c57ebceb@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Aug 24, 2022 at 01:29:03PM -0700, Dave Jiang wrote:
> 
> On 8/24/2022 12:29 PM, Jerry Snitselaar wrote:
> > For a software reset idxd_device_reinit() is called, which will walk
> > the device workqueues to see which ones were enabled, and try to
> > re-enable them. It keys off wq->state being iDXD_WQ_ENABLED, but the
> > first thing idxd_enable_wq() will do is see that the state of the
> > workqueue is enabled, and return 0 instead of attempting to issue
> > a command to enable the workqueue.
> > 
> > So once a workqueue is found that needs to be re-enabled,
> > set the state to disabled prior to calling idxd_enable_wq().
> > This would accurately reflect the state if the enable fails
> > as well.
> > 
> > Cc: Fenghua Yu <fenghua.yu@intel.com>
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Vinod Koul <vkoul@kernel.org>
> > Cc: dmaengine@vger.kernel.org
> > Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
> > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > ---
> >   drivers/dma/idxd/irq.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
> > index 743ead5ebc57..723eeb5328d6 100644
> > --- a/drivers/dma/idxd/irq.c
> > +++ b/drivers/dma/idxd/irq.c
> > @@ -52,6 +52,7 @@ static void idxd_device_reinit(struct work_struct *work)
> >   		struct idxd_wq *wq = idxd->wqs[i];
> >   		if (wq->state == IDXD_WQ_ENABLED) {
> > +			wq->state = IDXD_WQ_DISABLED;
> Might be better off to insert this line in idxd_wq_disable_cleanup(). I
> think that should put it in sane state.

I don't think that is called in the code path that I was lookng at. I've been
looking at this bit of process_misc_interrupts():

halt:
	gensts.bits = ioread32(idxd->reg_base + IDXD_GENSTATS_OFFSET);
	if (gensts.state == IDXD_DEVICE_STATE_HALT) {
		idxd->state = IDXD_DEV_HALTED;
		if (gensts.reset_type == IDXD_DEVICE_RESET_SOFTWARE) {
			/*
			 * If we need a software reset, we will throw the work
			 * on a system workqueue in order to allow interrupts
			 * for the device command completions.
			 */
			INIT_WORK(&idxd->work, idxd_device_reinit);
			queue_work(idxd->wq, &idxd->work);
		} else {
			idxd->state = IDXD_DEV_HALTED;
			idxd_wqs_quiesce(idxd);
			idxd_wqs_unmap_portal(idxd);
			spin_lock(&idxd->dev_lock);
			idxd_device_clear_state(idxd);
			dev_err(&idxd->pdev->dev,
				"idxd halted, need %s.\n",
				gensts.reset_type == IDXD_DEVICE_RESET_FLR ?
				"FLR" : "system reset");
			spin_unlock(&idxd->dev_lock);
			return -ENXIO;
		}
	}

	return 0;
}

So it sees that the device is halted, and sticks idxd_device_reinint() on that
workqueue. The idxd_device_reinit() has this loop to re-enable the idxd wqs:

	for (i = 0; i < idxd->max_wqs; i++) {
		struct idxd_wq *wq = idxd->wqs[i];

		if (wq->state == IDXD_WQ_ENABLED) {
			wq->state = IDXD_WQ_DISABLED;
			rc = idxd_wq_enable(wq);
			if (rc < 0) {
				dev_warn(dev, "Unable to re-enable wq %s\n",
					 dev_name(wq_confdev(wq)));
			}
		}
	}

Once you go into idxd_wq_enable() though you get this check at the beginning:

 	if (wq->state == IDXD_WQ_ENABLED) {
		dev_dbg(dev, "WQ %d already enabled\n", wq->id);
		return 0;
	}

So IIUC it sees the device is halted, goes to reset it, figures out a wq
should be re-enabled, calls idxd_wq_enable() which hits the check, returns
0 and the wq is never really re-enabled, though it will still have wq state
set to IDXD_WQ_ENABLED.

Or am I missing something?

Regards,
Jerry

> >   			rc = idxd_wq_enable(wq);
> >   			if (rc < 0) {
> >   				dev_warn(dev, "Unable to re-enable wq %s\n",

