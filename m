Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9EF600AC3
	for <lists+dmaengine@lfdr.de>; Mon, 17 Oct 2022 11:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiJQJcI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Oct 2022 05:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiJQJcH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Oct 2022 05:32:07 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099E6DFB9;
        Mon, 17 Oct 2022 02:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1665999125; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rMKReQwIIVROnhNRRcRSrMq5WTBa2N/odX1/c/GVkLg=;
        b=kJFze+j8yHYKpty5/eK7EP4QDoNyFl8juKwNPQ0r/r00EkgR/UUHdSeWh248/eDbhy5vM9
        lLtvhNSmJbbkSmtDk9RZnKf9+JDMNgNdtt4b0qpPqp3OiaGUj+dEecyo/3I5vcY+SX5Gi2
        W/1Zf15YfFPYNw2yS+MHt/IZjc6Zn08=
Date:   Mon, 17 Oct 2022 10:31:53 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 7/8] serial: 8250/ingenic: Add support for the
 JZ4750/JZ4755 SoCs
To:     Siarhei Volkau <lis8215@gmail.com>
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
Message-Id: <555WJR.ESJD0KDHOG3S@crapouillou.net>
In-Reply-To: <CAKNVLfbePJQN07GfhqAs-opm23poWsL0o-DkV=n-f9+H7Y7rpg@mail.gmail.com>
References: <20221009181338.2896660-8-lis8215@gmail.com>
        <202210100607.YdxoR0tD-lkp@intel.com>
        <CAKNVLfaFvge4A8-QUzeq-JManpuYMGvyHXCJi-ew==CWN8-M=A@mail.gmail.com>
        <bb9f79d4-82a9-4790-b849-d517333ea2d4@app.fastmail.com>
        <GSPOJR.M4XZ4D03G60F@crapouillou.net>
        <CAKNVLfZukazKx2yDBrLZc7J9=3cCvMgZbdghtt1YO7WivdPjvw@mail.gmail.com>
        <CAKNVLfbePJQN07GfhqAs-opm23poWsL0o-DkV=n-f9+H7Y7rpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Siarhei,

Le dim., oct. 16 2022 at 21:39:48 +0300, Siarhei Volkau=20
<lis8215@gmail.com> a =C3=A9crit :
> =D1=87=D1=82, 13 =D0=BE=D0=BA=D1=82. 2022 =D0=B3. =D0=B2 21:56, Siarhei V=
olkau=20
> <lis8215@gmail.com>:
>=20
>>  > Just disable the divider in ingenic_fixup_fdt() in
>=20
>>  I'll check that.
>=20
> I checked that approach: serial seems to be working as expected,
> but not all the time: there's a time period when the CGU driver
> started but serial console driver is still early one.
> In my case UART produces garbage at that period since CGU
> needs to enable clock divider back: ext is 24MHz but 12MHz
> required for audio codec and USB to function properly.

What I'd do, is just force-enable it to 12 MHz in ingenic_fixup_fdt(),=20
since the programming manual basically says that 24 MHz does not work=20
properly.

Then in the earlycon setup code hardcode the /2 divider with a big fat=20
comment about why it's there.

Cheers,
-Paul

> So I think Arnd's approach:
>=20
>>  the hardware should already be in a working state,
>>  with no need to touch it during early boot.
>=20
> shall resolve the problem, although I can't check it on all supported
> hardware.
>=20
> BR,
> Siarhei


