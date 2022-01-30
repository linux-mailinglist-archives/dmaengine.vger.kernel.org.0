Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67634A3591
	for <lists+dmaengine@lfdr.de>; Sun, 30 Jan 2022 11:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237005AbiA3KFl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 30 Jan 2022 05:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235274AbiA3KFk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 30 Jan 2022 05:05:40 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0285BC061714;
        Sun, 30 Jan 2022 02:05:39 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id x7so20776737lfu.8;
        Sun, 30 Jan 2022 02:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HeV0Wv/H/OhgPt4lE7qSA5LOMFeXkV06jM9iQMmPzsQ=;
        b=KXn6y3ZIu6u53xHjCds+h+Xo7KnzeCx1m+Iw3r799KUJnhwChxLYR2bBxufN03LcbL
         KAoZkknY7Kx6+Yauov6dWgRzTNPPiIon48TGET2ptsFZa/XptFFuhEb8WeK5dO5l27BZ
         K21H+0aDt1IhIwErB2pk4bVzskG1zsT7Wez9u+o5Ng2MOWJKbRD4DbiJ8E5wnb3ss2tH
         N/+9h9DCACNlcM65TTSvkJ540ypkBPqsDkZf8BaUBfyl/NgFzK/eGaX9pxnW2Kzad+pA
         s0zLc8lSPq1wGWlGVDtPWL3XUoQb33/Oo0ajNbNKJ0aq6zB1HGf0bzpYB1r7E5PAfh1c
         Sdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HeV0Wv/H/OhgPt4lE7qSA5LOMFeXkV06jM9iQMmPzsQ=;
        b=tBQO1cMlPv/VlBU4kNHiXmkODkPjq1apodwMACfrADxvIqmOiMtWSmXDP/2dJ6Qzg5
         vS9c+ie4Dvtev2wl69JL1hMGJB0uC4e2kqB66D47TNxKCwIzPx8RBHRGa/cOmQjf1CXA
         MCUIIyueHY7vobJml9wWIsxGBiq8UAxEhp8aPwqBqO8GwFnzeZiGYwZQqgTfrtwWYgJP
         XQMqLVXnhuAWEw1yv1eJAy1cnrA8oxaFsDTg6tG09ZEspesTjolZO8IX9ZUsOBZtBbZq
         ELm1HOIoM2mdD+4TsemJzPikgEQnoul9pUZJzLk5WaHcaKwU2vGXBkQDQp7f2T/ZtX0J
         QtGw==
X-Gm-Message-State: AOAM533TTNe3phyI1wA22A3YHBsZ007ZDfpFq2rYWGJX8AG0ecCPZoy2
        gD/B6EENgRnlrzjSLtCEy3i/4dCO7OA=
X-Google-Smtp-Source: ABdhPJwsdB2zj04aLxYfc6dbnuikX14O8Y5qLS+iVnH0LLu+zJxiI9zZl8ykGDDA6+VYG2o3Jq4nsA==
X-Received: by 2002:ac2:4d57:: with SMTP id 23mr11862456lfp.28.1643537138092;
        Sun, 30 Jan 2022 02:05:38 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-126.dynamic.spd-mgts.ru. [109.252.138.126])
        by smtp.googlemail.com with ESMTPSA id o20sm1119021lfu.244.2022.01.30.02.05.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jan 2022 02:05:37 -0800 (PST)
Message-ID: <ba109465-d7ee-09cb-775b-9b702a3910b0@gmail.com>
Date:   Sun, 30 Jan 2022 13:05:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v17 2/4] dmaengine: tegra: Add tegra gpcdma driver
Content-Language: en-US
To:     Akhil R <akhilrajeev@nvidia.com>, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, jonathanh@nvidia.com,
        kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        p.zabel@pengutronix.de, rgumasta@nvidia.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, vkoul@kernel.org
Cc:     Pavan Kunapuli <pkunapuli@nvidia.com>
References: <1643474453-32619-1-git-send-email-akhilrajeev@nvidia.com>
 <1643474453-32619-3-git-send-email-akhilrajeev@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <1643474453-32619-3-git-send-email-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

29.01.2022 19:40, Akhil R пишет:
> +static int tegra_dma_device_pause(struct dma_chan *dc)
> +{
> +	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
> +	unsigned long wcount, flags;
> +	int ret = 0;
> +
> +	if (!tdc->tdma->chip_data->hw_support_pause)
> +		return 0;

It's wrong to return zero if pause unsupported, please see what
dmaengine_pause() returns.

> +
> +	spin_lock_irqsave(&tdc->vc.lock, flags);
> +	if (!tdc->dma_desc)
> +		goto out;
> +
> +	ret = tegra_dma_pause(tdc);
> +	if (ret) {
> +		dev_err(tdc2dev(tdc), "DMA pause timed out\n");
> +		goto out;
> +	}
> +
> +	wcount = tdc_read(tdc, TEGRA_GPCDMA_CHAN_XFER_COUNT);
> +	tdc->dma_desc->bytes_xfer +=
> +			tdc->dma_desc->bytes_req - (wcount * 4);

Why transfer is accumulated?

Why do you need to update xfer size at all on pause?

> +
> +out:
> +	spin_unlock_irqrestore(&tdc->vc.lock, flags);
> +
> +	return ret;
> +}

Still nothing prevents interrupt handler to fire during the pause.

What you actually need to do is to disable/enable interrupt. This will
prevent the interrupt racing and then pause/resume may look like this:

static int tegra_dma_device_resume(struct dma_chan *dc)
{
	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
	u32 val;

	if (!tdc->tdma->chip_data->hw_support_pause)
		return -ENOSYS;

	if (!tdc->dma_desc)
		return 0;

	val = tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSRE);
	val &= ~TEGRA_GPCDMA_CHAN_CSRE_PAUSE;
	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSRE, val);
	
	enable_irq(tdc->irq);

	return 0;
}

static int tegra_dma_device_pause(struct dma_chan *dc)
{
	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
	u32 val;
	int ret;

	if (!tdc->tdma->chip_data->hw_support_pause)
		return -ENOSYS;

	disable_irq(tdc->irq);

	if (!tdc->dma_desc)
		return 0;

	val = tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSRE);
	val |= TEGRA_GPCDMA_CHAN_CSRE_PAUSE;
	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSRE, val);

	/* Wait until busy bit is de-asserted */
	ret = readl_relaxed_poll_timeout_atomic(
			tdc->chan_base + TEGRA_GPCDMA_CHAN_STATUS,
			val, !(val & TEGRA_GPCDMA_STATUS_BUSY),
			TEGRA_GPCDMA_BURST_COMPLETE_TIME,
			TEGRA_GPCDMA_BURST_COMPLETION_TIMEOUT);
	if (ret) {
		dev_err(tdc2dev(tdc), "DMA pause timed out: %d\n", ret);
		tegra_dma_device_resume(dc);
	}

	return ret;
}


