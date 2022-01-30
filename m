Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCD74A35A5
	for <lists+dmaengine@lfdr.de>; Sun, 30 Jan 2022 11:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354571AbiA3KR3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 30 Jan 2022 05:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbiA3KR2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 30 Jan 2022 05:17:28 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AE5C061714;
        Sun, 30 Jan 2022 02:17:27 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id y15so20763169lfa.9;
        Sun, 30 Jan 2022 02:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=ZNWegZ67d571yqNsvF2oWgdB+Oq2n4q02Y+RZZYGWhQ=;
        b=PKR+C8A2bllUqTpodS/+dmCuzuWSsGQIw4JTKmOWAxapB2gzdGAmk3lP+P9Ti6cu39
         1+rBfssbu6u3iNf2gxk+S4hfaSpYH3ZwKheWjcZ4EFwRfSzqekpBSkhxh6ISUDk4dR6Q
         17qjZxeNTPyjXq+IbjsI10huzvkmLDHndfdEuSaM4l6u2kGhW6MMmriS7KfR8ZPd90RP
         4djBdwYFl8tZJUlGwnAMh1lurzy/9/NTgik4gjUo7NYqboRr0AxLiRyUKWcp+PPO5QWy
         s2jMurLcX3s96ow35x1xCF1Qm0VIaH5SXkfGE9sYSsFLYBZqZGFtH/TlX0d3f4W38cW+
         bMXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=ZNWegZ67d571yqNsvF2oWgdB+Oq2n4q02Y+RZZYGWhQ=;
        b=El/tMZvae/deCxXYtdPToRjzxOdWZd71HpfYtPHxdwShjOOEwRbRmwzZ16cUsf8/jo
         Hlyly8nywtHw+rJClQnMA0HuNMQk+anzjTZk7vzpJSa0+7J7eAPBDquiE9Af5qPiM7gf
         Ts6aThFvDcaNiKVkx2LuiSAE4IFmooNFBPnMp0/dDxj8Wn0Nxam666qsdJ4y6tEQqMXY
         9A4w7qpvvqDEzZPyatfTVgXUxo6Aa01BAi3x1mYHi/OOlEX5buhrh+NU18odJvwa1UeE
         2IPjFX15zRyX3Q+LfKicef3GyCyxsw3pcLY1scdHUjmjGuXUA/QY3v1OCkUkCVIVaDvJ
         dXAQ==
X-Gm-Message-State: AOAM532622W0z46Z+Mbqv7p4HUaHv8Bq6ufJAdDtZojwaD+gQQqjG0Vl
        r+01dWrEXQtLJgMeU4gW5P8=
X-Google-Smtp-Source: ABdhPJyoFeAI22GoffWul7d+/QTSmEUFGpb4w/7BZwAFBtcmqf/TexVkhUwxBJXiOeOIhynG5KOBNA==
X-Received: by 2002:a05:6512:3086:: with SMTP id z6mr6049272lfd.85.1643537846419;
        Sun, 30 Jan 2022 02:17:26 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-126.dynamic.spd-mgts.ru. [109.252.138.126])
        by smtp.googlemail.com with ESMTPSA id j18sm1679914lja.26.2022.01.30.02.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jan 2022 02:17:26 -0800 (PST)
Message-ID: <45e1cbd1-d6dc-6341-399e-df53d5c48bd9@gmail.com>
Date:   Sun, 30 Jan 2022 13:17:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v17 2/4] dmaengine: tegra: Add tegra gpcdma driver
Content-Language: en-US
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Akhil R <akhilrajeev@nvidia.com>, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, jonathanh@nvidia.com,
        kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        p.zabel@pengutronix.de, rgumasta@nvidia.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, vkoul@kernel.org
Cc:     Pavan Kunapuli <pkunapuli@nvidia.com>
References: <1643474453-32619-1-git-send-email-akhilrajeev@nvidia.com>
 <1643474453-32619-3-git-send-email-akhilrajeev@nvidia.com>
 <ba109465-d7ee-09cb-775b-9b702a3910b0@gmail.com>
 <d45b57c7-2dc0-d971-42ac-aa33b2ee7d6b@gmail.com>
 <07aa10e7-22da-3844-8d6a-476ad0ea2e2e@gmail.com>
In-Reply-To: <07aa10e7-22da-3844-8d6a-476ad0ea2e2e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

30.01.2022 13:13, Dmitry Osipenko пишет:
> 30.01.2022 13:08, Dmitry Osipenko пишет:
>> 30.01.2022 13:05, Dmitry Osipenko пишет:
>>> static int tegra_dma_device_resume(struct dma_chan *dc)
>>> {
>>> 	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
>>> 	u32 val;
>>>
>>> 	if (!tdc->tdma->chip_data->hw_support_pause)
>>> 		return -ENOSYS;
>>>
>>> 	if (!tdc->dma_desc)
>>> 		return 0;
>>>
>>> 	val = tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSRE);
>>> 	val &= ~TEGRA_GPCDMA_CHAN_CSRE_PAUSE;
>>> 	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSRE, val);
>>> 	
>>> 	enable_irq(tdc->irq);
>>
>> Correction:
>>
>> if (tdc->dma_desc) {
>> 	val = tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSRE);
>> 	val &= ~TEGRA_GPCDMA_CHAN_CSRE_PAUSE;
>> 	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSRE, val);
>> }
>>
>> enable_irq(tdc->irq);
> 
> And apparently, tegra_dma_terminate_all() also needs to take care of
> removing the PAUSE bit. Otherwise it won't be possible to unpause
> channel after the termination.

Although, will be easier to just do this in the resume:

val = tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSRE);

if (val & TEGRA_GPCDMA_CHAN_CSRE_PAUSE) {
	val &= ~TEGRA_GPCDMA_CHAN_CSRE_PAUSE;
	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSRE, val);
}
