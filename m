Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36C3B143987
	for <lists+dmaengine@lfdr.de>; Tue, 21 Jan 2020 10:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgAUJd5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Jan 2020 04:33:57 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45102 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbgAUJd5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 21 Jan 2020 04:33:57 -0500
Received: by mail-ot1-f68.google.com with SMTP id 59so2300193otp.12;
        Tue, 21 Jan 2020 01:33:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qj5VbwsxDuvi6Lzh2JzA8IRCPYG3njmnwC8KpSoN7Fo=;
        b=Q9ddjvG4F10/oPJhrPZSLZPl6xpzubsP5a8MauU8U0mMqPWquJJzUAabI9Gl3b6rL6
         VCPEgd+xdTbYILya/UjEreEu1bXHZMZzWq2k0/vMxEOstyNG1hmY4DNgPzwtstZxKBae
         gacOGmoHEevTWHZsU3ed1U+9UlkjdUmfBRa5M69t5XEZ7FDiLNDME5VaZ2N6/3bNLwaE
         nNyVVzckUOZ6pLkpnDREzzpZIAiSUu8FzqVsTC/zqrPvsMWMZIUyKtR09BNXJQRWGL5A
         ZS56toNZyLztXImgxOP/jRi1NBgUfPgIkSCizYvkJDdQiiF50XNUhX+NZTWEsNIZ0a4w
         yyqA==
X-Gm-Message-State: APjAAAVRYtFmDCsBBdA27Lq6xXIES/c+Ayavn98j4Em3bOVLKGtwwHYP
        7H1VgBT2JIFor5ZeXSsf8zCtlGAn0AJUZ8lZHr4=
X-Google-Smtp-Source: APXvYqxhBfAirvha1jNyHcG9Wj357aKqFNFvum/Vm4ne3rqK1ZgfHgEvQ8rv4ewYeH7Yc9GdPstY3m6KPf+b0CnOlwk=
X-Received: by 2002:a9d:dc1:: with SMTP id 59mr2869459ots.250.1579599236621;
 Tue, 21 Jan 2020 01:33:56 -0800 (PST)
MIME-Version: 1.0
References: <20200117152933.31175-1-geert+renesas@glider.be> <20200121092303.GI2841@vkoul-mobl>
In-Reply-To: <20200121092303.GI2841@vkoul-mobl>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 21 Jan 2020 10:33:45 +0100
Message-ID: <CAMuHMdW39YMNixAkCKZexE2QZNxy5HoMGNtMGtRJ5n5rR-3FHA@mail.gmail.com>
Subject: Re: [PATCH 0/3] dmaengine: Miscellaneous cleanups
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matt Porter <mporter@konsulko.com>,
        Arnd Bergmann <arnd@arndb.de>, dmaengine@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On Tue, Jan 21, 2020 at 10:23 AM Vinod Koul <vkoul@kernel.org> wrote:
> On 17-01-20, 16:29, Geert Uytterhoeven wrote:
> > This patch series contains a few miscellaneous cleanups for the DMA
> > engine code and API.
>
> This looks good, thanks for the cleanup. But it fails to apply, can you
> please rebase and resend

Done.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
