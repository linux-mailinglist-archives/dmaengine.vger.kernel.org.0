Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B43477AC9
	for <lists+dmaengine@lfdr.de>; Thu, 16 Dec 2021 18:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbhLPRmb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Dec 2021 12:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhLPRmb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Dec 2021 12:42:31 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D883CC061574;
        Thu, 16 Dec 2021 09:42:30 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id m6so39320918lfu.1;
        Thu, 16 Dec 2021 09:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7FYfhrvLo3GwXmePy+p2yzbv60phNdldW5PFmWfPiXs=;
        b=OBJnVNMSYP1adOeWa8AFJJttrXnKOZ5+oNGEc7fxOVyfUhGwE2eSmsmDBRM30+2mPa
         W6UrrIxQpQldr/2PWt5ViY+Y5BC8bl6hqL+10epmYRyJwHIItwb7C59vc0OfjO1eaxTH
         jWWJSKFwZayFn9lvRON51g0t3THbTvJnO+vSYFKglpURt9oYefVHOdClgKA636UCwlwN
         ANQyvGQiTLtz0czKOq6n3YVvY0lXkjpAVhiP3OVNkcX6EKuvkgH1UeX5KsUHOof2Udo9
         nN+D2uoXmGx9hFm4ZuoHTwOX4YtOT/wFsP5xIrb+7YVkg9mSFwYyitromSiLKg241wyS
         PG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7FYfhrvLo3GwXmePy+p2yzbv60phNdldW5PFmWfPiXs=;
        b=mqDDzWOpRf1IdF6ZfD8tkzVmcBQODcnM/OBgJV+TepnSmWWPWUvJcgGryPR7ilCkCH
         TO1x3GsLo+Irj0j47jRtrZ/UKN/2z2u09mIoBWLXHs3zWo/PAaI3GSQNu1mQ2sYlOwIu
         eTR0qIWNm/Zovoqw2sSTz/v6zaSvEzIOn01JrErdYmLZWi7oD2dVouJwyCUuBJyN2r51
         uIM+xaG3fKavfYoZ4iVc0p1o96CpxR4aettmvg5D7r7XKFhNSR6pSIOXstkMKNahKUws
         KKAO26+r8HZOjdvaDDDBYExaXCEuX8jeqqF72oP0/jSguY1RFXHbFMK1AS9woA9fOSQR
         tf1w==
X-Gm-Message-State: AOAM531pAR69FFnL+NQ8LnqJTSEfXcv70AwPXmqVMZ6QTeJ8006CQp/i
        EjU9e02bvA1ZfAdM9+2xClU=
X-Google-Smtp-Source: ABdhPJxAQ0zmacqcYgTECIF74iTzW5n9uJt+DffNRDOYvj8/CQFPVFgscJUsXmswmHpoSH2OV23h1Q==
X-Received: by 2002:ac2:5966:: with SMTP id h6mr15703116lfp.358.1639676549126;
        Thu, 16 Dec 2021 09:42:29 -0800 (PST)
Received: from [192.168.2.145] (94-29-63-156.dynamic.spd-mgts.ru. [94.29.63.156])
        by smtp.googlemail.com with ESMTPSA id w15sm1244847ljo.97.2021.12.16.09.42.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 09:42:28 -0800 (PST)
Subject: Re: [PATCH v15 2/4] dmaengine: tegra: Add tegra gpcdma driver
To:     Akhil R <akhilrajeev@nvidia.com>, dan.j.williams@intel.com,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        jonathanh@nvidia.com, kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        p.zabel@pengutronix.de, rgumasta@nvidia.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, vkoul@kernel.org
Cc:     Pavan Kunapuli <pkunapuli@nvidia.com>
References: <1639674720-18930-1-git-send-email-akhilrajeev@nvidia.com>
 <1639674720-18930-3-git-send-email-akhilrajeev@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <45ba3abe-5e7e-4917-2b23-0616a758c4eb@gmail.com>
Date:   Thu, 16 Dec 2021 20:42:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1639674720-18930-3-git-send-email-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

16.12.2021 20:11, Akhil R пишет:
> +static int tegra_dma_terminate_all(struct dma_chan *dc)
> +{
> +	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
> +	unsigned long wcount = 0;
> +	unsigned long status;
> +	unsigned long flags;
> +	int err;
> +
> +	raw_spin_lock_irqsave(&tdc->lock, flags);
> +
> +	if (!tdc->dma_desc) {
> +		raw_spin_unlock_irqrestore(&tdc->lock, flags);
> +		return 0;
> +	}
> +
> +	if (!tdc->busy)
> +		goto skip_dma_stop;
> +
> +	if (tdc->tdma->chip_data->hw_support_pause)
> +		err = tegra_dma_pause(tdc);
> +	else
> +		err = tegra_dma_stop_client(tdc);
> +
> +	if (err) {
> +		raw_spin_unlock_irqrestore(&tdc->lock, flags);
> +		return err;
> +	}
> +
> +	status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_STATUS);
> +	if (status & TEGRA_GPCDMA_STATUS_ISE_EOC) {
> +		dev_dbg(tdc2dev(tdc), "%s():handling isr\n", __func__);
> +		tegra_dma_xfer_complete(tdc);
> +		status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_STATUS);
> +	}
> +
> +	wcount = tdc_read(tdc, TEGRA_GPCDMA_CHAN_XFER_COUNT);
> +	tegra_dma_stop(tdc);
> +
> +	tdc->dma_desc->bytes_transferred +=
> +			tdc->dma_desc->bytes_requested - (wcount * 4);
> +
> +skip_dma_stop:
> +	tegra_dma_sid_free(tdc);
> +	vchan_free_chan_resources(&tdc->vc);
> +	kfree(&tdc->vc);

You really going to kfree the head of tegra_dma_channel here? Once
again, this code was 100% untested :/

You're not allowed to free channel from the dma_terminate_all()
callback. This callback terminates submitted descs, that's it.

https://elixir.bootlin.com/linux/v5.16-rc5/source/include/linux/dmaengine.h#L1105

https://elixir.bootlin.com/linux/v5.16-rc5/source/drivers/i2c/busses/i2c-tegra.c#L962
