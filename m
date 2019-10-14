Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1614D5D76
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2019 10:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbfJNIah (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Oct 2019 04:30:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfJNIah (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 14 Oct 2019 04:30:37 -0400
Received: from localhost (unknown [122.167.124.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83B5C20873;
        Mon, 14 Oct 2019 08:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571041836;
        bh=pzx2a4+gtimMDY/H1zTjMD6F+r1Ky2VYeb6/PVRnv84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HL4tcFX850OdWfyKl5gMt1JCpVNADA3j8KOlJWHeBOTak1X7EAHgqheIovTpuevmZ
         +Qxs7ilLooplHcmWIyG2Vgw8ERibstkgTEHKE1CeiBCrL+9nz7sTAe0WiqNDRuBari
         LD1kzyW/ZGJZznbyYn/rJWdzUhK5FgjkXQOyCOaU=
Date:   Mon, 14 Oct 2019 14:00:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc:     Vinod Koul <vinod.koul@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH] dmaengine: bcm-sba-raid: Handle mbox_request_channel
 failure
Message-ID: <20191014083031.GP2654@vkoul-mobl>
References: <1547100464-7020-1-git-send-email-rayagonda.kokatanur@broadcom.com>
 <3d5497d8-7275-1461-8b59-b3695838be45@broadcom.com>
 <CAHO=5PE_Y2sx1pVnG79_JD_AFU8Vtu+e6PfCnBZDVLAcms64ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHO=5PE_Y2sx1pVnG79_JD_AFU8Vtu+e6PfCnBZDVLAcms64ug@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Rayagonda,

On 27-09-19, 09:38, Rayagonda Kokatanur wrote:
> Hi Vinod,
> 
> Did you get chance to review this fix?

Please do *not* top post

And on your question, sorry this is not in my queue somehow, please
rebase and repost

> 
> Best regards,
> Rayagonda
> 
> 
> On Thu, Jan 10, 2019 at 11:06 PM Ray Jui <ray.jui@broadcom.com> wrote:
> >
> >
> >
> > On 1/9/2019 10:07 PM, Rayagonda Kokatanur wrote:
> > > Fix kernel NULL pointer dereference error when mbox_request_channel()
> > > fails to allocate channel.
> > >
> > > Fixes: 4e9f8187aecb ("dmaengine: bcm-sba-raid: Use only single mailbox channel")
> > > Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> > > ---
> > >  drivers/dma/bcm-sba-raid.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
> > > index 72878ac5c78d..77ae74663a45 100644
> > > --- a/drivers/dma/bcm-sba-raid.c
> > > +++ b/drivers/dma/bcm-sba-raid.c
> > > @@ -1690,7 +1690,7 @@ static int sba_probe(struct platform_device *pdev)
> > >       sba->mchan = mbox_request_channel(&sba->client, 0);
> > >       if (IS_ERR(sba->mchan)) {
> > >               ret = PTR_ERR(sba->mchan);
> > > -             goto fail_free_mchan;
> > > +             goto fail_exit;
> > >       }
> > >
> > >       /* Find-out underlying mailbox device */
> > > @@ -1747,6 +1747,7 @@ static int sba_probe(struct platform_device *pdev)
> > >       sba_freeup_channel_resources(sba);
> > >  fail_free_mchan:
> > >       mbox_free_channel(sba->mchan);
> > > +fail_exit:
> > >       return ret;
> > >  }
> > >
> > >
> >
> > Looks good to me.
> >
> > Reviewed-by: Ray Jui <ray.jui@broadcom.com>

-- 
~Vinod
