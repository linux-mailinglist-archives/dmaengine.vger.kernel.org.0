Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA4946F5DC
	for <lists+dmaengine@lfdr.de>; Thu,  9 Dec 2021 22:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbhLIV1b (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Dec 2021 16:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbhLIV1a (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Dec 2021 16:27:30 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98438C0617A1;
        Thu,  9 Dec 2021 13:23:56 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id k2so10980650lji.4;
        Thu, 09 Dec 2021 13:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZXTNkYXQHnTQSZD4ZzDdjes6xAr43HXjXGxdFUbLRnE=;
        b=dP8u4CtVKXCNbb2CAS991Vh1ad0yhAVlwuPS7WXBUDifdmafLgq0hKSpfyKhc4/CvU
         M1maEjcgUP7+Qd45VwSnB3mMxS6MFGtndKgcGyZK5nO2xpB16k5SdpnmuUMQMRcN/LXT
         S1WXmhKtcup0RdxDviDR5PfaygGVZeCCijHkyb7Pf8W54cszS/3pgfxO1uz1Cs81MntC
         A6KuWggJAyEnU3sZ7+bW8vqWxe8iE0OOFR8pxQmrURkdruwvUcK1fdcCDFX4i9fej3vl
         8GpKWuA6ptabORzqdcCxY2AuWYlV5Kj6EOigFxxm5ejNkR9K02eP254nYBK23ekXQILH
         yurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZXTNkYXQHnTQSZD4ZzDdjes6xAr43HXjXGxdFUbLRnE=;
        b=8C5ZWsdC1POiVW2trsBt+R+rds6GKrmwK95LaBoXobnFxNVe4Ag16VXkpaZxuz4tPP
         Xy0+hl5QwsL+QiKaAW56OytltmeO8Kh5N6cx2pzcH5CK8FfzahRsTMN2Yuno7kLOvO+b
         Bea194Zre4Ki4uehDBFSr5Mj9jT8wR+hRM7G1AuzoV5tSbS5v7SJ/A/IYjAOneQWO3hW
         MR6ELEHGB6xF51kvpyEnJIIJVob1nRCFcdS4xHqv6t8Mcj/DTMpRsaDzANb40CcNwRso
         drSFf7VBy7rtsYRU1q27ktvjstsKQvW6BG1K+6rMJ+axLfrpwBUTqaPknYx1GhUsaDfG
         lsxQ==
X-Gm-Message-State: AOAM531accyULurZZ9Xb5F10ml0MmKU4dPRtOgONRDLzIWSHUhu219hd
        BJ1BNngXoYy6NE+SU147Gpc=
X-Google-Smtp-Source: ABdhPJwq5NDxB+zb3LmrxqlAKT6sdnILpFGCQR5edZiTzLkQeIuRRYSEaeKy+Lf/FAM6M3t4nwtBaA==
X-Received: by 2002:a2e:bf05:: with SMTP id c5mr9283889ljr.104.1639085034919;
        Thu, 09 Dec 2021 13:23:54 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id y11sm107408ljd.117.2021.12.09.13.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 13:23:54 -0800 (PST)
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
Message-ID: <3f7b072d-f108-ebce-e862-eff9869d1d92@gmail.com>
Date:   Fri, 10 Dec 2021 00:23:53 +0300
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
> +static const struct __maybe_unused dev_pm_ops tegra_dma_dev_pm_ops = {
> +	SET_LATE_SYSTEM_SLEEP_PM_OPS(tegra_dma_pm_suspend, tegra_dma_pm_resume)
> +};

Why late?
