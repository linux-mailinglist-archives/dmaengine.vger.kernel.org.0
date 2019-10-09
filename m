Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEB4D119B
	for <lists+dmaengine@lfdr.de>; Wed,  9 Oct 2019 16:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731290AbfJIOnI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Oct 2019 10:43:08 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42965 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731133AbfJIOnI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 9 Oct 2019 10:43:08 -0400
Received: by mail-ot1-f66.google.com with SMTP id c10so1917075otd.9;
        Wed, 09 Oct 2019 07:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yOIw38zD/ngNIg+xiz6Rbo3Jdwlcuf3nU+5nbTT8sV0=;
        b=borU7pg/yY7wtYipu5Oq8+zMUmREUzW0w29JTbrIek4Hb20hPKiSrGcPwa2V14Qjum
         oYRAidRZF2a7AlQpm8GkoquqgKLL6pLHfIkZTNtD4vkE/39sO7NhxpYn+HfEXJnIDQ1A
         BxYabMa+fSRpnlDJ3y8hnqgbSzDTevwCHXMocr3UvYD6oAirjpWOKSOEHEiqzv5ZvKSX
         sJf3H6sEDaKaCDoDbB+uccM16trZUh+J4Fj9HGjmag+SiR2nLgHF0/55WSbFHfA4Nv13
         wunZSKQKDeOF1wHK4NdKguHQsTZtWpdLPNyId2qACcXau1/bm1pmw1b9zPdZMQcQiykM
         kodA==
X-Gm-Message-State: APjAAAVUh4sM3Z6LqLbyts+7jmdrRqI2NPgVw8fRol0v80l0zg1YFonA
        yzYlx+xoX2v61LM276ATbDsMqJUpYR03D0FhG2Y=
X-Google-Smtp-Source: APXvYqxft/u7/XRb6nPeiCWFxPpaJowaExImgMdOt4nCer4aDN+X7hyxDQILaidnjOoe0WuTCqJnO3OSvFCZ8bO3zVk=
X-Received: by 2002:a05:6830:1b75:: with SMTP id d21mr3231975ote.145.1570632187381;
 Wed, 09 Oct 2019 07:43:07 -0700 (PDT)
MIME-Version: 1.0
References: <1570531132-21856-1-git-send-email-fabrizio.castro@bp.renesas.com> <1570531132-21856-11-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1570531132-21856-11-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Oct 2019 16:42:56 +0200
Message-ID: <CAMuHMdVSqWMqTq3wS43jX5bi+RhjzfH8CEJpTz5JySUUxq_DfA@mail.gmail.com>
Subject: Re: [PATCH 10/10] arm64: dts: renesas: r8a774b1: Add INTC-EX device node
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Simon Horman <horms@verge.net.au>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>, dmaengine@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Oct 8, 2019 at 12:39 PM Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> Add support for the Interrupt Controller for External Devices
> (INTC-EX) on RZ/G2N.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.5.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
