Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A9B438EE0
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 07:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhJYFg0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 01:36:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:35394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229499AbhJYFgZ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 25 Oct 2021 01:36:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2ADE960E0B;
        Mon, 25 Oct 2021 05:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635140044;
        bh=MBWKkbW1+ESRwn+T7RNQg/OWoFBlupiUTUDxyWaN+RQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pAapQdvIG2/E7DIic8Yh1zD7PyUGNuXbMcYnZyoou6HfSFJ+hNwyYftkZPSzintSC
         InUJrizteFw/8Xd1Paj33MOquMfHtC3Iy6GgJQ2GLN70A26QcGmRkrTbyBlqcQjtwy
         Mmde+43VV6OF4mx9qfC22i9QNuk9Kd5f6sxu1AeyOhata8LDlsYvWJRsZplQUx2wnJ
         KFk+SZfp12itsJMPEe2HQRqtjVU/wJPfyc+v8l2G5XSjTm8SKgDYBQD9TS0mjZI7AI
         D+VoJ8aWKRTuq+Ye9Z8+6Ppb7fkvFv5+oMM6W6ZZz3pvJr7UCbIfuGnTPNkOZ9H0rw
         +NwoTJ9O4dIpA==
Date:   Mon, 25 Oct 2021 11:03:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tim Gardner <tim.gardner@canonical.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][linux-next] dmaengine: dw-axi-dmac: Fix uninitialized
 variable in axi_chan_block_xfer_start()
Message-ID: <YXZBxx8NObaf3x70@matsya>
References: <20211019190701.15525-1-tim.gardner@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019190701.15525-1-tim.gardner@canonical.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-10-21, 13:07, Tim Gardner wrote:
> Coverity complains of an uninitialized variable:
> 
> 5. uninit_use_in_call: Using uninitialized value config.dst_per when calling axi_chan_config_write. [show details]
> 6. uninit_use_in_call: Using uninitialized value config.hs_sel_src when calling axi_chan_config_write. [show details]
> CID 121164 (#1-3 of 3): Uninitialized scalar variable (UNINIT)
> 7. uninit_use_in_call: Using uninitialized value config.src_per when calling axi_chan_config_write. [show details]
> 418        axi_chan_config_write(chan, &config);
> 
> Fix this by clearing the structure which should at least be benign in axi_chan_config_write(). Also fix
> what looks like a cut-n-paste error when initializing config.hs_sel_dst.

Eugeniy?

> 
> Fixes: 824351668a413 ("dmaengine: dw-axi-dmac: support DMAX_NUM_CHANNELS > 8")
> Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
> ---
>  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> index 79572ec532ef..f47116e77ea1 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -386,12 +386,13 @@ static void axi_chan_block_xfer_start(struct axi_dma_chan *chan,
>  
>  	axi_dma_enable(chan->chip);
>  
> +	memset(&config, 0, sizeof(config));

pls init config while defining instead

        struct axi_dma_chan_config config = {};

>  	config.dst_multblk_type = DWAXIDMAC_MBLK_TYPE_LL;
>  	config.src_multblk_type = DWAXIDMAC_MBLK_TYPE_LL;
>  	config.tt_fc = DWAXIDMAC_TT_FC_MEM_TO_MEM_DMAC;
>  	config.prior = priority;
>  	config.hs_sel_dst = DWAXIDMAC_HS_SEL_HW;
> -	config.hs_sel_dst = DWAXIDMAC_HS_SEL_HW;
> +	config.hs_sel_src = DWAXIDMAC_HS_SEL_HW;
>  	switch (chan->direction) {
>  	case DMA_MEM_TO_DEV:
>  		dw_axi_dma_set_byte_halfword(chan, true);
> -- 
> 2.33.1

-- 
~Vinod
