Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAB425785A
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 13:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgHaL0l (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 07:26:41 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45808 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgHaLXi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 07:23:38 -0400
Received: by mail-lj1-f196.google.com with SMTP id c2so2106699ljj.12
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 04:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eI+uaGXrReW1wiSkkAGQZB5VQp63X8g09PEhEY0wCvY=;
        b=cpCoo48eFm0fIm5Dlz6r8ZYnqML5dDdGQrghZHtCHoTblMIn7xgsg/aKLuSJ5kZLpJ
         iJjw7zhBykUNgA/5aMQ4ZLnC9bLpEYxC7zPIdfs23Xe9tEnECfiOJsCGwe3YNnDlryIQ
         nktFyIwGoFXzUHNowVUJW++bYnOAzFqYbsR4guUiQzpmJ2KlLmFC+h2dilt9nKPg6LTm
         5tBob8rEIyF5pijgJfEIZ917HUd5KIVBbw0wFcS+WtsuSpxAGqqJQJyYitL4yLdLk+Qq
         h6fq8hh7LDWCOTYWEoKKUcxIgJclxMs8g4ClSFaIOOGUxCB/wsRwIKmDn6fw23E1KLtx
         vjQA==
X-Gm-Message-State: AOAM532sSHamJmoU0TQwZsOfc3qoozBErnyLXOVIF1HPux2kJOWDafDg
        l2m6jaB5dKitYFUnZ0lzKwyQnZBV0vXagQ==
X-Google-Smtp-Source: ABdhPJyXO3qBjLzZor/iyRlA+6R+vjJwFW8Oi8fRUATvWF8QV+/ttulG/6n7J/ar19qq9XA8EFgYwQ==
X-Received: by 2002:a2e:91c7:: with SMTP id u7mr414915ljg.413.1598873016512;
        Mon, 31 Aug 2020 04:23:36 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id g1sm1496176ljj.56.2020.08.31.04.23.36
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 04:23:36 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id d2so3287648lfj.1
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 04:23:36 -0700 (PDT)
X-Received: by 2002:a05:6512:10ce:: with SMTP id k14mr483446lfg.7.1598873015958;
 Mon, 31 Aug 2020 04:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200831103542.305571-1-allen.lkml@gmail.com> <20200831103542.305571-27-allen.lkml@gmail.com>
In-Reply-To: <20200831103542.305571-27-allen.lkml@gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 31 Aug 2020 19:23:24 +0800
X-Gmail-Original-Message-ID: <CAGb2v66vw4BwZfFBgBo-CqzrC6h3Z-O9Kqye6frfvb28n+YwZQ@mail.gmail.com>
Message-ID: <CAGb2v66vw4BwZfFBgBo-CqzrC6h3Z-O9Kqye6frfvb28n+YwZQ@mail.gmail.com>
Subject: Re: [PATCH v3 26/35] dmaengine: sun6i: convert tasklets to use new
 tasklet_setup() API
To:     Allen Pais <allen.lkml@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, leoyang.li@nxp.com,
        zw@zh-kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>, logang@deltatee.com,
        Andy Gross <agross@kernel.org>, jorn.andersson@linaro.org,
        green.wan@sifive.com, Barry Song <baohua@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        Romain Perier <romain.perier@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Aug 31, 2020 at 6:38 PM Allen Pais <allen.lkml@gmail.com> wrote:
>
> In preparation for unconditionally passing the
> struct tasklet_struct pointer to all tasklet
> callbacks, switch to using the new tasklet_setup()
> and from_tasklet() to pass the tasklet pointer explicitly.
>
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
