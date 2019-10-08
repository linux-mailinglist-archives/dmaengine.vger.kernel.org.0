Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E09CBCF8BD
	for <lists+dmaengine@lfdr.de>; Tue,  8 Oct 2019 13:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730683AbfJHLmy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Oct 2019 07:42:54 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42836 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730118AbfJHLmx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 8 Oct 2019 07:42:53 -0400
Received: by mail-oi1-f194.google.com with SMTP id i185so14447664oif.9;
        Tue, 08 Oct 2019 04:42:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rWU50A1ftSfnXS5t6he0dr7vBuFC5vEUJUAdKOgY8bw=;
        b=CN9t7YfAc0vWJIDXMZTaDRZQTh76TPp4qTdZD4q6reYI5nrtM2KkzO3bkJX9EGgdnN
         gvHwRVL/CCevZiKCAzhu8V6gXArCwrJycQnANMX7JiVdMtgQrKMb3Mhc+38uxEImGhYz
         iqiUFb8nIWlvmDI2bexaxD1nP4Q9pbhYeNNtpCzvFpBhO6yQd5LaXXbhb/C5teesnPaW
         mLfIRCY9BThKjnbEkGOvqGGnaC2p7ZK5AbjyUpIu1FTNOUaM+r99yE8Bi4GoO9450Har
         cpvTD8ev8bAO/AGpUHQSrJSv8oA7xZno95O3zT2H7bxjyoMa/hhbvX9V8N7oR6UnycVt
         YoqQ==
X-Gm-Message-State: APjAAAU7MAeL8yAD8LVEIOCzku3sG88fOI1ivYkE1QPFT23J8dUu7jHw
        bR0+F71zeYWYbVnY0eMEitovInlB81HAtE/DjYU=
X-Google-Smtp-Source: APXvYqyCiews/tKA57sXvPG5XvGEr37Qd8csRkV55q3J6cezMVTk15zb8MhXvmopRDNPJSrIQDtYqNfHP9ZJEaZ2Qus=
X-Received: by 2002:aca:4bd2:: with SMTP id y201mr3663250oia.102.1570534973087;
 Tue, 08 Oct 2019 04:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <1570531132-21856-1-git-send-email-fabrizio.castro@bp.renesas.com> <1570531132-21856-7-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1570531132-21856-7-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Oct 2019 13:42:41 +0200
Message-ID: <CAMuHMdX5hkZ7kLRiA_NRrBziFsrZNgZX-cEiE+bAaubkMdX=1A@mail.gmail.com>
Subject: Re: [PATCH 06/10] dt-bindings: usb: renesas_usb3: Document r8a774b1 support
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
