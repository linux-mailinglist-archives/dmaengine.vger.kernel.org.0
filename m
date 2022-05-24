Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A082532258
	for <lists+dmaengine@lfdr.de>; Tue, 24 May 2022 07:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbiEXFJp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 May 2022 01:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiEXFJo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 May 2022 01:09:44 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C93852534;
        Mon, 23 May 2022 22:09:41 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 24O59IKt088535;
        Tue, 24 May 2022 00:09:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1653368958;
        bh=T/I4NBWnX8Y94wG/RtdZ+UaXlx+hF+/+ndDDsS8wdOk=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=UhA6T1hoP7vSZ60RyrFOQfUsIl5+EpEjcF6OIuJU58IqavS/+wksfU1YfOeqvLerc
         cNM7QzRruH0jLzRFMgYt7aNgpW10Iupe66J8VWEdAAdWnHyHL9vkDmtvwDc0OCYrwb
         W/90YMefIonROiT6Vvb/HN0oVjLlk7pOR3XRqeQY=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 24O59IUq032321
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 May 2022 00:09:18 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 24
 May 2022 00:09:17 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 24 May 2022 00:09:17 -0500
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 24O59Cqr124293;
        Tue, 24 May 2022 00:09:13 -0500
Message-ID: <59cf4d0b-67ab-913a-3e09-ff09eae4a253@ti.com>
Date:   Tue, 24 May 2022 10:39:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v11 8/8] PCI: endpoint: Enable DMA tests for endpoints
 with DMA capabilities
Content-Language: en-US
To:     Frank Li <Frank.Li@nxp.com>, <gustavo.pimentel@synopsys.com>,
        <hongxing.zhu@nxp.com>, <l.stach@pengutronix.de>,
        <linux-imx@nxp.com>, <linux-pci@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <fancer.lancer@gmail.com>,
        <lznuaa@gmail.com>, <helgaas@kernel.org>
CC:     <vkoul@kernel.org>, <lorenzo.pieralisi@arm.com>, <robh@kernel.org>,
        <kw@linux.com>, <bhelgaas@google.com>,
        <manivannan.sadhasivam@linaro.org>,
        <Sergey.Semin@baikalelectronics.ru>
References: <20220517151915.2212838-1-Frank.Li@nxp.com>
 <20220517151915.2212838-9-Frank.Li@nxp.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
In-Reply-To: <20220517151915.2212838-9-Frank.Li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 17/05/22 20:49, Frank Li wrote:
> Some PCI Endpoints controllers integrate an eDMA (embedded DMA).
> eDMA only sends once a bus read/write command to complete once
> data transfer. eDMA can bypass the outbound memory address translation
> unit to access all RC memory space.
> 
> Add DMA support for pci-epf-test.
> 
> EPF test can use, depending on HW availability, eDMA or general system
> DMA controllers to perform DMA. The test probes the EPF DMA channel
> capabilities.
> 
> Separate dma_chan to dma_chan_tx and dma_chan_rx. eDMA channels have
> higher priority than general DMA channels. If general memory to memory
> DMA hannels are used, dma_chan_rx = dma_chan_tx.
> 
> Add dma_addr_t dma_remote in function pci_epf_test_data_transfer()
> because eDMA using remote RC physical address directly
> 
> Add enum dma_transfer_direction dir in function pci_epf_test_data_transfer()
> because eDMA chooses the correct RX/TX channel by dir.
> 
> The overall steps are
> 
> 1. Execute dma_request_channel() and filter function to find correct eDMA
> RX and TX Channel. If a channel does not exist,  fallback to try to allocate
> general memory to memory DMA  channel.
> 2. Execute dmaengine_slave_config() to configure remote side physical address.
> 3. Execute dmaengine_prep_slave_single() to create transfer descriptor.
> 4. Execute tx_submit().
> 5. Execute dma_async_issue_pending()
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

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
