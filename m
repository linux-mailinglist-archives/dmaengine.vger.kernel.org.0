Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA0D643448
	for <lists+dmaengine@lfdr.de>; Mon,  5 Dec 2022 20:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbiLETn4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Dec 2022 14:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbiLETnk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 5 Dec 2022 14:43:40 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF1E2A410
        for <dmaengine@vger.kernel.org>; Mon,  5 Dec 2022 11:41:06 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id c66so10990530edf.5
        for <dmaengine@vger.kernel.org>; Mon, 05 Dec 2022 11:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gigaio-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a9FJPp4RYM4IExcW+0AZ/K850i7rukg60ng0ZWaZmAo=;
        b=7XBNQPHb962IxkKir46l9I220lTXbuI+fSJ+GPuYmmj2gXqo2XI2K2/u36lpkwUhLQ
         d4Scr1B0iYjHST6Ubl23kV6cng2tC9Qh0746sm0HvypaHXD4NVGbhnY3pPA7pZNAyO3a
         wykNpGb+v9Y+Y37RbqYDgfguipcepHs2g5DFHETm/JyXm0rHDHmFPJ0vAcy0FFeVFOaT
         gm80za58gT5AF8p+t2iXekA9ZJVp8E6BKOCvP1SrSNA9TqRhK0ZCGHR4Y0Ft6ODDYchJ
         EhLcVdkq5/1qifdQmvgtKostebGwRqWqCsTlDQi3KDZ/coHbqnyee+QQIGiflWb5dbfB
         ke3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a9FJPp4RYM4IExcW+0AZ/K850i7rukg60ng0ZWaZmAo=;
        b=VeRGgvWDIZZU10Gq/VHeMCPgr5i0/gUWId8CeT7Sa52r9hDRWpMleVhwkPkXWc6lIo
         vUaYBS/KjOw9PP4shaI5Wu+wnNjLPWHWZ6oBN+QQ5M799iMRGO6kC60yG/kPJoLti28G
         2RPJvGcK5Szw8eqN3/A97C2+MgNfYFQ7qASAjezahULBHTFaODw0vkCszf7A0YDzrWq2
         3UfElH4W0rbmpiKRDtMnVcN2stON8DQ+m+0PV2Qt2d6QvZz3gIf+u+bWltd1ISBeN9ik
         VjE8niqiOZkrmOcVsQlh6xUFV/+6/gUM6k0DP7ZM9Yt29dYS1LC6o+lhnqY9Nti4ysPD
         aFew==
X-Gm-Message-State: ANoB5pkB9k1PqSuB2p5NLf5v26KDKKr2s6x6GclqaGAwKDz9OZDy7+Vm
        7Fvq+LO6RWQJCfkQq3SphgBjA5hblX+l830K3tqf8DueRcCTu2hH
X-Google-Smtp-Source: AA0mqf4eV5hDGzO2e1m9virPBBtmuenp+VfBHj+758PbrHZMt7Ae3uigde0kYxvvaMkUSXDHcFiwDTCKSWuWr0BtMW0=
X-Received: by 2002:a05:6402:1443:b0:46c:ab70:bffc with SMTP id
 d3-20020a056402144300b0046cab70bffcmr6183794edx.371.1670269265125; Mon, 05
 Dec 2022 11:41:05 -0800 (PST)
MIME-Version: 1.0
References: <CAOQPn8tHAx1zsgUO7UAuKf1DJYt+fdT6OPAHoxO+HgEPvT5SPg@mail.gmail.com>
 <CAOQPn8v=PWvRWntknEK9pYu3jLgDePWfsjVByYSjUe_tYCpdPA@mail.gmail.com> <90f0244b-adb4-bc5e-792d-2ead9fe463d6@intel.com>
In-Reply-To: <90f0244b-adb4-bc5e-792d-2ead9fe463d6@intel.com>
From:   Eric Pilmore <epilmore@gigaio.com>
Date:   Mon, 5 Dec 2022 11:40:54 -0800
Message-ID: <CAOQPn8vT2eJW_FS_BcR=x0cFKavhse0EdPkDd+7-0Yrnusm=2g@mail.gmail.com>
Subject: Re: poor ptdma performance
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Dec 5, 2022 at 7:30 AM Dave Jiang <dave.jiang@intel.com> wrote:
>
>
>
> On 12/3/2022 1:51 AM, Eric Pilmore wrote:
> > On Fri, Dec 2, 2022 at 1:57 PM Eric Pilmore <epilmore@gigaio.com> wrote:
> >>
> >> Was curious if anybody has any expected performance numbers for the
> >> AMD DMA engine "ptdma"?
> >>
> >> I'm doing some testing utilizing the "ntb_netdev" module for TCP/IP
> >> communication between servers via NTB (Non-Transparent Bridge) using
> >> "iperf". I find that on Intel based boxes, utilizing IOAT DMA, I can
> >> get approximately 19-20 Gb/s for a simple untuned single iperf
> >> instance. However, when running on AMD based boxes (Milan CPUs), and
> >> running the latest ptdma driver from the Linux tree, I can only
> >> achieve about 2-3 Gb/s. I'm thinking there must be some driver knob
> >> that I need to tweek or something.
> >>
> >> Any help is greatly appreciated.
> >>
> >> Thanks,
> >> Eric
> >
> >
> > You can disregard this question. The issue turned out to be a bug in
> > the ntb_netdev module. The module was calling dev_kfree_skb() in an
> > inappropriate place (interrupt context). Once that was fixed (changed
> > to dev_kfree_skb_irq()), some assert WARNINGS (that I had previously
> > missed) went away and the performance is as expected.
> >
>
> Curious why this bug only effected the AMD DMA driver.... It should've
> impacted all DMA drivers through NTB right? Did it make any difference
> with the ioatdma after the change?

That would have been my expectation also, but we have never seen an
issue with ioatdma. It is only recently that we've started trying out
ptdma. This particular area of the ntb_netdev module has utilized
dev_kfree_skb() forever as far as I know. The suspect calls are in
ntb_netdev_rx_handler() and ntb_netdev_tx_handler(), each of which
could be called from interrupt context. These handlers are ultimately
called indirectly via function pointer (struct
dma_async_tx_descriptor.callback_result).

I have also seen an issue during driver shutdown where dma_sync_wait()
is hanging up, when ptdma is utilized. Flow is:
- device_del()
  - bus_remove_device()
    - device_release_driver()
      - device_release_driver_internal()
        - ntb_transport_bus_remove()
          - ntb_netdev_remove()
            - ntb_transport_free_queue()
              - dma_sync_wait() <<-- HANG

I am still investigating this one further in case it is related to
something in my local logic as I'm using a custom ntb_transport
module.

Eric
