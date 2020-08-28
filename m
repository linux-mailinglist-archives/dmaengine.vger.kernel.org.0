Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342F4255769
	for <lists+dmaengine@lfdr.de>; Fri, 28 Aug 2020 11:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgH1JSM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Aug 2020 05:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgH1JSJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Aug 2020 05:18:09 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8462C061264
        for <dmaengine@vger.kernel.org>; Fri, 28 Aug 2020 02:18:08 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t6so504044ljk.9
        for <dmaengine@vger.kernel.org>; Fri, 28 Aug 2020 02:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ng+zCbzwfJ99Zi5YpVRlQp3k3cpjfXZ+POmPrePE0RU=;
        b=KEAkDHlRUnW3W9yDLAnCQRnhwWX8omBTM5vKubwi60uQytYGZ9hoYSnvbQ44Um4+Ox
         WjyhUSqTUWAS9+Dyow0lGaPweYIPREi+76YsIN6PQgWUeRbqGI94TI+daqMtBgy4n9O8
         ASMpC3Gx4mAjhEGFrMAqRdLrOCODtqoULu1ye2cuENsU0f7KDAlzYkUaGTWjIP7/ycaT
         iueLbFjW3AoUA6o61hJkWkds4lM/al9CKnvnrUrYM6gOIWakSTt4QtEIPtqrqxQkAtN+
         jUK2wTZpFhxQpRAirYTgWqeYhNKFikf3j6199UZPK/GXwkzciMIqKCIGYpZEoOVf5Q3k
         141g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ng+zCbzwfJ99Zi5YpVRlQp3k3cpjfXZ+POmPrePE0RU=;
        b=Pmyb2HNAfKg2UVs79L76rHw+ULm/ktYgSAoa0Cyj0wXLLWJ+uTIVwHFisHbw12tjPr
         YIk2djACrW6cC3liulznlimmeNWGZQO5TfrcAplV7kFy2pS1JuOR4fmFMnxWeXCad9H9
         IE52AS84n4/wKkPd9NoACFNO59wqZMar/ox0Sg032Ezif+Sw+RtJjaf09c4VwBFF4xYC
         JBCoJt8/o03uK7rBqNEXP8q7lwv7XohaWUdvrvmhc1iOltV6pr3R7SaLhbigXZ8eZvyL
         j8AwtAZdxZEyVXwKkM99Ew/ThXVKUZgrnULGN87XHGWId7WZFfJIkwZwgsHA6IIQ3o3z
         WCPg==
X-Gm-Message-State: AOAM532UWCaduFhyWxUS4eyf/2/3OWBd5XeeYBIJsaNRr8L5ICsL7F+G
        DL/tfPaR4eqfetOT1Y78YqnsL2A97/rc2ibKzX2+Mw==
X-Google-Smtp-Source: ABdhPJxlVxDc4hE7VLarR2Wagnz5G/n+w7UrHgzDIOZD2zhORW3JV51IzmopPxvJKjbz4+x2tYeQKLEevol5bYpfJHQ=
X-Received: by 2002:a2e:8144:: with SMTP id t4mr499148ljg.100.1598606287121;
 Fri, 28 Aug 2020 02:18:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200818090638.26362-1-allen.lkml@gmail.com> <20200818090638.26362-26-allen.lkml@gmail.com>
In-Reply-To: <20200818090638.26362-26-allen.lkml@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Aug 2020 11:17:56 +0200
Message-ID: <CACRpkdbRuAdF-Q1K4wd4OXCpL4VKfqLYOZi+Gvh==Pgo7dG03g@mail.gmail.com>
Subject: Re: [PATCH 25/35] dma: ste_dma40: convert tasklets to use new
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

On Tue, Aug 18, 2020 at 11:08 AM Allen Pais <allen.lkml@gmail.com> wrote:

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
