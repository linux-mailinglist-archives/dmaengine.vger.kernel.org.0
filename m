Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6BA54E25C
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jun 2022 15:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbiFPNr2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Jun 2022 09:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377243AbiFPNrZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Jun 2022 09:47:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089ED37A09
        for <dmaengine@vger.kernel.org>; Thu, 16 Jun 2022 06:47:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41558B82284
        for <dmaengine@vger.kernel.org>; Thu, 16 Jun 2022 13:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32CFEC34114;
        Thu, 16 Jun 2022 13:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655387237;
        bh=rQn8Q1X22/dgmHa0skOG+ZXr01VjLkOSH6eJlkGH2fk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hHsa9rknPXl3HRiM6cCz3JOvcd+6ku/3FhAYYxuSGWFGE7PjfivbutQhwhclOMEZe
         U3k01gGyRcYOodsD4Hbe4x7v9m86B/qepOCntZPV1Cfo4YUbEvRugFdSn8trWbgR2O
         q9/cARKRLWlJ9GPiQpkaW54Qccm1VCDfCD8V/4la7T+gyCf97MGPWzbgkTuABAInBN
         tb9Dtv6qGWCM3FCLXAUrbkGHT5J4FugkXNQb57dddDJMOyc3TArA0zE2TCg3pVZ3rp
         UzuV7/1uD2jou0avshw7Ze+5vYUuqiO6TCdNdX8ukMMlShLwwC9ZWu73s4cgE3R/fV
         U2PdLUeW0tqBg==
Date:   Thu, 16 Jun 2022 06:47:16 -0700
From:   Vinod Koul <vkoul@kernel.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org,
        Tony Zhu <tony.zhu@intel.com>
Subject: Re: [PATCH v2] dmaengine: idxd: force wq context cleanup on device
 disable path
Message-ID: <Yqs0ZKr524m6elbO@matsya>
References: <20220615234219.178186-1-fenghua.yu@intel.com>
 <Yqp++PKEmV8GNvye@fyu1.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yqp++PKEmV8GNvye@fyu1.sc.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-06-22, 17:53, Fenghua Yu wrote:
> On Wed, Jun 15, 2022 at 04:42:19PM -0700, Fenghua Yu wrote:
> > From: Dave Jiang <dave.jiang@intel.com>
> > 
> > Testing shown that when a wq mode is setup to be dedicated and then torn
> > down and reconfigured to shared, the wq configured end up being dedicated
> > anyays. The root cause is when idxd_device_wqs_clear_state() gets called
> > during idxd_driver removal, idxd_wq_disable_cleanup() does not get called
> > vs when the wq driver is removed first. The check of wq state being
> > "enabled" causes the cleanup to be bypassed. However, idxd_driver->remove()
> > releases all wq drivers. So the wqs goes to "disabled" state and will never
> > be "enabled". By that point, the driver has no idea if the wq was
> > previously configured or clean. So force call idxd_wq_disable_cleanup() on
> > all wqs always to make sure everything gets cleaned up.
> > 
> > Reported-by: Tony Zhu <tony.zhu@intel.com>
> > Tested-by: Tony Zhu <tony.zhu@intel.com>
> > Fixes: 0dcfe41e9a4c ("dmanegine: idxd: cleanup all device related bits after disabling device")
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>

Pls send updated patchset

> 
> > ---
> > Change Log:
> > v2:
> > - Re-based to 5.19-rc2 so that it can be applied cleanly. No functionality
> >   change.
> > 
> > v1:
> > https://patchwork.kernel.org/project/linux-dmaengine/patch/165090959239.1376825.18183942742142655091.stgit@djiang5-desk3.ch.intel.com/
> > 
> >  drivers/dma/idxd/device.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> > index ff0ea60051f0..5a8cc52c1abf 100644
> > --- a/drivers/dma/idxd/device.c
> > +++ b/drivers/dma/idxd/device.c
> > @@ -716,10 +716,7 @@ static void idxd_device_wqs_clear_state(struct idxd_device *idxd)
> >  		struct idxd_wq *wq = idxd->wqs[i];
> >  
> >  		mutex_lock(&wq->wq_lock);
> > -		if (wq->state == IDXD_WQ_ENABLED) {
> > -			idxd_wq_disable_cleanup(wq);
> > -			wq->state = IDXD_WQ_DISABLED;
> > -		}
> > +		idxd_wq_disable_cleanup(wq);
> >  		idxd_wq_device_reset_cleanup(wq);
> >  		mutex_unlock(&wq->wq_lock);
> >  	}
> > -- 
> > 2.32.0
> > 

-- 
~Vinod
