Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452383A435C
	for <lists+dmaengine@lfdr.de>; Fri, 11 Jun 2021 15:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhFKNxa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Jun 2021 09:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbhFKNx3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Jun 2021 09:53:29 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB0EC061574;
        Fri, 11 Jun 2021 06:51:17 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id a19so6600644ljq.12;
        Fri, 11 Jun 2021 06:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xVxSNmZANvk4+xXEPZhmdlgwWkhMnsRF27bwwNOdZG8=;
        b=Sgrn7Y/dVZ5kOr4om0rQqu9jRGg39+nyLDYicWqeVx2nZ9X+zJNj+CJOwHlPT+1Wrj
         nXFlmDUb0Xo9Lh7dlg2DeS0XmhIW0zRjMZ2C4lhE/sI32mfOWFnYNbX2g9VkEhAusHZs
         Rswn/8EOfge1thH6I+tYzikO23WTeSv27sOXizs2CCOK17B5Oi3rJgxoEBL+S/EcOKBz
         7IauTY1u7kujy5CygP5aqFH7nogHvcJY/XYGEwNYeGtGl0TAbltX66XzI9hg0jXZtMh/
         2Y8a3WsMbluns0GKIaW9mSaBXGyeFpJwpRlMLrm9tyA+MWXOHKv+Ph6Qq0v7eEI8mgpo
         uhNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xVxSNmZANvk4+xXEPZhmdlgwWkhMnsRF27bwwNOdZG8=;
        b=WSC7n7KN7VpOP7oAItt4icc/tSN4r93OmIn1OhImJV2UxNa3MR7XtxIZnChiX8vy3d
         yrlgeOQYnagsIZ7NFdUeUfI4zHBYrNAbrdg2FWmrflPsPfQtmAmba1D+1x0b0ONWCZHW
         RINUzlt5/ebViR0QDI4N6W9TmDNRM4Hep15j+khlQXafRiNLWighUclsz3HLsaX9j9JI
         Jh9EXHhZC5LAB7xFHqeFIXXT/fJmNqtqugKzAYHM4HgO8fz3hRcQRkGkCdO+EprzG+x2
         u8IXVTbz47D0WMqtXK93pO0v7kk1WL+B1vflxtRZVBxCGPHPuLfZ5ZtlA8m2JF/d7p3G
         lPQA==
X-Gm-Message-State: AOAM533G1bWwgkX5ddnBR/cPZUiiQGxMNzwlE3J5RRCvnW8FThsOPbnp
        ZwVkzMLRNoi6D0nXmtofW4j5Ze4CT9BqvayUpYA=
X-Google-Smtp-Source: ABdhPJzBC5HTrPREljfBNuYDFNUOpKk5D/S72tuVLMDbbEnMCeVyrTuboq9vTycZoGPYOJtPpiu6HfWjFyo+5AaDbZM=
X-Received: by 2002:a05:651c:1193:: with SMTP id w19mr3110192ljo.264.1623419475775;
 Fri, 11 Jun 2021 06:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <1617809456-17693-1-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1617809456-17693-1-git-send-email-yibin.gong@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 11 Jun 2021 10:51:04 -0300
Message-ID: <CAOMZO5CNjpek0vkDrMyTmfbnr2cLcquck6QQBqXLBiyTDKPXvA@mail.gmail.com>
Subject: Re: [PATCH v14 00/12] add ecspi ERR009165 for i.mx6/7 soc family
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     Vinod <vkoul@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Martin Fuzzey <martin.fuzzey@flowbird.group>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Clark Wang <xiaoning.wang@nxp.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        dmaengine@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Robin,

On Wed, Apr 7, 2021 at 4:15 AM Robin Gong <yibin.gong@nxp.com> wrote:
>
> There is ecspi ERR009165 on i.mx6/7 soc family, which cause FIFO
> transfer to be send twice in DMA mode. Please get more information from:
> https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf. The workaround is adding
> new sdma ram script which works in XCH  mode as PIO inside sdma instead
> of SMC mode, meanwhile, 'TX_THRESHOLD' should be 0. The issue should be
> exist on all legacy i.mx6/7 soc family before i.mx6ul.
> NXP fix this design issue from i.mx6ul, so newer chips including i.mx6ul/
> 6ull/6sll do not need this workaroud anymore. All other i.mx6/7/8 chips
> still need this workaroud. This patch set add new 'fsl,imx6ul-ecspi'
> for ecspi driver and 'ecspi_fixed' in sdma driver to choose if need errata
> or not.
> The first two reverted patches should be the same issue, though, it
> seems 'fixed' by changing to other shp script. Hope Sean or Sascha could
> have the chance to test this patch set if could fix their issues.
> Besides, enable sdma support for i.mx8mm/8mq and fix ecspi1 not work
> on i.mx8mm because the event id is zero.
>
> PS:
>    Please get sdma firmware from below linux-firmware and copy it to your
> local rootfs /lib/firmware/imx/sdma.
> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/imx/sdma

Without this series, SPI DMA does not work on i.MX8MM:

 [   41.315984] spi_master spi1: I/O Error in DMA RX

I applied your series and SPI DMA works now:

Reviewed-by: Fabio Estevam <festevam@gmail.com>

Thanks
