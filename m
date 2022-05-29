Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BAA53723D
	for <lists+dmaengine@lfdr.de>; Sun, 29 May 2022 20:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbiE2Ste (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 29 May 2022 14:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiE2Stb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 29 May 2022 14:49:31 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088B428E0B
        for <dmaengine@vger.kernel.org>; Sun, 29 May 2022 11:49:29 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id v19so3703822edd.4
        for <dmaengine@vger.kernel.org>; Sun, 29 May 2022 11:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R7uJutVFI9zbN32EkS//6xvmPFfWw/D4Up53DrHq1CM=;
        b=CuUNmJmeEcc7EUv/S/oXFJLA5BF7DKv5c6FRlFokkO7Y4XA1peTaUnp4Mu/xyX00Ty
         /jil6AFEDcU6L5vUu9ZQQ99gG0SdcA0wl6aPrT86gJt8GiVF6RGhbPxHuQbRkDaD+Iw7
         Qf1WkP3H65VB31BI51A/konuu0cDCJ2twJKK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R7uJutVFI9zbN32EkS//6xvmPFfWw/D4Up53DrHq1CM=;
        b=hIfmRRIo3Ob059nQK4YLuSB5UzIpe9DODfxZKczpXrCCBpRomMtMfQdQALdpfDJhrW
         5OtKOBgPaUkLk7dEbijCI55O16scR2Z6teYWpUsXQoBXWa6VdkOBXtwO8tftTnhkcTdU
         /Czh7cfIjLrMvJH0fkn9oXqdzPjvH7Oa8/dnAiZ+rho9rguU9h3Kd+DDBR7/gaIfIkXs
         eY7AT20AfobEhzRif+usVoT2TJFStwPPqcYP6tSIfss2kCCqmRV9q4QUuxtahXVDTKEQ
         xRaIcdOruNg1c6UtG59nG4U5b10oSbDR2pGUkeFPZX8lIT4zvyXFqw26negwEj52ezPT
         r8WQ==
X-Gm-Message-State: AOAM530T6iaDC1tEiOIxRHfYGIno2Ta1vwP7TFgeeOoKeBqRc7Pq+H+y
        YSC/l+Pmwv2mW9YMV3kMqCO+gU6IKoUJF5yHJPc=
X-Google-Smtp-Source: ABdhPJzqCiDrC+hpy9VfOlQ0WRLknRjon68gEfLF2gN2x00OHNDQ5DfHfDYUlyBfaEE8zIVj4Tu6Kg==
X-Received: by 2002:a05:6402:e9f:b0:41c:df21:b113 with SMTP id h31-20020a0564020e9f00b0041cdf21b113mr54887327eda.217.1653850167370;
        Sun, 29 May 2022 11:49:27 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id b3-20020a509f03000000b0042617ba63a8sm5308996edf.50.2022.05.29.11.49.26
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 May 2022 11:49:26 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id f23-20020a7bcc17000000b003972dda143eso7293720wmh.3
        for <dmaengine@vger.kernel.org>; Sun, 29 May 2022 11:49:26 -0700 (PDT)
X-Received: by 2002:a05:600c:4f0e:b0:397:6b94:7469 with SMTP id
 l14-20020a05600c4f0e00b003976b947469mr15983870wmq.145.1653850165767; Sun, 29
 May 2022 11:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <YpOyb40/g5gIYigF@matsya>
In-Reply-To: <YpOyb40/g5gIYigF@matsya>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 29 May 2022 11:49:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgZtj6A7ggq7Ak5ZFwnLriGwU52NzC_3db5u+yLGJDJfA@mail.gmail.com>
Message-ID: <CAHk-=wgZtj6A7ggq7Ak5ZFwnLriGwU52NzC_3db5u+yLGJDJfA@mail.gmail.com>
Subject: Re: [GIT PULL]: dmaengine updates for v5.19-rc1
To:     Vinod Koul <vkoul@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, May 29, 2022 at 10:50 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> Please pull to receive the dmaengine updates for this cycle. Nothing
> special, this includes a couple of new device support and new driver
> support and bunch of driver updates.

Vinod, _please_ report it when it turns out that there are semantic
merge issues in linux-next.

The whole point of linux-next is to report and find problems, but that
also means that if the issues found in linux-next are then completely
ignored, the _point_ of being in linux-next goes away.

In particular, there was a semantic drivers/dma/idxd/device.c that git
was perfectly happy to merge one way, but that needed manual
intervention to get the locking right. See

   https://lore.kernel.org/all/a6df0b8a-dc42-51e4-4b7b-62d1d11c7800@intel.com/

and this is exactly the kind of thing that should be mentioned in the
pull request, because no, I do not track every single merge issue in
linux-next.

I only catch them when something makes me go "Hmm", and in this case
it was a different conflict near-by that just happened to make me look
closer (the same one that Stephen had noted).

Stephen makes this clear in his notifications:

 "This is now fixed as far as linux-next is concerned, but any non
  trivial conflicts should be mentioned to your upstream maintainer when
  your tree is submitted for merging"

and yes, the original merge was indeed trivial and wouldn't have
needed any further mention had it _stayed_ that way.

But it didn't actually stay that way, as pointed out by Dave Jiang in
that thread.

The fact that I caught it this time doesn't mean that I will catch
things like this in general. I'm pretty good at merging, but there
really is a reason linux-next exists.

                      Linus
