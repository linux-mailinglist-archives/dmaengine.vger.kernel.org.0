Return-Path: <dmaengine+bounces-3331-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BA9999270
	for <lists+dmaengine@lfdr.de>; Thu, 10 Oct 2024 21:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A7651F229A0
	for <lists+dmaengine@lfdr.de>; Thu, 10 Oct 2024 19:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1781B1CDFC2;
	Thu, 10 Oct 2024 19:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPvaLoCl"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4475A199E9B;
	Thu, 10 Oct 2024 19:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728588988; cv=none; b=aP76y1T7xaxqSWHK9xLcDPKGrt1Sfu2nkqEDcKOXqNSljmHfM6MqcgY/2/G5Nk9Bi2z8efJOil8UcpsRZkrr2WTLP/bAiUsdEjPxSetAviujiHWNBvxnDUnlnMXMFuwWgRApoeAgnqkuWVSKFIYSQ8Pqic7qdqqU3Ll24/b+PpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728588988; c=relaxed/simple;
	bh=V1FBsKi8p2h+u02jp8A26jsOKSKbITtx6QiKC0rMHyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gO4YUYvguzQi6KJqMPLTh1AZrCn2E+Zze7g1TOArOJ991SXqAFpe5tAoZBuGYFNLIzu7zjQ2OhApjL2j+hOKX9D6b2GaY0B4iTWX0qJXA3Q3ndm5AYcAHfR3V+of9M8yBB9k9VCoFSeoCu5eRMmIymdOhU/hezZ4iCsmVzX/8SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPvaLoCl; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fad100dd9eso14146651fa.3;
        Thu, 10 Oct 2024 12:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728588984; x=1729193784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sCZwKZXicxFc7OhOZXCMaFWfzpYZ6T6Z1WpwxTO5gBc=;
        b=dPvaLoCl2Jl04SADfjr+5EpHSU6waz2+2K2t2tT6rWBn58P5Bj0TCNbYWBDJMBV/5v
         vTOXKHDTcv8ekWSRcSp+Qov8e+FYVd2l5Af+y7GVnfSBFxj/K9tTFRk20ChbGXZ2lM5h
         mIakOAE+7I6lq8t8aZEBZ00nofrdoCv9yK1wOQzYNUoZcwwTj3owTVlVqCP7BWCvbjZH
         uUAMPlnoGmjUBrxXvoC/NpsQCErWkk5AxMj76DdNZJ6ZS8SyNm2Sk5WMFVK8ucE2twRH
         gGoinb2W8BO12m4jMzE6GHZONMspjDAxjReX2UQ/zUOJZ7/HcgGHZtj9LH8IZAZstyxK
         9/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728588984; x=1729193784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCZwKZXicxFc7OhOZXCMaFWfzpYZ6T6Z1WpwxTO5gBc=;
        b=VYzPSi/VLwmz5VhqiCvBa1sRX1XpDFnKXR0Wptag0bHYnHzaR24UdSbzPq0L44KDds
         SBk8FL9hr08cyAzODpjgpPIeKI4MhrkrMfKKlBM+vt51ek6LYSKY0IY/cwNMd6LzYQ+y
         FjZdH6XxVmmWRDLMh3AUnMZw/dZdNtKRIg9aeqD5+MUszbmEBDo3tLrL/yB2VhJhPi6J
         UEFLTutHnbt+yeezGz+tPLGfJr3rvzZp7/7t6/pQVWFk+NdmwofiqewcuSpvVUXU5xb6
         LGsinwWf3y0DyTSgkV4B61XQbcg+COQtIuBsixNwaJOuVIXHMCCdnJv3mQnsJFfG0Txg
         GvMg==
X-Forwarded-Encrypted: i=1; AJvYcCUuMPZYJYffomVTjiFcrJZXBrizjfmTukUCX8XFIMsXisoU2YyqLu9ncmuGx+wak37AN+x44M4j5ncDjzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzgRucrLxKkeXv9jHu/Fajmn0KLezC4W5PPvtlKDMLERFhvib3
	B66sviuCvSTpl7EL7ufMcbSGjhLhqvNrRJzXtFoGERlCVHXSgZ/n
X-Google-Smtp-Source: AGHT+IHVmzYRX3C1DeLNjIW8k0ByRI/oRBSbBG/kBdedX4hnOk5riP21cnFr14H1noAhf1FSwE0lVA==
X-Received: by 2002:a05:651c:4ca:b0:2fb:dc2:21ea with SMTP id 38308e7fff4ca-2fb24edb97emr14476201fa.19.1728588983854;
        Thu, 10 Oct 2024 12:36:23 -0700 (PDT)
