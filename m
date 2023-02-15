Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A38697E9D
	for <lists+dmaengine@lfdr.de>; Wed, 15 Feb 2023 15:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjBOOpD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Feb 2023 09:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjBOOpD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Feb 2023 09:45:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F7E8A5A;
        Wed, 15 Feb 2023 06:45:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECE0F61C3C;
        Wed, 15 Feb 2023 14:45:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC86C433A7;
        Wed, 15 Feb 2023 14:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676472301;
        bh=J7FR16wSeO0h7U2Rx2QzFOI98aN6QgOwDZqATCeQYVQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lfElhBWLykO/IJQQRODB6ZD2kRjRd9ASIZp9f8lTKR1+9FgfwaFmqe0HnNRHT9Hl3
         JkgU5v3vEdtLPgjeRRcJq3hv3Km6WJFocxQkgUlojqH7alhgWDMRAap4yyKNgWSlFM
         VOKpNUIYYpHF2vVio8HrKf+q9cSvm2aoZha9llKLmKv0QphWJ/mxRv0vnCW8R6jklr
         6/N5X7ZgJLm/dJ5bLJ2/oN/4kh2OUdKUkAp5UrVWyp3FdeUiiDJBhVtRjbFx85GCMO
         FOoM69qE8ueaGL5qtN2q7B9tqqLreXbtKeazbacUgYNmZfg4npkiMi2Sg8mDYWsOhr
         e3Fj94sQQv/6w==
Received: by mail-vk1-f180.google.com with SMTP id i4so5108071vkn.13;
        Wed, 15 Feb 2023 06:45:01 -0800 (PST)
X-Gm-Message-State: AO0yUKWRxNVrkYU67FU8fZYkGWztrgBayDtmbx6BUB3/8dDceZjRwexI
        v6YRg30pQvZI28f9FChM42EBwQg+U2USS8FoNQ==
X-Google-Smtp-Source: AK7set/kjqpJSwgOPQgeLthfUJMRO50WEjm6M46aPnoKXLrEXKV0KxBlqDn2v26BG08pkp0X6ufGr+PEnWMps4WzT6E=
X-Received: by 2002:a1f:1b83:0:b0:401:42f3:5657 with SMTP id
 b125-20020a1f1b83000000b0040142f35657mr350241vkb.42.1676472300265; Wed, 15
 Feb 2023 06:45:00 -0800 (PST)
MIME-Version: 1.0
References: <20230214141053.92731-1-povik+lin@cutebit.org> <167638945429.3790.16067227881981242831.robh@kernel.org>
 <6B75F1A1-E2DE-40D5-AA79-A764C65D8AD2@cutebit.org>
In-Reply-To: <6B75F1A1-E2DE-40D5-AA79-A764C65D8AD2@cutebit.org>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 15 Feb 2023 08:44:49 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJTHy3ZGUKk1dv3aD+ToxdmvYrjq1JPjHYt7R7LVVZpGQ@mail.gmail.com>
Message-ID: <CAL_JsqJTHy3ZGUKk1dv3aD+ToxdmvYrjq1JPjHYt7R7LVVZpGQ@mail.gmail.com>
Subject: Re: [RFC PATCH] dt-bindings: dma: apple,sio: Add schema
To:     =?UTF-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Janne Grunau <j@jannau.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hector Martin <marcan@marcan.st>, devicetree@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, Sven Peter <sven@svenpeter.dev>,
        asahi@lists.linux.dev, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Feb 14, 2023 at 1:18 PM Martin Povi=C5=A1er <povik+lin@cutebit.org>=
 wrote:
>
>
> > On 14. 2. 2023, at 17:12, Rob Herring <robh@kernel.org> wrote:
> > On Tue, 14 Feb 2023 15:10:53 +0100, Martin Povi=C5=A1er wrote:
> >> Describe the SIO coprocessor which serves as pretend DMA controller on
> >> recent Apple platforms.
> >>
> >> Signed-off-by: Martin Povi=C5=A1er <povik+lin@cutebit.org>
> >> ---
> >>
> >> Since the schema mentions a loader preparing the binding appropriately=
,
> >> here's a PR with the relevant (WIP) loader code, if anyone wants to lo=
ok:
> >> https://github.com/AsahiLinux/m1n1/pull/286
> >>
> >> .../devicetree/bindings/dma/apple,sio.yaml    | 129 ++++++++++++++++++
> >> 1 file changed, 129 insertions(+)
> >> create mode 100644 Documentation/devicetree/bindings/dma/apple,sio.yam=
l
> >>
> >
> > My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_chec=
k'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > Documentation/devicetree/bindings/dma/apple,sio.example.dts:24.35-27.11=
: Warning (node_name_vs_property_name): /example-0/interrupt-controller: no=
de name and property name conflict
>
> I saw the warning, but since I had copied that part of the example from
> apple,admac.yaml I didn=E2=80=99t make much of it. Now that I look at it =
again,
> the example in apple,admac doesn=E2=80=99t raise the same warning, how co=
me?
>
> This is just a curiosity since we don=E2=80=99t need the aic node in the =
example
> anyway (unlike in apple,admac where it=E2=80=99s needed because of empty =
entries
> in interrupts-extended).

'interrupts-extended' is why. If the example just has 'interrupts',
then a fake parent is constructed. It's pretty hacky, but necessary to
parse the interrupts later on for validation.

Rob
