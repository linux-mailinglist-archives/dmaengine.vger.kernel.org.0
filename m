Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C9560E637
	for <lists+dmaengine@lfdr.de>; Wed, 26 Oct 2022 19:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbiJZRNp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 Oct 2022 13:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbiJZRNo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 26 Oct 2022 13:13:44 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBD3FB724
        for <dmaengine@vger.kernel.org>; Wed, 26 Oct 2022 10:13:42 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id g12so19516526lfh.3
        for <dmaengine@vger.kernel.org>; Wed, 26 Oct 2022 10:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LPF2HJ1fQSJsT7qEYA8mSYeJvxG7edpORVMHOnFWnQI=;
        b=L4GJwit0zBRlV5RTa6P7Z1ntLK5mfgSouB3n/WAzAiL3llbjSyuUWCLgfV4pjxVsr5
         6zRekcbGZEwWhdYMSEsQEFZpyTl9J2Ewyx1G+0KO8W6CXrcyvGfL55RsllgCN1gRn4og
         ElBWguO2iWfZ7enBMV1X1wtVUg5+OYF7jf13/jPyYU5OJCGD5A+2C/6PTk5ZObhQSTGR
         80Fg/XI65aWAJP8JD5WDd6yPa96SWffdoVtHtb57g6cj/v6Nxz4tkFM/FERmmXCXQpsq
         9D0v+rqr2MxV9hZet83kNRKtwBGuk8FMZZ8PUSzYGHJ4aSvmqcpwQRGuxG337Y3wonXk
         MPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LPF2HJ1fQSJsT7qEYA8mSYeJvxG7edpORVMHOnFWnQI=;
        b=BN/UqjSIWcOY+wmvffimDtpQg1vS+NJBxNaxGCCH0jBThCLRiDcQydyMMAPBJBzhyN
         g98/5i1Jl/adKLBoPzmKup33NMTwgww33cxZXFDVClZowcFJX2iuRnsmQZZqvgyqtRUr
         Nt4GJR2V1qIuI1D8/+wNjAtaPJ85vzwtv8I18PzJZvzp5THXrtGCJwNX+D2rBrdXiYCI
         cxK4lanYwQl5RdY9nVqNzYjpI3f5RFG7GGnLVWPGOgox+MKlsagt777JkPYFT4QC5VIB
         p0bfTWY+WHWr5DJbepbTkpt2g6zcC/cU4mF+Q7xm+k/y6JA8vFY0yF7O6CxfoYVbxIK6
         xoJA==
X-Gm-Message-State: ACrzQf3kxyXd7GQhIY7YuKM2IOiA7QxKMs3abwIk7uTz4gj187R5rW5S
        hPYwaMnuj3vu1sHIIRCGonw=
X-Google-Smtp-Source: AMsMyM7ce4a7eh3ngJuQzn/lRMbHApubKYFkRX0AZnyKPQ9ly7QL657stQsA83LL4znrbQ93wPVnew==
X-Received: by 2002:ac2:57c5:0:b0:4a4:4f15:44ec with SMTP id k5-20020ac257c5000000b004a44f1544ecmr15873977lfo.526.1666804420591;
        Wed, 26 Oct 2022 10:13:40 -0700 (PDT)
Received: from [10.0.0.100] (host-185-69-38-8.kaisa-laajakaista.fi. [185.69.38.8])
        by smtp.gmail.com with ESMTPSA id n21-20020ac242d5000000b004a26ba3458fsm908909lfl.62.2022.10.26.10.13.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 10:13:39 -0700 (PDT)
Message-ID: <3f65b0f1-119e-2956-b909-d3860d0f12f0@gmail.com>
Date:   Wed, 26 Oct 2022 20:14:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] dmaengine: ti: k3-udma-glue: fix memory leak when
 register device fail
To:     Yang Yingliang <yangyingliang@huawei.com>,
        dmaengine@vger.kernel.org
Cc:     vigneshr@ti.com, peter.ujfalusi@ti.com, vkoul@kernel.org
References: <20221020062827.2914148-1-yangyingliang@huawei.com>
Content-Language: en-US
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20221020062827.2914148-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 20/10/2022 09:28, Yang Yingliang wrote:
> If device_register() fails, it should call put_device() to give
> up reference, the name allocated in dev_set_name() can be freed
> in callback function kobject_cleanup().

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> 
> Fixes: 5b65781d06ea ("dmaengine: ti: k3-udma-glue: Add support for K3 PKTDMA")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>   drivers/dma/ti/k3-udma-glue.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
> index 4fdd9f06b723..4f1aeb81e9c7 100644
> --- a/drivers/dma/ti/k3-udma-glue.c
> +++ b/drivers/dma/ti/k3-udma-glue.c
> @@ -299,6 +299,7 @@ struct k3_udma_glue_tx_channel *k3_udma_glue_request_tx_chn(struct device *dev,
>   	ret = device_register(&tx_chn->common.chan_dev);
>   	if (ret) {
>   		dev_err(dev, "Channel Device registration failed %d\n", ret);
> +		put_device(&tx_chn->common.chan_dev);
>   		tx_chn->common.chan_dev.parent = NULL;
>   		goto err;
>   	}
> @@ -917,6 +918,7 @@ k3_udma_glue_request_rx_chn_priv(struct device *dev, const char *name,
>   	ret = device_register(&rx_chn->common.chan_dev);
>   	if (ret) {
>   		dev_err(dev, "Channel Device registration failed %d\n", ret);
> +		put_device(&rx_chn->common.chan_dev);
>   		rx_chn->common.chan_dev.parent = NULL;
>   		goto err;
>   	}
> @@ -1048,6 +1050,7 @@ k3_udma_glue_request_remote_rx_chn(struct device *dev, const char *name,
>   	ret = device_register(&rx_chn->common.chan_dev);
>   	if (ret) {
>   		dev_err(dev, "Channel Device registration failed %d\n", ret);
> +		put_device(&rx_chn->common.chan_dev);
>   		rx_chn->common.chan_dev.parent = NULL;
>   		goto err;
>   	}

-- 
Péter
