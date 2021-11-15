Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05764501D7
	for <lists+dmaengine@lfdr.de>; Mon, 15 Nov 2021 10:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236829AbhKOJ71 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 15 Nov 2021 04:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237514AbhKOJ7O (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 15 Nov 2021 04:59:14 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A27AC061204;
        Mon, 15 Nov 2021 01:56:09 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id l24so29295184uak.2;
        Mon, 15 Nov 2021 01:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gsBk71NedBBsVpsWIk4ACHvjoj+bC3+VIVEUbcpO8IA=;
        b=ehc21nRzLc8i1U+EqW4HnjY+RWjGWh14ZBLj7yNPUxl816A1Dbell6St7S/yW4X/vv
         tt7qOOmMMY85WSc7GghoYpJGJ9xgEBBUokeqlapvAJX5EFUnaN1rvUlEUeE8epbheu5B
         bWVKVRopMxxBfMWO9giRCidfYfZ56vuyGO7o4CSsyVdRcdOlFmosB/G0CBJUF76Dwi9T
         Bi5dKD3S2Ixk/FkU0QqBfwiiGLH1DDHTmYGg0Ci2mql4cvEo0wmrzkz2B7tgBgY5liPS
         E361qlo75lRj9Ddb/VA9aIMjLtX6LX3ck8/h22UNs9feaHP2NMM+vvRDoJtlPCwrDlmi
         9GJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gsBk71NedBBsVpsWIk4ACHvjoj+bC3+VIVEUbcpO8IA=;
        b=g9QRdlJYHhz/vngbCGzB5W2OuGxvOHghG2/0qcXbWTtnsLc39XX43Pf0ynqoCdDpj+
         aINeAnK8NsK1TYTUG1rrXsLvVonXj0brbuIwjuQB7BupBnEV2F/YBHTMx4Yk0W1QG53u
         szkng+m6XBdBycV8wxJBWzGcbyz1mrltM6vMf9L9f1HSVSOAgqEyi2C5d0c3xJ5trQ8j
         5bD+6pZXYYhTKzeNqcs0uYAuAo8U4fcV61AHxJ9EhBnZowOCsQeSygjVW4JhCaquM9ms
         OHt8uEEXZowB84W8QUd6OxQ8vnliqHpvWPnuO2PGLxXYHoeNMG6f3E2y1jubYN+xggh2
         bZrg==
X-Gm-Message-State: AOAM530uLdzZbHLDycS40695dYt8VMKUjQHA9AHo6d8uvlubUZrsCyJQ
        SMWar6g7j9tEzW+w6uda6ISpWDJgAuhnQeTvemA=
X-Google-Smtp-Source: ABdhPJz6ESqhwfmkhVT1QvVuW/9wYB2eiEui3t3htInxrDx0SkRrPjrQEm+aetErjkG15iM6y1caYpqVdHJBHexZMiA=
X-Received: by 2002:ab0:6883:: with SMTP id t3mr56751869uar.66.1636970168537;
 Mon, 15 Nov 2021 01:56:08 -0800 (PST)
MIME-Version: 1.0
References: <20211115085403.360194-1-arnd@kernel.org> <20211115085403.360194-11-arnd@kernel.org>
In-Reply-To: <20211115085403.360194-11-arnd@kernel.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 15 Nov 2021 10:55:56 +0100
Message-ID: <CAMhs-H98kPNqH491+X0Mp81Ng++v1aQ=97XSHEhs+vx3g8W_4A@mail.gmail.com>
Subject: Re: [PATCH 10/11] staging: ralink-gdma: stop using slave_id config
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Andy Gross <agross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jon Hunter <jonathanh@nvidia.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Scott Branden <sbranden@broadcom.com>,
        Takashi Iwai <tiwai@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        alsa-devel@alsa-project.org, bcm-kernel-feedback-list@broadcom.com,
        dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Arnd,

On Mon, Nov 15, 2021 at 9:55 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Picking the connection between a DMA controller and its attached device
> is done through devicetree using the "dmas" property, which is implemented
> by the gdma driver, but it also allows overriding the "req" configuration
> with the slave_id field, as it was done in some linux-2.6 era drivers.
>
> There is no driver in the tree that sets these values, so stop
> interpreting them before anything accidentally starts relying on it.
> Rename the field in the channel from "slave_id" to "req" to better match
> the purpose and the naming in the hardware.
>
> If any driver actually starts using this DMA engine, it may be necessary
> to implement a .xlate callback that sets this field at probe time.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/staging/ralink-gdma/ralink-gdma.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)

