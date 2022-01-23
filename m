Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5394975AF
	for <lists+dmaengine@lfdr.de>; Sun, 23 Jan 2022 22:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240214AbiAWVHl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 23 Jan 2022 16:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbiAWVHk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 23 Jan 2022 16:07:40 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E1FC06173B;
        Sun, 23 Jan 2022 13:07:40 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id z7so5609546ljj.4;
        Sun, 23 Jan 2022 13:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TWroeOFfXJ8ykubtpTzdZUMtBKtFDv4WjEMH7rViCZ4=;
        b=AkLDoU65OoXutqFq/yU8DRichLINsqWe+UTaaaCXQHLixjrDMIlvTm18EXVEiGEe6T
         CcoIqpwZuZBwZK5lc0CvVKkDALVypCQrym1w6j5gBlRonsn+dhdr2lGBy3Soc4P9XlVp
         /vT84+5JJDT1hpWTbdlcBSXeeZ3npxZsIVcePXVSgIrfbID89xiqQEO7WPXoW5paFVnP
         /vNPluEab1TPFBZKGuOSp+gED+DwV7KW4nH74OU6hFt2IRFg8LHkFJtYuQ2jCGOtSfbo
         0qVQHT+5qNzUanGW01v4sTKCS+Y4I1wUOgb9/lqqOVB4TLCF7RjtXh2X48/Iw7RtV85w
         q7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TWroeOFfXJ8ykubtpTzdZUMtBKtFDv4WjEMH7rViCZ4=;
        b=tCQzOXGKTpoyHVg4gADTDj2AXsnEkdRZ8IzN1A0t7Etu3H2Z25Wn7UqJGYmPo6nPON
         Moim+Ia70LNVgw5b3Uf7v446UaisLVyHj+LtaHZyEjNtGJbV+oMJ/d4Oz/w0DgofrDig
         bdHMfYs/wemVPGsUiLhTNL/vevG4uRJLkutXVxY/I6c27G+9GUWbmSrP17S7hdntogEB
         iyDsutsK0TKgyWd817ccrm3F0ICnVDWDQBW4D3Q0aRCnNn52fXJZeoFxhLRcxzcGVDUw
         uTWhvgCWz+46emu2cLQ9Spnw0YqSJsMlOxaHqbrg6AnHYKOva8JvcDZ8bCGW6ZRU2UMM
         nqbg==
X-Gm-Message-State: AOAM531k1uw2xP7IsiM9XGRzd05ucdjEr3UmQug+n97RPdZ0Dvzzjaxd
        pvYdaiBOVpep5bqRseTPhrc=
X-Google-Smtp-Source: ABdhPJy3W+F/c72AUGx8ghCc1RakIcSzEyHm1Ekag8uEj+X1pC5IVjbRpsm7U2ORGJTTDfS1DMmxyw==
X-Received: by 2002:a2e:a40c:: with SMTP id p12mr2268584ljn.66.1642972058863;
        Sun, 23 Jan 2022 13:07:38 -0800 (PST)
Received: from [192.168.2.145] (109-252-139-36.dynamic.spd-mgts.ru. [109.252.139.36])
        by smtp.googlemail.com with ESMTPSA id be31sm960455lfb.46.2022.01.23.13.07.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jan 2022 13:07:38 -0800 (PST)
Message-ID: <80a90a28-d9b8-1ba6-b79e-07fd49cc92b7@gmail.com>
Date:   Mon, 24 Jan 2022 00:07:37 +0300
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
 <31ba2627-65c7-1340-e6b9-7c328a485456@gmail.com>
 <DM5PR12MB18502DF12B324E50D5E50BC0C05D9@DM5PR12MB1850.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <DM5PR12MB18502DF12B324E50D5E50BC0C05D9@DM5PR12MB1850.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

