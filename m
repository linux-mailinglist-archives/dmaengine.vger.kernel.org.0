Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C346D3DD0C7
	for <lists+dmaengine@lfdr.de>; Mon,  2 Aug 2021 08:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbhHBGuP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Aug 2021 02:50:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229734AbhHBGuP (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 2 Aug 2021 02:50:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94B5F61057;
        Mon,  2 Aug 2021 06:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627887006;
        bh=Fz900XpBh/PGdAtXY0FEeU5U3mClTwo8XC4ZHYQB6Ds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LisSfVvjyPRSJncWeLVqU9SQ0jFJUeXUg6eHjptc8o8Uc2fJk03YV0pjj1GpXfuAo
         CGgrGetPCapWgkleUgsWysHeBwdPxq6zPA3okXnNtiRrPGnDntpI6pRI/o6sb9+0IR
         weoG8wcFF/1Oq2/PgEgXwp5HgYjWQUGx2nrkdqiCuEy91giplHzxSG3U7rUO1EizRg
         sKq7wYXx1D+1+AK4tcmBwdE3YoCXtYcJH/t+qOEK6t/AZqjeBX5mHkkkNimMB+2Bqw
         /zOrQ3LBCkzCBOHtuvUfl6oXC/Ff3uzooWNi+pxjJ12dOz2agMx6sEr4kU3Coxwv3u
         14tu7hxCZEeXA==
Date:   Mon, 2 Aug 2021 12:20:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     pandith.n@intel.com
Cc:     Eugeniy.Paltsev@synopsys.com, dmaengine@vger.kernel.org,
        lakshmi.bai.raja.subramanian@intel.com, kris.pan@intel.com,
        mallikarjunappa.sangannavar@intel.com, Srikanth.Thokala@intel.com
Subject: Re: [PATCH V5 0/3] dmaengine: dw-axi-dmac: support parallel memory
 <--> peripheral transfers
Message-ID: <YQeVmuuLBznc9sBv@matsya>
References: <20210802055454.15192-1-pandith.n@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802055454.15192-1-pandith.n@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 02-08-21, 11:24, pandith.n@intel.com wrote:
> From: Pandith N <pandith.n@intel.com>
> 
> Added support for multiple DMA_MEM_TO_DEV, DMA_DEV_TO_MEM transfers in
> parallel. Peripherals can use DMA for both transmit and receive
> operations in parallel.
> 
> To setup DMA handshaking, the peripheral source number to be programmed
> in respective channel select slot of AXIDMA_CTRL_DMA_HS_SEL. No need to
> check for free slot in dw_axi_dma_set_hw_channel().
> 
> The channel slot used in AXIDMA_CTRL_DMA_HS_SEL needs to be set in
> src_per/dst_per of CHx_CFG register
> 
> Burst length, DMA HW capability set in dt-binding is now used in driver.

Applied, thanks

-- 
~Vinod
