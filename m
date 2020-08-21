Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82AA224CB33
	for <lists+dmaengine@lfdr.de>; Fri, 21 Aug 2020 05:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgHUDQY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Aug 2020 23:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbgHUDQX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Aug 2020 23:16:23 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0339C061385;
        Thu, 20 Aug 2020 20:16:22 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id x6so323097pgx.12;
        Thu, 20 Aug 2020 20:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zuSfrbRroXjdvycDvIKeih7mu1rrI15reoeLUG4u7xg=;
        b=MO/bFuRiKH6hf5dJApCZCir/8evOymPRRUSN+uJy3KDAIjWRhxKu+ebYmc2P2q+bCr
         daLgzJQPaQQZWr2W95guKOrpFvLaQE6scTY00kbhjNVKJKfvHAqxait9qGYLNFbbAmxg
         utGtWnrOBuYtGQPMb2y6lCDdg1tO308bit4SPmgYxef+gvKzslF5m1H+zRbGNFKi1t0F
         yU2I4dEntx+5GQjyu/UiaB7Ya8XLBkTV+HoCCQKowT0wRbtVmSAX05olaPYOH0H3doJ8
         /gnkbBJ5N16n5PWkthfMHcQSasfkFE5s8b4p2I+DVo7Mx6jWeC6Z5/9bZbYpoSwX36ej
         MXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zuSfrbRroXjdvycDvIKeih7mu1rrI15reoeLUG4u7xg=;
        b=NExE8Qm3lKKHdAI7pc2cFFNGq2XxiAJoWOpgwKJ+bTC7Zvyx1X9FmxrqqVHV8Mksnj
         2jAwaB9x4amlBVjjefX48zgx/qA9fxyuO+SePMHFIO9eMOi+1lNCPV/ztwMz2hIuwVkC
         wTds58a4S02qYRjWGV5mBtkXvaQMcoGAhQuhFCzK0ACIPr0A8bZLHfHhsO1KAQBLpB1H
         VeLMYcIN8cmBMut6chJ+P3dTfOyZXoXqx3ZEikmmumVE9aP3WvwFC8KR97hIElMKv2R3
         S5w5q3V0iPBRMM6ZtULfBNmANUdbgBkzMjM1QdtT6cwIRbDVgULeUlzoJdkjnWiNN1Vm
         0KFA==
X-Gm-Message-State: AOAM530fjA3SPQV1SrVrCsVjuIRBaVizuLO7V8cMz3YTh7k8lLZoarNP
        r6gcHS0n+hxTfyYph/uc9A==
X-Google-Smtp-Source: ABdhPJyLLFifq2ZsJQXiLNv6WVOo8gqDR4lttb0FPvu3Js2UMJbg2rwIgy8M5GxbRUDMfeDFF1SMHQ==
X-Received: by 2002:a63:e747:: with SMTP id j7mr846297pgk.107.1597979782380;
        Thu, 20 Aug 2020 20:16:22 -0700 (PDT)
Received: from madhuparna-HP-Notebook ([2402:3a80:cfa:ca54:b051:6744:d734:a674])
        by smtp.gmail.com with ESMTPSA id y1sm568390pfr.207.2020.08.20.20.16.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Aug 2020 20:16:21 -0700 (PDT)
From:   Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
X-Google-Original-From: Madhuparna Bhowmik <change_this_user_name@gmail.com>
Date:   Fri, 21 Aug 2020 08:46:16 +0530
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        madhuparnabhowmik10@gmail.com, dan.j.williams@intel.com,
        vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrianov@ispras.ru,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] drivers/dma/dma-jz4780: Fix race condition between probe
 and irq handler
Message-ID: <20200821031616.GA7874@madhuparna-HP-Notebook>
References: <20200816072253.13817-1-madhuparnabhowmik10@gmail.com>
 <ZM2DFQ.KQQJYLJ02WTD3@crapouillou.net>
 <e1961c04-e2aa-fe3a-fb84-bb3b33fae5dc@metafoo.de>
 <VHLDFQ.HR10VPMY1GHD3@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <VHLDFQ.HR10VPMY1GHD3@crapouillou.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Aug 20, 2020 at 08:46:43PM +0200, Paul Cercueil wrote:
>=20
>=20
> Le jeu. 20 ao=FBt 2020 =E0 20:23, Lars-Peter Clausen <lars@metafoo.de> a =
=E9crit :
> > On 8/20/20 1:59 PM, Paul Cercueil wrote:
> > > Hi,
> > >=20
> > > Le dim. 16 ao=FBt 2020 =E0 12:52, madhuparnabhowmik10@gmail.com a =E9=
crit
> > > :
> > > > From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > > >=20
> > > > In probe IRQ is requested before zchan->id is initialized which
> > > > can be
> > > > read in the irq handler. Hence, shift request irq and enable
> > > > clock after
> > > > other initializations complete. Here, enable clock part is not
> > > > part of
> > > > the race, it is just shifted down after request_irq to keep the
> > > > error
> > > > path same as before.
> > > >=20
> > > > Found by Linux Driver Verification project (linuxtesting.org).
> > > >=20
> > > > Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > >=20
> > > I don't think there is a race at all, the interrupt handler won't be
> > > =7Fcalled before the DMA is registered.
> > >=20
> > From a purely formal verification perspective there is a bug. The
> > interrupt could fire if i.e. the hardware is buggy or something. In
> > general it is a good idea to not request the IRQ until all the resources
> > that are used in the interrupt handler are properly set up. Even if you
> > know that in practice the interrupt will never fire this early.
> >=20
>
> Fair enough, I'm fine with that, but the patch should be reworked so that
> the clk_prepare_enable() call is not moved.
>

Sure, I will send the v2 of the patch with this change soon.

Thanks,
Madhuparna
> Cheers,
> -Paul
>=20
>=20
