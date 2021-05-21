Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D2B38BBFC
	for <lists+dmaengine@lfdr.de>; Fri, 21 May 2021 03:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237755AbhEUBw1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 May 2021 21:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237825AbhEUBw0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 May 2021 21:52:26 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DFDC06138A
        for <dmaengine@vger.kernel.org>; Thu, 20 May 2021 18:51:04 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id t20so14300874qtx.8
        for <dmaengine@vger.kernel.org>; Thu, 20 May 2021 18:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dSie+npZSkADJ7V+ho8kAal6Ij8W1UB//HsiRO+ZSP8=;
        b=vOzl2Ya9ahmcJE4NCzJ9YVIp8x1hqcye6X09xrg0Q1XTV8b4ot9MTBFjizfbo6YeDj
         3BSH9eXImPHo7gQFFgYi0Cutw9EYhBYjHozC2AHE3WsVNHNUEAZsA7JD0YFhOrFoYtfU
         wwcr3xsE0+cWHCX1/nu5s+J2WYyF4QSBCL5S+ku0iP+NQKS8kv4S5NxdpORp8bVpGWqJ
         Vi9Gr4A3WPJmaYF1XbwkeRpe/253gnG6PCoMlCGKv8R9XiuAHLogdMdU/JLbor/Cky8t
         AyiIlY6KH2wcXnJIL9J7lUtcAP3E3+o1d/j3GLyWwYmoi0+KyGemqz3Knz4MS4Oizu+6
         7+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dSie+npZSkADJ7V+ho8kAal6Ij8W1UB//HsiRO+ZSP8=;
        b=b4eA0VUSAaho972eywK42ZgZ69P1RAtAjsPHpxECrijlAjc7vo41j5jUCcWlqABWte
         3Eeo6x7SA1v3qp99kaYlyYbul5CY9o90Gl1TKyZA+w3XFOONCH0MDHCjZGB940xP18PT
         dl9/3W4QEPmW5qO4uYe2NmSANNB0tWWL9O9yD9WcNFGmLY0MlPpIQXXhhHZDb9sp0xyk
         CJ38oyZoPdnkYMfXZMyS9CFShqm/eApN6vxcV46N8OICtw+iK7pgsurbXSzbh4IoPB7t
         WPiuqM0S5n1FxdUcoOI2gbnuOkIOOum/COsHzFydaSwFBv8zg0KVrLp9gN/RYJiBAPRh
         u+rA==
X-Gm-Message-State: AOAM531oHu4m+DL+Fwhtj8a4k0a+yGgIM+s+84/svSJC8GyJxuh2i0Zt
        /7jLrcst/he3F/y4x8/EkOqfnQ==
X-Google-Smtp-Source: ABdhPJyfQ8Ksqhw/qYqkxD1Xtxi9JLGZRyD0jjn0+B2XiJN1JfRDZtttRX3iVIqVj3VCjoxF3jfjFQ==
X-Received: by 2002:ac8:7d56:: with SMTP id h22mr8701787qtb.151.1621561863530;
        Thu, 20 May 2021 18:51:03 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id h23sm3678998qka.22.2021.05.20.18.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 18:51:03 -0700 (PDT)
Subject: Re: [PATCH v3 15/17] crypto: qce: Convert the device found dev_dbg()
 to dev_info()
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com
References: <20210519143700.27392-1-bhupesh.sharma@linaro.org>
 <20210519143700.27392-16-bhupesh.sharma@linaro.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <731b0382-9e77-2a3a-cc83-4f1c63e9f8ce@linaro.org>
Date:   Thu, 20 May 2021 21:50:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210519143700.27392-16-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 5/19/21 10:36 AM, Bhupesh Sharma wrote:
> QCE crypto driver is right now too silent even if the probe() is ok
> and a valid crypto IP version is found.
> 
> Convert the dev_dbg() message to a dev_info() instead.
> 
> Cc: Thara Gopinath <thara.gopinath@linaro.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org
> Cc: linux-clk@vger.kernel.org
> Cc: linux-crypto@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: bhupesh.linux@gmail.com
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>

Warm Regards
Thara
> ---
>   drivers/crypto/qce/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
> index aecb2cdd79e5..8b3e2b4580c2 100644
> --- a/drivers/crypto/qce/core.c
> +++ b/drivers/crypto/qce/core.c
> @@ -179,7 +179,7 @@ static int qce_check_version(struct qce_device *qce)
>   	 */
>   	qce->pipe_pair_id = qce->dma.rxchan->chan_id >> 1;
>   
> -	dev_dbg(qce->dev, "Crypto device found, version %d.%d.%d\n",
> +	dev_info(qce->dev, "Crypto device found, version %d.%d.%d\n",
>   		major, minor, step);
>   
>   	return 0;
> 


