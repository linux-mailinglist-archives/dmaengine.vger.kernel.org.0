Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B931A531801
	for <lists+dmaengine@lfdr.de>; Mon, 23 May 2022 22:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242349AbiEWSm0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 May 2022 14:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244445AbiEWSll (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 23 May 2022 14:41:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41482187D9F;
        Mon, 23 May 2022 11:22:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4CA0B81202;
        Mon, 23 May 2022 18:22:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1002C385AA;
        Mon, 23 May 2022 18:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653330142;
        bh=Jq4X9tEfkNqa2aO7nyQNSqyYMNMwtkA/v3xJPFMy80s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EUWkaGd/YDszCDrA/9222yzmSZ/zKiRUTFiXHgb9X7P5vBMsHt8q2GMtSh2AuLA7W
         N84phJhAaVkS/j2O38R/ZFFvTrYzjc2tm1HoaOR0TgV0ZDswAufzqyNLC/5QF4ARlB
         pQSr/7c8lY7n3EeV7WMoEIFdWgrrbeXAiQwToPxCSkZeMdqRtCyhSY3DYpmbGbK/zg
         HN95ajOwOU+5SOTQjbBgosnCk07ZjUTnnZfJzOg9wjs9UJXa/i2qho4uTf3A7AyhP0
         s4ECX/of6+nfx4EokEyvywtSj7zqpF68V91f6449FigTpiaJyQ/TLpp6Yp1zEF+ouP
         w6gUGHnk9ChNA==
Date:   Mon, 23 May 2022 13:22:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, kishon@ti.com,
        vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: Re: [PATCH v11 8/8] PCI: endpoint: Enable DMA tests for endpoints
 with DMA capabilities
Message-ID: <20220523182219.GA168626@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517151915.2212838-9-Frank.Li@nxp.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, May 17, 2022 at 10:19:15AM -0500, Frank Li wrote:
> Some PCI Endpoints controllers integrate an eDMA (embedded DMA).
> eDMA only sends once a bus read/write command to complete once
> data transfer. eDMA can bypass the outbound memory address translation
> unit to access all RC memory space.

s/Endpoints/Endpoint/

I'm not sure what "only sends once a command to complete once
transfer" means or why it is revelant here.  I guess it just means
"the eDMA controller issues a single bus command per data transfer"?

> Add DMA support for pci-epf-test.

It looks like pci-epf-test.c already *has* DMA support, but you're
adding support for separate RX and TX DMA channels.

> EPF test can use, depending on HW availability, eDMA or general system
> DMA controllers to perform DMA. The test probes the EPF DMA channel
> capabilities.
> 
> Separate dma_chan to dma_chan_tx and dma_chan_rx. eDMA channels have
> higher priority than general DMA channels. 

I think the "priority" you refer to is merely that the *test* uses
eDMA channels if present, not that there's any actual hardware
priority involved here, right?

> If general memory to memory
> DMA hannels are used, dma_chan_rx = dma_chan_tx.

s/hannels/channels/

> Add dma_addr_t dma_remote in function pci_epf_test_data_transfer()
> because eDMA using remote RC physical address directly

s/function pci_epf_test_data_transfer()/pci_epf_test_data_transfer()/
s/eDMA using/eDMA uses/
s/directly/directly./

(No need to specify "function" since the parens make it obvious that
pci_epf_test_data_transfer() is a function.  Same thing below.)

> Add enum dma_transfer_direction dir in function pci_epf_test_data_transfer()
> because eDMA chooses the correct RX/TX channel by dir.
> 
> The overall steps are
> 
> 1. Execute dma_request_channel() and filter function to find correct eDMA
> RX and TX Channel. If a channel does not exist,  fallback to try to allocate
> general memory to memory DMA  channel.

s/exist,  /exist, /             remove extra space
s/memory DMA  /memory DMA /     remove extra space again

> 2. Execute dmaengine_slave_config() to configure remote side physical address.

Rewrap to fit in 75 columns.

> 3. Execute dmaengine_prep_slave_single() to create transfer descriptor.
> 4. Execute tx_submit().
> 5. Execute dma_async_issue_pending()
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> Change from v10 to v11:
>  - rewrite commit message
> Change from v9 to v10:
>  - rewrite commit message
> Change from v4 to v9:
>  - none
> Change from v3 to v4:
>  - reverse Xmas tree order
>  - local -> dma_local
>  - change error message
>  - IS_ERR -> IS_ERR_OR_NULL
>  - check return value of dmaengine_slave_config()
> Change from v1 to v2:
>  - none
> 
>  drivers/pci/endpoint/functions/pci-epf-test.c | 108 ++++++++++++++++--
>  1 file changed, 98 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 90d84d3bc868f..f26afd02f3a86 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -52,9 +52,11 @@ struct pci_epf_test {
>  	enum pci_barno		test_reg_bar;
>  	size_t			msix_table_offset;
>  	struct delayed_work	cmd_handler;
> -	struct dma_chan		*dma_chan;
> +	struct dma_chan		*dma_chan_tx;
> +	struct dma_chan		*dma_chan_rx;
>  	struct completion	transfer_complete;
>  	bool			dma_supported;
> +	bool			dma_private;
>  	const struct pci_epc_features *epc_features;
>  };
>  
> @@ -105,12 +107,15 @@ static void pci_epf_test_dma_callback(void *param)
>   */
>  static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
>  				      dma_addr_t dma_dst, dma_addr_t dma_src,
> -				      size_t len)
> +				      size_t len, dma_addr_t dma_remote,
> +				      enum dma_transfer_direction dir)

