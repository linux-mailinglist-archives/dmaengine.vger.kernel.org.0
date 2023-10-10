Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8377BFFD3
	for <lists+dmaengine@lfdr.de>; Tue, 10 Oct 2023 16:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbjJJO4o (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Oct 2023 10:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbjJJO4m (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 Oct 2023 10:56:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D28AC;
        Tue, 10 Oct 2023 07:56:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC3C0C433C8;
        Tue, 10 Oct 2023 14:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696949800;
        bh=+3BXBy0aMCLszRjGQbujRY/nkx9TtU/Q/8iVrbBGVuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ilP8+33nlnl3IgKElEbRdW7vgMUTBv89xPPxdP7jVqV+exiWjycamTEGn91R+rmdM
         vaYoOXLsNYvL5mgMkz/oNpmmzCjEpPRCmA7xNKrqw/9XKCdo00WmXCnuuEvxybVcb/
         vVrnEHNUicpv4tnTd3PvqKxm1vRpyTQ6ORWeeoQX/s1NzT/mp/aYc2kEW7/uICjPtK
         d6M87Vf36htjrjG+TJwBh0FOUCMltaAmdy/YHgV+mKZ4lpR1piYO3ru6JQev6jxFcE
         3/bTmB+B33r++kUzP9iG38n3YP5/ORprbjUHiEFofpsDd1I/pz409povXV4DFbzzx5
         fzMDBBKE2hKJg==
Date:   Tue, 10 Oct 2023 20:26:26 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     =?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH v2 1/5] dmaengine: dw-edma: Fix the ch_count hdma callback
Message-ID: <20231010145626.GK4884@thinkpad>
References: <20231002131749.2977952-1-kory.maincent@bootlin.com>
 <20231002131749.2977952-2-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231002131749.2977952-2-kory.maincent@bootlin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Oct 02, 2023 at 03:17:45PM +0200, Köry Maincent wrote:
> From: Kory Maincent <kory.maincent@bootlin.com>
> 
> The current check of ch_en enabled to know the maximum number of available
> hardware channels is wrong as it check the number of ch_en register set
> but all of them are unset at probe. This register is set at the
> dw_hdma_v0_core_start function which is run lately before a DMA transfer.
> 
> The HDMA IP have no way to know the number of hardware channels available
> like the eDMA IP, then let set it to maximum channels and let the platform
> set the right number of channels.
> 
> Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

One nitpick below. With that,

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> ---
> 
> See the following thread mail that talk about this issue:
> https://lore.kernel.org/lkml/20230607095832.6d6b1a73@kmaincent-XPS-13-7390/
> 
> Changes in v2:
> - Add comment
> ---
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index 00b735a0202a..3e78d4fd3955 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -65,18 +65,11 @@ static void dw_hdma_v0_core_off(struct dw_edma *dw)
>  
>  static u16 dw_hdma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
>  {
> -	u32 num_ch = 0;
> -	int id;
> -
> -	for (id = 0; id < HDMA_V0_MAX_NR_CH; id++) {
> -		if (GET_CH_32(dw, id, dir, ch_en) & BIT(0))
> -			num_ch++;
> -	}
> -
> -	if (num_ch > HDMA_V0_MAX_NR_CH)
> -		num_ch = HDMA_V0_MAX_NR_CH;
> -
> -	return (u16)num_ch;
> +	/* The HDMA IP have no way to know the number of hardware channels

Please use below style for multi line comment:

	   /*
	    * ...
	    */

- Mani

> +	 * available, we set it to maximum channels and let the platform
> +	 * set the right number of channels.
> +	 */
> +	return HDMA_V0_MAX_NR_CH;
>  }
>  
>  static enum dma_status dw_hdma_v0_core_ch_status(struct dw_edma_chan *chan)
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
