Return-Path: <dmaengine+bounces-3212-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CB5984B6F
	for <lists+dmaengine@lfdr.de>; Tue, 24 Sep 2024 21:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 921BEB21F80
	for <lists+dmaengine@lfdr.de>; Tue, 24 Sep 2024 19:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4735480043;
	Tue, 24 Sep 2024 19:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j24V+Ywm"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557CE8C1A;
	Tue, 24 Sep 2024 19:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727204845; cv=none; b=olhZHCKWqqV3GjrOUQAMzpVaFXPLPTYRXJRcPCwus7tcG8jC+wILGSCBnhEJMpGwEIGaEBShalsp7YAfqnyc/NT9NbdwiqdxSReiVoEfYvGUcvNFcnNYjQlt6tayCKumWfBdPVSRZGa50oM90ZO05Zs61C77KgcCs5ssOyxwVGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727204845; c=relaxed/simple;
	bh=nJbmR+xL2BQa3HaKO/EyCb2/CvS+m2cc5H/lZldfiWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n0/9Q/IAmtl/s6cVxUW9/+5GIcK98U/gXvaGcRtJChjb1Omse9rJEEyinpxUK6yXSNA+0MuKfV/Hwa1F8pEFCkDwcX+x1W5nZJtzzAcxQ4gPjQuPkHGFbgme5Zd+4dnbeu9H1jiRaCRNkTOvRKFVbZhZvI5yGZ3LSP5Dgl70qEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j24V+Ywm; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f75f116d11so59576681fa.1;
        Tue, 24 Sep 2024 12:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727204841; x=1727809641; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SAaH1NEwA9lOj6mrZXQD3aHN2nJjKeYxfLBQMiilRl8=;
        b=j24V+YwmgeHpRkhHbz8Gakww51d0XC1tTaCaViab2F5Yytc5kIrf5FK+vYeThYvdUj
         gJWAmywMW6k959TfKhyoxJLjQtkIqXkZ6nGbInpTpOjuB1qIhhOx1osqIcjwSnH/dx6w
         k9GQpCtrq1yPKjebvf88nT6Jv7YZK6iTsR77ZF6QJtzjJ/gjntpFU2kt9tsmgli6R6BT
         kseS1n2PLypd5b+eFtUfzmYhmMMgRGfw+cM/SEovKS1g/x7Wn+sKY00Kvm9B66VnfDDs
         lPwbkPY8GBHHhN8LHNp1lmabe8c/i6YCoGdQsJDsyHiz+FU3XOVl2t5wfIIzRrJSwNkH
         XF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727204841; x=1727809641;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SAaH1NEwA9lOj6mrZXQD3aHN2nJjKeYxfLBQMiilRl8=;
        b=M6LAMzk/HYvlUcM1E/eyHZycpgaX2wUu/dW4OCXNU+SyB53fBlEbnzLT+3VG49osT7
         XNldwmsgNXJMgpfhjeJEtq6vrrdYs3pJENDS8cg9StAeDudRvgQXGe9hzCQU8kGnWGfM
         conb2gUXyUp+XpqPo33HEqUchVrhDFH8Q6sxp93tpbGa0ZOwseKOSEx+4H8YXHBx+AO0
         kvMGl38iQwbFFeuH5kYODb/33lECu4JpT9a+8XIUpO8Ecwcxl6G5erS3UqKv2pEzzhZn
         y9yd7sJEp72l8Eal98a2cgyIQNNgMP6s92idI57/JKHKW4fO1Zrdi7BeuZAXmwwqlOay
         LsSg==
X-Forwarded-Encrypted: i=1; AJvYcCU96GJ/r6TnPw2zgDEMjNEzEOkzlCkDdA50N9m1oo2BK8fhgfOwgqXT7kjDNpOe9orKK7EHnb4jO3IBvdsY@vger.kernel.org, AJvYcCV+VQvdLbvg2OeBukFS5Od70hSlDuwsYezadMD9bc4+zFfOpTWQ8Uh4aKJoyeiDj2ItnCkvbs3y@vger.kernel.org, AJvYcCXXfT5ITfU09Z2zFHkBP0KytfgJYu3I3rPlusvrJLq8cvkeVZOvNunESSAphMGKqcP/k5maSsHFskk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3jLgg+VS78wLJSI+vFhy5Y+1yBlU/veSW5jayYDClCe8oQIXN
	zFkpRWGxTn/64e8mZxtE8U6yDLKwkvjjI0J7gVZJNMLizrmT/TyT
X-Google-Smtp-Source: AGHT+IGW+FPRFXS7Qejs1TqprRdEg80hXsFE8A7Qb5Mo08LGXjik0xl4AeSzj1yidjaHSObrSIXAog==
X-Received: by 2002:a05:651c:211d:b0:2f1:5561:4b66 with SMTP id 38308e7fff4ca-2f91ca733efmr2305391fa.44.1727204841002;
        Tue, 24 Sep 2024 12:07:21 -0700 (PDT)
