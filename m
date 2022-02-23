Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DEF4C1051
	for <lists+dmaengine@lfdr.de>; Wed, 23 Feb 2022 11:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239541AbiBWKcT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Feb 2022 05:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbiBWKcT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Feb 2022 05:32:19 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788F63334C;
        Wed, 23 Feb 2022 02:31:49 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4B38BC0013;
        Wed, 23 Feb 2022 10:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645612308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oOfX/YGFLaxVKjpkH4p+qXiTOuKUa8cjKBNyNjZbJTQ=;
        b=AG1g4TtzufPPwM00YdT69mP4u9h01kU7j0MiJruhBuBhrS2yeqlsaJv2dGRMJf49mfiuj0
        TKg7+362TiW7cb8hUGw7cYYZJcpilO6XBYa/s961lPZbssLVEuf0x1rQaQyuHNjIjutIwp
        4kgJdvM17MUZeXME689Ix08gHmTg2DUxe1VbfGGcF0Q6HDOV348mQ1a4dTJno1AbLxSPF9
        5gy9r48tGk3pTFgA3gA5HVTHJPIN8rjXOpEsqkxfm37JUICeas0DaELwRtpWz+27HPYWWO
        PyNhRphJj+Eiy69BfUgOAdZQHRu/lPJbO/IePdpUUXWIm3HH1CqkecfctXN9oQ==
Date:   Wed, 23 Feb 2022 11:31:43 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>
Subject: Re: [PATCH v2 4/8] dma: dmamux: Introduce RZN1 DMA router support
Message-ID: <20220223113143.132c3f98@xps13>
In-Reply-To: <20220222103437.194779-5-miquel.raynal@bootlin.com>
References: <20220222103437.194779-1-miquel.raynal@bootlin.com>
        <20220222103437.194779-5-miquel.raynal@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


[...]

> +static int rzn1_dmamux_init(void)
> +{
> +	return platform_driver_register(&rzn1_dmamux_driver);
> +}
> +arch_initcall(rzn1_dmamux_init);

I don't think this driver actually needs the arch_initcall() level,
I'll propose a v3 using the regular platform init level.

And this driver is now missing MODULE_* macros.

Thanks,
Miqu=C3=A8l
