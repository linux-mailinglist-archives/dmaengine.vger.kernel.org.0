Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70CD1E0B50
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2020 12:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389302AbgEYKEO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 May 2020 06:04:14 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42368 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389455AbgEYKEO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 May 2020 06:04:14 -0400
Received: by mail-ot1-f68.google.com with SMTP id z3so13436741otp.9;
        Mon, 25 May 2020 03:04:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v31B/+mIg8lG6wusmgij6EudDfakjKfKP1QDin7IGK8=;
        b=Csu19rx7v25A5lqYhtjHfDO88BU07dxd2V7adZ81b5Hjanc81TM2ByMCijS3hxo2fP
         sH+c648s3/vw4RpK5CXuH1Z5KlhcIXcrJJhN9Ugri+e7r64dvXbvM/pSMcGLs1YcnTl1
         sHUnDFEJcYZhQGseNkuyg71of0HojXglitsEcyvbj3AMlXDW3eUt4GsinN0FJwHQ5JfH
         eD2H5vgbtbRC+bElawBw7S2ZZdAzl7YgMmqrC2R2qwkNgkx6cqqz+QiVIPqOrX7nmEBp
         q0rogLCQsvnXXIe/b/+1r1HhpGxluUx3bcgmknTRptN8hPgAs7RzOijU1XOu+EybxKBa
         Qi0w==
X-Gm-Message-State: AOAM532uWRZ7USJdjtJimIcEVVUxJgnwQpx9RFL6Bn1OgPm+U7pKNBGi
        cBjK8gKCBlKs6C4d9OU4gsPUBOjrLGz5jKMEfCU=
X-Google-Smtp-Source: ABdhPJxj1yipEChKhdP6d90ZWYNeeJsYFcWxXurCt8Zk7oO9crkuij53NPxhS/j9MVFMnErAb1HKQpJovZTGBOXumUQ=
X-Received: by 2002:a9d:564:: with SMTP id 91mr20669630otw.250.1590401053190;
 Mon, 25 May 2020 03:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <1590356277-19993-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1590356277-19993-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1590356277-19993-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 May 2020 12:04:02 +0200
Message-ID: <CAMuHMdUXcuOWYHmSqpkrk1B=_6cRXYgsPk29FOvJz7vTqsO+9A@mail.gmail.com>
Subject: Re: [PATCH 3/8] dt-bindings: usb: renesas,usbhs: Add support for r8a7742
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, May 24, 2020 at 11:39 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Document support for RZ/G1H (R8A7742) SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
