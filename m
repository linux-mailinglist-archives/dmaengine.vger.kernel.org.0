Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5399CCF894
	for <lists+dmaengine@lfdr.de>; Tue,  8 Oct 2019 13:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730731AbfJHLgl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Oct 2019 07:36:41 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39718 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730631AbfJHLgl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 8 Oct 2019 07:36:41 -0400
Received: by mail-ot1-f65.google.com with SMTP id s22so13702920otr.6;
        Tue, 08 Oct 2019 04:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rWU50A1ftSfnXS5t6he0dr7vBuFC5vEUJUAdKOgY8bw=;
        b=gP9IM6l6V6qKOfuktxpG0VRlaXArt61lORsvVGnbVT++lkPctXP0dWCpDERiMFUUmc
         cjFyCNXrGB0vVSfF++qlezXiacav5QqZuKW6KdUdGxm3mQTzNdfxGf1FmBsdpG7+iI4M
         zFs/IcQ6vfl3LaQG/+d/qjBIpKpUq7O9SN/SCjKB+bKhSm1t+u3jKuBBHDfsHTxRg4vl
         lfcSTuAONvBaQGTNvQa/IlE2TbN+CQlllr0nGRAebOUP+AXdFtN1G+vL+ERPIgXUFRtp
         u9r0LeA6LJ79/lhYxsk5EOsyMr88Kmi7+98K1tYxa5bg3ROiP0C7o9blWgylrJ6q/mr9
         za2Q==
X-Gm-Message-State: APjAAAWPxEKQEZGFMKrNNr5qneKJkNiDTuExMPOg+k1oiwTlrBrnESql
        rF/waHFfc8PFDEHFPQx5Q7frMwsc5hUqRwKrw6k=
X-Google-Smtp-Source: APXvYqwOO5BS1K03L9uNR/miBqU63vEKiq23BoSUvbF63agtYSvu+oyojKsPD8km90+OaPp+oi4YlXVQvWCX4HWrRxM=
X-Received: by 2002:a9d:404d:: with SMTP id o13mr15570285oti.39.1570534599950;
 Tue, 08 Oct 2019 04:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <1570531132-21856-1-git-send-email-fabrizio.castro@bp.renesas.com> <1570531132-21856-5-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1570531132-21856-5-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Oct 2019 13:36:26 +0200
Message-ID: <CAMuHMdVUV2=RE4BmF94_bZfg_JoiU_JFPAguVqQWjAzwydRUbA@mail.gmail.com>
Subject: Re: [PATCH 04/10] dt-bindings: rcar-gen3-phy-usb3: Add r8a774b1 support
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
