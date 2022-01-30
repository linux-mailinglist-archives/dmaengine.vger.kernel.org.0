Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B45B4A35C2
	for <lists+dmaengine@lfdr.de>; Sun, 30 Jan 2022 11:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbiA3KjB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 30 Jan 2022 05:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiA3KjB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 30 Jan 2022 05:39:01 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98EDC061714;
        Sun, 30 Jan 2022 02:39:00 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id a25so15399755lji.9;
        Sun, 30 Jan 2022 02:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OGsou4bITobcNoh/T8B7f3LUVtaDKYId34ZdytE10to=;
        b=pdcHHmtt7GJhItUOIifV2/1NhInqMBc2yHvyui2IeBXkUc0BTjVCM1oFcemic15Oms
         N7+FM5fiQ6xyZv03VHEaWo/1PcKfv7SKzQ1NCw4YCcXxh/rJEBzaKhdEbqfwvAw+qQm3
         +ZJuVMai6J2OAvXEaxqiwaCQAh3JiG8CSehETpcc+iRpi89eBXJEXgg+sGlmVOwVLob8
         nxXEtJty2OjtCU0MTn33/Ww5H+xL5RH/cNn//W6kxpLlRZStAI6+5mJlDM4nyuGEYaL5
         IbswopnqZGZrG/mZfwx/6k+SZCXpUyQ9Z2elMZzaUHjRxkoQj2a72iRvUTkbYbGX46yr
         VY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OGsou4bITobcNoh/T8B7f3LUVtaDKYId34ZdytE10to=;
        b=y3Gd0ecJ9sBnXhqWF+m97K+DqFKJYLaOa/Fmom879OMQq/UHPANKu6+x2dq1q4ZJZJ
         TnjjJo3avdvl8JFPXzSoxpox1WmML8pFaadyQKLsPhbkapC38JPsHwld6gn77WoYxQ86
         ngF5IXVIuv+eOP5Te4PO6U1DZxcWY91BVcJERQVRt3JUJFWsHCSuZJoYYINgb0iS/eEo
         8lXBlO7A8i/56xaMvHoYtsWEc1oISE2MDmfOsTymsbBP56phO2CJCQyMU348rXw5fI3H
         vZzLcKivz3g0BnVlRKfg+/1iSeyUjUek2WCaxcJSzKOq20i1Qh3QALpHc8+ieZd80lhI
         2zgA==
X-Gm-Message-State: AOAM5300JircR3JN/BRY3KH8vvKKOh6Jbv8s5Ih4Agz3s/VEuBk7v8j/
        DgY5CikwKlJgkievZSPffHw=
X-Google-Smtp-Source: ABdhPJwSSFhJL1PtS35AqD+vk9HhxxQoB3K7jrFPRLjEGRG3ZfmV5BOQ50lKOjqZZEb8PYOjXfpoVA==
X-Received: by 2002:a2e:9d0a:: with SMTP id t10mr10679530lji.219.1643539139197;
        Sun, 30 Jan 2022 02:38:59 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-126.dynamic.spd-mgts.ru. [109.252.138.126])
        by smtp.googlemail.com with ESMTPSA id o24sm3227893lfo.146.2022.01.30.02.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jan 2022 02:38:58 -0800 (PST)
Message-ID: <05a48ebc-5526-f771-38df-90635e6c28fd@gmail.com>
Date:   Sun, 30 Jan 2022 13:38:58 +0300
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
> +static void tegra_dma_chan_synchronize(struct dma_chan *dc)
> +{
> +	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);

	synchronize_irq(tdc->irq);
> +	vchan_synchronize(&tdc->vc);
> +}

