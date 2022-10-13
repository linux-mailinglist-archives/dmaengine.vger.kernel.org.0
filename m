Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E915FD6D8
	for <lists+dmaengine@lfdr.de>; Thu, 13 Oct 2022 11:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiJMJRX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Oct 2022 05:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJMJRW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 13 Oct 2022 05:17:22 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E925FBC;
        Thu, 13 Oct 2022 02:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1665652637; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QfKF6P//aPtt3yXkddZGb8gQhNXBSYeBQmboxbZCJlU=;
        b=Ip0NSVDD1AM8ZgtvW/VD87fTHoRfAC5ZKR4g5vCDTryKzaGimlZJoh+FC5CRuxEyrYuyOV
        zFio5aFohd39Q+mWiqCJyJxM7qdFhkFObmPHLG9/o7LYmzxzlFG4La4/m47ImlJB8FwZ5u
        kKRpu9SSwogossEIyH7SeLGOjn8wS2U=
Date:   Thu, 13 Oct 2022 10:17:04 +0100
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
Message-Id: <GSPOJR.M4XZ4D03G60F@crapouillou.net>
In-Reply-To: <bb9f79d4-82a9-4790-b849-d517333ea2d4@app.fastmail.com>
References: <20221009181338.2896660-8-lis8215@gmail.com>
        <202210100607.YdxoR0tD-lkp@intel.com>
        <CAKNVLfaFvge4A8-QUzeq-JManpuYMGvyHXCJi-ew==CWN8-M=A@mail.gmail.com>
        <bb9f79d4-82a9-4790-b849-d517333ea2d4@app.fastmail.com>
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

Hi,

Le jeu., oct. 13 2022 at 08:46:39 +0200, Arnd Bergmann <arnd@arndb.de>=20
a =C3=A9crit :
> On Thu, Oct 13, 2022, at 8:37 AM, Siarhei Volkau wrote:
>>  =D0=BF=D0=BD, 10 =D0=BE=D0=BA=D1=82. 2022 =D0=B3. =D0=B2 01:29, kernel =
test robot=20
>> <lkp@intel.com>:
>>>  config: ia64-allyesconfig
>>>  config: arm64-randconfig-r035-20221010
>>=20
>>>   > 142  #define CGU_REG_CPCCR   ((void *)CKSEG1ADDR(0x10000000))
>>=20
>>>  0-DAY CI Kernel Test Service
>>=20
>>  I know CKSEG1ADDR is MIPS specific, might be it needed to disable=20
>> COMPILE_TEST
>>  on the driver?
>>  Since early syscon isn't mainlined yet I don't see any other way at=20
>> the moment.
>>=20
>>  Any suggestions on that, folks?
>=20
> This looks like some setup that belongs into the bootloader. If you=20
> are
> handing over the console from bootloader to kernel, the hardware=20
> should
> already be in a working state, with no need to touch it during early
> boot.
>=20
> If you are dealing with broken bootloaders that are not under your=20
> control,
> having this code in the architecture specific early boot as a fixup
> would be better than putting it into the driver.

Agreed. I am not fond of having a driver poking into an unrelated=20
subsystem's memory area.

Just disable the divider in ingenic_fixup_fdt() in=20
arch/mips/generic/board-ingenic.c.

Cheers,
-Paul


