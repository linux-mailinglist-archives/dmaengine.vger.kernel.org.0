Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9FFCD10DB
	for <lists+dmaengine@lfdr.de>; Wed,  9 Oct 2019 16:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731384AbfJIOH3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Oct 2019 10:07:29 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36576 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731291AbfJIOH3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 9 Oct 2019 10:07:29 -0400
Received: by mail-ot1-f66.google.com with SMTP id 67so1827038oto.3;
        Wed, 09 Oct 2019 07:07:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xoqu4/6gzZJfqydmLWCZZExTM+Z/HHchEI/c3BMPIcY=;
        b=T/mfS4YAhhPvuePxJ6MIJOcbml47SI6B5hvCOOLVEdt+DFDJO1PHQ0q047P//wVQKC
         rXsR0Hextecd6M7RP0EiWHlv/E45lpCuAAdrOY5X8abxrZFyAqIUB+N1vXJr0+yMYqGm
         0zSocij5OnAFpz5DCvTY6AGVSd/GJUEXn/O0l1Gt6KkJ0g9lCNXeKY2MikxaqNqV6CKR
         UwGPEhbCpdvOsk53BNCDQ0455AV1fESSjyDh0uujWJOpTKESIBp6F8/LSf9UmtDLU/0U
         dEW3FGbf6xA2B+2WJsxWejL5ZQy5rmHAVpbmcBk2KZ6P1xMPBCDms0ZHnG5Am839nJyw
         z9Fw==
X-Gm-Message-State: APjAAAWDOBNUSdM4ji4yctZcJ00mJ9AGKCDHn6k6X3r/4FFSkc4QCZLA
        LqQFBCw7YVeqazeIcJ+EJFG3pClb8NU3LtIROvc=
X-Google-Smtp-Source: APXvYqxG9nKgXLSoFI7/giibY8i89eFKiPK6JRXt8GaE/1srOdt2enUGLSmmEHLF6Cfzpg5dHk5/eRRLlvpTtbTZ5ZA=
X-Received: by 2002:a05:6830:1b75:: with SMTP id d21mr3034304ote.145.1570630048241;
 Wed, 09 Oct 2019 07:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <1570531132-21856-1-git-send-email-fabrizio.castro@bp.renesas.com> <1570531132-21856-8-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1570531132-21856-8-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Oct 2019 16:07:17 +0200
Message-ID: <CAMuHMdV8+Rsb53dsMEoRMk3Oj7yEqbhJ7CTNz-Z90ZZaBkZV8Q@mail.gmail.com>
Subject: Re: [PATCH 07/10] arm64: dts: renesas: r8a774b1: Add USB2.0 phy and
 host (EHCI/OHCI) device nodes
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
> Add USB2.0 phy and host (EHCI/OHCI) device nodes on RZ/G2N SoC dtsi.
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
