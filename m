Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D2C6002EA
	for <lists+dmaengine@lfdr.de>; Sun, 16 Oct 2022 20:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJPSkC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 16 Oct 2022 14:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiJPSkC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 16 Oct 2022 14:40:02 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0565620994;
        Sun, 16 Oct 2022 11:40:00 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id y80so7580407iof.3;
        Sun, 16 Oct 2022 11:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=er//qg/gl4dGP2tGaPp0ROa9zLnweqgMmV1YWZYYP7c=;
        b=VLlF0F3ix3yIubo5GyNOzrxMT9uWk3plyHN40JmolDouSrQ6S1EkrNOya03i9KYYee
         Pdev33Tl7wz7AOBvwkIWQLGgDzO0xQkh+PhQREIzD1GZPnPRO/lcMf1VWMop9hq358fl
         aXOTiHnPm7vzpKXFYAJcnkfoGhLNd0RFOM2wNTECtw4VAB3Z8WkZM6t4+8EN3t5JCW4L
         0kDq5AgEHKFhEyBJPfvXQmLC4Jb6kCZhJVx/oy7N6XuJqZhwJVR2VkREM2wKA0uzh8Fk
         UIavRDjcsJugiUVfEo2acS8siEp0mDsbdgjZfIVNnTI51xK3B2T9kTvnL0L4+W4wKQoU
         tMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=er//qg/gl4dGP2tGaPp0ROa9zLnweqgMmV1YWZYYP7c=;
        b=mMm23AdkgG1EnOyPnxxR3zgNWvxXWVThECAzYiCnBKBHI4P1kJb3NzA6i4MoP/lMwZ
         7JhImFN/QqoBXAJDvFKDvRE8LPpgyIETuDJpCWD0QMjtwlAOgb4sOzYI+944OFg2vR1v
         K5L5Vx7Lc+SG+ofpWwVy7Hwb8T6MqtCZGK+3CGRYqvuDz33bLIpzqOBSNa03IAUb0cuK
         4/xzn9SsV8M/giTZWHVbz+5WYu1t1cn9EubagMfDP5w/V60Ba6Rbcyuo5GJAvg2nr6/q
         i8gJP5ztRH2MWFsJXEUUDwO1fe2Hv4cYA10hbDY6S0c2qFUvW6njcP10nOAi0gNZSH0t
         Frew==
X-Gm-Message-State: ACrzQf0NAfdEwFvVIzjl/8Zkhf/RGf6li8JtmtP9Y23bXc8eg/b5UADb
        UnNtauaM8lW9uK2lQ+9kW1aEB3/2GEv5EPnV0Ps=
X-Google-Smtp-Source: AMsMyM418IYKdUWCL2jLsEzw/ZxVzVBP8CpmwVFc41Ps8SCy1jto6Dznc6/8LG+UqyyPQURKmvlBPoxB8eZ05lpVVqA=
X-Received: by 2002:a6b:6716:0:b0:6bc:113c:22a2 with SMTP id
 b22-20020a6b6716000000b006bc113c22a2mr3022066ioc.12.1665945599378; Sun, 16
 Oct 2022 11:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <20221009181338.2896660-8-lis8215@gmail.com> <202210100607.YdxoR0tD-lkp@intel.com>
 <CAKNVLfaFvge4A8-QUzeq-JManpuYMGvyHXCJi-ew==CWN8-M=A@mail.gmail.com>
 <bb9f79d4-82a9-4790-b849-d517333ea2d4@app.fastmail.com> <GSPOJR.M4XZ4D03G60F@crapouillou.net>
 <CAKNVLfZukazKx2yDBrLZc7J9=3cCvMgZbdghtt1YO7WivdPjvw@mail.gmail.com>
In-Reply-To: <CAKNVLfZukazKx2yDBrLZc7J9=3cCvMgZbdghtt1YO7WivdPjvw@mail.gmail.com>
From:   Siarhei Volkau <lis8215@gmail.com>
Date:   Sun, 16 Oct 2022 21:39:48 +0300
Message-ID: <CAKNVLfbePJQN07GfhqAs-opm23poWsL0o-DkV=n-f9+H7Y7rpg@mail.gmail.com>
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

=D1=87=D1=82, 13 =D0=BE=D0=BA=D1=82. 2022 =D0=B3. =D0=B2 21:56, Siarhei Vol=
kau <lis8215@gmail.com>:

> > Just disable the divider in ingenic_fixup_fdt() in

> I'll check that.

I checked that approach: serial seems to be working as expected,
but not all the time: there's a time period when the CGU driver
started but serial console driver is still early one.
In my case UART produces garbage at that period since CGU
needs to enable clock divider back: ext is 24MHz but 12MHz
required for audio codec and USB to function properly.

So I think Arnd's approach:

> the hardware should already be in a working state,
> with no need to touch it during early boot.

shall resolve the problem, although I can't check it on all supported
hardware.

BR,
Siarhei
