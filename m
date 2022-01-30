Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914E04A35BB
	for <lists+dmaengine@lfdr.de>; Sun, 30 Jan 2022 11:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354610AbiA3Kdz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 30 Jan 2022 05:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiA3Kdy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 30 Jan 2022 05:33:54 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AE2C061714;
        Sun, 30 Jan 2022 02:33:54 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id x23so20995045lfc.0;
        Sun, 30 Jan 2022 02:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=qogYnykCq8GPqjgSxhoKbfcFb8+hulxt7m27U6WNjps=;
        b=cLiFhSrHn0IyGSVbqITyXEXxJchtGzRn3Nk683Q3sZ1pUaAUycOJrkdcX4LOb4vPp3
         9WHBxHU2wJOporKYgXlP1M+qiwzCcMNyYCqdrzrjGJl/LMANVBJ+ULpA+AnHVRjwkkmr
         QVhVCcUChLaULEQ6eEfHvMJQ7ODmFn/EoTlnwVZyOgaBKTyDCdew1xyjiZ3kwJZG+co+
         k/l+vf7qzznf+ZvmHgGlzs4UtDkdIMLL6F8poOLjOoGw8h0S5j/CM5N8VeANRnb49qSp
         AMl9siDlHP/OBi8/Zuyxr7UGaRObIBJFMv1jcKqh+5IGu2FYJYkRAZCXUDe81YKTIt+l
         ceXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=qogYnykCq8GPqjgSxhoKbfcFb8+hulxt7m27U6WNjps=;
        b=rapjS3PsXa156/bMTfM278MUsm6KvlFK+akJryNYBczIvYNQh2Ywd5sjvQAadkvHOL
         uy217jzSBkZgJaGUu0L/W5ODiiMeeEU/w0c3FTcnNT9qX6thywa8Vw3c+AgBy9jHTDlY
         Ev/BQ2W3wRd5PqgoMUUROgUm1hlyutUUflfw4t6sFruasWtXWXlyMHuwxdoej7OkGbk3
         a0A9X0Mz/LB+FAdpsbf/KbyTAdQ2xZqjnPvj9Ew520vV6hWJyoKtNU8LMLoeq/uO0UQj
         e+ACGjZSWB994j779KXfa6NQi6eRK+fwp5rBIwAGEykoMZFCzsOfeuTKGyOK3sLWiIid
         l9Gg==
X-Gm-Message-State: AOAM531dOKxckAnFKbidC0QLQP5di/QUMCO+gc0lJ/wjwnkexYwkwHSJ
        qT44OLG+bNa2ZYK5HGa+RfM=
X-Google-Smtp-Source: ABdhPJzduR146OXne0GOzLqFHOt0mkr4cvN2mvV/JXrbzijRxEzWmQwz0n5JcW4bZquOuleGEGVwyw==
X-Received: by 2002:ac2:4118:: with SMTP id b24mr11744551lfi.64.1643538832692;
        Sun, 30 Jan 2022 02:33:52 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-126.dynamic.spd-mgts.ru. [109.252.138.126])
        by smtp.googlemail.com with ESMTPSA id bu32sm3224069lfb.287.2022.01.30.02.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jan 2022 02:33:52 -0800 (PST)
Message-ID: <f32e119a-1d08-d1f9-a264-fe004960e8bf@gmail.com>
Date:   Sun, 30 Jan 2022 13:33:51 +0300
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
 <dcd4e4db-2999-15c9-0c82-42dd8ca1e61d@gmail.com>
In-Reply-To: <dcd4e4db-2999-15c9-0c82-42dd8ca1e61d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

30.01.2022 13:26, Dmitry Osipenko пишет:
> 30.01.2022 13:05, Dmitry Osipenko пишет:
>> Still nothing prevents interrupt handler to fire during the pause.
>>
>> What you actually need to do is to disable/enable interrupt. This will
>> prevent the interrupt racing and then pause/resume may look like this:
> 
> Although, seems this won't work, unfortunately. I see now that
> device_pause() doesn't have might_sleep().
> 

Ah, I see now that the pause/unpause is actually a separate control and
doesn't conflict with "start next transfer".

So you just need to set/unset the pause under lock. And don't touch
tdc->dma_desc. That's it.

static int tegra_dma_device_pause(struct dma_chan *dc)
{
	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
	unsigned long flags;
	u32 val;

	if (!tdc->tdma->chip_data->hw_support_pause)
		return -ENOSYS;

	spin_lock_irqsave(&tdc->vc.lock, flags);

	val = tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSRE);
	val |= TEGRA_GPCDMA_CHAN_CSRE_PAUSE;
	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSRE, val);

	spin_unlock_irqrestore(&tdc->vc.lock, flags);

	return 0;
}

static int tegra_dma_device_resume(struct dma_chan *dc)
{
	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
	unsigned long flags;
	u32 val;

	if (!tdc->tdma->chip_data->hw_support_pause)
		return -ENOSYS;

	spin_lock_irqsave(&tdc->vc.lock, flags);

	val = tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSRE);
	val &= ~TEGRA_GPCDMA_CHAN_CSRE_PAUSE;
	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSRE, val);

	spin_unlock_irqrestore(&tdc->vc.lock, flags);
	
	return 0;
}