Received: from mobilestation ([85.249.18.22])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb24772be8sm3067291fa.137.2024.10.10.12.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 12:36:22 -0700 (PDT)
Date: Thu, 10 Oct 2024 22:36:18 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v1 1/1] dmaengine: dw: Switch to LATE_SIMPLE_DEV_PM_OPS()
Message-ID: <kg3uelu7772lk74p7rwxs72qo6pvzny2mkyxgocamcc2b4delr@x3qll3y3vhhz>
References: <20241007150912.2183805-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007150912.2183805-1-andriy.shevchenko@linux.intel.com>

On Mon, Oct 07, 2024 at 06:09:12PM GMT, Andy Shevchenko wrote:
> SET_LATE_SYSTEM_SLEEP_PM_OPS is deprecated, replace it with
> LATE_SYSTEM_SLEEP_PM_OPS() and use pm_sleep_ptr() for setting
> the driver's pm routines. We can now remove the ifdeffery
> in the suspend and resume functions.

Nice clean up. Thanks!
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/dma/dw/pci.c      | 8 ++------
>  drivers/dma/dw/platform.c | 8 ++------
>  2 files changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/dma/dw/pci.c b/drivers/dma/dw/pci.c
> index e8a0eb81726a..a3aae3d1c093 100644
> --- a/drivers/dma/dw/pci.c
> +++ b/drivers/dma/dw/pci.c
> @@ -76,8 +76,6 @@ static void dw_pci_remove(struct pci_dev *pdev)
>  		dev_warn(&pdev->dev, "can't remove device properly: %d\n", ret);
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
> -
>  static int dw_pci_suspend_late(struct device *dev)
>  {
>  	struct dw_dma_chip_pdata *data = dev_get_drvdata(dev);
> @@ -94,10 +92,8 @@ static int dw_pci_resume_early(struct device *dev)
>  	return do_dw_dma_enable(chip);
>  };
>  
> -#endif /* CONFIG_PM_SLEEP */
> -
>  static const struct dev_pm_ops dw_pci_dev_pm_ops = {
> -	SET_LATE_SYSTEM_SLEEP_PM_OPS(dw_pci_suspend_late, dw_pci_resume_early)
> +	LATE_SYSTEM_SLEEP_PM_OPS(dw_pci_suspend_late, dw_pci_resume_early)
>  };
>  
>  static const struct pci_device_id dw_pci_id_table[] = {
> @@ -136,7 +132,7 @@ static struct pci_driver dw_pci_driver = {
>  	.probe		= dw_pci_probe,
>  	.remove		= dw_pci_remove,
>  	.driver	= {
> -		.pm	= &dw_pci_dev_pm_ops,
> +		.pm	= pm_sleep_ptr(&dw_pci_dev_pm_ops),
>  	},
>  };
>  
> diff --git a/drivers/dma/dw/platform.c b/drivers/dma/dw/platform.c
> index 47c58ad468cb..bf86c34285f3 100644
> --- a/drivers/dma/dw/platform.c
> +++ b/drivers/dma/dw/platform.c
> @@ -157,8 +157,6 @@ static const struct acpi_device_id dw_dma_acpi_id_table[] = {
>  MODULE_DEVICE_TABLE(acpi, dw_dma_acpi_id_table);
>  #endif
>  
> -#ifdef CONFIG_PM_SLEEP
> -
>  static int dw_suspend_late(struct device *dev)
>  {
>  	struct dw_dma_chip_pdata *data = dev_get_drvdata(dev);
> @@ -183,10 +181,8 @@ static int dw_resume_early(struct device *dev)
>  	return do_dw_dma_enable(chip);
>  }
>  
> -#endif /* CONFIG_PM_SLEEP */
> -
>  static const struct dev_pm_ops dw_dev_pm_ops = {
> -	SET_LATE_SYSTEM_SLEEP_PM_OPS(dw_suspend_late, dw_resume_early)
> +	LATE_SYSTEM_SLEEP_PM_OPS(dw_suspend_late, dw_resume_early)
>  };
>  
>  static struct platform_driver dw_driver = {
> @@ -195,7 +191,7 @@ static struct platform_driver dw_driver = {
>  	.shutdown       = dw_shutdown,
>  	.driver = {
>  		.name	= DRV_NAME,
> -		.pm	= &dw_dev_pm_ops,
> +		.pm	= pm_sleep_ptr(&dw_dev_pm_ops),
>  		.of_match_table = of_match_ptr(dw_dma_of_id_table),
>  		.acpi_match_table = ACPI_PTR(dw_dma_acpi_id_table),
>  	},
> -- 
> 2.43.0.rc1.1336.g36b5255a03ac
> 

