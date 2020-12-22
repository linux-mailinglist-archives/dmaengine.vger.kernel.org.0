Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430F22E0D77
	for <lists+dmaengine@lfdr.de>; Tue, 22 Dec 2020 17:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgLVQkq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Dec 2020 11:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgLVQkq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 22 Dec 2020 11:40:46 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333AAC0613D3;
        Tue, 22 Dec 2020 08:40:06 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id s15so3279620plr.9;
        Tue, 22 Dec 2020 08:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XA14ElTeUosr9Ce812CRm87QO2rKQtr679G385v8kMg=;
        b=XBZl/fP8JfaKjImHJU56Okh7Pmq6oSlqsbjWtruce/kIO+jNbne6lPveMeQNQxnp5g
         +pLF+j+xuYF+XItUHD9rfD7VgypsMkmaK4nZpJHJen72knZ1pLBtdHdXDQxE0BC9Abuo
         mDIHGzkXvFPSxBY8Van6Xt+9NYy1KH+7/f6nWtI7nfPVkJpq3+bCiVwi6NIsm96Hi7cL
         xoYGhxL+b298xlYDlZyhkmbOYST4O3GRlyHcQOjcGS/uADxtKhbdw+TofsHeS4LqtMAc
         aKrOjvIvuZtyW07CYTs1Goinb3iDKTwpMNyt6HXSEU2k/xhq895exHFUv2vhPgKJJLjF
         Qr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XA14ElTeUosr9Ce812CRm87QO2rKQtr679G385v8kMg=;
        b=OPF8qxuhrFWaomPd9EfMuhhuuq0Fe8xWTTVtISx8AlEZU2lj10XB4U6ide5h5jx/C0
         PoRzRL8y8zvHEQBCKL8nHIFAADR3bOA+Xm+1DjQLw2EpN8en3/3GWMEfhU8pa1NXXzVL
         n5ykMX6HmDlSSxYKns9c502nH2HbLqfYsa8blAPuckO+/UJdEQRCbVx51kxcL9e1XV+m
         gJwxuSisLQPu1I8F/lN3RpJiWefO67GhinBDUtO+yOLIf0pJRTsN1JrDa5TSMiarF8Ph
         gUMRV11DP0QwpYHfsb1sKwDrFPLsqOQaODvG9gB2Er7CKzho2Q+N1yCoxywOkboZnWQu
         Fs9A==
X-Gm-Message-State: AOAM533+ppOP6K86WLdU/4FIg2fh5v7MA+fs90B+o17sK73+Jw6E5Nnc
        5Q8HPc3W0vvHsAphU94lF0H2I0NEAZZQi10NWdRTf2bvpzU=
X-Google-Smtp-Source: ABdhPJzIwF2uyoRs5h3zHcpXR9B8X/+Kqf1ghnirkIrgLeEnyEAF8eGlnlscDztG0W09G5UHgi1pkkPM9Nt/7w4z4jE=
X-Received: by 2002:a17:902:82c7:b029:da:cb88:38f8 with SMTP id
 u7-20020a17090282c7b02900dacb8838f8mr22192274plz.49.1608655205691; Tue, 22
 Dec 2020 08:40:05 -0800 (PST)
MIME-Version: 1.0
References: <20201222040645.1323611-1-robh@kernel.org>
In-Reply-To: <20201222040645.1323611-1-robh@kernel.org>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Tue, 22 Dec 2020 10:39:55 -0600
Message-ID: <CABb+yY0Q+7vqoVsHJEdP4r9+RwhjEKoBHnKRtGqKc3BNAP_SCQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Drop redundant maxItems/items
To:     Rob Herring <robh@kernel.org>
Cc:     Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        dri-devel@lists.freedesktop.org, dmaengine@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Dec 21, 2020 at 10:10 PM Rob Herring <robh@kernel.org> wrote:
>
> 'maxItems' equal to the 'items' list length is redundant. 'maxItems' is
> preferred for a single entry while greater than 1 should have an 'items'
> list.
>
> A meta-schema check for this is pending once these existing cases are
> fixed.
>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jassi Brar <jaswinder.singh@linaro.org>
> Cc: dri-devel@lists.freedesktop.org
> Cc: dmaengine@vger.kernel.org
> Cc: alsa-devel@alsa-project.org
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml    | 1 -
>  Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml   | 1 -
>  Documentation/devicetree/bindings/mailbox/arm,mhu.yaml         | 1 -
>  .../devicetree/bindings/sound/nvidia,tegra30-hda.yaml          | 2 --
>  Documentation/devicetree/bindings/usb/renesas,usb-xhci.yaml    | 1 -
>  Documentation/devicetree/bindings/usb/renesas,usbhs.yaml       | 3 ---
>  6 files changed, 9 deletions(-)

Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
