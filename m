Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A454A3F1A
	for <lists+dmaengine@lfdr.de>; Mon, 31 Jan 2022 10:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbiAaJQO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Jan 2022 04:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbiAaJQO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Jan 2022 04:16:14 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4101C061714;
        Mon, 31 Jan 2022 01:16:13 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id n8so25456406lfq.4;
        Mon, 31 Jan 2022 01:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8dIClAuzGyxeW1QA6Ear5GK8ux1d20BAvE6o8CT4Cco=;
        b=BJhA9yxnQUJ7EZm6dlq4u+EasZJSnOy54DZvD7NgK2XTAYMAwGjf+TF1j7fSanKXfM
         5VAuhI2xanC9R4xYdOq7dFDf96HVx0UYKIjhxlGWDsEQFye/mz0F82vHN0Eb0zdiHkNT
         ZyCmUMqnTGD/9jABG5NEKYxbGAR+sD9VaWmHDyZrq3x+gnnI4mWwBClZOZ+DIxjX/x2R
         fM1M3lIc6jlv+f29f9yTl0lpgyMhiK6Hyngv52FMb00w3oSJFthn2OH08NAkWupiOfeE
         NStujjtgOPIhVJjON/NbzVy2InMfFbNRw7UYScB0mMc0Poh2i8uYmb+PoqiknKr2t/vc
         PYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8dIClAuzGyxeW1QA6Ear5GK8ux1d20BAvE6o8CT4Cco=;
        b=OQHg3fCROd3toUjEQyXRG87tdht7LGbrWTw+INtWYothbl3/BrqVtVadnjuo9IaVt2
         GYY2THRGXxc4xWe6jdhtZb7pOxa7gh0Zs5EXmj4HiUEGQkg7wgmmuEGZfB9VTNdZtIqK
         S6FpGJ36XFwGh0KYeg9q3opLIrRY9BOSYjukq8lyRfCQZnWvBB8Mp1xRjECYNZA4CO66
         EjHq/JlPxyAFRlwKkvs8K2pRIJWzBESNicw11/uO69Rzkm3IuTlExCfbZz4dYAJp4Wen
         /45YCre8yjhXXsPmsmRtvEcYkw8wzqWvbKscg5Ffj7enDMtCJQxXccRkcQ06sKy4ReYB
         /cuA==
X-Gm-Message-State: AOAM533b7LiTnQjG75xjJJYNVFVGqN215MVunjhuGfN9Hj9hQn+BHF70
        1zp2oV7nWmu2Tn2RGoQyj80zwBZIKEI=
X-Google-Smtp-Source: ABdhPJyKUAYZUePEH7wJ9+flCUQH/6so6zdX2aIW4XPVMcESBDN8QhjR2Y5tVvD34H9nki+t80GOVQ==
X-Received: by 2002:a05:6512:1303:: with SMTP id x3mr14623943lfu.77.1643620572071;
        Mon, 31 Jan 2022 01:16:12 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-126.dynamic.spd-mgts.ru. [109.252.138.126])
        by smtp.googlemail.com with ESMTPSA id l9sm1406963lfc.304.2022.01.31.01.16.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 01:16:11 -0800 (PST)
Message-ID: <8abf2da8-9a11-8f16-b495-d8ef2d00ab51@gmail.com>
Date:   Mon, 31 Jan 2022 12:16:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v17 2/4] dmaengine: tegra: Add tegra gpcdma driver
Content-Language: en-US
To:     Akhil R <akhilrajeev@nvidia.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Rajesh Gumasta <rgumasta@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Pavan Kunapuli <pkunapuli@nvidia.com>
References: <1643474453-32619-1-git-send-email-akhilrajeev@nvidia.com>
 <1643474453-32619-3-git-send-email-akhilrajeev@nvidia.com>
 <ba109465-d7ee-09cb-775b-9b702a3910b0@gmail.com>
 <DM5PR12MB1850D836ACDF95008EF74CC7C0249@DM5PR12MB1850.namprd12.prod.outlook.com>
 <08f6571e-af75-b6b3-443e-e86e3bdb365b@gmail.com>
 <DM5PR12MB1850FD5F3EF5CBFEA97B3611C0259@DM5PR12MB1850.namprd12.prod.outlook.com>
 <20220131094205.73f5f8c3@dimatab>
 <DM5PR12MB1850D677140466EC74C621A4C0259@DM5PR12MB1850.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <DM5PR12MB1850D677140466EC74C621A4C0259@DM5PR12MB1850.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

31.01.2022 12:09, Akhil R пишет:
>> В Mon, 31 Jan 2022 04:25:14 +0000
>> Akhil R <akhilrajeev@nvidia.com> пишет:
>>
>>>> 30.01.2022 19:34, Akhil R пишет:
>>>>>> 29.01.2022 19:40, Akhil R пишет:
>>>>>>> +static int tegra_dma_device_pause(struct dma_chan *dc) {
>>>>>>> +     struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
>>>>>>> +     unsigned long wcount, flags;
>>>>>>> +     int ret = 0;
>>>>>>> +
>>>>>>> +     if (!tdc->tdma->chip_data->hw_support_pause)
>>>>>>> +             return 0;
>>>>>>
>>>>>> It's wrong to return zero if pause unsupported, please see what
>>>>>> dmaengine_pause() returns.
>>>>>>
>>>>>>> +
>>>>>>> +     spin_lock_irqsave(&tdc->vc.lock, flags);
>>>>>>> +     if (!tdc->dma_desc)
>>>>>>> +             goto out;
>>>>>>> +
>>>>>>> +     ret = tegra_dma_pause(tdc);
>>>>>>> +     if (ret) {
>>>>>>> +             dev_err(tdc2dev(tdc), "DMA pause timed out\n");
>>>>>>> +             goto out;
>>>>>>> +     }
>>>>>>> +
>>>>>>> +     wcount = tdc_read(tdc, TEGRA_GPCDMA_CHAN_XFER_COUNT);
>>>>>>> +     tdc->dma_desc->bytes_xfer +=
>>>>>>> +                     tdc->dma_desc->bytes_req - (wcount * 4);
>>>>>>
>>>>>> Why transfer is accumulated?
>>>>>>
>>>>>> Why do you need to update xfer size at all on pause?
>>>>>
>>>>> I will verify the calculation. This looks correct only for single
>>>>> sg transaction.
>>>>>
>>>>> Updating xfer_size is added to support drivers which pause the
>>>>> transaction and read the status before terminating.
>>>>> Eg.
>>>>
>>>> Why you couldn't update the status in tegra_dma_terminate_all()?
>>> Is it useful to update the status in terminate_all()? I assume the
>>> descriptor Is freed in vchan_dma_desc_free_list() or am I getting it
>>> wrong?
>>
>> Yes, it's not useful. Then you only need to fix the tx_status() and
>> don't touch dma_desc on pause.
> If the bytes_xfer is updated in tx_status(), I suppose 
> DMA_RESIDUE_GRANULARITY_BURST can be kept as is, correct?

You don't need to update bytes_xfer in tx_status(). Please see Tegra20
DMA driver for the example, which supports GRANULARITY_BURST properly.

