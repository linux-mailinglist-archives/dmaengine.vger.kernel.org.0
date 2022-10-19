Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFF8604B4C
	for <lists+dmaengine@lfdr.de>; Wed, 19 Oct 2022 17:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbiJSP1X (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Oct 2022 11:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbiJSP1D (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Oct 2022 11:27:03 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C75A14C527;
        Wed, 19 Oct 2022 08:19:53 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id i65so14770074ioa.0;
        Wed, 19 Oct 2022 08:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KiAtnv3O8MX8nL+R91UDkC4RH0kfqHF5HE/wVPNVO9E=;
        b=j/plf1bJ20J4G8S6RNOuUW/ahXCuyTBOVehUugkYj9HW+bWZp3E288RhnrDTBBLtg5
         9XHeMaz5bL09MTVZ66Foxxkam2kIGyuF05IHkTbommDvOd2M/KS3nrfyZWnE9ynFfd9l
         ZDorP9vGnGy/hXRENdDoE27Wi4rpKfO7FnX3k3Ezx5FtwrN/MlaUUrA8jpkV5+kzfRbT
         nFsTfArSDT1wk8d1GqtiX1lVqrWg/uC0P5JaJ66VouWgEihLxjW5jUNdd/wc9uOaYByT
         sENKdwS5+l6L4gkskVqUlxLN4ZcQetjAGTlbgMYexcyKNLPPNSF2ZyFpf1DJpYWs5Z+D
         +WGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KiAtnv3O8MX8nL+R91UDkC4RH0kfqHF5HE/wVPNVO9E=;
        b=jbjZqL5FXDm/Q3q57sjj+mkK0QCEN7ACC9rmMt4k0v4mjIuhebRYvRLV4pTkBG/jMP
         1pUwGPMGvbj7O5yXofieqyu9t0tyNOcBwfH/8FSELRNe2kHdp8BZpezZEv+Ad9PGTtFG
         L0dsOpNCZDp5tPnrmKNdl85lnyOujZLQu7kyzuWsy+IDOvomj01Ly8TkA2+ZYtLMRwfB
         +vA+RYdnYUj9tsLkfZIBL7QSyFEsFOBNQF9Hg030iUOd9iTu2HW6InIix8lYznVJ74kA
         7gCxlhlhxv/jGtT4qsZ/fOCHOMEk0jB1dNSYbRilYg7eA8D2g4ecVlEtcyAnkMGVWys7
         sR/g==
X-Gm-Message-State: ACrzQf1QYd0C4uHAmM0ynySBTHgLJ7XBuxu/iKWkRIMskRoqhHY0nrCz
        eN+vEx3NtJ/WL4DGvQRm+Ez1AYwgtiGutolCLyU=
X-Google-Smtp-Source: AMsMyM5qPsQtuBvKyPQMnBZjaxeLYE52tYSFcHWWnB70BrncG/Hn51NZd/lN2AWIwQJCxd/unWoBGJKg26X7wKRspXA=
X-Received: by 2002:a05:6638:3452:b0:363:69f8:549f with SMTP id
 q18-20020a056638345200b0036369f8549fmr6938721jav.190.1666192765289; Wed, 19
 Oct 2022 08:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <20221009181338.2896660-8-lis8215@gmail.com> <202210100607.YdxoR0tD-lkp@intel.com>
 <CAKNVLfaFvge4A8-QUzeq-JManpuYMGvyHXCJi-ew==CWN8-M=A@mail.gmail.com>
 <bb9f79d4-82a9-4790-b849-d517333ea2d4@app.fastmail.com> <GSPOJR.M4XZ4D03G60F@crapouillou.net>
 <CAKNVLfZukazKx2yDBrLZc7J9=3cCvMgZbdghtt1YO7WivdPjvw@mail.gmail.com>
 <CAKNVLfbePJQN07GfhqAs-opm23poWsL0o-DkV=n-f9+H7Y7rpg@mail.gmail.com> <555WJR.ESJD0KDHOG3S@crapouillou.net>
In-Reply-To: <555WJR.ESJD0KDHOG3S@crapouillou.net>
From:   Siarhei Volkau <lis8215@gmail.com>
Date:   Wed, 19 Oct 2022 18:19:13 +0300
Message-ID: <CAKNVLfZ0ndwGUUq0VX3vdvxfDK6Shf61WS_dC5WocChKeYSWJg@mail.gmail.com>
Subject: Re: [PATCH 7/8] serial: 8250/ingenic: Add support for the
 JZ4750/JZ4755 SoCs
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
        kbuild-all@lists.01.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-mips@vger.kernel.org,
        GPIO SUBSYSTEM <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

=D0=BF=D0=BD, 17 =D0=BE=D0=BA=D1=82. 2022 =D0=B3. =D0=B2 12:32, Paul Cercue=
il <paul@crapouillou.net>:
> > I checked that approach: serial seems to be working as expected,
> > but not all the time: there's a time period when the CGU driver
> > started but serial console driver is still early one.
> > In my case UART produces garbage at that period since CGU
> > needs to enable clock divider back: ext is 24MHz but 12MHz
> > required for audio codec and USB to function properly.
>
> What I'd do, is just force-enable it to 12 MHz in ingenic_fixup_fdt(),
> since the programming manual basically says that 24 MHz does not work
> properly.
>
> Then in the earlycon setup code hardcode the /2 divider with a big fat
> comment about why it's there.

Agree, the vendor's kernel does that as well.

Also I found that:
1. Many other drivers compile the early console only when
CONFIG_SERIAL_8250_CONSOLE is set.
2. All the early ingenic_ functions can be labeled as __init.
Shall I fix that while I'm already here?
