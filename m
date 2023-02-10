Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD57691858
	for <lists+dmaengine@lfdr.de>; Fri, 10 Feb 2023 07:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjBJGKI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Feb 2023 01:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjBJGKH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Feb 2023 01:10:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EA538662;
        Thu,  9 Feb 2023 22:10:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4757F61CBE;
        Fri, 10 Feb 2023 06:10:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08284C433EF;
        Fri, 10 Feb 2023 06:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676009405;
        bh=jv4TbX6GFpuT5SBF7sQEqLkkaYY2p9ReJ7B17Deq/50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eC3Tutfn6fZwjeZQLwzhFNTdDNgHmBWE17pEMrsIgueH6uJ+CvZbGb05nn66LBHAH
         I91eHhk8rX5z+HTBrnmKNU807f47ekjhISA5t39h4FnbryMIq+mI0hj+BzYink2mRM
         k/hmllC5y0rjWb4EI8PJhItDyN9ast37M2CEAa8i98AIXMOWWmToX6WA/bF7ZK4c6K
         4Wp9VkgQ2LXdHJ+YdhCOkN8NcvfWH4Wp0+pi9VAd5UPPUm9gx1owCwm4SThcrAxDQI
         Dd0k+AiR7IVYLHoTzk1HD98I/sKtqJovAC9wAU4nDSpOvhWSzsXpiKM8F1QuC8RRBS
         vkicLzV/cZfcQ==
Date:   Fri, 10 Feb 2023 11:40:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        dmaengine@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sia Jee Heng <jee.heng.sia@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dw-axi-dmac: Do not dereference NULL structure
Message-ID: <Y+XfuL8jZmSd4/fZ@matsya>
References: <20230127223623.never.507-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127223623.never.507-kees@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27-01-23, 14:36, Kees Cook wrote:
> If "vdesc" is NULL, it cannot be used with vd_to_axi_desc(). Leave
> "bytes" unchanged at 0. Seen under GCC 13 with -Warray-bounds:
> 
> ../drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c: In function 'dma_chan_tx_status':
> ../drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:329:46: warning: array subscript 0 is outside array bounds of 'struct
> virt_dma_desc[46116860184273879]' [-Warray-bounds=]
>   329 |                 bytes = vd_to_axi_desc(vdesc)->length;
>       |                                              ^~
> 

Applied, thanks

-- 
~Vinod
