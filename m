Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F6969E93F
	for <lists+dmaengine@lfdr.de>; Tue, 21 Feb 2023 22:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjBUVGT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+dmaengine@lfdr.de>); Tue, 21 Feb 2023 16:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjBUVGS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 21 Feb 2023 16:06:18 -0500
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B11301A0;
        Tue, 21 Feb 2023 13:06:17 -0800 (PST)
Received: by mail-qv1-f45.google.com with SMTP id op8so6770978qvb.11;
        Tue, 21 Feb 2023 13:06:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nGc2n13Qzq9F45b7/zTwEGlcQ+HxwWUoXW7d4uMT/QI=;
        b=Xjo3V26+NAx8G2ShHt+g/Cq1PWaVa+GgvEQBCvcDHL+wEvMdwNDFiNjtESrceoqU2P
         cTQXs7GMtwO8cPH1b+QOHnqgpXtnBLpIv9MYlfXafm2yf6oLeISwduyZS/0Vg9Cd6NmL
         skGZpciyIJj/fP7IgfgbGnDF+6K+SNUExisxV+5SVsncDNGj9RuuqdAeeAlN8mAg++n9
         Ea2JX2bVe2Yum2aWX8sULKMxMKvmjt7+1IsC2EqXrsrX7ShLw8ARPPV1GQqJAitfcZS6
         iJ0KM37sJFDi4kWsXXHscvPjsO/GQwVEtYO1KyZaDd1tvBVyQAo93d8xJdeKyq3Km0pB
         wTUQ==
X-Gm-Message-State: AO0yUKXpzrW/uNshd8Vv+DnrADgS/BrxHOnml7QfR2ftUBmzU8K+Z2Z0
        0IlYB3EK0iPgeN+x9AWQDOLFrTRacMELxw==
X-Google-Smtp-Source: AK7set9UlqzCqu7npSle/AH15xlkzr+lPO8TtEjrUR2VUu07Y77NkRYBTExDcV1rfyOFGjZN3OhcnA==
X-Received: by 2002:ad4:5ae4:0:b0:568:c5e3:a0ce with SMTP id c4-20020ad45ae4000000b00568c5e3a0cemr14912589qvh.20.1677013576300;
        Tue, 21 Feb 2023 13:06:16 -0800 (PST)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id 21-20020a370315000000b0073b7889590dsm1574942qkd.111.2023.02.21.13.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 13:06:15 -0800 (PST)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-536b7ffdd34so78784247b3.6;
        Tue, 21 Feb 2023 13:06:15 -0800 (PST)
X-Received: by 2002:a81:ae0c:0:b0:52e:cacb:d7c4 with SMTP id
 m12-20020a81ae0c000000b0052ecacbd7c4mr575233ywh.5.1677013574811; Tue, 21 Feb
 2023 13:06:14 -0800 (PST)
MIME-Version: 1.0
References: <1675969514-3137-1-git-send-email-lizhi.hou@amd.com>
 <1675969514-3137-2-git-send-email-lizhi.hou@amd.com> <CAMuHMdXsUPAW5zKrsaTR9Tgv7kFdkz8s_QUjLXq6zDpoo47fRA@mail.gmail.com>
 <0f1aafa2-7495-163b-523a-f634bacc4b1f@gpxsee.org>
In-Reply-To: <0f1aafa2-7495-163b-523a-f634bacc4b1f@gpxsee.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 21 Feb 2023 22:06:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUVkbPf1a8cW+zY1HwD83tm_m0L7Ufy=GO-RQB-AF_15A@mail.gmail.com>
Message-ID: <CAMuHMdUVkbPf1a8cW+zY1HwD83tm_m0L7Ufy=GO-RQB-AF_15A@mail.gmail.com>
Subject: Re: [RESEND PATCH V12 XDMA 1/2] dmaengine: xilinx: xdma: Add xilinx
 xdma driver
To:     =?UTF-8?B?TWFydGluIFTFr21h?= <tumic@gpxsee.org>
Cc:     Lizhi Hou <lizhi.hou@amd.com>, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        max.zhen@amd.com, sonal.santan@amd.com, larry.liu@amd.com,
        brian.xu@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Martin,

On Tue, Feb 21, 2023 at 9:45 PM Martin Tůma <tumic@gpxsee.org> wrote:
> On 21. 02. 23 14:25, Geert Uytterhoeven wrote:
> > No platform dependencies at all, while this is a platform driver that
> > relies on some other not-yet-existing driver creating an "xdma"
> > platform device?
>
> There is at least one "already-existing" driver based on this driver
> that is waiting in the v4l2 queue for xdma - our MGB4 driver:
> https://patchwork.kernel.org/project/linux-media/patch/20230207150119.5542-2-tumic@gpxsee.org/

Thanks for the link!

As VIDEO_MGB4 selects XILINX_XDMA, perhaps XILINX_XDMA
can be made invisible, unless compile-testing?

    config XILINX_XDMA
        tristate "Xilinx DMA/Bridge Subsystem DMA Engine" if COMPILE_TEST

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
