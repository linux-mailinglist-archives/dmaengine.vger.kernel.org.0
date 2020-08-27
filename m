Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC4F2544AD
	for <lists+dmaengine@lfdr.de>; Thu, 27 Aug 2020 13:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbgH0L6r (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 Aug 2020 07:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728957AbgH0L4i (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 27 Aug 2020 07:56:38 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C332C06123E;
        Thu, 27 Aug 2020 04:08:34 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id q16so2729576ybk.6;
        Thu, 27 Aug 2020 04:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4AC1iNQgWZrkBSCQYpKpySGolDqTh2HDf1hkAeZFNb4=;
        b=T+RtF9WlK+QYlzaFRforZObowt16Z/icVvaSdm1jjwL0BDGUHQxVhiDeSCIDIn/cF4
         +Jfk9BSyfhzclpoE+pdql83jioly+c2MdVx6NLOqCLqCWsfKn3Ao1cjYW7XGKcbi7b+U
         lMPm9mwtitTgaESAs6c79YF6oXOk0GFbAjfy2CbREnXE5LP9HiOSzDqqm6SpSwKIwp78
         jol6U5yB2v5SJpmbkCRsn9lIz1UpWha3gERsgWwwi0BiYzt2T8ctaMSbXxTOd937vCr6
         +e/ereWKyJnAtDM99NFXloqA5EQ1i1oc8Q08QBJG2EdSdwUiYA2aTShsnaRZ5mV5pyJT
         LM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4AC1iNQgWZrkBSCQYpKpySGolDqTh2HDf1hkAeZFNb4=;
        b=r04hRvZH6rcwvRX+/cRGvUFv/2GkV3XgabSorz8yILWPdCehOTI2OO+ohm+29kz8H2
         /IJFFb9afn0OBe4o/xBJnn9EeN012EA2Yb31d5oPwYacFBRxGKfFnwA+COBEFRgZrRON
         y47z4xOva9+tJNnKIhrxOjlqB4494nnY0iOYi/pIT02T9X+TlLciJlT8YWhyZWoPUL/U
         1yqG3SPPMWegXE0/M0UKPIepbIQiOK/M3GW1nJKr/6djtdwuB1RHSQEh+CgKl/LfwwZr
         PztxWNgFgyeQI1EtM2ouNM+X2cIVoahXLkdOtRjRR9K7CqfSsQzx/fNzhyFz8pkYYijW
         Lbww==
X-Gm-Message-State: AOAM5307fAgGfz9DoT3BBnMCsuWPXrf4iuHC+A55rVifiBN0DL2MD9q/
        8ZYokM/uCiAn6XVYB64uIid7qAKWbddK5RCXWaY=
X-Google-Smtp-Source: ABdhPJxqcVtXp1n3gyHbu5k3vj5n974w3z1wdNTj6pVg7CQ0rfbSLCDrB4IgRwp3FjMCjoGv8C0ToybrrjeIiLUlXDE=
X-Received: by 2002:a25:8149:: with SMTP id j9mr28989594ybm.214.1598526513604;
 Thu, 27 Aug 2020 04:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <1588542414-14826-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588542414-14826-6-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1588542414-14826-6-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 27 Aug 2020 12:08:07 +0100
Message-ID: <CA+V-a8v5CtxJQxjSWcvJrPtf9JyYKZeACdc3as_hjM710pk1AQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] dt-bindings: renesas,rcar-dmac: Document r8a7742 support
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On Sun, May 3, 2020 at 10:47 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> Renesas RZ/G SoC also have the R-Car gen2/3 compatible DMA controllers.
> Document RZ/G1H (also known as R8A7742) SoC bindings.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
This patch is not present in linux-next yet, could you please take care of it.

Cheers,
Prabhakar
