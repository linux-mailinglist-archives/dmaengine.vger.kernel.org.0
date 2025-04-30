Return-Path: <dmaengine+bounces-5039-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC98BAA430C
	for <lists+dmaengine@lfdr.de>; Wed, 30 Apr 2025 08:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1775516185A
	for <lists+dmaengine@lfdr.de>; Wed, 30 Apr 2025 06:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1AA1D5CFE;
	Wed, 30 Apr 2025 06:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UU5l5+rv"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A521BD9D3
	for <dmaengine@vger.kernel.org>; Wed, 30 Apr 2025 06:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745994232; cv=none; b=NyOm+JiMg7jcMhmHY/1ayC4Wc+ksj8azfmhFaqIRfJeR80vvdF0Dn0XPD3ow9/M47i7ytPwEyjHoleIKYFJWvMa/WRnyz/kc9zHwKRKwkos+onDBy9h2xd7e2AwlIdqW0VpRoO81w/AmZCr9YBP7wML87zj1CqXDzsvsHhB4AAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745994232; c=relaxed/simple;
	bh=QdW0ibxTwWwREp4tWV5Y7Dah9FZgyJW4dRHXA8zibYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSQKE/nNKPrVCY6XanWBZe09znApss5oPeY85NIZ1+ZAn9uzEm6om70A2/6wBQQ5iSvKyan+wxcdrpUI7JEkkP4XVPui5jgLyFiY1sC6qRjK+1IfYq2Q6BPsD+t9JaGl31QnTYGCxHUVeiXWNXypXciavz9/oii8DlDGT4u1WnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UU5l5+rv; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22c336fcdaaso83227475ad.3
        for <dmaengine@vger.kernel.org>; Tue, 29 Apr 2025 23:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745994230; x=1746599030; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=03WoV54tz3M6hwT9sU/vqgSJjnQ/tgaaDuyl7WpQlLc=;
        b=UU5l5+rv8og/Lm41FBjsfDNBIBSDIXkQu1uR6hCKoHqpEt83qKgiTA2Y8nLRsD1NnZ
         jutsCYGXhojLY8wZRTxtWl/PGfa32/RCAN5SLvj4sTn3XLQO9GWrmGr7ZGYijf1eoOjr
         n9lhFY3hXnTzUolYkKJCpYmTs3q0WmguGGxcYZvLnVhJId6UWwnyIJ6rk4wKhK7EPrE1
         XbSKQRiiE8hqL34FqsIcGdz9E7KWboxoffI2qHcSjgVv+iu6rjAlMA1UoTU4yNUsqNa4
         Bwm5H3wuinlxomNRF51OoywFy1nyNwK/MucSrIrX0mMIu8wM2fW885H7D4wu4sIwkNn8
         xeow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745994230; x=1746599030;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=03WoV54tz3M6hwT9sU/vqgSJjnQ/tgaaDuyl7WpQlLc=;
        b=aKEAYdFAluavsX88stVtVpGOoGznBQLRQJknvRIcPtHTXYc6odRyFr114NHYxBHobZ
         pQwe/6sssV5YKNA3mMae1ln+kZHriR7Secmk95G/THb10IfO2iDj6WRwICMVH+MRxUbf
         opthClkw/T8Yglz0IXH7toe/AH9K/IXI77EEOsi4Wlca7AxMVSePinBSZOo0+j8v0tqe
         PI/lTcXvBoDjMIvBKYonY1fQOuC290WBPTI2l6TjI1f9FAaIcDaIC/g3pqSJqUkVCgzL
         8UzorzeSBhpTXUgoUISePpxuDnzWH106Tunq6XD/QAOHsmieA7I7Q25PXYLiNrgKVPTN
         W1Tw==
X-Gm-Message-State: AOJu0Yw8lj4xAOfmhaNcmYRKZw5WEYhwB8TZssAdC+thlpfJkv7x1wOB
	gAu2tRperwHYGI4gk7YUrLZlyrBLWfHka6SGZqHmrXYHUTNzODI7CKo85sQ2wQ==
X-Gm-Gg: ASbGncsMm63oYfI4Lti0JkDdODytPbLdrV8MW+SvBrB0MB5pK3jcCG1U2i8DPobCPp3
	4a2SFViYdu8gklJv3nIufLidikB/ad1px87hl2UeJhJM8506EIw27KETW5BhGtytYmmvnmUnciI
	+LpjKWOy4uGp/DjArQEa5We1nRvthqBRraj8oFjfk6pv9whwj4kUzKJoWAhyUWFbmX1A6ANUFxN
	RfraC9AnsEwnsP0aoWc7yYKOF4ZrCtQGqGstmrEK9aMiddrZfGUUZJUJ9zKE+oCYt0Rm7S4WEGH
	5k/q8iV7KjP6+Jy+uuR0VKKncVQkL8i/2kSwEPB+pNbpGwO73guQ
X-Google-Smtp-Source: AGHT+IEeslhmFcqhuBeb3fAJDK9HU4zUhtq5N9GUPDoyLQYoyCTcLVDmw51YcSLVIRANtjSCwllR4A==
X-Received: by 2002:a17:902:f68e:b0:224:826:279e with SMTP id d9443c01a7336-22df35887e6mr32343915ad.50.1745994230152;
        Tue, 29 Apr 2025 23:23:50 -0700 (PDT)
Received: from thinkpad ([120.56.197.193])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5221943sm113794745ad.249.2025.04.29.23.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 23:23:49 -0700 (PDT)
Date: Wed, 30 Apr 2025 11:53:46 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Devendra K Verma <devverma@amd.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michal.simek@amd.com, vkoul@kernel.org
Subject: Re: [RESEND PATCH] dmaengine: dw-edma: Add HDMA NATIVE map check
Message-ID: <lmfkq4k6fkm4rlayysf3m2qpbyejfkgxubu2c7txtvwzlp6ua6@6jl7glnnndcf>
References: <20250429113048.199179-1-devverma@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250429113048.199179-1-devverma@amd.com>

On Tue, Apr 29, 2025 at 05:00:48PM +0530, Devendra K Verma wrote:
> The HDMA IP supports the HDMA_NATIVE map format as part of Vendor-Specific
> Extended Capability. Added the check for HDMA_NATIVE map format.
> The check for map format enables the IP specific function invocation
> during the DMA ops.
> 

You also need to update the 'Debug info' part in dw_edma_pcie_probe().

- Mani

> Signed-off-by: Devendra K Verma <devverma@amd.com>
> ---
>  drivers/dma/dw-edma/dw-edma-pcie.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 1c6043751dc9..42b2a554f7a5 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -136,7 +136,8 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
>  	map = FIELD_GET(DW_PCIE_VSEC_DMA_MAP, val);
>  	if (map != EDMA_MF_EDMA_LEGACY &&
>  	    map != EDMA_MF_EDMA_UNROLL &&
> -	    map != EDMA_MF_HDMA_COMPAT)
> +	    map != EDMA_MF_HDMA_COMPAT &&
> +	    map != EDMA_MF_HDMA_NATIVE)
>  		return;
>  
>  	pdata->mf = map;
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

