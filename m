Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942C3405CAD
	for <lists+dmaengine@lfdr.de>; Thu,  9 Sep 2021 20:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242975AbhIISMd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Sep 2021 14:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237354AbhIISMb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Sep 2021 14:12:31 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C21C061574
        for <dmaengine@vger.kernel.org>; Thu,  9 Sep 2021 11:11:21 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id j12so4333457ljg.10
        for <dmaengine@vger.kernel.org>; Thu, 09 Sep 2021 11:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3w4XX6yR0QzRiZJpSGde7fWq2eAjHlmLHnFHbdMV8Zw=;
        b=f8cWzc+qPXq7JuEevYzkWEktyjooBtzN5s+4yG2cN4TTsZYh2v6gDrh7DzBnD/HsUt
         7dG5gNYf+VAJHqprxMeXXmPbMSUowyhN0J0ScQ9rgrLGtjM7perzG3nqOrVNByGfv7m3
         a2Oap21jix6+PYdZXqkBY6EVh1jxBOES7Uwbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3w4XX6yR0QzRiZJpSGde7fWq2eAjHlmLHnFHbdMV8Zw=;
        b=XmTD/TCt/9CDhfGmCtOqmifaJFay1Wr8hPQMePzA31jv799ns/QshF3sYMJJKL/KHK
         YTe/yy2d7FSvyPHRykTC8Sg84DTrU7tFz7kv6HIfapqnQku7soUU7Azhfdc+S00ACTLM
         57EH4TAFHv3QvOUNBCJGw2jliGr4MiHC/XAlcP2sHzAb6ITwDX+LIGljCt0aa7tnFAYD
         2taSbvhFt3quyvPQbP52qOpRaT4ozthvWQ98KRWy5b7l2Cgr6aOcoYqSS3Xef/SHOUQJ
         F39DCV1L0NbVQFTy18fyHz8xlM4AmfGz2H36Bk/Wii/xrMLnyYkTh2K2DINBgh4jyY53
         pa3w==
X-Gm-Message-State: AOAM531+ihJkW6iHfV27HkSA8U5Kzqf3LPRFBi7Z/WMeenOQ3+rDPHd2
        7UGsmHASrJKl18AcaRCqS84VM8kSleWDnDq7nXo=
X-Google-Smtp-Source: ABdhPJzXKaJTkBOF8xj+U1sj25FyPXqpDYs99ZI92flI0jbDFhkP++54xFlWxhQluqVjGGW8mlJsBQ==
X-Received: by 2002:a2e:86d6:: with SMTP id n22mr1002343ljj.416.1631211079732;
        Thu, 09 Sep 2021 11:11:19 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id q18sm279978ljm.50.2021.09.09.11.11.18
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 11:11:19 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id g14so4364704ljk.5
        for <dmaengine@vger.kernel.org>; Thu, 09 Sep 2021 11:11:18 -0700 (PDT)
X-Received: by 2002:a2e:8185:: with SMTP id e5mr899668ljg.31.1631211078697;
 Thu, 09 Sep 2021 11:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <YTg+csY9wy4mk035@matsya>
In-Reply-To: <YTg+csY9wy4mk035@matsya>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Sep 2021 11:11:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVLppF6shSBiKK7-B7FRZ3UP_sMVKcLvtRs8AQM+k2vg@mail.gmail.com>
Message-ID: <CAHk-=wiVLppF6shSBiKK7-B7FRZ3UP_sMVKcLvtRs8AQM+k2vg@mail.gmail.com>
Subject: Re: [GIT PULL]: dmaengine updates for v5.15-rc1
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Sep 7, 2021 at 9:39 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> Also contains, bus_remove_return_void-5.15 to resolve dependencies

That one actually has a commit message with explanations about that
branch from Greg.

There are other merges that _don't_ have any reason for them. Like
randomly merging 5.14-rc5 with no explanation.

Or the three random "merge fixes".

Please people. For the Nth time. Merges need commit messages that tell
people _why_ you merge, and what the code is that you merge. Not just
"merge tree X"

             Linus
