Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4DB04A35C6
	for <lists+dmaengine@lfdr.de>; Sun, 30 Jan 2022 11:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbiA3KjL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 30 Jan 2022 05:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233939AbiA3KjJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 30 Jan 2022 05:39:09 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53941C061714;
        Sun, 30 Jan 2022 02:39:09 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id t7so15391117ljc.10;
        Sun, 30 Jan 2022 02:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gtnyB8ubZiXqYBaZeGR5BpWJct2w6Or8WCdgqTrzOcg=;
        b=YhDLZ9XN96D1M/SqK99RQPX3oJ9huqLiDu47HQURAlR1JbpNzNBlcdHTCaZHCW0DWn
         3miFnLdLMfMaxTnsxj50irzyhAoOyz48s88RrfSpOGhixgqPFuWw3Nv5wVea39/x1r8A
         27KWONjTkNkZcvCdxD6W+f+6JEXldgxzhsiTrvNy5kP7s5UlodDroMr86bRph+jT2ZUn
         mR2tUHwXKmfkEzfufVdr4Ek19jEojXkq7iZKX3JOw2DfVQ5EYT9oMBbhJ0kDSE7RQzKx
         1ehjq83NMKEbDa0heZGHfnMzIPh5WDwXgBXLTL7FQq5lqL6vocDKAa/cZLyitZb26Ano
         Mv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gtnyB8ubZiXqYBaZeGR5BpWJct2w6Or8WCdgqTrzOcg=;
        b=hOLO6N0o9wvMuvz7wjHdnlhzU66KsnHzzQR+b7EDWOYLq87myTpQUwE2hMVY2IHrJO
         U5alwG/4dgKTTqPDWugWjRq5AGhKnwTChwtuD7ZB2Ko1qgBsZlqRfEH4cC8918qCZa94
         QBl/2UCBkfjP9IxPn1Bp8ilhqVV4qUi7zm4LoEIEY83inyyZTrTDebSYgk5yTEGvwlxW
         CEBz2mAvQ/7Bfs8OybX9KQgqDpFyGC2yGjaZlOQvsxAphXDMjKc61DRx6AbFtVsfIYna
         crCSx6A3WVJrzLf2MDeeB85eAcjoCrAbrsJF50x3S/5+HZcRXd1tVZnzKJSoERGwfszO
         /sWw==
X-Gm-Message-State: AOAM531loDqMvqeJmdvRJP7RlPxA4JDYA2cTgjWJaP/huaqubXuBWda/
        nSK7qK73irHa6ocVjrBKXig=
X-Google-Smtp-Source: ABdhPJzsqk+Vhmf8zRuTlh8LTY+MW7lSEZQl/2XL/czKI9Qrqd9FECtNiuVDMn2NoebdDG39AO4+9w==
X-Received: by 2002:a05:651c:891:: with SMTP id d17mr10794836ljq.443.1643539147768;
        Sun, 30 Jan 2022 02:39:07 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-126.dynamic.spd-mgts.ru. [109.252.138.126])
        by smtp.googlemail.com with ESMTPSA id g8sm3230961lfc.236.2022.01.30.02.39.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jan 2022 02:39:07 -0800 (PST)
Message-ID: <22aa3313-3b12-c92f-5955-3a8736cbe8f4@gmail.com>
Date:   Sun, 30 Jan 2022 13:39:06 +0300
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
> +static void tegra_dma_free_chan_resources(struct dma_chan *dc)
> +{
> +	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
> +
> +	dev_dbg(tdc2dev(tdc), "Freeing channel %d\n", tdc->id);
> +
> +	tegra_dma_terminate_all(dc);

	synchronize_irq(tdc->irq);

> +	tasklet_kill(&tdc->vc.task);

