Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C33B4A35A0
	for <lists+dmaengine@lfdr.de>; Sun, 30 Jan 2022 11:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354527AbiA3KN5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 30 Jan 2022 05:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbiA3KN4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 30 Jan 2022 05:13:56 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6A7C061714;
        Sun, 30 Jan 2022 02:13:56 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id o12so20745399lfg.12;
        Sun, 30 Jan 2022 02:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=Mf4rn/A93bs+tmhafEPat6ShjRZdodZqjQlp0CtF5tA=;
        b=p9dWggsBwKunubvgI2bpM/+6WCxYsCukW69+H3jEnrH7FMZIYJuk3Dd/OLqZmQydBC
         HbwJuPeU/FVtPetRy2GniUIAyntc5KiUGUZodlzN2dqI9a3KjcxXZSo4cbSEJbPn2Nfp
         LHDOz9vKga/NbrrStSgb9+fxTmla9V0y3nEv7nLmuj0kNDqMBEzGNRPjYDRVXyxWjl/v
         GV96DDeLdCAIDhJJVQYTFvoRORY+A1jdWmmr+T4aDBfAOsXSrvYJCSmI13aRooNr/N+p
         2wbfh2CdKtomErsw86F/noH1zwYaRsJ5Vx4zMPIgubtDvHDH4m0h7pR9MWy5mWDld3ml
         F9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=Mf4rn/A93bs+tmhafEPat6ShjRZdodZqjQlp0CtF5tA=;
        b=LoLF4sU8OV24VBd7cakSugntLyxLfEN//QdsareeNPRgqPYTDPmfX5Inm2BlSsneq6
         8v6IMZtdciquCjQo2jpecpc7Va72xLDiHaA3Y9kiGsMhgMN1WBp+K9LuwuhRymnhvWl/
         JcyRSYA8rM1L6faF1VdVB2UwTV3+CpMl/us1CK1lYxJQbJ0EyY8AyHXW9D8g7QVhgK0g
         TAIUJa9aMfzenroTF4sVRPnAWAfazLMgJvu/bsuEJJrQXbuTmY6LDpj7yMI1UR8HdPj7
         mRhqsugchQ3EbGTQi15Z55JEgR20sbdmhnGTa4r6mL4KwPei7ptznHpjprRqnY6Mj2sr
         lmjQ==
X-Gm-Message-State: AOAM531Xhmj2jrDkZ96OYdZimq0OzHITFA7Sa9/5al280fOAlF8QD+fX
        Mu2s5fI8Wdg19dv/svtxMyY=
X-Google-Smtp-Source: ABdhPJyLOEuXB+Vm7LBwhVralrs9NisjJuqMK+5cELlGrrXwxMZqon7gdjZiWo78mQBPbyAYPPpUDw==
X-Received: by 2002:a05:6512:3408:: with SMTP id i8mr11609722lfr.17.1643537634571;
        Sun, 30 Jan 2022 02:13:54 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-126.dynamic.spd-mgts.ru. [109.252.138.126])
        by smtp.googlemail.com with ESMTPSA id bt5sm3220443lfb.38.2022.01.30.02.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jan 2022 02:13:54 -0800 (PST)
Message-ID: <07aa10e7-22da-3844-8d6a-476ad0ea2e2e@gmail.com>
Date:   Sun, 30 Jan 2022 13:13:53 +0300
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
In-Reply-To: <d45b57c7-2dc0-d971-42ac-aa33b2ee7d6b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

30.01.2022 13:08, Dmitry Osipenko пишет:
> 30.01.2022 13:05, Dmitry Osipenko пишет:
>> static int tegra_dma_device_resume(struct dma_chan *dc)
>> {
>> 	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
>> 	u32 val;
>>
>> 	if (!tdc->tdma->chip_data->hw_support_pause)
>> 		return -ENOSYS;
>>
>> 	if (!tdc->dma_desc)
>> 		return 0;
>>
>> 	val = tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSRE);
>> 	val &= ~TEGRA_GPCDMA_CHAN_CSRE_PAUSE;
>> 	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSRE, val);
>> 	
>> 	enable_irq(tdc->irq);
> 
> Correction:
> 
> if (tdc->dma_desc) {
> 	val = tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSRE);
> 	val &= ~TEGRA_GPCDMA_CHAN_CSRE_PAUSE;
> 	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSRE, val);
> }
> 
> enable_irq(tdc->irq);

And apparently, tegra_dma_terminate_all() also needs to take care of
removing the PAUSE bit. Otherwise it won't be possible to unpause
channel after the termination.
