Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7D7CF846
	for <lists+dmaengine@lfdr.de>; Tue,  8 Oct 2019 13:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbfJHLcz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Oct 2019 07:32:55 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33924 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730156AbfJHLcz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 8 Oct 2019 07:32:55 -0400
Received: by mail-ot1-f65.google.com with SMTP id m19so13752895otp.1;
        Tue, 08 Oct 2019 04:32:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X/P4A34kBWltit617HgU9BCptX8N7U/u6oSp9tuhsww=;
        b=JP7YPc7eT6xQ6ck0G+DAbgxNob/xhbTbFLe+4zOsFMlL+8h5pm3+Es7g9xdUY39/Oz
         cAo08tHYGKA9+8g8KuWmWzaIEIL09oCiIK8HxwO788kw55sb++QjjS4XmvW0RPj1IDKi
         dpgFfkrpQ0RlprPqoTtqnnRXfbObL+D8bzCLA7A16KqiLwOx2EIzBnR+g088Uixo2Kwn
         2VVm1EirYPHe4redtNgV6n0BC1o1GvXrnDjvTWlgV3ukFFR+oe/Ft44iS/Y2aFNoe9aT
         59RUT1pP/y4P7NYDdBHGvoJCaPadroPCYNJZPdJXnWF+vPNRbNzbbXiEvSRd1xzt4QtV
         YPQw==
X-Gm-Message-State: APjAAAXsAHPvbDxOu+YGRBsbXquuwdRfu/2XFsM0q2Cz6APd1G3vz7lY
        U+cM5pR35CZJ+XulkfHH4jsr2MuWhprRNkWRxmA=
X-Google-Smtp-Source: APXvYqz93Kf3dVVQ1pD17nYMR7M0+TJGZ+RyWjaEPoiOqoprx/G7pBNyusN7HY7F4713UaL1ro4MlzqU5ZzEiQNFxQk=
X-Received: by 2002:a9d:7311:: with SMTP id e17mr23509246otk.107.1570534372603;
 Tue, 08 Oct 2019 04:32:52 -0700 (PDT)
MIME-Version: 1.0
References: <1570531132-21856-1-git-send-email-fabrizio.castro@bp.renesas.com> <1570531132-21856-3-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1570531132-21856-3-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Oct 2019 13:32:41 +0200
Message-ID: <CAMuHMdVgkmrDmTwZQksy_qfkk6kmshnTwCMeYXBpKb0Nk_PKLg@mail.gmail.com>
Subject: Re: [PATCH 02/10] dt-bindings: dmaengine: usb-dmac: Add binding for r8a774b1
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
> This patch adds the binding for r8a774b1 SoC (RZ/G2N).
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
