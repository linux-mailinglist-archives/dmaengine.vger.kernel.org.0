Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989D66197AA
	for <lists+dmaengine@lfdr.de>; Fri,  4 Nov 2022 14:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbiKDNWn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Nov 2022 09:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbiKDNWj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 4 Nov 2022 09:22:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80525598;
        Fri,  4 Nov 2022 06:22:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35F83B82C13;
        Fri,  4 Nov 2022 13:22:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA70C433D6;
        Fri,  4 Nov 2022 13:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667568155;
        bh=1hK5ljR9yk+op2w1/4TNVZdI5xtxUhlyrb3pnwSfZZ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rBjUUvJFW1YDZUEDqQe5gxd4NvZ4XGOlpm+123KUmXdUx7f/44XEShB9cdYuc7Khn
         vLo09PeNv0mXAo4yfLTZMLtkRUrLgAxqOGvLMn4/4YIC2dwgAcJWePV69gj12WJ5aq
         t1Urc0apTaZok13pJ8hhtqKpPEBrhjwcZMcdO6EYRJEv4H1yBBmgwtqIyZJcXPdDns
         dkgxuFVQ+iQX0wA5x0telfjMZ2HIVjOZEu3DOfm4kza5K8+7/P4o6WlyJ+Pbz7TZIt
         VvwMI1GNlfurJTPymQc3Sw3Eo+4lgnRUA3BRYvMlGJn/b6HyWwSAVUVykc09GF1UE7
         dUIWE1QL54M7g==
Date:   Fri, 4 Nov 2022 18:52:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     peda@axentia.se, du@axentia.se, maciej.sosnowski@intel.com,
        nicolas.ferre@microchip.com, mripard@kernel.org,
        torfl6749@gmail.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 00/32] dmaengine: at_hdmac: Fix concurrency bugs and
 then convert to virt-dma
Message-ID: <Y2USF24O90/dLKz7@matsya>
References: <20221025090306.297886-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025090306.297886-1-tudor.ambarus@microchip.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-10-22, 12:02, Tudor Ambarus wrote:
> v2:
> - reorder patches so that fixes come first -> easier to backport to
> stable kernels.
> - drop the devm_request_irq() patch as we had to disable the irq anyway
> in remove() in order to avoid spurios IRQs. Using devm variant brings no
> palpable benefit.
> - reword pm_ptr commit message
> 
> 
> at_hdmac driver had poor list handling and concurrency bugs.
> We experienced calling of the completion call twice for the
> same descriptor. Peter Rosin encountered the same while
> reporting a different bug:
> https://lore.kernel.org/lkml/13c6c9a2-6db5-c3bf-349b-4c127ad3496a@axentia.se/
> 
> Two sets of tests were performed:
> 1/ tested just the fixes, to make sure everything is fine and the
> concurrency bugs are squashed even without the conversion to virt-dma.
> All went fine.
> 2/ tested the entire series including the conversion the virt-dma
> All went fine.
> 
> I tested NAND (prep_dma_memcpy), MMC (prep_dma_slave_sg),
> usart (cyclic mode), dmatest (memcpy, memset).
> With the conversion to virt-dma I replaced the election of a new transfer
> in the tasklet with the election of the new transfer in the interrupt
> handler. We should have a shorter idle window as we remove the scheduling
> latency of the tasklet. Using mtd_speedtest showed similar performances
> when using NAND with DMA. That could be because of using a low timming
> mode on NAND.

This does not apply on dmaengine-fixes, can you please rebase and resend

-- 
~Vinod
