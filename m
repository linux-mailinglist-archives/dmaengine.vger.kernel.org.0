Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45ECB23DCEC
	for <lists+dmaengine@lfdr.de>; Thu,  6 Aug 2020 18:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbgHFQ45 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Aug 2020 12:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728977AbgHFQkm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Aug 2020 12:40:42 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0215AC0A8921;
        Thu,  6 Aug 2020 08:02:44 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id g6so39491697ljn.11;
        Thu, 06 Aug 2020 08:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FRLGrXmYURDQT4jjHt8eSTzOHaMGuqVLG4OQ53qtVbI=;
        b=mK2TApaeMLPwdu9HF70ojxwm7ZUs+w6NO+TI8LWnPh5C3NwdrLHKA2lX59OHagNj2m
         L4BIeBalExOwh/f5brHD8SHCoZ0gnvaM9zkdfNQMb4uxcELZIKE5+jAe4cHBc/+H1HPf
         jcGwM5VhjTh130aLISlmqIA3FUZjYPloD1eK+wOXB8D4hoJO1i2H/IC7Ays5VUF4P+OU
         NZUVr8CQRz1voy64aSsE7xbR65Qflo+gbspbFU+UGY/xHa2Cn3Mh1WC9OLUbcdBlW0PO
         +MRkZemi79hgawLxMTBnfJu8vFvRT1JnQEo5Cy3CT7MlbPTkvf43Lg3719N6MMVb3bZA
         RmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FRLGrXmYURDQT4jjHt8eSTzOHaMGuqVLG4OQ53qtVbI=;
        b=b2DTxJ30uy29QhQokRlu3a1E54bgyrz4FJ6cv6eg2jQNm+tqa4rxV9eedi16GUecog
         SnKKNBwsG6xjq1SdT+BJv0UxUlxd/MlpOTN0ekUHKjCQj4oVpiNMlrUi4C6Fi7FAhQg9
         UCd/KxAUZJsCEBz1bNBPQH+lpK5ph1XsfKiHYnHRokvt7dW7svayh5ttNZsCtdApau02
         Qf7PX2ZcDPoF1xWA6J6BdeEqjoU6ebrRhgDNOOAufc5SBJvnybLaNjn2Zk0LXnV12nYP
         E1isLGwq01K+LYo6wD7c7Jdam9bEP/F4UXaXF60mI/y46UjWzTfta4gNlZdFO5T3pALF
         Yb7w==
X-Gm-Message-State: AOAM531hGP+yCjgdSrJpnCuE5r8HsPmX752JMEDfuDgVWRTxk4PNoRCG
        boJ06fxaI89jjiEFrUXgaHY=
X-Google-Smtp-Source: ABdhPJxmVntrfJXbx7gn5IV414m2Z4GaYwG1UUTqxROn64w7h7pvKoG/QJ1Z9+LJ7Bd1189Ir9ocbg==
X-Received: by 2002:a05:651c:2007:: with SMTP id s7mr3839916ljo.74.1596726156822;
        Thu, 06 Aug 2020 08:02:36 -0700 (PDT)
Received: from [192.168.2.145] (94-29-41-50.dynamic.spd-mgts.ru. [94.29.41.50])
        by smtp.googlemail.com with ESMTPSA id 132sm2842862lfo.16.2020.08.06.08.02.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 08:02:35 -0700 (PDT)
Subject: Re: [Patch v2 2/4] dmaengine: tegra: Add Tegra GPC DMA driver
To:     Rajesh Gumasta <rgumasta@nvidia.com>, ldewangan@nvidia.com,
        jonathanh@nvidia.com, vkoul@kernel.org, dan.j.williams@intel.com,
        thierry.reding@gmail.com, p.zabel@pengutronix.de,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kyarlagadda@nvidia.com, Pavan Kunapuli <pkunapuli@nvidia.com>
References: <1596699006-9934-1-git-send-email-rgumasta@nvidia.com>
 <1596699006-9934-3-git-send-email-rgumasta@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <67b9821a-1820-5089-445b-0d1b4f4ee996@gmail.com>
Date:   Thu, 6 Aug 2020 18:02:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1596699006-9934-3-git-send-email-rgumasta@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

06.08.2020 10:30, Rajesh Gumasta пишет:
> +static int tegra_dma_program_sid(struct tegra_dma_channel *tdc,
> +				 int chan, int stream_id)
> +{
> +	unsigned int reg_val =  tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ);
> +
> +	reg_val &= ~(TEGRA_GPCDMA_MCSEQ_STREAM_ID_MASK <<
> +					TEGRA_GPCDMA_MCSEQ_STREAM_ID0_SHIFT);
> +	reg_val &= ~(TEGRA_GPCDMA_MCSEQ_STREAM_ID_MASK <<
> +					TEGRA_GPCDMA_MCSEQ_STREAM_ID1_SHIFT);
> +
> +	reg_val |= (stream_id << TEGRA_GPCDMA_MCSEQ_STREAM_ID0_SHIFT);
> +	reg_val |= (stream_id << TEGRA_GPCDMA_MCSEQ_STREAM_ID1_SHIFT);

Have you seen my comment to v1 about FIELD_GET/FIELD_PREP?

If you disagree with something, then you should answer with a rationale
and not silently ignore review comments.
