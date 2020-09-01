Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28FB2585FB
	for <lists+dmaengine@lfdr.de>; Tue,  1 Sep 2020 05:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgIADE3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 23:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgIADE3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 23:04:29 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C8BC061366
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 20:04:28 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id e5so3651653qvr.3
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 20:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ECy1gO52sW+Swnf3y3Fh4qtMOGE+pPMTycqEvJknoks=;
        b=bQN7eB/NLE5pTPqaKOY+BK/pEawTnJHw2+CVTSCmT2cxQWc+7zXlLm8FzjNt9mBZa8
         RiAkuiAOLQ3NUF7Il/xdgMP6+DNdM3iglJlVl0dwfX1/gmLbQ4cMgUei17skZtSTJCQ9
         E4fxU2rZnTAtkqhFNrNm/dVRIlQ7A/e3sytZiubr1HQDWzD2UWgz2FsNIXaJpd8oyCOb
         GDyVfHihadPmie+2hGV6xkVtiQHPSSOB54tSoAs9x0wUPLJa0Ky9ZVlFbAK89xT97CVU
         HdhHf+oZAUtftnBaRgHsJsYtJgaHRZ1edI0e9TpBjaggbOKt0oygr09pxGa5q3JnSByd
         ALjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ECy1gO52sW+Swnf3y3Fh4qtMOGE+pPMTycqEvJknoks=;
        b=ec5QrB5snH75pIi1CED+QI8gEMrJQPHguckiYPyxeQke9C0bzZ3vl7hcHZfEA7U1jp
         oYsPLlckpTr9OkphI336CmFtN9ouwZatG+9C+oLIbEyEQf7ETZ3Z13Tef6zucAgLLkvo
         BBmei2qF/SOmUm60s+6tDvWoN6IdLXMBwqjZHpiLCTFo/0knPpWYZDiRscauycczmFZk
         KZag4dEltVICbfa6xLNyLJUEc0LvuWmECpjZjFn4J5MmXV/76WGy6GrJBgcP5kzm4BvZ
         uqoY3QZnzs4N3jZoUhgpJT+5ikJtlSFy9pt1526JEpnh9mYS77ned28orXYf7gxgGkI1
         wqyg==
X-Gm-Message-State: AOAM531o467/g238/8768z31uTKCnjoI6wqutnJFURb7gz/EhggLBwTV
        jZCRLzILgyjuQd2BNr8BkL0UF7WIARYA97NNpGJ50w==
X-Google-Smtp-Source: ABdhPJzqXXTFFZQ6pMCNXEB04FVVa1cn28QsPmZvqWvJ6lYwYYTqE8veDF4E2I/zKsAuGuMCOWLlKyeh3wgsd93kOf4=
X-Received: by 2002:a0c:a004:: with SMTP id b4mr4178983qva.46.1598929467805;
 Mon, 31 Aug 2020 20:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200827133309.17362-1-brad.kim@semifive.com> <CAJivOr4iT-GZ_CcAHRPp9rjZbOaBXcX6j4KGQH=XuGoArZSnsg@mail.gmail.com>
In-Reply-To: <CAJivOr4iT-GZ_CcAHRPp9rjZbOaBXcX6j4KGQH=XuGoArZSnsg@mail.gmail.com>
From:   Green Wan <green.wan@sifive.com>
Date:   Tue, 1 Sep 2020 11:04:15 +0800
Message-ID: <CAJivOr4os24woM7477=J=fCh_YzeRSQWg7W5-2jWtkpJnD2Hvg@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: sf-pdma: Fix an error that calls callback twice
To:     Brad Kim <brad.kim@sifive.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Brad Kim <brad.kim@semifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Looks good to me.

Tested-and-Reviewed-by: Green Wan <green.wan@sifive.com>


On Tue, Sep 1, 2020 at 9:43 AM Green Wan <green.wan@sifive.com> wrote:
>
> Looks good to me.
>
> Tested-and-Reviewed-by: Green Wan <green.wan@sifive.com>
>
> On Thu, Aug 27, 2020 at 9:33 PM Brad Kim <brad.kim@sifive.com> wrote:
>>
>> Because a callback is called twice when DMA transfer complete
>> the second callback may be possible to access a freed memory
>> if the first callback routines perform the dma_release_channel function.
>> So this patch serialized the callback functions
>>
>> Signed-off-by: Brad Kim <brad.kim@semifive.com>
>> ---
>>  drivers/dma/sf-pdma/sf-pdma.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
>> index 6e530dca6d9e..754994087e5f 100644
>> --- a/drivers/dma/sf-pdma/sf-pdma.c
>> +++ b/drivers/dma/sf-pdma/sf-pdma.c
>> @@ -295,7 +295,10 @@ static void sf_pdma_donebh_tasklet(unsigned long arg)
>>         }
>>         spin_unlock_irqrestore(&chan->lock, flags);
>>
>> -       dmaengine_desc_get_callback_invoke(desc->async_tx, NULL);
>> +       spin_lock_irqsave(&chan->vchan.lock, flags);
>> +       list_del(&chan->desc->vdesc.node);
>> +       vchan_cookie_complete(&chan->desc->vdesc);
>> +       spin_unlock_irqrestore(&chan->vchan.lock, flags);
>>  }
>>
>>  static void sf_pdma_errbh_tasklet(unsigned long arg)
>> @@ -332,8 +335,7 @@ static irqreturn_t sf_pdma_done_isr(int irq, void *dev_id)
>>         residue = readq(regs->residue);
>>
>>         if (!residue) {
>> -               list_del(&chan->desc->vdesc.node);
>> -               vchan_cookie_complete(&chan->desc->vdesc);
>> +               tasklet_hi_schedule(&chan->done_tasklet);
>>         } else {
>>                 /* submit next trascatioin if possible */
>>                 struct sf_pdma_desc *desc = chan->desc;
>> @@ -347,8 +349,6 @@ static irqreturn_t sf_pdma_done_isr(int irq, void *dev_id)
>>
>>         spin_unlock_irqrestore(&chan->vchan.lock, flags);
>>
>> -       tasklet_hi_schedule(&chan->done_tasklet);
>> -
>>         return IRQ_HANDLED;
>>  }
>>
>> --
>> 2.17.1
>>
