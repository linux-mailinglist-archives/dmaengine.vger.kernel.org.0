Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF035EFC26
	for <lists+dmaengine@lfdr.de>; Thu, 29 Sep 2022 19:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiI2RkR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Sep 2022 13:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiI2RkQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Sep 2022 13:40:16 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECB210FE27;
        Thu, 29 Sep 2022 10:40:11 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1664473208; bh=+tSZFKbdvZWoKMzR6iGa9lHAoFeV6hdZ0rUHvW7OGxA=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=aUAW32jD+aP7mmtNX2LQYWs/MD0I0GmQisxaT44WHXAVeagRLcMdq0FPNkZ32CIEA
         hJJcMAd/KirCWXqknBO0WaSJbDPplJFsdvMyBI9CTARaupas5At9dGqhtV5Ad5MgTP
         MOIv3M4FrMU8vxQALx0ueyOxrJ1e7PLaZJ7p7vyo=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH v1 01/10] dt-bindings: dma: apple,admac: Add iommus and
 power-domains properties
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <YzXIVM6zGszDa2JQ@matsya>
Date:   Thu, 29 Sep 2022 19:40:05 +0200
Cc:     Janne Grunau <j@jannau.net>, asahi@lists.linux.dev,
        Mark Kettenis <kettenis@openbsd.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sven Peter <sven@svenpeter.dev>, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EE079966-79EE-47D4-A8AC-5DC404A62A1E@cutebit.org>
References: <20220916142550.269905-1-j@jannau.net>
 <20220916142550.269905-2-j@jannau.net> <YzXIVM6zGszDa2JQ@matsya>
To:     Vinod Koul <vkoul@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


> On 29. 9. 2022, at 18:31, Vinod Koul <vkoul@kernel.org> wrote:
>=20
> On 16-09-22, 16:25, Janne Grunau wrote:
>> Apple's ADMAC is on all supported Apple silicon SoCs behind an IOMMU
>> and has its own power-domain.
>=20
> Applied, thanks

Hi Vinod,

this has been picked up by Hector and is staged in asahi-soc/dt [0].
I see you haven=E2=80=99t pushed yet. Would it be possible to drop the =
patch
on your end so we don=E2=80=99t end up with two commits for the same =
change?
(I assume that would be an issue.)

To recapitulate: There are two ADMAC binding changes to go in for 6.1,
they are both in asahi-soc/dt. I know I initially asked you to apply
this patch when the series was an RFC.

Thanks,
Martin

[0] =
https://github.com/AsahiLinux/linux/commit/3ac3865735a83bd1c0dae7ad73b7462=
1774755cb

> --=20
> ~Vinod
>=20

