Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734644D2E58
	for <lists+dmaengine@lfdr.de>; Wed,  9 Mar 2022 12:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiCILpg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Mar 2022 06:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiCILpf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 9 Mar 2022 06:45:35 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9BB1712AB
        for <dmaengine@vger.kernel.org>; Wed,  9 Mar 2022 03:44:36 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id g19so2016492pfc.9
        for <dmaengine@vger.kernel.org>; Wed, 09 Mar 2022 03:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KZV9hj/uC7GrTorz0uQ7uU0D7Wa2F3RBS3FqLpxbuA4=;
        b=nMESCidNg6Rt/5yLxXvf4nacebtrCAEEfxcxiI0lQfNDyYTKoJ2XgYYwB78CFUXrmH
         yZgVZFcuOfCHH6iVtq4JUVP0gljgpSplwh6ljyCuChebrzXQwxIAMZlAG7MpZfy0OCLC
         ZiR4voiVmBiFsYnfYt9W+vm7vZ+2YlDWXA/xKCHlDycehMHAjtjPNfbTOgbRd9LktgEQ
         Z7CvDRGNt22jbZdOFKZnWIieUEEbTpakMSqWavsPUG/6Nr40hmjHG1BtuFUsFZ6+/lw7
         EtcczTwzWomlfRc3ZgAFUJ8y9EHRRnFXy8zPu8dc6zn6wqZvp5qVwe1AOtC4M6B8Zmb6
         s9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KZV9hj/uC7GrTorz0uQ7uU0D7Wa2F3RBS3FqLpxbuA4=;
        b=CStCjl3vh3kcSkrrfdWRFN55oWbKOszUa6KIhglejiHWveRokP5xV2whAYb4YaDMZS
         +V86CE/wDETM9SWiqmx93Ia0V7FB2cYvsy7PeYSBjelYVeXMP9Kf30VVXVwc3RhL4hPB
         fe3qSJwJu2tJZ04bWa7xFUERfOSDjGF4+4qhAb/RYKXhI4tumfyFtAj1OUVkR3ed+1Fy
         JmiMqv8728RqVyKk9CSnFe5xSf/7U18ivhXvCjfPRU5oxMsEfllMPtamx0SyWaYvipJ9
         yc43dRikhzEJw0NWzf4CKRE2Vo7XSLLJFa6+4bkgjo1LLz3Zk3XLJMSQmZtSbfClOEvm
         Y7HA==
X-Gm-Message-State: AOAM531Uhnnsp8yMS02ufxSDiNkvj8JnVnVXh5YKj96OtOWAC9JAPE1/
        x/tEbVUNXo+eUufJkihJn1dX
X-Google-Smtp-Source: ABdhPJzoCE9sQGEFODPIDDJ3kRF3MoLegAEK2W0U/V0767L0lXYxDy8X9J0GubS2HCNVMxU68SB/dg==
X-Received: by 2002:a05:6a00:1a8b:b0:4f7:595c:b900 with SMTP id e11-20020a056a001a8b00b004f7595cb900mr1685104pfv.62.1646826275661;
        Wed, 09 Mar 2022 03:44:35 -0800 (PST)
Received: from thinkpad ([117.193.208.22])
        by smtp.gmail.com with ESMTPSA id 2-20020a620502000000b004f6d2975cbesm2500269pff.116.2022.03.09.03.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 03:44:35 -0800 (PST)
Date:   Wed, 9 Mar 2022 17:14:28 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com, vkoul@kernel.org, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        shawnguo@kernel.org
Subject: Re: [PATCH v3 6/6] PCI: endpoint: functions/pci-epf-test: Support
 PCI controller DMA
Message-ID: <20220309114428.GA134091@thinkpad>
References: <20220307224750.18055-1-Frank.Li@nxp.com>
 <20220307224750.18055-6-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307224750.18055-6-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Mar 07, 2022 at 04:47:50PM -0600, Frank Li wrote:
> Designware provided DMA support in controller. This enabled use
> this DMA controller to transfer data.
> 

Please use the term "eDMA (embedded DMA)"

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
> ---
> Resend added dmaengine@vger.kernel.org
> 
> Change from v1 to v3
>  - none
> 
>  drivers/pci/endpoint/functions/pci-epf-test.c | 106 ++++++++++++++++--
>  1 file changed, 96 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 90d84d3bc868f..22ae420c30693 100644
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
> @@ -105,14 +107,17 @@ static void pci_epf_test_dma_callback(void *param)
>   */
>  static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
>  				      dma_addr_t dma_dst, dma_addr_t dma_src,
> -				      size_t len)
> +				      size_t len, dma_addr_t remote,

dma_remote to align with other parameters

