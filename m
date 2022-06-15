Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4511E54C81E
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jun 2022 14:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346772AbiFOMHV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jun 2022 08:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239284AbiFOMHU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Jun 2022 08:07:20 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EFD37ABF;
        Wed, 15 Jun 2022 05:07:17 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1655294834; bh=izkMW7/nCGStLmJpRPGKVyWyEhaf2yWPv1nwAze4fKo=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=b4ZvYL9PgIee/QHliIcDiomKj4KMu53BbVvWwW22fP6OB2/aYrhLL8bviphVK3OZ/
         Tq8GyQLc2PzHnweYsbg5OKeiudyxLVLrCPGyMy4bYyLi6PG5tur3FFIBNrPwCEMafg
         kuHhGtSxG2DKv65jJcYlKa5BZSKI1sEnHVEAqpPs=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH -next] dmaengine: apple-admac: Fix build on
 32-bit/non-LPAE platforms
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <20220614074915.1443629-1-geert@linux-m68k.org>
Date:   Wed, 15 Jun 2022 14:07:12 +0200
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4D5BB835-5DF0-4BBB-B073-A77F1A96EA19@cutebit.org>
References: <20220614074915.1443629-1-geert@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


> On 14. 6. 2022, at 9:49, Geert Uytterhoeven <geert@linux-m68k.org> =
wrote:
>=20
> If CONFIG_PHYS_ADDR_T_64BIT is not set:
>=20
>    drivers/dma/apple-admac.c: In function =
=E2=80=98admac_cyclic_write_one_desc=E2=80=99:
>    drivers/dma/apple-admac.c:213:22: error: right shift count >=3D =
width of type [-Werror=3Dshift-count-overflow]
>      213 |  writel_relaxed(addr >> 32,       ad->base + =
REG_DESC_WRITE(channo));
>          |                      ^~
>=20
> Fix this by using the {low,upp}er_32_bits() helper macros to obtain =
the
> address parts.
>=20
> Reported-by: noreply@ellerman.id.au
> Fixes: b127315d9a78c011 ("dmaengine: apple-admac: Add Apple ADMAC =
driver")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks! (TIL about the lower/upper_32_bits helpers)

Acked-by: Martin Povi=C5=A1er <povik+lin@cutebit.org>

