Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589142B4C64
	for <lists+dmaengine@lfdr.de>; Mon, 16 Nov 2020 18:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730775AbgKPROu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Nov 2020 12:14:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:41208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731793AbgKPROt (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 16 Nov 2020 12:14:49 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21FF720797;
        Mon, 16 Nov 2020 17:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605546889;
        bh=Do6LikazT2GPRsF4PjZgIWIMXnzhA/SSk92JoCfMLG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V/PPfYy+fVraJmzX0RDzARI4yPpVSeu+Oy83cU0rFyWc1/B/nhWFK+gECtLr1C7qm
         TVyt6NwFmgV6JALFNsNP7bVzYB5hOBpqbTAVZuRdhYQpzzpgSEOCT8I1l97RSEkOe/
         sLWhP2Kc80FumzzaasgjvK+D7S16ddfq+oLViDRA=
Date:   Mon, 16 Nov 2020 22:44:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sugar Zhang <sugar.zhang@rock-chips.com>
Cc:     linux-rockchip@lists.infradead.org,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: pl330: _prep_dma_memcpy: Fix wrong burst size
Message-ID: <20201116171444.GA50232@vkoul-mobl>
References: <1605326106-55681-1-git-send-email-sugar.zhang@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605326106-55681-1-git-send-email-sugar.zhang@rock-chips.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-11-20, 11:55, Sugar Zhang wrote:
> Actually, burst size is equal to '1 << desc->rqcfg.brst_size'.
> we should use burst size, not desc->rqcfg.brst_size.
> 
> dma memcpy performance on Rockchip RV1126
> @ 1512MHz A7, 1056MHz LPDDR3, 200MHz DMA:
> 
> dmatest:
> 
> /# echo dma0chan0 > /sys/module/dmatest/parameters/channel
> /# echo 4194304 > /sys/module/dmatest/parameters/test_buf_size
> /# echo 8 > /sys/module/dmatest/parameters/iterations
> /# echo y > /sys/module/dmatest/parameters/norandom
> /# echo y > /sys/module/dmatest/parameters/verbose
> /# echo 1 > /sys/module/dmatest/parameters/run
> 
> dmatest: dma0chan0-copy0: result #1: 'test passed' with src_off=0x0 dst_off=0x0 len=0x400000
> dmatest: dma0chan0-copy0: result #2: 'test passed' with src_off=0x0 dst_off=0x0 len=0x400000
> dmatest: dma0chan0-copy0: result #3: 'test passed' with src_off=0x0 dst_off=0x0 len=0x400000
> dmatest: dma0chan0-copy0: result #4: 'test passed' with src_off=0x0 dst_off=0x0 len=0x400000
> dmatest: dma0chan0-copy0: result #5: 'test passed' with src_off=0x0 dst_off=0x0 len=0x400000
> dmatest: dma0chan0-copy0: result #6: 'test passed' with src_off=0x0 dst_off=0x0 len=0x400000
> dmatest: dma0chan0-copy0: result #7: 'test passed' with src_off=0x0 dst_off=0x0 len=0x400000
> dmatest: dma0chan0-copy0: result #8: 'test passed' with src_off=0x0 dst_off=0x0 len=0x400000
> 
> Before:
> 
>   dmatest: dma0chan0-copy0: summary 8 tests, 0 failures 48 iops 200338 KB/s (0)
> 
> After this patch:
> 
>   dmatest: dma0chan0-copy0: summary 8 tests, 0 failures 179 iops 734873 KB/s (0)
> 
> After this patch and increase dma clk to 400MHz:
> 
>   dmatest: dma0chan0-copy0: summary 8 tests, 0 failures 259 iops 1062929 KB/s (0)

Applied, thanks

-- 
~Vinod
