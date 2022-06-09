Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB7C544392
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jun 2022 08:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238230AbiFIGIq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Jun 2022 02:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiFIGIp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Jun 2022 02:08:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596F038BF6;
        Wed,  8 Jun 2022 23:08:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BC94B82B7D;
        Thu,  9 Jun 2022 06:08:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7EEBC34114;
        Thu,  9 Jun 2022 06:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654754921;
        bh=rRyh6mUIdjpNaoFvIEvMubMdp2SSy0/D0Unf7o8kRrA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QNSnlWsCWErljOe9PHQ67cSyld0USpnwcn2om9xWHqZQXD4lPLZlaaIsMGA8q6Te+
         vjpkPktw1+zyIXbEI/rxkaNgVyjAamAkaxSkK9lZ2NAFu6aGqjJhfbC6Lg7A5CR9bz
         pO9sU//NQUEJdl2Yn5YYFF8As1+gp6RBWGfWf9/sKauDeHQEHVog+8Hyic+PZbAo1q
         WOY2eHEAMScDFgwNwxm67Ta0ulMYPqgLrtFFyFDhsVaSiLEbwI3BWCJE2uMT0DrTD4
         4g8m81nyE4+OJ6I7YTMAb0NhHAwqh49H8TcyktXsnwx1nrGR4ujp6IclDdyInmenUT
         25w/YGu/KDgQw==
Date:   Thu, 9 Jun 2022 11:38:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, shengjiu.wang@gmail.com, joy.zou@nxp.com,
        linux-imx@nxp.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma: imx-sdma: Add FIFO offset support for multi FIFO
 script
Message-ID: <YqGOZdv+KHNFCZlK@matsya>
References: <1654163627-30836-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1654163627-30836-1-git-send-email-shengjiu.wang@nxp.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 02-06-22, 17:53, Shengjiu Wang wrote:

subsystem tag should be dmaengine

