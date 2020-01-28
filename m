Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F33F14BC57
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jan 2020 15:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgA1OxJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Jan 2020 09:53:09 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37272 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgA1OxJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Jan 2020 09:53:09 -0500
Received: by mail-lj1-f195.google.com with SMTP id v17so15023379ljg.4;
        Tue, 28 Jan 2020 06:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U/Ya9HgJWhgUTwQZYe1oiJhltZSo1E2iHMK7KNQPMfY=;
        b=Hodtc920lvy8sd8TOTlPdC/iSYLKAGwpRDk06V/01Ur3aQ4XL1ivGkNnH84m2XjAn1
         gGLP60qux/AnellnnVvVspIXPaLRsziphTxCBokG4OTCtZ37vGJY3/YoQ2fa9RmNWcuw
         ZV86MylNds9Suufer9RChI2yJlqms8dr4wV4zQwlHVmMfjWRHPNtMMtWIgY981nuxJsS
         4tdkUc+CqcFdlyhyvWbWqu3IjfoNzIVRRtQvsxGCcRsUqvsNlvo1NMi0Af120Fi5YKK+
         BxdcmSxZWWgyU7tyEmQ0FOuBXEVAgcxCB1ZjL7J/Dy0tCkLWHON44PcYQozxI1tzq6Xo
         O5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U/Ya9HgJWhgUTwQZYe1oiJhltZSo1E2iHMK7KNQPMfY=;
        b=fl33GQHmo6O1cXOiJbcka+vqgWU/3ZBCV8Htmy7j1Is6VidKNr/qbqr0oXoz06HZlj
         kcbcuEifTCpLjiR26BB1MqiXf5TtL8ZZnFqwgH/QqS5bpMFunyFocT9ZFR7hyDpr45uE
         RgMeosSH6xw68mnjDxCFSxlWrgHYRDLTEAf2nBCTUeDnLS5Uub/481Mo3RKW5TfzOJRS
         UY/Haq15GHLyNGHv3fWmS/oFHRWYN0prtSCGwO5QQoAO3U4CFK+8h3UuqMyw+0msKsGN
         8fp8dPFg7DJn1vmdPCA1JZkpJ4eDt91QLVqCwRZtF1eYbKRHweECBIYhpQu0Th42nWl9
         Lqdw==
X-Gm-Message-State: APjAAAXwMvA+lX1A1rUHrmjZI6b/sDpCJ/at+PkHd4LAhmLlDkvTB7fO
        foku411XUvG3HhsBpvC8qdhcJLXg
X-Google-Smtp-Source: APXvYqw9Pp2WA7B96iEHSu67EpIA7RH2scmzETdUu6IFWu6gJGRHjOAtKCEWC03WfutzAH5DvVqD2w==
X-Received: by 2002:a2e:7009:: with SMTP id l9mr13222873ljc.96.1580223186894;
        Tue, 28 Jan 2020 06:53:06 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id j19sm12072651lfb.90.2020.01.28.06.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 06:53:06 -0800 (PST)
Subject: Re: [PATCH v4 11/14] dmaengine: tegra-apb: Clean up suspend-resume
To:     Jon Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200112173006.29863-1-digetx@gmail.com>
 <20200112173006.29863-12-digetx@gmail.com>
 <7e0d2cfa-5570-93e6-e3dc-7d3f6902a528@gmail.com>
 <831d5e28-72df-3175-bfb6-b33985d93a52@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e245618c-6ae9-18d9-5671-1d6c0cf47a39@gmail.com>
Date:   Tue, 28 Jan 2020 17:53:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <831d5e28-72df-3175-bfb6-b33985d93a52@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

28.01.2020 17:10, Jon Hunter пишет:
> 
> On 21/01/2020 21:23, Dmitry Osipenko wrote:
>> 12.01.2020 20:30, Dmitry Osipenko пишет:
>>> It is enough to check whether hardware is busy on suspend and to reset
>>> it across of suspend-resume because channel's configuration is fully
>>> re-programmed on each DMA transaction anyways and because save-restore
>>> of an active channel won't end up well without pausing transfer prior to
>>> saving of the state (note that all channels shall be idling at the time of
>>> suspend, so save-restore is not needed at all).
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/dma/tegra20-apb-dma.c | 131 +++++++++++++++++-----------------
>>>  1 file changed, 67 insertions(+), 64 deletions(-)
>>>
>>> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
>>> index b9d8e57eaf54..398a0e1d6506 100644
>>> --- a/drivers/dma/tegra20-apb-dma.c
>>> +++ b/drivers/dma/tegra20-apb-dma.c
>>> @@ -1392,6 +1392,36 @@ static const struct tegra_dma_chip_data tegra148_dma_chip_data = {
>>>  	.support_separate_wcount_reg = true,
>>>  };
>>>  
>>> +static int tegra_dma_init_hw(struct tegra_dma *tdma)
>>> +{
>>> +	int err;
>>> +
>>> +	err = reset_control_assert(tdma->rst);
>>> +	if (err) {
>>> +		dev_err(tdma->dev, "failed to assert reset: %d\n", err);
>>> +		return err;
>>> +	}
>>> +
>>> +	err = clk_enable(tdma->dma_clk);
>>> +	if (err) {
>>> +		dev_err(tdma->dev, "failed to enable clk: %d\n", err);
>>> +		return err;
>>> +	}
>>> +
>>> +	/* reset DMA controller */
>>> +	udelay(2);
>>> +	reset_control_deassert(tdma->rst);
>>> +
>>> +	/* enable global DMA registers */
>>> +	tdma_write(tdma, TEGRA_APBDMA_GENERAL, TEGRA_APBDMA_GENERAL_ENABLE);
>>> +	tdma_write(tdma, TEGRA_APBDMA_CONTROL, 0);
>>> +	tdma_write(tdma, TEGRA_APBDMA_IRQ_MASK_SET, 0xFFFFFFFF);
>>> +
>>> +	clk_disable(tdma->dma_clk);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>  static int tegra_dma_probe(struct platform_device *pdev)
>>>  {
>>>  	const struct tegra_dma_chip_data *cdata;
>>> @@ -1433,30 +1463,18 @@ static int tegra_dma_probe(struct platform_device *pdev)
>>>  	if (ret)
>>>  		return ret;
>>>  
>>> +	ret = tegra_dma_init_hw(tdma);
>>> +	if (ret)
>>> +		goto err_clk_unprepare;
>>> +
>>>  	pm_runtime_irq_safe(&pdev->dev);
>>>  	pm_runtime_enable(&pdev->dev);
>>>  	if (!pm_runtime_enabled(&pdev->dev)) {
>>>  		ret = tegra_dma_runtime_resume(&pdev->dev);
>>>  		if (ret)
>>>  			goto err_clk_unprepare;
>>
>> Jon, but isn't the RPM mandatory for all Tegra SoCs now and thus
>> guaranteed to be enabled? Maybe we should start to remove handling the
>> case of unavailable RPM from all Tegra drivers?
> 
> Yes that's true, even ARCH_TEGRA selects PM now

I already sent out v5 with the !RPM handling removed from the code,
please take a look at it.
