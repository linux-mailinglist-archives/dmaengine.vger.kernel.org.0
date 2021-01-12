Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D5C2F38E1
	for <lists+dmaengine@lfdr.de>; Tue, 12 Jan 2021 19:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406210AbhALS3N (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Jan 2021 13:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406163AbhALS3M (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Jan 2021 13:29:12 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB79C061795;
        Tue, 12 Jan 2021 10:28:32 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id y22so3930840ljn.9;
        Tue, 12 Jan 2021 10:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2YD7WmNM8qnNwZubIsxZz9m/eBN1TOpp41xnsGgqsBA=;
        b=byTKUlRzRnCEQMTcxu3/A7PtaLo3WmmNVgyQTKBV42/o8XdmBnxbv4hHcVkB4ikhfH
         IIELx4zkK0upHMkYKk9r5cVRr3i0w0T6f7W9w0I1cVwKwg1GQBilWO11Kdw+kiO9AZBh
         i/HI4AV9k9idzvQXjIeuJP2qleVf2FbyDKsekzLy8kmCfh6TqlyKavOmgotI5Q6jZUxn
         B028k19ORfE4Tkr7FoqwUjAYlN0PYPOplIbF5IJTdSFLZDKZIbdnQ2KR9ieRIXDJLaLa
         1XqHRfKy/2c/2A5mRvhOEBSEc72WGOmBdHjJ7hKumGXZAWIPMJL3HuWGt1loWFluXEKK
         r6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2YD7WmNM8qnNwZubIsxZz9m/eBN1TOpp41xnsGgqsBA=;
        b=f68WI2e2XZhGLkb/UR3ObHR9nx+gZBR9YjjRR2aZbMV/iEWvBU7JdvRqdqWpACqHhv
         XIipAk9Hmc4EeBD9BQ7Q81jXgojwl2n9/hPxdFSA8Gdzni12YcLyhlEo74GUSZIcre3l
         ubnbkXQEqqjwUXXOSAfXt/sM60MZxnuhEJd0HdYiAc/7Cz1vu1pq6TSjvnRjsYiNj2Qx
         BtZ8Lkghusd8xJyoQZJ/FcLLbZl8MNKrYs8xXdx2X0AYqWf2nf2JxsfVIvhTDFKKNHfL
         cceFggLeeBeKmgKtNSZJz6m3ebbhO3jiiYkau7vVgJKeQc3RRSuZZf0IxS6mAvG9dD4L
         MyaA==
X-Gm-Message-State: AOAM530Nh3OW0zkGlojZ35TppQnEAsjzzyscdzCtE3n/1zt19IRP60Xn
        cf5MCsBBGk36UCjpyvTTm8DQ2BZyDwbdew==
X-Google-Smtp-Source: ABdhPJx3ml1Qc0rHyDgLf7XM2B6Waq12EH9xvzTE1a8E1Tc0QSWg8Kptf1dFz8Ka/LP4cDf7mSOMHA==
X-Received: by 2002:a05:651c:cb:: with SMTP id 11mr206216ljr.509.1610476110465;
        Tue, 12 Jan 2021 10:28:30 -0800 (PST)
Received: from [10.0.0.127] (91-157-87-152.elisa-laajakaista.fi. [91.157.87.152])
        by smtp.gmail.com with ESMTPSA id t28sm444828ljo.45.2021.01.12.10.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 10:28:29 -0800 (PST)
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Set rflow count for BCDMA split
 channels
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210112141403.30286-1-vigneshr@ti.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Message-ID: <dc598197-6aa0-f9f9-dadc-54d1e6fb7361@gmail.com>
Date:   Tue, 12 Jan 2021 20:29:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210112141403.30286-1-vigneshr@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vignesh,

On 1/12/21 4:14 PM, Vignesh Raghavendra wrote:
> BCDMA RX channels have one flow per channel, therefore set the rflow_cnt
> to rchan_cnt.
> 
> Without this patch, request for BCDMA RX channel allocation fails as
> rflow_cnt is 0 thus fails to reserve a rflow for the channel.

Good catch, thank you!

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> 
> Fixes: 8844898028d4 ("dmaengine: ti: k3-udma: Add support for BCDMA channel TPL handling")
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>   drivers/dma/ti/k3-udma.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 298460438bb4..a1af59d901be 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -4305,6 +4305,7 @@ static int udma_get_mmrs(struct platform_device *pdev, struct udma_dev *ud)
>   		ud->bchan_cnt = BCDMA_CAP2_BCHAN_CNT(cap2);
>   		ud->tchan_cnt = BCDMA_CAP2_TCHAN_CNT(cap2);
>   		ud->rchan_cnt = BCDMA_CAP2_RCHAN_CNT(cap2);
> +		ud->rflow_cnt = ud->rchan_cnt;
>   		break;
>   	case DMA_TYPE_PKTDMA:
>   		cap4 = udma_read(ud->mmrs[MMR_GCFG], 0x30);
> 

-- 
Péter
