Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFA1251C22
	for <lists+dmaengine@lfdr.de>; Tue, 25 Aug 2020 17:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgHYPU2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Aug 2020 11:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgHYPU0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 25 Aug 2020 11:20:26 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125EDC061574;
        Tue, 25 Aug 2020 08:20:26 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id z195so8891110oia.6;
        Tue, 25 Aug 2020 08:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q+RMk5wvoqYVTQjyw9GbUNNJ6WQtEUUd/c3ecY2vkpY=;
        b=RSF0aVZCnRpnvapcXXDPeJL4Z812mMOogWe2XKyLGbg4HRBCINbBQEgTwTkCBaERj6
         /XaH702noT121NOZzEP1yTSRAPW31PGWYmDnNl2Wf15uJExXhl3C8STKv6DJ4MtdyqT2
         EhbJL1JTOjK9JgVzwcVKtpGu5QMiATBc4zAM2aOTCRZGZpvjzG4vHabgzthPU5nUFdRk
         rO3LiNzI58Ib+lG9mqrghS41ctbPxTDA26wCbxLF4Pe2QurLq+vl+YIkBHX6hOC2TBuz
         TmRiScL4ocnnVztRbRl8kJ+cL2/GkOo3mTitCn6xfIiapTTHU5ZvwRjhvO4imkFU6Qp1
         FcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q+RMk5wvoqYVTQjyw9GbUNNJ6WQtEUUd/c3ecY2vkpY=;
        b=NfgmZaX/qJX13TQUYNxiwoT9a2Rzhsx3Bg8zXiYAL0+AczZWOszstzaMw+A3/Aq+yf
         K3uBxVWUEtGKGm1lyYqveShqRWUJ1vFsE+LckSBZLo1+l/UEAAt1GRwGkf3+8Zp0r1Wn
         htWuwgYDab95lSS/fbOPH9YSOc0/qvIBSCNBaCiQfWiCDVYTugznwrkvoNQlOd7EJDin
         3jOwQnveq9Dp4y833KgQd2dt8MFLfJl44BORIyaFOWgmFDV0u/dailaLMcDmblvEigw2
         nClcExX//yf8CCoKXi5eC9pduVPAsBQwvFnBA+EweRF43LKMBpy4Juegsxi1M2t7Y0ay
         5HFA==
X-Gm-Message-State: AOAM530wX8k8AbzDlhN7Ym2oF/AZsiQMy8olXj+ErJ6ZpOVKHSoWkG1C
        /wZMGJHE2vKSgd+yAwAvgmqtAYi0EiroU5fnOhPuoyvEy4Q=
X-Google-Smtp-Source: ABdhPJwubsbMhk3N5K1XreQ6Lx/R1j+L+VAnnbBIZ+ffdw6J6wbP+cjZhnRGIUbtxCOOGu9EqdiJ6V8ll55ds3e9pKY=
X-Received: by 2002:a05:6808:9a7:: with SMTP id e7mr1267408oig.124.1598368825486;
 Tue, 25 Aug 2020 08:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200825124840.43664-1-alexandru.ardelean@analog.com>
 <20200825144619.GR2639@vkoul-mobl> <CA+U=Dsra7JT9X036M6PruJpQPw-Ht_4A83M1T0L-PdByHg+wAw@mail.gmail.com>
In-Reply-To: <CA+U=Dsra7JT9X036M6PruJpQPw-Ht_4A83M1T0L-PdByHg+wAw@mail.gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 25 Aug 2020 18:20:14 +0300
Message-ID: <CA+U=DsoMBcoB+=r3L4j-w8cxv7eovNCtrHWVi_Y2ywRTh5QRHQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] dmaengine: axi-dmac: add support for reading bus
 attributes from register
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        dmaengine@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, dan.j.williams@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Aug 25, 2020 at 6:14 PM Alexandru Ardelean
<ardeleanalex@gmail.com> wrote:
>
> On Tue, Aug 25, 2020 at 5:46 PM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > On 25-08-20, 15:48, Alexandru Ardelean wrote:
> > > The series adds support for reading the DMA bus attributes from the
> > > INTERFACE_DESCRIPTION (0x10) register.
> > >
> > > The first 5 changes are a bit of rework prior to adding the actual
> > > change in patch 6, as things need to be shifted around a bit, to enable
> > > the clock to be enabled earlier, to be able to read the version
> > > register.
> >
> > Not sure what happened, I see two sets of patches in this series, maybe
> > duplicate..? Better to resend a clean version..
> >
> > Even PW shows 12 patches https://patchwork.kernel.org/project/linux-dmaengine/list/
>
> I'm not sure either.
> I checked the folder from where I sent the patches.
> They're still there, and only 6 { + cover letter].
>
> Will re-send.

My bad.
In the bash history I found that I put *.patch & v2-*.patch when sending.
They were mixed in with some CC'ed emails so I didn't see it before.

>
> >
> > Thanks
> >
> > >
> > > Changelog v1 -> v2:
> > > * fixed error-exit paths for the clock move patch
> > >   i.e. 'dmaengine: axi-dmac: move clock enable earlier'
> > > * fixed error-exit path for patch
> > >   'axi-dmac: wrap channel parameter adjust into function'
> > > * added patch 'dmaengine: axi-dmac: move active_descs list init after device-tree init'
> > >   the list of active_descs can be moved a bit lower in the init/probe
> > >
> > > Alexandru Ardelean (6):
> > >   dmaengine: axi-dmac: move version read in probe
> > >   dmaengine: axi-dmac: move active_descs list init after device-tree
> > >     init
> > >   dmaengine: axi-dmac: move clock enable earlier
> > >   dmaengine: axi-dmac: wrap entire dt parse in a function
> > >   dmaengine: axi-dmac: wrap channel parameter adjust into function
> > >   dmaengine: axi-dmac: add support for reading bus attributes from
> > >     registers
> > >
> > >  drivers/dma/dma-axi-dmac.c | 138 ++++++++++++++++++++++++++++---------
> > >  1 file changed, 107 insertions(+), 31 deletions(-)
> > >
> > > --
> > > 2.17.1
> >
> > --
> > ~Vinod
