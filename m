Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7180220FB7E
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2020 20:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390708AbgF3SOr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Jun 2020 14:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390707AbgF3SOq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 Jun 2020 14:14:46 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DC4C061755;
        Tue, 30 Jun 2020 11:14:45 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id h28so17120281edz.0;
        Tue, 30 Jun 2020 11:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J4eE12BOE1HalE843yy2+ABkRGNvy5RVDqgV4Do+Hxs=;
        b=b0p9lJnA9AEnQ/OCFLRDracrYFp4I6OVuWsJcT/octsL0opJ8r/zfNPOlkBBhQP6jj
         A3Sl/EeNlagvrkjHf5S1TIRIdVxqLhQEz+EH/ID/dca5NUdHN4ucOubimvul3Ae5cih0
         7KyNI2zkfSGwYCliLNv1Rb5LZdXnqEIy4uoZKrpRyLepkBd9CJ1peAimbT99k8bv8kTA
         vkhzw/XP4RwwB9bDBDa9vX6B8sh7SX2tWPU2erQ6hMlFI/wcz7HUbLeSgYHu3rXNj38H
         Hwu4MYFdxfIJatJO1mPQlTM1yDEbKlH4KhwqN88dKc9lN8emDE4jtBn/RJFdXg8ru3qO
         sUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J4eE12BOE1HalE843yy2+ABkRGNvy5RVDqgV4Do+Hxs=;
        b=kLVDq6MMRZJMZu2ihz92qwxh6nMH55gVoyPtYFllce+uzjQcr3AtzcDL6IVEE5pdHE
         YP8pPHnRsHVl26ATtNYp4bxPl80CQNAORoSb0dhVuvrlMPvgs1UqFELVLScMKr245ZCB
         dvN8EtkWGo/z+cuTyfDC/sdwL8l6j4oRy1cMhckosnHG32NenG0t23UE3MefRN7Pge8O
         1ZwqLSmLJApbxxkp97yIn9b9KCJM26rR/xFKBvyb3JcW+P66d7dWb9hEqsKVCk48fQFo
         sxZstTEDwR0QgJkEdDKnpDWx1x6MlAT/EvtSjKJpfbw7f4+uFicg6AuL3Ny8DClIhtBh
         GLnQ==
X-Gm-Message-State: AOAM532nQjTM9Q5yEY/47XzeNsajcVN93q7Idz5OpeUzuJpdjbn0GPHu
        ToBigYCYcwnI4cdidyp8Q90HDB/lNYlsHheNnzM=
X-Google-Smtp-Source: ABdhPJxNZ/TFxDKRnW9VbHXebDh2ZEsRrPe+ICrLHAMxjLv+e5504Mo7cub+qPqMRStrZi1Fn5uSLFVMTJDGzNJVzJY=
X-Received: by 2002:a05:6402:1244:: with SMTP id l4mr24868482edw.71.1593540883963;
 Tue, 30 Jun 2020 11:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <1591697830-16311-1-git-send-email-amittomer25@gmail.com>
 <1591697830-16311-3-git-send-email-amittomer25@gmail.com> <20200624061529.GF2324254@vkoul-mobl>
 <CABHD4K-Z7_MkG-j1uAt6XGnz4zWzNYeuEgq=BwE=NXPwY6gb6g@mail.gmail.com>
 <20200629095207.GG2599@vkoul-mobl> <CABHD4K9VOWpC7=o2VKrqoxEtMQ2gFv_Qs885dBKL1o+B_fe_3g@mail.gmail.com>
 <20200630142427.GP2599@vkoul-mobl>
In-Reply-To: <20200630142427.GP2599@vkoul-mobl>
From:   Amit Tomer <amittomer25@gmail.com>
Date:   Tue, 30 Jun 2020 23:44:06 +0530
Message-ID: <CABHD4K8y-3LTnp-UnFRvP4vocpJYpVZ8iH4r_+BmsQSVUDScyA@mail.gmail.com>
Subject: Re: [PATCH v4 02/10] dmaengine: Actions: Add support for S700 DMA engine
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        dan.j.williams@intel.com, cristian.ciocaltea@gmail.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-actions@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

On Tue, Jun 30, 2020 at 7:54 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 30-06-20, 15:17, Amit Tomer wrote:
> > Hi Vinod,
> >
> > On Mon, Jun 29, 2020 at 3:22 PM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > > If you use of_device_get_match_data() you will not fall into this :)
> >
> > But again, of_device_get_match_data() returns void *, and we need
> > "uintptr_t" in order to type cast it properly (at-least without
> > warning).
>
> Not really, you can cast from void * to you own structure.. btw why do
> you need uintptr_t?

uintptr_t allows us to cast to an integer type that matches with enum
in terms of size, and
clang is happy about it (no more such warnings).

> The problem is a pointer to enum conversion :) I think the right way
> would be to do would be below
>
>         soc_type =  (enum foo)of_device_get_match_data(dev);
>
> or
>         soc_type =  (unsigned long) of_device_get_match_data(dev);
>
> which I think should be fine in gcc, but possibly give you above warning

Yeah, GCC is always fine with it.

> in clang.. but i thought that was fixed in clang https://reviews.llvm.org/D75758

Thanks for pointing this out.

To be honest, I thought clang had brought something important which is
missed by GCC (via emitting this warning)
that needed to be fixed in Kernel code.

But looking at this commit[1], feeling that CLANG people just wanted
to be compatible with GCC, and
in that situation why should one believe the clang ?

[1]: https://github.com/ClangBuiltLinux/llvm-project/commit/4fd4438882cc7f78e56e147d52d9a1f63b58ba81

Thanks
-Amit
