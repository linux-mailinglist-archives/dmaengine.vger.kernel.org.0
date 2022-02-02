Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EE34A74E0
	for <lists+dmaengine@lfdr.de>; Wed,  2 Feb 2022 16:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345561AbiBBPpQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 2 Feb 2022 10:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbiBBPpN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 2 Feb 2022 10:45:13 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB585C061714;
        Wed,  2 Feb 2022 07:45:12 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id t7so29439279ljc.10;
        Wed, 02 Feb 2022 07:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=z4arY+g8wX8M89ywxFO2V/rPiSArckND5pFwvaV0inI=;
        b=dDX1WqEELcv5LJXvtiKxE9g1GertKAlmxr1c221g9sXoPxMsFCWHqy7RkqG8vZDQyd
         gcNKwpxoN86JGI/tSNcFedjuTn7x1r+VXDI6lQVbZxKbVr716t0ehbl0DXLsymYX6rfJ
         buIzveNaSU4ZQJbugECw7NgHNAg4xdqTtY+kAutZFw049r8SPvqdNsSsWGJqiu7HsG9i
         YYahyPRyzm6LnuX4Rn7a6JrgYxUZ5CNc8cM8V+GxzkBTZ6xBrtnI7hAVxWpaUGgGhj4o
         CJ+55DLGQXxG7aW4XmJrgOdiG6YyufhzXnANxNrLKEy/YXEAUeI9HDhtYmEVwhIjFaGw
         wZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=z4arY+g8wX8M89ywxFO2V/rPiSArckND5pFwvaV0inI=;
        b=nE2d00tC2nEMh+iJ3uHxBFhbn+sWh7y/nDU+ZK1KLK9rjBG37BJ3VSbRQKxCd8H0YN
         KLCgw953H8rwcW9IBOc4Srk7/ysK0MRGFt41gDrwoAZdMwpgzwNDBM+yH3OAgWMg+99C
         yPpY8Xzye6xIVtmBs0Fy3ih9NtBGp1qrsUlM/8B0xizKQABUY0cjKRkL23MTfKnl8KO9
         TmzAKorqoX2RsjewchSJCEsBMPlNvygB+pO3/O9A0eMI5hyPgr1SpnsjoYRA9F+cjkXu
         9VdFn2gkWAayiKD7p+13xP29Q5hHD7RItNdb9yuGftR1yXNsREW6u60NanhzhWeDZkFq
         D+og==
X-Gm-Message-State: AOAM533J1SPztIEwbxVCVbENZSXD0sxCTcQMl7Wv/e7g+LY5dkJlgkMP
        AuxsGNtgY2T8f1jFiMGZ2K0=
X-Google-Smtp-Source: ABdhPJzaT7yeTWNK1STtK5CEEtrRe3k3RfThPGNKhym658ySPbYjl4psomBsLIDLXhg9UuACHRR3AA==
X-Received: by 2002:a05:651c:179c:: with SMTP id bn28mr20182343ljb.4.1643816710975;
        Wed, 02 Feb 2022 07:45:10 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-136.dynamic.spd-mgts.ru. [109.252.138.136])
        by smtp.googlemail.com with ESMTPSA id a18sm4047834lfg.83.2022.02.02.07.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 07:45:10 -0800 (PST)
Message-ID: <3feaa359-31bb-bb07-75d7-2a39c837a7a2@gmail.com>
Date:   Wed, 2 Feb 2022 18:45:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v18 2/4] dmaengine: tegra: Add tegra gpcdma driver
Content-Language: en-US
To:     Akhil R <akhilrajeev@nvidia.com>, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, jonathanh@nvidia.com,
        kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        p.zabel@pengutronix.de, rgumasta@nvidia.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, vkoul@kernel.org
Cc:     Pavan Kunapuli <pkunapuli@nvidia.com>
References: <1643729199-19161-1-git-send-email-akhilrajeev@nvidia.com>
 <1643729199-19161-3-git-send-email-akhilrajeev@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <1643729199-19161-3-git-send-email-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

