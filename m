Return-Path: <dmaengine+bounces-930-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C0C846E45
	for <lists+dmaengine@lfdr.de>; Fri,  2 Feb 2024 11:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C468298FD0
	for <lists+dmaengine@lfdr.de>; Fri,  2 Feb 2024 10:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C77128808;
	Fri,  2 Feb 2024 10:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOXD2IKQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E45422067;
	Fri,  2 Feb 2024 10:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706871054; cv=none; b=I0k4byhEl8BhRIIiEAFRCx6XxxUOipDtaUopB0pr+krPp5PJ3356mO+dVuNUVv7tNRq/QOVX4iIidgPyAuZtKmaJUSxmGYwq5nnv0pqZ36bz+0ZAgU+P5sYtBwX5zg9FVcbqnh7dKefqH2eShdBtKGNeGO15Yhh0tZS6TIg/gu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706871054; c=relaxed/simple;
	bh=EU60AJ/wPOUddPzydcM0wLpZPFMiP7dkEkSpksaeKT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sx6p8NlTbN0qyPXlg8BDJgrSv2hx29AAKHrtOaZv3eEwDe3sO0iUivQgoyVaF2oHn7cBRa31oFqQ8S5QJQbFk1AENLBitYRikixNl+OGFtFCTLZ7hRTDoXiLE2/CKxd7IsBGXKB8y4iSOJ94bPLJT6LhyBx/7KuX7zH2sc7sTX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOXD2IKQ; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5113303e664so1295711e87.0;
        Fri, 02 Feb 2024 02:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706871050; x=1707475850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ezetAdrGUzi80LfrZYbUgN2AgU2wxiaRJ4LeWUJ80vI=;
        b=VOXD2IKQaa0qmE7HlLGUcC+PZU7Yf+3rNY32GFLhKpRR9Zy5xcyLYYdMC/WVjisBng
         A/2pYp2SVcvO+Plwj099bBdstcgHVtfr8IQUs4KVvFKFCq1tE/gYaNzvknBM46arfFRS
         fxv79brTco8grpW5ZuUiKObYpvTljNNXHZyIyhZKEkijtfS6JOu5PyxyUi8QYAItxXMq
         mqFQzwO8BNGRaO5hwAm0+Vc3UZXARfNPvCnfKoNoMWgVshwkERETsd7fraXR0Y4o46T6
         iSWA8F3+tH/8pP7PaQGAQCAcRTg0hI0++ffv0kIxVQx74P/oHtIsceRFyarBeJxRq4JS
         Y1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706871050; x=1707475850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezetAdrGUzi80LfrZYbUgN2AgU2wxiaRJ4LeWUJ80vI=;
        b=wj+ddnZnkmuAxkCbUIrErIaLN8sFCeYMuog7jecNDBVOvMkbCGfE7QhE7mnRFm1Ioh
         u4I7OJr8q1Aw99vLVoqFak5jwtt10JIzj5rzfBM6KLJvl5RtrxvwM9rMIRhaxLT5d/ok
         em3IPKUM7aIkiU7wEAvjpnKw+gJ+AH423wls/h0Uj4rzGliEYc+kTuA2EyOup4zd8TGT
         uoJV2ehWy25tleNiSw0FsRWsrstbzf23Oy6jdb5xAaA2rXrGRrPLRwMNE2TwHxeg67AZ
         YX8GAzHtoUIWUJNH03BLpD0dJ70KPLEjDoXrdKi8Ikx6exqaW3DrdcotFZP3iYHAlk7d
         Fu2Q==
X-Gm-Message-State: AOJu0YzawIYQOP00/GBbhYvLYqHEsLr0eZLyNbC6L9SFzlrO9K8LPAqe
	SzakoYHmN7krgILXfjDsSAVmSBqNbP5Cb8eeF+bKac+XIyztcOB1