Received: from ?IPV6:2a02:a466:68ed:1:de6e:765:1390:c103? (2a02-a466-68ed-1-de6e-765-1390-c103.fixed6.kpn.net. [2a02:a466:68ed:1:de6e:765:1390:c103])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf49d23asm1071749a12.41.2024.09.24.12.07.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 12:07:20 -0700 (PDT)
Message-ID: <d6ebb78b-a369-4958-9ce1-8d0647d3410a@gmail.com>
Date: Tue, 24 Sep 2024 21:07:19 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] dmaengine: dw: Select only supported masters for
 ACPI devices
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Serge Semin <fancer.lancer@gmail.com>, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 stable@vger.kernel.org
References: <20240920155820.3340081-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Ferry Toth <fntoth@gmail.com>
In-Reply-To: <20240920155820.3340081-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Op 20-09-2024 om 17:56 schreef Andy Shevchenko:
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
>> [  164.525604] pxa2xx_spi_pci 0000:00:07.1: DMA slave config failed
>> [  164.536105] pxa2xx_spi_pci 0000:00:07.1: failed to get DMA TX descriptor
>> [  164.543213] spidev spi-SPT0001:00: SPI transfer failed: -16
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
> 
>   drivers/dma/dw/acpi.c     | 6 ++++--
>   drivers/dma/dw/internal.h | 8 ++++++++
>   drivers/dma/dw/pci.c      | 4 ++--
>   3 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/dw/acpi.c b/drivers/dma/dw/acpi.c
> index c510c109d2c3..b6452fffa657 100644
> --- a/drivers/dma/dw/acpi.c
> +++ b/drivers/dma/dw/acpi.c
> @@ -8,13 +8,15 @@
>   
>   static bool dw_dma_acpi_filter(struct dma_chan *chan, void *param)
>   {
> +	struct dw_dma *dw = to_dw_dma(chan->device);
> +	struct dw_dma_chip_pdata *data = dev_get_drvdata(dw->dma.dev);
>   	struct acpi_dma_spec *dma_spec = param;
>   	struct dw_dma_slave slave = {
>   		.dma_dev = dma_spec->dev,
>   		.src_id = dma_spec->slave_id,
>   		.dst_id = dma_spec->slave_id,
> -		.m_master = 0,
> -		.p_master = 1,
> +		.m_master = data->m_master,
> +		.p_master = data->p_master,
>   	};
>   
>   	return dw_dma_filter(chan, &slave);
> diff --git a/drivers/dma/dw/internal.h b/drivers/dma/dw/internal.h
> index 779b3cbcf30d..99d9f61b2254 100644
> --- a/drivers/dma/dw/internal.h
> +++ b/drivers/dma/dw/internal.h
> @@ -51,11 +51,15 @@ struct dw_dma_chip_pdata {
>   	int (*probe)(struct dw_dma_chip *chip);
>   	int (*remove)(struct dw_dma_chip *chip);
>   	struct dw_dma_chip *chip;
> +	u8 m_master;
> +	u8 p_master;
>   };
>   
>   static __maybe_unused const struct dw_dma_chip_pdata dw_dma_chip_pdata = {
>   	.probe = dw_dma_probe,
>   	.remove = dw_dma_remove,
> +	.m_master = 0,
> +	.p_master = 1,
>   };
>   
>   static const struct dw_dma_platform_data idma32_pdata = {
> @@ -72,6 +76,8 @@ static __maybe_unused const struct dw_dma_chip_pdata idma32_chip_pdata = {
>   	.pdata = &idma32_pdata,
>   	.probe = idma32_dma_probe,
>   	.remove = idma32_dma_remove,
> +	.m_master = 0,
> +	.p_master = 0,
>   };
>   
>   static const struct dw_dma_platform_data xbar_pdata = {
> @@ -88,6 +94,8 @@ static __maybe_unused const struct dw_dma_chip_pdata xbar_chip_pdata = {
>   	.pdata = &xbar_pdata,
>   	.probe = idma32_dma_probe,
>   	.remove = idma32_dma_remove,
> +	.m_master = 0,
> +	.p_master = 0,
>   };
>   
>   int dw_dma_fill_pdata(struct device *dev, struct dw_dma_platform_data *pdata);
> diff --git a/drivers/dma/dw/pci.c b/drivers/dma/dw/pci.c
> index adf2d69834b8..a3aae3d1c093 100644
> --- a/drivers/dma/dw/pci.c
> +++ b/drivers/dma/dw/pci.c
> @@ -56,10 +56,10 @@ static int dw_pci_probe(struct pci_dev *pdev, const struct pci_device_id *pid)
>   	if (ret)
>   		return ret;
>   
> -	dw_dma_acpi_controller_register(chip->dw);
> -
>   	pci_set_drvdata(pdev, data);
>   
> +	dw_dma_acpi_controller_register(chip->dw);
> +
>   	return 0;
>   }
>   
Tested-by: Ferry Toth <fntoth@gmail.com> (Intel Edison-Arduino)

