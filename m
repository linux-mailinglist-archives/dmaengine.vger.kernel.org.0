Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE421C6F10
	for <lists+dmaengine@lfdr.de>; Wed,  6 May 2020 13:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgEFLNO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 May 2020 07:13:14 -0400
Received: from foss.arm.com ([217.140.110.172]:34202 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgEFLNO (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 6 May 2020 07:13:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFEA31FB;
        Wed,  6 May 2020 04:13:12 -0700 (PDT)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EDBE3F71F;
        Wed,  6 May 2020 04:13:11 -0700 (PDT)
Subject: Re: [PATCH RFC 2/8] dmaengine: Actions: Add support for S700 DMA
 engine
To:     Amit Singh Tomar <amittomer25@gmail.com>, vkoul@kernel.org,
        afaerber@suse.de, manivannan.sadhasivam@linaro.org
Cc:     dan.j.williams@intel.com, cristian.ciocaltea@gmail.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
References: <1588761371-9078-1-git-send-email-amittomer25@gmail.com>
 <1588761371-9078-3-git-send-email-amittomer25@gmail.com>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Autocrypt: addr=andre.przywara@arm.com; prefer-encrypt=mutual; keydata=
 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
 i4aIXCH3Wv6K
Organization: ARM Ltd.
Message-ID: <1c285ad4-a366-db08-e4e8-c2e1437cc505@arm.com>
Date:   Wed, 6 May 2020 12:12:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1588761371-9078-3-git-send-email-amittomer25@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06/05/2020 11:36, Amit Singh Tomar wrote:

Hi,

> DMA controller present on S700 SoC is compatible with the one on S900
> (as most of registers are same), but it has different DMA descriptor
> structure where registers "fcnt" and "ctrlb" uses different encoding.
> 
> For instance, on S900 "fcnt" starts at offset 0x0c and uses upper 12
> bits whereas on S700, it starts at offset 0x1c and uses lower 12 bits.
> 
> This commit adds support for DMA controller present on S700.
> 
> Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
> ---
>  drivers/dma/owl-dma.c | 99 ++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 70 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
> index b0d80a2fa383..6c2f0d0aad4c 100644
> --- a/drivers/dma/owl-dma.c
> +++ b/drivers/dma/owl-dma.c
> @@ -134,6 +134,11 @@ enum owl_dmadesc_offsets {
>  	OWL_DMADESC_SIZE
>  };
>  
> +enum owl_dma_id {
> +	S900_DMA,
> +	S700_DMA,
> +};
> +
>  /**
>   * struct owl_dma_lli - Link list for dma transfer
>   * @hw: hardware link list
> @@ -200,6 +205,7 @@ struct owl_dma_vchan {
>   * @pchans: array of data for the physical channels
>   * @nr_vchans: the number of physical channels
>   * @vchans: array of data for the physical channels
> + * @devid: device id based on OWL SoC
>   */
>  struct owl_dma {
>  	struct dma_device	dma;
> @@ -214,6 +220,7 @@ struct owl_dma {
>  
>  	unsigned int		nr_vchans;
>  	struct owl_dma_vchan	*vchans;
> +	enum owl_dma_id		devid;
>  };
>  
>  static void pchan_update(struct owl_dma_pchan *pchan, u32 reg,
> @@ -354,6 +361,7 @@ static inline int owl_dma_cfg_lli(struct owl_dma_vchan *vchan,
>  				  struct dma_slave_config *sconfig,
>  				  bool is_cyclic)
>  {
> +	struct owl_dma *od = to_owl_dma(vchan->vc.chan.device);
>  	u32 mode, ctrlb;
>  
>  	mode = OWL_DMA_MODE_PW(0);
> @@ -409,8 +417,14 @@ static inline int owl_dma_cfg_lli(struct owl_dma_vchan *vchan,
>  	lli->hw[OWL_DMADESC_DADDR] = dst;
>  	lli->hw[OWL_DMADESC_SRC_STRIDE] = 0;
>  	lli->hw[OWL_DMADESC_DST_STRIDE] = 0;
> -	lli->hw[OWL_DMADESC_FLEN] = len | 1 << 20;
> -	lli->hw[OWL_DMADESC_CTRLB] = ctrlb;
> +
> +	if (od->devid == S700_DMA) {
> +		lli->hw[OWL_DMADESC_FLEN] = len;
> +		lli->hw[OWL_DMADESC_CTRLB] = 1 | ctrlb;
> +	} else {
> +		lli->hw[OWL_DMADESC_FLEN] = len | 1 << 20;
> +		lli->hw[OWL_DMADESC_CTRLB] = ctrlb;
> +	}
>  
>  	return 0;
>  }
> @@ -562,26 +576,35 @@ static irqreturn_t owl_dma_interrupt(int irq, void *dev_id)
>  	dma_writel(od, OWL_DMA_IRQ_PD0, pending);
>  
>  	/* Check missed pending IRQ */
> -	for (i = 0; i < od->nr_pchans; i++) {
> -		pchan = &od->pchans[i];
> -		chan_irq_pending = pchan_readl(pchan, OWL_DMAX_INT_CTL) &
> -				   pchan_readl(pchan, OWL_DMAX_INT_STATUS);
> -
> -		/* Dummy read to ensure OWL_DMA_IRQ_PD0 value is updated */
> -		dma_readl(od, OWL_DMA_IRQ_PD0);
> +	if (od->devid == S900_DMA) {

You should mention (at least in the commit message) why this is needed.
And please move this into a separate function, this indentation is
becoming mad here.

> +		for (i = 0; i < od->nr_pchans; i++) {
> +			pchan = &od->pchans[i];
> +			chan_irq_pending = pchan_readl(pchan,
> +						       OWL_DMAX_INT_CTL) &
> +					   pchan_readl(pchan,
> +						       OWL_DMAX_INT_STATUS)
> +							;
> +
> +			/* Dummy read to ensure OWL_DMA_IRQ_PD0 value is
> +			 * updated
> +			 */
> +			dma_readl(od, OWL_DMA_IRQ_PD0);
>  
> -		global_irq_pending = dma_readl(od, OWL_DMA_IRQ_PD0);
> +			global_irq_pending = dma_readl(od,
> +						       OWL_DMA_IRQ_PD0);
>  
> -		if (chan_irq_pending && !(global_irq_pending & BIT(i)))	{
> -			dev_dbg(od->dma.dev,
> -				"global and channel IRQ pending match err\n");
> +			if (chan_irq_pending && !(global_irq_pending &
> +						  BIT(i))) {
> +				dev_dbg(od->dma.dev,
> +			"global and channel IRQ pending match err\n");
>  
> -			/* Clear IRQ status for this pchan */
> -			pchan_update(pchan, OWL_DMAX_INT_STATUS,
> -				     0xff, false);
> +				/* Clear IRQ status for this pchan */
> +				pchan_update(pchan, OWL_DMAX_INT_STATUS,
> +					     0xff, false);
>  
> -			/* Update global IRQ pending */
> -			pending |= BIT(i);
> +				/* Update global IRQ pending */
> +				pending |= BIT(i);
> +			}
>  		}
>  	}
>  
> @@ -720,6 +743,7 @@ static int owl_dma_resume(struct dma_chan *chan)
>  
>  static u32 owl_dma_getbytes_chan(struct owl_dma_vchan *vchan)
>  {
> +	struct owl_dma *od = to_owl_dma(vchan->vc.chan.device);
>  	struct owl_dma_pchan *pchan;
>  	struct owl_dma_txd *txd;
>  	struct owl_dma_lli *lli;
> @@ -741,9 +765,15 @@ static u32 owl_dma_getbytes_chan(struct owl_dma_vchan *vchan)
>  		list_for_each_entry(lli, &txd->lli_list, node) {
>  			/* Start from the next active node */
>  			if (lli->phys == next_lli_phy) {
> -				list_for_each_entry(lli, &txd->lli_list, node)
> -					bytes += lli->hw[OWL_DMADESC_FLEN] &
> -						 GENMASK(19, 0);
> +				list_for_each_entry(lli, &txd->lli_list, node) {
> +					if (od->devid == S700_DMA)
> +						bytes +=
> +						lli->hw[OWL_DMADESC_FLEN];
> +					else
> +						bytes +=
> +						lli->hw[OWL_DMADESC_FLEN] &
> +						GENMASK(19, 0);

You should have an accessor for getting the frame len, that should avoid
the insane wrapping here. Or factor this out into a helper function.
Alternatively revert the if statement and continue, that saves you one
level of indentation.

I guess flen is limited to 20 bits anyway, so you might want to apply
the 20-bit mask unconditionally.

Cheers,
Andre

> +				}
>  				break;
>  			}
>  		}
> @@ -756,6 +786,7 @@ static enum dma_status owl_dma_tx_status(struct dma_chan *chan,
>  					 dma_cookie_t cookie,
>  					 struct dma_tx_state *state)
>  {
> +	struct owl_dma *od = to_owl_dma(chan->device);
>  	struct owl_dma_vchan *vchan = to_owl_vchan(chan);
>  	struct owl_dma_lli *lli;
>  	struct virt_dma_desc *vd;
> @@ -773,8 +804,13 @@ static enum dma_status owl_dma_tx_status(struct dma_chan *chan,
>  	vd = vchan_find_desc(&vchan->vc, cookie);
>  	if (vd) {
>  		txd = to_owl_txd(&vd->tx);
> -		list_for_each_entry(lli, &txd->lli_list, node)
> -			bytes += lli->hw[OWL_DMADESC_FLEN] & GENMASK(19, 0);
> +		list_for_each_entry(lli, &txd->lli_list, node) {
> +			if (od->devid == S700_DMA)
> +				bytes += lli->hw[OWL_DMADESC_FLEN];
> +			else
> +				bytes += lli->hw[OWL_DMADESC_FLEN] &
> +					 GENMASK(19, 0);
> +		}
>  	} else {
>  		bytes = owl_dma_getbytes_chan(vchan);
>  	}
> @@ -1031,11 +1067,20 @@ static struct dma_chan *owl_dma_of_xlate(struct of_phandle_args *dma_spec,
>  	return chan;
>  }
>  
> +static const struct of_device_id owl_dma_match[] = {
> +	{ .compatible = "actions,s900-dma", .data = (void *)S900_DMA,},
> +	{ .compatible = "actions,s700-dma", .data = (void *)S700_DMA,},
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, owl_dma_match);
> +
>  static int owl_dma_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
>  	struct owl_dma *od;
>  	int ret, i, nr_channels, nr_requests;
> +	const struct of_device_id *of_id =
> +				of_match_device(owl_dma_match, &pdev->dev);
>  
>  	od = devm_kzalloc(&pdev->dev, sizeof(*od), GFP_KERNEL);
>  	if (!od)
> @@ -1060,6 +1105,8 @@ static int owl_dma_probe(struct platform_device *pdev)
>  	dev_info(&pdev->dev, "dma-channels %d, dma-requests %d\n",
>  		 nr_channels, nr_requests);
>  
> +	od->devid = (enum owl_dma_id)of_id->data;
> +
>  	od->nr_pchans = nr_channels;
>  	od->nr_vchans = nr_requests;
>  
> @@ -1192,12 +1239,6 @@ static int owl_dma_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static const struct of_device_id owl_dma_match[] = {
> -	{ .compatible = "actions,s900-dma", },
> -	{ /* sentinel */ }
> -};
> -MODULE_DEVICE_TABLE(of, owl_dma_match);
> -
>  static struct platform_driver owl_dma_driver = {
>  	.probe	= owl_dma_probe,
>  	.remove	= owl_dma_remove,
> 

