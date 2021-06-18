Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6103ACCCD
	for <lists+dmaengine@lfdr.de>; Fri, 18 Jun 2021 15:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbhFRNzR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Jun 2021 09:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234020AbhFRNzO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 18 Jun 2021 09:55:14 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F8DC061574;
        Fri, 18 Jun 2021 06:53:05 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id c9so10887523wrt.5;
        Fri, 18 Jun 2021 06:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ITBAl4FWs2S5uSotuHXD8wqyuOBqmsc7zriYKDn2S+k=;
        b=nTxIZ8xokQc6mlmltoY0rHWuh/kMpywSMXPOercEeeZbPaeZCE9/O22J53a2EBWUtP
         d5foNFsym9xbqMkgBT+TrE9kMN76sMNzeDInDALWAJF7bizuIA0fI1rmBm42VY9o+TIg
         /nzoJ9rZxBkcucm18mkhBVAOzneyEJWnKx0hPpkOPsvRjpVXaS7ZXtCuYpUPVL7Qc6Qo
         2/Q5S5mPW/a47e8k+jUhrBYaqJTlZpCuKO5mZtvStOnyKRfVv+4FvA0uYFVrgRaS2Z2t
         C1sU2SmbS2RIdP1cHKBdfcbRderokDveStCbZVTDVi4O6n69C1inDeb/Onc16cT3ytDK
         Q2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ITBAl4FWs2S5uSotuHXD8wqyuOBqmsc7zriYKDn2S+k=;
        b=eIW2GFy5vb8OPgLOLLptTpzQpqzq8Oc7GdqrhdohPHI2aOUWQToJTbTkSvLmwc6XL3
         iIp5U0b3I/Rnu+lmx9bYoMZG/B6/cwO5Gs6O9QrN3Tpyp0AocmCrLaSkmtr3buHg1hZu
         HpeqG5ws9iui/wzEI9DLwS9262baUp/+7PWbPL5z02Km/y6RXIdpHJ41eGgijHYRXvyU
         jBY4fds816GKC92Po3N7DNLjUCSvn6u5x/kRGz/WwKHAMKtJcv4UJZLwbb2Bhx4mRt8H
         wiizEDn+nmK1hwgSVERCi3DHNhG6AoECDks5VGBH67eQmb97G2pJ8k0aHd4SYWjwnhyE
         BfEA==
X-Gm-Message-State: AOAM531euGlbbbvzfUYY4dygNJb1L6Pdru6QBDfO9VOzR/zSEJr7VfIY
        n0id1aURjXEmIV5cMlUW1kk=
X-Google-Smtp-Source: ABdhPJw+MfiIKMOT70+0vEXXd5JNmRAUwX7q13K8fShJA9b0q7JJvb8tpaYMCPMQQ3AQQnp4h+HXRg==
X-Received: by 2002:a05:6000:178e:: with SMTP id e14mr12911421wrg.246.1624024383863;
        Fri, 18 Jun 2021 06:53:03 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id c13sm8935127wrb.5.2021.06.18.06.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 06:53:03 -0700 (PDT)
Subject: Re: [PATCH] dmaengine: mediatek: Return the correct errno code
To:     angkery <angkery@163.com>, sean.wang@mediatek.com, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Junlin Yang <yangjunlin@yulong.com>
References: <20210617133229.1497-1-angkery@163.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <2eb509a4-73dd-b3db-41d3-e7a0043ce8c9@gmail.com>
Date:   Fri, 18 Jun 2021 15:53:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210617133229.1497-1-angkery@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 17/06/2021 15:32, angkery wrote:
> From: Junlin Yang <yangjunlin@yulong.com>
> 
> When devm_kzalloc failed, should return ENOMEM rather than ENODEV.
> 
> Signed-off-by: Junlin Yang <yangjunlin@yulong.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>  drivers/dma/mediatek/mtk-uart-apdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/mediatek/mtk-uart-apdma.c b/drivers/dma/mediatek/mtk-uart-apdma.c
> index 375e7e6..a4cb30f 100644
> --- a/drivers/dma/mediatek/mtk-uart-apdma.c
> +++ b/drivers/dma/mediatek/mtk-uart-apdma.c
> @@ -529,7 +529,7 @@ static int mtk_uart_apdma_probe(struct platform_device *pdev)
>  	for (i = 0; i < mtkd->dma_requests; i++) {
>  		c = devm_kzalloc(mtkd->ddev.dev, sizeof(*c), GFP_KERNEL);
>  		if (!c) {
> -			rc = -ENODEV;
> +			rc = -ENOMEM;
>  			goto err_no_dma;
>  		}
>  
> 
