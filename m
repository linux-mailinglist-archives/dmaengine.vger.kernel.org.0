Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0674E49276E
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jan 2022 14:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbiARNsb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Jan 2022 08:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242543AbiARNs2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Jan 2022 08:48:28 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B4BC06161C;
        Tue, 18 Jan 2022 05:48:27 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id br17so70910855lfb.6;
        Tue, 18 Jan 2022 05:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=17MkQ+D7lcIHENLUZkNE+Wb1M6GLIW0KLmLfLfpyKuY=;
        b=mvTY0w/pN5vJRbVPnoOMSXYgEs0lE5GlWlKV8Luv12ObuBtRxvt7RXJeD2Z0aNH3ce
         PPMNmQnjVcQOy6g/N73ELDWzPO5QURYj60f7BWVvl2JFCrM8hDCL+Ou6UqO4dWJASTUE
         p85+YBd1DD4XiFG9c5igQlX+SSZ84TaUlM8j3MmOtnbCR9w97IzXpN0PdmXOAVK/gJoL
         zMTZ4Ev4EBM5S9UF3Hcub3rkfkbGCeruG6b3ZVGf1C0ZgonWKEWOweucqUJ3XJ7ILIMM
         iuW8AwkGSe5KaKLAHljj1SOLuHXp8YxWfy0G2Edb0RGSiya/37yP/b5x0O9rPqBNAzXr
         kcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=17MkQ+D7lcIHENLUZkNE+Wb1M6GLIW0KLmLfLfpyKuY=;
        b=C69E5gk22bWcOcu7SHgSG1kbiNeKsaLUDpvqULxcpjrKX2SO7yPZS3inaMw1PHHxNo
         i29llskcmsY69uM4SPrX5Eokn6nG2bd2El9ftc6pb06UUssgx3Y9MbKWG9Dz3deyTzpd
         0tuvUeoO7eF4PkyT3uqRbF+pyU6kG8izgOFWSOmrErCLzYqjuVrc0nUaNPQSyIB6bgeb
         VQP8qhOswOfnRyLtSUnYh7kmDMwqdoHIWDjjLsPOVJvVotCKkzyZnLdcK+bBGPdeRbH+
         5HWq16GlyC91ptFGuZLW97bk6umuwwMCDTNIhaEMRYV2MavGBZJaLVAkFRQ194EXfMt4
         ihYw==
X-Gm-Message-State: AOAM532SCUlKmsfxYNHpIxl7lhuGrI3xA9jxTQamRNqZ1glnx6OO5KeG
        OIgxo3R3+OOSQmmRY8tOPzE=
X-Google-Smtp-Source: ABdhPJy5tJQ9AnqnDnEzUgBVyJTQX64dfrMfnDFOnHwhm/zxWsZZI0QlLSJNsTEqxIim+EyvlBxJ6g==
X-Received: by 2002:a05:651c:171c:: with SMTP id be28mr20262368ljb.183.1642513705172;
        Tue, 18 Jan 2022 05:48:25 -0800 (PST)
Received: from [192.168.2.145] (46-138-227-157.dynamic.spd-mgts.ru. [46.138.227.157])
        by smtp.googlemail.com with ESMTPSA id t13sm1625887lji.57.2022.01.18.05.48.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 05:48:24 -0800 (PST)
Message-ID: <683a71b1-049a-bddf-280d-5d5141b59686@gmail.com>
Date:   Tue, 18 Jan 2022 16:48:23 +0300
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
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <DM5PR12MB1850FF1DC4DC1714E31AADB5C0589@DM5PR12MB1850.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

18.01.2022 08:36, Akhil R пишет:
>> 17.01.2022 10:02, Akhil R пишет:
>>>> 10.01.2022 19:05, Akhil R пишет:
>>>>> +static int tegra_dma_terminate_all(struct dma_chan *dc)
>>>>> +{
>>>>> +     struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
>>>>> +     unsigned long flags;
>>>>> +     LIST_HEAD(head);
>>>>> +     int err;
>>>>> +
>>>>> +     if (tdc->dma_desc) {
>>>>
>>>> Needs locking protection against racing with the interrupt handler.
>>> tegra_dma_stop_client() waits for the in-flight transfer
>>> to complete and prevents any additional transfer to start.
>>> Wouldn't it manage the race? Do you see any potential issue there?
>>
>> You should consider interrupt handler like a process running in a
>> parallel thread. The interrupt handler sets tdc->dma_desc to NULL, hence
>> you'll get NULL dereference in tegra_dma_stop_client().
> 
> Is it better if I remove the below part from tegra_dma_stop_client() so
> that dma_desc is not accessed at all?
> 
> +	wcount = tdc_read(tdc, TEGRA_GPCDMA_CHAN_XFER_COUNT);
> +	tdc->dma_desc->bytes_transferred +=
> +			tdc->dma_desc->bytes_requested - (wcount * 4);
> 
> Because I don't see a point in updating the value there. dma_desc is set
> to NULL in the next step in terminate_all() anyway.

That isn't going help you much because you also can't release DMA
descriptor while interrupt handler still may be running and using that
descriptor.
