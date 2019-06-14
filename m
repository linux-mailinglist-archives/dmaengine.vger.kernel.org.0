Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4D6545E4F
	for <lists+dmaengine@lfdr.de>; Fri, 14 Jun 2019 15:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfFNNfs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 14 Jun 2019 09:35:48 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41042 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbfFNNfr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 14 Jun 2019 09:35:47 -0400
Received: by mail-ot1-f68.google.com with SMTP id 107so2632971otj.8
        for <dmaengine@vger.kernel.org>; Fri, 14 Jun 2019 06:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Iumb5nCJVz2HC5/nbRIEDZUIZqdpRhVEmQs809cxSo=;
        b=h7tg3sjFL4f+yNN/91TYjVrpxnwzYt+gGHLq8QmMeaQrToFB2+nRGWop83WSLVjJss
         5oyNn74saGXhBLqBKroPI9odbFsqifoREUvx+3xW59g9m+tXUqZgP8wfUej6ENlHnUCV
         vlitnGmwpM+VVsnWEkF1vMXfqJrcOBIxhua/taQ1bVXz7u1NtZpO+CZb/3mt+rhvwyxH
         9uPRRveSTTiWyGfuYnGmmSRmr9MxFZ8512dHDfw879ehHWtxVmqNt2TiS4OclukO4zYX
         bKtwUcLW8d8NrkeJVYbFNX20S2btklGN0EsrjcVrJ0MTl2+kenxIk6V69ZAWhyrkFu56
         ofzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Iumb5nCJVz2HC5/nbRIEDZUIZqdpRhVEmQs809cxSo=;
        b=ZIP/9QX1n5zHj47MtNSEMy9P0MMMyBm3Ve91bjNVfvIZwzn8yF2vKC0NzNrso+9wsJ
         KfUhcvtz7n3cdcun3jR+WZWCN2dyjZeMcIAYBnETOvBDCpfQEup1UKNLD3XX6zgv38No
         UL6bpYTUs+kO9kGVHwG17GQ6ngEFAvZIfDLRkfGdEpMLB+0s/mt7qulckRSKKpGMoaBk
         DkLarF8YBYUg4JiybhwLcLZmXz395F8bLAM8SkXLHDMJVqkOfJeV3FBe1IoHf+C3KfnI
         nwIds5WktR1HVYWqIOAd17BNNPs+XEGVT8XLVGhtlKmnf41G56XgkMBYDjLg3jxt2UR3
         89KA==
X-Gm-Message-State: APjAAAWiMUyaYY9HlDws66gCFcmMXxHjo+Rwsqe7blmcjU3ZR1EffJqH
        Dla/yvMwn9/wu6mYA2hG95eK08dDMZEWRd1WIWIYZQ==
X-Google-Smtp-Source: APXvYqyAHNQQrhuiues4BPDDMqOVwi6uPApFWQbGHNqabmJA/bDejfzEJeXfWZbmC3TNm/pELH4rkrdnbKy756U7huo=
X-Received: by 2002:a05:6830:1319:: with SMTP id p25mr6040495otq.224.1560519346918;
 Fri, 14 Jun 2019 06:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190614083959.37944-1-yibin.gong@nxp.com>
In-Reply-To: <20190614083959.37944-1-yibin.gong@nxp.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Fri, 14 Jun 2019 09:35:36 -0400
Message-ID: <CAGngYiU_sNiAi0gYFEUg6=TfvUWH+6Nhid9PqYa6x+nb4UkVWA@mail.gmail.com>
Subject: Re: [PATCH v1] dmaengine: imx-sdma: remove BD_INTR for channel0
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Vinod <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, dmaengine@vger.kernel.org,
        Sascha Hauer <kernel@pengutronix.de>,
        Michael Olbrich <m.olbrich@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Robin, see comments inline.

On Fri, Jun 14, 2019 at 4:38 AM <yibin.gong@nxp.com> wrote:
>
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index deea9aa..b5a1ee2 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -742,7 +742,7 @@ static int sdma_load_script(struct sdma_engine *sdma, void *buf, int size,
>         spin_lock_irqsave(&sdma->channel_0_lock, flags);
>
>         bd0->mode.command = C0_SETPM;
> -       bd0->mode.status = BD_DONE | BD_INTR | BD_WRAP | BD_EXTD;
> +       bd0->mode.status = BD_DONE | BD_WRAP | BD_EXTD;

I tested this change on its own, and it seemed sufficient to make the crash
disappear.

>         bd0->mode.count = size / 2;
>         bd0->buffer_addr = buf_phys;
>         bd0->ext_buffer_addr = address;
> @@ -1064,7 +1064,7 @@ static int sdma_load_context(struct sdma_channel *sdmac)
>         context->gReg[7] = sdmac->watermark_level;
>
>         bd0->mode.command = C0_SETDM;
> -       bd0->mode.status = BD_DONE | BD_INTR | BD_WRAP | BD_EXTD;
> +       bd0->mode.status = BD_DONE | BD_WRAP | BD_EXTD;

This function isn't part of the firmware load path, so how can it be related
to fixing the firmware crash?

If this is an unrelated efficiency saving, maybe it should go into its
own patch?
Maybe we want bugfix patches to be as small and specific as possible, so they
can more easily be backported to older kernels?

>         bd0->mode.count = sizeof(*context) / 4;
>         bd0->buffer_addr = sdma->context_phys;
>         bd0->ext_buffer_addr = 2048 + (sizeof(*context) / 4) * channel;
> --
> 2.7.4
>
