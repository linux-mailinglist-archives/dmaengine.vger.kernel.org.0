Return-Path: <dmaengine+bounces-3202-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E379A97E3DE
	for <lists+dmaengine@lfdr.de>; Mon, 23 Sep 2024 00:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63B3F1C20E6F
	for <lists+dmaengine@lfdr.de>; Sun, 22 Sep 2024 22:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26B11E885;
	Sun, 22 Sep 2024 22:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXRyo+dD"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4F8BA27;
	Sun, 22 Sep 2024 22:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727042476; cv=none; b=sLR7LIqnSt3CfvajpvdYTOt7jHKnJjsUdOWJJGtOZtMWfm6PEqo7+cp920xjtgFTeeZ1yJ0GGzkDQxsX53ZbnfR7ass5TLkcB42c2/NOCL0ty2KSWOQzTsPj5jJiz40Vg6NPnMBUGZvjSMohoJdX/P7G4EQVOF5NgUi7gqmSG8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727042476; c=relaxed/simple;
	bh=p/soAmu2RO/C/tIiPLNsU9CGkT9SOqHWOAcgrtxrKUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxUBnRe5X9MDTaUxAvfcPqi7ougnbST7JL5HO/rjFPvbUwYkLxg/tVxy6JRtBchWWRKxgX8ugKIKb+l7GE3x9u+9fBEno4Fo5DRniDr4t75n2nq7M5ELUB4j5BYjl9tigto5Aog7nU+ATez57kMhuMgkj8b/JI0769FMtBl90ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXRyo+dD; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f7ba97ebaaso33147161fa.2;
        Sun, 22 Sep 2024 15:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727042473; x=1727647273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2F11MlRDxchXHUfNoGUmT3jqqaQlLJ0vF51YAc/EHvI=;
        b=HXRyo+dDrcBxnQRXNWNHXmk3z806/trLjMxWUWWqCyNVh41ymn4FOo1XBzV2cA+1Wv
         LqPoqCD/042ovTdKBlMoo+/bDtdIeO2LVk2B9SBMC26Jq4aOckX0TybNC97F/PvZOYgi
         tZ7mULqk07/W4PhHRt8AspEqiDKyWawrfZAUzvXrEhmrYF6ZEjlhK61Ri6oJpuqqLqt3
         EwoXmCz1DVp9VjTlfL7yMbVJ2qO4jih6p9tbra9k+MR0YvvuNtFPpOacsSd7W4eyc9z+
         uvNZWIhsmjsQ68MPXAaaDj8/Lfi+hJRlMBYjlzLZlWegUodkObxkwkUJpfTjTtGkVH7b
         ySZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727042473; x=1727647273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2F11MlRDxchXHUfNoGUmT3jqqaQlLJ0vF51YAc/EHvI=;
        b=M3KEEJPAGxFjufQjXWYQ83MnRKZOAk9hbHrKRCZCDm8AUX8tnMlx0FML+7+SloX3n0
         KAA1lgFkg+xGt/+zY4l4pRwlxsewP9UsjXGy5vLbN7YOM11SwjlyzRl9zydYzFakbk03
         1+kdlSA4hUqS10fle+qhq8sK6TZUBFs0RIN/d4knxEzuv+TgMxcXJD/rZhzfexp5bJr4
         wpjQ6ybmRVFoMvYr+HxjHZ34UGkKm3cfc2JP9vCzvQD30I8FvSlCj75aGUi6Bt7cCRTu
         LalMUv5R0DChXU672aPuCdt5kIRQ1PDjLFYci3yXxqwdiW3H5MBV1IEAeFhjYZeMgNH3
         Ix7Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+/K3UZvHfA+/6m+n7jce52r777YzojY9ltYoT86+H4IehfpJd3eDMP2f5wqrY5A68tK/MH95GP10ud5s=@vger.kernel.org, AJvYcCXeI6rR9h9IeHm8QxhW4lKxi4WmvBPUjEhgeT+zpOR3wE6aLrxCbYydcSCUL3psRmDGvRdt01XQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzFd/Fjxq4RE2bptBj7Amp4TP1A9vFChWkVAwz5yk2dUmZZqjjl
	f/qivSX+Rm1d5df3++8ApBvvmZAyMSggMQHfKRlbr4A3fCByunIW
