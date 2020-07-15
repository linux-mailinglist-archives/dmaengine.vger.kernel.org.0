Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A262204B9
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2020 08:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgGOGD7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jul 2020 02:03:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:56780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbgGOGD7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 15 Jul 2020 02:03:59 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F12E20663;
        Wed, 15 Jul 2020 06:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594793039;
        bh=1lPhEX+gUN5h3SFVmkH1Xm04ko6BKhHxoYzLWu5nClA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V0S5z6fuc6QuujTu5XuCaSzdF1JNAWlWgKlptU3pzyPcNLq/6md1jBNIn34mgCF2O
         eOKJioilQYvaRtRqPxgFMhQ1kaKb5p4E9OCKYwhW01fmP7dTqGGvJtoX7GbsZGk9nw
         4GmW8rHFrFg43vMiRaMdvZn2T2iAznXxsRNe0ujg=
Date:   Wed, 15 Jul 2020 11:33:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: Re: [PATCH -next] dmaengine: idxd: fix PCI_MSI build errors
Message-ID: <20200715060355.GX34333@vkoul-mobl>
References: <9dee3f46-70d9-ea75-10cb-5527ab297d1d@infradead.org>
 <46ae481e-3213-f1e0-604b-177bc876bb93@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46ae481e-3213-f1e0-604b-177bc876bb93@intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-07-20, 07:58, Dave Jiang wrote:
> 
> 
> On 7/13/2020 11:35 PM, Randy Dunlap wrote:
> > From: Randy Dunlap <rdunlap@infradead.org>
> > 
> > Fix build errors when CONFIG_PCI_MSI is not enabled by making the
> > driver depend on PCI_MSI:
> > 
> > ld: drivers/dma/idxd/device.o: in function `idxd_mask_msix_vector':
> > device.c:(.text+0x26f): undefined reference to `pci_msi_mask_irq'
> > ld: drivers/dma/idxd/device.o: in function `idxd_unmask_msix_vector':
> > device.c:(.text+0x2af): undefined reference to `pci_msi_unmask_irq'
> > 
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: dmaengine@vger.kernel.org
> > Cc: Vinod Koul <vkoul@kernel.org>
> 
> Vinod, I submitted this fix patch last week:
> https://patchwork.kernel.org/patch/11649231/
> 
> But I think maybe Randy's patch may be more preferable? You can apply this
> one and ignore my submission.

Ok, Applied this one, thanks
-- 
~Vinod
