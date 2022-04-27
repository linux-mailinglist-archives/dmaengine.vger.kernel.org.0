Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734FD5115AC
	for <lists+dmaengine@lfdr.de>; Wed, 27 Apr 2022 13:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiD0K70 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Apr 2022 06:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbiD0K64 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Apr 2022 06:58:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 979AA3C5985;
        Wed, 27 Apr 2022 03:35:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C05C61474;
        Wed, 27 Apr 2022 02:30:54 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.11.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09EDD3F5A1;
        Wed, 27 Apr 2022 02:30:51 -0700 (PDT)
Date:   Wed, 27 Apr 2022 10:30:46 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org,
        vkoul@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, manivannan.sadhasivam@linaro.org,
        Sergey.Semin@baikalelectronics.ru
Subject: Re: [PATCH v9 9/9] PCI: endpoint: Add embedded DMA controller test
Message-ID: <YmkNRnkKo/UQT5uX@lpieralisi>
References: <20220422143643.727871-1-Frank.Li@nxp.com>
 <20220422143643.727871-10-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422143643.727871-10-Frank.Li@nxp.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Apr 22, 2022 at 09:36:43AM -0500, Frank Li wrote:
> Designware provided eDMA support in controller. This enabled use
> this eDMA controller to transfer data.
> 
> The whole flow align with standard DMA usage module
> 
> 1. Using dma_request_channel() and filter function to find correct
> RX and TX Channel.
> 2. dmaengine_slave_config() config remote side physcial address.
> 3. using dmaengine_prep_slave_single() create transfer descriptor
> 4. tx_submit();
> 5. dma_async_issue_pending();
> 
> Tested at i.MX8DXL platform.
> 
> root@imx8qmmek:~# /usr/bin/pcitest -d -w
> WRITE ( 102400 bytes):          OKAY
> root@imx8qmmek:~# /usr/bin/pcitest -d -r
> READ ( 102400 bytes):           OKAY
> 
> WRITE => Size: 102400 bytes DMA: YES  Time: 0.000180145 seconds Rate: 555108 KB/s
> READ => Size: 102400 bytes  DMA: YES  Time: 0.000194397 seconds Rate: 514411 KB/s
> 
> READ => Size: 102400 bytes  DMA: NO   Time: 0.013532597 seconds Rate: 7389 KB/s
> WRITE => Size: 102400 bytes DMA: NO   Time: 0.000857090 seconds Rate: 116673 KB/s
> 

You should rewrite this commit log.

1) this is not Designware specific
2) On what platforms you tested is information for a cover letter but
   not very useful for a commit log
3) The commit log describes why you need the patch and what the patch
   does.
   It can be a one liner: "Enable DMA controller tests for endpoints with
   DMA capabilities". Or something along those lines.

Lorenzo

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v6 to v9:
>  - none
> Change from v5 to v6:
>  - change subject
> Change from v4 to v5:
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
>  		if (ret)
>  			dev_err(dev, "Data transfer failed\n");
>  		ktime_get_ts64(&end);
> -- 
> 2.35.1
> 
