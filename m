Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA987A5B52
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 09:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjISHjC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 03:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbjISHio (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 03:38:44 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA79F128;
        Tue, 19 Sep 2023 00:38:36 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d9443c01a7336-1c44c0f9138so23389145ad.2;
        Tue, 19 Sep 2023 00:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695109116; x=1695713916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QdisVKFIE99YKvBEdsNzQrVKLp57UGmNrGrdDlX3/L4=;
        b=nn/P1MIdkrnOxsYRFWXAlNDeTyTLdvTvDCFA5t5vQwZud0osUhiw1gXRxfnSo4euY4
         glbGG72M+i3dVLK2hFu5ZG0GIg0ZWSXvNuaY1kvYTIaHFoUqM6h6qz8Fl1K0jW5jf7ug
         HY3pT6xLWy3WApSbSyWCAP3DsmKo/KJWs8cv24rozCCx4prfQK0GmL7g/CtpTuF0UO9O
         7qdUu0FTn/H5UZ879WLjNiv9P7hGgOzO2PcQl+nFY+8k7Swon3C7eGB3AmJ01iQ7tPLs
         T6aWOXNDCmoeZj/D/tO/PVJj1LYllNTtzzjuLLWnOH72dd5QWJcR/eZvIWPKv9dXGasg
         IqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695109116; x=1695713916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QdisVKFIE99YKvBEdsNzQrVKLp57UGmNrGrdDlX3/L4=;
        b=QP7XGoCePQjl4tnsr+noiWUyNxi+qO6czaTVxap6rx4wqI6tkeUdW7vYbmSdxGEpnr
         SkiGIQOhlMjknbtvOIPG7vbkTcl+oUv/9sLPdaGLX0658rPQ4zHKqUDCCiFL3PJq2bK+
         41YJXPm2IT9fCVbPt7MsrC+nwkCJIqzbpKRkCY4AAKAfGewNRI+V8rCX11BZRVRe0EIA
         8apzXkWhZTRAyvH6TWulhxbw9NWseDSy61WN64YO4zCvIb6Lj7LFDhB+xQqJKflAUbwi
         ekVRebS+LUW3r99dZm2m0nWmFVW4HUHIb2ZpmzC/ZVCuteTWspSvQkP53W7oAJYPKBWu
         SJkA==
X-Gm-Message-State: AOJu0YxacsytT7KMhpIW2hS8P1dTU3cqAKzT/0qBMY47za0RhMjM/7BJ
        2bU1zaJM4uni8pbggG4+0bkqk0B+6lSiXr3dnqY=
X-Google-Smtp-Source: AGHT+IGv4tdj/croxIzRqvTHuCi0ETMx5zq7oprP/5wPWALGrZDjvbOpQsTQmm2zIhZMZ8byd+CpUqb5SqCLmnwYuzg=
X-Received: by 2002:a17:90b:1913:b0:276:785f:7edd with SMTP id
 mp19-20020a17090b191300b00276785f7eddmr3483975pjb.25.1695109115980; Tue, 19
 Sep 2023 00:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230919023050.3777-1-kaiwei.liu@unisoc.com> <793afbca-187d-c54f-c479-52cfd1975799@linux.alibaba.com>
In-Reply-To: <793afbca-187d-c54f-c479-52cfd1975799@linux.alibaba.com>
From:   liu kaiwei <liukaiwei086@gmail.com>
Date:   Tue, 19 Sep 2023 15:38:24 +0800
Message-ID: <CAOgAA6Ey_CcdVdDYn7==hGxh0tJjtUWEw74td-_XYoJYGd1Maw@mail.gmail.com>
Subject: Re: [PATCH V2] dmaengine: sprd: add dma mask interface in probe
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Kaiwei Liu <kaiwei.liu@unisoc.com>, Vinod Koul <vkoul@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wenming Wu <wenming.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Baolin, I am sorry that didn't add and commit my changes in PATCH
V2. I have added the changes in PATCH V3, please check the new email,
thank you.

On Tue, Sep 19, 2023 at 11:23=E2=80=AFAM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 9/19/2023 10:30 AM, Kaiwei Liu wrote:
> > In the probe of DMA, the default addressing range is 32 bits,
> > while the actual DMA hardware addressing range used is 36 bits.
> > So add dma_set_mask_and_coherent function to match DMA
> > addressing range.
> >
> > Signed-off-by: Kaiwei Liu <kaiwei.liu@unisoc.com>
> > ---
> > Change in V2:
> > -Change subject line.
> > -Modify error message to make it more readable.
>
> Have you modified the error message against v1? I did not see it.
>
> https://lore.kernel.org/all/20230807052014.2781-1-kaiwei.liu@unisoc.com/
>
> > ---
> >   drivers/dma/sprd-dma.c | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
> > index 20c3cb1ef2f5..0e146550dfbb 100644
> > --- a/drivers/dma/sprd-dma.c
> > +++ b/drivers/dma/sprd-dma.c
> > @@ -1115,6 +1115,15 @@ static int sprd_dma_probe(struct platform_device=
 *pdev)
> >       u32 chn_count;
> >       int ret, i;
> >
> > +     ret =3D dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(36));
> > +     if (ret) {
> > +             ret =3D dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MAS=
K(32));
> > +             if (ret) {
> > +                     dev_err(&pdev->dev, "dma_set_mask_and_coherent fa=
iled\n");
> > +                     return ret;
> > +             }
> > +     }
> > +
> >       /* Parse new and deprecated dma-channels properties */
> >       ret =3D device_property_read_u32(&pdev->dev, "dma-channels", &chn=
_count);
> >       if (ret)