> +				      enum dma_transfer_direction dir)
>  {
>  	enum dma_ctrl_flags flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
> -	struct dma_chan *chan = epf_test->dma_chan;
> +	struct dma_chan *chan = (dir == DMA_DEV_TO_MEM) ? epf_test->dma_chan_tx : epf_test->dma_chan_rx;

Move this to top for reverse Xmas tree order

>  	struct pci_epf *epf = epf_test->epf;
>  	struct dma_async_tx_descriptor *tx;
>  	struct device *dev = &epf->dev;
>  	dma_cookie_t cookie;
> +	struct dma_slave_config	sconf;

struct dma_slave_config sconf = {}

This can save one memset() below

> +	dma_addr_t local = (dir == DMA_MEM_TO_DEV) ? dma_src : dma_dst;

dma_local?

>  	int ret;
>  
>  	if (IS_ERR_OR_NULL(chan)) {
> @@ -120,7 +125,20 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
>  		return -EINVAL;
>  	}
>  
> -	tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src, len, flags);
> +	if (epf_test->dma_private) {
> +		memset(&sconf, 0, sizeof(sconf));
> +		sconf.direction = dir;
> +		if (dir == DMA_MEM_TO_DEV)
> +			sconf.dst_addr = remote;
> +		else
> +			sconf.src_addr = remote;
> +
> +		dmaengine_slave_config(chan, &sconf);

This could fail

> +		tx = dmaengine_prep_slave_single(chan, local, len, dir, flags);
> +	} else {
> +		tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src, len, flags);
> +	}
> +
>  	if (!tx) {
>  		dev_err(dev, "Failed to prepare DMA memcpy\n");
>  		return -EIO;
> @@ -148,6 +166,23 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
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

This will not work when read/write channel counts are greater than 1. You would
need this patch:

https://git.linaro.org/landing-teams/working/qualcomm/kernel.git/commit/?h=tracking-qcomlt-sdx55-drivers&id=c77ad9d929372b1ff495709714b24486d266a810

Feel free to pick it up in next iteration

> +}
> +
>  /**
>   * pci_epf_test_init_dma_chan() - Function to initialize EPF test DMA channel
>   * @epf_test: the EPF test device that performs data transfer operation
> @@ -160,8 +195,42 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
>  	struct device *dev = &epf->dev;
>  	struct dma_chan *dma_chan;
>  	dma_cap_mask_t mask;
> +	struct epf_dma_filter filter;

Please preserve the reverse Xmas tree order

>  	int ret;
>  
> +	filter.dev = epf->epc->dev.parent;
> +	filter.dma_mask = BIT(DMA_DEV_TO_MEM);
> +
> +	dma_cap_zero(mask);
> +	dma_cap_set(DMA_SLAVE, mask);
> +	dma_chan = dma_request_channel(mask, epf_dma_filter_fn, &filter);
> +	if (IS_ERR(dma_chan)) {

dma_request_channel() can return NULL also. So use IS_ERR_OR_NULL() for error
check

> +		dev_info(dev, "Failure get built-in DMA channel, fail back to try allocate general DMA channel\n");

"Failed to get private DMA channel. Falling back to generic one"

> +		goto fail_back_tx;
> +	}
> +
> +	epf_test->dma_chan_rx = dma_chan;
> +
> +	filter.dma_mask = BIT(DMA_MEM_TO_DEV);
> +	dma_chan = dma_request_channel(mask, epf_dma_filter_fn, &filter);
> +
> +	if (IS_ERR(dma_chan)) {
> +		dev_info(dev, "Failure get built-in DMA channel, fail back to try allocate general DMA channel\n");

"Failed to get private DMA channel. Falling back to generic one"

> +		goto fail_back_rx;
> +	}
> +
> +	epf_test->dma_chan_tx = dma_chan;
> +	epf_test->dma_private = true;
> +
> +	init_completion(&epf_test->transfer_complete);

You could use DECLARE_COMPLETION_ONSTACK() for simplifying the completion handling.

Thanks,
Mani

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
> @@ -174,7 +243,7 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
>  	}
>  	init_completion(&epf_test->transfer_complete);
>  
> -	epf_test->dma_chan = dma_chan;
> +	epf_test->dma_chan_tx = epf_test->dma_chan_rx = dma_chan;
>  
>  	return 0;
>  }
> @@ -190,8 +259,17 @@ static void pci_epf_test_clean_dma_chan(struct pci_epf_test *epf_test)
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
> @@ -280,8 +358,14 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
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
> @@ -363,7 +447,8 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
>  
>  		ktime_get_ts64(&start);
>  		ret = pci_epf_test_data_transfer(epf_test, dst_phys_addr,
> -						 phys_addr, reg->size);
> +						 phys_addr, reg->size,
> +						 reg->src_addr, DMA_DEV_TO_MEM);
>  		if (ret)
>  			dev_err(dev, "Data transfer failed\n");
>  		ktime_get_ts64(&end);
> @@ -453,8 +538,9 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
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
> 2.24.0.rc1
> 
