Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E364F17CE
	for <lists+dmaengine@lfdr.de>; Mon,  4 Apr 2022 17:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378366AbiDDPDo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 4 Apr 2022 11:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378363AbiDDPDm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 4 Apr 2022 11:03:42 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6FC2F3A4;
        Mon,  4 Apr 2022 08:01:35 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 906E4240017;
        Mon,  4 Apr 2022 15:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649084494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oSz9CbmyqFYj7WTtWZFGNmlwynE09FntzIRYQ161JtE=;
        b=JpRUcx41T6mUPb3+9eobnQYBoR5+IieSvJsMpRY7Ryr9F4Q+33G8GaGaxT5unTjr8izY0S
        vlp/LX+OfanFkUThDoRaNF4wiybPsyQA0JMD1UOTwEmQ9PzU2Eerg/4gvkEB3ws1WDBWhc
        1YPMrhUuadRTXj3LrT6QAOysvTSUnEGBBZJIjMJ/tp7WOK7XxPFVpY/jdgxxW+ISug7lez
        hwrv+7WArBEa9DgpF00m+WE1a/63a6j1YHLE1qiIayRt7GqZp59IelnMStimWpetbw1LcL
        Nvi2AixApHxwFUyyq44PahYoosRTyuwyh+k7lVva0DtxqR6+7GjvesGjFRayMw==
Date:   Mon, 4 Apr 2022 17:01:29 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
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
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v6 0/8] RZN1 DMA support
Message-ID: <20220404170129.42a0924d@xps13>
In-Reply-To: <CAMuHMdWS0ABggEuyqjzuX1Jp306p6FOj_uvPuHW1Z63Ov551+Q@mail.gmail.com>
References: <20220404133904.1296258-1-miquel.raynal@bootlin.com>
        <CAMuHMdWS0ABggEuyqjzuX1Jp306p6FOj_uvPuHW1Z63Ov551+Q@mail.gmail.com>
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

Hi Geert,

geert@linux-m68k.org wrote on Mon, 4 Apr 2022 16:48:58 +0200:

> Hi Miquel,
>=20
> On Mon, Apr 4, 2022 at 3:39 PM Miquel Raynal <miquel.raynal@bootlin.com> =
wrote:
> > Here is a first series bringing DMA support to RZN1 platforms. Soon a
> > second series will come with changes made to the UART controller
> > driver, in order to interact with the RZN1 DMA controller.
> >
> > Stephen acked the sysctrl patch (in the clk driver) but somehow I feel
> > like it would be good to have this patch applied on both sides
> > (dmaengine and clk) because more changes will depend on the addition of
> > this helper, that are not related to DMA at all. I'll let you folks
> > figure out what is best.
> >
> > Cheers,
> > Miqu=C3=A8l
> >
> > Changes in v6:
> > * Added Stephen's acks. =20
>=20
> Looks like you forgot to add the ack?

Mmmh .____.

I have several series queued and I did apply Stephen's tag to
the wrong patch without noticing. Kudos for catching this. I will send
an updated version with it and Ilpo's comment addressed later this week.
In the mean time if there is anything else, let me know.

Thanks,
Miqu=C3=A8l
