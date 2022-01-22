Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5494496D4C
	for <lists+dmaengine@lfdr.de>; Sat, 22 Jan 2022 19:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbiAVSbp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 22 Jan 2022 13:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbiAVSbo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 22 Jan 2022 13:31:44 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA5FC06173B;
        Sat, 22 Jan 2022 10:31:43 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id bu18so40853177lfb.5;
        Sat, 22 Jan 2022 10:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yh82ozfSM6oapqGRh4z7IM/xoIpSwq0P7Nnmuai8gxg=;
        b=CAFwyQ77R2H6RYwpu0aR7vj2GXGa6gLhHNaq/FMOVKUwB9TSdOV1niGlNkrMDkuIDg
         WU9BqxwnUgKILKeA6hPbuOX6TW/AXfNcT9UGGpeka8FaqEHbf0el5u8kebmCg65dulz9
         SqpWcsrMguDTbHPpMlMc6LxC/Ua3lNuNr2yvJxp4zma6wb9fJ8FLyt3RlR83T/OutSlb
         MnJPvr+8atYvWA/ohHEvKjqfV9xbcBX2NNEnYNNxjNjAa0p5rGNdjL0WHutWsnMpvSlQ
         q2Tlua+vE/qx8rLjxnnFcqiuextgJHNbxdfZjFp11AtHU3NWkVwIsT5hOugAe3ZUK28u
         G6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yh82ozfSM6oapqGRh4z7IM/xoIpSwq0P7Nnmuai8gxg=;
        b=W+90WSc3Yc2sVkNrTrvtJXAcKnDXTNsfeBByz19Yt25czIdLngbahOysq2rFCzAaEB
         HuAX/ZqkCl5SmanW5B5VOBQiotu4YS8ZbiIxX9dWV2NWkTyGXQMTDu6bM+6fBYLaverQ
         U5ieonYfE1nxfgXVjUMoeaby9EP3gmgzTIygRTsViqb+IbhNA/OR0Dm5JvolyfPW87wm
         BbMTqp/MGkvuAy9p3pptZJXWb8VAhs1qN6SWdhwcGsH16TNYNyAuxHrQZ2+krZ4P01dx
         OF+DYEUdT4EMssQa5vFf8WK9WGvbLlF5liXb50eCZPPW51WXqom/pad1LWWaJnQrLEKk
         MFWA==
X-Gm-Message-State: AOAM532b+TxIDaYG1vB2EgP5/hAtVA4UrlojVm5VE1lcNUDukfMH4/R9
        Bahua1FVh8ZWgR9ZpMfQhyY=
X-Google-Smtp-Source: ABdhPJx0tROet2YXOw/bq3Yumcg02rCbq0PE56juLvkeoXb/+YoZ1Jt9J9SY8lhUIYVvmxkFAIIHIQ==
X-Received: by 2002:a05:6512:207:: with SMTP id a7mr5440742lfo.208.1642876301886;
        Sat, 22 Jan 2022 10:31:41 -0800 (PST)
Received: from [192.168.2.145] (109-252-139-36.dynamic.spd-mgts.ru. [109.252.139.36])
        by smtp.googlemail.com with ESMTPSA id q16sm631365lfg.170.2022.01.22.10.31.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jan 2022 10:31:41 -0800 (PST)
Message-ID: <31ba2627-65c7-1340-e6b9-7c328a485456@gmail.com>
Date:   Sat, 22 Jan 2022 21:31:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v16 2/4] dmaengine: tegra: Add tegra gpcdma driver
Content-Language: en-US
To:     Akhil R <akhilrajeev@nvidia.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
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
        "vkoul@kernel.org" <vkoul@kernel.org>
Cc:     Pavan Kunapuli <pkunapuli@nvidia.com>
References: <1641830718-23650-1-git-send-email-akhilrajeev@nvidia.com>
 <1641830718-23650-3-git-send-email-akhilrajeev@nvidia.com>
 <16c73e83-b990-7d8e-ddfd-7cbbe7e407ea@gmail.com>
 <DM5PR12MB1850A5F5ABA9CD5D04C37086C0579@DM5PR12MB1850.namprd12.prod.outlook.com>
 <1db14c3d-6a96-96dd-be76-b81b3a48a2b1@gmail.com>
 <DM5PR12MB1850FF1DC4DC1714E31AADB5C0589@DM5PR12MB1850.namprd12.prod.outlook.com>
 <683a71b1-049a-bddf-280d-5d5141b59686@gmail.com>
 <DM5PR12MB1850D67F9B5640943F1AEB2EC05B9@DM5PR12MB1850.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <DM5PR12MB1850D67F9B5640943F1AEB2EC05B9@DM5PR12MB1850.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

