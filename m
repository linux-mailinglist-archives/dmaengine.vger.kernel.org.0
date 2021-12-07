Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC29046AFE2
	for <lists+dmaengine@lfdr.de>; Tue,  7 Dec 2021 02:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbhLGBmO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Dec 2021 20:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhLGBmO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Dec 2021 20:42:14 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4287C061746;
        Mon,  6 Dec 2021 17:38:44 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id j9so11612799qvm.10;
        Mon, 06 Dec 2021 17:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TtX5Ua1bFK7U/ze5aptE0nmXvt0FV6UQIzQSovRpPk0=;
        b=Fc0NJJWlIsvOOQPTjV7ybl0o/gG2buF2Ao4AFw3HZBtOUMHdx3N0b0GDbMrHdVHEGr
         f2VU5s02Q5oCnpngXUvm1iyQuvbmGiGRQv6C0jmWei7y5mEJh5X0wNVhWSQ3qn0fNSiT
         R6N4NdC32Glypm4dJBTgBddG4mlV6ACgPJlA/pFEY0If4iycaICREhU3ZY4Ib3uT+jW2
         XhJmT8jPasUUVCewWaBBr6TzLP6R2ahvVKUgM1uDhNQeLsiKvC07MuKzhrVk5o0IYFj8
         W4MTTTs7NJnFfd0oy97QJO+L+yjdmRyMsTrRxlYhjrCMCU2qVRs4UO1AWihwupydpPhJ
         rwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TtX5Ua1bFK7U/ze5aptE0nmXvt0FV6UQIzQSovRpPk0=;
        b=M0swkeHtN/uaY4UJT/fVFLn4Ewl31x9Ra4NKNUI94NV1JmxAsv/2Okn2vZza2UAbF0
         bhBXT3KJfx1I1hWpkEB6qNbMDtAWYJ4pv2bRdTWiM1pCWTtD6CexawhJaNZ9X5C9eTSi
         zCmSjhndJsb5V2FB1I9oYXl+TSEPs6SgZnu70JdX3nIZy39yr8QwTYB+ybZ6sU2JAH1q
         h20Ml8l9XNNiHU7kD6QeEou+bvQE6hb679jmW8oB/DU9oNmoAG+ligH2eBaeqAHvIws5
         x0rgfGn/6xUXtuY+7rvr9/FEsjPV2/dRg9eO4vQwBWR+U5mpx6lMovU/XxF+F2jG0TBz
         08Mg==
X-Gm-Message-State: AOAM533dzkeohOcbU9hTmR26kZICmT1qX1EeZqbPvIhsmZzOi6FuFZ/p
        0luMkVXgqgPQ6LX0qGg67iK0I5Dq3fMYGP/tRAg=
X-Google-Smtp-Source: ABdhPJw9IBOmfDzr2lw9BdL22wzIVyQOHdH9Q/My/9L3cfmA6oJbyB4PFgg0Wceil0iKnLXIVfFpqkyL+Ebm2HeIx70=
X-Received: by 2002:ad4:4027:: with SMTP id q7mr41260760qvp.117.1638841124062;
 Mon, 06 Dec 2021 17:38:44 -0800 (PST)
MIME-Version: 1.0
References: <20211206113437.2820889-1-mudongliangabcd@gmail.com>
In-Reply-To: <20211206113437.2820889-1-mudongliangabcd@gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Tue, 7 Dec 2021 09:39:24 +0800
Message-ID: <CADBw62pSJ=rHjwTocxeeuCgtadLKqz-U7gAQek5Eo_bBQSzBzQ@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: sprd: move pm_runtime_disable to err_rpm
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Baolin Wang <baolin.wang@spreadtrum.com>,
        dmaengine@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Dongliang,

On Mon, Dec 6, 2021 at 7:34 PM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
>
> When pm_runtime_get_sync fails, it forgets to invoke pm_runtime_disable
> in the label err_rpm.
>
> Fix this by moving pm_runtime_disable to label err_rpm.
>
> Fixes: 9b3b8171f7f4 ("dmaengine: sprd: Add Spreadtrum DMA driver")
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---

Thanks for your patch, but looking at the code in detail, I think we
also should decrease the rpm counter when failing to call the
pm_runtime_get_sync().

--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -1210,7 +1210,7 @@ static int sprd_dma_probe(struct platform_device *pdev)
        ret = dma_async_device_register(&sdev->dma_dev);
        if (ret < 0) {
                dev_err(&pdev->dev, "register dma device failed:%d\n", ret);
-               goto err_register;
+               goto err_rpm;
        }

        sprd_dma_info.dma_cap = sdev->dma_dev.cap_mask;
@@ -1224,10 +1224,9 @@ static int sprd_dma_probe(struct platform_device *pdev)

 err_of_register:
        dma_async_device_unregister(&sdev->dma_dev);
-err_register:
+err_rpm:
        pm_runtime_put_noidle(&pdev->dev);
        pm_runtime_disable(&pdev->dev);
-err_rpm:
        sprd_dma_disable(sdev);
        return ret;
 }

-- 
Baolin Wang
