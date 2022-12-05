Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E211D6434DE
	for <lists+dmaengine@lfdr.de>; Mon,  5 Dec 2022 20:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbiLETx3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Dec 2022 14:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235191AbiLETxD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 5 Dec 2022 14:53:03 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4401010AE
        for <dmaengine@vger.kernel.org>; Mon,  5 Dec 2022 11:51:29 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id t17so1128285eju.1
        for <dmaengine@vger.kernel.org>; Mon, 05 Dec 2022 11:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gigaio-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jmTT6d0YAho8aMqkgnqtYMEMZ+qQZ1V+4UzV264X17M=;
        b=dPcDzOitm2pLljUbu3WxYDA2VU6qz0IWvj96yXqrg73GIym46VBcW9sbD+ZfP5NNNs
         DlXJJ77LCgxlP4lbuExM0ihFID7f3bFMXUsbmwQ1dIroVwX68tiiNnLDCK65SZhxABl1
         1QG+E5/feNZ730gor7IUG2GY/DjWCYWzHDyAJZWYnuIEP14McI7hNdYxmofYyFJcK2X3
         RG5s4Hc9BfuS48qjE6XHpIuOGsARUamLfQFRGAlm6jlDahIKeD0MFPW69Ma6rH5s1qAd
         8RvE5onPYc1AH+zVW5yJjefj9rZ8JwuuGGhvA+bvOJnJCkHpzPbsbrNKK/Ipq7AWccHF
         DbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jmTT6d0YAho8aMqkgnqtYMEMZ+qQZ1V+4UzV264X17M=;
        b=hnxWfqWncU0oA6BaNS/Ez+onCTCWvNRskXBGaxwR/eMmPJaTJbnq3HmWDPGP0RDbEY
         LTGKDiKn6WtWofR0JA+fcQYATclh91YRjXVCNb6DHVgusP7oPLazoaJcCl0fv+z552E7
         jkJoxTfDSmChAX7muteh0TFB9EXqGmdXsETjIjNpiJmdb1IB0Sz9VQlyrLGNjYQbgf1x
         9uEVIkBpX9iX888eD0bbpD0g01LbdejtM3zRAtDhWaxu4Y8ZC9aCRZWN4GaHbRB32T3y
         ygd5WvdGWsO8jy70kaTbWXx/2oF6SAAG6M2lMVpmtwN2MRYrnkAkMevZ82f0KeI5ohyd
         eJyg==
X-Gm-Message-State: ANoB5pljEWLO4UVhnNKSFRMEeF2XD5jso+zXMS4KnMWTxN4Llf0jV6Wt
        O07bhU/cp3VMTj3Cx7CZ03yJHoP0pQwg+zFQpaDqoOLfVbDjzLfs
X-Google-Smtp-Source: AA0mqf5DMOwzrtq/O75co9IwTw6OLbmtb98KTM2UfX1VfqfR9Hc4kr0W6v0KhJMhr5bc8kyX9fMz2C9z6inegeXK5/k=
X-Received: by 2002:a17:906:c259:b0:7b5:9670:ae0 with SMTP id
 bl25-20020a170906c25900b007b596700ae0mr56404019ejb.321.1670269887766; Mon, 05
 Dec 2022 11:51:27 -0800 (PST)
MIME-Version: 1.0
References: <CAOQPn8tHAx1zsgUO7UAuKf1DJYt+fdT6OPAHoxO+HgEPvT5SPg@mail.gmail.com>
 <CAOQPn8v=PWvRWntknEK9pYu3jLgDePWfsjVByYSjUe_tYCpdPA@mail.gmail.com>
 <90f0244b-adb4-bc5e-792d-2ead9fe463d6@intel.com> <CAOQPn8vT2eJW_FS_BcR=x0cFKavhse0EdPkDd+7-0Yrnusm=2g@mail.gmail.com>
In-Reply-To: <CAOQPn8vT2eJW_FS_BcR=x0cFKavhse0EdPkDd+7-0Yrnusm=2g@mail.gmail.com>
From:   Eric Pilmore <epilmore@gigaio.com>
Date:   Mon, 5 Dec 2022 11:51:16 -0800
Message-ID: <CAOQPn8soS-2Hej8rBAhHs1jn-hXabPJzViz2T+vPFtS-7Afypg@mail.gmail.com>
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

