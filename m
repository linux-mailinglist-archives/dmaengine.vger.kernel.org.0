Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DC5692B27
	for <lists+dmaengine@lfdr.de>; Sat, 11 Feb 2023 00:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjBJX3o (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Feb 2023 18:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBJX3o (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Feb 2023 18:29:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521EE1B564;
        Fri, 10 Feb 2023 15:29:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFB6561ECC;
        Fri, 10 Feb 2023 23:29:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090DFC433EF;
        Fri, 10 Feb 2023 23:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676071782;
        bh=Q/hcON/J2f4ngMfFy+pzVpSf8Ze+WMGxgIYkbCcKRRk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TUh7nptV4CkpbBl5Gwk+eTVNDGkwWWHg9wDZbbF21XP5OXksKcsoF55cAv8OS7+/u
         8D+YGwwhrzAkJ9I5os7vFlHsKZmDDUKnKf0vl66D8rue6Tf4iJOYRi09TslBdB9yu2
         Wy/y8K4DiySh8l5odhxw7Ys/i2I3MzGRBCmj3ARrBmK25u+ImwCndZa/1mVBVVGmU+
         trO3iuh245mHInyXPzargzk9P5nWyqrQ1T0nIo6U1bp3VmEv/BAYQWcwShWQ0c9A9Z
         7sLuPbu6cipxEplQD9+XLySFKKlTx2G4H4//WTRmC4wd5Rqy8fP26Il1eGMz+XMJN8
         EtHj8gCkFxznQ==
Date:   Fri, 10 Feb 2023 17:29:40 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Arnd Bergmann <arnd@arndb.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Frank Li <Frank.Li@nxp.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] dmaengine: dw-edma: reduce stack usage after
 debugfs rework
Message-ID: <20230210232940.GA2712698@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210123525.cphmtcf7pmfj67os@mobilestation.baikal.int>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Feb 10, 2023 at 03:35:25PM +0300, Serge Semin wrote:
> On Fri, Feb 10, 2023 at 02:22:28PM +0530, Vinod Koul wrote:
> > On 30-01-23, 19:50, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > > 
> > > After the dw_edma_debugfs_entry arrays are no longer compile-time
> > > constant, they take up space on the stack, which exceeds the warning
> > > limit after inlining:
> > > 
> > > drivers/dma/dw-edma/dw-edma-v0-debugfs.c:280:6: error: stack frame size (1784) exceeds limit (1400) in 'dw_edma_v0_debugfs_on' [-Werror,-Wframe-larger-than]
> > > void dw_edma_v0_debugfs_on(struct dw_edma *dw)
> > > 
> > > Work around this by preventing dw_edma_debugfs_regs_{wr,rd} from both
> > > being inlined together, which cuts the stack frame size in half and
> > > makes it fit below the warning limit.
> > > 
> > > Fixes: 5c0373eafd83 ("dmaengine: dw-edma: Move eDMA data pointer to debugfs node descriptor")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > > v2: rebase on top of dmaengine tree
> > 
> > I dont have 5c0373eafd83 in my tree, I guess that went thru PCI tree, so
> > I am going to defer this after merge window
> 
> It's in the @Bjorn tree now
> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/ctrl/dwc&id=5c0373eafd8334343da22338d8588ed61e8daba0
> 
> If you are ok with the fix then @Bjorn could take the patch in to his
> repo. Right, @Bjorn?

Yes, I squashed this into the original patch and tweaked the
whitespace per Manivannan's comment.

Note that we've moved to a shared PCI git tree, so the helgaas/pci.git
tree is obsolete and will bit rot until we remove it completely.

The new one is:

  https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/

Bjorn
