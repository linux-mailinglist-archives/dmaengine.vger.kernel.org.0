Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A03691813
	for <lists+dmaengine@lfdr.de>; Fri, 10 Feb 2023 06:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjBJFqi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Feb 2023 00:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjBJFqh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Feb 2023 00:46:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7C9643F1;
        Thu,  9 Feb 2023 21:46:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41FD0B82363;
        Fri, 10 Feb 2023 05:46:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38786C433EF;
        Fri, 10 Feb 2023 05:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676007993;
        bh=QSn6XoyFpXD2W04LGu/g0NJ0eT/MSQSv9o2g+wm9Txs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R/salf5gPkyaTBrzxN7b928+NuEIvT5jSi/Q3nqQJg6gxqW2i4m35UKBbDcGHfot0
         U0bq7Kt6S6mvTmcXjWMhI0eIBNEOLiMI5o+dlEcm9Y9yVRP0/dAkzCdMIyQJXF1Ryz
         C3OkKRZBUhxZBHbzPegzM0/tupFziDqVeBJ0flUTluZN5OAToHilLNJlcrr/2SshRB
         LDWsrk/KiUamiaknRoB9VXhUx2gzDzZWwYKJbTqXYKgvrNgNQt1ZpC2BqS0JXlsyOE
         sZdMSjGuAa8VwCzfEfsEZscbtwYoyX3TiF1psLUjn2PafhVmsTWyYyARbEtjrABLXP
         +SiSxEiknHXgQ==
Date:   Fri, 10 Feb 2023 11:16:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     shravan kumar <shravan.chippa@microchip.com>
Cc:     green.wan@sifive.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v1] dmaengine: sf-pdma: pdma_desc memory leak fix
Message-ID: <Y+XaNflpN01k2AMI@matsya>
References: <20230120100623.3530634-1-shravan.chippa@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120100623.3530634-1-shravan.chippa@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-01-23, 15:36, shravan kumar wrote:
> From: Shravan Chippa <shravan.chippa@microchip.com>
> 
> Commit b2cc5c465c2c ("dmaengine: sf-pdma: Add multithread support for a
> DMA channel") changed sf_pdma_prep_dma_memcpy() to unconditionally
> allocate a new sf_pdma_desc each time it is called.
> 
> The driver previously recycled descs, by checking the in_use flag, only
> allocating additional descs if the existing one was in use. This logic
> was removed in commit b2cc5c465c2c ("dmaengine: sf-pdma: Add multithread
> support for a DMA channel"), but sf_pdma_free_desc() was not changed to
> handle the new behaviour.
> 
> As a result, each time sf_pdma_prep_dma_memcpy() is called, the previous
> descriptor is leaked, over time leading to memory starvation:
> 
>   unreferenced object 0xffffffe008447300 (size 192):
>   comm "irq/39-mchp_dsc", pid 343, jiffies 4294906910 (age 981.200s)
>   hex dump (first 32 bytes):
>     00 00 00 ff 00 00 00 00 b8 c1 00 00 00 00 00 00  ................
>     00 00 70 08 10 00 00 00 00 00 00 c0 00 00 00 00  ..p.............
>   backtrace:
>     [<00000000064a04f4>] kmemleak_alloc+0x1e/0x28
>     [<00000000018927a7>] kmem_cache_alloc+0x11e/0x178
>     [<000000002aea8d16>] sf_pdma_prep_dma_memcpy+0x40/0x112
> 
> Add the missing kfree() to sf_pdma_free_desc(), and remove the redundant
> in_use flag.

Applied, thanks

-- 
~Vinod
