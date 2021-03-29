Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5FBA34C35B
	for <lists+dmaengine@lfdr.de>; Mon, 29 Mar 2021 07:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbhC2Fzd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Mar 2021 01:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhC2Fz1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 Mar 2021 01:55:27 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E50FC061574;
        Sun, 28 Mar 2021 22:55:27 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id j7so8584074qtx.5;
        Sun, 28 Mar 2021 22:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=3sxooqOLO1y1jfA0hH8Tp6Do4156/VwnStLOftkWolU=;
        b=Vlx9D3rNBdfV9Twbtu5elSlHPfi5IXXOKF2jGRNyYsk0o4ecYOB2cj/naEcloSDf8R
         alIWlT36rpUX2jLbRw5jNyCb0r3zkvxNLxY/oU79NVWrIxn4iLG00+Wq2kw7CnCQbDa3
         Vq5XIMiUAeKSjU0zJhBu0ZfLTacA025RRUEJktbgtvUYntzC2tJxy9ud0yj4A992QfYd
         E65g7Sytx2VJjQoKcE9L8l3CpsnFO1Ta+UbOF/MzqyHx2L5IPQLP80F+olm2Uu7Gxp2I
         iEptFFxpwRV3Tm3xQzYlhgiHlGq+3tuOwAAYp16fwL5O+70slP3kGBQQx1aeNOGA+OU6
         i2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=3sxooqOLO1y1jfA0hH8Tp6Do4156/VwnStLOftkWolU=;
        b=sUid0KiCoSwNDDrZploOkd8zKYbn55CKZERWQVqyXajjY/wnEWHMfrFvWDOqE8BKt3
         u+IrDTwfKpXCENjix/CO3wpzQAwJcqI4GA1GKrWgSZl0EMdPDaWHWQjKoOGrqaozQ3d3
         XNAUU+GWp7zlKeE7VogHlonUe9AZ6Pxk/1goI2nhfp7Oj941W+RwZxVj1jIrxXZMCmSK
         43cpu0Bam8XhvY08zwvX/cQ5mB97IBbP1ilowGwU0o6frosei6IcTKUI4FgK40iBPFBc
         51WwaI5DsPgG2U0xxbLmckbCLXI53YcXyDHQW66ucBjIhdgbP7q/t/7MzwBeRXXVQDpO
         vTMw==
X-Gm-Message-State: AOAM530KJHu+8SK0HDigSXaaMs+Ems0spqbuWUHTPAqw5NRlFtpqUOdw
        5cMTfqcKBau5N5dP8rnjE8qFXKh/LgMsuEae
X-Google-Smtp-Source: ABdhPJyjMO9PATIBVElUDbHpz1rS/mlZe2xmTsSLkRGrzA/ytq1vxJ2tRlhHienza2FDGcd8/6DVxQ==
X-Received: by 2002:ac8:6f2e:: with SMTP id i14mr21073963qtv.25.1616997326394;
        Sun, 28 Mar 2021 22:55:26 -0700 (PDT)
Received: from Gentoo ([156.146.37.195])
        by smtp.gmail.com with ESMTPSA id f9sm10448869qto.46.2021.03.28.22.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 22:55:25 -0700 (PDT)
Date:   Mon, 29 Mar 2021 11:25:11 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        dave.jiang@intel.com, dan.j.williams@intel.com,
        rdunlap@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/30] DMA: Mundane typo fixes
Message-ID: <YGFrvwX8QngvwPbA@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        dave.jiang@intel.com, dan.j.williams@intel.com,
        rdunlap@infradead.org, linux-kernel@vger.kernel.org
References: <cover.1616971780.git.unixbhaskar@gmail.com>
 <20210329052910.GB26495@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sWMMWipitTWX5OoP"
Content-Disposition: inline
In-Reply-To: <20210329052910.GB26495@lst.de>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--sWMMWipitTWX5OoP
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 07:29 Mon 29 Mar 2021, Christoph Hellwig wrote:
>I really don't think these typo patchbomb are that useful.  I'm all
>for fixing typos when working with a subsystem, but I'm not sure these
>patchbombs help anything.
>
I am sure you are holding the wrong end of the wand and grossly failing to
understand.

Anyway, I hope I give a heads up ...find "your way" to fix those damn
thing...it's glaring....