23.01.2022 19:49, Akhil R пишет:
>> 21.01.2022 19:24, Akhil R пишет:
>>>>>>>>> +static int tegra_dma_terminate_all(struct dma_chan *dc) {
>>>>>>>>> +     struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
>>>>>>>>> +     unsigned long flags;
>>>>>>>>> +     LIST_HEAD(head);
>>>>>>>>> +     int err;
>>>>>>>>> +
>>>>>>>>> +     if (tdc->dma_desc) {
>>>>>>>>
>>>>>>>> Needs locking protection against racing with the interrupt handler.
>>>>>>> tegra_dma_stop_client() waits for the in-flight transfer to
>>>>>>> complete and prevents any additional transfer to start.
>>>>>>> Wouldn't it manage the race? Do you see any potential issue there?
>>>>>>
>>>>>> You should consider interrupt handler like a process running in a
>>>>>> parallel thread. The interrupt handler sets tdc->dma_desc to NULL,
>>>>>> hence you'll get NULL dereference in tegra_dma_stop_client().
>>>>>
>>>>> Is it better if I remove the below part from tegra_dma_stop_client()
>>>>> so that dma_desc is not accessed at all?
>>>>>
>>>>> +     wcount = tdc_read(tdc, TEGRA_GPCDMA_CHAN_XFER_COUNT);
>>>>> +     tdc->dma_desc->bytes_transferred +=
>>>>> +                     tdc->dma_desc->bytes_requested - (wcount * 4);
>>>>>
>>>>> Because I don't see a point in updating the value there. dma_desc is
>>>>> set to NULL in the next step in terminate_all() anyway.
>>>>
>>>> That isn't going help you much because you also can't release DMA
>>>> descriptor while interrupt handler still may be running and using
>>>> that descriptor.
>>>
>>> Does the below functions look good to resolve the issue, provided
>>> tegra_dma_stop_client() doesn't access dma_desc?
>>
>> Stop shall not race with the start.
>>
>>> +static int tegra_dma_terminate_all(struct dma_chan *dc) {
>>> +       struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
>>> +       unsigned long flags;
>>> +       LIST_HEAD(head);
>>> +       int err;
>>> +
>>> +       err = tegra_dma_stop_client(tdc);
>>> +       if (err)
>>> +               return err;
>>> +
>>> +       tegra_dma_stop(tdc);
>>> +
>>> +       spin_lock_irqsave(&tdc->vc.lock, flags);
>>> +       tegra_dma_sid_free(tdc);
>>> +       tdc->dma_desc = NULL;
>>> +
>>> +       vchan_get_all_descriptors(&tdc->vc, &head);
>>> +       spin_unlock_irqrestore(&tdc->vc.lock, flags);
>>> +
>>> +       vchan_dma_desc_free_list(&tdc->vc, &head);
>>> +
>>> +       return 0;
>>> +}
>>>
>>> +static irqreturn_t tegra_dma_isr(int irq, void *dev_id) {
>>> +       struct tegra_dma_channel *tdc = dev_id;
>>> +       struct tegra_dma_desc *dma_desc = tdc->dma_desc;
>>> +       struct tegra_dma_sg_req *sg_req;
>>> +       u32 status;
>>> +
>>> +       /* Check channel error status register */
>>> +       status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_ERR_STATUS);
>>> +       if (status) {
>>> +               tegra_dma_chan_decode_error(tdc, status);
>>> +               tegra_dma_dump_chan_regs(tdc);
>>> +               tdc_write(tdc, TEGRA_GPCDMA_CHAN_ERR_STATUS, 0xFFFFFFFF);
>>> +       }
>>> +
>>> +       status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_STATUS);
>>> +       if (!(status & TEGRA_GPCDMA_STATUS_ISE_EOC))
>>> +               return IRQ_HANDLED;
>>> +
>>> +       tdc_write(tdc, TEGRA_GPCDMA_CHAN_STATUS,
>>> +                 TEGRA_GPCDMA_STATUS_ISE_EOC);
>>> +
>>> +       spin_lock(&tdc->vc.lock);
>>> +       if (!dma_desc)
>> All checks and assignments must be done inside of critical section.
> 
> Okay. So, the lock should be held throughout the function.
> Do you think tegra_dma_pause should also hold a lock
> and remove irq_synchronize? That function also writes
> to CSR register.

Interrupt handler shall not unpause channel in a case of race condition,
it should handle completed transfer and check whether channel is paused
before issuing next transfer.
So yes, pause also needs a lock.
