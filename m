Return-Path: <dmaengine+bounces-2710-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E90D093391E
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jul 2024 10:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CDD5B238EC
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jul 2024 08:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B70610953;
	Wed, 17 Jul 2024 08:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bigItTj5"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4453A8CB
	for <dmaengine@vger.kernel.org>; Wed, 17 Jul 2024 08:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721205306; cv=none; b=ohFRIQpqoC5XFLtAQ7Q3s4HQy9UneUtKNyLn3EMuomG5esLNLS79nJ182FDa5VyeRLS2LQRnkY2/z/ENtS0g2JKywGNZBoL4Py2YdWfw8VsU2VMk2i30AX3LpbgIE2XSMcFyJstS0vGFnfiLzg+7Xe+bkB/miA4GxRsY7f04UxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721205306; c=relaxed/simple;
	bh=7yWT9wGZeLIqjFls1Qiq/gphKhA3MEBdNOj7oVHIg3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4fI+beABKxT+alT5ioCSkpTbKGoMj6mtDTrzPJNaGCmSz2s0F3IUiif+jsi1ZBhhx4LfgELuSizIBtw6PdAX9s768/hV04khTrNTVm1iAHLPqIcfBAgBc2e6sOSu+G5nWqH5kNYm0CVg9W4/TRVIiQRmK3HGEpNa85EccJocEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bigItTj5; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fc566ac769so19385ad.1
        for <dmaengine@vger.kernel.org>; Wed, 17 Jul 2024 01:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721205304; x=1721810104; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mNkMLlzIh0FRUMrqsEmjaMD7DKmMc/WtpJCzEXhD76s=;
        b=bigItTj51EMhBldwnwgIA/LvPmUqdzn3f2dkoW026ssQPtOp4obtCgW0tIilMgcsQN
         6TOpZHPyyI2PyyE1nBXBoj7ZmiJLdUFprO3J1d8MDgaNTITKyF8r4d14GP02IAmTzEWu
         7wGjkm8z5RLX9UWhclvPYvdwB8MqFeMlKl6d3GmvbY3WGsbHs0J1KNjS9/KIys2B3kTW
         NPjxrSOtIvPW3mfgZP5kjovYjPg2dpIN5A0x7uBWf6G5nTSdWJm/013uO8mv8Af4qTVc
         36CmRXVNDpKoIwa1J2JrtofnT7PAEdO1xnqHv2UPBGMFWYnfDUB3/4iGDO30C8rxyCad
         DwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721205304; x=1721810104;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mNkMLlzIh0FRUMrqsEmjaMD7DKmMc/WtpJCzEXhD76s=;
        b=rDWErRHg7wgyHpENq2IkUwQfPIDxxb9iaM/fiWzPcE+DO07jxohf08LrrhzeCPu23z
         1t+kp5MpS8UxdGJkXto9l7SImFzClUAuq9Syx1Tx8GOuKzyaIPz5N0hjr6UjSpvSOR4V
         w7DNjGmvcjuRPJaTsujb9tqRQmJM+B/aKCOvXn1n9BfNDgY4KOonBhTD4m03b7seyQId
         9zcOIzZycrcgO1drFyF1InBlJgzlITrHRzl4WzQUmAMD2GDY0upCtB2fsGG3MpXIirq3
         ETQvIfwh3uC6xVhumqT3P5PJ+G5dOODMaTelsRtAsxYjZBGgr3b3CyEbyJQ1ug6ttHrP
         6pLA==
X-Forwarded-Encrypted: i=1; AJvYcCWgOXrnxYCOIJDAd+Z84iwa9e31dUDpfPN1OODU6pDoHARQwc3MuJcPEqeNQ5tMZVfHce1XGHG5q6wCoclphZNnTxenlDkRobMD
X-Gm-Message-State: AOJu0YzCMlvS1HQO5nE/gvLP/0i/0K5Od/49FauRumXM9M93AnBp1DSD
	/haY4hyzP3Q+y+PmaZ/o2K36L08C6Zuw6jFscigTEneiPhL+WFWyhk/P5O+BsA==
X-Google-Smtp-Source: AGHT+IGl2IJMzGLyoVjbWN3voJb+DI9d1XbG0jgZwcz3Yoiew4Ex5l2yrPzMBWFdANacOw+Nwc0rgw==
X-Received: by 2002:a17:902:ce8f:b0:1fb:cf82:11b4 with SMTP id d9443c01a7336-1fc4e13590amr8333135ad.6.1721205304162;
        Wed, 17 Jul 2024 01:35:04 -0700 (PDT)
Received: from thinkpad ([220.158.156.207])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bbc25d2sm70270675ad.100.2024.07.17.01.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 01:35:02 -0700 (PDT)
Date: Wed, 17 Jul 2024 14:04:58 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc: fancer.lancer@gmail.com, vkoul@kernel.org, quic_shazhuss@quicinc.com,
	quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com,
	quic_nayiluri@quicinc.com, quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] dmaengine: dw-edma: Add change to remove
 watermark interrupt enablement
Message-ID: <20240717083458.GC2574@thinkpad>
References: <1720187733-5380-1-git-send-email-quic_msarkar@quicinc.com>
 <1720187733-5380-3-git-send-email-quic_msarkar@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1720187733-5380-3-git-send-email-quic_msarkar@quicinc.com>

On Fri, Jul 05, 2024 at 07:25:33PM +0530, Mrinmay Sarkar wrote:

Subject should be:

dmaengine: dw-edma: Do not enable watermark interrupts for HDMA

> DW_HDMA_V0_LIE and DW_HDMA_V0_RIE are initialized as BIT(3) and BIT(4)
> respectively in dw_hdma_control enum. But as per HDMA register these
> bits are corresponds to LWIE and RWIE bit i.e local watermark interrupt
> enable and remote watermarek interrupt enable. In linked list mode LWIE
> and RWIE bits only enable the local and remote watermark interrupt.
> 

I guess you should also rename DW_HDMA_V0_LIE -> DW_HDMA_V0_LWIE and
DW_HDMA_V0_RIE -> DW_HDMA_V0_RWIE in the code, unless the register name changes
with mode.

> As we are not handling watermark interruprt so removing watermark
> interrupt enablement logic to avoid unnecessary watermark interrupt
> event.
> 

How about,

"Since the watermark interrupts are not used but enabled, this leads to
spurious interrupts getting generated. So remove the code that enables them
to avoid generating spurious watermark interrupts."

> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>

Again, please include Fixes tag and CC stable.

> ---
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index 88bd652f..aaf2e27 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -197,23 +197,13 @@ static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
>  	struct dw_edma_burst *child;
>  	struct dw_edma_chan *chan = chunk->chan;

This becomes unused as reported by bot.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

