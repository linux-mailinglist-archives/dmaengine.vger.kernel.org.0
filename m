Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A53137BC07
	for <lists+dmaengine@lfdr.de>; Wed, 12 May 2021 13:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhELLsS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 May 2021 07:48:18 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55327 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhELLsS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 May 2021 07:48:18 -0400
Received: from mail-vk1-f197.google.com ([209.85.221.197])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lgnKX-0007OQ-86
        for dmaengine@vger.kernel.org; Wed, 12 May 2021 11:47:09 +0000
Received: by mail-vk1-f197.google.com with SMTP id u186-20020a1fddc30000b02901eb1ea824ddso2973310vkg.12
        for <dmaengine@vger.kernel.org>; Wed, 12 May 2021 04:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yBitZcNhIM9z4KET6YAuzNPYaMvvVUiEAXXH4qj8xVM=;
        b=mcFI/xuFPlR27702izBNk9Nt1Yy4mzqqU2p+KqSEHhlu0iA7TtY2M6XH626CZfjzvC
         S9Ex2xp5KdwYGZoDQRdQxSQfuglTrLU/yaS8TIog2Nll/xKL/hdu1GLvTzics3uoluif
         d7HXxKW3gEFWPKFfw/B0DI1A9S7ILH95X6cH6MExBL2wTJFOE9yDhmBGuaQXcC1b+mzy
         8HYt4H7JIzvP/wvngFFTM7k7Bk2l3aW4QDujdaZmZuX5GxR9TaT+fMcWGbZ/dmRP7G43
         RrYc7CSv1nICUTFUBNNEL/eMmqyaN44hL7b1ctt1XeKybupLp3EdJJE3TbA8sIIh5pue
         OaWw==
X-Gm-Message-State: AOAM532TkdpdvUtNqQbavl1v2qyU90IehFeynrOaaiHI5m2f95NU/HCu
        awtTqZvaoptk40vVSHfIYQGKFaCyrU+gV9NXAVnpAGscJzTDU3DGxnoIb6MK8+JFxpgH0T5zlD6
        QFUqXS4jWbRVixLGcVD4zvOQIxMQU+XjdkLjJMQ==
X-Received: by 2002:a67:e915:: with SMTP id c21mr32088439vso.32.1620820028096;
        Wed, 12 May 2021 04:47:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYslrlexrDVfJAQWZv27Gx/WKb27rynSQ4drYxmvnOGuiXWdUXlFKZ/Vt3FdWmjVrKIrO69Q==
X-Received: by 2002:a67:e915:: with SMTP id c21mr32088437vso.32.1620820027940;
        Wed, 12 May 2021 04:47:07 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.48.6])
        by smtp.gmail.com with ESMTPSA id s200sm2594366vks.34.2021.05.12.04.47.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 04:47:07 -0700 (PDT)
Subject: Re: [PATCH -next] dmaengine: s3c24xx: add missing MODULE_DEVICE_TABLE
To:     Zou Wei <zou_wei@huawei.com>, vkoul@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1620801555-18805-1-git-send-email-zou_wei@huawei.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <ee04c671-1194-402f-c82f-36c139dd5ca7@canonical.com>
Date:   Wed, 12 May 2021 07:47:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1620801555-18805-1-git-send-email-zou_wei@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12/05/2021 02:39, Zou Wei wrote:
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.


Hi,

Thanks for the patch. It cannot be built as a module.

> 
> Reported-by: Hulk Robot <hulkci@huawei.com>

Please make the reports public. This is open source work and public
collaboration.

Best regards,
Krzysztof