X-Google-Smtp-Source: AGHT+IHoMN+jbmkGmsI79k6tPTCnxW9JGzS5bl8JjwANPmEVlA9q1UNuJg8M6/Th+aIbrGdfopLxrw==
X-Received: by 2002:a2e:1312:0:b0:2f5:839:2982 with SMTP id 38308e7fff4ca-2f7cc36597fmr33254601fa.12.1727042472462;
        Sun, 22 Sep 2024 15:01:12 -0700 (PDT)
Received: from mobilestation ([95.79.225.241])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f79d3007basm27545231fa.32.2024.09.22.15.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 15:01:10 -0700 (PDT)
Date: Mon, 23 Sep 2024 01:01:08 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>, stable@vger.kernel.org, 
	Ferry Toth <fntoth@gmail.com>
Subject: Re: [PATCH v3 1/1] dmaengine: dw: Select only supported masters for
 ACPI devices
Message-ID: <ajcqxw6in7364m6bp2wncym65mlqf57fxr6pc4aor3xbokx2cu@2wve6fdtu3vz>
References: <20240920155820.3340081-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920155820.3340081-1-andriy.shevchenko@linux.intel.com>

Hi Andy

On Fri, Sep 20, 2024 at 06:56:17PM +0300, Andy Shevchenko wrote:
> From: Serge Semin <fancer.lancer@gmail.com>
> 
> The recently submitted fix-commit revealed a problem in the iDMA 32-bit
> platform code. Even though the controller supported only a single master
> the dw_dma_acpi_filter() method hard-coded two master interfaces with IDs
> 0 and 1. As a result the sanity check implemented in the commit
> b336268dde75 ("dmaengine: dw: Add peripheral bus width verification")
> got incorrect interface data width and thus prevented the client drivers
> from configuring the DMA-channel with the EINVAL error returned. E.g.,
> the next error was printed for the PXA2xx SPI controller driver trying
> to configure the requested channels:
> 
> > [  164.525604] pxa2xx_spi_pci 0000:00:07.1: DMA slave config failed
> > [  164.536105] pxa2xx_spi_pci 0000:00:07.1: failed to get DMA TX descriptor
> > [  164.543213] spidev spi-SPT0001:00: SPI transfer failed: -16
> 
> The problem would have been spotted much earlier if the iDMA 32-bit
> controller supported more than one master interfaces. But since it
> supports just a single master and the iDMA 32-bit specific code just
> ignores the master IDs in the CTLLO preparation method, the issue has
> been gone unnoticed so far.
> 
> Fix the problem by specifying the default master ID for both memory
> and peripheral devices in the driver data. Thus the issue noticed for
> the iDMA 32-bit controllers will be eliminated and the ACPI-probed
> DW DMA controllers will be configured with the correct master ID by
> default.
> 
> Cc: stable@vger.kernel.org
> Fixes: b336268dde75 ("dmaengine: dw: Add peripheral bus width verification")
> Fixes: 199244d69458 ("dmaengine: dw: add support of iDMA 32-bit hardware")
> Reported-by: Ferry Toth <fntoth@gmail.com>
> Closes: https://lore.kernel.org/dmaengine/ZuXbCKUs1iOqFu51@black.fi.intel.com/
> Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Closes: https://lore.kernel.org/dmaengine/ZuXgI-VcHpMgbZ91@black.fi.intel.com/
> Co-developed-by: Serge Semin <fancer.lancer@gmail.com>
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v3: rewrote to use driver_data
> v2: https://lore.kernel.org/r/20240919185151.7331-1-fancer.lancer@gmail.com

IMO v2 looked better for me. I am sure you know, but Master IDs is a
platform-specific thing specific for each slave/peripheral device
connected to the DMA controller. Depending on the chip design one
peripheral device can be accessed over the one master IDs, another
device/memory may have another master connected (can be up to four
master IDs in general). That's why the master IDs have been declared
in the dw_dma_slave structure. So adding them to struct
dw_dma_chip_pdata doesn't seem like a good idea seeing it contains the
generic DW DMA controller info. On the contrary my implementation
seems a bit more coherent since it just changes the default slave IDs
defined in the dw_dma_acpi_filter() method and initialized in the
dw_dma_slave instance without adding slave-specific fields to the
generic controller data.

