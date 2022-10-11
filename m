Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5B85FBA7F
	for <lists+dmaengine@lfdr.de>; Tue, 11 Oct 2022 20:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiJKSiT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Oct 2022 14:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiJKSiS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 11 Oct 2022 14:38:18 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BAA62AA2;
        Tue, 11 Oct 2022 11:38:16 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id o65so11591632iof.4;
        Tue, 11 Oct 2022 11:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yzz7HPfd9lZbybLpIqjBSIyTMfCLBxbv1l1ZEl4GhoA=;
        b=Qk8QJCIatrsXIrxE/1a4v6fwYn2G9ANRwZ/uX2kjiTr0NSt5poOiPAzTxoj7e31W5K
         IxvyMMHhBnGzATsf2wbexpgSf4zz/Wkt0/SEY0PEw2afmrFu0B1UJxD0pEVx8Wy1mHPg
         lH6Z4XxiwccfnyyEQJYRweI8lQYUEA8DQOpmcsouqwJl7HmSm8uLgjV2FkkljSHscw3T
         fn6teUcifNDJ7ie9w8jtZ6nqiygnDbEYlU4dNv2o/pTOmZrXH2975YeOdjVmaMZTzrGk
         yL0XXjeYRtGF47M/8oNKAqys/gANbdBwVKroEMOaKef47BWqV1hbWsW2s9G/kDLIEWE1
         8dIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yzz7HPfd9lZbybLpIqjBSIyTMfCLBxbv1l1ZEl4GhoA=;
        b=RBUWEPJncbllp7NdDpzODxwZqNzMpxDciKKcx7eos4OP5dPuvpp3X5NA/jX7pmjz7n
         tVIQInk9i9OvSUsIoMBWOaGOBshwucSjuxwPhv1zuxGJvvtT9kn2g+SNqiCZuXkoDj+t
         kFclitraEDBTW8llh3vGyauda/5yiM4L+P+xB+pUYPglMdSVCXYzGlmBf4nt1aIr/Ifb
         rX+apHaSi7CQ8uYRcHA28oiA62vXfaohXSAx4Eyqm5wzhiS0byPogHKwOuEFPt5SxIHV
         xUHoPP1zLMSVdxqsDv25/mgMxdFAUmFCeiPLSsOugiHn9u+92y1YeU4zQGSaqWp4GHM8
         53yQ==
X-Gm-Message-State: ACrzQf0s2nQOBM6TRf3yrsUjfR5DwUfWM+dhWzAb/7ALLwfDdY3rqcYC
        HZ+foYn2JZt6o+j7/Wf6UlgeWJBsNZNgAhlyKws=
X-Google-Smtp-Source: AMsMyM6K6r8LdVzpVWYq8QtcvBsfHdBteWilO2KZnECnX0n0rcAd1mM+RWpr1skNfc7yA9u6pPfyByjCewD57Mlv1r4=
X-Received: by 2002:a05:6638:2494:b0:363:db4f:c870 with SMTP id
 x20-20020a056638249400b00363db4fc870mr1579414jat.65.1665513494686; Tue, 11
 Oct 2022 11:38:14 -0700 (PDT)
MIME-Version: 1.0
References: <20221009181338.2896660-1-lis8215@gmail.com> <20221009181338.2896660-8-lis8215@gmail.com>
 <Y0R+q7BdxtFqeiT1@kroah.com>
In-Reply-To: <Y0R+q7BdxtFqeiT1@kroah.com>
From:   Siarhei Volkau <lis8215@gmail.com>
Date:   Tue, 11 Oct 2022 21:38:03 +0300
Message-ID: <CAKNVLfaNJjdVCeVCrOOw5xjsJ=gzJ2uFxAjgMA9tWHE=qFEECA@mail.gmail.com>
Subject: Re: [PATCH 7/8] serial: 8250/ingenic: Add support for the
 JZ4750/JZ4755 SoCs
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org
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

=D0=BF=D0=BD, 10 =D0=BE=D0=BA=D1=82. 2022 =D0=B3. =D0=B2 23:20, Greg Kroah-=
Hartman <gregkh@linuxfoundation.org>:
> What does "clkdiv" mean here?

That means a clock divisor between the input oscillator and UART
peripheral clock source. Most Ingenic SoCs don't have that divisor,
so 1 is always in effect for them.
However, the JZ4750 and JZ4755 have switchable /2 clock divisor.

> If you only have 1 or 2 as an option

Yes, it is.

> just have 2 functions instead please.

Got it, will do that.

Thank you.
