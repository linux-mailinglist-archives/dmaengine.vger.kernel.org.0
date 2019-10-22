Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39A4FE00B6
	for <lists+dmaengine@lfdr.de>; Tue, 22 Oct 2019 11:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbfJVJ10 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Oct 2019 05:27:26 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:39121 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731234AbfJVJ10 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 22 Oct 2019 05:27:26 -0400
Received: by mail-lj1-f172.google.com with SMTP id y3so16387434ljj.6
        for <dmaengine@vger.kernel.org>; Tue, 22 Oct 2019 02:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T9L8jGHiyeAbKVH3+eeYDr6SmphM8zhAv3MB0FnWhlI=;
        b=tETdSgEZGXBa+oNwO4Xq0Qkcc04mCbE2OQZv7G/SFHrTzYMbS2UiqshYOlqxUqogyd
         XdU1gCB+El8o045uP6HPzhLIH567KG9rtt5dXNGaQw0+TQBmxgjz7gRsQAJNrFcRX7wA
         99ZDIlbDebHdg2P/s+oH/H0UlXq1kS0ONAdhG8IEk88kSnaua92WgyxPniM67G0pwVjk
         ByuY5kCC1Qt1Wz33TJekx8A2fH4uGzbmQlGyk1k7d7OSryShZxvVOLItpxbrZf7m3m98
         pfO1cfzkexZ+shxUOi7NSuHLCI+u0lZVht14xAJphB7Kt7CEbnu/BKOczqYHCklq0JJu
         Jz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T9L8jGHiyeAbKVH3+eeYDr6SmphM8zhAv3MB0FnWhlI=;
        b=Vuxnu9Q2ddRDS2PKuVo4wuJPlUv5OKvlqWRyfuDqbOjLo2drRUx4+n7Xl2YUYG6J9R
         RGSil4XHNLTak6SpiOetSPJ5D0hWx+ZPmI2d1UG3TU4N5kBsShjiVtnyrtgb4bSM1U+s
         MjkTm+p2RfSHZsYe7iU1mawiP1wtTitrqAnWM1H1QBjlBbfwfXgnRHEd4YkcwD9ktS3R
         UtqwtIjgZef+fCsPlhT1AhBcHZkwLUUeIKa5Y73ZIkcfA+SJk9jOweq9Jnai2635GfYk
         n67uqCBsq3vpdY0MwRwdmRMpM/cueXM+8p5IDieI+TEE5xndDGcq377PRhm81jLvkPFT
         6+aA==
X-Gm-Message-State: APjAAAVV0rdmxZ6U7wl0I3sqZ8kx7MTNDraVX74wssij/EhEWZYimrsI
        lAIc6oT2ptzEL0zjofV8uhfcson/kLMJ5Lu1/VsR4A==
X-Google-Smtp-Source: APXvYqy8z7iSzq4oSiQyTstd4CoQLRTdUMxQ/fJueKzRPVMDu9UORzwo7WdQv7uhY6ESEHo1thAJtNn8wPWYJTbXz+0=
X-Received: by 2002:a05:651c:237:: with SMTP id z23mr18783819ljn.214.1571736444355;
 Tue, 22 Oct 2019 02:27:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190930020440.7754-1-peng.ma@nxp.com> <20191017041124.GN2654@vkoul-mobl>
 <AM0PR04MB44207F0EF575C5FB44DA6984ED6D0@AM0PR04MB4420.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB44207F0EF575C5FB44DA6984ED6D0@AM0PR04MB4420.eurprd04.prod.outlook.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 22 Oct 2019 11:27:13 +0200
Message-ID: <CADYN=9JkQMawVnLoJ8sXAbV8NB_BK0zQA0PomJ583Agj12r8Cg@mail.gmail.com>
Subject: Re: [EXT] Re: [V5 1/2] dmaengine: fsl-dpaa2-qdma: Add the DPDMAI(Data
 Path DMA Interface) support