This driver has been already deleted from the staging tree. See [0].

Best regards,
    Sergio Paracuellos

[0]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?h=staging-testing&id=5bfc10690c6c590a972be014ed8595e77e1e2dea

>
> diff --git a/drivers/staging/ralink-gdma/ralink-gdma.c b/drivers/staging/ralink-gdma/ralink-gdma.c
> index b5229bc6eae5..f00240e62e1b 100644
> --- a/drivers/staging/ralink-gdma/ralink-gdma.c
> +++ b/drivers/staging/ralink-gdma/ralink-gdma.c
> @@ -106,7 +106,7 @@ struct gdma_dma_desc {
>  struct gdma_dmaengine_chan {
>         struct virt_dma_chan vchan;
>         unsigned int id;
> -       unsigned int slave_id;
> +       unsigned int req;
>
>         dma_addr_t fifo_addr;
>         enum gdma_dma_transfer_size burst_size;
> @@ -194,7 +194,6 @@ static int gdma_dma_config(struct dma_chan *c,
>                         dev_err(dma_dev->ddev.dev, "only support 4 byte buswidth\n");
>                         return -EINVAL;
>                 }
> -               chan->slave_id = config->slave_id;
>                 chan->fifo_addr = config->dst_addr;
>                 chan->burst_size = gdma_dma_maxburst(config->dst_maxburst);
>                 break;
> @@ -203,7 +202,6 @@ static int gdma_dma_config(struct dma_chan *c,
>                         dev_err(dma_dev->ddev.dev, "only support 4 byte buswidth\n");
>                         return -EINVAL;
>                 }
> -               chan->slave_id = config->slave_id;
>                 chan->fifo_addr = config->src_addr;
>                 chan->burst_size = gdma_dma_maxburst(config->src_maxburst);
>                 break;
> @@ -288,12 +286,12 @@ static int rt305x_gdma_start_transfer(struct gdma_dmaengine_chan *chan)
>                 dst_addr = chan->fifo_addr;
>                 ctrl0 = GDMA_REG_CTRL0_DST_ADDR_FIXED |
>                         (8 << GDMA_RT305X_CTRL0_SRC_REQ_SHIFT) |
> -                       (chan->slave_id << GDMA_RT305X_CTRL0_DST_REQ_SHIFT);
> +                       (chan->req << GDMA_RT305X_CTRL0_DST_REQ_SHIFT);
>         } else if (chan->desc->direction == DMA_DEV_TO_MEM) {
>                 src_addr = chan->fifo_addr;
>                 dst_addr = sg->dst_addr;
>                 ctrl0 = GDMA_REG_CTRL0_SRC_ADDR_FIXED |
> -                       (chan->slave_id << GDMA_RT305X_CTRL0_SRC_REQ_SHIFT) |
> +                       (chan->req << GDMA_RT305X_CTRL0_SRC_REQ_SHIFT) |
>                         (8 << GDMA_RT305X_CTRL0_DST_REQ_SHIFT);
>         } else if (chan->desc->direction == DMA_MEM_TO_MEM) {
>                 /*
> @@ -365,12 +363,12 @@ static int rt3883_gdma_start_transfer(struct gdma_dmaengine_chan *chan)
>                 dst_addr = chan->fifo_addr;
>                 ctrl0 = GDMA_REG_CTRL0_DST_ADDR_FIXED;
>                 ctrl1 = (32 << GDMA_REG_CTRL1_SRC_REQ_SHIFT) |
> -                       (chan->slave_id << GDMA_REG_CTRL1_DST_REQ_SHIFT);
> +                       (chan->req << GDMA_REG_CTRL1_DST_REQ_SHIFT);
>         } else if (chan->desc->direction == DMA_DEV_TO_MEM) {
>                 src_addr = chan->fifo_addr;
>                 dst_addr = sg->dst_addr;
>                 ctrl0 = GDMA_REG_CTRL0_SRC_ADDR_FIXED;
> -               ctrl1 = (chan->slave_id << GDMA_REG_CTRL1_SRC_REQ_SHIFT) |
> +               ctrl1 = (chan->req << GDMA_REG_CTRL1_SRC_REQ_SHIFT) |
>                         (32 << GDMA_REG_CTRL1_DST_REQ_SHIFT) |
>                         GDMA_REG_CTRL1_COHERENT;
>         } else if (chan->desc->direction == DMA_MEM_TO_MEM) {
> --
> 2.30.2
>
>
