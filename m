Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC0F251BFC
	for <lists+dmaengine@lfdr.de>; Tue, 25 Aug 2020 17:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgHYPPE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Aug 2020 11:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgHYPPB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 25 Aug 2020 11:15:01 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B271BC061574;
        Tue, 25 Aug 2020 08:15:01 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id z22so11906392oid.1;
        Tue, 25 Aug 2020 08:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s4p9YQ24Yqz5BWvKJez6nOG2+kXTy6OCMRyd8gMw2b4=;
        b=b0K/GrxtX8vI+99lOoFZbuj940Cos9IJqqnF8kg1Gq6IxvdZoFbwuVJ7rrsYx2ZDXU
         STM/ATTwMVtGTl9VmsdeLS5dPiW9XUQ38MQ0Xs+6hl3SGiN5giPY3gtwfFsWHObG30NZ
         x5jDR3enXgdZF6oyUHbnpCDYi/MuDCNWGkoo8Sycivu2A0wqdfPgaF5C2wfxVap4qn7H
         LfsaFDteUuh3Wp5kVuC9Qz5A09Km7he5l9B/qqvIGx9ryjbHD+om4nMCKTcYJ7KMeRSx
         4GUYAjPHEnzGm8DfX1FSbEzwYS3Fx0WTM7Vlbax+oaFPJZNEByEN2vWHhYjIUn1saU/g
         GzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s4p9YQ24Yqz5BWvKJez6nOG2+kXTy6OCMRyd8gMw2b4=;
        b=GS+xP++KJ8zxntOWBLpprVDZg4eRoOofo4eEI74/sehbEMf8WIjFaqEH3b1EZFmrEM
         F+kMF8ycoT2e3jQC0Btj/APfGXT6kcgtpWNaLrRFBooAmTZ0BinnOTwxeMgBLlXYUmkx
         EAx+1AvN7+weXNPk351PMyE9aQSyyKJxndm9u8ojXMXz26aNRQzrxnithfRA9xCBWHxZ
         h/kz0OUVfrUXNB+VbSb4Xxjv19TvMn56WhdxPGjBq83DLQ27cZ+Z4+9vHLb6nKSCoB+h
         orkKRD5u2theSJgcq3yr7TEmhw/P92UM5TMCgHGP9HVrlIUA92Pouez6prlOIJ17fYcm
         +8Gw==
X-Gm-Message-State: AOAM532OazEvdm6VhY++Rt3U1vbVrTwsfQp45I3m9BxMRDAxo3TXX5Ha
        GjdzUmZ3ixJghWapaHD3qDz7QqrFb+wDw/egFV4=
X-Google-Smtp-Source: ABdhPJzC71ZGDUw6CCwEsPEXn2P1h/sJFbUDsBxR+bQn4pvVUQe5ZevafM0STXXFqKpIMjKdcqJEmWI7XNk+TuxMLms=
X-Received: by 2002:aca:304b:: with SMTP id w72mr1234294oiw.117.1598368501009;
 Tue, 25 Aug 2020 08:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200825124840.43664-1-alexandru.ardelean@analog.com> <20200825144619.GR2639@vkoul-mobl>
In-Reply-To: <20200825144619.GR2639@vkoul-mobl>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 25 Aug 2020 18:14:50 +0300
Message-ID: <CA+U=Dsra7JT9X036M6PruJpQPw-Ht_4A83M1T0L-PdByHg+wAw@mail.gmail.com>
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

On Tue, Aug 25, 2020 at 5:46 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 25-08-20, 15:48, Alexandru Ardelean wrote:
> > The series adds support for reading the DMA bus attributes from the
> > INTERFACE_DESCRIPTION (0x10) register.
> >
> > The first 5 changes are a bit of rework prior to adding the actual
> > change in patch 6, as things need to be shifted around a bit, to enable
> > the clock to be enabled earlier, to be able to read the version
> > register.
>
> Not sure what happened, I see two sets of patches in this series, maybe
> duplicate..? Better to resend a clean version..
>
> Even PW shows 12 patches https://patchwork.kernel.org/project/linux-dmaengine/list/

I'm not sure either.
I checked the folder from where I sent the patches.
They're still there, and only 6 { + cover letter].

Will re-send.

>
> Thanks
>
> >
> > Changelog v1 -> v2:
> > * fixed error-exit paths for the clock move patch
> >   i.e. 'dmaengine: axi-dmac: move clock enable earlier'
> > * fixed error-exit path for patch
> >   'axi-dmac: wrap channel parameter adjust into function'
> > * added patch 'dmaengine: axi-dmac: move active_descs list init after device-tree init'
> >   the list of active_descs can be moved a bit lower in the init/probe
> >
> > Alexandru Ardelean (6):
> >   dmaengine: axi-dmac: move version read in probe
> >   dmaengine: axi-dmac: move active_descs list init after device-tree
> >     init
> >   dmaengine: axi-dmac: move clock enable earlier
> >   dmaengine: axi-dmac: wrap entire dt parse in a function
> >   dmaengine: axi-dmac: wrap channel parameter adjust into function
> >   dmaengine: axi-dmac: add support for reading bus attributes from
> >     registers
> >
> >  drivers/dma/dma-axi-dmac.c | 138 ++++++++++++++++++++++++++++---------
> >  1 file changed, 107 insertions(+), 31 deletions(-)
> >
> > --
> > 2.17.1
>
> --
> ~Vinod
