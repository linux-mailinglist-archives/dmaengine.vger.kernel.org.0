Return-Path: <dmaengine+bounces-3352-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5969799DD91
	for <lists+dmaengine@lfdr.de>; Tue, 15 Oct 2024 07:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19AFC2836D4
	for <lists+dmaengine@lfdr.de>; Tue, 15 Oct 2024 05:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2F0175568;
	Tue, 15 Oct 2024 05:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s6IErQUx"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25138170828
	for <dmaengine@vger.kernel.org>; Tue, 15 Oct 2024 05:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728970573; cv=none; b=h7dfa+wvPQ4jJFjQoCJ9cnHv59NkUFVKDay+DLIpaNh2v/h5He+mkDbX7AdWdC9Z7XIZS3cOky45bQ7Qye+CHC+gUnnQCmUcqsnVvrEazTZsVLVsgCLpZbuGUmd7tHGAi9Ju6jUMzq3iQad4sppJr4ISFny8WYuhagae1Abw9ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728970573; c=relaxed/simple;
	bh=yszwKQ9Uc/WwDVgcbv1zceidlzSiESQI89BBRJB+3gA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0PL7yDXlu+mzy/rNQoMqW5fJRCwjnD4iWJTZSSDvNXuqUVep6pzFN0tcIUCgXY3FU7cvaDi+q4BDAzj7ZI9grgeR9Lm2lyBFq4PQhPI5hsIkiinXNnj4f/JdMJjIb4xoudvnsMCqRVMPAFtv6aE592LiD3VMteCGNA1LTZ09fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s6IErQUx; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ea12e0dc7aso3137469a12.3
        for <dmaengine@vger.kernel.org>; Mon, 14 Oct 2024 22:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728970571; x=1729575371; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GXgy8197OqSzaMzOs/kBSKtlaDYzOu3RBo5ZvMdUY68=;
        b=s6IErQUxrsbeD52exQ6LC/Ir/5H2cS8Dd6+Q8IqUwIdx3HhIdgPSeKD851TQ4fOI5y
         Ppjp8+kDOSWY2pqiKP6Py6pDauEpUtq+5dqm9TR8o7+wFp7k22TiiLUEplMQ2/JzZnhf
         HbsqGHJKW4bse/WNSISBYbnUijHNXOXqcrWletzr+5NycNpjU682geizqihyI4fz/O0H
         nHMo4Ls1vt+TLD2cOcUSvr7t+fg6Y5ruo3ntGT3svsLawhwbedN8ROeI+o6slZjF94W2
         lKW4Eyr5hncbcWx3d/NnPMKtsSFunb3lJf25oJHGe1wmQd2zT9J50UicosIagfc1nN4V
         G+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728970571; x=1729575371;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GXgy8197OqSzaMzOs/kBSKtlaDYzOu3RBo5ZvMdUY68=;
        b=nh6GxtBz4wCq+eMOBw//N+fWVda2UU7ykPffk3o1KNY7CxM1w5ty5xkJuZrPPx70VG
         MFi+6gYwPihCc1i/SVqyl3HlsDcsfVDNApjI+Dfdoq+f4u/PfL4Crtv1yud6Wqrs5QYQ
         X4vFn69Bqc3wJ3Fq375QHQfCSqhChmFFa8OPLCFNGajlGB/9C/YMKdnp8DSaz0kuTvUf
         5bM/O7NTf4a6Uzd4WgFPX9dhTCYW/4fsqO1h+Dy4zMO06dF9UZ/XnNxAxjkfC5EWeuQU
         r5IOUQ88R5+bY31HNw/HyvHfFa7J9FxjTeD3q865FFFjd6l4G8ny8WZIYQW27V0MAw0Z
         CHTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8fISWyTqZ0BZ4zC5ypGEFg6KoxUXyWzeJvHT/+z46VM7YRxoGD7rrnEkCM683sZ148D5JYMPRuFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvn2dP4kABMpyVSqju8lpwNSVtf6lZP1b7LA3z9Ozwr92rg4LI
	sJXC1CGXPKUgH5ybPZBRiTGiOgvnSXSUHRm6gvfG5OPPXIIYvFs9fQDpTEuSwg==
X-Google-Smtp-Source: AGHT+IGfog2Fs+KHlICZ0Il/O7zt2ISKY4xDwFmjK7Hgr2698r5tPxk4iA9eMgOYKQ8Np1SqclTKcQ==
X-Received: by 2002:a05:6a20:d49b:b0:1d6:e5bf:f95a with SMTP id adf61e73a8af0-1d8c955c8f6mr17286863637.2.1728970571441;
        Mon, 14 Oct 2024 22:36:11 -0700 (PDT)
Received: from thinkpad ([220.158.156.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e774a2b20sm463266b3a.122.2024.10.14.22.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 22:36:11 -0700 (PDT)
Date: Tue, 15 Oct 2024 11:06:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: ChunyouTang <tangchunyou@163.com>
Cc: fancer.lancer@gmail.com, vkoul@kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma/dw-edma: chip regs base should add the offset
Message-ID: <20241015053608.h2avloxfak5yagyd@thinkpad>
References: <20241014134832.4505-1-tangchunyou@163.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241014134832.4505-1-tangchunyou@163.com>

On Mon, Oct 14, 2024 at 09:48:32PM +0800, ChunyouTang wrote:
> From: tangchunyou <tangchunyou@163.com>
> 
> fix the regs base with offset.
> 

Initially I thought that this patch is a spam, but it is not. It is indeed
fixing a real bug in the driver. But the subject and description made it look
like a spam. Please follow the process defined in:
Documentation/process/5.Posting.rst to send the patches.

Essentially you need to properly describe what the patch does and how it impacts
the driver etc... Then there needs to be a valid 'Fixes' tag and stable list
should be CCed to backport to stable kernels.

- Mani

> Signed-off-by: tangchunyou <tangchunyou@163.com>
> ---
>  drivers/dma/dw-edma/dw-edma-pcie.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 1c6043751dc9..2918b64708f9 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -234,6 +234,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	if (!chip->reg_base)
>  		return -ENOMEM;
>  
> +	chip->reg_base += vsec_data.rg.off;
> +
>  	for (i = 0; i < chip->ll_wr_cnt; i++) {
>  		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
>  		struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

