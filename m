Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D0C255753
	for <lists+dmaengine@lfdr.de>; Fri, 28 Aug 2020 11:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgH1JQa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Aug 2020 05:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbgH1JQ3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Aug 2020 05:16:29 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C37C061264
        for <dmaengine@vger.kernel.org>; Fri, 28 Aug 2020 02:16:28 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id m22so517839ljj.5
        for <dmaengine@vger.kernel.org>; Fri, 28 Aug 2020 02:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pKFJMoSxuyl3FtpyG3za89A+6HJOtqb0zpDXKQ3YceE=;
        b=oSuh+KVA1QqyDt+NYhMBQwSr5/J5KGR0j1ucQow6astjiAhAAO+ObvKja/88I65hY6
         DmsS5DiMPFh/PEcB0Eljlo98tiSkkSPHnqdqzGcohc74gNtnzvQjCBZtL3rcf+/maAxJ
         wBkjb6x95FnkCej9BuTPDYEKi7oUi6D8vgeB41VyOL5cZPczjIo2RYcWi+Zp9QIfX9gu
         4Ubj/sAtZLXdfBGY+UrETAg/vhXiYjXb1rF0kI0BOB5Jj9/bKOqQi9+nTBKfoRXbYwd9
         Aa0lk3Lho0JoHXuy4K2k2QXQP7woxvaEhEg2bMgy/2XJbodumpjEjtqm1lym07FGimvV
         HeHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pKFJMoSxuyl3FtpyG3za89A+6HJOtqb0zpDXKQ3YceE=;
        b=CbGGp1C7f4zFXElevivUEUSUOGK4VYIk9BouuNHdRgsbprGn5kyb8mB7zYIovpI91T
         xqAsdd4OJBEeezmCvKBkw8mhq0ahEP8xB5e5vglevqvoqsUKle1hS/OYn07xkqJ80nLP
         IJlXnk1i7IPMQFCkQx5b0qvbiMBXO77Z6ugXTOaLdlmISs8gMPgarsZ4fGAGocW/O9cN
         TUVsTQSd2Sm4h1YrH691vhlfZK45S6Ous0m7RaWgbDQ0k+ydltzGZp97aVB2N4/PiPp7
         w/94owKBr2xPJPPjmOjJzPX8yLBbGjoNAhZcMLbDDSanhcO3s3vkOiWWP+pb9HoB+MZ4
         69QQ==
X-Gm-Message-State: AOAM533KvxvHVel2wvOm7gQDKAQITNz4wdjiwDiFipwHMPUyplqC/K6i
        doXhsR/PPs8a0+Taa0hfMphmVE/a51Rot/saZcBZbQ==
X-Google-Smtp-Source: ABdhPJy04VyxZx3txP7+IeTirbRIphU4vSee7yqZ8kOAK3kqG8P/99IeJzff4HHj24Ix/kSIjEwFohUj4vrKS8tRZeU=
X-Received: by 2002:a2e:b80b:: with SMTP id u11mr472055ljo.286.1598606187298;
 Fri, 28 Aug 2020 02:16:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200818090638.26362-1-allen.lkml@gmail.com> <20200818090638.26362-5-allen.lkml@gmail.com>
In-Reply-To: <20200818090638.26362-5-allen.lkml@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Aug 2020 11:16:15 +0200
Message-ID: <CACRpkda6BdFrpzHefCfM_hfEho9tCOVextXSMwMvavTtPHP8vg@mail.gmail.com>
Subject: Re: [PATCH 04/35] dma: coh901318: convert tasklets to use new
 tasklet_setup() API
To:     Allen Pais <allen.lkml@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Leo Li <leoyang.li@nxp.com>, Zhang Wei <zw@zh-kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Barry Song <baohua@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Romain Perier <romain.perier@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Aug 18, 2020 at 11:07 AM Allen Pais <allen.lkml@gmail.com> wrote:

> In preparation for unconditionally passing the
> struct tasklet_struct pointer to all tasklet
> callbacks, switch to using the new tasklet_setup()
> and from_tasklet() to pass the tasklet pointer explicitly.
>
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
