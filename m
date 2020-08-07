Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13CF823F12E
	for <lists+dmaengine@lfdr.de>; Fri,  7 Aug 2020 18:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbgHGQXy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Aug 2020 12:23:54 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:19202 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgHGQXs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Aug 2020 12:23:48 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f2d80070000>; Fri, 07 Aug 2020 09:23:35 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 07 Aug 2020 09:23:48 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 07 Aug 2020 09:23:48 -0700
Received: from [10.26.73.183] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Aug
 2020 16:23:43 +0000
Subject: Re: [Patch v2 2/4] dmaengine: tegra: Add Tegra GPC DMA driver
To:     Rajesh Gumasta <rgumasta@nvidia.com>, <ldewangan@nvidia.com>,
        <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <thierry.reding@gmail.com>, <p.zabel@pengutronix.de>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <kyarlagadda@nvidia.com>, Pavan Kunapuli <pkunapuli@nvidia.com>
References: <1596699006-9934-1-git-send-email-rgumasta@nvidia.com>
 <1596699006-9934-3-git-send-email-rgumasta@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <bb79cb56-c33b-193a-3947-0a4066d8ccc2@nvidia.com>
Date:   Fri, 7 Aug 2020 17:23:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1596699006-9934-3-git-send-email-rgumasta@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596817415; bh=1VqK9yAg2GM/TAKKjq0JqEtOF2EMO0PPGVIBxBRJSE0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=VI2Va6ryV8Ggq+5wzg42Q6o39MVuCpDQ2OeOv8K3Wi0mRF2TG69+IxSnW6QpaQjdQ
         FBsAfrvBhZmiAGtz039uz2asPck6PFRiEc5aXMN1iqXsBiLTratDSNil9EbSnk6QPh
         hOtVUMnEvMQhD0wTX29oUg/Ynuj9zC918hv3Z3MPbEy0t58bFPrFUa9CSin7o570w6
         wO3Gctu8YGO8JwtmaAQ8bBgY4R2Y4If0cIcmu06PTqupfvl+0EUmsuRrRCYo0g/BH4
         WUMmIcYfvBMoNJL0gEA8EtHJqJ88yXEeou3VzBBS5JZJSkP2r+TSwahLQSXd7BlN+3
         jawE/7s0RXnsg==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 06/08/2020 08:30, Rajesh Gumasta wrote:
> Adding GPC DMA controller driver for Tegra186 and Tegra194. The driver
> supports dma transfers between memory to memory, IO peripheral to memory
> and memory to IO peripheral.
> 
> Signed-off-by: Pavan Kunapuli <pkunapuli@nvidia.com>
> Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
> ---
>  drivers/dma/Kconfig         |   12 +
>  drivers/dma/Makefile        |    1 +
>  drivers/dma/tegra-gpc-dma.c | 1472 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1485 insertions(+)
>  create mode 100644 drivers/dma/tegra-gpc-dma.c

> +static void tegra_dma_desc_free(struct virt_dma_desc *vd)
> +{
> +	struct tegra_dma_desc *dma_desc = vd_to_tegra_dma_desc(vd);
> +	struct tegra_dma_channel *tdc = dma_desc->tdc;
> +	unsigned long flags;
> +
> +	if (!dma_desc)
> +		return;

Personally, I would do this the other way around. If dma_desc is valid
then do the below.

> +	raw_spin_lock_irqsave(&tdc->lock, flags);
> +	kfree(dma_desc);
> +	raw_spin_unlock_irqrestore(&tdc->lock, flags);
> +}
> +
> +static int tegra_dma_slave_config(struct dma_chan *dc,
> +				  struct dma_slave_config *sconfig)
> +{
> +	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
> +
> +	if (!list_empty(&tdc->pending_sg_req)) {
> +		dev_err(tdc2dev(tdc), "Configuration not allowed\n");
> +		return -EBUSY;
> +	}
> +
> +	memcpy(&tdc->dma_sconfig, sconfig, sizeof(*sconfig));
> +	if (tdc->slave_id == -1)
> +		tdc->slave_id = sconfig->slave_id;
> +	tdc->config_init = true;
> +	return 0;
> +}
> +
> +static int tegra_dma_pause(struct tegra_dma_channel *tdc)
> +{
> +	u32 val;
> +	int ret;
> +
> +	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSRE, TEGRA_GPCDMA_CHAN_CSRE_PAUSE);
> +
> +	/* Wait until busy bit is de-asserted */
> +	ret = readl_relaxed_poll_timeout_atomic(tdc->tdma->base_addr +
> +			tdc->chan_base_offset + TEGRA_GPCDMA_CHAN_STATUS,
> +			val,
> +			!(val & TEGRA_GPCDMA_STATUS_BUSY),
> +			TEGRA_GPCDMA_BURST_COMPLETE_TIME,
> +			TEGRA_GPCDMA_BURST_COMPLETION_TIMEOUT);
> +
> +	if (ret) {
> +		dev_err(tdc2dev(tdc), "DMA pause timed out\n");
> +		return ret;

No need to return here.

> +	}
> +
> +	return ret;
> +}

...