X-Google-Smtp-Source: AGHT+IFY7jsnsgdzXAniUyhH+YrHZWSG4wTqXL2QlAUjlS9x8Z4+/xFbrmQQNMg3zLD4lMrXE5cjdw==
X-Received: by 2002:a05:6512:3482:b0:511:2e09:932a with SMTP id v2-20020a056512348200b005112e09932amr2955145lfr.41.1706871050260;
        Fri, 02 Feb 2024 02:50:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWj5ayWlnGWMF9RRgGQCgfJQbV9I/DbvuUKLSCAWq2E12OaHxHBPZ/rXf4JAAyKIGHNwf0pSFtjjP7tB8c0MaFozEwdtSjwEO0W455NWXoHb6R7R6wV3BN6rU5l9R2Qusn4YmAGq+gqjIvRKFvZ6W5cU9ikwMW8cxyy43gQHMWZ0sfJENwJ49WcH9jWeqaSN9ykTqbZOque/PJ5jscp/LRhASU18wRP3haiz9jRZEbRejkXHXtC92sAd7jIgw7opJEfORBQUFJs9DDjH3xPvmt4iQmqDjPZK393DJvcskFgd5QfYQnEjcUTWaJXRuhpQ8WMU+8zTtnLtD4Jp5LQ5up75cdX6N4DhKCCpHehb2QR8ObSjuAr6KDU0zIlAmt9jFCx9L6S0Twsh27Incm8518G4YFXA7+oydGqMAsls+5bIBzdbC8IRTNFhsrTh940mFyMNxLaxff0I4CWvsYTKq2JOysZ4H+RlgQn3TyyVX7n4NlBywQBwURGw7TimJc76siAPdV08SQA7abdNKVG59JMjOSVaBz6C1tGCMUQPFcL03sPplDC13pNHNe2z1pUAX8GvVxGS0+ZC9rdxmQM3FIuRY47iTEb1OU8SKRdJN/xLVYswAC1ZsEXEEEj3yc+sQX+gkZVVPhiXQQ1NfdKCYM3GTBswjiRNScimpk+52OT+6jjeGEy6UyWfFd8/QV8npV7yvldCGfNhWd3l34aEbltlGf061qmonQ7Ul8XSsXpbdLflft3BlnV6bUUXW1VwOcH4HFdInpDYb7TpbZHygr/6/hv+zYgDFKLgCOFiQd86fq24YrWbdN6Bs+BNcG25foLwVVkrMOnUbNe9DJQbH8FFmIznOiqJBV5mhFMyLYnH7YG0ghtQkUxIzHcPTaWnqQgW/1g1IQbhOPuBqucDmYHaD6N3hwr0dAE
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id d10-20020ac24c8a000000b0051121bedf76sm209502lfl.34.2024.02.02.02.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 02:50:49 -0800 (PST)
Date: Fri, 2 Feb 2024 13:50:47 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc: vkoul@kernel.org, jingoohan1@gmail.com, conor+dt@kernel.org, 
	konrad.dybcio@linaro.org, manivannan.sadhasivam@linaro.org, robh+dt@kernel.org, 
	quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com, 
	quic_nayiluri@quicinc.com, dmitry.baryshkov@linaro.org, quic_krichai@quicinc.com, 
	quic_vbadigan@quicinc.com, quic_parass@quicinc.com, quic_schintav@quicinc.com, 
	quic_shijjose@quicinc.com, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev
Subject: Re: [PATCH v1 1/6] dmaengine: dw-edma: Pass 'struct dw_edma_chip' to
 irq_vector()
Message-ID: <vlllubkhvya3po7xdxqrb555vox6xwbrujn3ekyka7rbtrhaum@uqvkofe3zlat>
References: <1705669223-5655-1-git-send-email-quic_msarkar@quicinc.com>
 <1705669223-5655-2-git-send-email-quic_msarkar@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1705669223-5655-2-git-send-email-quic_msarkar@quicinc.com>

On Fri, Jan 19, 2024 at 06:30:17PM +0530, Mrinmay Sarkar wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> eDMA client drivers defining the irq_vector() callback need to access the
> members of dw_edma_chip structure. So let's pass that pointer instead.

See my comment to the patch 4:
https://lore.kernel.org/linux-pci/qfdsnz7louqdrs6mhz72o6mzjo66kw63vtlhgpz6hgqfyyzyhq@tge3r7mvwtw3/

-Serge(y)

> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> ---
>  drivers/dma/dw-edma/dw-edma-core.c           | 11 +++++------
>  drivers/dma/dw-edma/dw-edma-pcie.c           |  4 ++--
>  drivers/pci/controller/dwc/pcie-designware.c |  4 ++--
>  include/linux/dma/edma.h                     |  3 ++-
>  4 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 6823624..7fe1c19 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -849,7 +849,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
>  
>  	if (chip->nr_irqs == 1) {
>  		/* Common IRQ shared among all channels */
> -		irq = chip->ops->irq_vector(dev, 0);
> +		irq = chip->ops->irq_vector(chip, 0);
>  		err = request_irq(irq, dw_edma_interrupt_common,
>  				  IRQF_SHARED, dw->name, &dw->irq[0]);
>  		if (err) {
> @@ -874,7 +874,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
>  		dw_edma_add_irq_mask(&rd_mask, *rd_alloc, dw->rd_ch_cnt);
>  
>  		for (i = 0; i < (*wr_alloc + *rd_alloc); i++) {
> -			irq = chip->ops->irq_vector(dev, i);
> +			irq = chip->ops->irq_vector(chip, i);
>  			err = request_irq(irq,
>  					  i < *wr_alloc ?
>  						dw_edma_interrupt_write :
> @@ -895,7 +895,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
>  
>  err_irq_free:
>  	for  (i--; i >= 0; i--) {
> -		irq = chip->ops->irq_vector(dev, i);
> +		irq = chip->ops->irq_vector(chip, i);
>  		free_irq(irq, &dw->irq[i]);
>  	}
>  
> @@ -975,7 +975,7 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>  
>  err_irq_free:
>  	for (i = (dw->nr_irqs - 1); i >= 0; i--)
> -		free_irq(chip->ops->irq_vector(dev, i), &dw->irq[i]);
> +		free_irq(chip->ops->irq_vector(chip, i), &dw->irq[i]);
>  
>  	return err;
>  }
> @@ -984,7 +984,6 @@ EXPORT_SYMBOL_GPL(dw_edma_probe);
>  int dw_edma_remove(struct dw_edma_chip *chip)
>  {
>  	struct dw_edma_chan *chan, *_chan;
> -	struct device *dev = chip->dev;
>  	struct dw_edma *dw = chip->dw;
>  	int i;
>  
> @@ -997,7 +996,7 @@ int dw_edma_remove(struct dw_edma_chip *chip)
>  
>  	/* Free irqs */
>  	for (i = (dw->nr_irqs - 1); i >= 0; i--)
> -		free_irq(chip->ops->irq_vector(dev, i), &dw->irq[i]);
> +		free_irq(chip->ops->irq_vector(chip, i), &dw->irq[i]);
>  
>  	/* Deregister eDMA device */
>  	dma_async_device_unregister(&dw->dma);
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 1c60437..2b13725 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -90,9 +90,9 @@ static const struct dw_edma_pcie_data snps_edda_data = {
>  	.rd_ch_cnt			= 2,
>  };
>  
> -static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
> +static int dw_edma_pcie_irq_vector(struct dw_edma_chip *chip, unsigned int nr)
>  {
> -	return pci_irq_vector(to_pci_dev(dev), nr);
> +	return pci_irq_vector(to_pci_dev(chip->dev), nr);
>  }
>  
>  static u64 dw_edma_pcie_address(struct device *dev, phys_addr_t cpu_addr)
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 250cf7f..eca047a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -858,9 +858,9 @@ static u32 dw_pcie_readl_dma(struct dw_pcie *pci, u32 reg)
>  	return val;
>  }
>  
> -static int dw_pcie_edma_irq_vector(struct device *dev, unsigned int nr)
> +static int dw_pcie_edma_irq_vector(struct dw_edma_chip *edma, unsigned int nr)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> +	struct platform_device *pdev = to_platform_device(edma->dev);
>  	char name[6];
>  	int ret;
>  
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index 3080747..7197a58 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -16,6 +16,7 @@
>  #define EDMA_MAX_RD_CH                                  8
>  
>  struct dw_edma;
> +struct dw_edma_chip;
>  
>  struct dw_edma_region {
>  	u64		paddr;
> @@ -41,7 +42,7 @@ struct dw_edma_region {
>   *			automatically.
>   */
>  struct dw_edma_plat_ops {
> -	int (*irq_vector)(struct device *dev, unsigned int nr);
> +	int (*irq_vector)(struct dw_edma_chip *chip, unsigned int nr);
>  	u64 (*pci_address)(struct device *dev, phys_addr_t cpu_addr);
>  };
>  
> -- 
> 2.7.4
> 

