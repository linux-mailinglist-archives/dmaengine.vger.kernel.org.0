Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2509146F60F
	for <lists+dmaengine@lfdr.de>; Thu,  9 Dec 2021 22:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbhLIVlF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Dec 2021 16:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhLIVlE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Dec 2021 16:41:04 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AE7C061746;
        Thu,  9 Dec 2021 13:37:30 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id m6so2747614lfu.1;
        Thu, 09 Dec 2021 13:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TqTpDTINLxy3WS9shl/AGQezgI5fHlezU7a3Hlx0CnI=;
        b=DXJPkF2bXslN6AlJW7fuVsvie6HWMwkpZoA71U0rpDcSbx2g+evi3vXrvjSZV2nq62
         B9O+/aoeJBRFjuL2KIvAj74B/A84FyyLnfW2gUCvWjPs9LpThTkaqKrHIC5NFbHLuBG9
         SvgWcSPA42LFss7qR3MS1miXw05FL8xEDrEkwwOEWmzpA+upYI3c2VVyefdNwjx91N4J
         eqbvfLSzjwkCioHd0fK66LT6EFIzg69m8//eGTkWKi+XRoGq/UUaz3yI6bdqKmzUU25B
         Hrj4mKGxlI3idRqmol8oXAjysg5A3vlViwWYDsEkHPb49y/7t4ftZ2YRy1bOwrK4Mo58
         ZF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TqTpDTINLxy3WS9shl/AGQezgI5fHlezU7a3Hlx0CnI=;
        b=U3FMnkpH3G7zIL8VaCasmlihqFJgL+F8PbB+DjlqRSDCEFv/j5zNHyTi+pDFWYYrAS
         deDQ/D6Pmd0MOXbuaXlstnUISM0O1H0w1Gs/0JKpozDdNvUj3XKuoSEePOtQD+smxzyq
         HLQT5G5obLlnyFukJVSet9tnizk7EaE2ijr83xiB9DRAItsTjvWrnMgGBVeVKRbHn5ag
         LnyGqvJCtD+AYU38ACYB3IPgWqi19UE0XdRk767tm1S2QS69kw7BMyLVWxGnvHYickh7
         9ymCs2xxld2k6CBuVngurucUq5CLcKFALdfzpCFPASIrO74fdse2JZgqA6FvYk66lAmf
         ZDFA==
X-Gm-Message-State: AOAM531oROqUt9AZKySiC48lize8otfibVwjrp9CcKm0aTpzkdnTL6oE
        TkURo6XqBx+ihV93pbaunqU=
X-Google-Smtp-Source: ABdhPJxJuvc07pm2m00Inr4k5j+ojE1PDO3izUfN9TyqXbGTRQvem85bBJCiHCjsgP+aA7ugv7zbsQ==
X-Received: by 2002:a05:6512:2815:: with SMTP id cf21mr8365281lfb.211.1639085848520;
        Thu, 09 Dec 2021 13:37:28 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id c30sm112551lfp.31.2021.12.09.13.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 13:37:28 -0800 (PST)
Subject: Re: [PATCH v14 2/4] dmaengine: tegra: Add tegra gpcdma driver
To:     Akhil R <akhilrajeev@nvidia.com>, dan.j.williams@intel.com,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        jonathanh@nvidia.com, kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        p.zabel@pengutronix.de, rgumasta@nvidia.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, vkoul@kernel.org
Cc:     Pavan Kunapuli <pkunapuli@nvidia.com>
References: <1638795639-3681-1-git-send-email-akhilrajeev@nvidia.com>
 <1638795639-3681-3-git-send-email-akhilrajeev@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a8e55db8-67cf-0706-8770-b89e1282e007@gmail.com>
Date:   Fri, 10 Dec 2021 00:37:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1638795639-3681-3-git-send-email-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

06.12.2021 16:00, Akhil R пишет:
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
> +	kfree(tdc->dma_desc);

This kfree looks very suspicious. It should be on the tdc->vc list
AFAICS, secondly I don't think that driver can be considered the owner
of the descriptor.

> +	vchan_free_chan_resources(&tdc->vc);

