Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CF777E659
	for <lists+dmaengine@lfdr.de>; Wed, 16 Aug 2023 18:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344400AbjHPQ1H (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Aug 2023 12:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344735AbjHPQ1C (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 16 Aug 2023 12:27:02 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACA210EC
        for <dmaengine@vger.kernel.org>; Wed, 16 Aug 2023 09:27:01 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-6434cd84a96so140136d6.0
        for <dmaengine@vger.kernel.org>; Wed, 16 Aug 2023 09:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692203221; x=1692808021;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6f27s+Wx+pCW5RRcZkqOBNW0HED0Cz6eU7OxX3HyNik=;
        b=FAgOhxhO3dwvhjhio2XKGFgsM0+HfIgj3q1ChYnRzYJuRwtJIgyS/KLSQFqHd/ll3U
         1VlBd129z3vWntft2xlS2vsHBk16LzIkDE1r3kwodVKSH5nsKVKWsRKAkg5+mhmJbNua
         2RCp5cSUSFmU+QD0rPS3oNwzk2ZiaqA5PJivj3c24pnWXhceYCxCQJ0m5/ZTSjdGCwtB
         Gipg9sNmA7/GmKFJ3R97fDndFisoZshFVmrQRb+lsL69ARfwXcptzhZMiFNO7I8r05Gh
         s1PqfWHdQtogqyOdBtGafO+thLPuJWEaNRWwgaRB4dPrjx0hy3OX5ov93UOW7KQQTWHZ
         OR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692203221; x=1692808021;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6f27s+Wx+pCW5RRcZkqOBNW0HED0Cz6eU7OxX3HyNik=;
        b=NDzOQThuF83dzRVYC0wyotzDDtEtx4FODBuE5SRKFXhMtgL8GUo+qEM1fdm6vqRu4b
         q30zTt76ivFD5AEkEDLYNIVTO9+oJmm0EESBJ9av3vfV/PP/8U3w3PxVEuD13jHEk5bk
         wsxme8ORYurXgvWHRZv9qZpPojryHaGZToCoxha+W8gKrqCdZsdlAHC0hD4rLtC4hvvY
         a0X8EH5jqUH8+3M1VGvuCUyI+FFPPZ/WVIAVW6KHVf0xB+w9xLRNvDN7UlAnKCG1zD5E
         0MvOYEbMey45JHxXd9+hfO0vZn/tbRDzgkeD81Q2TgPiB1M/ZlRQJPw5swch9HDWu8Xu
         WXjA==
X-Gm-Message-State: AOJu0YziYjMbbqzmeDR4wWr/72u/kiN0MmAGvZ9iamfD7/mFkH7bvQ9s
        fahMaQfiWhhCh3usrYmJe4ueZPoayRC1kR4UUWwTyQ==
X-Google-Smtp-Source: AGHT+IE2s1Q6441rknpJ44fk3rDX1cxX8JweaKnu0+1b94qtJnFJis3dzfKVmtrglJAqPmBMRNJeEh4LCzVinAA4qyw=
X-Received: by 2002:a05:6214:d64:b0:636:3f18:4c2b with SMTP id
 4-20020a0562140d6400b006363f184c2bmr125290qvs.29.1692203220632; Wed, 16 Aug
 2023 09:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230726090628.1784-1-dg573847474@gmail.com>
In-Reply-To: <20230726090628.1784-1-dg573847474@gmail.com>
From:   Jassi Brar <jaswinder.singh@linaro.org>
Date:   Wed, 16 Aug 2023 11:26:50 -0500
Message-ID: <CAJe_ZhcN7P7z_W9r5RZ6qA5qLRkXzC3cw7+Vj3GXGyw5HuFxgw@mail.gmail.com>
Subject: Re: [PATCH RESEND] dmaengine: milbeaut-hdmac: Fix potential deadlock
 on &mc->vc.lock
To:     Chengfeng Ye <dg573847474@gmail.com>
Cc:     vkoul@kernel.org, sugaya.taichi@socionext.com,
        orito.takao@socionext.com, len.baker@gmx.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 26 Jul 2023 at 04:06, Chengfeng Ye <dg573847474@gmail.com> wrote:
>
> As &mc->vc.lock is acquired by milbeaut_hdmac_interrupt() under irq
> context, other acquisition of the same lock under process context should
> disable irq, otherwise deadlock could happen if the irq preempts the
> execution of process context code while the lock is held in process context
> on the same CPU.
>
> milbeaut_hdmac_chan_config(), milbeaut_hdmac_chan_resume() and
> milbeaut_hdmac_chan_pause() are such callback functions not disable irq by
> default.
>
> Possible deadlock scenario:
> milbeaut_hdmac_chan_config()
>     -> spin_lock(&mc->vc.lock)
>         <hard interruption>
>         -> milbeaut_hdmac_interrupt()
>         -> spin_lock(&mc->vc.lock); (deadlock here)
>
> This flaw was found by an experimental static analysis tool I am developing
> for irq-related deadlock.
>
> The tentative patch fixes the potential deadlock by spin_lock_irqsave() in
> the three callback functions to disable irq while lock is held.
>
> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
> ---
>  drivers/dma/milbeaut-hdmac.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/dma/milbeaut-hdmac.c b/drivers/dma/milbeaut-hdmac.c
> index 1b0a95892627..6151c830ff6e 100644
> --- a/drivers/dma/milbeaut-hdmac.c
> +++ b/drivers/dma/milbeaut-hdmac.c
> @@ -214,10 +214,11 @@ milbeaut_hdmac_chan_config(struct dma_chan *chan, struct dma_slave_config *cfg)
>  {
>         struct virt_dma_chan *vc = to_virt_chan(chan);
>         struct milbeaut_hdmac_chan *mc = to_milbeaut_hdmac_chan(vc);
> +       unsigned long flags;
>
> -       spin_lock(&mc->vc.lock);
> +       spin_lock_irqsave(&mc->vc.lock, flags);
>
while at it, maybe also use vc->lock, instead of mc->vc.lock here and
in other two places, just like the rest of driver.

Acked-by: Jassi Brar <jaswinder.singh@linaro.org>

thanks.
