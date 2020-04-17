Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13FCA1AD862
	for <lists+dmaengine@lfdr.de>; Fri, 17 Apr 2020 10:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729664AbgDQIQG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Apr 2020 04:16:06 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37674 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729607AbgDQIQF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Apr 2020 04:16:05 -0400
Received: by mail-oi1-f194.google.com with SMTP id r25so1424909oij.4;
        Fri, 17 Apr 2020 01:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OEUqvO4o4PLcUzctH8y/pHIipYkwHBkxh0sUSwqBhjI=;
        b=KVj96e/tfUheE6ARFM2bfYhbgfdhQLyr25P7ursPxPh6duAI2Vj1fbe6WWoSlqesRr
         +VFQKFsTo9YKte6u2iDsBv1fJyRmO1M0nsgPLXNng9kCRS9cfbBvnldfLDzDn6xbFNEu
         LJOun/DkA/wpUZltpaorii2r48YVFOUO6ddcjrd7aV/5ZeoeHmGRvdF7y/mxrnpkAsgT
         N8iFiUp+5AgM98Y9kOFEehKV1ZsIl1csRuwqpxR5WA/QBRKYeUcir5YMb4arC98R8vmW
         H8CJYjv52HzqiAy8j+xT01w4PHPoktT+nMYew8Uyay0XKb0MSoQ8uDnbFcARe2y5GJ0p
         D4DA==
X-Gm-Message-State: AGi0PuZNLzDMWluiW1G7FuPyIHg2aIRvYKEgNL8jHWkjUnA3SFEJGDRd
        e8d6twUqesuEeYouwY3jIqvlcbpHmvZax++9b5bgNQ==
X-Google-Smtp-Source: APiQypLgb84lCmEkROwoYQwqq0y4HCBdGz8GOcxZq+P0iQq/kE0BDjlAwm2ypBVTzGYMRyxhyaIzk+3QcIX+GqraTH0=
X-Received: by 2002:aca:cdd1:: with SMTP id d200mr1278264oig.153.1587111363675;
 Fri, 17 Apr 2020 01:16:03 -0700 (PDT)
MIME-Version: 1.0
References: <1587110829-26609-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1587110829-26609-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1587110829-26609-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 17 Apr 2020 10:15:52 +0200
Message-ID: <CAMuHMdX3sPAfKooRQcNBph6OWg=7OQ0g33PCTBpLRkqu5YcP-A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: dma: renesas,usb-dmac: convert
 bindings to json-schema
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

On Fri, Apr 17, 2020 at 10:08 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Convert Renesas R-Car USB-DMA Controller bindings documentation
> to json-schema.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
