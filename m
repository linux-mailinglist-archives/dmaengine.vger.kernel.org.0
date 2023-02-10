Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE5A691F31
	for <lists+dmaengine@lfdr.de>; Fri, 10 Feb 2023 13:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjBJMfg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Feb 2023 07:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjBJMff (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Feb 2023 07:35:35 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19DA635A8;
        Fri, 10 Feb 2023 04:35:29 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id w11so8054313lfu.11;
        Fri, 10 Feb 2023 04:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8TaVBd2PRqxi6IKt0HzSNZlfKLk06ERBwLCcqpM4sTs=;
        b=nsCnqHmjAA7Uzj+ZGctkg3BQ5wuQR6BBnxCNxg6bVq4IkLRbBrlDg11tsYyODgldhD
         /L3+0QBfbVvYCqtEN8PmeQ3B8WIYk8arvBelLyVsR2XgGXd1iH55RMtokZpkcHE2H6eA
         9wcU+DOJSBgtmInPDfcez1nZA0U8L+gTlOm2OZyR8txrd4SfvC6hTD7AbQCsZZMaT31Z
         S4r+SOStitGMWdEpSnmGbWZo8MQsrGuE/L44klei2BgFADhOL+KUlmsVql38/iLq2yfr
         ThbJq92/mQF0K5g7v99fkUSpSpSTDGlW7XtcwrUWozt2W3NfpOIT0ZoKglwD0n8wKzpZ
         kdew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TaVBd2PRqxi6IKt0HzSNZlfKLk06ERBwLCcqpM4sTs=;
        b=UDAv8X45Ji5ewWYDZ6DTGWIpq6mTz/nBNpWpDvRFI/MMbIMqSm/DX1o4GhV4+9wLbV
         /VOBm6wEKWtMeU+ovcOCABjMX6qwnirGjrB7wc3//qVAToT1UacLIZRXGKTiP42L/YSP
         RzohvNE3H38IDyWGWkfU8Iw2D18Fk211+gUxsTI0wImeU+CeSHBN7K4ggSEZJhakIM8S
         JOShVX6qmS8v2P80KQmTRQl4+ezhDDINyL20yzgN75CdNDYyCgDVNLUXCL+wL0zLX9bX
         iQhcr2MvGMi2cFnmZ4fe7QqH0YlbyFNi10PihvW//7cWd1GHXY80JbECqgHyYTkalxy6
         umqg==
X-Gm-Message-State: AO0yUKVb9Yld0VBaFGNL9Vm9wes/iMSo+ms7TvkrUqCFQiFHlAvQDi2s
        EfcronOL+ihaJ8WHIJVy08wusMBXC/E=
X-Google-Smtp-Source: AK7set/17ItNntmeCc5xMu0tUPhW2KL1l8Afr4/36uz5jn8CzoAKw9xKiBrT2/jYM2sQZ8qqHQgOoA==
X-Received: by 2002:a19:ee02:0:b0:4d8:6a30:fbd7 with SMTP id g2-20020a19ee02000000b004d86a30fbd7mr4348124lfb.67.1676032528016;
        Fri, 10 Feb 2023 04:35:28 -0800 (PST)
Received: from mobilestation.baikal.int ([94.125.187.42])
        by smtp.gmail.com with ESMTPSA id l29-20020ac24a9d000000b004cb23904bd9sm305545lfp.144.2023.02.10.04.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 04:35:27 -0800 (PST)
Date:   Fri, 10 Feb 2023 15:35:25 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Arnd Bergmann <arnd@arndb.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Frank Li <Frank.Li@nxp.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] dmaengine: dw-edma: reduce stack usage after
 debugfs rework
Message-ID: <20230210123525.cphmtcf7pmfj67os@mobilestation.baikal.int>
References: <20230130185101.2883245-1-arnd@kernel.org>
 <Y+YFzDm4XOnzZTpM@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+YFzDm4XOnzZTpM@matsya>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Vinod

On Fri, Feb 10, 2023 at 02:22:28PM +0530, Vinod Koul wrote:
> On 30-01-23, 19:50, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > After the dw_edma_debugfs_entry arrays are no longer compile-time
> > constant, they take up space on the stack, which exceeds the warning
> > limit after inlining:
> > 
> > drivers/dma/dw-edma/dw-edma-v0-debugfs.c:280:6: error: stack frame size (1784) exceeds limit (1400) in 'dw_edma_v0_debugfs_on' [-Werror,-Wframe-larger-than]
> > void dw_edma_v0_debugfs_on(struct dw_edma *dw)
> > 
> > Work around this by preventing dw_edma_debugfs_regs_{wr,rd} from both
> > being inlined together, which cuts the stack frame size in half and
> > makes it fit below the warning limit.
> > 
> > Fixes: 5c0373eafd83 ("dmaengine: dw-edma: Move eDMA data pointer to debugfs node descriptor")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > v2: rebase on top of dmaengine tree
> 
> I dont have 5c0373eafd83 in my tree, I guess that went thru PCI tree, so
> I am going to defer this after merge window

It's in the @Bjorn tree now
https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/ctrl/dwc&id=5c0373eafd8334343da22338d8588ed61e8daba0

If you are ok with the fix then @Bjorn could take the patch in to his
repo. Right, @Bjorn?

-Serge(y)

> 
> > ---
> >  drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> > index 42380bf64a70..6542060bd01a 100644
> > --- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> > +++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> > @@ -136,7 +136,8 @@ static void dw_edma_debugfs_regs_ch(struct dw_edma *dw, enum dw_edma_dir dir,
> >  	dw_edma_debugfs_create_x32(dw, debugfs_regs, nr_entries, dent);
> >  }
> >  
> > -static void dw_edma_debugfs_regs_wr(struct dw_edma *dw, struct dentry *dent)
> > +static noinline_for_stack void
> > +dw_edma_debugfs_regs_wr(struct dw_edma *dw, struct dentry *dent)
> >  {
> >  	const struct dw_edma_debugfs_entry debugfs_regs[] = {
> >  		/* eDMA global registers */
> > @@ -197,7 +198,8 @@ static void dw_edma_debugfs_regs_wr(struct dw_edma *dw, struct dentry *dent)
> >  	}
> >  }
> >  
> > -static void dw_edma_debugfs_regs_rd(struct dw_edma *dw, struct dentry *dent)
> > +static noinline_for_stack void
> > +dw_edma_debugfs_regs_rd(struct dw_edma *dw, struct dentry *dent)
> >  {
> >  	const struct dw_edma_debugfs_entry debugfs_regs[] = {
> >  		/* eDMA global registers */
> > -- 
> > 2.39.0
> 
> -- 
> ~Vinod