21.01.2022 19:24, Akhil R пишет:
>>>>>>> +static int tegra_dma_terminate_all(struct dma_chan *dc)
>>>>>>> +{
>>>>>>> +     struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
>>>>>>> +     unsigned long flags;
>>>>>>> +     LIST_HEAD(head);
>>>>>>> +     int err;
>>>>>>> +
>>>>>>> +     if (tdc->dma_desc) {
>>>>>>
>>>>>> Needs locking protection against racing with the interrupt handler.
>>>>> tegra_dma_stop_client() waits for the in-flight transfer
>>>>> to complete and prevents any additional transfer to start.
>>>>> Wouldn't it manage the race? Do you see any potential issue there?
>>>>
>>>> You should consider interrupt handler like a process running in a
>>>> parallel thread. The interrupt handler sets tdc->dma_desc to NULL, hence
>>>> you'll get NULL dereference in tegra_dma_stop_client().
>>>
>>> Is it better if I remove the below part from tegra_dma_stop_client() so
>>> that dma_desc is not accessed at all?
>>>
>>> +     wcount = tdc_read(tdc, TEGRA_GPCDMA_CHAN_XFER_COUNT);
>>> +     tdc->dma_desc->bytes_transferred +=
>>> +                     tdc->dma_desc->bytes_requested - (wcount * 4);
>>>
>>> Because I don't see a point in updating the value there. dma_desc is set
>>> to NULL in the next step in terminate_all() anyway.
>>
>> That isn't going help you much because you also can't release DMA
>> descriptor while interrupt handler still may be running and using that
>> descriptor.
> 
> Does the below functions look good to resolve the issue, provided
> tegra_dma_stop_client() doesn't access dma_desc?

Stop shall not race with the start.

> +static int tegra_dma_terminate_all(struct dma_chan *dc)
> +{
> +       struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
> +       unsigned long flags;
> +       LIST_HEAD(head);
> +       int err;
> +
> +       err = tegra_dma_stop_client(tdc);
> +       if (err)
> +               return err;
> +
> +       tegra_dma_stop(tdc);
> +
> +       spin_lock_irqsave(&tdc->vc.lock, flags);
> +       tegra_dma_sid_free(tdc);
> +       tdc->dma_desc = NULL;
> +
> +       vchan_get_all_descriptors(&tdc->vc, &head);
> +       spin_unlock_irqrestore(&tdc->vc.lock, flags);
> +
> +       vchan_dma_desc_free_list(&tdc->vc, &head);
> +
> +       return 0;
> +}
> 
> +static irqreturn_t tegra_dma_isr(int irq, void *dev_id)
> +{
> +       struct tegra_dma_channel *tdc = dev_id;
> +       struct tegra_dma_desc *dma_desc = tdc->dma_desc;
> +       struct tegra_dma_sg_req *sg_req;
> +       u32 status;
> +
> +       /* Check channel error status register */
> +       status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_ERR_STATUS);
> +       if (status) {
> +               tegra_dma_chan_decode_error(tdc, status);
> +               tegra_dma_dump_chan_regs(tdc);
> +               tdc_write(tdc, TEGRA_GPCDMA_CHAN_ERR_STATUS, 0xFFFFFFFF);
> +       }
> +
> +       status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_STATUS);
> +       if (!(status & TEGRA_GPCDMA_STATUS_ISE_EOC))
> +               return IRQ_HANDLED;
> +
> +       tdc_write(tdc, TEGRA_GPCDMA_CHAN_STATUS,
> +                 TEGRA_GPCDMA_STATUS_ISE_EOC);
> +
> +       spin_lock(&tdc->vc.lock);
> +       if (!dma_desc)
All checks and assignments must be done inside of critical section.


> +               goto irq_done;
