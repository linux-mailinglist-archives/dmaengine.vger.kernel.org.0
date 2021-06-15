Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931AD3A7439
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jun 2021 04:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhFOCpZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Jun 2021 22:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbhFOCpX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 14 Jun 2021 22:45:23 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D78C061574;
        Mon, 14 Jun 2021 19:43:18 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id x24so18761569lfr.10;
        Mon, 14 Jun 2021 19:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7xvsLbXf65mdyb3qLUmqZwn3t2ST568AmCGF279evdw=;
        b=mPte5ivMY13f4aHDh4e9CUXMO6E4zLQKcMuVaSfSD8gJ1LV2QGHNXsgvlYt6x4zJe9
         ZbdVWvL71MVSwlEqrAczZWJ8UIbLR8s3G4Pk6JEKyOQLgW3iLhmzCkfhlYNfT8fh+M4c
         tgsuT3GzuUwaVlVM05zw6KYVUYN7g8B+ga7LaWV+fjMPky8fgPtRyjd0Vx52mzwcHUfN
         i0p0uP29sNA0EjVQ49ZYemjN0D9TKrbKVI9FfTOlyhvo1tGh7EBuv0YIJlikw3IX6F6X
         CYKritPkVEMP8OaanyeoaNFMli9ICXEM4TnXRvth/mIlIjXbYtJfwt96ca32cbBAdrF8
         TuOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7xvsLbXf65mdyb3qLUmqZwn3t2ST568AmCGF279evdw=;
        b=En3Mh6IAbzcDfwKNAB1jiGL3gA4h9Spdszi3WNwfkoWN/EwAYxnbBqzRzmIYnFR+vQ
         /s7bWl8qayG8rEwDWid9cZh63PEP7wLcP7AxTa1VYo31TIXzvrhExtxkruDddVzs4i2p
         4Hymv6vd9AFajw9wWDn7CBFhbujk5l4Zjk97kZazZRpBL9l7FXpTZ7BFVNsePV+Yi1A0
         lAcQcpt9AOQdPW3Bxl81leWa5TapKlU6YsFeSgT2gs7cMLXm60zEjud0pqgsaAm7BreR
         zzjYVKiI9weHzhtcCWZuBOdoqZTagzLhJEn4drRMfa4mnvI+LKDwa36bq02v3EoUuwRy
         8Ltg==
X-Gm-Message-State: AOAM532i9YBC2v0svS3TXVYQJ2b7WyHnFkExqR9zWJr01V4kvs3oIKq6
        RF0A1zk2SzqqoueJ9o0LoxUnzHVmUUAs0md3h/EmoCV5GBaOSQ==
X-Google-Smtp-Source: ABdhPJxyKlOZpgSD8mTvCMHfxQgeU7FRe81qS8OkPHT5YyuLuoBqn1hSl1lR0cDDsmOfJI+GcTA0YKZ7+laCcXh5+Sk=
X-Received: by 2002:a2e:97d1:: with SMTP id m17mr11254855ljj.490.1623723167236;
 Mon, 14 Jun 2021 19:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <1617809456-17693-1-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1617809456-17693-1-git-send-email-yibin.gong@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 14 Jun 2021 23:12:36 -0300
Message-ID: <CAOMZO5CVyaOXNxwv9hKV3RB9Q4kzW4VchEeBj1=b9PvHkskcow@mail.gmail.com>
Subject: Re: [PATCH v14 00/12] add ecspi ERR009165 for i.mx6/7 soc family
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     Vinod <vkoul@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Martin Fuzzey <martin.fuzzey@flowbird.group>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Clark Wang <xiaoning.wang@nxp.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        dmaengine@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Robin,

On Wed, Apr 7, 2021 at 4:15 AM Robin Gong <yibin.gong@nxp.com> wrote:
>
> There is ecspi ERR009165 on i.mx6/7 soc family, which cause FIFO
> transfer to be send twice in DMA mode. Please get more information from:
> https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf. The workaround is adding
> new sdma ram script which works in XCH  mode as PIO inside sdma instead
> of SMC mode, meanwhile, 'TX_THRESHOLD' should be 0. The issue should be

Could you please confirm whether the sdma-imx7d.bin firmware available at
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/log/imx/sdma/sdma-imx7d.bin

contains the "new sdma ram script which works in XCH  mode as PIO
inside sdma instead
of SMC mode" fix?

Thanks,

Fabio Estevam
