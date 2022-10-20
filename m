Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456E86058B2
	for <lists+dmaengine@lfdr.de>; Thu, 20 Oct 2022 09:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiJTHeN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Oct 2022 03:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiJTHdo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Oct 2022 03:33:44 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464D316CA78;
        Thu, 20 Oct 2022 00:33:43 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id u2so10442935ilv.6;
        Thu, 20 Oct 2022 00:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQoe4mW/rm1KWeW7BtSxDlEmq6+mZfZxuDUoP6ut/Rc=;
        b=B91OTGK9jmVK044XH1gJya0pQCiTIjde9Dgfmr/QVGHt0m9K83prXyBA+E2QzMQJYh
         E99ir4SgSCyscrbggLu3McKr2h+/51lQ+t2Y1qArPNEt1cHcqQVt58PMGDCOjImQaGcl
         rG3DT3eDaqMGmvhCxmUM597DvMNiMgnd1air3hrWBp0io728Pmmib5hq8j1HONMuM82c
         XfjWQbrzouG3UUM4hPuv3P0Fuwvo7lrv/uZDX92w/GvZYPP2RoA8zjcs+qBMfH/0rmFF
         Tz3u6S9Cw4Mxa1NN6643CT0YXIX89q5jM10cre0AgEySCfDOJe6BunWXm/IoGXTKe58n
         4ItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cQoe4mW/rm1KWeW7BtSxDlEmq6+mZfZxuDUoP6ut/Rc=;
        b=5u9aqpTcSlg15zCsR1sbKdmpnBj6HNAkxAZ4SwsmILnbOkigpnR5Vmt+kIfTP4k9ff
         KnPucsA7YeH77+6+eyLm1765r+5d4wqffRz1QM2QN5wKLnRxEC+pLl5szUIqwY7hWPLO
         Pci2A2tkx1RIFijvbEvWs7OAcjoxkmjRiMdqO51nD+dW91nhDBFuj5pgquR29zq2fQpq
         tDEtGoG7ooD+dCvenZeiHbqZaLVpypKM7IBEgHLDQGnndkndozW8ZlJEBsDzFuMmXPN+
         uUltJy+YClLOYlJq+mOwlFK6dvHc3OcbWIzn7X28wW1jciZefYznHbAwfCuTCPflaD0H
         yJKQ==
X-Gm-Message-State: ACrzQf0Ji+bUmBkv9MUfU+3z+0Kat+1TlFE8jjIT7/nTiXPgmno/i4mn
        /jR9QIEsogVxNJaDj+YGo60w1gQ/Q0oK9xtS6wc=
X-Google-Smtp-Source: AMsMyM4g30rMn7ttr3kmUknQLn0B6kDhz7ZpDkkcubdeZ1P3YWFfXRnItKHKxtKiOIH71IhPwoN5tzSJ6Lqj8v1ZwQQ=
X-Received: by 2002:a05:6e02:19ce:b0:2fc:3a29:f89f with SMTP id
 r14-20020a056e0219ce00b002fc3a29f89fmr9428145ill.219.1666251222545; Thu, 20
 Oct 2022 00:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <20221003234929.186290-1-gengcixi@gmail.com> <Y1AEngC3y9+OyG5S@matsya>
In-Reply-To: <Y1AEngC3y9+OyG5S@matsya>
From:   Cixi Geng <gengcixi@gmail.com>
Date:   Thu, 20 Oct 2022 15:33:06 +0800
Message-ID: <CAF12kFsKV3dY4pTxv5TxHZ0=WWnNRtjTwJfzrrs0_9YGvBwu_w@mail.gmail.com>
Subject: Re: [PATCH V2] dmaengine: sprd: Support two-stage dma interrupt
To:     Vinod Koul <vkoul@kernel.org>
Cc:     orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Cixi Geng <cixi.geng1@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Vinod Koul <vkoul@kernel.org> =E4=BA=8E2022=E5=B9=B410=E6=9C=8819=E6=97=A5=
=E5=91=A8=E4=B8=89 22:07=E5=86=99=E9=81=93=EF=BC=9A
>
> On 04-10-22, 07:49, Cixi Geng wrote:
> > From: Cixi Geng <cixi.geng1@unisoc.com>
> >
> > Audio need to request Audio CP global dma interrupt, so Audio CP
> > DMA should support two-stage interrupt to adapte it.
> > It will occur interrupt when two-stage dma channel transfer done.
>
> The patch looks fine to me but...
>
> > diff --git a/include/linux/dma/sprd-dma.h b/include/linux/dma/sprd-dma.=
h
> > index d09c6f6f6da5..26de41d6d915 100644
> > --- a/include/linux/dma/sprd-dma.h
> > +++ b/include/linux/dma/sprd-dma.h
>
> >  enum sprd_dma_int_type {
> >       SPRD_DMA_NO_INT,
> > @@ -112,6 +120,10 @@ enum sprd_dma_int_type {
> >       SPRD_DMA_TRANS_BLK_INT,
> >       SPRD_DMA_LIST_INT,
> >       SPRD_DMA_CFGERR_INT,
> > +     SPRD_DMA_SRC_CHN0_INT,
> > +     SPRD_DMA_SRC_CHN1_INT,
> > +     SPRD_DMA_DST_CHN0_INT,
> > +     SPRD_DMA_DST_CHN1_INT,
>
> why is sprd_dma_int_type part of driver interface. sprd_dma_int_type is
> used only by this driver and should be moved into the driver..
>
> Can you change that as well please
the two-stage interrupts added need more discuss and test,
anyway, I can create a new patch for the change to move init_type into driv=
er,
>
> --
> ~Vinod
