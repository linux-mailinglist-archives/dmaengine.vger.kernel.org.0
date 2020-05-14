Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6846E1D3740
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2020 19:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgENRDi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 May 2020 13:03:38 -0400
Received: from foss.arm.com ([217.140.110.172]:40722 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbgENRDh (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 14 May 2020 13:03:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B40121042;
        Thu, 14 May 2020 10:03:36 -0700 (PDT)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7198D3F71E;
        Thu, 14 May 2020 10:03:35 -0700 (PDT)
Subject: Re: [PATCH v1 2/9] dmaengine: Actions: Add support for S700 DMA
 engine
To:     Amit Singh Tomar <amittomer25@gmail.com>, vkoul@kernel.org,
        afaerber@suse.de, manivannan.sadhasivam@linaro.org
Cc:     dan.j.williams@intel.com, cristian.ciocaltea@gmail.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
References: <1589472657-3930-1-git-send-email-amittomer25@gmail.com>
 <1589472657-3930-3-git-send-email-amittomer25@gmail.com>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Organization: ARM Ltd.
Message-ID: <6d6d6523-7a9f-97a1-124c-cca8f10f1c2f@arm.com>
Date:   Thu, 14 May 2020 18:02:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1589472657-3930-3-git-send-email-amittomer25@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14/05/2020 17:10, Amit Singh Tomar wrote:

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
> Changes since RFC:
> 	* Added accessor function to get the frame lenght.
> 	* Removed the SoC specific check in IRQ routine.
> ---
>  drivers/dma/owl-dma.c | 50 +++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 37 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
> index b0d80a2fa383..afa6c6f43d26 100644
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
> @@ -308,6 +315,11 @@ static inline u32 llc_hw_ctrlb(u32 int_ctl)
>  	return ctl;
>  }
>  
> +static inline u32 llc_hw_flen(struct owl_dma_lli *lli)

Drop the inline, that's not needed. The compiler knows better.

> +{
> +	return lli->hw[OWL_DMADESC_FLEN] & GENMASK(19, 0);
> +}

Please introduce this function in the previous patch already. Otherwise
you replace code here that you introduced only there.

> +
>  static void owl_dma_free_lli(struct owl_dma *od,
>  			     struct owl_dma_lli *lli)
>  {
> @@ -354,6 +366,7 @@ static inline int owl_dma_cfg_lli(struct owl_dma_vchan *vchan,
>  				  struct dma_slave_config *sconfig,
>  				  bool is_cyclic)
>  {
> +	struct owl_dma *od = to_owl_dma(vchan->vc.chan.device);
>  	u32 mode, ctrlb;
>  
>  	mode = OWL_DMA_MODE_PW(0);
> @@ -409,8 +422,14 @@ static inline int owl_dma_cfg_lli(struct owl_dma_vchan *vchan,
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

Can you either add comments or use macros to explain what's going on
here? What is the "1" about?

> +	}
>  
>  	return 0;
>  }
> @@ -572,7 +591,7 @@ static irqreturn_t owl_dma_interrupt(int irq, void *dev_id)
>  
>  		global_irq_pending = dma_readl(od, OWL_DMA_IRQ_PD0);
>  
> -		if (chan_irq_pending && !(global_irq_pending & BIT(i)))	{
> +		if (chan_irq_pending && !(global_irq_pending & BIT(i))) {
>  			dev_dbg(od->dma.dev,
>  				"global and channel IRQ pending match err\n");
>  
> @@ -741,9 +760,9 @@ static u32 owl_dma_getbytes_chan(struct owl_dma_vchan *vchan)
>  		list_for_each_entry(lli, &txd->lli_list, node) {
>  			/* Start from the next active node */
>  			if (lli->phys == next_lli_phy) {
> -				list_for_each_entry(lli, &txd->lli_list, node)
> -					bytes += lli->hw[OWL_DMADESC_FLEN] &
> -						 GENMASK(19, 0);
> +				list_for_each_entry(lli, &txd->lli_list,
> +						    node)

Not needed line break?

Cheers,
Andre.


> +					bytes += llc_hw_flen(lli);
>  				break;
>  			}
>  		}
> @@ -774,7 +793,7 @@ static enum dma_status owl_dma_tx_status(struct dma_chan *chan,
>  	if (vd) {
>  		txd = to_owl_txd(&vd->tx);
>  		list_for_each_entry(lli, &txd->lli_list, node)
> -			bytes += lli->hw[OWL_DMADESC_FLEN] & GENMASK(19, 0);
> +			bytes += llc_hw_flen(lli);
>  	} else {
>  		bytes = owl_dma_getbytes_chan(vchan);
>  	}
> @@ -1031,11 +1050,20 @@ static struct dma_chan *owl_dma_of_xlate(struct of_phandle_args *dma_spec,
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
> @@ -1060,6 +1088,8 @@ static int owl_dma_probe(struct platform_device *pdev)
>  	dev_info(&pdev->dev, "dma-channels %d, dma-requests %d\n",
>  		 nr_channels, nr_requests);
>  
> +	od->devid = (enum owl_dma_id)of_id->data;
> +
>  	od->nr_pchans = nr_channels;
>  	od->nr_vchans = nr_requests;
>  
> @@ -1192,12 +1222,6 @@ static int owl_dma_remove(struct platform_device *pdev)
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

