Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B4850C9DB
	for <lists+dmaengine@lfdr.de>; Sat, 23 Apr 2022 14:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbiDWMXq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 23 Apr 2022 08:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235342AbiDWMXp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 23 Apr 2022 08:23:45 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC25A1A3B0
        for <dmaengine@vger.kernel.org>; Sat, 23 Apr 2022 05:20:48 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id c1so3921192pfo.0
        for <dmaengine@vger.kernel.org>; Sat, 23 Apr 2022 05:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oslXbqre1NW7GvGLD8bXnKIy4kjgtTw6N3s1B3zv7HA=;
        b=EVo+WGGNHQGy2OiX6psv2OUAKpNn948+u8q1efdf8UTJpUHSqQ3T1N1KnmUZmMn0Fu
         OUztqeZWM5EKB4ySY3R2G72n0iJuv87In61ay70TQCHWYL/KkRwomtcx3fHYLonjMknm
         GJQuUEvC6MAXq//yehKO1l20anlCwrerYC2Uq44fnWY/kDBJ8cimWOVhw8/g1NOhLP1z
         BURxvoniQ+pd3CbC9jv6o+XhLrxtZbj8ExtVUNRbIKIV/1dlxJ8ORlg/h6vL5ZCZN5Uw
         A2VOCYU2AmuSEA1HYgs6fF16vsBCciRFiRksDwUMDSjEjJcqbv46p7kIvJO+DAnTxIkD
         rWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oslXbqre1NW7GvGLD8bXnKIy4kjgtTw6N3s1B3zv7HA=;
        b=wnmJ/AW6Hd2UGE0W/gmB5EepQJuooZELEvP51zOOvcoWyLn1wzNfnrfscKYXmOqsET
         r34Fq8GILvgE4UatDCDWLZiRvgGy+vPt6raN5uPK+6LnvL0LK8D2UF1JnBJmqpi2yoh1
         B8J609i9Turpjz2AY2R54sJx0o9tFBKdGvuAuOjIpTsuLTOGDtn+QZWvHtsYlYrh5muN
         H7QOVefqPRqk0vwutvySHf6wOszEJS092oPT1YHElhj2EA9BPsmg8pAgmHhZgDfEtSCW
         /QYjC0olrL9NcPE6E+OEOFAinMH24rd/GwCYcUT0DtGw2jWm+yvxPFbqEWFpX8FlW6yc
         Kt7A==
X-Gm-Message-State: AOAM5309RGHbuXg3UTGr/dE/GHqovs6NVDxdlY8vTjupYj1mAvh/+NBT
        NSsdpp7mcgjOgcLnpJ5RZoBt
X-Google-Smtp-Source: ABdhPJxWqne99UgUcPKGXFc6v3kvhqe4IdEhMMI4ljBLdpxARwu5b8pBz02EfACxzMTar+f5G1fhkw==
X-Received: by 2002:a63:d44c:0:b0:380:8c48:e040 with SMTP id i12-20020a63d44c000000b003808c48e040mr8036600pgj.14.1650716448075;
        Sat, 23 Apr 2022 05:20:48 -0700 (PDT)
Received: from thinkpad ([117.207.28.196])
        by smtp.gmail.com with ESMTPSA id bb1-20020a17090b008100b001cd4989feb9sm2197270pjb.5.2022.04.23.05.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 05:20:47 -0700 (PDT)
Date:   Sat, 23 Apr 2022 17:50:40 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org,
        vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        Sergey.Semin@baikalelectronics.ru
Subject: Re: [PATCH v9 9/9] PCI: endpoint: Add embedded DMA controller test
Message-ID: <20220423122040.GJ374560@thinkpad>
References: <20220422143643.727871-1-Frank.Li@nxp.com>
 <20220422143643.727871-10-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422143643.727871-10-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Patch looks good to me but I cannot test it on my platform. So,

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

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
