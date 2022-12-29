Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F227F658F0F
	for <lists+dmaengine@lfdr.de>; Thu, 29 Dec 2022 17:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbiL2Q2b (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Dec 2022 11:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbiL2Q1r (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Dec 2022 11:27:47 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD1414D3C;
        Thu, 29 Dec 2022 08:27:42 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id p36so28146470lfa.12;
        Thu, 29 Dec 2022 08:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HKPf3AAmHMNfXy/SpKzN+dMPo3a5K+pwZZAoxAVIWfg=;
        b=bYsi5L6YsNBkslDh/wzHILPAYgT7PxbAs3niyiZDk5N8RMVXXrFVl6jqHpM7nF+FtG
         PzJ4CId3kyt3Sf4T/n1p5PsZLFFBEC+6zUerFxY09OJPTP6U7I3qicssv8nrw2IhQw9n
         SIi9dUq80Qp2zN26tWZZoj3GmUCGBAZDFgOsMhEVOcKpeXHfiAmfmVxUYcLb24AJb+th
         AHATWn5aJIoigl65iZKX0Fs0526Ib7pNovSeReJjFdUwURIzvJQ8Ew+ctIo4LAUj6hwA
         HZ7tTu/LUyv+BODEAah9cjNigUZYXCY7DsN0ZdZbHq5YScozcYFVusTsPQt0dD1NW4r/
         qa1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HKPf3AAmHMNfXy/SpKzN+dMPo3a5K+pwZZAoxAVIWfg=;
        b=U5CiN7mTrLXw3RAEar+RsSsQSaiQvdULiK+/VD/75RAjNbTtu0ZPWCK636FY5wRh6E
         ZF4r/ZOhK/NmcKavqBggHWNMA6uG4EX1Z0stvCdA6LU3EMmNm+GX7EEhF1MFM1rUDFRE
         0mgMidfPuaUOqOVx4Z4t7o75C5gz/ycfrP7RiYiBDvRIYfflE6pn/y0XKwl6MsubJBZ6
         ikpGTdxBd1gML7ItyqZAYVdX0bNVPNmlqzf6nvHqOvwgyeBc25R+p0zC/NaXIixGhEg3
         6Szg+IK5Qn4inCx3dCg+XNS2E1hyxzDSyCbUL8cVBDoECsSJhSMUgPv2DnrzoMn7Pss7
         Qt+Q==
X-Gm-Message-State: AFqh2kqhguvrbYc+3UM6nB5ZvExPGTih1HW59HGz3xsQFdN2fkuA6x0c
        33nYn9nyUtjxbOlYMBGgvEg=
X-Google-Smtp-Source: AMrXdXsBB2ZiPwIR6YWj3B0uL/8/IyT88Tp/l9XNriUSRX5nUSZ/1cwGCtewfLQGGbgWSMxMW1w9Hg==
X-Received: by 2002:a05:6512:510:b0:4cb:4e2:7a89 with SMTP id o16-20020a056512051000b004cb04e27a89mr4319538lfb.25.1672331261179;
        Thu, 29 Dec 2022 08:27:41 -0800 (PST)
Received: from [10.0.0.100] (host-185-69-38-8.kaisa-laajakaista.fi. [185.69.38.8])
        by smtp.gmail.com with ESMTPSA id j4-20020a056512344400b004cb0dfe4993sm1288025lfr.65.2022.12.29.08.27.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 08:27:40 -0800 (PST)
Message-ID: <52a11d11-20a0-bf08-ce64-401b5d0ad133@gmail.com>
Date:   Thu, 29 Dec 2022 18:29:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3] dmaengine: ti: k3-udma: Deferring probe when
 soc_device_match() returns NULL
To:     Vinod Koul <vkoul@kernel.org>,
        Nicolas Frayer <nfrayer@baylibre.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, glaroque@baylibre.com
References: <20221117184406.292416-1-nfrayer@baylibre.com>
 <Y6wlhfdDdm+XAsuH@matsya>
Content-Language: en-US
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <Y6wlhfdDdm+XAsuH@matsya>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 28/12/2022 13:16, Vinod Koul wrote:
> On 17-11-22, 19:44, Nicolas Frayer wrote:
>> When the k3 socinfo driver is built as a module, there is a possibility
>> that it will probe after the k3 udma driver and the later returns -ENODEV.
>> By deferring the k3 udma probe we allow the k3 socinfo to probe and
>> register the soc_device_attribute structure needed by the k3 udma driver.
>> Removed the dev_err() message as well as it's deferring and not failing.
> 
> lgtm, but need rebase as I already picked commit 3f58e10615f3 dmaengine: ti:
> k3-udma: Add support for BCDMA CSI RX

Is this path needed at all? afaik the k3 socinfo is not going to be 
module built.

> 
>>
>> Signed-off-by: Nicolas Frayer <nfrayer@baylibre.com>
>> ---
>> v1->v2:
>> Extracted this patch from the following series:
>> https://lore.kernel.org/all/20221108181144.433087-1-nfrayer@baylibre.com/
>>
>> v2->v3:
>> Removed the dev_err() message
>>
>>   drivers/dma/ti/k3-udma.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
>> index ce8b80bb34d7..ca1512eb9910 100644
>> --- a/drivers/dma/ti/k3-udma.c
>> +++ b/drivers/dma/ti/k3-udma.c
>> @@ -5271,10 +5271,10 @@ static int udma_probe(struct platform_device *pdev)
>>   	ud->match_data = match->data;
>>   
>>   	soc = soc_device_match(k3_soc_devices);
>> -	if (!soc) {
>> -		dev_err(dev, "No compatible SoC found\n");
>> -		return -ENODEV;
>> -	}
>> +
>> +	if (!soc)
>> +		return -EPROBE_DEFER;
>> +
>>   	ud->soc_data = soc->data;
>>   
>>   	ret = udma_get_mmrs(pdev, ud);
>> -- 
>> 2.25.1
> 

-- 
Péter
