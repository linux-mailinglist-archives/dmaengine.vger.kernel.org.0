Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8812649BC0F
	for <lists+dmaengine@lfdr.de>; Tue, 25 Jan 2022 20:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiAYT2f (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Jan 2022 14:28:35 -0500
Received: from mail-pl1-f175.google.com ([209.85.214.175]:35700 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiAYT2c (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 25 Jan 2022 14:28:32 -0500
Received: by mail-pl1-f175.google.com with SMTP id d18so7633582plg.2;
        Tue, 25 Jan 2022 11:28:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rkz5i91jrZJto37j3RGSd05f/eRfvo2BCm796nin8Vs=;
        b=XRSGOlm1VFqT3avvfzptjdr/V8D9yTVMulgMxGpZ7G7ejzNVUmBrSCSSzGdQIbyBGA
         wLOATfMRkgFf7AKjLokOWmvQ71CTQzSyBSMu32dH9GIJwiRDS5KY51i2SYfY0XPneHL/
         ryCWbdsIcvWIxwUcQruluk6MN1ULgD5779AyhvV50OPqRmw+gqJ494us1srnl3Ds/4Tw
         FA+szLQkz+NTKT5gBSs8lhlo3if8ALpz98+fE8QN7vc+AWMtHB22xJKpNFyz/WEPjT5a
         EUJbOhxxGarJRbtGkRONvQB963Qct9mbEQnP1NF+wi7cC9Cppqh/vlLxWz03d0sdhqgn
         bGnA==
X-Gm-Message-State: AOAM533sXRFtcUNigiJ0DQlIB32sZGa/bv9zSZa0r8EZkSOwfSQbHV9n
        CPnYdKZ9giKc43jEewCH4OA=
X-Google-Smtp-Source: ABdhPJyeNd/r+jQn3mMtMf9He8DTH104dq3dEwAvQtFQxWx1zXikeSDUCeamDKcdFDb0ku5F8bxZDQ==
X-Received: by 2002:a17:902:6bc9:b0:149:fdf1:f031 with SMTP id m9-20020a1709026bc900b00149fdf1f031mr19734916plt.58.1643138906187;
        Tue, 25 Jan 2022 11:28:26 -0800 (PST)
Received: from localhost ([2601:647:5b00:ece0:aab:34ff:52ca:a7a5])
        by smtp.gmail.com with ESMTPSA id qe15sm1162214pjb.47.2022.01.25.11.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 11:28:25 -0800 (PST)
Date:   Tue, 25 Jan 2022 11:28:24 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     arnd@arndb.de, hch@infradead.org, akpm@linux-foundation.org,
        rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        davem@davemloft.net, airlied@linux.ie, vkoul@kernel.org,
        hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, awalls@md.metrocast.net, mchehab@kernel.org,
        sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com, mporter@kernel.crashing.org,
        alex.bou9@gmail.com, bhelgaas@google.com,
        linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-media@vger.kernel.org,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 00/16] Remove usage of the deprecated "pci-dma-compat.h"
 API
Message-ID: <YfBPWB9m5TWcZuFY@epycbox.lan>
References: <cover.1641500561.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1641500561.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jan 06, 2022 at 10:45:13PM +0100, Christophe JAILLET wrote:
> This serie axes all the remaining usages of the deprecated "pci-dma-compat.h"
> API.
> 
> All these patches have already been posted.
> 
> They have been generated with a coccinelle script.
> The tricky parts are patches that use dma_alloc_coherent() because the correct
> GFP flag has to be used in place of the previous embedded GFP_ATOMIC.
> 
> Patches 1-3 are already Reviewed. References to the corresponding mail is
> given below the ---
> 
> Patch 1-2,4-10 are just generated from the coccinelle script. Only too long
> lines have been hand modified. dma_alloc_coherent() modification are NOT part
> of these patches.
> 
> Patch 3 also includes some 'dma_set_mask_and_coherent()' instead of
> 'pci_set_dma_mask()/pci_set_consistent_dma_mask()'.
> I've left this additional modification because it was reviewed with it.
> 
> Patch 10-15 are the tricky parts. Explanation of which GFP flag is the right one
> is given in each patch. It has been divided in several patches to ease review.
> 
> Patch 15 is the only one I'm slighly unsure with. The old code was using a
> GFP_USER flag in the function. I'm not familiar with it.
> I *guess*  that GFP_KERNEL is fine, but maybe it should also be GFP_USER or left
> as GFP_ATOMIC so that nothing is changed.
> 
> Patch 16 is the last step that remove "pci-dma-compat.h" and its only usage.
> 
> 
> All patches, exept 1-2,6 that are architecture specific, have been compile tested.
> 
> 
> After all that, a few rst files, 1 or 2 strings in error messages and some
> error branching labels should still need some attention. 
> This is some minor issues.
> 
> 
> Only the cover letter is sent to every one. Each patch is sent to the
> corresponding maintainer(s) + Andrew Morton, Christoph Hellwig and Arnd Bergmann.
> 
> 
> Best regards.
> 
> 
> Christophe JAILLET (16):
>   alpha: Remove usage of the deprecated "pci-dma-compat.h" API
>   floppy: Remove usage of the deprecated "pci-dma-compat.h" API
>   fpga: dfl: pci: Remove usage of the deprecated "pci-dma-compat.h" API
>   media: Remove usage of the deprecated "pci-dma-compat.h" API
>   agp/intel: Remove usage of the deprecated "pci-dma-compat.h" API
>   sparc: Remove usage of the deprecated "pci-dma-compat.h" API
>   dmaengine: pch_dma: Remove usage of the deprecated "pci-dma-compat.h"
>     API
>   rapidio/tsi721: Remove usage of the deprecated "pci-dma-compat.h" API
>   media: v4l2-pci-skeleton: Remove usage of the deprecated
>     "pci-dma-compat.h" API
>   scsi: message: fusion: Remove usage of the deprecated
>     "pci-dma-compat.h" API
>   scsi: mptbase: Use dma_alloc_coherent() in 'mpt_alloc_fw_memory()'
>   scsi: mptbase: Use dma_alloc_coherent()
>   scsi: mptsas: Use dma_alloc_coherent() in
>     mptsas_exp_repmanufacture_info()
>   scsi: mptsas: Use dma_alloc_coherent()
>   scsi: mptctl: Use dma_alloc_coherent()
>   PCI: Remove usage of the deprecated "pci-dma-compat.h" API
> 
>  arch/alpha/include/asm/floppy.h     |   7 +-
>  arch/alpha/kernel/pci_iommu.c       |  12 +--
>  arch/powerpc/include/asm/floppy.h   |   8 +-
>  arch/sparc/kernel/ioport.c          |   2 +-
>  drivers/char/agp/intel-gtt.c        |  26 ++---
>  drivers/dma/pch_dma.c               |   2 +-
>  drivers/fpga/dfl-pci.c              |  14 +--
>  drivers/media/pci/cx18/cx18-queue.h |   6 +-
>  drivers/media/pci/ivtv/ivtv-queue.h |  25 +++--
>  drivers/media/pci/ivtv/ivtv-udma.h  |   8 +-
>  drivers/message/fusion/mptbase.c    | 149 ++++++++++++++++------------
>  drivers/message/fusion/mptctl.c     |  82 +++++++++------
>  drivers/message/fusion/mptlan.c     |  90 +++++++++--------
>  drivers/message/fusion/mptsas.c     |  94 +++++++++---------
>  drivers/rapidio/devices/tsi721.c    |   8 +-
>  include/linux/pci-dma-compat.h      | 129 ------------------------
>  include/linux/pci.h                 |   3 -
>  samples/v4l/v4l2-pci-skeleton.c     |   2 +-
>  18 files changed, 289 insertions(+), 378 deletions(-)
>  delete mode 100644 include/linux/pci-dma-compat.h
> 
> -- 
> 2.32.0
> 
Applied [03/16] to linux-fpga for-next.

Thanks,
Moritz
