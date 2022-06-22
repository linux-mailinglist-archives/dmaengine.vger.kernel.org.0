Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DEE554334
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jun 2022 09:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbiFVGaH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jun 2022 02:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiFVGaG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Jun 2022 02:30:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05B52F64A
        for <dmaengine@vger.kernel.org>; Tue, 21 Jun 2022 23:30:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A78461425
        for <dmaengine@vger.kernel.org>; Wed, 22 Jun 2022 06:30:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BF8C34114;
        Wed, 22 Jun 2022 06:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655879404;
        bh=h3Vv9qNgq4HzMgNZ/jgHRU49Sdukfg5M6MdpehJH23M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QaAzmbwUCnh1C0IdLDlPkFTgMOfulOmZvz9HzXD58rQb5/4M/zKTmaDYW8ZSAnyxx
         j3g3lcXt12kRacsWjWeaIh3i84twzoxhQSxPOeYVbezqHSZWnTt0ZX3pxZUiR+5eCG
         irRAT80PJVW1U9RLoE6BOjLO+PVa8GH9QwOdgn2tdkNDj/0D9S8iSS4u7uNoQDljnB
         u71RznxiF1YHrA4lX8kwHZieJQGL6ZgNNecTqetPN1D+7R5MVXQd54DGhMPjpP1H/s
         jxhZ6yqN49s9XWCCtIarpH/0IL07Ifgpib1wOZBFHxpqNtqTP0E43tM7OWNt3JyADy
         60+DJt2lnI6Ng==
Date:   Wed, 22 Jun 2022 07:29:58 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Ben Walker <benjamin.walker@intel.com>, dmaengine@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        mporter@kernel.crashing.org, alex.bou9@gmail.com
Subject: Re: [PATCH v2 00/15] dmaengine: Support polling for out of order
 completions
Message-ID: <20220622072918.03ecda4c@sal.lan>
In-Reply-To: <YqGY0fIvuIS88XGl@matsya>
References: <20220503200728.2321188-1-benjamin.walker@intel.com>
        <YqGY0fIvuIS88XGl@matsya>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Em Thu, 9 Jun 2022 12:23:05 +0530
Vinod Koul <vkoul@kernel.org> escreveu:

> On 03-05-22, 13:07, Ben Walker wrote:
> > This series adds support for polling async transactions for completion
> > even if interrupts are disabled and trasactions can complete out of
> > order.
> > 
> > To do this, all DMA client assumptions about the behavior of
> > dma_cookie_t have to be removed. Prior to this series, dma_cookie_t was
> > a monotonically increasing integer and cookies could be compared to one
> > another to determine if earlier operations had completed (up until the
> > cookie wraps around, then it would break).
> > 
> > Fortunately, only one out of the many, many DMA clients had any
> > dependency on dma_cookie_t being anything more than an opaque handle.
> > This is the pxa_camera driver and it is dealt with in patch 7 of this
> > series.
> > 
> > The series also does some API clean up and documents how dma_cookie_t
> > should behave (i.e. there are no rules, it's just a handle).
> > 
> > This closes out by adding support for .device_tx_status() to the idxd
> > driver and then reverting the DMA_OUT_OF_ORDER patch that previously
> > allowed idxd to opt-out of support for polling, which I think is a nice
> > overall simplification to the damengine API.
> > 
> > Herbert, David - Need an ack on patch 4.
> > 
> > Mauro - Need an ack on patches 5 and 7.
> > 
> > Matt, Alexandre - Need an ack on patch 6.  
> 
> Can you rebase and resend this, hopefully folks can ack the change...

The mailing lists for each subsystem should also be c/c, in order to
allow usual reviewers to take a look at the patches. In case of
patches 5 and 7, they both should be c/c to linux-media@vger.kernel.org.

It also makes sense to c/c LKML, in case some of the reviewers want to
see the full patch series.

Regards,
Mauro

> 
> > 
> > Changes since version 1:
> >  - Broke up the change to remove dma_async_is_tx_complete into a single
> >    patch for each driver
> >  - Renamed dma_async_is_tx_complete to dmaengine_async_is_tx_complete.
> > 
> > Ben Walker (15):
> >   dmaengine: Remove dma_async_is_complete from client API
> >   dmaengine: Move dma_set_tx_state to the provider API header
> >   dmaengine: Add dmaengine_async_is_tx_complete
> >   crypto: stm32/hash: Use dmaengine_async_is_tx_complete
> >   media: omap_vout: Use dmaengine_async_is_tx_complete
> >   rapidio: Use dmaengine_async_is_tx_complete
> >   media: pxa_camera: Use dmaengine_async_is_tx_complete
> >   dmaengine: Remove dma_async_is_tx_complete
> >   dmaengine: Remove last, used from dma_tx_state
> >   dmaengine: Providers should prefer dma_set_residue over
> >     dma_set_tx_state
> >   dmaengine: Remove dma_set_tx_state
> >   dmaengine: Add provider documentation on cookie assignment
> >   dmaengine: idxd: idxd_desc.id is now a u16
> >   dmaengine: idxd: Support device_tx_status
> >   dmaengine: Revert "cookie bypass for out of order completion"
> > 
> >  Documentation/driver-api/dmaengine/client.rst | 24 ++----
> >  .../driver-api/dmaengine/provider.rst         | 64 ++++++++------
> >  drivers/crypto/stm32/stm32-hash.c             |  3 +-
> >  drivers/dma/amba-pl08x.c                      |  1 -
> >  drivers/dma/at_hdmac.c                        |  3 +-
> >  drivers/dma/dmaengine.c                       |  2 +-
> >  drivers/dma/dmaengine.h                       | 12 ++-
> >  drivers/dma/dmatest.c                         | 14 +--
> >  drivers/dma/idxd/device.c                     |  1 +
> >  drivers/dma/idxd/dma.c                        | 86 ++++++++++++++++++-
> >  drivers/dma/idxd/idxd.h                       |  3 +-
> >  drivers/dma/imx-sdma.c                        |  3 +-
> >  drivers/dma/mmp_tdma.c                        |  3 +-
> >  drivers/dma/mxs-dma.c                         |  3 +-
> >  drivers/media/platform/omap/omap_vout_vrfb.c  |  2 +-
> >  drivers/media/platform/pxa_camera.c           | 15 +++-
> >  drivers/rapidio/devices/rio_mport_cdev.c      |  3 +-
> >  include/linux/dmaengine.h                     | 58 +------------
> >  18 files changed, 164 insertions(+), 136 deletions(-)
> > 
> > -- 
> > 2.35.1  
> 
