Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB63CF86C
	for <lists+dmaengine@lfdr.de>; Tue,  8 Oct 2019 13:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730866AbfJHLed (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Oct 2019 07:34:33 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37615 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730317AbfJHLec (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 8 Oct 2019 07:34:32 -0400
Received: by mail-oi1-f194.google.com with SMTP id i16so14470589oie.4;
        Tue, 08 Oct 2019 04:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rWU50A1ftSfnXS5t6he0dr7vBuFC5vEUJUAdKOgY8bw=;
        b=N527jT4PgHTmlvHAVhCNHtZNL738nc/OGDDOsUN8frAJui2iRa5Ppc1CNAsXjx9VyR
         8696sO7bTM3oVRV9yADjmUpkmBYBNWpXuJJL21tkRgsiq385hvblWNFggoXQRTBrqtJH
         ACyMAYy8BmaTEqEAWb01vhSx9pRwlzlYoZhxwqHXuJEYpbRHkcGGGwyeqthxjO8ftYz9
         zsldRXpo75NK4CQ38MdGem7yuys70bfHqSn+VdJ2K/WYsg1KbesP1taYL2gJICDbyxnO
         8chJ8nSsCPzERIeA2aRpIzCpngdUCHR4MqVlLEfxXG4W6D5aVVyfLFLPAMsunG8HXtJP
         FRxQ==
X-Gm-Message-State: APjAAAWr9MtuF4U0g1yMWswyt9oe1KNX8MjyFqG9HKuYwngnPex7955A
        CX0mqtuJder2U8E4QiOEROmV6mUa8zYy+LBB7Gw=
X-Google-Smtp-Source: APXvYqwAPA2l7U6mPkupJHpYJrzDgXDrTLl3jL3YFnacDYrvezNetIgkQYwcj5GZ7SdPtESzr+7ZY8OXFr4We2D5N+s=
X-Received: by 2002:aca:f305:: with SMTP id r5mr3342982oih.131.1570534471508;
 Tue, 08 Oct 2019 04:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <1570531132-21856-1-git-send-email-fabrizio.castro@bp.renesas.com> <1570531132-21856-4-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1570531132-21856-4-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Oct 2019 13:34:20 +0200
Message-ID: <CAMuHMdVGcsVZoJdqaYHVYi4XHkUT24ryRBFo6cXmJ+zfYF69DQ@mail.gmail.com>
Subject: Re: [PATCH 03/10] dt-bindings: usb: renesas_usbhs: Add r8a774b1 support
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>,
        Vinod Koul <vkoul@kernel.org>,
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
> Document RZ/G2N (R8A774B1) SoC bindings.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
