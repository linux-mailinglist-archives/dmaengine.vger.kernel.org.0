Return-Path: <dmaengine+bounces-3764-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B739D5539
	for <lists+dmaengine@lfdr.de>; Thu, 21 Nov 2024 23:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E731B1F22B6B
	for <lists+dmaengine@lfdr.de>; Thu, 21 Nov 2024 22:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00341DDA34;
	Thu, 21 Nov 2024 22:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H9P1RY7q"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AD21DC1BA
	for <dmaengine@vger.kernel.org>; Thu, 21 Nov 2024 22:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732227043; cv=none; b=ZHfNYcSTXCqDOzrXQtFH08E/+P2wzA4vniA8TnuRXDZ63PYDqXUOQAUPwnHTQkW8unF6VXj7eeddGrVxaqDNyFOX7KJPGhnZ/K+GiA9G85r0mKZ5SpdMIN6zRCF/DEa4qL8cvsRfJc3X3w9jy3ooMcSf/LdR0SRpfZgc8RCDS+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732227043; c=relaxed/simple;
	bh=yeWBaZyskmHQQzGoYf4eQzjnS5JlEV8qt70IgjYzCIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTLN57Rra1uuPz3f4u5GYK+VX3HysGqSRCYnJ5UcjLp4w0NJDPnCYSta6xvKyHEHKXxh4mh1cycTtlE/naAh3EnKHjrtmxIXdwp6blbuAu7CR0QTL1faEv50o9iT/WXH12n/uJRprl+eC/JDPYsyOl4vNjs2Zys5M7LLppOF17M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H9P1RY7q; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ffa12ad18cso11223161fa.2
        for <dmaengine@vger.kernel.org>; Thu, 21 Nov 2024 14:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732227040; x=1732831840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gFDuP7IjDwDMv6NR+DnprUqGpxBiP59fQ/sq6qPsJrg=;
        b=H9P1RY7qOTOzBIoE9oqgJcctr5IqJ9f3UvXdpcBOJrQ+nVf0lLCpWjh477uvHWFek6
         GyU8h2ELHq2Z3bMc47zDNEd79WT3cBbSUGXDV2djQlMm65J/kXFUkNlg1wU3Dtz0R5Wd
         5G2b8/aIRkJFmuwAcotlk1VyuJ43aCcl8b1nlQ4Ly3nfcfIOaJfMO3YoP0vw/xNJbElc
         QFw9qUhPOH90ZGVpph3XJiYDtXcUrUsjVEa14Ug9bKk2KoiaYzPUdsaTNxfvMfdH7FoT
         +qwyDMnMDRRcVGZIpqyT8K+DLrUUCIIGpgsYuv1UkA/0jSSNliFxe1LGWb4EtXbxVsFQ
         eT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732227040; x=1732831840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFDuP7IjDwDMv6NR+DnprUqGpxBiP59fQ/sq6qPsJrg=;
        b=jQDjbJjGJB36iiaOf6094cci1HxPHB9BEAdlaagtb1ttiEzwJGovxfEeN3ayCmFM3S
         sHOEOzBdO5+IL9M45WGfV8cS87Vf5r8NQ7eFchL5LlBYxpPhZFUwH9WjWN8gjRMaV4c2
         1RDw+UMHfe4jqATQSQ62eJIExnCxGXVTBPzweGDFe2LxKDkBRRBq+8aRGLJwBhakK2DH
         u2ViqXqmvSbzF1wGYdLFM/N4RgArZwhswDytllslwhkC9sJxBFIJH//2TtxMzXRa+/HS
         Lu9ZE0MmhV9BIKbXZlUZVH8hPXZNv5sO4cn5vytLavYQ2gZy4Z6kXnwm4sRCrGGwgmXG
         ioZA==
X-Forwarded-Encrypted: i=1; AJvYcCVi5pTnRdI517qvTmms6cLAi4IzRpMufvAae4MscGEnveoWx+fqXGyOed5nYzSWM5+Rv/CUJ9utZoU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv8Sjantz/VKhBUh0LR8aBqZnjwz5BGASLZQ1i/WHuy72oHwha
	UrO5mSkZxwEoiJVubZgJWZoZgsPPojCh8ZmhY97TC6cS8xEFtWxRa1ZgICPJFpc=
X-Gm-Gg: ASbGncvO8aEHGWompZIJcFg9Mme9URYj/cfWLXhtnvgWdb2ezhA8atrJ7tbw3XloAeq
	Wh395VYd248ou5wYVaiJgakxs+EG9RPvyzFcT/RlwIh82dxTNjp+AqAx1qGgRjrt3nVp8NWSSZm
	XYPDYeRCwrXWpg/NL8l3k/TemqZVcWQ6mv9lCeuUVQZQydxEJwdjf52I+v0fhxGK3MeU84Og0gt
	TjHl6xeORuy00affftQG/RWPvDxooefJXUrJqTbWhzMrwphVRLjajt3Olw8VACWoVJ96faxW+tf
	kFfFJMQdMjonfya94uG/ZRobR1LVOg==
X-Google-Smtp-Source: AGHT+IF5UEvVH8EwlVFvDbA8yqDXP2EnIvz85XTHp+jyVxMS03tfkpla0bwll8dc1ETCUfCWi+KKfg==
X-Received: by 2002:a05:651c:2208:b0:2f4:3de7:ac4c with SMTP id 38308e7fff4ca-2ffa70f0968mr1996351fa.8.1732227039935;
        Thu, 21 Nov 2024 14:10:39 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffa538f100sm593151fa.103.2024.11.21.14.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 14:10:38 -0800 (PST)
Date: Fri, 22 Nov 2024 00:10:36 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com
Subject: Re: [PATCH v3 3/3] i2c: i2c-qcom-geni: Update compile dependenices
 for I2C GENI driver
Message-ID: <zfkhbjm6wrmcocqcvluov3nbrpb2ozbo52c6nlwxro44gublcw@5645ksz4cfm2>
References: <20241121130134.29408-1-quic_jseerapu@quicinc.com>
 <20241121130134.29408-4-quic_jseerapu@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121130134.29408-4-quic_jseerapu@quicinc.com>

On Thu, Nov 21, 2024 at 06:31:34PM +0530, Jyothi Kumar Seerapu wrote:
> I2C functionality has dependencies on the GPI driver.
> Ensure that the GPI driver is enabled when using the I2C
> driver functionality.
> Therefore, update the I2C GENI driver to depend on the GPI driver.
> 
> Signed-off-by: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
> ---
> v2 -> v3:
>    - Moved this change to patch3.
>    - Updated commit description.
> 
> v1 -> v2:
>    -  This patch is added in v2 to address the kernel test robot
>       reported compilation error.
>       ERROR: modpost: "gpi_multi_desc_process" [drivers/i2c/busses/i2c-qcom-geni.ko] undefined!
> 
>  drivers/i2c/busses/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 0aa948014008..87634a682855 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -1049,6 +1049,7 @@ config I2C_QCOM_GENI
>  	tristate "Qualcomm Technologies Inc.'s GENI based I2C controller"
>  	depends on ARCH_QCOM || COMPILE_TEST
>  	depends on QCOM_GENI_SE
> +	depends on QCOM_GPI_DMA

So... without this change the previous patch is broken, which is a
no-go. And anyway, adding dependency onto a particular DMA driver is a
bad idea. Please make use of the DMA API instead.

>  	help
>  	  This driver supports GENI serial engine based I2C controller in
>  	  master mode on the Qualcomm Technologies Inc.'s SoCs. If you say
> -- 
> 2.17.1
> 

-- 
With best wishes
Dmitry

