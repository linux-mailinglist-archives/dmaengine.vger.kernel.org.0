Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E641140E44
	for <lists+dmaengine@lfdr.de>; Fri, 17 Jan 2020 16:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgAQPti (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Jan 2020 10:49:38 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:35431 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbgAQPti (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Jan 2020 10:49:38 -0500
Received: from mail-qt1-f169.google.com ([209.85.160.169]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MvJjz-1jinLd3mL3-00rEnx; Fri, 17 Jan 2020 16:49:37 +0100
Received: by mail-qt1-f169.google.com with SMTP id e25so10753924qtr.13;
        Fri, 17 Jan 2020 07:49:36 -0800 (PST)
X-Gm-Message-State: APjAAAXDjGVlH6AF6r4fS4/Db/I8MvPHpug0fcsRLRfkVLJXnMDg0ShG
        P8mEhdIldoRT92MPkI67il6348Mleylv22nkpt8=
X-Google-Smtp-Source: APXvYqztD+1sjrj8dopDcYp2VjNvyMd85uBQWSwxVcXENdTkLqC0YwLWTNTWjgtCs7i1WELihm2qeNB6W4rJuwnzTkY=
X-Received: by 2002:ac8:47d3:: with SMTP id d19mr7972128qtr.142.1579276175723;
 Fri, 17 Jan 2020 07:49:35 -0800 (PST)
MIME-Version: 1.0
References: <20200117152933.31175-1-geert+renesas@glider.be>
In-Reply-To: <20200117152933.31175-1-geert+renesas@glider.be>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Jan 2020 16:49:19 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2a243LkRu5Np-AmUoyWkSLTuDb9vA8oGwWOsjdHXsffQ@mail.gmail.com>
Message-ID: <CAK8P3a2a243LkRu5Np-AmUoyWkSLTuDb9vA8oGwWOsjdHXsffQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] dmaengine: Miscellaneous cleanups
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matt Porter <mporter@konsulko.com>, dmaengine@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:5bQm1FZoanPkTY63bYHQrI4BPXQt/WpPAXIPxlmiiH5ExvzQhPs
 vfv29XBkmluopPWoXiC4fua0WWyvj2PM+/dgZpTSUQGrkK+e7vqZ4eYP1amQLbzeGR5yS1V
 tGmqh9ED+zyXFdsdK/L02ieFTsc0TUgwgt36fxjYhX6m5l/oBrN3J8PsMo8stZxBKhWeiA3
 if1+2Cys+nDlBLO1mO56A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zjYbMpEZPZA=:jwO7+7FR3Ho5FlgowVQVMy
 Vrwf3hKlGsr0oK0NawfMhRdGP2xSo3Fd3qJp3d9l+CsIQfhUEEwe3PweHfFQop3yKS1e6BHBQ
 myLGo1MoLwp4vBrychHzCAHX3Ggm6Hfv86mnxKNRsWV23r36Q7BUlXhSUkm44MGDUUsktnJjC
 b9RrlrzHJtr9FYXPP/mk32dpRgM7DLPPL1W7dUtFrZ4WqdOcvssBunqbDxgO3lWsYVpKChKCG
 1c+UeyUXG2rAVo5xkwiGGvqa+RqVCcVBKswfQgQNunGRxi8e3sySPet6hd79jRKvDDqjbGUQY
 948Mi42KFWb7MeGWwa1hQPCrP9CJXLbWF5EKpL76QN8llsmHbPl536ePL+JyEmfMwPZpWk/+J
 R6Co8xcMQXGxwv0WCc3jycw2doPd6FoBDo1Tq7D7tqNMwijEdAQdn+SPJ1SnnBlqEJ+7RYDB1
 TA/2pl9XqVc1EqvC6KDdqy4Rb+96Tx8M7btkF8O8eJt28swZeggEJT+dIx9g5AAEdGCMur6+h
 q1XaqRZo0LTjKlj93a0Ckc6YLK4IV2YTM3mvJfgKTKA6+Db8WGV6BKeZa3pHZ+ZGRgCRvTy9R
 0q1yyqgpZ9Woz/NaFg49x28wGLR6k/rmRbIt5B2raZ2Hkyixq/bhCApNXF69cjmg5zdoIPI9s
 415AN5oqsxWej1bosfkpiqK57/Xi/WHgeE/YriBuy5NFx/4+B7pw5+pwDRlvI9TUYYDv1fRrU
 ueY3KhxOfKUAfBptZU+Lv6avuiKAyYN2FFxj85yrk2VFODaAPQE+W4LaogW0JCWHtMaOExl4W
 mLA/XbLGxArMKPKOe01qTFqSPc/6yI3CpUsyVEenkag/ZV3KeDyfEtV7APWW8ry8KbdP8IRpM
 2VqRbvRn/hDdU0GQDJEA==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jan 17, 2020 at 4:29 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
>         Hi all,
>
> This patch series contains a few miscellaneous cleanups for the DMA
> engine code and API.
>
> Thanks for your comments!
>
> Geert Uytterhoeven (3):
>   dmaengine: Remove dma_device_satisfies_mask() wrapper
>   dmaengine: Remove dma_request_slave_channel_compat() wrapper
>   dmaengine: Move dma_get_{,any_}slave_channel() to private dmaengine.h

These all look good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>
