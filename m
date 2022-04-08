Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1F64F9D74
	for <lists+dmaengine@lfdr.de>; Fri,  8 Apr 2022 21:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbiDHTHq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 8 Apr 2022 15:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239160AbiDHTH0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 8 Apr 2022 15:07:26 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DF9FC8BB;
        Fri,  8 Apr 2022 12:05:21 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id w134so16685533ybe.10;
        Fri, 08 Apr 2022 12:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZEcUtO2v/WlLzjxpQ7XpDI1V7ziKO5fo7ZWmNgWyPtE=;
        b=PmwYKhlSZA/KBCRPNtd2dgeerhXTTV4HcPhWCqhmVQW8rqtZ3ySJOyOZFE6SFTuT2/
         6LHy2CXzw3E3h7dMJu6eUYQG+i59cBdqrD1F64GyYqj97zF/tUFotVrnMMF08n2cnHvH
         oUxSxlpOBnwNQ6UWf+BF+tExLLL+eygA9CCm7LrNOWEiFv+75805wT9u0r7YFVk2YwB+
         zpf/6e1qHwN/SEq3cWF+GsxgUC50vvLutdnY0J/5lmjS0g+s4NqmAu2V0f6i+41WGaZe
         S7C+IKMWEeVKIGgmqB4ySdzYdCp9/gzS9/RdP/hmxfnxM3df2yXJ3dP4qGVaDnTTycz4
         +K6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZEcUtO2v/WlLzjxpQ7XpDI1V7ziKO5fo7ZWmNgWyPtE=;
        b=ma0th36dWyAlDZLbNl4VIyHfox9l05lngm1xHxbMASoAeYMqgG/6W0ae7LJIZDIPMw
         GQfJ46gpx5JWqrTHLjCIJHkxfyLmM7sFSh+jr2IKawgajNtqlepr4ZXN6sBXEyg5eeN8
         Idmz5D0LvmdVfLmSXbeQgXWzaQXmjYzhqGXa924pUXrqdgwbA1SxuT4vu2PIUSIyj2oB
         o6MFNSuMfBgvWHEC+WeiprsVRTxC0bEs5zd2zVbDA4rjaILJ9xsT3VFjddtXDqy7Bw39
         ZPWTG1ROd5KIlLxHtFSyyg7GNnJLi5bmfaoYkZ+XmIGkrB33OU0dBxfbouT+8pUnYvGq
         3xFw==
X-Gm-Message-State: AOAM530GFtHoolX1ir9pHFQikP+bVQYMB+snNszeRN9gFgETWAOlxnKW
        isGCw7didbcDwjYehacDh94cuTtyJBG6hICIEI+8z4PH1cseGGUk
X-Google-Smtp-Source: ABdhPJz+8CCXiO27jq0dSiJ6LlWduDnYBfFknVvzuuyWJRga0JVZZhWwKMlh3h+sIxMLVSFCj5zFUulBf8L6BaQRT9A=
X-Received: by 2002:a05:6902:1083:b0:63e:5325:d6b0 with SMTP id
 v3-20020a056902108300b0063e5325d6b0mr7319082ybu.431.1649444720478; Fri, 08
 Apr 2022 12:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220404155557.27316-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CA+V-a8tM3EiZkNSCG+CtrOnfGBc5WSaac__FBsRn72zrsjQ2ew@mail.gmail.com> <YlB07XRDWPHF7VaI@matsya>
In-Reply-To: <YlB07XRDWPHF7VaI@matsya>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 8 Apr 2022 20:04:54 +0100
Message-ID: <CA+V-a8uJPk48p4sE6eLTdaGyE5FwuLYD3oke5GPqf05ocHFESw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] dmaengine: Use platform_get_irq*() variants to
 fetch IRQ's
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On Fri, Apr 8, 2022 at 6:46 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 07-04-22, 03:52, Lad, Prabhakar wrote:
> > Hi Vinod,
> >
> > On Mon, Apr 4, 2022 at 4:56 PM Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > >
> > > Hi All,
> > >
> > > This patch series aims to drop using platform_get_resource() for IRQ types
> > > in preparation for removal of static setup of IRQ resource from DT core
> > > code.
> > >
> > Fyi.. the OF core changes have landed into -next [0].
> >
> > [0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20220406&id=a1a2b7125e1079cfcc13a116aa3af3df2f9e002b
>
> Is this series dependent on this?
>
Yes, if this series doesn't hit soon this will break the drivers.

Cheers,
Prabhakar
