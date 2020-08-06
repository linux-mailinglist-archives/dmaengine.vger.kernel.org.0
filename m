Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B8123DE4E
	for <lists+dmaengine@lfdr.de>; Thu,  6 Aug 2020 19:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbgHFRYY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Aug 2020 13:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729929AbgHFREn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Aug 2020 13:04:43 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A516C03460C;
        Thu,  6 Aug 2020 07:22:50 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 185so41736659ljj.7;
        Thu, 06 Aug 2020 07:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XByk4zQLeWdVJ99jAPoK52EaFY9Nq96sXFd7ZxTXSZs=;
        b=T0JlCXRlEg1AKCwQb1Q6HbT/3xfXPI1KwN7z3+S4H2XdoJf5sckRXpOd32Vj99hdZL
         37mV132mg68iZ3zO5YvGKQBpF4ZmLRSkbzl9rdYzDZZDGFw8O8b+S0Uq9Vq50z6pIVR+
         7zD4im9G8SYACEta3zEIjft/lAZB1aTVdYmJ+L3Y0S34NidBHYZ7yh9ee/J2ye9CgA3P
         /lJ5WIpzDneUNMyM1VHVqjwIAPrL0Pxab33D5KBqnh67nkkXTXcLe+46/lNeUrb+LrsA
         5VQFpXLPhIINuM8eV5bGVSYNijh7laO+zCxpNisCSy8HwtoQkSIowyDIIujk9DMonPW4
         gdow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XByk4zQLeWdVJ99jAPoK52EaFY9Nq96sXFd7ZxTXSZs=;
        b=LsiPdCSSIGezBLwLMm67zLU5h4j/XH/3HNXICixllh2bQwJih88B/4+HMoie+FYAat
         kPjz35npSDaoyd0v+njcqFdK7FXP4c/n/piP7hjvYU/R8/003cKpo6CPdP0m3MBa4hT5
         IXQd23k6FVopVTHZLxo/1OmVhuq+qhgrEJ05UxYUjsLpR6gLwEwX48wqfZkmsl2H9dlz
         2O8v++SH54T/V18McZQLjyYb57U+QAWH7vMGywHMTFPypa0MRncRtStop/lNR7EzBY+5
         41HU8jmRsd9FL4PjGSZmCpLdwlCLpLD2bZ2Mjmh3dTBlcw/twNkkXB2NRhbc0gAYTXqd
         CS6Q==
X-Gm-Message-State: AOAM532aEAxUGSRASymmXM040IztMx4Ikt5XrnZEAokGqrhrYKUTAvvN
        dbfjGgo1untPtR7UEDivDrA=
X-Google-Smtp-Source: ABdhPJxA2Tkfxwf/RHpIug+GOl8r/RwGGUhTAJxYzx5jCzoXQ539huOTFz7Djjq2XQjHvs9c2QBk/Q==
X-Received: by 2002:a2e:3c03:: with SMTP id j3mr3998129lja.397.1596723767006;
        Thu, 06 Aug 2020 07:22:47 -0700 (PDT)
Received: from [192.168.2.145] (94-29-41-50.dynamic.spd-mgts.ru. [94.29.41.50])
        by smtp.googlemail.com with ESMTPSA id h17sm2479535ljj.118.2020.08.06.07.22.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 07:22:45 -0700 (PDT)
Subject: Re: [Patch v2 2/4] dmaengine: tegra: Add Tegra GPC DMA driver
To:     Rajesh Gumasta <rgumasta@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Pavan Kunapuli <pkunapuli@nvidia.com>
References: <1596699006-9934-1-git-send-email-rgumasta@nvidia.com>
 <1596699006-9934-3-git-send-email-rgumasta@nvidia.com>
 <bc7d0d9d-ac7f-b720-64f5-63e0c76e6786@gmail.com>
 <CH2PR12MB41350E273B36463F9B372A52A2480@CH2PR12MB4135.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <8fa139f2-685e-9e19-df55-bc7f84ec9a4c@gmail.com>
Date:   Thu, 6 Aug 2020 17:22:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CH2PR12MB41350E273B36463F9B372A52A2480@CH2PR12MB4135.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

06.08.2020 16:56, Rajesh Gumasta пишет:
...
>>> +static const struct __maybe_unused dev_pm_ops
>> tegra_dma_dev_pm_ops = {
>>> +     SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(tegra_dma_pm_suspend,
>>> +tegra_dma_pm_resume) };
>>
>> Please explain why this is needed. All DMA should be stopped (not
>> paused) on system's suspend, shouldn't it?
> I have rechecked with HW verification team and they confirmed that after suspend, csr and channel registers will get reset hence on resume we need to restore back.
> Also GPCDMA does not support power gate as a unit.

But all registers are re-programmed on starting a DMA transfer, hence
why do you need to save-restore them on suspend-resume?
