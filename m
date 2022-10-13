Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501C95FE248
	for <lists+dmaengine@lfdr.de>; Thu, 13 Oct 2022 20:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiJMS7a (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Oct 2022 14:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbiJMS6y (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 13 Oct 2022 14:58:54 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA30827928;
        Thu, 13 Oct 2022 11:57:06 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id q11so1431005ilj.10;
        Thu, 13 Oct 2022 11:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aU4v5j25jcA4b2/jV12oaXw7opkB9OVDvdOu4hkOSkY=;
        b=QhFO5qgSaKUMRml2Jd5VUmeEmiC9AF9BZmoWzw8uxvh3OpKZoYPyVVGYi4p2MDAlFa
         +hMoMa8jTFYXU93+Kr/LdS9ATml85nFb2/ErVZ6DUkcki6WLco1sdO0u0MUr7zdLcb50
         U8gM9fCJcsogz5Lw6B9QRyxGaZ8d9HJ75FXki6+24oVpcN9wE3GBgQinDmZm8oG27DKl
         xfaeeT3GBBYthIwZkrCiBgC8M40Lo3rPe4nJ2ES38QAj1B8OCrI9b5eQNKJsi5wChNTd
         b60m4fcAQbwUuQngvLcY0Luy7sOWRSIr/XRLCS5wpz0wbDJKImI5VlSnEwoWCcuyaX5y
         1YLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aU4v5j25jcA4b2/jV12oaXw7opkB9OVDvdOu4hkOSkY=;
        b=K4VQ24JcmhHFUeTtBBqWcn+HkAA1v3Z0OiUu56pd0rz/g+xDSvNXZo7hV7kxoMIvCF
         BYZebeejThbZ2ftg78MEZ6seU/N5oUCUEdJ/oOA6faZyr7hKHd+5NSATgqVASKbQsAeR
         +2fpEUNTpWS9NGcRMF4H0RdXqtwlS96n0ZDs4gBJhSjdvP94QmottMTze+OAk6HnDPjN
         IRR+JAIAuXKrVDCfa9rTl6nAMspyX9L7uPqGF1qripGfnadyogAr4rjOoFsSVhmZuUEw
         dGrZRK/xsA4BidXcpOFaK7iygGbwug9gAXeplOKtMQ6I3wuMNDPoRHhFaPUOCSe2M1dK
         sswQ==
X-Gm-Message-State: ACrzQf0CddUJX4PziJN2cc9gi4EcyODUXt73ToCo/0WlWWscv8MSmnhO
        Uq3AB6wLtq1kqWXFO5G7E8WGvQcsjqKHxfKjIDk=
X-Google-Smtp-Source: AMsMyM4tAkBUHy+Lv4iPEVX7fI3kq/6F/ptm2DyftFBCewja+gWmdmjL6xlLgaH6l9cZUi7njV1AcafirE2fwO2o+eY=
X-Received: by 2002:a05:6e02:20ea:b0:2fa:bf8:300a with SMTP id
 q10-20020a056e0220ea00b002fa0bf8300amr696533ilv.309.1665687426081; Thu, 13
 Oct 2022 11:57:06 -0700 (PDT)
MIME-Version: 1.0
References: <20221009181338.2896660-8-lis8215@gmail.com> <202210100607.YdxoR0tD-lkp@intel.com>
 <CAKNVLfaFvge4A8-QUzeq-JManpuYMGvyHXCJi-ew==CWN8-M=A@mail.gmail.com>
 <bb9f79d4-82a9-4790-b849-d517333ea2d4@app.fastmail.com> <GSPOJR.M4XZ4D03G60F@crapouillou.net>
In-Reply-To: <GSPOJR.M4XZ4D03G60F@crapouillou.net>
From:   Siarhei Volkau <lis8215@gmail.com>
Date:   Thu, 13 Oct 2022 21:56:54 +0300
Message-ID: <CAKNVLfZukazKx2yDBrLZc7J9=3cCvMgZbdghtt1YO7WivdPjvw@mail.gmail.com>
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

=D1=87=D1=82, 13 =D0=BE=D0=BA=D1=82. 2022 =D0=B3. =D0=B2 12:17, Paul Cercue=
il <paul@crapouillou.net>:
>
> Just disable the divider in ingenic_fixup_fdt() in
> arch/mips/generic/board-ingenic.c.
>
> Cheers,
> -Paul
>

Looks reasonable, I hope the bootloader initialized peripherals can handle
doubled frequency, till re-initialization completes. I'll check that.

Thank you all, guys.
