Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C90353843
	for <lists+dmaengine@lfdr.de>; Sun,  4 Apr 2021 15:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbhDDNhj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 4 Apr 2021 09:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhDDNhi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 4 Apr 2021 09:37:38 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD96C061756;
        Sun,  4 Apr 2021 06:37:34 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id m12so13889221lfq.10;
        Sun, 04 Apr 2021 06:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+HyYmPnuWFFMIB7SpjIfrjeRJ9UQQxny2FWb69wvVv0=;
        b=FJXzDuwGBEUuCTztCBPIrjJlZA/CX7RI25lUHFo/GsEUXKQFlfYchi//lxsK0mr8Rb
         XDAo+BY11DGZU3N5MT+lEhXwApPQtYWQKztQRj/m1NfZmIMjvV8Bd6wdm4NCPs4uHnZ6
         8GHsJw55eUWb4w34EymYDs2FqPzLUQ73BqOWyS2RUGS3jfhRL0TBrEEeEtVNqqHrNb6l
         he+5GH5gA8bElV5/eeCRnZMyDpojqwFWYdsMsh4Urw6/RUsZGmzdjzJhZRD3LHug1owe
         XPmRMFS6K1Nx3CbbYI4gjVY7jz6a8g7PW6aRmBiIqGC8Wsp3fDg9uyCO38+uUhHFv3Kq
         wn1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+HyYmPnuWFFMIB7SpjIfrjeRJ9UQQxny2FWb69wvVv0=;
        b=eED5AcfRsoGaseg4fUFH/u5bAFAQJjth4YnLrTbk8JgiFhKN6oXc0u7kYtUm6PWaa1
         5YqRjtkVRP8fA08dOzl3MXGjB6EqRuh3kV4tJz2VNZz6AuO/gVmLCZgOQPOPJEewbnm3
         yaF209wYSAIuganG65kF4EC2lmiEjKxOaufPT0KCasXPjF8GSSAP8jh3EXZ/oGJ7EULZ
         XuP9umX2m+A3FB9sBjtXdBicrYMjLlnTqV5S1wWxyMYlHkOqI9U4y+4x63Ppr/TdCPn8
         RYp8BIj1eekXJ/noYjCenk8k/dp/cFosXyWL7vp4KdDTH4OluwJN9KBNEB03btYHllBQ
         SxOA==
X-Gm-Message-State: AOAM530Yhf/WwdEvqCcs0hn3v4Lz9R9q1i7595dkIfvYfvoo9qyqemi+
        Kw2cxKt1WRhUupof3sfChRs=
X-Google-Smtp-Source: ABdhPJy30HYImZBK03kv3X4L6uVNJSkQ/Jz4VRA2vHp4FEqO8UBKLgdvEBu1k3f9zBhXIHxmDW0p9g==
X-Received: by 2002:a05:6512:ac9:: with SMTP id n9mr15012614lfu.186.1617543452694;
        Sun, 04 Apr 2021 06:37:32 -0700 (PDT)
Received: from [10.0.0.42] (91-157-86-200.elisa-laajakaista.fi. [91.157.86.200])
        by smtp.gmail.com with ESMTPSA id t10sm1451535lfk.58.2021.04.04.06.37.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Apr 2021 06:37:32 -0700 (PDT)
To:     Pratyush Yadav <p.yadav@ti.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Benoit Parrot <bparrot@ti.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Alexandre Courbot <acourbot@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Helen Koike <helen.koike@collabora.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Peter Chen <peter.chen@nxp.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        dmaengine@vger.kernel.org
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
References: <20210330173348.30135-1-p.yadav@ti.com>
 <20210330173348.30135-14-p.yadav@ti.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH 13/16] media: ti-vpe: csi2rx: Add CSI2RX support
Message-ID: <1983f3dd-d157-900f-b72f-c8e6987f7ec6@gmail.com>
Date:   Sun, 4 Apr 2021 16:38:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210330173348.30135-14-p.yadav@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Pratyush,

+1 from me also to the points Tomi raised.

few minor comments on the DMAengie side.

On 3/30/21 8:33 PM, Pratyush Yadav wrote:
> TI's J721E uses the Cadence CSI2RX and DPHY peripherals to facilitate
> capture over a CSI-2 bus.
> 
> The Cadence CSI2RX IP acts as a bridge between the TI specific parts and
> the CSI-2 protocol parts. TI then has a wrapper on top of this bridge
> called the SHIM layer. It takes in data from stream 0, repacks it, and
> sends it to memory over PSI-L DMA.
> 
> This driver acts as the "front end" to V4L2 client applications. It
> implements the required ioctls and buffer operations, passes the
> necessary calls on to the bridge, programs the SHIM layer, and performs
> DMA via the dmaengine API to finally return the data to a buffer
> supplied by the application.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> ---
>  MAINTAINERS                               |   7 +
>  drivers/media/platform/Kconfig            |  11 +
>  drivers/media/platform/ti-vpe/Makefile    |   1 +
>  drivers/media/platform/ti-vpe/ti-csi2rx.c | 964 ++++++++++++++++++++++
>  4 files changed, 983 insertions(+)
>  create mode 100644 drivers/media/platform/ti-vpe/ti-csi2rx.c

...

> diff --git a/drivers/media/platform/ti-vpe/ti-csi2rx.c b/drivers/media/platform/ti-vpe/ti-csi2rx.c
> new file mode 100644
> index 000000000000..355204ae473b
> --- /dev/null
> +++ b/drivers/media/platform/ti-vpe/ti-csi2rx.c

...

> +static int ti_csi2rx_init_vb2q(struct ti_csi2rx_dev *csi)
> +{
> +	struct vb2_queue *q = &csi->vidq;
> +	int ret;
> +
> +	q->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
> +	q->io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF | VB2_READ;
> +	q->drv_priv = csi;
> +	q->buf_struct_size = sizeof(struct ti_csi2rx_buffer);
> +	q->ops = &csi_vb2_qops;
> +	q->mem_ops = &vb2_dma_contig_memops;
> +	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
> +	q->dev = csi->dma->device->dev;

q->dev = dmaengine_get_dma_device(csi->dma);

> +	q->lock = &csi->mutex;
> +
> +	ret = vb2_queue_init(q);
> +	if (ret)
> +		return ret;
> +
> +	csi->vdev.queue = q;
> +
> +	return 0;
> +}
> +
> +static int ti_csi2rx_init_dma(struct ti_csi2rx_dev *csi)
> +{
> +	struct dma_slave_config cfg;
> +	int ret;
> +
> +	INIT_LIST_HEAD(&csi->dmaq.list);
> +
> +	csi->dma = NULL;
> +
> +	csi->dma = dma_request_chan(csi->dev, "rx0");
> +	if (IS_ERR(csi->dma))
> +		return PTR_ERR(csi->dma);
> +
> +	memset(&cfg, 0, sizeof(cfg));
> +
> +	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_16_BYTES;
> +	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_16_BYTES;

No need to set the dst_addr_width as you only support RX.

Another note: UDMA with PSI-L native peripherals ignores this
cofniguration, only used for PDMAs, but I can remain to future proof the
driver and to keep it generic.

> +
> +	ret = dmaengine_slave_config(csi->dma, &cfg);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}

-- 
Péter
