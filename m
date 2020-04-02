Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADB0219CD78
	for <lists+dmaengine@lfdr.de>; Fri,  3 Apr 2020 01:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390174AbgDBX20 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Apr 2020 19:28:26 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41038 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387919AbgDBX20 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Apr 2020 19:28:26 -0400
Received: by mail-lj1-f194.google.com with SMTP id n17so5102241lji.8
        for <dmaengine@vger.kernel.org>; Thu, 02 Apr 2020 16:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=27Eq33tzm0rwxrqYtQSqbizdJYHHnYSaU0MAG8gpLzU=;
        b=CfTBY7xc1tiuPYtHEJoigkNy6ECHxmqNNJtfajsajw5CbJZRZPLrGU/rk4vJo9ix26
         abrgDQ+uFBTyTnl4yYkkq16ZlRI/cZ1V7eMVlzB1WFePzfq2eXWPusgbU45dPLtmBD35
         BdRd7O/NjpQ1pgDxt+SYe8xxgLc6alEqsqeOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=27Eq33tzm0rwxrqYtQSqbizdJYHHnYSaU0MAG8gpLzU=;
        b=a+OYTUM2sv714txga2nsPRP3/XRqC2DmUKxroWcp3veaslSctsNVMEJVZLLIZCNtn2
         0yIhu92sSvPQfvJUsSjzd0pn8Tvx0E2jAG0mqVVA/ScJzurZA6Jm+1VXm5RLhiIvnzeO
         13S4kLVnk4bKNiFXGe6Lyhv1aufiE+zrxx+8oJNDivmPXaRo5y1WJrVNa7a51sHksR+u
         FeXR2jALTnsaVQMYuPD7XSQl+eAGHo4FZHpah8nEjEB7x7it27rgGkv6PUQLvnFT8xJA
         FDLDzvCbabK3Llxk8v+gUmtJkKmdhiXCmce/xcjPRio8CwzrPY3cGoaSRBBrREEehZt4
         fgnw==
X-Gm-Message-State: AGi0PuZn4zm68pGJV/nb+U3SeiQ+9qUB6IC/SWj7UOZ/Ea1bC6ZlHriR
        ghsNCMFSBkATzfNJqX9HfdpD9z6f6Dk=
X-Google-Smtp-Source: APiQypJO93xTvanTlUqGd12SN/dZqCd6d3v6erMZxdQ3vYCsmye6Z1xmKbroagEF5aBHP3+XTRmftg==
X-Received: by 2002:a2e:5844:: with SMTP id x4mr3274885ljd.40.1585870100696;
        Thu, 02 Apr 2020 16:28:20 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id e4sm4812634lfn.80.2020.04.02.16.28.19
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 16:28:19 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id r7so5050865ljg.13
        for <dmaengine@vger.kernel.org>; Thu, 02 Apr 2020 16:28:19 -0700 (PDT)
X-Received: by 2002:a2e:b4cb:: with SMTP id r11mr3432765ljm.201.1585870099332;
 Thu, 02 Apr 2020 16:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200402112500.GJ72691@vkoul-mobl>
In-Reply-To: <20200402112500.GJ72691@vkoul-mobl>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Apr 2020 16:28:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi81+9roQMgf7n0YRxJ0rqK3W0ghB3tS3kngSikC7cOig@mail.gmail.com>
Message-ID: <CAHk-=wi81+9roQMgf7n0YRxJ0rqK3W0ghB3tS3kngSikC7cOig@mail.gmail.com>
Subject: Re: [GIT PULL]: dmaengine updates for v5.7-rc1
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Apr 2, 2020 at 4:25 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> Here are the changes for this cycle. SFR has told me that you might see
> a merge conflict, but I am sure you would be okay with it :)

It looked trivial enough. That said, it's in the TI_K3_UDMA driver,
which I can't build. The driver is marked as COMPILE_TEST, but it also
has

        depends on TI_SCI_PROTOCOL
        depends on TI_SCI_INTA_IRQCHIP

which means that it depends on TI_MESSAGE_MANAGER, which in turn has a

        depends on ARCH_KEYSTONE || ARCH_K3

so it may be *marked* for build testing, but it doesn't actually get
any outside of those builds.

So I did the resolution that looked trivial, but mistakes happen, and
I can't even build-test that driver..

Just a heads-up. It does look like it was _meant_ to be build-tested,
but that intent didn't work out.

Adding a COMPILE_TEST option to TI_MESSAGE_MANAGER gets things a bit
further, but even then it doesn't actually build that driver because
that TI_SCI_INTA_IRQCHIP dependency needs to be enabled too.

And that one doesn't even have a question, it's just a plain bool, and
expects to be selected. Which the arm64 platform does.

Anyway, to make a long story short: "the COMPILE_TEST marker is a lie".

So somebody should actually test my merge.

                  Linus
