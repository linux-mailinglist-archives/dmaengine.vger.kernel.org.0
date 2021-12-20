Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9C347B117
	for <lists+dmaengine@lfdr.de>; Mon, 20 Dec 2021 17:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbhLTQak (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Dec 2021 11:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbhLTQak (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Dec 2021 11:30:40 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D86C061574;
        Mon, 20 Dec 2021 08:30:39 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id p8so16892830ljo.5;
        Mon, 20 Dec 2021 08:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nK8wg+ThtsoRIQwEeu/rFUoiyE0C3jF2d8qNzRJpLtg=;
        b=PVa6mW0XBS4KPJfueUBFvXIwYWZmvnmySIfaMqWEpB0lP6zy0Uc1f0yuHc0fc7zNGQ
         a3nkiy50XW9M5moJt4JeFgvKGdTTc8TQbtuFz6BtR77XOdAIo0DcbzIjkCKbhYznk+dl
         NATRsoEfZ+bHYsdbCrwwu80EuoZ/WNjnopXuwYSx3DD5VSr/yjsXSOylvhl+rkfwJLW2
         eVfAYAJlDSeCxUsIEM9CufwTPGohPTm+S7MIhR58LB1RbbGkQX8wO838qB/CvdYSMYGT
         PWMie9fFdAgFEx6RnWdpTPvSM6yunpyzPBaGvOc/6UZqvgDRYJiilzZ/V/ora8eNTiz0
         mgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nK8wg+ThtsoRIQwEeu/rFUoiyE0C3jF2d8qNzRJpLtg=;
        b=c4P4mwlYEh/4dEiLAQe4a/2CrFbuDGllg7finWMUeJSQ+jBxPBY8/MaH9PP2cGQ5u6
         KyCXlYU45bN9QOivCGvxh5zQqKlfHZwQYe1zEA7od2X6bdOr2gxXPWdOk664OtSq2bmX
         CixAZWdvJho71/jJmVkxdiarcitBooJ62o6c5uTn9j21EuACgJVcFJsZvRFN3EXTAqHp
         wX/WVIwI8Gsd+9udagLk+LtsPZQ3av53klZ+8bwsVv4AmmiOKeIGPVWsuFLLp3p/p3Zo
         6d/5CqiVxjAgad/s2w3f8D+ikgKg9VkM9I9EHgl3atCRR/cRz2Ko98XTSPDVlBvJ4HLm
         YhwQ==
X-Gm-Message-State: AOAM533/VmS64aFAAIgbT6kCeSrIyJut+Rfi27YH276oDVqqD0pksY+T
        UfcEzM2ULQ5DmpY0/kDsRZupu+e8X88=
X-Google-Smtp-Source: ABdhPJwws576TxlN6hEqFkLDXPljO1c5WA7L1xawr9flrLIxu2o7FFQHQ2wlBv6l1HukG44jKfrVgw==
X-Received: by 2002:a2e:2410:: with SMTP id k16mr15499339ljk.441.1640017838131;
        Mon, 20 Dec 2021 08:30:38 -0800 (PST)
Received: from [192.168.2.145] (46-138-43-24.dynamic.spd-mgts.ru. [46.138.43.24])
        by smtp.googlemail.com with ESMTPSA id o19sm1379904lfu.149.2021.12.20.08.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 08:30:37 -0800 (PST)
Subject: Re: [PATCH v15 2/4] dmaengine: tegra: Add tegra gpcdma driver
To:     Akhil R <akhilrajeev@nvidia.com>
Cc:     Pavan Kunapuli <pkunapuli@nvidia.com>,
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
References: <1639674720-18930-1-git-send-email-akhilrajeev@nvidia.com>
 <1639674720-18930-3-git-send-email-akhilrajeev@nvidia.com>
 <45ba3abe-5e7e-4917-2b23-0616a758c4eb@gmail.com>
 <BN9PR12MB52730121B2B01739DA52020EC07B9@BN9PR12MB5273.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <6241cfa3-dd7e-012c-3687-daad0aa4631d@gmail.com>
Date:   Mon, 20 Dec 2021 19:30:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <BN9PR12MB52730121B2B01739DA52020EC07B9@BN9PR12MB5273.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

20.12.2021 18:23, Akhil R пишет:
>> 16.12.2021 20:11, Akhil R пишет:
>>> +static int tegra_dma_terminate_all(struct dma_chan *dc) {
>>> +     struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
>>> +     unsigned long wcount = 0;
>>> +     unsigned long status;
>>> +     unsigned long flags;
>>> +     int err;
>>> +
>>> +     raw_spin_lock_irqsave(&tdc->lock, flags);
>>> +
>>> +     if (!tdc->dma_desc) {
>>> +             raw_spin_unlock_irqrestore(&tdc->lock, flags);
>>> +             return 0;
>>> +     }
>>> +
>>> +     if (!tdc->busy)
>>> +             goto skip_dma_stop;
>>> +
>>> +     if (tdc->tdma->chip_data->hw_support_pause)
>>> +             err = tegra_dma_pause(tdc);
>>> +     else
>>> +             err = tegra_dma_stop_client(tdc);
>>> +
>>> +     if (err) {
>>> +             raw_spin_unlock_irqrestore(&tdc->lock, flags);
>>> +             return err;
>>> +     }
>>> +
>>> +     status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_STATUS);
>>> +     if (status & TEGRA_GPCDMA_STATUS_ISE_EOC) {
>>> +             dev_dbg(tdc2dev(tdc), "%s():handling isr\n", __func__);
>>> +             tegra_dma_xfer_complete(tdc);
>>> +             status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_STATUS);
>>> +     }
>>> +
>>> +     wcount = tdc_read(tdc, TEGRA_GPCDMA_CHAN_XFER_COUNT);
>>> +     tegra_dma_stop(tdc);
>>> +
>>> +     tdc->dma_desc->bytes_transferred +=
>>> +                     tdc->dma_desc->bytes_requested - (wcount * 4);
>>> +
>>> +skip_dma_stop:
>>> +     tegra_dma_sid_free(tdc);
>>> +     vchan_free_chan_resources(&tdc->vc);
>>> +     kfree(&tdc->vc);
>>
>> You really going to kfree the head of tegra_dma_channel here? Once again, this
>> code was 100% untested :/
> I did validate this using DMATEST which did not show any error.
> https://www.kernel.org/doc/html/latest/driver-api/dmaengine/dmatest.html
> Do you suggest something better?
> 
>> You're not allowed to free channel from the dma_terminate_all() callback. This
>> callback terminates submitted descs, that's it.
>>
> Sorry, I am relatively new to DMA framework (probably you get it from the patch 
> version no. :)). I read your previous comment as to use tdc->vc instead of dma_desc.
> I would learn a bit more and update with a change. Thanks for the inputs.

Looks like DMATEST doesn't try to terminate in a middle of transfer and
then check that further transfers work. You may try to extend DMATEST or
simulate I2C error to test it, you should also test it with enabled KASAN.
