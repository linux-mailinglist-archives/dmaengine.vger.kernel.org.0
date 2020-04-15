Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C16F1AA922
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2020 15:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636298AbgDONxN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Apr 2020 09:53:13 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34345 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2636290AbgDONxI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Apr 2020 09:53:08 -0400
Received: by mail-ot1-f65.google.com with SMTP id m2so3490885otr.1;
        Wed, 15 Apr 2020 06:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BLcFv5whL5EjTbt6b2FbQSBshbkRbokQxYkiiI7yDlo=;
        b=EstvoWp0GCOpxnHCw65gvbFVQByHzZSEDRCh6XmZOGRBYF6g5RBf/7nZf/V4ydYTVK
         v5IzjZoJ5G6rcmlIolFJs17TPSvjONs+JxKTHtQZWIIFVYkef3ZmK7dcsr+tNSppIOBf
         OvM0D9oaQriBTkStdchSp6VSTsOu78CarVIBIegKLzjigPxxWo6ZYIx+sObWn6/zNWCL
         qJYnKiOxwTvkskqRDJn5SZhkgghhbsWWI6O3NEqLlEx19byTomVOtDUISl1g6X8e/0VC
         bMjVQV5gMrDhmiP+o8+/M50s1gNiRE9n39yW87pego9dNgV/dUvRKqklMmDpuzY5V12U
         Mbug==
X-Gm-Message-State: AGi0PubEi0qkxreF0zyNMl7BKMPqTT9E270iEn1tFIes8m2QZV8eOusY
        uaNwFsRaGGwzdujkwV2Hp8VcVpejQP2FHwu+0xE=
X-Google-Smtp-Source: APiQypJ7e+qd8UvZuq2hYGRTkssWX3YA5bdATEvTb4+Avw03fyZoXFjFFBAs/hA//LhoXCPcrFtaIIdJaNMJ885/n7s=
X-Received: by 2002:a9d:76c7:: with SMTP id p7mr21888214otl.145.1586958786901;
 Wed, 15 Apr 2020 06:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <1586512923-21739-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1586512923-21739-2-git-send-email-yoshihiro.shimoda.uh@renesas.com> <CAMuHMdULExMNnKJWsjAonR1sVeTyQCH0shwO--Wo6dLzrWV_tQ@mail.gmail.com>
In-Reply-To: <CAMuHMdULExMNnKJWsjAonR1sVeTyQCH0shwO--Wo6dLzrWV_tQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 15 Apr 2020 15:52:55 +0200
Message-ID: <CAMuHMdWp8kNnZYXpp8LnKcE01OWZi2x7U29MLjQ4BTAcYJUyeQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: dma: renesas,rcar-dmac: convert bindings
 to json-schema
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Vinod <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Shimoda-san,

On Wed, Apr 15, 2020 at 3:09 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Fri, Apr 10, 2020 at 12:02 PM Yoshihiro Shimoda
> <yoshihiro.shimoda.uh@renesas.com> wrote:
> > Convert Renesas R-Car and RZ/G DMA Controller bindings
> > documentation to json-schema.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> One question below...

Sorry, I missed something at first: shouldn't "power-domains" and "resets"
be mandatory as well?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