> The peripheral may have several FIFOs, but some case just select
> some FIFOs from them for data transfer, which means FIFO0 and FIFO2
> may be selected. So add FIFO address offset support, 0 means all FIFOs
> are continuous, 1 means 1 word offset between FIFOs. All offset between
> FIFOs should be same.
> 
> Another option words_per_fifo means how many audio channel data copied
> to one FIFO one time, 0 means one channel per FIFO, 1 means 2 channels
> per FIFO.
> 
> If 'n_fifos_src =  4' and 'words_per_fifo = 1', it means the first two
> words(channels) fetch from FIFO0 and then jump to FIFO1 for next two words,
> and so on after the last FIFO3 fetched, roll back to FIFO0.
> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  drivers/dma/imx-sdma.c      | 26 ++++++++++++++++++++++++--
>  include/linux/dma/imx-dma.h | 13 +++++++++++++
>  2 files changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 111beb7138e0..3c95719286bc 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -183,6 +183,8 @@
>  				 BIT(DMA_DEV_TO_DEV))
>  
>  #define SDMA_WATERMARK_LEVEL_N_FIFOS	GENMASK(15, 12)
> +#define SDMA_WATERMARK_LEVEL_OFF_FIFOS  GENMASK(19, 16)
> +#define SDMA_WATERMARK_LEVEL_WORDS_PER_FIFO   GENMASK(31, 28)
>  #define SDMA_WATERMARK_LEVEL_SW_DONE	BIT(23)
>  
>  #define SDMA_DONE0_CONFIG_DONE_SEL	BIT(7)
> @@ -429,6 +431,9 @@ struct sdma_desc {
>   * @n_fifos_src:	number of source device fifos
>   * @n_fifos_dst:	number of destination device fifos
>   * @sw_done:		software done flag
> + * @off_fifos_src:	offset for source device FIFOs
> + * @off_fifos_dst:	offset for destination device FIFOs

Will both of these be used together...?

> + * @words_per_fifo:	copy number of words one time for one FIFO
>   */
>  struct sdma_channel {
>  	struct virt_dma_chan		vc;
> @@ -456,6 +461,9 @@ struct sdma_channel {
>  	bool				is_ram_script;
>  	unsigned int			n_fifos_src;
>  	unsigned int			n_fifos_dst;
> +	unsigned int			off_fifos_src;
> +	unsigned int			off_fifos_dst;
> +	unsigned int			words_per_fifo;
>  	bool				sw_done;
>  };
>  
> @@ -1245,17 +1253,28 @@ static void sdma_set_watermarklevel_for_p2p(struct sdma_channel *sdmac)
>  static void sdma_set_watermarklevel_for_sais(struct sdma_channel *sdmac)
>  {
>  	unsigned int n_fifos;
> +	unsigned int off_fifos;
> +	unsigned int words_per_fifo;
>  
>  	if (sdmac->sw_done)
>  		sdmac->watermark_level |= SDMA_WATERMARK_LEVEL_SW_DONE;
>  
> -	if (sdmac->direction == DMA_DEV_TO_MEM)
> +	if (sdmac->direction == DMA_DEV_TO_MEM) {
>  		n_fifos = sdmac->n_fifos_src;
> -	else
> +		off_fifos = sdmac->off_fifos_src;
> +	} else {
>  		n_fifos = sdmac->n_fifos_dst;
> +		off_fifos = sdmac->off_fifos_dst;
> +	}
> +
> +	words_per_fifo = sdmac->words_per_fifo;
>  
>  	sdmac->watermark_level |=
>  			FIELD_PREP(SDMA_WATERMARK_LEVEL_N_FIFOS, n_fifos);
> +	sdmac->watermark_level |=
> +			FIELD_PREP(SDMA_WATERMARK_LEVEL_OFF_FIFOS, off_fifos);
> +	sdmac->watermark_level |=
> +			FIELD_PREP(SDMA_WATERMARK_LEVEL_WORDS_PER_FIFO, (words_per_fifo - 1));
>  }
>  
>  static int sdma_config_channel(struct dma_chan *chan)
> @@ -1769,6 +1788,9 @@ static int sdma_config(struct dma_chan *chan,
>  		}
>  		sdmac->n_fifos_src = sdmacfg->n_fifos_src;
>  		sdmac->n_fifos_dst = sdmacfg->n_fifos_dst;
> +		sdmac->off_fifos_src = sdmacfg->off_fifos_src;
> +		sdmac->off_fifos_dst = sdmacfg->off_fifos_dst;
> +		sdmac->words_per_fifo = sdmacfg->words_per_fifo;
>  		sdmac->sw_done = sdmacfg->sw_done;
>  	}
>  
> diff --git a/include/linux/dma/imx-dma.h b/include/linux/dma/imx-dma.h
> index 8887762360d4..0c739d571956 100644
> --- a/include/linux/dma/imx-dma.h
> +++ b/include/linux/dma/imx-dma.h
> @@ -70,6 +70,16 @@ static inline int imx_dma_is_general_purpose(struct dma_chan *chan)
>   * struct sdma_peripheral_config - SDMA config for audio
>   * @n_fifos_src: Number of FIFOs for recording
>   * @n_fifos_dst: Number of FIFOs for playback
> + * @off_fifos_src: FIFO address offset for recording, 0 means all FIFOs are
> + *                 continuous, 1 means 1 word offset between FIFOs. All offset
> + *                 between FIFOs should be same.
> + * @off_fifos_dst: FIFO address offset for playback
> + * @words_per_fifo: numbers of words per FIFO fetch/fill, 0 means
> + *                  one channel per FIFO, 1 means 2 channels per FIFO..
> + *                  If 'n_fifos_src =  4' and 'words_per_fifo = 1', it
> + *                  means the first two words(channels) fetch from FIFO0
> + *                  and then jump to FIFO1 for next two words, and so on
> + *                  after the last FIFO3 fetched, roll back to FIFO0.
>   * @sw_done: Use software done. Needed for PDM (micfil)
>   *
>   * Some i.MX Audio devices (SAI, micfil) have multiple successive FIFO
> @@ -82,6 +92,9 @@ static inline int imx_dma_is_general_purpose(struct dma_chan *chan)
>  struct sdma_peripheral_config {
>  	int n_fifos_src;
>  	int n_fifos_dst;
> +	int off_fifos_src;
> +	int off_fifos_dst;
> +	int words_per_fifo;
>  	bool sw_done;
>  };
>  
> -- 
> 2.17.1

-- 
~Vinod
