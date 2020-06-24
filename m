Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1EB2206C18
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2020 08:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388632AbgFXGCV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Jun 2020 02:02:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388307AbgFXGCV (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 24 Jun 2020 02:02:21 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EA6C2085B;
        Wed, 24 Jun 2020 06:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592978541;
        bh=3XIvBjkB95tczXXLOOekIN2aQotuf3cKPQMbiB6HV6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IjhSCyMuB3rM0xwChkv+9A+AuPl9xC4GkRdkMnur7/Pt6eCop4sgEbEKgFTZyNNa0
         GlMeak4GnJ9q8InUQViPJz8mZayO7OUuACPfpYtBe8rNH08yXPiUWSZbEYmvTTxtAq
         /uPRWDVDh6Lyyb3nM0veO1ZBL7tEsQpOkz5ZY290=
Date:   Wed, 24 Jun 2020 11:32:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH] dma: sh: usb-dmac: Fix residue after the commit
 24461d9792c2
Message-ID: <20200624060217.GA2324254@vkoul-mobl>
References: <1590061573-12576-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20200616165550.GP2324254@vkoul-mobl>
 <TY2PR01MB3692283C5F3695033D20A7AFD89B0@TY2PR01MB3692.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY2PR01MB3692283C5F3695033D20A7AFD89B0@TY2PR01MB3692.jpnprd01.prod.outlook.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-06-20, 00:56, Yoshihiro Shimoda wrote:
> Hi Vinod,
> 
> > From: Vinod Koul, Sent: Wednesday, June 17, 2020 1:56 AM
> > 
> > On 21-05-20, 20:46, Yoshihiro Shimoda wrote:
> > > This driver assumed that freed descriptors have "done_cookie".
> > > But, after the commit 24461d9792c2 ("dmaengine: virt-dma: Fix
> > > access after free in vchan_complete()"), since the desc is freed
> > > after callback function was called, this driver could not
> > > match any done_cookie when a client driver (renesas_usbhs driver)
> > > calls dmaengine_tx_status() in the callback function.
> > 
> > Hmmm, I am not sure about this, why should we try to match! cookie is
> > monotonically increasing number so if you see that current cookie
> > completed is > requested you should return DMA_COMPLETE
> 
> The reason is this hardware is possible to stop the transfer even if
> all transfer length is not received. This is related to one of USB
> specification which allows to stop when getting a short packet.
> So, a client driver has to get residue even if DMA_COMPLETE.

We have additional dma_async_tx_callback_result callback to indicate the
residue in these cases, please use that

> > The below case of checking residue should not even get executed
> 
> I see...
> So, I'm thinking the current implementation was a tricky because we didn't
> have dma_async_tx_callback_result when I wrote this usb-dmac driver.
> I'll try this to fix the issue.

Right :)

Also please use tag dmaengine: .. for these patches

-- 
~Vinod
