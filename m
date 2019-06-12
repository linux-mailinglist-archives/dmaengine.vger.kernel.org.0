Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2496447D4
	for <lists+dmaengine@lfdr.de>; Thu, 13 Jun 2019 19:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbfFMRCJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Jun 2019 13:02:09 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45487 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729525AbfFLXOj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Jun 2019 19:14:39 -0400
Received: by mail-pg1-f195.google.com with SMTP id w34so9729453pga.12
        for <dmaengine@vger.kernel.org>; Wed, 12 Jun 2019 16:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hpdxxdnECrCjfxRQwQAXITDsXaRY4S9Y8qNe9cxvook=;
        b=q5HV6uR0qU8gfYERpbtgOXiB16bdDKZqjJ8yqVAfRUsCVrr5UW/VXIBUMalc8kGJ8e
         SW7vyN8ZLRzUsDrmlPCeMSaqxOd8NAk8riv426uuleJQLBjjdTxd6ru4CW97jxqxoNj0
         pcIfFYgGvVNX3u0Fayt2GCS0cMD2hUYzwXOQ6Icz4dsJaconOW9atwDICfo6tWeujct9
         +411xP5ry8xLiW2r1AhVFPkoCcKzJa0MaXshle9M8188Eo/h3VW4RprwrwerqSKSq7Lt
         3J7LbbB9FVNZp3WJm5sKC7P3Ic8etu9+CgIvgCmarryYcQLvbtzVS5rNackF2tSbrJfR
         E78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hpdxxdnECrCjfxRQwQAXITDsXaRY4S9Y8qNe9cxvook=;
        b=tVMwWj5vDF+2w+uouuhC1SXpXbP3800yW7Ar/M+WdMSSGbZzmnJL90zJbwboOHsQeR
         q2CW8LJt/DetEMSqU7tCF4/cATRnYX2cO3j7/QPcUikyAT1OnmC4BdFPFWfTOAYXs8za
         YaBmdOLz/7lZnDXZ3Lp2/0RbOTpOehoBN0Huzlql7iingrDSR7dJONHzprYODbFyuG7A
         IwM/xNctghkQML6zJ/xk9mQrIxmeFbREsQbV5HN5XTmO7WBpLAZGRfQEZKvd/EGeDa6U
         FOrCeDYWq/yWsX7Nhw7ISU4QG5lSajuG3TvLgbq6bXhn0QDz9wv+C26JkuT/QO1wXHS3
         C+jQ==
X-Gm-Message-State: APjAAAXsFefvpzl3pvkjgEbBjiE1X8UI4BpFwFCMyxh5ebaXiTrxabQz
        rMGKx1BryTfnoFkghJ3uxfhX8WBkqk0LP0QvPMN79A==
X-Google-Smtp-Source: APXvYqztz5V4dpKFE1Y8iXl/I0qdlviNE8GgjRikSDpqDKtChZ+KTIWt5CleNZQU3O9ZT60wDef+zNwlYot5W099IjY=
X-Received: by 2002:a17:90a:2488:: with SMTP id i8mr1547499pje.123.1560381277880;
 Wed, 12 Jun 2019 16:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190612225419.241618-1-nhuck@google.com>
In-Reply-To: <20190612225419.241618-1-nhuck@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 12 Jun 2019 16:14:26 -0700
Message-ID: <CAKwvOdkAJcOCGvveBYaDD2kf4vx7m=b+Nxyn3_n=9aCBapzDcw@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: mv_xor_v2: Fix -Wshift-negative-value
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, vkoul@kernel.org,
        dmaengine@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jun 12, 2019 at 3:54 PM 'Nathan Huckleberry' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
> Upon further investigation MV_XOR_V2_DMA_IMSG_THRD_SHIFT and
> MV_XOR_V2_DMA_IMSG_TIMER_THRD_SHIFT are both 0. Since shifting by 0 does
> nothing, these variables can be removed.
>
> Cc: clang-built-linux@googlegroups.com
> Link: https://github.com/ClangBuiltLinux/linux/issues/521
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> ---
>  drivers/dma/mv_xor_v2.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
> index fa5dab481203..5d2e0d1f3ec9 100644
> --- a/drivers/dma/mv_xor_v2.c
> +++ b/drivers/dma/mv_xor_v2.c
> @@ -261,16 +259,15 @@ void mv_xor_v2_enable_imsg_thrd(struct mv_xor_v2_device *xor_dev)
>
>         /* Configure threshold of number of descriptors, and enable timer */
>         reg = readl(xor_dev->dma_base + MV_XOR_V2_DMA_IMSG_THRD_OFF);
> -       reg &= (~MV_XOR_V2_DMA_IMSG_THRD_MASK << MV_XOR_V2_DMA_IMSG_THRD_SHIFT);
> -       reg |= (MV_XOR_V2_DONE_IMSG_THRD << MV_XOR_V2_DMA_IMSG_THRD_SHIFT);
> +       reg &= (~MV_XOR_V2_DMA_IMSG_THRD_MASK);
> +       reg |= (MV_XOR_V2_DONE_IMSG_THRD);
>         reg |= MV_XOR_V2_DMA_IMSG_TIMER_EN;
>         writel(reg, xor_dev->dma_base + MV_XOR_V2_DMA_IMSG_THRD_OFF);
>
>         /* Configure Timer Threshold */
>         reg = readl(xor_dev->dma_base + MV_XOR_V2_DMA_IMSG_TMOT);
> -       reg &= (~MV_XOR_V2_DMA_IMSG_TIMER_THRD_MASK <<
> -               MV_XOR_V2_DMA_IMSG_TIMER_THRD_SHIFT);
> -       reg |= (MV_XOR_V2_TIMER_THRD << MV_XOR_V2_DMA_IMSG_TIMER_THRD_SHIFT);
> +       reg &= (~MV_XOR_V2_DMA_IMSG_TIMER_THRD_MASK);
> +       reg |= (MV_XOR_V2_TIMER_THRD);

Don't need the parentheses anymore. Please send a v2.

-- 
Thanks,
~Nick Desaulniers
