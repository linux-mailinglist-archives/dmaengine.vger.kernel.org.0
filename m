Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082031BFE2F
	for <lists+dmaengine@lfdr.de>; Thu, 30 Apr 2020 16:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgD3O1y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Apr 2020 10:27:54 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40803 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbgD3O1y (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Apr 2020 10:27:54 -0400
Received: by mail-qk1-f194.google.com with SMTP id l78so5851460qke.7;
        Thu, 30 Apr 2020 07:27:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O/0HPBsHNU1Zz63ikLSaiq1tEsUfgo674JZFS5/Kd2o=;
        b=uBtuzKpeFF8JpOG5cdUp4saRLGn1bxt4ywT1Fnfcl+F6ZFHI6g8Go0hMHDlgRH+EAr
         kTLoYyzkjcO6DlQrj9Wdc0oC6vews6BcvI5DKQac8LEJGt6FNGaucWjo9lbMdIRqjcms
         fnCrZo6nwNLL8/RB8/7RF+LbnV0cYK178eLTZNTd4JpGvPVYcfGy5zGRw1QJc4zp02v+
         IXuayvyCLUT6QWOABTcbeSJmy2Y/q3pXR9tVXj0PO9hdJm50VjybRDdTM4lIbBFJnajX
         y+aWD2OxzthVoaW1te6/X2L/NMOAxz7ucW7z3AneGA1w0K0w3lq+8ASFVr/WdkGrjKMO
         GLMA==
X-Gm-Message-State: AGi0PuZ5oaXAOXe+6XvJWCTjlJ2r+ArfUKSxkKYDvOu1Cad0XIWrxibW
        oVmdmrm5gwQGVqguEc3z3JtSNrEfd0ttSV4G+3AVgWOM
X-Google-Smtp-Source: APiQypJ0wnfqNBtvV5DRJQ7B2RPuH0aK38BLyizTr8I4v1YozRfr0aHWKl2U/Ir3VfckqinVYAjVYSuNmzb4FyxwrlE=
X-Received: by 2002:a37:a212:: with SMTP id l18mr3494398qke.428.1588256872560;
 Thu, 30 Apr 2020 07:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <1588197415-13747-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588197415-13747-17-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1588197415-13747-17-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Apr 2020 16:27:40 +0200
Message-ID: <CAMuHMdX=Y49D+zP4-6oxsu7c1gsMbQC-Wb34uJqrPmxRxZp7JA@mail.gmail.com>
Subject: Re: [PATCH 16/18] ARM: dts: r8a7742: Add [H]SCIF{A|B} support
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Apr 29, 2020 at 11:58 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Describe [H]SCIF{|A|B} ports in the R8A7742 device tree.
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