> +static irqreturn_t tegra_dma_isr(int irq, void *dev_id)
> +{
> +	struct tegra_dma_channel *tdc = dev_id;
> +	unsigned int err_status;
> +	unsigned long status;
> +
> +	raw_spin_lock(&tdc->lock);
> +
> +	status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_STATUS);
> +	err_status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_ERR_STATUS);
> +
> +	if (err_status) {
> +		tegra_dma_chan_decode_error(tdc, err_status);
> +		tegra_dma_dump_chan_regs(tdc);
> +		tdc_write(tdc, TEGRA_GPCDMA_CHAN_ERR_STATUS, 0xFFFFFFFF);
> +	}
> +
> +	if (status & TEGRA_GPCDMA_STATUS_ISE_EOC) {
> +		tdc_write(tdc, TEGRA_GPCDMA_CHAN_STATUS,
> +			  TEGRA_GPCDMA_STATUS_ISE_EOC);
> +		if (tdc->isr_handler) {
> +			tdc->isr_handler(tdc, false);
> +		} else {
> +			dev_err(tdc->tdma->dev,
> +				"GPCDMA CH%d: status %lx ISR handler absent!\n",
> +				tdc->id, status);
> +			tegra_dma_dump_chan_regs(tdc);
> +		}
> +		raw_spin_unlock(&tdc->lock);
> +		return IRQ_HANDLED;

It is usually better to init a return value to IRQ_NONE at the beginning
and then update the variable here and just have one return point.

> +	}
> +
> +	raw_spin_unlock(&tdc->lock);
> +	return IRQ_NONE;
> +}

...

> +static inline int get_bus_width(struct tegra_dma_channel *tdc,
> +				enum dma_slave_buswidth slave_bw)
> +{
> +	switch (slave_bw) {
> +	case DMA_SLAVE_BUSWIDTH_1_BYTE:
> +		return TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH_8;
> +	case DMA_SLAVE_BUSWIDTH_2_BYTES:
> +		return TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH_16;
> +	case DMA_SLAVE_BUSWIDTH_4_BYTES:
> +		return TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH_32;
> +	case DMA_SLAVE_BUSWIDTH_8_BYTES:
> +		return TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH_64;
> +	default:
> +		dev_warn(tdc2dev(tdc),
> +			 "slave bw is not supported, using 32bits\n");
> +		return TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH_32;

This is an error and so please return an error. I doubtful that there is
any point in trying to continue.

> +	}
> +}
> +
> +static inline int get_burst_size(struct tegra_dma_channel *tdc,
> +				 u32 burst_size,
> +				 enum dma_slave_buswidth slave_bw,
> +				 int len)
> +{
> +	int burst_mmio_width;
> +	int burst_byte;
> +
> +	/*
> +	 * burst_size from client is in terms of the bus_width.
> +	 * convert that into words.
> +	 */
> +	burst_byte = burst_size * slave_bw;
> +	burst_mmio_width = burst_byte / 4;
> +
> +	/* If burst size is 0 then calculate the burst size based on length */
> +	if (!burst_mmio_width) {
> +		if (len & 0xF)

case statement?

> +			return TEGRA_GPCDMA_MMIOSEQ_BURST_1;
> +		else if ((len >> 3) & 0x1)
> +			return TEGRA_GPCDMA_MMIOSEQ_BURST_2;
> +		else if ((len >> 4) & 0x1)
> +			return TEGRA_GPCDMA_MMIOSEQ_BURST_4;
> +		else if ((len >> 5) & 0x1)
> +			return TEGRA_GPCDMA_MMIOSEQ_BURST_8;
> +		else
> +			return TEGRA_GPCDMA_MMIOSEQ_BURST_16;
> +	}
> +	if (burst_mmio_width < 2)

case statement?

> +		return TEGRA_GPCDMA_MMIOSEQ_BURST_1;
> +	else if (burst_mmio_width < 4)
> +		return TEGRA_GPCDMA_MMIOSEQ_BURST_2;
> +	else if (burst_mmio_width < 8)
> +		return TEGRA_GPCDMA_MMIOSEQ_BURST_4;
> +	else if (burst_mmio_width < 16)
> +		return TEGRA_GPCDMA_MMIOSEQ_BURST_8;
> +	else
> +		return TEGRA_GPCDMA_MMIOSEQ_BURST_16;
> +}

...

> +static int tegra_dma_probe(struct platform_device *pdev)
> +{
> +	const struct tegra_dma_chip_data *cdata = NULL;
> +	struct tegra_dma_chip_data *chip_data = NULL;
> +	unsigned int nr_chans, stream_id;
> +	unsigned int start_chan_idx = 0;
> +	struct tegra_dma *tdma;
> +	struct resource	*res;
> +	unsigned int i;
> +	int ret;
> +
> +	if (pdev->dev.of_node) {

This is always true

> +		const struct of_device_id *match;
> +
> +		match = of_match_device(of_match_ptr(tegra_dma_of_match),
> +					&pdev->dev);
> +		if (!match) {

No need to test this.

> +			dev_err(&pdev->dev, "Error: No device match found\n");
> +			return -ENODEV;
> +		}
> +		cdata = match->data;
> +
> +		ret = of_property_read_u32(pdev->dev.of_node, "dma-channels",
> +					   &nr_chans);

You appear to have this in two places; one in DT and one in the chip
data. We can use the chip data and so we don't need this.

> +		if (!ret) {
> +			/* Allocate chip data and update number of channels */
> +			chip_data =
> +				devm_kzalloc(&pdev->dev,
> +					     sizeof(struct tegra_dma_chip_data),
> +								GFP_KERNEL);
> +			if (!chip_data) {
> +				dev_err(&pdev->dev, "Error: memory allocation failed\n");
> +				return -ENOMEM;
> +			}
> +			memcpy(chip_data, cdata,
> +			       sizeof(struct tegra_dma_chip_data));
> +			chip_data->nr_channels = nr_chans;
> +			cdata = chip_data;
> +		}
> +		ret = of_property_read_u32(pdev->dev.of_node,
> +					   "nvidia,start-dma-channel-index",
> +						&start_chan_idx);

This is not a valid property for DT. Please remove.

Cheers
Jon

-- 
nvpublic
