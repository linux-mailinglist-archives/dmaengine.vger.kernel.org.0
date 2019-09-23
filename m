Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9654DBB742
	for <lists+dmaengine@lfdr.de>; Mon, 23 Sep 2019 16:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731142AbfIWOz6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 Sep 2019 10:55:58 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35077 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731128AbfIWOz6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 23 Sep 2019 10:55:58 -0400
Received: by mail-io1-f68.google.com with SMTP id q10so34224383iop.2;
        Mon, 23 Sep 2019 07:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aJSkN3O3R055m+qpJx/Tm2HyfkEZX9CoGjygiAHKo+g=;
        b=gysmm9SedIHwKk43YK3DQp+CGCZC3a0JoqbVuZXFDfM7s7tI05+eBgvd9zlJT0ufYF
         LNSj++cFYfxLREA8TSOtM6d7szFNRwrQfRYyHBxbb7EzfUL86rthVAOWZeCOfNTmU+gk
         lwt8SF1824iQXKk3ma3/8RrREG4xDzdnjOsv2h5Bj0SBCRrrvscqW4MBz959+gL0hBMh
         M5vjZz+QeRZX3QTSVjt/05/sWJf7zcoY8h8en678AqXCzGJU3hfndwTJuA5nYAAS8asV
         +QlrgBF0YTWeDwT0J+zXbwuAfLgJWtBap6FVa5NEJ3/xyP+J2QIrazfvRecu5Voax5dC
         4L9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aJSkN3O3R055m+qpJx/Tm2HyfkEZX9CoGjygiAHKo+g=;
        b=XaN8/fo9c+Ww6oVGzGEuQRG5OQ7BElt2aDeSc0/uRJLBrl11Uj8xZ1UT8nPUDwBTDY
         3+Ihu4ZsjlTb5wPwxEe53wVCyt/HaU0aAfhIHCM/zwHIS6Lv2/NLrZl6S6E57Bd3qi50
         YP6HyLBgREASmTuvBXf9Qzy1xJUVOqS1R9/pknlLxz0wGUSx5oBBLz9k0t/zBy3j2DFS
         afFv7/J+8OOvVGvaTPTE1HFxNGQmAyFTRZr/t1+Y5o03qfprStjvRxxJQBpnEjJR5+zu
         I8+3r0A7WsKOEw7jm7YjaEEVALCAbVXMGRz6NKGpDSFnZLrUjpvuY78PZFNs78+xnXyo
         zt0Q==
X-Gm-Message-State: APjAAAUI9H2yFmewHG1Q/cit3mWJheTu7wBtosLBUCnuF8flfI2ei5L+
        rNRwkCxJiIExWM1OmXbG7D9BzooCIVopUFNhcpg=
X-Google-Smtp-Source: APXvYqz3umQLZs1WqpUvvzKbf1OvBAzKpjy4hK6udNDouR2tEvv08QtBYHQKN8m3xT72wndDH8FytOxzmRkmAiayeiE=
X-Received: by 2002:a5d:9c4c:: with SMTP id 12mr672385iof.276.1569250557575;
 Mon, 23 Sep 2019 07:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190923135808.815-1-philipp.puschmann@emlix.com>
In-Reply-To: <20190923135808.815-1-philipp.puschmann@emlix.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 23 Sep 2019 09:55:46 -0500
Message-ID: <CAHCN7xJL_x1ryOoNW+R2hOZ9dMFem9wni8Uo8QOA3wxpzKLbqQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Fix UART DMA freezes for i.MX SOCs
To:     Philipp Puschmann <philipp.puschmann@emlix.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        fugang.duan@nxp.com, jlu@pengutronix.de,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>, vkoul@kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        dmaengine@vger.kernel.org, dan.j.williams@intel.com,
        Robin Gong <yibin.gong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Sep 23, 2019 at 8:58 AM Philipp Puschmann
<philipp.puschmann@emlix.com> wrote:
>
> For some years and since many kernel versions there are reports that
> RX UART DMA channel stops working at one point. So far the usual
> workaround was to disable RX DMA. This patches fix the underlying
> problem.
>
> When a running sdma script does not find any usable destination buffer
> to put its data into it just leads to stopping the channel being
> scheduled again. As solution we manually retrigger the sdma script for
> this channel and by this dissolve the freeze.
>
> While this seems to work fine so far, it may come to buffer overruns
> when the channel - even temporary - is stopped. This case has to be
> addressed by device drivers by increasing the number of DMA periods.
>
> This patch series was tested with the current kernel and backported to
> kernel 4.15 with a special use case using a WL1837MOD via UART and
> provoking the hanging of UART RX DMA within seconds after starting a
> test application. It resulted in well known
>   "Bluetooth: hci0: command 0x0408 tx timeout"
> errors and complete stop of UART data reception. Our Bluetooth traffic
> consists of many independent small packets, mostly only a few bytes,
> causing high usage of periods.
>

Using the 4.19.y branch, this seems to working just fine for me with an i.MX6Q
with WL1837MOD Bluetooth connected to UART2.  I am still seeing some
timeouts with 5.3, but I'm going to continue to run some tests.

Tested-by: Adam Ford <aford173@gmail.com> #imx6q w/ 4.19 Kernel

> Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>
> Reviewed-by: Fugang Duan <fugang.duan@nxp.com>
>
> ---
>
> Changelog v5:
>  - join with patch version from Jan Luebbe
>  - adapt comments and patch descriptions
>  - add Reviewed-by
>
> Changelog v4:
>  - fixed the fixes tags
>
> Changelog v3:
>  - fixes typo in dma_wmb
>  - add fixes tags
>
> Changelog v2:
>  - adapt title (this patches are not only for i.MX6)
>  - improve some comments and patch descriptions
>  - add a dma_wb() around BD_DONE flag
>  - add Reviewed-by tags
>  - split off  "serial: imx: adapt rx buffer and dma periods"
>
> Philipp Puschmann (3):
>   dmaengine: imx-sdma: fix buffer ownership
>   dmaengine: imx-sdma: fix dma freezes
>   dmaengine: imx-sdma: drop redundant variable
>
>  drivers/dma/imx-sdma.c | 37 +++++++++++++++++++++++++++----------
>  1 file changed, 27 insertions(+), 10 deletions(-)
>
> --
> 2.23.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
