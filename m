Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C0128452A
	for <lists+dmaengine@lfdr.de>; Tue,  6 Oct 2020 07:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgJFFEB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Oct 2020 01:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgJFFEA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 6 Oct 2020 01:04:00 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4567C0613A7
        for <dmaengine@vger.kernel.org>; Mon,  5 Oct 2020 22:04:00 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id z26so11284586oih.12
        for <dmaengine@vger.kernel.org>; Mon, 05 Oct 2020 22:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QGu57He4y/dCOvt7o+WgVrO1Sgkn4+jpedCapUyqhfs=;
        b=IQkcA16iS8dPd3Wxh3N0GOLWjkSZ0o5wWLJux79NGl21txbBJIUs3VI3qKfQ9d44fK
         SBV4UaKrkzLo/Xm0RL/kgdbIOdcl1/YBjwy48yZZYxtz9RpozGPP7wbC+VuWXJLrdnyB
         XjqpYdq0u9AT+lAvH2RuGKqyfVCpWJyCSbnTXlmE/tN7qaelEaT62PIRz9lOT0rMhzf5
         gM73CnYX1aBl1yB1cfB9RY8eLutdeeqr/ahC2E/ygRZHFisz4A24z4m9oZPJKkQsvyKv
         gwTejQpbOarcH8ESSUDXR1Dz5PyN0XnQGOydBWq7ovUVBAbvGl2phZjkkglLrybZ35S9
         esPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QGu57He4y/dCOvt7o+WgVrO1Sgkn4+jpedCapUyqhfs=;
        b=E0qyarx4dndHFNUvv6Ai9VbFwMx3WKQK27fOaYOrGctPtwOGlqIQc7f9UsGTuv5+Pz
         KRVc58BIj8CQZaAdcu7tlpB9j82HZAYD3A0QhN6hKenBqvC/TIr4d5tfd1AqUemTrYLE
         gnUYNPmPc6lkOta9N3Nrrdgmzkv48WeYzaBoyQRuzBO4xsdPyCpBcDST2g6+HIBJBa1y
         lRgSjLoBENMw0XfMbYtO7ybjUl6sAvlZJ8yGpXbS6hAKuWKpBSYWl9ig86J7hp3NnQe/
         r0Pr3kvlyPeKpIXObL/1SehyusdfaV+vjtmv0ElXweIcioGwoLqw/Q2wxPsJM0TGg74A
         +h8Q==
X-Gm-Message-State: AOAM532IHd5WuRrdUuqXCHRnsfmxWlG84SWtUyFXh7vE9kNmyWHEZlBN
        xREqKKemF6XxYy4TN7TGonAWlqDwyUvgtktxyi8=
X-Google-Smtp-Source: ABdhPJy0/+vU7wmZfETx/FUuElu90bPE9u0NLBXAA8R5aDJ+bhv+1bxcf1xecYxk+XGvQ6nQwT1Iecli6ZEFuB7NxKI=
X-Received: by 2002:aca:1815:: with SMTP id h21mr1625073oih.154.1601960640149;
 Mon, 05 Oct 2020 22:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201001164740.178977-1-vkoul@kernel.org>
In-Reply-To: <20201001164740.178977-1-vkoul@kernel.org>
From:   Allen <allen.lkml@gmail.com>
Date:   Tue, 6 Oct 2020 10:33:47 +0530
Message-ID: <CAOMdWS+E2uNzBFRu7kWmaK_DfxdoGmNz8jpueaR7zezk69psgQ@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: fsl: remove bad channel update
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, Romain Perier <romain.perier@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> Commit 59cd818763e8 ("dmaengine: fsl: convert tasklets to use new
> tasklet_setup() API") broke this driver by not removing the old channel
> update method.
>
> Fix this by remove the offending call as channel is queried from
> tasklet structure.
>
> Fixes: 59cd818763e8 ("dmaengine: fsl: convert tasklets to use new tasklet_setup() API")
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/dma/fsl_raid.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/dma/fsl_raid.c b/drivers/dma/fsl_raid.c
> index 1ddd7cee2e7a..fdf3500d96a9 100644
> --- a/drivers/dma/fsl_raid.c
> +++ b/drivers/dma/fsl_raid.c
> @@ -163,8 +163,6 @@ static void fsl_re_dequeue(struct tasklet_struct *t)
>         unsigned int count, oub_count;
>         int found;
>
> -       re_chan = dev_get_drvdata((struct device *)data);
> -
>         fsl_re_cleanup_descs(re_chan);
>
>         spin_lock_irqsave(&re_chan->desc_lock, flags);
> --
> 2.26.2
>

Thank you.

-- 
       - Allen
