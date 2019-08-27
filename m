Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54B3A9E8B2
	for <lists+dmaengine@lfdr.de>; Tue, 27 Aug 2019 15:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfH0NKW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Aug 2019 09:10:22 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46883 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfH0NKW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 27 Aug 2019 09:10:22 -0400
Received: by mail-ot1-f67.google.com with SMTP id z17so18529165otk.13;
        Tue, 27 Aug 2019 06:10:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZjjAPvtdqQ+MMrsYJ6BeBqmBME1FqNF62Ndm29euJTo=;
        b=c5IhBxuj8D4WHr0xM9Ift5qJet46JBFPWeYdzSkIypJ+8Wi74HqybhUFdeWP/PdHLv
         yG8rQuem9fViD3ZJ28TW8tXHFZoEKPymFeljayQcPluwxGBl5Aba6AVjE2sfLtvn1+Zg
         2yoBFanjpp1n5y0IzybI3LOSHwK/wxDxbxDAycl1UNiOi382MhRp8MJlFtpiqzsEC96s
         sUv/6LCQ5wOgTD2fiKECJTGwMWoTWHFfa8S4wGxZSFrYWve9PqpQRYEYMDIkAlPd/D86
         DeI+nzqcIk4OIZ4S020NvTjMw+XUp9lLJjJiBbmVGEd2IHE6hpJKNCXXXMEB8rmfKo+n
         Z5Ww==
X-Gm-Message-State: APjAAAWadgPaaKKiXbGvddIdizI/hrWKZgtB/YcvuFHSgVCL9KkjeVsI
        uN9dQS7WuOE+7DQZOj4Amcb2auNHOfZTEoQBBlA=
X-Google-Smtp-Source: APXvYqxxorPvdJkb0OYGcB8cDQpUM9GTTbQnlWyPbX+CoDrY92tiMZlXxjhJqBfkXYglPYdRQjKUGGSR3hir9V/tIdM=
X-Received: by 2002:a9d:68c5:: with SMTP id i5mr4722119oto.250.1566911421346;
 Tue, 27 Aug 2019 06:10:21 -0700 (PDT)
MIME-Version: 1.0
References: <1566904231-25486-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1566904231-25486-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1566904231-25486-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 27 Aug 2019 15:10:10 +0200
Message-ID: <CAMuHMdU29C1KKzave72s6gTZH8VgkzGnFGcfZ6rFJaREdUAcRA@mail.gmail.com>
Subject: Re: [PATCH 2/2] dmaengine: rcar-dmac: Use devm_platform_ioremap_resource()
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Vinod <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Aug 27, 2019 at 1:12 PM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> This patch uses devm_platform_ioremap_resource() instead of
> using platform_get_resource() and devm_ioremap_resource() together
> to simplify.
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
