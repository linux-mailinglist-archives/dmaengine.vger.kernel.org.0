Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074574F1548
	for <lists+dmaengine@lfdr.de>; Mon,  4 Apr 2022 14:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343812AbiDDM5U (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 4 Apr 2022 08:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348187AbiDDM5U (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 4 Apr 2022 08:57:20 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8F0329B6;
        Mon,  4 Apr 2022 05:55:23 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 05C2F1BF206;
        Mon,  4 Apr 2022 12:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649076922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/x1VrTRzYIeZXgFI1aJWoH7XuJ4OZsM8zjk30JyCJy0=;
        b=BLzDPpcPhbH/jJwxz5q1L6uTHagwDAz9k8cHN52HkpLjzIIqbnp9YvzjPNiEfYH+Yo/iUE
        Sas6CLUXoQVza5LWBaH73TPSPXIBJcySlz8m8u9761f2CVZUu+tK1KTI0mdWSmUar3S2SV
        vUXrTp6z7GoqctRlDajLP6EW+iB156kjGrDxfGGYJGW3/mZBTjdkBHbp4X0BjbjRT6ZFIT
        +g6aiMc17Q2emuDNPmJ5XTVYKilY/ki+lf1jDmE0Vjg3ap0G7dHsCFw0uil5p139BZZv0q
        fjt0cjIIFkANFunSalO+dnkHmFYNAjuCbgKp6SpofvcJgEqVS8CI34dlW+Pbbw==
Date:   Mon, 4 Apr 2022 14:55:18 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org
Cc:     Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Viresh Kumar <vireshk@kernel.org>
Subject: Re: [PATCH v5 4/8] soc: renesas: rzn1-sysc: Export function to set
 dmamux
Message-ID: <20220404145518.6b427356@xps13>
In-Reply-To: <20220315191255.221473-5-miquel.raynal@bootlin.com>
References: <20220315191255.221473-1-miquel.raynal@bootlin.com>
        <20220315191255.221473-5-miquel.raynal@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello,

miquel.raynal@bootlin.com wrote on Tue, 15 Mar 2022 20:12:51 +0100:

> The dmamux register is located within the system controller.
>=20
> Without syscon, we need an extra helper in order to give write access to
> this register to a dmamux driver.
>=20
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/clk/renesas/r9a06g032-clocks.c        | 35 ++++++++++++++++++-
>  include/linux/soc/renesas/r9a06g032-sysctrl.h | 11 ++++++
>  2 files changed, 45 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/soc/renesas/r9a06g032-sysctrl.h
>=20

[...]

>  /* register/bit pairs are encoded as an uint16_t */
>  static void
>  clk_rdesc_set(struct r9a06g032_priv *clocks,
> @@ -922,6 +948,7 @@ static int __init r9a06g032_clocks_probe(struct platf=
orm_device *pdev)
>  	clocks->reg =3D of_iomap(np, 0);
>  	if (WARN_ON(!clocks->reg))
>  		return -ENOMEM;
> +

As we are post -rc1 I will repost this series as a v6 after rebasing.

While at it I'll get rid of this extra new line but that's basically
all what I plan to change.

As this series brings the basics for more RZN1 support (because of
this specific sysctrl patch), it is kind of a base for more
contributions which are in the pipe (UART, USB, RTC, Switch, etc) so
hopefully it is now ready to be accepted.

Thanks,
Miqu=C3=A8l
