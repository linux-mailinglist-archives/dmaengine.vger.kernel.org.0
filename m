Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE665FD51A
	for <lists+dmaengine@lfdr.de>; Thu, 13 Oct 2022 08:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiJMGrF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Oct 2022 02:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiJMGrE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 13 Oct 2022 02:47:04 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D401290A6;
        Wed, 12 Oct 2022 23:47:03 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id EF7485C0127;
        Thu, 13 Oct 2022 02:47:02 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 13 Oct 2022 02:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1665643622; x=
        1665730022; bh=XwmsESqk/Mz2TS0pIfupkDkgEK5jAWpDkr1AL7dqjEQ=; b=a
        wqMFRb+P9hedqzCXGkdo06lLrny5ilZcxAC4Nk/R57b287QUw39WN/2zYPxs6Kc7
        zM9Meeht5SKyKtBYENDBbbKK3P3bedFuITiVZDtEJgrk9UiNjNpuCRolbByg6Naj
        go6Rj1iHawTSol3FMqjU2y7Fy1noajh2yS0lYfaI+AAfkMm4YhJ3r4GPY0v/RYIK
        B+kUobvEuWAMquAoQrWvu5xuxb2wFvcwrMNAIgD0G+6++RbOTA765G/STiBPrNKc
        pTiIQrqKT/kzJgg6fTrZbGA6IB3EhAKuhY38gm2fRwSJn31VZlTV7xnlfUZWs9AZ
        YpDpCnLdywHAEhPD7pd0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1665643622; x=
        1665730022; bh=XwmsESqk/Mz2TS0pIfupkDkgEK5jAWpDkr1AL7dqjEQ=; b=C
        RtXT3kUB2JNUdCISb+BfeQfuzflADRGlr15UIgd9heK4aE5FRLf4yvD0+ds2br97
        3wNRhmo2YimXJs7AHUnUVK/ikVEaSnO6p/tn7TuakqQiHOSmq3Fe9CS3loDg7xzI
        jpc+Ske2ZdPq+em1A1ji/nXRXaLNCD8PpHuMTgOQBeHgf3tona4XCNCOy32gHh5R
        CwRgCzZnLSwRvfbH0cEd3mK8nvlIJMWPOQDR/TtgiWokwiYPB8oiYcoq7XJU2UBf
        kiHHe6/7oaUlneRBcChAw+RTwQq2lB+h2AqAu1HEFFBqkUyMZaQ0gkVUMDrgobaM
        tadg4t0nz+/PVyHez0zUw==
X-ME-Sender: <xms:ZbRHY3t7Wb6krKewjVLxQuag5wRQr19BJPrSCKl0PPxa-OdweXLnDw>
    <xme:ZbRHY4cxZDi56UMG95tyINBJI5Xrd9XtfEe11xd1vEuXuHbgsBxpglDBPOZwyQuLG
    osmlOJLvF48SZteqnY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejledguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudek
    tdfgjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:ZbRHY6y4_LimGAeWk3Yz4h732qXyCAb-PaA2-1v6Jj7Afdi6bl-m8A>
    <xmx:ZbRHY2OV-HxTA5POBUvfgNJ0epqhYd0Bzg38dNooqQPz3XpzTj5Mrg>
    <xmx:ZbRHY39Rlln9hZ_jsYL_sxwqNPHVwn6M-zLAnTrVjlV2eQlrd8jRcA>
    <xmx:ZrRHY0in_4fg76jKKZZymv8C57pap7TLcmYudQYy89fu9AxSpjBuJA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C6189B60086; Thu, 13 Oct 2022 02:47:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <bb9f79d4-82a9-4790-b849-d517333ea2d4@app.fastmail.com>
In-Reply-To: <CAKNVLfaFvge4A8-QUzeq-JManpuYMGvyHXCJi-ew==CWN8-M=A@mail.gmail.com>
References: <20221009181338.2896660-8-lis8215@gmail.com>
 <202210100607.YdxoR0tD-lkp@intel.com>
 <CAKNVLfaFvge4A8-QUzeq-JManpuYMGvyHXCJi-ew==CWN8-M=A@mail.gmail.com>
Date:   Thu, 13 Oct 2022 08:46:39 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Siarhei Volkau" <lis8215@gmail.com>,
        "kernel test robot" <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzk@kernel.org>,
        "Vinod Koul" <vkoul@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Paul Cercueil" <paul@crapouillou.net>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Jiri Slaby" <jirislaby@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-mips@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH 7/8] serial: 8250/ingenic: Add support for the JZ4750/JZ4755 SoCs
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Oct 13, 2022, at 8:37 AM, Siarhei Volkau wrote:
> =D0=BF=D0=BD, 10 =D0=BE=D0=BA=D1=82. 2022 =D0=B3. =D0=B2 01:29, kernel=
 test robot <lkp@intel.com>:
>> config: ia64-allyesconfig
>> config: arm64-randconfig-r035-20221010
>
>>  > 142  #define CGU_REG_CPCCR   ((void *)CKSEG1ADDR(0x10000000))
>
>> 0-DAY CI Kernel Test Service
>
> I know CKSEG1ADDR is MIPS specific, might be it needed to disable COMP=
ILE_TEST
> on the driver?
> Since early syscon isn't mainlined yet I don't see any other way at th=
e moment.
>
> Any suggestions on that, folks?

This looks like some setup that belongs into the bootloader. If you are
handing over the console from bootloader to kernel, the hardware should
already be in a working state, with no need to touch it during early
boot.

If you are dealing with broken bootloaders that are not under your contr=
ol,
having this code in the architecture specific early boot as a fixup
would be better than putting it into the driver.

      Arnd
