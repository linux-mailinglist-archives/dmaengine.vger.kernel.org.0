Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEAE567DA7
	for <lists+dmaengine@lfdr.de>; Wed,  6 Jul 2022 07:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiGFFTo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Jul 2022 01:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiGFFTo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Jul 2022 01:19:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE281FCE9;
        Tue,  5 Jul 2022 22:19:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B99D61C44;
        Wed,  6 Jul 2022 05:19:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2934C341C0;
        Wed,  6 Jul 2022 05:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657084782;
        bh=svUMohRId2WoIxN83gAvNcAjKwXZlCNNsgeNDNGEIeE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qZQb4R5DxUUBKTsyOqbJkmXNshqX5eNv3PVxNU8XCPL/x5n9c42eiB53KUJFn0lwR
         yJZliSAFtltdOpv6AFuRLUSUUt7vD8lVex9JbHqoRKZbM8iclPr7fwEAesQJt8MaSj
         OjyYpDVsDP6RKDfEw8frYK6OkXDzTyqGpqqGk/VYyKgCFO8nN/lHfkYpHCsIdCnU/x
         tzZGnKP4pFMMNHSN+GeXBFZwQm/kXQsDRR1tMFhNmVAk75Vcxo43SYZMYJrPknUCGr
         v/AJY4M42i+Emrr0FHPmcxNvgENIYhvVFby4JLUpTJXNH6/x7Mg4fwM/V1an3IHm4C
         9ClQerMQdkbyQ==
Date:   Wed, 6 Jul 2022 10:49:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dmaengine: pl330: Fix lockdep warning about
 non-static key
Message-ID: <YsUbasNhhZQKCCOs@matsya>
References: <20220520181432.149904-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520181432.149904-1-dmitry.osipenko@collabora.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-05-22, 21:14, Dmitry Osipenko wrote:
> The DEFINE_SPINLOCK() macro shouldn't be used for dynamically allocated
> spinlocks. The lockdep warns about this and disables locking validator.
> Fix the warning by making lock static.
> 
>  INFO: trying to register non-static key.
>  The code is fine but needs lockdep annotation, or maybe
>  you didn't initialize this object before use?
>  turning off the locking correctness validator.
>  Hardware name: Radxa ROCK Pi 4C (DT)
>  Call trace:
>   dump_backtrace.part.0+0xcc/0xe0
>   show_stack+0x18/0x6c
>   dump_stack_lvl+0x8c/0xb8
>   dump_stack+0x18/0x34
>   register_lock_class+0x4a8/0x4cc
>   __lock_acquire+0x78/0x20cc
>   lock_acquire.part.0+0xe0/0x230
>   lock_acquire+0x68/0x84
>   _raw_spin_lock_irqsave+0x84/0xc4
>   add_desc+0x44/0xc0
>   pl330_get_desc+0x15c/0x1d0
>   pl330_prep_dma_cyclic+0x100/0x270
>   snd_dmaengine_pcm_trigger+0xec/0x1c0
>   dmaengine_pcm_trigger+0x18/0x24
>   ...

Applied, thanks

-- 
~Vinod