....
> +static int tegra_dma_pause(struct tegra_dma_channel *tdc)
> +{
> +	int ret;
> +	u32 val;
> +
> +	val = tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSRE);
> +	val |= TEGRA_GPCDMA_CHAN_CSRE_PAUSE;
> +	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSRE, val);
> +
> +	/* Wait until busy bit is de-asserted */
> +	ret = readl_relaxed_poll_timeout_atomic(tdc->tdma->base_addr +
> +			tdc->chan_base_offset + TEGRA_GPCDMA_CHAN_STATUS,
> +			val,
> +			!(val & TEGRA_GPCDMA_STATUS_BUSY),
> +			TEGRA_GPCDMA_BURST_COMPLETE_TIME,
> +			TEGRA_GPCDMA_BURST_COMPLETION_TIMEOUT);
> +
> +	return ret;
> +}
> +
> +static int tegra_dma_device_pause(struct dma_chan *dc)
> +{
> +	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	if (!tdc->tdma->chip_data->hw_support_pause)
> +		return -ENOSYS;
> +
> +	spin_lock_irqsave(&tdc->vc.lock, flags);
> +	ret = tegra_dma_pause(tdc);
> +	if (ret)
> +		dev_err(tdc2dev(tdc), "DMA pause timed out\n");

Why error message shouldn't be printed by tegra_dma_terminate_all()?

The error message should be placed inside of tegra_dma_pause().

...
> +static int tegra_dma_stop_client(struct tegra_dma_channel *tdc)
> +{
> +	int ret;
> +	unsigned long status;
> +	u32 csr = tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSR);
> +
> +	/*
> +	 * Change the client associated with the DMA channel
> +	 * to stop DMA engine from starting any more bursts for
> +	 * the given client and wait for in flight bursts to complete
> +	 */
> +	csr &= ~(TEGRA_GPCDMA_CSR_REQ_SEL_MASK);
> +	csr |= TEGRA_GPCDMA_CSR_REQ_SEL_UNUSED;
> +	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSR, csr);
> +
> +	/* Wait for in flight data transfer to finish */
> +	udelay(TEGRA_GPCDMA_BURST_COMPLETE_TIME);
> +
> +	/* If TX/RX path is still active wait till it becomes
> +	 * inactive
> +	 */
> +
> +	ret = readl_relaxed_poll_timeout_atomic(tdc->tdma->base_addr +
> +				tdc->chan_base_offset +
> +				TEGRA_GPCDMA_CHAN_STATUS,
> +				status,
> +				!(status & (TEGRA_GPCDMA_STATUS_CHANNEL_TX |
> +				TEGRA_GPCDMA_STATUS_CHANNEL_RX)),
> +				5,
> +				TEGRA_GPCDMA_BURST_COMPLETION_TIMEOUT);
> +	if (ret) {
> +		dev_err(tdc2dev(tdc), "Timeout waiting for DMA burst completion!\n");
> +		tegra_dma_dump_chan_regs(tdc);
> +	}
> +
> +	return ret;
> +}
> +
> +static int tegra_dma_terminate_all(struct dma_chan *dc)
> +{
> +	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
> +	unsigned long flags;
> +	LIST_HEAD(head);
> +	int err;
> +
> +	spin_lock_irqsave(&tdc->vc.lock, flags);
> +
> +	if (tdc->dma_desc) {
> +		err = tdc->tdma->chip_data->hw_support_pause ?
> +		      tegra_dma_pause(tdc) :
> +		      tegra_dma_stop_client(tdc);

The canonical coding style is:

if (tdc->tdma->chip_data->hw_support_pause)
	err = tegra_dma_pause(tdc);
else
	err = tegra_dma_stop_client(tdc);


But why do you need to pause at all here and can't use
tegra_dma_stop_client() even if pause is supported?
