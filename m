Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D19547CFBC
	for <lists+dmaengine@lfdr.de>; Wed, 22 Dec 2021 11:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239890AbhLVKK3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Dec 2021 05:10:29 -0500
Received: from mail-vk1-f175.google.com ([209.85.221.175]:40564 "EHLO
        mail-vk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbhLVKK3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Dec 2021 05:10:29 -0500
Received: by mail-vk1-f175.google.com with SMTP id 70so989253vkx.7;
        Wed, 22 Dec 2021 02:10:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MFNPNVaT4uT5sTxBbDK7W+4/2BKnEWtptYUvYSGupsA=;
        b=OSYGb5XpAIKLrjQUCyYmQFh5pZPB/ILlQV7bPLg4uMfXRZvDk75q0OYl++5KBzCVTo
         yszhx4BoM+2FkJFptbyra5LQxyJpCIF1LsV4EaU4fRDD0GS+c5WKZtUv5nfUm/n5CsiF
         K27Y1IJf6Ybg3218u6oD+aks+B42L2AZLClcxgU9rj7+AXAbEXxo7y9yLtbY8pwLVa3a
         z3B538HNx4zCoW96fnEQunDI96X9JcJ7mlvEZsS1kgbxvGnobDI0SyO3Wt9JYITeyt7x
         IzDBHGG91KDTutgQGnEBSUk6nGJu5X6XPhM8s+Sj+0KVonLriNNoWOH994DjGic+Zzdl
         mGRg==
X-Gm-Message-State: AOAM5337uifvCLATWNRDmtzzj1toB/CMTiGKL2V/QlPwjNvBpYJfalTh
        VIcOuLmZ8o/HneIQpJMTusNl7BWlgznFwg==
X-Google-Smtp-Source: ABdhPJwg7DtgtzmM+oOEQZB8B3w7xxoTEP1sHRuXCct8dE7pqzgnpSVXATg5kQ3cxTHedgByibCaKw==
X-Received: by 2002:a05:6122:2188:: with SMTP id j8mr761062vkd.11.1640167828305;
        Wed, 22 Dec 2021 02:10:28 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id n46sm185944uae.2.2021.12.22.02.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Dec 2021 02:10:28 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id p2so3207194uad.11;
        Wed, 22 Dec 2021 02:10:27 -0800 (PST)
X-Received: by 2002:a9f:22ca:: with SMTP id 68mr712218uan.78.1640167827839;
 Wed, 22 Dec 2021 02:10:27 -0800 (PST)
MIME-Version: 1.0
References: <20211221052722.597407-1-yoshihiro.shimoda.uh@renesas.com>
 <20211221052722.597407-3-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdX81Ed-U_DSTKtv074qAq0yB0DJA4YnF9XS1YfEi2zW=g@mail.gmail.com> <TY2PR01MB3692659BC6251EED054C326BD87D9@TY2PR01MB3692.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB3692659BC6251EED054C326BD87D9@TY2PR01MB3692.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 22 Dec 2021 11:10:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVb3gfsNLO4tB8nh9sWeHYJZdxd3aZGRHxSEPZGE+Qi8Q@mail.gmail.com>
Message-ID: <CAMuHMdVb3gfsNLO4tB8nh9sWeHYJZdxd3aZGRHxSEPZGE+Qi8Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] dmaengine: rcar-dmac: Add support for R-Car S4-8
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Vinod <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Shimoda-san,

On Wed, Dec 22, 2021 at 11:08 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> > From: Geert Uytterhoeven, Sent: Wednesday, December 22, 2021 6:17 PM
> > As some registers do not exist (or are not documented) on R-Car S4-8, perhaps you want to document that in the comments
> > for the register definitions, too? Fortunately none of them are used by the driver.
>
> You're correct. So, I'll modify the following code:
>
> -#define RCAR_DMACHCLR                   0x0080  /* Not on R-Car V3U */
> +#define RCAR_DMACHCLR                   0x0080  /* Not on R-Car Gen4 */
> (sorry these tabs are replaced as spaces)
>
> Also, I'll add such information in the commit description
> like below.
> -----
> Add support for R-Car S4-8. We can reuse R-Car V3U code so that
> renames variable names as "gen4".
>
> Note that some registers of R-Car V3U do not exist on R-Car S4-8,
> but none of them are used by the driver for now.
> -----
>
> Are they acceptable?

Perfect! Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
