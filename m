Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98EE02B832C
	for <lists+dmaengine@lfdr.de>; Wed, 18 Nov 2020 18:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgKRRiq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Nov 2020 12:38:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:55816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgKRRiq (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 18 Nov 2020 12:38:46 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 566C7248E4;
        Wed, 18 Nov 2020 17:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605721125;
        bh=TJs6ufOKrYfPMympCMUx0YXX4b/lAEhbvsaPAVJ7nzU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dt8M0ohw8HXTxblHpQirtRUNfOvYLcfIGqCW5lQNXL4FC9zymrt5ZLGBD3jVU2ary
         A4mVlPDZNSf4PcnyRzndgglOEs5MIV4e6nisXjNstGEY5jlwCbHQuRiHhgXTOBQgEa
         8AJirs586mVufGxHNat+E0erKNZl5UcTbUopDIVs=
Date:   Wed, 18 Nov 2020 23:08:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, chuanhua.lei@linux.intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        malliamireddy009@gmail.com, peter.ujfalusi@ti.com
Subject: Re: [PATCH v9 2/2] Add Intel LGM SoC DMA support.
Message-ID: <20201118173840.GW50232@vkoul-mobl>
References: <cover.1605158930.git.mallikarjunax.reddy@linux.intel.com>
 <67be905aa3bcb9faac424f2a134e88d076700419.1605158930.git.mallikarjunax.reddy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67be905aa3bcb9faac424f2a134e88d076700419.1605158930.git.mallikarjunax.reddy@linux.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12-11-20, 13:38, Amireddy Mallikarjuna reddy wrote:
> Add DMA controller driver for Lightning Mountain (LGM) family of SoCs.
> 
> The main function of the DMA controller is the transfer of data from/to any
> peripheral to/from the memory. A memory to memory copy capability can also
> be configured.
> 
> This ldma driver is used for configure the device and channnels for data
> and control paths.
> 
> Signed-off-by: Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>
> ---
> v1:
> - Initial version.

You have a cover letter, use that to keep track of these changes

> +++ b/drivers/dma/lgm/Kconfig
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config INTEL_LDMA
> +	bool "Lightning Mountain centralized low speed DMA and high speed DMA controllers"

Do we have any other speeds :D

> +++ b/drivers/dma/lgm/lgm-dma.c
> @@ -0,0 +1,1742 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Lightning Mountain centralized low speed and high speed DMA controller driver
> + *
> + * Copyright (c) 2016 ~ 2020 Intel Corporation.

I think you mean 2016 - 2020, a dash which refers to duration

> +struct dw2_desc {
> +	struct {
> +		u32 len		:16;
> +		u32 res0	:7;
> +		u32 bofs	:2;
> +		u32 res1	:3;
> +		u32 eop		:1;
> +		u32 sop		:1;
> +		u32 c		:1;
> +		u32 own		:1;
> +	} __packed field;

Another one, looks like folks adding dmaengine patches love this
approach, second one for the day..

Now why do you need the bit fields, why not use register defines and
helpers in bitfield.h to help configure the fields See FIELD_GET,
FIELD_PREP etc

> +struct dma_dev_ops {
> +	int (*device_alloc_chan_resources)(struct dma_chan *chan);
> +	void (*device_free_chan_resources)(struct dma_chan *chan);
> +	int (*device_config)(struct dma_chan *chan,
> +			     struct dma_slave_config *config);
> +	int (*device_pause)(struct dma_chan *chan);
> +	int (*device_resume)(struct dma_chan *chan);
> +	int (*device_terminate_all)(struct dma_chan *chan);
> +	void (*device_synchronize)(struct dma_chan *chan);
> +	enum dma_status (*device_tx_status)(struct dma_chan *chan,
> +					    dma_cookie_t cookie,
> +					    struct dma_tx_state *txstate);
> +	struct dma_async_tx_descriptor *(*device_prep_slave_sg)
> +		(struct dma_chan *chan, struct scatterlist *sgl,
> +		unsigned int sg_len, enum dma_transfer_direction direction,
> +		unsigned long flags, void *context);
> +	void (*device_issue_pending)(struct dma_chan *chan);
> +};

Heh! why do you have a copy of dmaengine ops here?

> +static int ldma_chan_desc_cfg(struct ldma_chan *c, dma_addr_t desc_base,
> +			      int desc_num)
> +{
> +	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
> +
> +	if (!desc_num) {
> +		dev_err(d->dev, "Channel %d must allocate descriptor first\n",
> +			c->nr);
> +		return -EINVAL;
> +	}
> +
> +	if (desc_num > DMA_MAX_DESC_NUM) {
> +		dev_err(d->dev, "Channel %d descriptor number out of range %d\n",
> +			c->nr, desc_num);
> +		return -EINVAL;
> +	}
> +
> +	ldma_chan_desc_hw_cfg(c, desc_base, desc_num);
> +
> +	c->flags |= DMA_HW_DESC;
> +	c->desc_cnt = desc_num;
> +	c->desc_phys = desc_base;

So you have a custom API which is used to configure this flag, a number
and an address. The question is why, can you please help explain this?

> +static void dma_issue_pending(struct dma_chan *chan)
> +{
> +	struct ldma_chan *c = to_ldma_chan(chan);
> +	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
> +	unsigned long flags;
> +
> +	if (d->ver == DMA_VER22) {

why is this specific to this version?

> +static enum dma_status
> +dma_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
> +	      struct dma_tx_state *txstate)
> +{
> +	struct ldma_chan *c = to_ldma_chan(chan);
> +	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
> +	enum dma_status status = DMA_COMPLETE;
> +
> +	if (d->ver == DMA_VER22)
> +		status = dma_cookie_status(chan, cookie, txstate);

so for non DMA_VER22 status is always complete, even if I may havent
invoked issue_pending() right!

> new file mode 100644
> index 000000000000..6942e0ef0977
> --- /dev/null
> +++ b/include/linux/dma/lgm_dma.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2016 ~ 2020 Intel Corporation.
> + */
> +#ifndef LGM_DMA_H
> +#define LGM_DMA_H
> +
> +#include <linux/types.h>
> +#include <linux/dmaengine.h>
> +
> +/*!
> + * \fn int intel_dma_chan_desc_cfg(struct dma_chan *chan, dma_addr_t desc_base,
> + *                                 int desc_num)
> + * \brief Configure low level channel descriptors
> + * \param[in] chan   pointer to DMA channel that the client is using
> + * \param[in] desc_base   descriptor base physical address
> + * \param[in] desc_num   number of descriptors
> + * \return   0 on success
> + * \return   kernel bug reported on failure

See Documentation/process/coding-style.rst!

-- 
~Vinod
