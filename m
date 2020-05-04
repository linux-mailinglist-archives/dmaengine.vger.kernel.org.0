Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4FD1C3206
	for <lists+dmaengine@lfdr.de>; Mon,  4 May 2020 07:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgEDFEt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 4 May 2020 01:04:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:52088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgEDFEs (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 4 May 2020 01:04:48 -0400
Received: from localhost (unknown [171.76.84.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0488206EB;
        Mon,  4 May 2020 05:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588568688;
        bh=uC1pih+roQvwyhTev/L0dbHWDrWGsjBiyYcYdiKyvnY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dQS/jPaz1EZ2HGweB8C3vAqHoOlHKALAfbdAmZKuny5/FPENQi1dPTy+POlsZgYyQ
         2UjaeSS5S92HESh6a7KqqWmfnvVQX1VwsyjComKoruRNg0TGB70oTH3DLfb1N5nIAh
         ZNJikxLezQrsqLY2UAK8f1qIqmySzy28k59PvvAQ=
Date:   Mon, 4 May 2020 10:34:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] dmaengine: owl: Use correct lock in
 owl_dma_get_pchan()
Message-ID: <20200504050443.GD1375924@vkoul-mobl>
References: <c6e6cdaca252b5364bd294093673951036488cf0.1588439073.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6e6cdaca252b5364bd294093673951036488cf0.1588439073.git.cristian.ciocaltea@gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 02-05-20, 20:15, Cristian Ciocaltea wrote:
> When the kernel is built with lockdep support and the owl-dma driver is
> used, the following message is shown:
> 
> [    2.496939] INFO: trying to register non-static key.
> [    2.501889] the code is fine but needs lockdep annotation.
> [    2.507357] turning off the locking correctness validator.
> [    2.512834] CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.6.3+ #15
> [    2.519084] Hardware name: Generic DT based system
> [    2.523878] Workqueue: events_freezable mmc_rescan
> [    2.528681] [<801127f0>] (unwind_backtrace) from [<8010da58>] (show_stack+0x10/0x14)
> [    2.536420] [<8010da58>] (show_stack) from [<8080fbe8>] (dump_stack+0xb4/0xe0)
> [    2.543645] [<8080fbe8>] (dump_stack) from [<8017efa4>] (register_lock_class+0x6f0/0x718)
> [    2.551816] [<8017efa4>] (register_lock_class) from [<8017b7d0>] (__lock_acquire+0x78/0x25f0)
> [    2.560330] [<8017b7d0>] (__lock_acquire) from [<8017e5e4>] (lock_acquire+0xd8/0x1f4)
> [    2.568159] [<8017e5e4>] (lock_acquire) from [<80831fb0>] (_raw_spin_lock_irqsave+0x3c/0x50)
> [    2.576589] [<80831fb0>] (_raw_spin_lock_irqsave) from [<8051b5fc>] (owl_dma_issue_pending+0xbc/0x120)
> [    2.585884] [<8051b5fc>] (owl_dma_issue_pending) from [<80668cbc>] (owl_mmc_request+0x1b0/0x390)
> [    2.594655] [<80668cbc>] (owl_mmc_request) from [<80650ce0>] (mmc_start_request+0x94/0xbc)
> [    2.602906] [<80650ce0>] (mmc_start_request) from [<80650ec0>] (mmc_wait_for_req+0x64/0xd0)
> [    2.611245] [<80650ec0>] (mmc_wait_for_req) from [<8065aa10>] (mmc_app_send_scr+0x10c/0x144)
> [    2.619669] [<8065aa10>] (mmc_app_send_scr) from [<80659b3c>] (mmc_sd_setup_card+0x4c/0x318)
> [    2.628092] [<80659b3c>] (mmc_sd_setup_card) from [<80659f0c>] (mmc_sd_init_card+0x104/0x430)
> [    2.636601] [<80659f0c>] (mmc_sd_init_card) from [<8065a3e0>] (mmc_attach_sd+0xcc/0x16c)
> [    2.644678] [<8065a3e0>] (mmc_attach_sd) from [<8065301c>] (mmc_rescan+0x3ac/0x40c)
> [    2.652332] [<8065301c>] (mmc_rescan) from [<80143244>] (process_one_work+0x2d8/0x780)
> [    2.660239] [<80143244>] (process_one_work) from [<80143730>] (worker_thread+0x44/0x598)
> [    2.668323] [<80143730>] (worker_thread) from [<8014b5f8>] (kthread+0x148/0x150)
> [    2.675708] [<8014b5f8>] (kthread) from [<801010b4>] (ret_from_fork+0x14/0x20)
> [    2.682912] Exception stack(0xee8fdfb0 to 0xee8fdff8)
> [    2.687954] dfa0:                                     00000000 00000000 00000000 00000000
> [    2.696118] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    2.704277] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> 
> The obvious fix would be to use 'spin_lock_init()' on 'pchan->lock'
> before attempting to call 'spin_lock_irqsave()' in 'owl_dma_get_pchan()'.
> 
> However, according to Manivannan Sadhasivam, 'pchan->lock' was supposed
> to only protect 'pchan->vchan' while 'od->lock' does a similar job in
> 'owl_dma_terminate_pchan()'.
> 
> Therefore, this patch substitutes 'pchan->lock' with 'od->lock' and
> removes the 'lock' attribute in 'owl_dma_pchan' struct.

Applied, thanks

-- 
~Vinod