On Mon, Dec 5, 2022 at 11:40 AM Eric Pilmore <epilmore@gigaio.com> wrote:
>
> On Mon, Dec 5, 2022 at 7:30 AM Dave Jiang <dave.jiang@intel.com> wrote:
> >
> >
> >
> > On 12/3/2022 1:51 AM, Eric Pilmore wrote:
> > > On Fri, Dec 2, 2022 at 1:57 PM Eric Pilmore <epilmore@gigaio.com> wrote:
> > >>
> > >> Was curious if anybody has any expected performance numbers for the
> > >> AMD DMA engine "ptdma"?
> > >>
> > >> I'm doing some testing utilizing the "ntb_netdev" module for TCP/IP
> > >> communication between servers via NTB (Non-Transparent Bridge) using
> > >> "iperf". I find that on Intel based boxes, utilizing IOAT DMA, I can
> > >> get approximately 19-20 Gb/s for a simple untuned single iperf
> > >> instance. However, when running on AMD based boxes (Milan CPUs), and
> > >> running the latest ptdma driver from the Linux tree, I can only
> > >> achieve about 2-3 Gb/s. I'm thinking there must be some driver knob
> > >> that I need to tweek or something.
> > >>
> > >> Any help is greatly appreciated.
> > >>
> > >> Thanks,
> > >> Eric
> > >
> > >
> > > You can disregard this question. The issue turned out to be a bug in
> > > the ntb_netdev module. The module was calling dev_kfree_skb() in an
> > > inappropriate place (interrupt context). Once that was fixed (changed
> > > to dev_kfree_skb_irq()), some assert WARNINGS (that I had previously
> > > missed) went away and the performance is as expected.
> > >
> >
> > Curious why this bug only effected the AMD DMA driver.... It should've
> > impacted all DMA drivers through NTB right? Did it make any difference
> > with the ioatdma after the change?
>
> That would have been my expectation also, but we have never seen an
> issue with ioatdma. It is only recently that we've started trying out
> ptdma. This particular area of the ntb_netdev module has utilized
> dev_kfree_skb() forever as far as I know. The suspect calls are in
> ntb_netdev_rx_handler() and ntb_netdev_tx_handler(), each of which
> could be called from interrupt context. These handlers are ultimately
> called indirectly via function pointer (struct
> dma_async_tx_descriptor.callback_result).
>
> I have also seen an issue during driver shutdown where dma_sync_wait()
> is hanging up, when ptdma is utilized. Flow is:
> - device_del()
>   - bus_remove_device()
>     - device_release_driver()
>       - device_release_driver_internal()
>         - ntb_transport_bus_remove()
>           - ntb_netdev_remove()
>             - ntb_transport_free_queue()
>               - dma_sync_wait() <<-- HANG
>
> I am still investigating this one further in case it is related to
> something in my local logic as I'm using a custom ntb_transport
> module.
>
> Eric

BTW, I tried the change (dev_kfree_skb -> dev_kfree_skb_irq) in
ntb_netdev, while utilizing ioatdma, and no impact. No warnings/errors
or performance impact before/after the modification.

Just to note, the warning, when utilizing ptdma, was coming from
skb_release_head_state().  I should note that I'm running on an old
Linux base (5.3) and I see this area of logic has changed slightly in
the latest Linux base (6.1).

Linux 5.3:
        if (skb->destructor) {
                WARN_ON(in_irq());  <<<<<<<
                skb->destructor(skb);
        }

Linux 6.1:
        if (skb->destructor) {
                DEBUG_NET_WARN_ON_ONCE(in_hardirq());  <<<<<<<<
                skb->destructor(skb);
        }

However, I see that both in_irq() and in_hardirq() ultimately resolve
to the same check, hardirq_count().

Eric


-- 
Eric Pilmore
epilmore@gigaio.com
http://gigaio.com
Phone: (858) 775 2514

This e-mail message is intended only for the individual(s) to whom
it is addressed and may contain information that is privileged,
confidential, proprietary, or otherwise exempt from disclosure under
applicable law. If you believe you have received this message in
error, please advise the sender by return e-mail and delete it from
your mailbox.
Thank you.
