Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143FC2FC215
	for <lists+dmaengine@lfdr.de>; Tue, 19 Jan 2021 22:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbhASSsH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Jan 2021 13:48:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:49902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730714AbhASS22 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 19 Jan 2021 13:28:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59E1423384;
        Tue, 19 Jan 2021 16:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611074421;
        bh=jfIXpXqVZhOWlbrRVnWU9607dhob6RCOtt5MPQ41Jqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S69byIznlukx2mZyChxm9kGqehi2cgTg/eqWONerhv+GVXCOoYMtR24epo9b8jIjI
         FbVYlnAuHyMrqg+Ln54U8zyvyY6rzo7n0zAF3tkaB3gpYERAqhb72BidxXLL0OLIno
         ReO2XZ6wFwMh1YoDhMyPcm/sMpHq8dAE1bhz7y9Dty6rFJp7JrbyvtFJjO9/ruMjhz
         rolwG0fbXQuPn/SeD0bAceZvy9KZku9Ay5SyPz/DLSZ3yGKfbpQd/pRrfF+peBBM/W
         pzo5lmIHGEZxaJ2udYpejlyTgW5YI4uVmNXngH4grlTuuowtsVFu4IyuDmYY1JhLf+
         uZd8ns1Fac9Kg==
Date:   Tue, 19 Jan 2021 22:10:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org, radheys@xilinx.com,
        pthomas8589@gmail.com
Subject: Re: [PATCH] dmaengine: move channel device_node deletion to driver
Message-ID: <20210119164014.GD2771@vkoul-mobl>
References: <161099092469.2495902.5064826526660062342.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161099092469.2495902.5064826526660062342.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-01-21, 10:28, Dave Jiang wrote:
> Channel device_node deletion is managed by the device driver rather than
> the dmaengine core. The deletion was accidentally introduced when making
> channel unregister dynamic. It causes xilinx_dma module to crash on unload
> as reported by Radhey. Remove chan->device_node delete in dmaengine and
> also fix up idxd driver.
> 
> [   42.142705] Internal error: Oops: 96000044 [#1] SMP
> [   42.147566] Modules linked in: xilinx_dma(-) clk_xlnx_clock_wizard uio_pdrv_genirq
> [   42.155139] CPU: 1 PID: 2075 Comm: rmmod Not tainted 5.10.1-00026-g3a2e6dd7a05-dirty #192
> [   42.163302] Hardware name: Enclustra XU5 SOM (DT)
> [   42.167992] pstate: 40000005 (nZcv daif -PAN -UAO -TCO BTYPE=--)
> [   42.173996] pc : xilinx_dma_chan_remove+0x74/0xa0 [xilinx_dma]
> [   42.179815] lr : xilinx_dma_chan_remove+0x70/0xa0 [xilinx_dma]
> [   42.185636] sp : ffffffc01112bca0
> [   42.188935] x29: ffffffc01112bca0 x28: ffffff80402ea640
> 
> xilinx_dma_chan_remove+0x74/0xa0:
> __list_del at ./include/linux/list.h:112 (inlined by)
> __list_del_entry at./include/linux/list.h:135 (inlined by)
> list_del at ./include/linux/list.h:146 (inlined by)
> xilinx_dma_chan_remove at drivers/dma/xilinx/xilinx_dma.c:2546

Applied, thanks

-- 
~Vinod