>On Mon, Mar 29, 2021 at 05:22:56AM +0530, Bhaskar Chowdhury wrote:
>> This patch series fixes some trivial and rudimentary spellings in the COMMENT
>> sections.
>>
>> Bhaskar Chowdhury (30):
>>   acpi-dma.c: Fix couple of typos
>>   altera-msgdma.c: Couple of typos fixed
>>   amba-pl08x.c: Fixed couple of typos
>>   bcm-sba-raid.c: Few typos fixed
>>   bcm2835-dma.c: Fix a typo
>>   idma64.c: Fix couple of typos
>>   iop-adma.c: Few typos fixed
>>   mv_xor.c: Fix a typo
>>   mv_xor.h: Fixed a typo
>>   mv_xor_v2.c: Fix a typo
>>   nbpfaxi.c: Fixed a typo
>>   of-dma.c: Fixed a typo
>>   s3c24xx-dma.c: Fix a typo
>>   Revert "s3c24xx-dma.c: Fix a typo"
>>   s3c24xx-dma.c: Few typos fixed
>>   st_fdma.h: Fix couple of typos
>>   ste_dma40_ll.h: Fix a typo
>>   tegra20-apb-dma.c: Fixed a typo
>>   xgene-dma.c: Few spello fixes
>>   at_hdmac.c: Quite a few spello fixes
>>   owl-dma.c: Fix a typo
>>   at_hdmac_regs.h: Couple of typo fixes
>>   dma-jz4780.c: Fix a typo
>>   Kconfig: Change Synopsys to Synopsis
>>   ste_dma40.c: Few spello fixes
>>   dw-axi-dmac-platform.c: Few typos fixed
>>   dpaa2-qdma.c: Fix a typo
>>   usb-dmac.c: Fix a typo
>>   edma.c: Fix a typo
>>   xilinx_dma.c: Fix a typo
>>
>>  drivers/dma/Kconfig                            |  8 ++++----
>>  drivers/dma/acpi-dma.c                         |  4 ++--
>>  drivers/dma/altera-msgdma.c                    |  4 ++--
>>  drivers/dma/amba-pl08x.c                       |  4 ++--
>>  drivers/dma/at_hdmac.c                         | 14 +++++++-------
>>  drivers/dma/at_hdmac_regs.h                    |  4 ++--
>>  drivers/dma/bcm-sba-raid.c                     |  8 ++++----
>>  drivers/dma/bcm2835-dma.c                      |  2 +-
>>  drivers/dma/dma-jz4780.c                       |  2 +-
>>  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c |  8 ++++----
>>  drivers/dma/idma64.c                           |  4 ++--
>>  drivers/dma/iop-adma.c                         |  6 +++---
>>  drivers/dma/mv_xor.c                           |  2 +-
>>  drivers/dma/mv_xor.h                           |  2 +-
>>  drivers/dma/mv_xor_v2.c                        |  2 +-
>>  drivers/dma/nbpfaxi.c                          |  2 +-
>>  drivers/dma/of-dma.c                           |  2 +-
>>  drivers/dma/owl-dma.c                          |  2 +-
>>  drivers/dma/s3c24xx-dma.c                      |  6 +++---
>>  drivers/dma/sh/shdmac.c                        |  2 +-
>>  drivers/dma/sh/usb-dmac.c                      |  2 +-
>>  drivers/dma/st_fdma.h                          |  4 ++--
>>  drivers/dma/ste_dma40.c                        | 10 +++++-----
>>  drivers/dma/ste_dma40_ll.h                     |  2 +-
>>  drivers/dma/tegra20-apb-dma.c                  |  2 +-
>>  drivers/dma/ti/edma.c                          |  2 +-
>>  drivers/dma/xgene-dma.c                        |  6 +++---
>>  drivers/dma/xilinx/xilinx_dma.c                |  2 +-
>>  28 files changed, 59 insertions(+), 59 deletions(-)
>>
>> --
>> 2.26.3
>---end quoted text---

--sWMMWipitTWX5OoP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBha78ACgkQsjqdtxFL
KRU5tAgAr1C5zvxnwKv4KhR9L2TClLDXSTaUY3OV1okoqlPp80479+s9NxY1Mdfb
/dcKAncDa4LJOBe3vtl6RUzicAL+qMybaswSz7tR+hJjZRreWTpKOpeb/4CVZ2oS
4MHOO6L8fKBFSQtnFKWj0MeNdZzoi+EIxEUKEu3IVZ8LY3Du4rLiiCElBKkxabcV
v/N/kB9dvtqfHpGvire1GfBXJJGdWfWazs0+72IN4OSQacYtAcjgwALObuOP2Zmc
hwsQgJQHEoKr2U1dmFaHlOvnU+qNmOmci4hkdVeF5sD7gFFomwXA3xW9USoMo9W1
1cnEvFduJrGuL/e8jV3xI7KwNQVoUg==
=XlPQ
-----END PGP SIGNATURE-----

--sWMMWipitTWX5OoP--
