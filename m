Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6926548E987
	for <lists+dmaengine@lfdr.de>; Fri, 14 Jan 2022 12:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240917AbiANL5h (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 14 Jan 2022 06:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiANL5h (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 14 Jan 2022 06:57:37 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F219C061574;
        Fri, 14 Jan 2022 03:57:36 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bu18so6469359lfb.5;
        Fri, 14 Jan 2022 03:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sjN7HPUH7Ug5X0NQ0OoeotHY8BGCzuFrcq6sgpHsOA4=;
        b=AdpLYfxODBkXDQIbyp+qF14sUymbcLVGlDkPE3jNWqBCa3l1kP6oLjsbKnw4yOarVz
         8YpU9/i3nqXBGuOfuw5z33kjebnGB4oFyX8UI2pqFltxqhoxYQ+7SGLN1JjgjanT6W74
         GM+qBmYu/GFX8NJLhMVSNmVC3kIxhQxt8ojChQaw1sZLqHE8UVWe4Kmgfz8ChiL6UUGt
         Usrx18Q9tUSB3LC+IVLy/6bpd3s6cKANn17j+mokwhuxnQYHvA/hZthJc7IhagnRbS82
         ZYhCE16pVB5eQr3Ud+7ZNlTZiJZI0Sp3RUmUjBXW8yqXUDSDOql1WS5FIDTtVok7csIe
         nAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sjN7HPUH7Ug5X0NQ0OoeotHY8BGCzuFrcq6sgpHsOA4=;
        b=246SMfxy72+I8FYQDcQyp16otyBWgnRHIsujMgJ/ogKdbIHUyEkpt2E3uzW+BpK5ii
         /D3dS/cKVr17mzxOaHsXZz6gbkfIqqCwINsUlI+mT+408r3otQJ1Hdd1rDK4lYj2PGAH
         pTlB0o9/Jfx9i0R9cV28SsgfjqnvhvbvD2aZP0ynXZP8Teroz98tFwIoRhCEPTAV4Y8q
         oI5g9Nr/dKpwrFOyBqadwazylj/CXhEzfUUAksWnEb1R29ziE9HFRSk0zSgxCKlcqgJm
         Z86PcFbdoYdGDAEFS0rgFf20ArUP86LlaeY7x9qLBg6VoadfFEXA4XgwhVM9nMlIBqS6
         Te2g==
X-Gm-Message-State: AOAM530E+jZw0iDYkc0qs2C/armkSHNCM64EbuUyhJ8yWCakjuWw0d5n
        oxVrt4t77mlssNVElAwJA5q9IjzoMQU=
X-Google-Smtp-Source: ABdhPJwJlj0n6aU3bkhluqbsKFTna4jWn8pCe5ppGTnreW4zcFhIlJ1YkpoWecjMvDZ3RaPyRr0HaA==
X-Received: by 2002:a2e:9c0c:: with SMTP id s12mr6057309lji.251.1642161454362;
        Fri, 14 Jan 2022 03:57:34 -0800 (PST)
Received: from [192.168.2.145] (46-138-227-157.dynamic.spd-mgts.ru. [46.138.227.157])
        by smtp.googlemail.com with ESMTPSA id a35sm543435ljq.7.2022.01.14.03.57.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 03:57:33 -0800 (PST)
Subject: Re: [PATCH v16 2/4] dmaengine: tegra: Add tegra gpcdma driver
To:     Akhil R <akhilrajeev@nvidia.com>, dan.j.williams@intel.com,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        jonathanh@nvidia.com, kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        p.zabel@pengutronix.de, rgumasta@nvidia.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, vkoul@kernel.org
Cc:     Pavan Kunapuli <pkunapuli@nvidia.com>
References: <1641830718-23650-1-git-send-email-akhilrajeev@nvidia.com>
 <1641830718-23650-3-git-send-email-akhilrajeev@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <16c73e83-b990-7d8e-ddfd-7cbbe7e407ea@gmail.com>
Date:   Fri, 14 Jan 2022 14:57:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1641830718-23650-3-git-send-email-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

10.01.2022 19:05, Akhil R пишет:
> +static int tegra_dma_terminate_all(struct dma_chan *dc)
> +{
> +	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
> +	unsigned long flags;
> +	LIST_HEAD(head);
> +	int err;
> +
> +	if (tdc->dma_desc) {

Needs locking protection against racing with the interrupt handler.
