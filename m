Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B6E5B3A7F
	for <lists+dmaengine@lfdr.de>; Fri,  9 Sep 2022 16:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiIIOQk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Sep 2022 10:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbiIIOQc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 9 Sep 2022 10:16:32 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5076C6951;
        Fri,  9 Sep 2022 07:16:27 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1662732985; bh=JwFAHcC/4eYphZlFJvNFL6J9NVjJq/CoRrfoZy73gUs=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=g4Q3gU7RsWFdnxwGJGFTG1OiSMEGIlmu3Brl7NvC84c77Z1XA+EfquuLWfcK8m7u9
         +631amUToG5wtKoVe8WbcHCFit/JhV896ll2vbQp5mcSsAKKNL+Pyo4OJzwaYYKPrp
         ke8Sf8e203KocpZeq5h8Futbk6bBjxRqCqEZcauE=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [RFC PATCH 02/10] dt-bindings: dma: apple,admac: Add iommus and
 power-domains properties
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <20220909135103.98179-3-j@jannau.net>
Date:   Fri, 9 Sep 2022 16:16:24 +0200
Cc:     asahi@lists.linux.dev, Mark Kettenis <kettenis@openbsd.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sven Peter <sven@svenpeter.dev>, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <60F87A29-03D1-4F82-ABEF-A64C38E550FE@cutebit.org>
References: <20220909135103.98179-1-j@jannau.net>
 <20220909135103.98179-3-j@jannau.net>
To:     Janne Grunau <j@jannau.net>, Vinod Koul <vkoul@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


> On 9. 9. 2022, at 15:50, Janne Grunau <j@jannau.net> wrote:
>=20
> Apple's ADMAC is on all supported Apple silicon SoCs behind an IOMMU
> and has its own power-domain.
>=20
> Signed-off-by: Janne Grunau <j@jannau.net>

Acked-by: Martin Povi=C5=A1er <povik+lin@cutebit.org>

Vinod, please pick it up in the dmaengine tree, I may have one patch to
the binding I will post later (with associated driver changes).

