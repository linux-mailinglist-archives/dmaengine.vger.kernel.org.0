Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2168B378F70
	for <lists+dmaengine@lfdr.de>; Mon, 10 May 2021 15:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbhEJNnm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 May 2021 09:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345072AbhEJNhI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 10 May 2021 09:37:08 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D2DC061200;
        Mon, 10 May 2021 06:26:42 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id r13so8258372qvm.7;
        Mon, 10 May 2021 06:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jklOc3icgheG5q/B29LMt1SbezKUwO76sv5JG0Oh0EE=;
        b=nJKRQPvBReJZSVuBEwKej2dTNH3uRx/1Mwx7kejjEc1eplMshYotpY7upFXa6BEstL
         ExJVd0JMAaOEVxdTsh74sOrLPuPQ84E6tZNup/48vQAC/4m5BaFeqUjmiSlrGaIfywGJ
         BeWKlAn8VANBOn/b1S3DM8ogw3APQUf78c6U4f+QYvc3awBzG9oV9FC2g/du5C5ebA37
         aLj8ZYnC204qLD39TR+9Qb6N7JEtspbcZdZOmqZf2lvDTqJCHTz9wTVPweV8BTIRWdG5
         EdY0Huy3iLT/QLIpiXxaDJFe8Q6fHI2GzC/dSg8jRFXuZ4PBepQ6aSDMTmXAKs8wedNG
         D4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jklOc3icgheG5q/B29LMt1SbezKUwO76sv5JG0Oh0EE=;
        b=AHpukIhSJdK8o58Dc+p6vN+kMQGa/q5+yl/e2/tIGfa3YfRjrFEaGj6pdApABIcvJ/
         Cv7hikXqj3Ot60DVCswAG9vTBiEVacysCQYkmaSaa0/yuHKnBX4pyza/2gcq2SZhtV1k
         9WTqt7PQwtqy+jcsMClOcI33Gmwfz4Tvp+Kp94lgscJhqJBZtqV6lVVDN/2bVNIbW+D8
         kt0aneY274Ai6YnhWHloeZWrKQVj9nC6Yc6wHwQBDL+wCEB6G4Krii/4Kue7VU4/h4ju
         b8bDRAyQLJkMpql2FAIwVeJzU0DUeMZ0fuTSQsZdGksTPnnTnjf/PrEZ/e1518JEf0qq
         xLlQ==
X-Gm-Message-State: AOAM531PSFpLC6ekxha2kTTAMfD6NWwAJQXK1tVhp1tpS+bvqkcu34K1
        QAtbyrjkIlJin5SiJgKiquV2J6bznh4IV5HYwf4=
X-Google-Smtp-Source: ABdhPJxREruRZN+3MgQJ1KDl5qMRva1NVpCcoVdryxhiZ40/MtP0hrp0sNeqwrY5UaX814L7hEnkcAKEGjS21Pz9ZCs=
X-Received: by 2002:a0c:c447:: with SMTP id t7mr23673693qvi.60.1620653202090;
 Mon, 10 May 2021 06:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <1620094977-70146-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1620094977-70146-1-git-send-email-zou_wei@huawei.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Mon, 10 May 2021 21:26:50 +0800
Message-ID: <CADBw62q+kwNE1V9HDeK=87co0TSOODFG--S2_ywVdhL2+A9WHA@mail.gmail.com>
Subject: Re: [PATCH -next] dmaengine: sprd: Add missing MODULE_DEVICE_TABLE
To:     Zou Wei <zou_wei@huawei.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        dmaengine@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, May 4, 2021 at 10:06 AM Zou Wei <zou_wei@huawei.com> wrote:
>
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>

Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>

> ---
>  drivers/dma/sprd-dma.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
> index 0ef5ca8..4357d23 100644
> --- a/drivers/dma/sprd-dma.c
> +++ b/drivers/dma/sprd-dma.c
> @@ -1265,6 +1265,7 @@ static const struct of_device_id sprd_dma_match[] = {
>         { .compatible = "sprd,sc9860-dma", },
>         {},
>  };
> +MODULE_DEVICE_TABLE(of, sprd_dma_match);
>
>  static int __maybe_unused sprd_dma_runtime_suspend(struct device *dev)
>  {
> --
> 2.6.2
>


-- 
Baolin Wang
