Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 069A5863ED
	for <lists+dmaengine@lfdr.de>; Thu,  8 Aug 2019 16:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733200AbfHHOJ4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 8 Aug 2019 10:09:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:46856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbfHHOJz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 8 Aug 2019 10:09:55 -0400
Received: from localhost (unknown [122.178.245.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D0D721743;
        Thu,  8 Aug 2019 14:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565273394;
        bh=gA44XLKRN/pAQgX4lVuLJHPX31ttKB8ZduENEjxuRdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1cFxuMxzmr71qoyYuXvjzcX/McYNk2Mypanay4lBJ6eV06PuGWcysIHo3ovxOufgJ
         jvX0Jk8XEWAYjw1BK7K+ZbXaq85E5fFaEFT+bSzAtqJqY9oOJJb2baJcni3UhmzQDw
         Ip/JEMo9RpTNQfy26s5CGE0af8tb7NsneNzINzFo=
Date:   Thu, 8 Aug 2019 19:38:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     jonathanh@nvidia.com, ldewangan@nvidia.com,
        thierry.reding@gmail.com, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: tegra210-adma: fix transfer failure
Message-ID: <20190808140842.GC12733@vkoul-mobl.Dlink>
References: <1562929830-29344-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562929830-29344-1-git-send-email-spujar@nvidia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12-07-19, 16:40, Sameer Pujar wrote:
> >From Tegra186 onwards OUTSTANDING_REQUESTS field is added in channel
  ^^
please remove the leading char from the para

> configuration register(bits 7:4) which defines the maximum number of reads
> from the source and writes to the destination that may be outstanding at
> any given point of time. This field must be programmed with a value
> between 1 and 8. A value of 0 will prevent any transfers from happening.
> 
> Thus added 'ch_pending_req' member in chip data structure and the same is
> populated with maximum allowed pending requests. Since the field is not
> applicable to Tegra210, mentioned bit fields are unused and hence the
> member is initialized with 0. For Tegra186, by default program this field
> with the maximum permitted value of 8.
> 
> Fixes: 433de642a76c ("dmaengine: tegra210-adma: add support for Tegra186/Tegra194")

Should this be tagged stable? Also some reviews from Tegra folks would
be great

> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  drivers/dma/tegra210-adma.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> index 2805853..5ab4e3a9 100644
> --- a/drivers/dma/tegra210-adma.c
> +++ b/drivers/dma/tegra210-adma.c
> @@ -74,6 +74,8 @@
>  				    TEGRA186_ADMA_CH_FIFO_CTRL_TXSIZE(3)    | \
>  				    TEGRA186_ADMA_CH_FIFO_CTRL_RXSIZE(3))
>  
> +#define TEGRA186_DMA_MAX_PENDING_REQS			8
> +
>  #define ADMA_CH_REG_FIELD_VAL(val, mask, shift)	(((val) & mask) << shift)
>  
>  struct tegra_adma;
> @@ -85,6 +87,7 @@ struct tegra_adma;
>   * @ch_req_tx_shift: Register offset for AHUB transmit channel select.
>   * @ch_req_rx_shift: Register offset for AHUB receive channel select.
>   * @ch_base_offset: Register offset of DMA channel registers.
> + * @ch_pending_req: Outstaning DMA requests for a channel.
>   * @ch_fifo_ctrl: Default value for channel FIFO CTRL register.
>   * @ch_req_mask: Mask for Tx or Rx channel select.
>   * @ch_req_max: Maximum number of Tx or Rx channels available.
> @@ -98,6 +101,7 @@ struct tegra_adma_chip_data {
>  	unsigned int ch_req_tx_shift;
>  	unsigned int ch_req_rx_shift;
>  	unsigned int ch_base_offset;
> +	unsigned int ch_pending_req;
>  	unsigned int ch_fifo_ctrl;
>  	unsigned int ch_req_mask;
>  	unsigned int ch_req_max;
> @@ -602,6 +606,7 @@ static int tegra_adma_set_xfer_params(struct tegra_adma_chan *tdc,
>  			 ADMA_CH_CTRL_FLOWCTRL_EN;
>  	ch_regs->config |= cdata->adma_get_burst_config(burst_size);
>  	ch_regs->config |= ADMA_CH_CONFIG_WEIGHT_FOR_WRR(1);
> +	ch_regs->config |= cdata->ch_pending_req;

so for tegra186 this will be 0, which per above would prevent any
transfers?? What did i miss

>  	ch_regs->fifo_ctrl = cdata->ch_fifo_ctrl;
>  	ch_regs->tc = desc->period_len & ADMA_CH_TC_COUNT_MASK;
>  
> @@ -786,6 +791,7 @@ static const struct tegra_adma_chip_data tegra210_chip_data = {
>  	.ch_req_tx_shift	= 28,
>  	.ch_req_rx_shift	= 24,
>  	.ch_base_offset		= 0,
> +	.ch_pending_req		= 0,
>  	.ch_fifo_ctrl		= TEGRA210_FIFO_CTRL_DEFAULT,
>  	.ch_req_mask		= 0xf,
>  	.ch_req_max		= 10,
> @@ -800,6 +806,7 @@ static const struct tegra_adma_chip_data tegra186_chip_data = {
>  	.ch_req_tx_shift	= 27,
>  	.ch_req_rx_shift	= 22,
>  	.ch_base_offset		= 0x10000,
> +	.ch_pending_req		= (TEGRA186_DMA_MAX_PENDING_REQS << 4),
>  	.ch_fifo_ctrl		= TEGRA186_FIFO_CTRL_DEFAULT,
>  	.ch_req_mask		= 0x1f,
>  	.ch_req_max		= 20,
> -- 
> 2.7.4

-- 
~Vinod
