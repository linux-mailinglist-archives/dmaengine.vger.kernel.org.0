Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623B8544448
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jun 2022 08:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbiFIGxO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Jun 2022 02:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238357AbiFIGxN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Jun 2022 02:53:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B085D53C6A
        for <dmaengine@vger.kernel.org>; Wed,  8 Jun 2022 23:53:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 500A161DD9
        for <dmaengine@vger.kernel.org>; Thu,  9 Jun 2022 06:53:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCFE3C34114;
        Thu,  9 Jun 2022 06:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654757589;
        bh=jMvpyMAsE89/35AIfaO7R4ygJLmG04nd5e8k7peYgVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KpKw10P3KAzU8/RBfOLKSCSK2yY93fUDeichW9Vnt9+rPHPL3u0K1zD6IBE9XiC+p
         iPEnD8kOxf3euhqjAeh2W8lWWK01T/T5f7KgF9Q0wticxC7iadHI3auiZ1GeznZZg4
         U+v7bS15oUjSyBL3Fsh1bJOQwBY6ZD/6ileU8divBpenxCYp+zrOhlBMWrwQZBUIIT
         tUsCj5WJRTtuzL51KpNUa4Yl+o4CcRJME/MdP+y/ug9nqgLXOdkXj4qVODIUaAOhRD
         reV95So8z93B8PTHh//9PNdy2cykEqG/3aoswTDp5kS0dpl0pwVlnFK56KBGjokWC+
         9b6wgUYmJ9EFg==
Date:   Thu, 9 Jun 2022 12:23:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Ben Walker <benjamin.walker@intel.com>
Cc:     dmaengine@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, mchehab@kernel.org,
        mporter@kernel.crashing.org, alex.bou9@gmail.com
Subject: Re: [PATCH v2 00/15] dmaengine: Support polling for out of order
 completions
Message-ID: <YqGY0fIvuIS88XGl@matsya>
References: <20220503200728.2321188-1-benjamin.walker@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503200728.2321188-1-benjamin.walker@intel.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-05-22, 13:07, Ben Walker wrote:
> This series adds support for polling async transactions for completion
> even if interrupts are disabled and trasactions can complete out of
> order.
> 
> To do this, all DMA client assumptions about the behavior of
> dma_cookie_t have to be removed. Prior to this series, dma_cookie_t was
> a monotonically increasing integer and cookies could be compared to one
> another to determine if earlier operations had completed (up until the
> cookie wraps around, then it would break).
> 
> Fortunately, only one out of the many, many DMA clients had any
> dependency on dma_cookie_t being anything more than an opaque handle.
> This is the pxa_camera driver and it is dealt with in patch 7 of this
> series.
> 
> The series also does some API clean up and documents how dma_cookie_t
> should behave (i.e. there are no rules, it's just a handle).
> 
> This closes out by adding support for .device_tx_status() to the idxd
> driver and then reverting the DMA_OUT_OF_ORDER patch that previously
> allowed idxd to opt-out of support for polling, which I think is a nice
> overall simplification to the damengine API.
> 
> Herbert, David - Need an ack on patch 4.
> 
> Mauro - Need an ack on patches 5 and 7.
> 
> Matt, Alexandre - Need an ack on patch 6.

Can you rebase and resend this, hopefully folks can ack the change...

> 
> Changes since version 1:
>  - Broke up the change to remove dma_async_is_tx_complete into a single
>    patch for each driver
>  - Renamed dma_async_is_tx_complete to dmaengine_async_is_tx_complete.
> 
> Ben Walker (15):
>   dmaengine: Remove dma_async_is_complete from client API
>   dmaengine: Move dma_set_tx_state to the provider API header
>   dmaengine: Add dmaengine_async_is_tx_complete
>   crypto: stm32/hash: Use dmaengine_async_is_tx_complete
>   media: omap_vout: Use dmaengine_async_is_tx_complete
>   rapidio: Use dmaengine_async_is_tx_complete
>   media: pxa_camera: Use dmaengine_async_is_tx_complete
>   dmaengine: Remove dma_async_is_tx_complete
>   dmaengine: Remove last, used from dma_tx_state
>   dmaengine: Providers should prefer dma_set_residue over
>     dma_set_tx_state
>   dmaengine: Remove dma_set_tx_state
>   dmaengine: Add provider documentation on cookie assignment
>   dmaengine: idxd: idxd_desc.id is now a u16
>   dmaengine: idxd: Support device_tx_status
>   dmaengine: Revert "cookie bypass for out of order completion"
> 
>  Documentation/driver-api/dmaengine/client.rst | 24 ++----
>  .../driver-api/dmaengine/provider.rst         | 64 ++++++++------
>  drivers/crypto/stm32/stm32-hash.c             |  3 +-
>  drivers/dma/amba-pl08x.c                      |  1 -
>  drivers/dma/at_hdmac.c                        |  3 +-
>  drivers/dma/dmaengine.c                       |  2 +-
>  drivers/dma/dmaengine.h                       | 12 ++-
>  drivers/dma/dmatest.c                         | 14 +--
>  drivers/dma/idxd/device.c                     |  1 +
>  drivers/dma/idxd/dma.c                        | 86 ++++++++++++++++++-
>  drivers/dma/idxd/idxd.h                       |  3 +-
>  drivers/dma/imx-sdma.c                        |  3 +-
>  drivers/dma/mmp_tdma.c                        |  3 +-
>  drivers/dma/mxs-dma.c                         |  3 +-
>  drivers/media/platform/omap/omap_vout_vrfb.c  |  2 +-
>  drivers/media/platform/pxa_camera.c           | 15 +++-
>  drivers/rapidio/devices/rio_mport_cdev.c      |  3 +-
>  include/linux/dmaengine.h                     | 58 +------------
>  18 files changed, 164 insertions(+), 136 deletions(-)
> 
> -- 
> 2.35.1

-- 
~Vinod
