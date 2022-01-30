Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360564A3ADF
	for <lists+dmaengine@lfdr.de>; Mon, 31 Jan 2022 00:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbiA3XLs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 30 Jan 2022 18:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356805AbiA3XLp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 30 Jan 2022 18:11:45 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB9DC061714;
        Sun, 30 Jan 2022 15:11:44 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id u6so23177493lfm.10;
        Sun, 30 Jan 2022 15:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fBazUoManQmdCOgsGnYl8pWs8Dgsrr/yW5B1ya2FEso=;
        b=kXcT76Ehpw97klLUe1NbiJ0Hd9PCFkTohf9mqSOw84cGUws54aaiEF93maRWcwgzkC
         UgPjZmMTXIq96JADlDRaqJZJYwULe1UdNr4+ythUnIilnlq2BfVI7XZpvNilR2/dKBwD
         eTvNl1uOV7H6j48EBrHsJ45xnr/mbsqfIifWds5mJ0f/HslUswKTam22TTei9lq0SROP
         mLhD3Sl9/5p9PYaWT0v8wEPDNEH0laWRBbdMmBNqUHGXA6ssUySj/Zceoy3L2cJUsKnj
         Oq5zzJBchhW+HRb/hS1mSi+9IpCnX162IvyBbTgsZbQ1G9jBHG4n3bn+wBSTpfKvBfI1
         VPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fBazUoManQmdCOgsGnYl8pWs8Dgsrr/yW5B1ya2FEso=;
        b=xQBlS/IlNALV/jAqnI+sEG7rPJjWcR7lqKtb46MSsOClFHsf6QYubwnii+U6dDyFPW
         gjYujX0ykfeO2SBWN0KpQFCr4XEYAEo+oVfIVJDa+FQXUPZokVYHQI+KAiE1MFrKkVDc
         coamb9tUJeXCZjuEvT8r/o1mfP/WAAX9lVzVtFzD7JSMhMOqDyMebWr29ZDCVm/sINRR
         L/SieNDpbXjpN3pxejuzJLQYKPUpXHnAZVHHJcLg6nerO1+5hsVVKHFK+adrzLKSjp1T
         sHj/MpZ5E0FmDvncQrMhqI2+xfFsDvxX+ygOn1yRj76ii3nmXttLBLMqkB0+bvQuzQwk
         VAnQ==
X-Gm-Message-State: AOAM533LVqYAzBAmuBtxzkZlML+s183NmvAyhzaSIGTrBNxgP3IzWXrp
        AWDpjE21LC35FEERpxhnYTY=
X-Google-Smtp-Source: ABdhPJxQCslvN2wphyp5gdfJHOCkv2vF9rSTO8WVZr5H+FWJDqc4bVz/uuv9QFu4ovxDSFAhJ/iSsA==
X-Received: by 2002:ac2:5c4d:: with SMTP id s13mr13550392lfp.324.1643584302676;
        Sun, 30 Jan 2022 15:11:42 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-126.dynamic.spd-mgts.ru. [109.252.138.126])
        by smtp.googlemail.com with ESMTPSA id d25sm1019704lfe.297.2022.01.30.15.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jan 2022 15:11:42 -0800 (PST)
Message-ID: <08f6571e-af75-b6b3-443e-e86e3bdb365b@gmail.com>
Date:   Mon, 31 Jan 2022 02:11:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v17 2/4] dmaengine: tegra: Add tegra gpcdma driver
Content-Language: en-US
To:     Akhil R <akhilrajeev@nvidia.com>,
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
References: <1643474453-32619-1-git-send-email-akhilrajeev@nvidia.com>
 <1643474453-32619-3-git-send-email-akhilrajeev@nvidia.com>
 <ba109465-d7ee-09cb-775b-9b702a3910b0@gmail.com>
 <DM5PR12MB1850D836ACDF95008EF74CC7C0249@DM5PR12MB1850.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <DM5PR12MB1850D836ACDF95008EF74CC7C0249@DM5PR12MB1850.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

30.01.2022 19:34, Akhil R пишет:
>> 29.01.2022 19:40, Akhil R пишет:
>>> +static int tegra_dma_device_pause(struct dma_chan *dc) {
>>> +     struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
>>> +     unsigned long wcount, flags;
>>> +     int ret = 0;
>>> +
>>> +     if (!tdc->tdma->chip_data->hw_support_pause)
>>> +             return 0;
>>
>> It's wrong to return zero if pause unsupported, please see what
>> dmaengine_pause() returns.
>>
>>> +
>>> +     spin_lock_irqsave(&tdc->vc.lock, flags);
>>> +     if (!tdc->dma_desc)
>>> +             goto out;
>>> +
>>> +     ret = tegra_dma_pause(tdc);
>>> +     if (ret) {
>>> +             dev_err(tdc2dev(tdc), "DMA pause timed out\n");
>>> +             goto out;
>>> +     }
>>> +
>>> +     wcount = tdc_read(tdc, TEGRA_GPCDMA_CHAN_XFER_COUNT);
>>> +     tdc->dma_desc->bytes_xfer +=
>>> +                     tdc->dma_desc->bytes_req - (wcount * 4);
>>
>> Why transfer is accumulated?
>>
>> Why do you need to update xfer size at all on pause?
> 
> I will verify the calculation. This looks correct only for single sg transaction.
> 
> Updating xfer_size is added to support drivers which pause the transaction
> and read the status before terminating. 
> Eg. https://elixir.bootlin.com/linux/latest/source/drivers/tty/serial/amba-pl011.c

Why you couldn't update the status in tegra_dma_terminate_all()?
