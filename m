Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C973E2D415D
	for <lists+dmaengine@lfdr.de>; Wed,  9 Dec 2020 12:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730928AbgLILt0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Dec 2020 06:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730926AbgLILt0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 9 Dec 2020 06:49:26 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCCEC061793
        for <dmaengine@vger.kernel.org>; Wed,  9 Dec 2020 03:48:45 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id d9so1336947iob.6
        for <dmaengine@vger.kernel.org>; Wed, 09 Dec 2020 03:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j3uGWJhYTw6GKZHD8wfKlSNKe6wdrtYdPYkKgKUgxgg=;
        b=06+rhWd8+y6iJvjo/+iWgqONBMCsCjSjihXULqFxCdI19FRSFOE1qKqDyNI8Py53HG
         x75OopikQdvCY0j75xpQhzRPu6xxO9SbOTXqDwZOBF2F5zhHfSy1TE6N+PZl82GJp6N0
         OlrM1Z2dWgOu9xL/Qc8w2WJQ2os624p0Wcfopz0R4O7uxrOFRX26z0S4U95Y21kP/1c7
         aSQ0quwz7yJMMoWIWsXn4SW75CAGDVQENl3/dfcr3Vw6CCoASlPMUbY1kKEVD9mZtsYe
         nhg5QymztkxgSfizfVJPUWcNih7BRHPPQh1ZZAr+3oncmj6CaKJrLu8Rmddc6m8z5eTa
         QcvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j3uGWJhYTw6GKZHD8wfKlSNKe6wdrtYdPYkKgKUgxgg=;
        b=rj1XQQO7MK+ya8JINOj8P8D0ZHPh5worgDvmEwXMSsWRsBS3Iadh94mraBocWDJZMg
         A2vzp1+gGkR0bTNv4K3HvMeB5NO95lkdpjv2fK5flNxBqtzXu4Ff0bb44GfEyn/P4wHm
         JW5P6CwNNzUVZWXKrY8XqoQsFZjb7RHcJwoHHTooBUk/ljHmu3HdcJX8INf16iTyomNl
         RRH8PzIxAHfC+nJs9A923poOXGxmfsftNPZjx/WZIif74W4yr6wskNQJueFpVisntUl7
         z7pq5YetSPBmCeTUtbMz/L4dudZ6EKbJxE4vOWL80ERxvSCtXU0e7jcr8GI3xGYUkhSQ
         hcsQ==
X-Gm-Message-State: AOAM531FkfcIG8HLzS8Il+T/WL+HxI2rf7nY6N0ec9ZLXemvGkqxDx3p
        D5hjZf20RV4Vr1m6eYHeEsNOHyYFT39X+KFbABC2wQ==
X-Google-Smtp-Source: ABdhPJwbQYL5n5RxpdrD8qygMiWe+C20JC4G4yrDR2T5YkOM/MbdAUfZY6za7jqeE7Dk8OtDbfD6reyrXup+NvBRUpw=
X-Received: by 2002:a02:6557:: with SMTP id u84mr2532784jab.82.1607514525257;
 Wed, 09 Dec 2020 03:48:45 -0800 (PST)
MIME-Version: 1.0
References: <20201209114440.62950-1-fparent@baylibre.com>
In-Reply-To: <20201209114440.62950-1-fparent@baylibre.com>
From:   Fabien Parent <fparent@baylibre.com>
Date:   Wed, 9 Dec 2020 12:48:34 +0100
Message-ID: <CAOwMV_xMfSV9+zTZzUgB5XYNZR0ed8J=H9G39++bBJNWiR_Ehg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v2_1=2F2=5D_=F0=9F=93=A4_dt=2Dbindings=3A_dma=3A_mtk=2Dapdma=3A?=
        =?UTF-8?Q?_add_bindings_for_MT8516_SOC?=
To:     Sean Wang <sean.wang@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, dmaengine@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Sorry, resending without the unicode symbol in the title

On Wed, Dec 9, 2020 at 12:44 PM Fabien Parent <fparent@baylibre.com> wrote:
>
> Add bindings to APDMA for MT8516 SoC. MT8516 is compatible with MT6577.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>
> V2: no change
>
>  Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt b/Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt
> index 2117db0ce4f2..fef9c1eeb264 100644
> --- a/Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt
> +++ b/Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt
> @@ -4,6 +4,7 @@ Required properties:
>  - compatible should contain:
>    * "mediatek,mt2712-uart-dma" for MT2712 compatible APDMA
>    * "mediatek,mt6577-uart-dma" for MT6577 and all of the above
> +  * "mediatek,mt8516-uart-dma", "mediatek,mt6577" for MT8516 SoC
>
>  - reg: The base address of the APDMA register bank.
>
> --
> 2.29.2
>
