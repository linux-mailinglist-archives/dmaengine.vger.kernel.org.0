Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABF16939A4
	for <lists+dmaengine@lfdr.de>; Sun, 12 Feb 2023 20:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjBLTX4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 12 Feb 2023 14:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBLTX4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 12 Feb 2023 14:23:56 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5558BEB52;
        Sun, 12 Feb 2023 11:23:52 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id cq19so7587045edb.5;
        Sun, 12 Feb 2023 11:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hWA7slO9G8Jc3S+n8D692Q0piCjB6i9K+iTxEA52tbk=;
        b=i08YrdLrE7dnYfJQ/wEdJQKfyPbM+pf7AeIp5+/9qvIGkrEg29xcL4BjCk4LrZGvzw
         txHiTmiDnGAgvBvGomdYLjVBv5A8FTP1895QtiP10IKXXwZc3lY4oFE1qyRwd2BeVuiQ
         5D0mq5qom9OZIbi3BkB7NY4oRkQ65T1You3nwe8lcPOcmcSjw1Vc5vrn1ho97BJy3Cup
         W5LZ+FGQJX/Y1MA+Uhw6yWwxUwPipWCcu/rIkLLtNAKVkUutICnrVi69mwjdOJ1V5E48
         3/X9+uI4XEO+46o8ST1ux2xNSSbStfbool4NigYvDWcjd2OcOBeVcW1niVB/piiKH15d
         uHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWA7slO9G8Jc3S+n8D692Q0piCjB6i9K+iTxEA52tbk=;
        b=v4PHrDezZDS3+suRkcYKYz9D66dOrYKLyMaLD20XNiRgzhQDIng1gW+vaOnpUyI30U
         Py2ZUZjDTqMY7K/M9m+7mxVv1rvbKTCjzeI0xjk/H5Y4A3DDMnZPv8q72+krMgccJxUz
         53gQkPz27WIdMJ3PUUXRYLOJxcwCOGVcZOTZ6j6Y1UnXq71S49k3+4EwbvB5PCUGMtqR
         7fRBAvXqc5nogmIK4Gm68qHfLZhhZW+Ooq/+M9fAq29OCWJtYQfon9gfB7FvzcFbDFv7
         K2UwLBRFZsc7AyJrcU1HL/dCl2R3Gy4hxbEcBHBWAFgbBk1O7GBhMBWGuOUJZLut6EEa
         XBYA==
X-Gm-Message-State: AO0yUKUiO1AyalIRbRlrxbNuzcld/Z/Cq4Qicam2xmC1UWO7BC7ATtoO
        nZB9L6fIhvkbqxttmRPFnHc=
X-Google-Smtp-Source: AK7set8H1t3IbSjiYv1Pz1/NMV0Ad0fjePUqpwr6na8txm1QjYcwwRf7dgYT9xDp0aqttZ+wFT+fsw==
X-Received: by 2002:a50:cd4f:0:b0:4aa:aaf6:e6be with SMTP id d15-20020a50cd4f000000b004aaaaf6e6bemr23244112edj.7.1676229830818;
        Sun, 12 Feb 2023 11:23:50 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id n2-20020a5099c2000000b0048ecd372fc9sm5636768edb.2.2023.02.12.11.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 11:23:50 -0800 (PST)
Date:   Sun, 12 Feb 2023 22:23:47 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <20230212192347.6izrdws4iu7czfvg@mobilestation>
References: <20230210123525.cphmtcf7pmfj67os@mobilestation.baikal.int>
 <20230210232940.GA2712698@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210232940.GA2712698@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Feb 10, 2023 at 05:29:40PM -0600, Bjorn Helgaas wrote:
> On Fri, Feb 10, 2023 at 03:35:25PM +0300, Serge Semin wrote:
> > On Fri, Feb 10, 2023 at 02:22:28PM +0530, Vinod Koul wrote:
> > > On 30-01-23, 19:50, Arnd Bergmann wrote:
> > > > From: Arnd Bergmann <arnd@arndb.de>
> > > > 
> > > > After the dw_edma_debugfs_entry arrays are no longer compile-time
> > > > constant, they take up space on the stack, which exceeds the warning
> > > > limit after inlining:
> > > > 
> > > > drivers/dma/dw-edma/dw-edma-v0-debugfs.c:280:6: error: stack frame size (1784) exceeds limit (1400) in 'dw_edma_v0_debugfs_on' [-Werror,-Wframe-larger-than]
> > > > void dw_edma_v0_debugfs_on(struct dw_edma *dw)
> > > > 
> > > > Work around this by preventing dw_edma_debugfs_regs_{wr,rd} from both
> > > > being inlined together, which cuts the stack frame size in half and
> > > > makes it fit below the warning limit.
> > > > 
> > > > Fixes: 5c0373eafd83 ("dmaengine: dw-edma: Move eDMA data pointer to debugfs node descriptor")
> > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > > ---
> > > > v2: rebase on top of dmaengine tree
> > > 
> > > I dont have 5c0373eafd83 in my tree, I guess that went thru PCI tree, so
> > > I am going to defer this after merge window
> > 
> > It's in the @Bjorn tree now
> > https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/ctrl/dwc&id=5c0373eafd8334343da22338d8588ed61e8daba0
> > 
> > If you are ok with the fix then @Bjorn could take the patch in to his
> > repo. Right, @Bjorn?
> 

> Yes, I squashed this into the original patch and tweaked the
> whitespace per Manivannan's comment.

Great! Thanks.

> 
> Note that we've moved to a shared PCI git tree, so the helgaas/pci.git
> tree is obsolete and will bit rot until we remove it completely.
> 
> The new one is:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/

Good to know. Thanks again.

-Serge(y)

> 
> Bjorn