Please update the kernel-doc for these two new parameters.  You can
use:

  $ make W=1 drivers/pci/endpoint/functions/

to find errors like this.

>  {
> +	struct dma_chan *chan = (dir == DMA_DEV_TO_MEM) ? epf_test->dma_chan_tx : epf_test->dma_chan_rx;
> +	dma_addr_t dma_local = (dir == DMA_MEM_TO_DEV) ? dma_src : dma_dst;
>  	enum dma_ctrl_flags flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
> -	struct dma_chan *chan = epf_test->dma_chan;
>  	struct pci_epf *epf = epf_test->epf;
>  	struct dma_async_tx_descriptor *tx;
> +	struct dma_slave_config sconf = {};
>  	struct device *dev = &epf->dev;
>  	dma_cookie_t cookie;
>  	int ret;
> @@ -120,7 +125,22 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
>  		return -EINVAL;
>  	}
>  
> -	tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src, len, flags);
> +	if (epf_test->dma_private) {
> +		sconf.direction = dir;
> +		if (dir == DMA_MEM_TO_DEV)
> +			sconf.dst_addr = dma_remote;
> +		else
> +			sconf.src_addr = dma_remote;
> +
> +		if (dmaengine_slave_config(chan, &sconf)) {
> +			dev_err(dev, "DMA slave config fail\n");
> +			return -EIO;
> +		}
> +		tx = dmaengine_prep_slave_single(chan, dma_local, len, dir, flags);
> +	} else {
> +		tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src, len, flags);
> +	}
> +
>  	if (!tx) {
>  		dev_err(dev, "Failed to prepare DMA memcpy\n");
>  		return -EIO;
> @@ -148,6 +168,23 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
>  	return 0;
>  }
>  
> +struct epf_dma_filter {
> +	struct device *dev;
> +	u32 dma_mask;
> +};
> +
> +static bool epf_dma_filter_fn(struct dma_chan *chan, void *node)
> +{
> +	struct epf_dma_filter *filter = node;
> +	struct dma_slave_caps caps;
> +
> +	memset(&caps, 0, sizeof(caps));
> +	dma_get_slave_caps(chan, &caps);
> +
> +	return chan->device->dev == filter->dev
> +		&& (filter->dma_mask & caps.directions);
> +}
> +
>  /**
>   * pci_epf_test_init_dma_chan() - Function to initialize EPF test DMA channel
>   * @epf_test: the EPF test device that performs data transfer operation
> @@ -158,10 +195,44 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
>  {
>  	struct pci_epf *epf = epf_test->epf;
>  	struct device *dev = &epf->dev;
> +	struct epf_dma_filter filter;
>  	struct dma_chan *dma_chan;
>  	dma_cap_mask_t mask;
>  	int ret;
>  
> +	filter.dev = epf->epc->dev.parent;
> +	filter.dma_mask = BIT(DMA_DEV_TO_MEM);
> +
> +	dma_cap_zero(mask);
> +	dma_cap_set(DMA_SLAVE, mask);
> +	dma_chan = dma_request_channel(mask, epf_dma_filter_fn, &filter);
> +	if (IS_ERR_OR_NULL(dma_chan)) {
> +		dev_info(dev, "Failed to get private DMA channel. Falling back to generic one\n");
> +		goto fail_back_tx;
> +	}
> +
> +	epf_test->dma_chan_rx = dma_chan;
> +
> +	filter.dma_mask = BIT(DMA_MEM_TO_DEV);
> +	dma_chan = dma_request_channel(mask, epf_dma_filter_fn, &filter);
> +
> +	if (IS_ERR(dma_chan)) {
> +		dev_info(dev, "Failed to get private DMA channel. Falling back to generic one\n");

These messages should indicate whether the failure was for the
DEV_TO_MEM channel or the MEM_TO_DEV channel.  Otherwise the failure
looks the same to the user.

> +		goto fail_back_rx;
> +	}
> +
> +	epf_test->dma_chan_tx = dma_chan;
> +	epf_test->dma_private = true;
> +
> +	init_completion(&epf_test->transfer_complete);
> +
> +	return 0;
> +
> +fail_back_rx:
> +	dma_release_channel(epf_test->dma_chan_rx);
> +	epf_test->dma_chan_tx = NULL;
> +
> +fail_back_tx:
>  	dma_cap_zero(mask);
>  	dma_cap_set(DMA_MEMCPY, mask);
>  
> @@ -174,7 +245,7 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
>  	}
>  	init_completion(&epf_test->transfer_complete);
>  
> -	epf_test->dma_chan = dma_chan;
> +	epf_test->dma_chan_tx = epf_test->dma_chan_rx = dma_chan;
>  
>  	return 0;
>  }
> @@ -190,8 +261,17 @@ static void pci_epf_test_clean_dma_chan(struct pci_epf_test *epf_test)
>  	if (!epf_test->dma_supported)
>  		return;
>  
> -	dma_release_channel(epf_test->dma_chan);
> -	epf_test->dma_chan = NULL;
> +	dma_release_channel(epf_test->dma_chan_tx);
> +	if (epf_test->dma_chan_tx == epf_test->dma_chan_rx) {
> +		epf_test->dma_chan_tx = NULL;
> +		epf_test->dma_chan_rx = NULL;
> +		return;
> +	}
> +
> +	dma_release_channel(epf_test->dma_chan_rx);
> +	epf_test->dma_chan_rx = NULL;
> +
> +	return;
>  }
>  
>  static void pci_epf_test_print_rate(const char *ops, u64 size,
> @@ -280,8 +360,14 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
>  			goto err_map_addr;
>  		}
>  
> +		if (epf_test->dma_private) {
> +			dev_err(dev, "Cannot transfer data using DMA\n");
> +			ret = -EINVAL;
> +			goto err_map_addr;
> +		}
> +
>  		ret = pci_epf_test_data_transfer(epf_test, dst_phys_addr,
> -						 src_phys_addr, reg->size);
> +						 src_phys_addr, reg->size, 0, DMA_MEM_TO_MEM);
>  		if (ret)
>  			dev_err(dev, "Data transfer failed\n");
>  	} else {
> @@ -363,7 +449,8 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
>  
>  		ktime_get_ts64(&start);
>  		ret = pci_epf_test_data_transfer(epf_test, dst_phys_addr,
> -						 phys_addr, reg->size);
> +						 phys_addr, reg->size,
> +						 reg->src_addr, DMA_DEV_TO_MEM);
>  		if (ret)
>  			dev_err(dev, "Data transfer failed\n");
>  		ktime_get_ts64(&end);
> @@ -453,8 +540,9 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
>  		}
>  
>  		ktime_get_ts64(&start);
> +
>  		ret = pci_epf_test_data_transfer(epf_test, phys_addr,
> -						 src_phys_addr, reg->size);
> +						 src_phys_addr, reg->size, reg->dst_addr, DMA_MEM_TO_DEV);

Wrap to fit in 80 columns, like the rest of the file.  There are a
couple other cases above (the dev_info() cases are fine since we don't
want to split info/error message strings).

>  		if (ret)
>  			dev_err(dev, "Data transfer failed\n");
>  		ktime_get_ts64(&end);
> -- 
> 2.35.1
> 