To:     Peng Ma <peng.ma@nxp.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, 17 Oct 2019 at 08:16, Peng Ma <peng.ma@nxp.com> wrote:
>
> Hi Vinod,
>
> Thanks very much for your reply.
>
> Best Regards,
> Peng
> >-----Original Message-----
> >From: Vinod Koul <vkoul@kernel.org>
> >Sent: 2019=E5=B9=B410=E6=9C=8817=E6=97=A5 12:11
> >To: Peng Ma <peng.ma@nxp.com>
> >Cc: dan.j.williams@intel.com; Leo Li <leoyang.li@nxp.com>;
> >linux-kernel@vger.kernel.org; dmaengine@vger.kernel.org
> >Subject: [EXT] Re: [V5 1/2] dmaengine: fsl-dpaa2-qdma: Add the DPDMAI(Da=
ta
> >Path DMA Interface) support
> >
> >Caution: EXT Email
> >
> >On 30-09-19, 02:04, Peng Ma wrote:
> >> The MC(Management Complex) exports the DPDMAI(Data Path DMA
> >Interface)
> >> object as an interface to operate the DPAA2(Data Path Acceleration
> >> Architecture 2) qDMA Engine. The DPDMAI enables sending frame-based
> >> requests to qDMA and receiving back confirmation response on
> >> transaction completion, utilizing the DPAA2 QBMan(Queue Manager and
> >> Buffer Manager
> >> hardware) infrastructure. DPDMAI object provides up to two priorities
> >> for processing qDMA requests.
> >> The following list summarizes the DPDMAI main features and capabilitie=
s:
> >>       1. Supports up to two scheduling priorities for processing
> >>       service requests.
> >>       - Each DPDMAI transmit queue is mapped to one of two service
> >>       priorities, allowing further prioritization in hardware between
> >>       requests from different DPDMAI objects.
> >>       2. Supports up to two receive queues for incoming transaction
> >>       completion confirmations.
> >>       - Each DPDMAI receive queue is mapped to one of two receive
> >>       priorities, allowing further prioritization between other
> >>       interfaces when associating the DPDMAI receive queues to DPIO
> >>       or DPCON(Data Path Concentrator) objects.
> >>       3. Supports different scheduling options for processing received
> >>       packets:
> >>       - Queues can be configured either in 'parked' mode (default),
> >>       or attached to a DPIO object, or attached to DPCON object.
> >>       4. Allows interaction with one or more DPIO objects for
> >>       dequeueing/enqueueing frame descriptors(FD) and for
> >>       acquiring/releasing buffers.
> >>       5. Supports enable, disable, and reset operations.
> >>
> >> Add dpdmai to support some platforms with dpaa2 qdma engine.
> >
> >Applied both, thanks

I see this error when I'm building.

WARNING: modpost: missing MODULE_LICENSE() in
drivers/dma/fsl-dpaa2-qdma/dpdmai.o
see include/linux/module.h for more information
ERROR: "dpdmai_enable" [drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko] undefined=
!
ERROR: "dpdmai_set_rx_queue"
[drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko] undefined!
ERROR: "dpdmai_get_tx_queue"
[drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko] undefined!
ERROR: "dpdmai_get_rx_queue"
[drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko] undefined!
ERROR: "dpdmai_get_attributes"
[drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko] undefined!
ERROR: "dpdmai_open" [drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko] undefined!
ERROR: "dpdmai_close" [drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko] undefined!
ERROR: "dpdmai_disable" [drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko] undefine=
d!
ERROR: "dpdmai_reset" [drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko] undefined!
make[2]: *** [../scripts/Makefile.modpost:95: __modpost] Error 1
make[1]: *** [/srv/src/kernel/next/Makefile:1282: modules] Error 2
make: *** [Makefile:179: sub-make] Error 2
make: Target 'Image' not remade because of errors.
make: Target 'modules' not remade because of errors.

any other that see the same ?

Cheers,
Anders
