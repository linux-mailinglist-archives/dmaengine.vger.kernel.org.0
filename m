Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA428692218
	for <lists+dmaengine@lfdr.de>; Fri, 10 Feb 2023 16:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjBJPZ1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Feb 2023 10:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjBJPZ0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Feb 2023 10:25:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2EF2CFF0;
        Fri, 10 Feb 2023 07:25:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B208AB82556;
        Fri, 10 Feb 2023 15:25:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07ACC433D2;
        Fri, 10 Feb 2023 15:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676042722;
        bh=nYpPRyeQkq+m8vShkaRwwr6mWHNudduY3tY8CRy1JjY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fYVpUw1cIehLljFAFfU9EMH8yxtv0KYkFOGtBrE46DT84G5dCovhrjTlVLvT4FHzA
         vpVwpr2iYxdn9/rqN928qPnFLKP0sY57GRcMxt/1nqtm/Sl5ds2DiZaSatrGB3yj+Q
         O+h0Nduz/+mKvuGwWHJvb+GTIWfqu5eBOOPREceGG73QsfGbcfpPHDYY8w8QF9fJIw
         7kpFa7PVpud/ZRvAR4069THnTR0I25717Xdnm62O77PQr7yzAfCHTY18J2+FVZsNax
         p/DIjNHsgflVv+OrT24FOs/F8BJyAz6rqVd/sazsDkBihFMnR2iXd2duHDgTQxHMj2
         yYExIDGEptFsA==
Date:   Fri, 10 Feb 2023 20:55:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
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
Message-ID: <Y+Zh3KOE3m1TdpG5@matsya>
References: <20230130185101.2883245-1-arnd@kernel.org>
 <Y+YFzDm4XOnzZTpM@matsya>
 <20230210123525.cphmtcf7pmfj67os@mobilestation.baikal.int>
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

On 10-02-23, 15:35, Serge Semin wrote:
> Hello Vinod
> 
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

Sure:

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