What seems like a much better alternative to the both approaches, is
to use the dw_dma_slave instance defined in the mrfld_spi_setup()
method for the Intel Merrifield SPI PXA2xx DMA-interface in
drivers/spi/spi-pxa2xx-pci.c. But AFAICT that data is left unused
since the DMA-engine handle and connection parameters are determined
by the channel name. Right? Is it possible to make use of the
filter-function specified to the dma_request_slave_channel_compat()
method?

-Serge(y)

> 
>  drivers/dma/dw/acpi.c     | 6 ++++--
>  drivers/dma/dw/internal.h | 8 ++++++++
>  drivers/dma/dw/pci.c      | 4 ++--
>  3 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/dw/acpi.c b/drivers/dma/dw/acpi.c
> index c510c109d2c3..b6452fffa657 100644
> --- a/drivers/dma/dw/acpi.c
> +++ b/drivers/dma/dw/acpi.c
> @@ -8,13 +8,15 @@
>  
>  static bool dw_dma_acpi_filter(struct dma_chan *chan, void *param)
>  {
> +	struct dw_dma *dw = to_dw_dma(chan->device);
> +	struct dw_dma_chip_pdata *data = dev_get_drvdata(dw->dma.dev);
>  	struct acpi_dma_spec *dma_spec = param;
>  	struct dw_dma_slave slave = {
>  		.dma_dev = dma_spec->dev,
>  		.src_id = dma_spec->slave_id,
>  		.dst_id = dma_spec->slave_id,
> -		.m_master = 0,
> -		.p_master = 1,
> +		.m_master = data->m_master,
> +		.p_master = data->p_master,
>  	};
>  
>  	return dw_dma_filter(chan, &slave);
> diff --git a/drivers/dma/dw/internal.h b/drivers/dma/dw/internal.h
> index 779b3cbcf30d..99d9f61b2254 100644
> --- a/drivers/dma/dw/internal.h
> +++ b/drivers/dma/dw/internal.h
> @@ -51,11 +51,15 @@ struct dw_dma_chip_pdata {
>  	int (*probe)(struct dw_dma_chip *chip);
>  	int (*remove)(struct dw_dma_chip *chip);
>  	struct dw_dma_chip *chip;
> +	u8 m_master;
> +	u8 p_master;
>  };
>  
>  static __maybe_unused const struct dw_dma_chip_pdata dw_dma_chip_pdata = {
>  	.probe = dw_dma_probe,
>  	.remove = dw_dma_remove,
> +	.m_master = 0,
> +	.p_master = 1,
>  };
>  
>  static const struct dw_dma_platform_data idma32_pdata = {
> @@ -72,6 +76,8 @@ static __maybe_unused const struct dw_dma_chip_pdata idma32_chip_pdata = {
>  	.pdata = &idma32_pdata,
>  	.probe = idma32_dma_probe,
>  	.remove = idma32_dma_remove,
> +	.m_master = 0,
> +	.p_master = 0,
>  };
>  
>  static const struct dw_dma_platform_data xbar_pdata = {
> @@ -88,6 +94,8 @@ static __maybe_unused const struct dw_dma_chip_pdata xbar_chip_pdata = {
>  	.pdata = &xbar_pdata,
>  	.probe = idma32_dma_probe,
>  	.remove = idma32_dma_remove,
> +	.m_master = 0,
> +	.p_master = 0,
>  };
>  
>  int dw_dma_fill_pdata(struct device *dev, struct dw_dma_platform_data *pdata);
> diff --git a/drivers/dma/dw/pci.c b/drivers/dma/dw/pci.c
> index adf2d69834b8..a3aae3d1c093 100644
> --- a/drivers/dma/dw/pci.c
> +++ b/drivers/dma/dw/pci.c
> @@ -56,10 +56,10 @@ static int dw_pci_probe(struct pci_dev *pdev, const struct pci_device_id *pid)
>  	if (ret)
>  		return ret;
>  
> -	dw_dma_acpi_controller_register(chip->dw);
> -
>  	pci_set_drvdata(pdev, data);
>  
> +	dw_dma_acpi_controller_register(chip->dw);
> +
>  	return 0;
>  }
>  
> -- 
> 2.43.0.rc1.1336.g36b5255a03ac
> 

