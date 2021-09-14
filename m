Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2E940A8E0
	for <lists+dmaengine@lfdr.de>; Tue, 14 Sep 2021 10:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbhINIKR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Sep 2021 04:10:17 -0400
Received: from mail-vs1-f50.google.com ([209.85.217.50]:40532 "EHLO
        mail-vs1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbhINII4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Sep 2021 04:08:56 -0400
Received: by mail-vs1-f50.google.com with SMTP id d6so11036605vsr.7;
        Tue, 14 Sep 2021 01:07:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nWdDaNoyy56XWGHXA0NUC5Ev09Q10Kwh4uHK+hjBqzI=;
        b=eq974B+GidpHICQ+F2VXesIo/gNZUtucHCSUalDkZ02sKIVTvNJB3cQg+MLRsm0iV7
         ws6VUpueKT2vJjGJJCC71nrmIRrv4q7zW70XYRcAdWEaqynYrYmCbkFynJMJf4iNUwcy
         LXBS3rCssRvX6EL/pkdv0pyy2HjI3ZGJjBwABS8iUONzuH88Wsgarn09LoVcD67JYrja
         IIZKILQJs+SIuCmy2ElUXwAMZ1+c0COYdO1lZbksKBv43WjSUgomca8BTjR0Z0tn/AVd
         W+CISop/FseeLlnHaWKo2vY2aAyadyw81WcwoI+WmwbwVGYHUJvrMNIRf1Ex7vjshytL
         kkCg==
X-Gm-Message-State: AOAM531xtcjW7E832FMvosJphuphIMekbOzB9asPb8Uxuq0andlFdc8Q
        sO3o0n9TuW+yQ1TedDkJPCkf4NUA24j3XHN+7PDsHE8xtZ4=
X-Google-Smtp-Source: ABdhPJz4EBhW8t60u1EKYSX/bC5dT1gPDiZBr8SCBiGLJLZbHW3dbrj0CBK50Zme9jgr/Xsnbqb7VU76uquoJ7aU7l4=
X-Received: by 2002:a67:d51d:: with SMTP id l29mr5043128vsj.46.1631606852089;
 Tue, 14 Sep 2021 01:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210629103710.24828-1-harini.katakam@xilinx.com> <YQEA0DWG4X8U83/z@matsya>
In-Reply-To: <YQEA0DWG4X8U83/z@matsya>
From:   Harini Katakam <harinik@xilinx.com>
Date:   Tue, 14 Sep 2021 13:37:21 +0530
Message-ID: <CAFcVEC+HuZHnpMy3TWSThwHXBR_W_ZLggKd4hmcjFn459LaLXA@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: pl330: Typecast with enum to fix the coverity warning
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Harini Katakam <harini.katakam@xilinx.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        radhey.shyam.pandey@xilinx.com, shravya.kumbham@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

<snip>
> >       pch->cyclic = true;
> > -     desc->txd.flags = flags;
> > +     desc->txd.flags = (enum dma_ctrl_flags)flags;
>
> Does this driver use the txd.flags?

Sorry for the delayed response. This flag is not used and I'm working
on another patch to remove it.

Regards,
Harini
