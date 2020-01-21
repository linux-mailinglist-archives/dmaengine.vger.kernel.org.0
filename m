Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA78F14465D
	for <lists+dmaengine@lfdr.de>; Tue, 21 Jan 2020 22:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgAUVXN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Jan 2020 16:23:13 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33640 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728776AbgAUVXN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 21 Jan 2020 16:23:13 -0500
Received: by mail-lj1-f196.google.com with SMTP id y6so4418032lji.0;
        Tue, 21 Jan 2020 13:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b0e47hfuHVqQ3RlreV067jhMkKP4EChxl8z4USHZAn0=;
        b=Znkf8yiDZmuz2u6fxHNHBP4U0l3nqx5VdCZ+2ochZk4c16z9G7LDVoX+PElqYV018R
         xDoUc9GAvJFzBewwa8Z9R5ysoxo7x7azBrFGFckY5fIdSJ1oMae9y2uGTRBbxhaaKKVY
         bRdtIeYaD1lfpNMZsA8IDp7bQWGnR+PiZxwWYMBqu20iNgNmGteE4ueCfsfY/VcjwrQ6
         l4YCNA1I/U8tnxogvSI6WREa3fFVnA7/qog0c34ox1xpIc7WTCo9jKoonHnKwbmIF8U/
         5uRyWMu5jbsaK9iHrI9MmvNLOTPIaLf7pKxBsq4hOpC5YCT1efkGEGj/3UvDlF7bhf0B
         2kEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b0e47hfuHVqQ3RlreV067jhMkKP4EChxl8z4USHZAn0=;
        b=kfIGF3McCdXIwqf+ykhUj/AbjdIpVySH8mXiRtNC+htqgQbxUjJkYdjqVQxFo1Psku
         H2Y85VgFTlTDxKp9JY1MmUNvKJZPEglar8cw8+6inYhv4PtdVaM7jYRwalgKMC6JZmRt
         dBErpYKrKSI9RHTNNUAYLolftumKUUEan8Y6aGOp67f0fCtnRgTUnJdD03XYyvrJDbq5
         sz4y10/EBMh1n9tjgYy2metlTZBSbmIBC21DXOv1SW94Odi844xZB+tDY65SXSQj6tU3
         k3NpWSABJ4yRf5rqjWoHDR/6r9jq5h66GF5A3Ww02FrxarRPGxF5XLbDamSDx2RdcARF
         FH0Q==
X-Gm-Message-State: APjAAAXlJaucrDT0VlN6CZV0nm4/l2SEZN54RYB0oRqMUlNLs1yoE0Mu
        xyqEGsBofMLM4FrreDdt3j5apKHP
X-Google-Smtp-Source: APXvYqxcyvx6QMH8v8kxuunZP9IH+Mbb7MnvNDwj0Fs01Diy3b7BSM1aMjPhpKGtvaWJQvXO/Ckvyw==
X-Received: by 2002:a2e:9b03:: with SMTP id u3mr17261711lji.87.1579641789328;
        Tue, 21 Jan 2020 13:23:09 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id q26sm1618839lfp.85.2020.01.21.13.23.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 13:23:08 -0800 (PST)
Subject: Re: [PATCH v4 11/14] dmaengine: tegra-apb: Clean up suspend-resume
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200112173006.29863-1-digetx@gmail.com>
 <20200112173006.29863-12-digetx@gmail.com>
Message-ID: <7e0d2cfa-5570-93e6-e3dc-7d3f6902a528@gmail.com>
Date:   Wed, 22 Jan 2020 00:23:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200112173006.29863-12-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

