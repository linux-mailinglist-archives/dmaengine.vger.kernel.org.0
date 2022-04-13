Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00E54FF76C
	for <lists+dmaengine@lfdr.de>; Wed, 13 Apr 2022 15:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbiDMNMo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Apr 2022 09:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235711AbiDMNMe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 Apr 2022 09:12:34 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE32369FF;
        Wed, 13 Apr 2022 06:10:12 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8ADB560006;
        Wed, 13 Apr 2022 13:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649855411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zq0/0xA2JZ05vFh/LQxUdxfXIW45kzNdF9iAIigkAL0=;
        b=dgBzt2BY+uWtcgOkQ2QOiFv5e00IthNbA6vS4ChNlw4ltj7qbgUtlOv/B/NUaeXCCp4Zxi
        1TY+VRfwlt3APCqV2qUzgd7sPHBMSmzOQLv2NcM1kyyoYy62G2D5jieoZOg8aE+1dhY+Gs
        4yuF0rUIiiC7rOLbWe7UEfj8Z0FW+LWNwo6uYNx5qM84krPVjIY54oV97xDjciztMEJ6T0
        HG/MgeAOCE02L4rguZetP3pa5DJ7jf1jY93kgZXcP5se0i1MYZR0yBaoSJeS5ZOyCuCKm4
        Isz3w7T/SK7tmzwiQrH6dmtYpPHpX1e+y5mVUlTk74dGy/WVc/Gxs+siGs7l/g==
Date:   Wed, 13 Apr 2022 15:10:07 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v10 5/9] dmaengine: dw: dmamux: Introduce RZN1 DMA
 router support
Message-ID: <20220413151007.15cc54fd@xps13>
In-Reply-To: <Ylaom9pRMm0C0Nsz@smile.fi.intel.com>
References: <20220412193936.63355-1-miquel.raynal@bootlin.com>
        <20220412193936.63355-6-miquel.raynal@bootlin.com>
        <CAMuHMdV_KWuDRWtNaL2n8+1y4GbOSSosesd3RPK60i6zYkQPDA@mail.gmail.com>
        <Ylaom9pRMm0C0Nsz@smile.fi.intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Andy,

andriy.shevchenko@linux.intel.com wrote on Wed, 13 Apr 2022 13:40:27
+0300:

> On Wed, Apr 13, 2022 at 09:53:09AM +0200, Geert Uytterhoeven wrote:
> > On Tue, Apr 12, 2022 at 9:39 PM Miquel Raynal <miquel.raynal@bootlin.co=
m> wrote: =20
>=20
> ...
>=20
> > You might as well declare it in rzn1_dmamux_data as:
> >=20
> >     unsigned long used_chans[BITS_TO_LONGS(2 * RZN1_DMAMUX_MAX_LINES)];=
 =20

Now at the top of the driver I have

#define RZN1_DMAMUX_LINES 64
#define RZN1_DMAMUX_MAX_LINES 16

Which does not look right. So FYI I decided to change them to

#define RZN1_DMAMUX_MAX_LINES 64
#define RZN1_DMAMUX_LINES_PER_CTLR 16

which feels much more clear.

Thanks,
Miqu=C3=A8l
