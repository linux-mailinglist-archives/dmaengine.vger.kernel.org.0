Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C98619F5E
	for <lists+dmaengine@lfdr.de>; Fri,  4 Nov 2022 18:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbiKDR7O (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Nov 2022 13:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbiKDR7N (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 4 Nov 2022 13:59:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A573845A22;
        Fri,  4 Nov 2022 10:59:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A65260EEB;
        Fri,  4 Nov 2022 17:59:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B7AC433C1;
        Fri,  4 Nov 2022 17:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667584751;
        bh=9bEd6RvWlk8+LwS+SOM2Gnnt/TE+rZd1G811+jRRR4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eJlWA5Ep5Y/GLJsLjdSVCc84lnXkmpHo6RAK/jXWNOYcx4InkFy6suDmJ/Z7xn5/3
         7aDBc3VVQMa/dNblVzLvr9tu86GKhGuyo0Q5OnVowQ5LIZbu36jCRpxuApcKkrk9C3
         8E7zrBvHYs2RrLIpo2zuSbj5odDLIKnxign78033XzF2yl1uuD7xwIOcyHGzOKSqX2
         Df8GkiO/xqm12qCoTOojWuzNqUuq2EME0hGQNlu1RzVtIvnNvml43AVjlhik34oqDU
         RxJSdrPla8AGUjbKV4ev+UCZNVGrP/XA1rNXkIkPNlA9AG6gCutqn/v29qQgWHmCu7
         nLdFx2SmI020A==
Date:   Fri, 4 Nov 2022 23:29:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tudor.Ambarus@microchip.com
Cc:     peda@axentia.se, du@axentia.se, maciej.sosnowski@intel.com,
        Nicolas.Ferre@microchip.com, mripard@kernel.org,
        torfl6749@gmail.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 00/32] dmaengine: at_hdmac: Fix concurrency bugs and
 then convert to virt-dma
Message-ID: <Y2VS6xPnTXNvNtf8@matsya>
References: <20221025090306.297886-1-tudor.ambarus@microchip.com>
 <Y2USF24O90/dLKz7@matsya>
 <d1035d5f-02f8-a98f-fbfe-bccbdfd3920b@microchip.com>
 <93048355-18a0-df4e-54ad-9c5955933109@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93048355-18a0-df4e-54ad-9c5955933109@microchip.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 04-11-22, 15:21, Tudor.Ambarus@microchip.com wrote:
> 
> >>
> >> This does not apply on dmaengine-fixes, can you please rebase and resend
> >>
> > 
> > Sure, I can, but on my side it applies just fine, both on the fixes and next
> > branches. I used git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git
> > Shall I use other tree?

this is right tree, I was on fixes branch (for initial fixes) and i
think 7th or 8th one failed to apply for me...

> 
> $ git log --oneline
> 79029dc341c7 (HEAD, vkoul-dma/fixes) dmaengine: stm32-dma: fix potential race between pause and resume
> 
> [cut]
> 
> $ b4 am 20221025090306.297886-1-tudor.ambarus@microchip.com
> Looking up https://lore.kernel.org/r/20221025090306.297886-1-tudor.ambarus%40microchip.com
> Grabbing thread from lore.kernel.org/all/20221025090306.297886-1-tudor.ambarus%40microchip.com/t.mbox.gz
> Analyzing 37 messages in the thread
> Checking attestation on all messages, may take a moment...
> ---
>   [PATCH v2 1/32] dmaengine: at_hdmac: Fix at_lli struct definition
>   [PATCH v2 2/32] dmaengine: at_hdmac: Don't start transactions at tx_submit level
>   [PATCH v2 3/32] dmaengine: at_hdmac: Start transfer for cyclic channels in issue_pending
>   [PATCH v2 4/32] dmaengine: at_hdmac: Fix premature completion of desc in issue_pending
>   [PATCH v2 5/32] dmaengine: at_hdmac: Do not call the complete callback on device_terminate_all
>   [PATCH v2 6/32] dmaengine: at_hdmac: Protect atchan->status with the channel lock
>   [PATCH v2 7/32] dmaengine: at_hdmac: Fix concurrency problems by removing atc_complete_all()
>   [PATCH v2 8/32] dmaengine: at_hdmac: Fix concurrency over descriptor
>   [PATCH v2 9/32] dmaengine: at_hdmac: Free the memset buf without holding the chan lock
>   [PATCH v2 10/32] dmaengine: at_hdmac: Fix concurrency over the active list
>   [PATCH v2 11/32] dmaengine: at_hdmac: Fix descriptor handling when issuing it to hardware
>   [PATCH v2 12/32] dmaengine: at_hdmac: Fix completion of unissued descriptor in case of errors
>   [PATCH v2 13/32] dmaengine: at_hdmac: Don't allow CPU to reorder channel enable
>   [PATCH v2 14/32] dmaengine: at_hdmac: Fix impossible condition
>   [PATCH v2 15/32] dmaengine: at_hdmac: Check return code of dma_async_device_register
>   [PATCH v2 16/32] dmaengine: at_hdmac: Do not print messages on console while holding the lock
>   [PATCH v2 17/32] dmaengine: at_hdmac: Return dma_cookie_status()'s ret code when txstate is NULL
>   [PATCH v2 18/32] dmaengine: at_hdmac: Remove superfluous cast
>   [PATCH v2 19/32] dmaengine: at_hdmac: Pass residue by address to avoid unnecessary implicit casts
>   [PATCH v2 20/32] dmaengine: at_hdmac: s/atc_get_bytes_left/atc_get_residue
>   [PATCH v2 21/32] dmaengine: at_hdmac: Introduce atc_get_llis_residue()
>   [PATCH v2 22/32] dmaengine: at_hdmac: Use devm_kzalloc() and struct_size()
>   [PATCH v2 23/32] dmaengine: at_hdmac: Use devm_platform_ioremap_resource
>   [PATCH v2 24/32] dmaengine: at_hdmac: Use devm_clk_get()
>   [PATCH v2 25/32] dmaengine: at_hdmac: Use pm_ptr()
>   [PATCH v2 26/32] dmaengine: at_hdmac: Set include entries in alphabetic order
>   [PATCH v2 27/32] dmaengine: at_hdmac: Keep register definitions and structures private to at_hdmac.c
>   [PATCH v2 28/32] dmaengine: at_hdmac: Use bitfield access macros
>   [PATCH v2 29/32] dmaengine: at_hdmac: Rename "dma_common" to "dma_device"
>   [PATCH v2 30/32] dmaengine: at_hdmac: Rename "chan_common" to "dma_chan"
>   [PATCH v2 31/32] dmaengine: at_hdmac: Remove unused member of at_dma_chan
>   [PATCH v2 32/32] dmaengine: at_hdmac: Convert driver to use virt-dma
>     + Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---
> Total patches: 32
> ---
> NOTE: Some trailers were sent to the cover letter:
>       Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> NOTE: Rerun with -t to apply them to all patches
> ---
> Cover: ./v2_20221025_tudor_ambarus_dmaengine_at_hdmac_fix_concurrency_bugs_and_then_convert_to_virt_dma.cover
>  Link: https://lore.kernel.org/r/20221025090306.297886-1-tudor.ambarus@microchip.com
>  Base: not specified
>        git am ./v2_20221025_tudor_ambarus_dmaengine_at_hdmac_fix_concurrency_bugs_and_then_convert_to_virt_dma.mbx
> 
> $ git am ./v2_20221025_tudor_ambarus_dmaengine_at_hdmac_fix_concurrency_bugs_and_then_convert_to_virt_dma.mbx
> Applying: dmaengine: at_hdmac: Fix at_lli struct definition
> Applying: dmaengine: at_hdmac: Don't start transactions at tx_submit level
> Applying: dmaengine: at_hdmac: Start transfer for cyclic channels in issue_pending
> Applying: dmaengine: at_hdmac: Fix premature completion of desc in issue_pending
> Applying: dmaengine: at_hdmac: Do not call the complete callback on device_terminate_all
> Applying: dmaengine: at_hdmac: Protect atchan->status with the channel lock
> Applying: dmaengine: at_hdmac: Fix concurrency problems by removing atc_complete_all()
> Applying: dmaengine: at_hdmac: Fix concurrency over descriptor
> Applying: dmaengine: at_hdmac: Free the memset buf without holding the chan lock
> Applying: dmaengine: at_hdmac: Fix concurrency over the active list
> Applying: dmaengine: at_hdmac: Fix descriptor handling when issuing it to hardware
> Applying: dmaengine: at_hdmac: Fix completion of unissued descriptor in case of errors
> Applying: dmaengine: at_hdmac: Don't allow CPU to reorder channel enable
> Applying: dmaengine: at_hdmac: Fix impossible condition
> Applying: dmaengine: at_hdmac: Check return code of dma_async_device_register
> Applying: dmaengine: at_hdmac: Do not print messages on console while holding the lock
> Applying: dmaengine: at_hdmac: Return dma_cookie_status()'s ret code when txstate is NULL
> Applying: dmaengine: at_hdmac: Remove superfluous cast
> Applying: dmaengine: at_hdmac: Pass residue by address to avoid unnecessary implicit casts
> Applying: dmaengine: at_hdmac: s/atc_get_bytes_left/atc_get_residue
> Applying: dmaengine: at_hdmac: Introduce atc_get_llis_residue()
> Applying: dmaengine: at_hdmac: Use devm_kzalloc() and struct_size()
> Applying: dmaengine: at_hdmac: Use devm_platform_ioremap_resource
> Applying: dmaengine: at_hdmac: Use devm_clk_get()
> Applying: dmaengine: at_hdmac: Use pm_ptr()
> Applying: dmaengine: at_hdmac: Set include entries in alphabetic order
> Applying: dmaengine: at_hdmac: Keep register definitions and structures private to at_hdmac.c
> Applying: dmaengine: at_hdmac: Use bitfield access macros
> Applying: dmaengine: at_hdmac: Rename "dma_common" to "dma_device"
> Applying: dmaengine: at_hdmac: Rename "chan_common" to "dma_chan"
> Applying: dmaengine: at_hdmac: Remove unused member of at_dma_chan
> Applying: dmaengine: at_hdmac: Convert driver to use virt-dma
> 
> $ git log --oneline
> 0216a9804005 (HEAD) dmaengine: at_hdmac: Convert driver to use virt-dma
> 3c38e6f0c683 dmaengine: at_hdmac: Remove unused member of at_dma_chan
> 3f801af0fe24 dmaengine: at_hdmac: Rename "chan_common" to "dma_chan"
> deee5deb54d7 dmaengine: at_hdmac: Rename "dma_common" to "dma_device"
> 6561448a5bef dmaengine: at_hdmac: Use bitfield access macros
> 744ba3189722 dmaengine: at_hdmac: Keep register definitions and structures private to at_hdmac.c
> c7b1826777a1 dmaengine: at_hdmac: Set include entries in alphabetic order
> fb34dfd24504 dmaengine: at_hdmac: Use pm_ptr()
> 348276780e9c dmaengine: at_hdmac: Use devm_clk_get()
> 800462a74e78 dmaengine: at_hdmac: Use devm_platform_ioremap_resource
> d7236b9dd3b4 dmaengine: at_hdmac: Use devm_kzalloc() and struct_size()
> e6eaacf98492 dmaengine: at_hdmac: Introduce atc_get_llis_residue()
> 010cabae81ae dmaengine: at_hdmac: s/atc_get_bytes_left/atc_get_residue
> 9d09a47eb73a dmaengine: at_hdmac: Pass residue by address to avoid unnecessary implicit casts
> 2dd9e9cbb086 dmaengine: at_hdmac: Remove superfluous cast
> 5ef926e13fb8 dmaengine: at_hdmac: Return dma_cookie_status()'s ret code when txstate is NULL
> 3b09d91a06ef dmaengine: at_hdmac: Do not print messages on console while holding the lock
> e521dfad36a3 dmaengine: at_hdmac: Check return code of dma_async_device_register
> 5edd5e1c0a8d dmaengine: at_hdmac: Fix impossible condition
> 5621e6e7be9b dmaengine: at_hdmac: Don't allow CPU to reorder channel enable
> 263a0ea4bc91 dmaengine: at_hdmac: Fix completion of unissued descriptor in case of errors
> afb3cd55a2c1 dmaengine: at_hdmac: Fix descriptor handling when issuing it to hardware
> cc94d7bdae69 dmaengine: at_hdmac: Fix concurrency over the active list
> e654eceb0331 dmaengine: at_hdmac: Free the memset buf without holding the chan lock
> 2536923b7374 dmaengine: at_hdmac: Fix concurrency over descriptor
> c928306dea15 dmaengine: at_hdmac: Fix concurrency problems by removing atc_complete_all()
> 55f6c9b21ad1 dmaengine: at_hdmac: Protect atchan->status with the channel lock
> ecb13670616f dmaengine: at_hdmac: Do not call the complete callback on device_terminate_all
> e0926ead50f9 dmaengine: at_hdmac: Fix premature completion of desc in issue_pending
> 8354c91e9484 dmaengine: at_hdmac: Start transfer for cyclic channels in issue_pending
> 90395825181c dmaengine: at_hdmac: Don't start transactions at tx_submit level
> 93af084cf60a dmaengine: at_hdmac: Fix at_lli struct definition
> 79029dc341c7 (vkoul-dma/fixes) dmaengine: stm32-dma: fix potential race between pause and resume

-- 
~Vinod
