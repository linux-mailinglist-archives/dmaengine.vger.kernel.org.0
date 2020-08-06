Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C59BE23DE37
	for <lists+dmaengine@lfdr.de>; Thu,  6 Aug 2020 19:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgHFRXc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Aug 2020 13:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729799AbgHFRFG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Aug 2020 13:05:06 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7139EC08E835;
        Thu,  6 Aug 2020 06:46:28 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id c15so8840938lfi.3;
        Thu, 06 Aug 2020 06:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VZnlZHi2pNVM/YMIfXvf/UHbjwYhQmIPewxedOf93xI=;
        b=obXR+Nn3YxEJAFYj9GjuuDHfWohVA8Ko2EZOZhRZLysgDkBB/zbNM9sFGHsyIalrV4
         nhWnw+C8JYCh/hhgGGIK+A5QVPoC1u2W0DMy+tbkWLsBhKev24yAyy/CXHDYX/0qelNI
         H6YkD+SM7NZszlsAWXR0/CDbstrY4mr0yoePvmsFTURovar9kWBpSeOCu85MkyANy7Q6
         X4JL+qn9lAkd1xlNmY8vQw+M3hRVSK0hzPO5pygND0gWt0pA/NN4wVcb9XGxq5RBRpYe
         JTk404spywnd3PhejTaIe4KjNw4tEZhg2KJpTx5y2qHI6RDSdq4QOTyX16Kdx2IGoBvo
         VChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VZnlZHi2pNVM/YMIfXvf/UHbjwYhQmIPewxedOf93xI=;
        b=tagaIIRLTt86ZBnBqxL3EzA8poZDsNq1p8gZniw42b//dzB1EnGM2vXudxtyv6Kyvx
         yvKseGSwmx74kpcgcnsyi06EVjQBa2q45jEfF861Dum6KEK/Y5CGgzATUo7R+phsY1Ev
         /zF70lW2ufQFP4Y4BO0eeAuIdVQYj6e16YKEipjBVedxM+1OFx5ySmUlIuSvDsibao4I
         jAdBcf7rPcIAJZTp6xvW2KzwBRkFhYhyvddQtWDcBhlo65eBiTZTmpID0jx54ilP6wXb
         9tZfOH1Znq6vXKSg2ZyUQAvEVJHG1UvlJaxigwUNDejzi3l3gItK33wWhqhDS3/GYKUr
         DKNg==
X-Gm-Message-State: AOAM531EdD8H/9ojGlu3d0RoFXiU+9BxYCphRcMy3YRZpl4ls2ZKoG5i
        jm011Wmdb8Qbup8XcevxWnw0KwJi
X-Google-Smtp-Source: ABdhPJw4moAXUF/I/3kTkOQE43bGzwcBxEGZxvffHv+O3d1addRnPEos3MVbxYnblMoeVEBo8DGHhg==
X-Received: by 2002:a19:4f01:: with SMTP id d1mr3959771lfb.159.1596721576594;
        Thu, 06 Aug 2020 06:46:16 -0700 (PDT)
Received: from [192.168.2.145] (94-29-41-50.dynamic.spd-mgts.ru. [94.29.41.50])
        by smtp.googlemail.com with ESMTPSA id z18sm2402757lja.55.2020.08.06.06.46.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 06:46:15 -0700 (PDT)
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
Message-ID: <bc7d0d9d-ac7f-b720-64f5-63e0c76e6786@gmail.com>
Date:   Thu, 6 Aug 2020 16:46:14 +0300
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
...
> +/*
> + * Save and restore csr and channel register on pm_suspend
> + * and pm_resume respectively
> + */
> +static int __maybe_unused tegra_dma_pm_suspend(struct device *dev)
> +{
> +	struct tegra_dma *tdma = dev_get_drvdata(dev);
> +	int i;
> +
> +	for (i = 0; i < tdma->chip_data->nr_channels; i++) {
> +		struct tegra_dma_channel *tdc = &tdma->channels[i];
> +		struct tegra_dma_channel_regs *ch_reg = &tdc->channel_reg;
> +
> +		ch_reg->csr = tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSR);
> +		ch_reg->src_ptr = tdc_read(tdc, TEGRA_GPCDMA_CHAN_SRC_PTR);
> +		ch_reg->dst_ptr = tdc_read(tdc, TEGRA_GPCDMA_CHAN_DST_PTR);
> +		ch_reg->high_addr_ptr = tdc_read(tdc,
> +						 TEGRA_GPCDMA_CHAN_HIGH_ADDR_PTR);
> +		ch_reg->mc_seq = tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ);
> +		ch_reg->mmio_seq = tdc_read(tdc, TEGRA_GPCDMA_CHAN_MMIOSEQ);
> +		ch_reg->wcount = tdc_read(tdc, TEGRA_GPCDMA_CHAN_WCOUNT);
> +	}
> +	return 0;
> +}
> +
> +static int __maybe_unused tegra_dma_pm_resume(struct device *dev)
> +{
> +	struct tegra_dma *tdma = dev_get_drvdata(dev);
> +	int i;
> +
> +	for (i = 0; i < tdma->chip_data->nr_channels; i++) {
> +		struct tegra_dma_channel *tdc = &tdma->channels[i];
> +		struct tegra_dma_channel_regs *ch_reg = &tdc->channel_reg;
> +
> +		tdc_write(tdc, TEGRA_GPCDMA_CHAN_WCOUNT, ch_reg->wcount);
> +		tdc_write(tdc, TEGRA_GPCDMA_CHAN_DST_PTR, ch_reg->dst_ptr);
> +		tdc_write(tdc, TEGRA_GPCDMA_CHAN_SRC_PTR, ch_reg->src_ptr);
> +		tdc_write(tdc, TEGRA_GPCDMA_CHAN_HIGH_ADDR_PTR,
> +			  ch_reg->high_addr_ptr);
> +		tdc_write(tdc, TEGRA_GPCDMA_CHAN_MMIOSEQ, ch_reg->mmio_seq);
> +		tdc_write(tdc, TEGRA_GPCDMA_CHAN_MCSEQ, ch_reg->mc_seq);
> +		tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSR,
> +			  (ch_reg->csr & ~TEGRA_GPCDMA_CSR_ENB));
> +	}
> +	return 0;
> +}
> +
> +static const struct __maybe_unused dev_pm_ops tegra_dma_dev_pm_ops = {
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(tegra_dma_pm_suspend, tegra_dma_pm_resume)
> +};

Please explain why this is needed. All DMA should be stopped (not
paused) on system's suspend, shouldn't it?