12.01.2020 20:30, Dmitry Osipenko пишет:
> It is enough to check whether hardware is busy on suspend and to reset
> it across of suspend-resume because channel's configuration is fully
> re-programmed on each DMA transaction anyways and because save-restore
> of an active channel won't end up well without pausing transfer prior to
> saving of the state (note that all channels shall be idling at the time of
> suspend, so save-restore is not needed at all).
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/dma/tegra20-apb-dma.c | 131 +++++++++++++++++-----------------
>  1 file changed, 67 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
> index b9d8e57eaf54..398a0e1d6506 100644
> --- a/drivers/dma/tegra20-apb-dma.c
> +++ b/drivers/dma/tegra20-apb-dma.c
> @@ -1392,6 +1392,36 @@ static const struct tegra_dma_chip_data tegra148_dma_chip_data = {
>  	.support_separate_wcount_reg = true,
>  };
>  
> +static int tegra_dma_init_hw(struct tegra_dma *tdma)
> +{
> +	int err;
> +
> +	err = reset_control_assert(tdma->rst);
> +	if (err) {
> +		dev_err(tdma->dev, "failed to assert reset: %d\n", err);
> +		return err;
> +	}
> +
> +	err = clk_enable(tdma->dma_clk);
> +	if (err) {
> +		dev_err(tdma->dev, "failed to enable clk: %d\n", err);
> +		return err;
> +	}
> +
> +	/* reset DMA controller */
> +	udelay(2);
> +	reset_control_deassert(tdma->rst);
> +
> +	/* enable global DMA registers */
> +	tdma_write(tdma, TEGRA_APBDMA_GENERAL, TEGRA_APBDMA_GENERAL_ENABLE);
> +	tdma_write(tdma, TEGRA_APBDMA_CONTROL, 0);
> +	tdma_write(tdma, TEGRA_APBDMA_IRQ_MASK_SET, 0xFFFFFFFF);
> +
> +	clk_disable(tdma->dma_clk);
> +
> +	return 0;
> +}
> +
>  static int tegra_dma_probe(struct platform_device *pdev)
>  {
>  	const struct tegra_dma_chip_data *cdata;
> @@ -1433,30 +1463,18 @@ static int tegra_dma_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	ret = tegra_dma_init_hw(tdma);
> +	if (ret)
> +		goto err_clk_unprepare;
> +
>  	pm_runtime_irq_safe(&pdev->dev);
>  	pm_runtime_enable(&pdev->dev);
>  	if (!pm_runtime_enabled(&pdev->dev)) {
>  		ret = tegra_dma_runtime_resume(&pdev->dev);
>  		if (ret)
>  			goto err_clk_unprepare;

Jon, but isn't the RPM mandatory for all Tegra SoCs now and thus
guaranteed to be enabled? Maybe we should start to remove handling the
case of unavailable RPM from all Tegra drivers?

> -	} else {
> -		ret = pm_runtime_get_sync(&pdev->dev);
> -		if (ret < 0)
> -			goto err_pm_disable;
>  	}
>  
> -	/* Reset DMA controller */
> -	reset_control_assert(tdma->rst);
> -	udelay(2);
> -	reset_control_deassert(tdma->rst);
> -
> -	/* Enable global DMA registers */
> -	tdma_write(tdma, TEGRA_APBDMA_GENERAL, TEGRA_APBDMA_GENERAL_ENABLE);
> -	tdma_write(tdma, TEGRA_APBDMA_CONTROL, 0);
> -	tdma_write(tdma, TEGRA_APBDMA_IRQ_MASK_SET, 0xFFFFFFFFul);
> -
> -	pm_runtime_put(&pdev->dev);
> -
>  	INIT_LIST_HEAD(&tdma->dma_dev.channels);
>  	for (i = 0; i < cdata->nr_channels; i++) {
>  		struct tegra_dma_channel *tdc = &tdma->channels[i];
> @@ -1583,26 +1601,6 @@ static int tegra_dma_remove(struct platform_device *pdev)
>  static int tegra_dma_runtime_suspend(struct device *dev)
>  {
>  	struct tegra_dma *tdma = dev_get_drvdata(dev);
> -	unsigned int i;
> -
> -	tdma->reg_gen = tdma_read(tdma, TEGRA_APBDMA_GENERAL);
> -	for (i = 0; i < tdma->chip_data->nr_channels; i++) {
> -		struct tegra_dma_channel *tdc = &tdma->channels[i];
> -		struct tegra_dma_channel_regs *ch_reg = &tdc->channel_reg;
> -
> -		/* Only save the state of DMA channels that are in use */
> -		if (!tdc->config_init)
> -			continue;
> -
> -		ch_reg->csr = tdc_read(tdc, TEGRA_APBDMA_CHAN_CSR);
> -		ch_reg->ahb_ptr = tdc_read(tdc, TEGRA_APBDMA_CHAN_AHBPTR);
> -		ch_reg->apb_ptr = tdc_read(tdc, TEGRA_APBDMA_CHAN_APBPTR);
> -		ch_reg->ahb_seq = tdc_read(tdc, TEGRA_APBDMA_CHAN_AHBSEQ);
> -		ch_reg->apb_seq = tdc_read(tdc, TEGRA_APBDMA_CHAN_APBSEQ);
> -		if (tdma->chip_data->support_separate_wcount_reg)
> -			ch_reg->wcount = tdc_read(tdc,
> -						  TEGRA_APBDMA_CHAN_WCOUNT);
> -	}
>  
>  	clk_disable(tdma->dma_clk);
>  
> @@ -1612,46 +1610,51 @@ static int tegra_dma_runtime_suspend(struct device *dev)
>  static int tegra_dma_runtime_resume(struct device *dev)
>  {
>  	struct tegra_dma *tdma = dev_get_drvdata(dev);
> -	unsigned int i;
> -	int ret;
>  
> -	ret = clk_enable(tdma->dma_clk);
> -	if (ret < 0) {
> -		dev_err(dev, "clk_enable failed: %d\n", ret);
> -		return ret;
> -	}
> +	return clk_enable(tdma->dma_clk);
> +}
>  
> -	tdma_write(tdma, TEGRA_APBDMA_GENERAL, tdma->reg_gen);
> -	tdma_write(tdma, TEGRA_APBDMA_CONTROL, 0);
> -	tdma_write(tdma, TEGRA_APBDMA_IRQ_MASK_SET, 0xFFFFFFFFul);
> +static int __maybe_unused tegra_dma_dev_suspend(struct device *dev)
> +{
> +	struct tegra_dma *tdma = dev_get_drvdata(dev);
> +	unsigned long flags;
> +	unsigned int i;
> +	bool busy;
>  
>  	for (i = 0; i < tdma->chip_data->nr_channels; i++) {
>  		struct tegra_dma_channel *tdc = &tdma->channels[i];
> -		struct tegra_dma_channel_regs *ch_reg = &tdc->channel_reg;
> -
> -		/* Only restore the state of DMA channels that are in use */
> -		if (!tdc->config_init)
> -			continue;
> -
> -		if (tdma->chip_data->support_separate_wcount_reg)
> -			tdc_write(tdc, TEGRA_APBDMA_CHAN_WCOUNT,
> -				  ch_reg->wcount);
> -		tdc_write(tdc, TEGRA_APBDMA_CHAN_APBSEQ, ch_reg->apb_seq);
> -		tdc_write(tdc, TEGRA_APBDMA_CHAN_APBPTR, ch_reg->apb_ptr);
> -		tdc_write(tdc, TEGRA_APBDMA_CHAN_AHBSEQ, ch_reg->ahb_seq);
> -		tdc_write(tdc, TEGRA_APBDMA_CHAN_AHBPTR, ch_reg->ahb_ptr);
> -		tdc_write(tdc, TEGRA_APBDMA_CHAN_CSR,
> -			  ch_reg->csr & ~TEGRA_APBDMA_CSR_ENB);
> +
> +		spin_lock_irqsave(&tdc->lock, flags);
> +		busy = tdc->busy;
> +		spin_unlock_irqrestore(&tdc->lock, flags);
> +
> +		if (busy) {
> +			dev_err(tdma->dev, "channel %u busy\n", i);
> +			return -EBUSY;
> +		}
> +
> +		tasklet_kill(&tdc->tasklet);

I realized that it will be more robust to kill the tasklet before
checking the busy state because technically tasklet could issue new DMA
transfer, will correct it in v5.

>  	}
>  
> -	return 0;
> +	return pm_runtime_force_suspend(dev);
> +}
> +
> +static int __maybe_unused tegra_dma_dev_resume(struct device *dev)
> +{
> +	struct tegra_dma *tdma = dev_get_drvdata(dev);
> +	int err;
> +
> +	err = tegra_dma_init_hw(tdma);
> +	if (err)
> +		return err;
> +
> +	return pm_runtime_force_resume(dev);
>  }
>  
>  static const struct dev_pm_ops tegra_dma_dev_pm_ops = {
>  	SET_RUNTIME_PM_OPS(tegra_dma_runtime_suspend, tegra_dma_runtime_resume,
>  			   NULL)
> -	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> -				pm_runtime_force_resume)
> +	SET_SYSTEM_SLEEP_PM_OPS(tegra_dma_dev_suspend, tegra_dma_dev_resume)
>  };
>  
>  static const struct of_device_id tegra_dma_of_match[] = {
> 

