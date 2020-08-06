Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A4023DCB8
	for <lists+dmaengine@lfdr.de>; Thu,  6 Aug 2020 18:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbgHFQz0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Aug 2020 12:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729759AbgHFQzU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Aug 2020 12:55:20 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7F8C0A889D;
        Thu,  6 Aug 2020 07:50:05 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id i80so26235480lfi.13;
        Thu, 06 Aug 2020 07:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q+Uq8k5re7cUqp6WIZR8xEDOrcjWzDvNdEqOcxf2ZGk=;
        b=YSuw0JUD4BI9mDqWniQI7oBkON85+Hily9832Miaihip0RlifaExWnpi46k72Ylx/0
         j8dBhGbQtkX23MvMAlBA1VcS6Er1XNDPV8EThtSUBYVSUhGp9LIWaD3ne1uwJiyqBXw1
         D5nGpPcknk3s4yzbaepxnRvrXbtI3MQYlZhj+YMBawEoaiPHRu5D5fDv0ORa5GEPxNy+
         TEPhCrzev0zQKsSKVx4MVxamstlMxS7DGaUkHQbmcfS5aju9oQpDxX9yxs81BgmeUJUc
         lT2FfL7PXRm8I8Im19vcypzAr8t0DyX0QiTF28F1RqyMcZybK2R5+weOFDGowmeYHxJn
         NusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q+Uq8k5re7cUqp6WIZR8xEDOrcjWzDvNdEqOcxf2ZGk=;
        b=AKt7yYQTc0AJTJrtAuxJ0IyyhOBvkwbCfuwP/EFdLmYnvnQmr9FE7hv/fTmZGGIyWL
         qvDfEyvbkzHFEcE5UlItPdM5o7Mz2Vj6LgOQIo/EVvUfLWjqnCm2HlWSvBHTIMM4kgcz
         VNmFhH9mvw2z/9X3UEe/OVwF7aQjd8Z3dT3GdkqonHtUKR5HDKtpeFMGIlG254R7zQES
         /icejXIVDAxy2lbbQQk6FJxtYM97jLfydzQ5mQv1d/onZkltegY7ipQFudFX6hPVl1Oa
         g/Y+yfVhIMkvw6QLWa743AvxAjjZBo9xE5pePbHwVilzMHxEV7yrJ7dHdxj9B+iPdl3M
         ssjw==
X-Gm-Message-State: AOAM530pM2j2Bg5TwrfrypyWNnkzDvp+0qe/EN1MX8voytv2hghEnHCu
        QD/unB4/fO6lZni3VIDDf1w=
X-Google-Smtp-Source: ABdhPJzWUE2bNkTWRtmo+gsMb7ug+grnXRR4hPLQdhUh80mdWnmTJ62sNdD6tPJa0sgHU3CrS+mq1Q==
X-Received: by 2002:a19:457:: with SMTP id 84mr4141422lfe.191.1596725401282;
        Thu, 06 Aug 2020 07:50:01 -0700 (PDT)
Received: from [192.168.2.145] (94-29-41-50.dynamic.spd-mgts.ru. [94.29.41.50])
        by smtp.googlemail.com with ESMTPSA id a16sm2739927ljj.108.2020.08.06.07.49.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 07:50:00 -0700 (PDT)
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
Message-ID: <93b20bf7-1cb8-c8cf-06ef-1c15b7ce7ff2@gmail.com>
Date:   Thu, 6 Aug 2020 17:49:59 +0300
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
> +static struct dma_async_tx_descriptor *tegra_dma_prep_dma_memset(
> +	struct dma_chan *dc, dma_addr_t dest, int value, size_t len,
> +	unsigned long flags)
> +{

This looks and reads okay, although the following style of code's
formatting is a bit more common for the kernel:

static struct dma_async_tx_descriptor *
tegra_dma_prep_dma_memset(struct dma_chan *dc, dma_addr_t dest,
			  int value, size_t len, unsigned long flags)

You could make this small improvement in a v3. Same for all similar
cases in the code.
