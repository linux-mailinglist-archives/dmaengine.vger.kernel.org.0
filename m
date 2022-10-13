Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42B05FD68F
	for <lists+dmaengine@lfdr.de>; Thu, 13 Oct 2022 11:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiJMJDx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Oct 2022 05:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiJMJDw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 13 Oct 2022 05:03:52 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1089FAA4C;
        Thu, 13 Oct 2022 02:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1665651829; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3w+kxdMlvD/pI2haEFydC/UnxNO43RACIV6R2zgapDU=;
        b=N45fZOMeEOwmYLujVLRGPkUBvG87sCBg78asnf975h/Er5O65LysWcqyU3+5LNjshYWpc4
        LRmjbQYLwqKRA+x24xUADhJP9offZ+Q1CiNjTk8ErtmlvzE+CZlDYfLW+OT/UwilVSxrLf
        hhOSjit5k5iBrssrF3vX93dZ7hrvHu0=
Date:   Thu, 13 Oct 2022 10:03:37 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/8] dt-bindings: ingenic: Add support for the JZ4755 SoC
To:     Siarhei Volkau <lis8215@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org
Message-Id: <16POJR.Z0LNYV2MVKSS@crapouillou.net>
In-Reply-To: <CAKNVLfZmjfmKb5ybY8NDhV-bQCQn7o_bSVK=aM4byftasW6dLg@mail.gmail.com>
References: <20221009181338.2896660-1-lis8215@gmail.com>
        <20221009181338.2896660-2-lis8215@gmail.com>
        <84b6dae0-d503-bbd2-d483-80462917afa4@linaro.org>
        <CAKNVLfZmjfmKb5ybY8NDhV-bQCQn7o_bSVK=aM4byftasW6dLg@mail.gmail.com>
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

Le lun., oct. 10 2022 at 23:18:05 +0300, Siarhei Volkau=20
<lis8215@gmail.com> a =C3=A9crit :
> =D0=BF=D0=BD, 10 =D0=BE=D0=BA=D1=82. 2022 =D0=B3. =D0=B2 17:55, Krzysztof=
 Kozlowski
> <krzysztof.kozlowski@linaro.org>:
>=20
>>  How do you plan to merge it? Usually these go via subsystem trees...
>=20
> It's a new case for me, could you explain the problem a bit more?
> What things should I bother with in the next patchset version?
> Thanks in advance.

Just split the patchset, most of your patches (e.g. DMA patch, CGU,=20
pinctrl, UART) should be sent separately.

Otherwise it makes things much more complicated for merging.

Cheers,
-Paul


