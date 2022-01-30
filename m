Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35DD84A3597
	for <lists+dmaengine@lfdr.de>; Sun, 30 Jan 2022 11:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354338AbiA3KIr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 30 Jan 2022 05:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbiA3KIq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 30 Jan 2022 05:08:46 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610B3C061714;
        Sun, 30 Jan 2022 02:08:46 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id z19so20702234lfq.13;
        Sun, 30 Jan 2022 02:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=lFNcKlSH5KtcDIj5MqSGHoOrKKxYl2D5zTBr+vsWA4A=;
        b=YI871gBk8vOsYDap0COhaAJ7rRECMB8avgXTBwkdW3QObBpGaqo84vWXJ93H4ZfPGr
         o8xsMqUvb8tXHZovIAWNGpWEE6Gq0MgrgWQEzFs9LHnD9qezjACC8e/cON/eKcn219AM
         d6tlj3aeexjensmtUxXnRqrNeXI8rJo8VpLOAIXK5CIJmF38hTeUZ4Y7bXl7qC6TRhoR
         0wrW8pHUJMvY07Y17NdNtTLjD7PsZR8+uelseH3XwdjH35h4NwWNec4kIVv6sTtHbOaC
         kV9mOh493OL6QSGoJk+xli2Y8aC8KMWpyJeJS5LaAN7wB4dmySCvVZvL6tzccAEYtMmW
         yqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=lFNcKlSH5KtcDIj5MqSGHoOrKKxYl2D5zTBr+vsWA4A=;
        b=Sr9ALU37X3H4M3hJ/TIRlGmoxInavhDB1757AagYqe9amaldT7VluXTmzi+NIHJLMf
         iqyuRltvUg6YVWKk2DeEtQD6kJ3WwRAZe2UsmNx+lTcBsIL/3M/MmwJfk7CnxwGWadPn
         zwHFjyEtuAF5p0rhVTaN3dOG9ac1ocsRJsb2/LrdVQAavhjJyoLCYKSwcKVVphLcDS/A
         /LzCqAYVT2Lh4XC5MzWz9Ymx8RsAtbNtoYY42kjl5XIeOgdkUenxbtolnmgpAyLc2tQI
         DSMOAXo8RcJv7urN5coK2rp+XXZtmgTkWYsFDMU1YAxakVDWNioWJ/5UGwRiG4unlArR
         BlMg==
X-Gm-Message-State: AOAM532pEDx0GvhDvzehGVDpQNnx7iDlmvaW6OIcVg87efRgPKwO+HsH
        B0hR9Tu4cXc939dTWIPbiMg=
X-Google-Smtp-Source: ABdhPJzj0pInEZ599mMyWfEq+FfDMMGg0ChRSHDm4K7PvesKE760/wFI86/QcAJW4JPvmdMhRfJZKg==
X-Received: by 2002:ac2:4e81:: with SMTP id o1mr11483357lfr.557.1643537324297;
        Sun, 30 Jan 2022 02:08:44 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-126.dynamic.spd-mgts.ru. [109.252.138.126])
        by smtp.googlemail.com with ESMTPSA id w13sm2572896lfk.148.2022.01.30.02.08.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jan 2022 02:08:43 -0800 (PST)
Message-ID: <d45b57c7-2dc0-d971-42ac-aa33b2ee7d6b@gmail.com>
Date:   Sun, 30 Jan 2022 13:08:43 +0300
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
In-Reply-To: <ba109465-d7ee-09cb-775b-9b702a3910b0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

30.01.2022 13:05, Dmitry Osipenko пишет:
> static int tegra_dma_device_resume(struct dma_chan *dc)
> {
> 	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
> 	u32 val;
> 
> 	if (!tdc->tdma->chip_data->hw_support_pause)
> 		return -ENOSYS;
> 
> 	if (!tdc->dma_desc)
> 		return 0;
> 
> 	val = tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSRE);
> 	val &= ~TEGRA_GPCDMA_CHAN_CSRE_PAUSE;
> 	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSRE, val);
> 	
> 	enable_irq(tdc->irq);

Correction:

if (tdc->dma_desc) {
	val = tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSRE);
	val &= ~TEGRA_GPCDMA_CHAN_CSRE_PAUSE;
	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSRE, val);
}

enable_irq(tdc->irq);
