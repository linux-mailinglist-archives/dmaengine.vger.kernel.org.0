Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09FA395600
	for <lists+dmaengine@lfdr.de>; Mon, 31 May 2021 09:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhEaHZY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 May 2021 03:25:24 -0400
Received: from mail-vs1-f54.google.com ([209.85.217.54]:37887 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhEaHZX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 May 2021 03:25:23 -0400
Received: by mail-vs1-f54.google.com with SMTP id s15so5564882vsi.4;
        Mon, 31 May 2021 00:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yCQkAamaqjzLvYlJjCOp6ATLrw+uII+84I0DAql6qao=;
        b=I0mp7wLdffOtLyPYNA1Yzr5makkrsAl6KlvblaJ/tyHpz1szQaFRdpGtpT+1RagC07
         tgJSHuuzl1C0MVRqeiEVk5vdJA1Lq2MWepVYI7bd4x0KzKhHsAv8urDr33/5usUxF1ZT
         SqwSf0Qqs33f92AHl6pHH3dBv7EWED5j2iKzoHZ1Ooztki2oorRkuij5bVBYyBUImDA3
         F+duYMqdfG0tbid6c1ORi2+f5p281kgbSFcNNvZ6wf8GuIooYlEySq4U0FT/dshsGG9W
         oymdM9iO60NHg5O09nUyYQ/JWlrTrtfb6tcrvgRh7XSXObILzJgY+oza4Myl89etHUp1
         RBog==
X-Gm-Message-State: AOAM532swbXjbyknLvGK43WTLcqWyM4ievGbWrnqRzRp3CYL597sSSQi
        0GwdNIhbxf31LtuJQ/7ryqWwfPLFiqukki0Q2MzeGaHT
X-Google-Smtp-Source: ABdhPJwisAqGQ1fkkuGH584QMhvbukZjzC0A91o+9LsKTto8IcyOAx6K18991priyM55NMhUMZ9aQGIKkExwtmvjbbk=
X-Received: by 2002:a67:fb8c:: with SMTP id n12mr1679834vsr.18.1622445823003;
 Mon, 31 May 2021 00:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <1622442963-54095-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1622442963-54095-1-git-send-email-zou_wei@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 31 May 2021 09:23:31 +0200
Message-ID: <CAMuHMdV4fHpdm9tBMetde0ngRr8AuzcZ1sRFyFVKWCVg9TfspQ@mail.gmail.com>
Subject: Re: [PATCH -next] dmaengine: rcar-dmac: Fix PM reference leak in rcar_dmac_probe()
To:     Zou Wei <zou_wei@huawei.com>
Cc:     Vinod <vkoul@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Robin Murphy <robin.murphy@arm.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, May 31, 2021 at 8:17 AM Zou Wei <zou_wei@huawei.com> wrote:
> pm_runtime_get_sync will increment pm usage counter even it failed.
> Forgetting to putting operation will result in reference leak here.
> Fix it by replacing it with pm_runtime_resume_and_get to keep usage
> counter balanced.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
