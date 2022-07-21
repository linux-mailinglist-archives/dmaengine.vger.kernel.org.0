Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6E257CC0D
	for <lists+dmaengine@lfdr.de>; Thu, 21 Jul 2022 15:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiGUNg1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Jul 2022 09:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiGUNgZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Jul 2022 09:36:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2280526AD7;
        Thu, 21 Jul 2022 06:36:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3BF461F0B;
        Thu, 21 Jul 2022 13:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E3BC341C6;
        Thu, 21 Jul 2022 13:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658410584;
        bh=tPw3/zFzSi74bxB/0a8YLwdGeKzsIDaGr+axnWPvb3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cls4ebnuCw+MOwSL2tvLlbZ1M1xywKs5TPjlmyha75NSYGgU5gcPLyd89HEL4Mbc5
         t9kVrcskREyLyx9HjylF5yeMMYa8li7LEYoOdQoXq9pP3hNxGr14ZOIOqRiKMilrKl
         EiGXQwKyXWlffx4WGW/NqJ+jRWu6NM4vYVXFITVOgwHL6JtGEuKxMr0ZbkbL1IuWUI
         1MHarp7A9X/0aT7qjZLVHDDjCQjI9bYwlRp+2ZIc4A3LUcMypajwQX5rcprXMpStXO
         i+P5dkeyeqHtv43t9juwSRs2wELcbwqVwUtR1wUHNGzC4luIlu1psX5UeWgRO1wqez
         52K80HThdnYzA==
Date:   Thu, 21 Jul 2022 19:06:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Agarwal, Swati" <swati.agarwal@amd.com>
Cc:     Swati Agarwal <swati.agarwal@xilinx.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "adrianml@alumnos.upm.es" <adrianml@alumnos.upm.es>,
        "libaokun1@huawei.com" <libaokun1@huawei.com>,
        "marex@denx.de" <marex@denx.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "harini.katakam@xilinx.com" <harini.katakam@xilinx.com>,
        "radhey.shyam.pandey@xilinx.com" <radhey.shyam.pandey@xilinx.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "Katakam, Harini" <harini.katakam@amd.com>,
        "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>
Subject: Re: [PATCH 1/2] dmaengine: xilinx_dma: Fix probe error cleanup
Message-ID: <YtlWU/H+45hkEv4o@matsya>
References: <20220624063539.18657-1-swati.agarwal@xilinx.com>
 <20220624063539.18657-2-swati.agarwal@xilinx.com>
 <Yr7fou17VkqOYV0V@matsya>
 <BL0PR12MB25796644B683AB6FAF6BD9D6E4869@BL0PR12MB2579.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR12MB25796644B683AB6FAF6BD9D6E4869@BL0PR12MB2579.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12-07-22, 07:36, Agarwal, Swati wrote:
> Hi Vinod,
> 
> > -----Original Message-----
> > From: Vinod Koul <vkoul@kernel.org>
> > Sent: Friday, July 1, 2022 5:21 PM
> > To: Swati Agarwal <swati.agarwal@xilinx.com>
> > Cc: lars@metafoo.de; adrianml@alumnos.upm.es; libaokun1@huawei.com;
> > marex@denx.de; dmaengine@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > harini.katakam@xilinx.com; radhey.shyam.pandey@xilinx.com;
> > michal.simek@xilinx.com
> > Subject: Re: [PATCH 1/2] dmaengine: xilinx_dma: Fix probe error cleanup
> > 
> > CAUTION: This message has originated from an External Source. Please use
> > proper judgment and caution when opening attachments, clicking links, or
> > responding to this email.
> > 
> > 
> > On 24-06-22, 12:05, Swati Agarwal wrote:
> > > When probe fails remove dma channel resources and disable clocks in
> > > accordance with the order of resources allocated .
> > 
> > Ok this looks fine and the changes below..
> 
> Thanks for the review!!
> Sorry for the delayed reply. I missed this mail due to some mailer issues.
> 
> > >
> > > Add missing cleanup in devm_platform_ioremap_resource(),
> > > xlnx,num-fstores property.
> > 
> > Where is this part?
> 
> The statement is an elaboration of the previous one. The relevant code is below.

Okay, a patch should do only One thing, pls consider splitting it up...

> 
> <snip>
> > >       /* Request and map I/O memory */
> > >       xdev->regs = devm_platform_ioremap_resource(pdev, 0);
> > > -     if (IS_ERR(xdev->regs))
> > > -             return PTR_ERR(xdev->regs);
> > > +     if (IS_ERR(xdev->regs)) {
> > > +             err = PTR_ERR(xdev->regs);
> > > +             goto disable_clks;
> > > +     }
> 
> This  
> 
> <snip>
> > >               if (err < 0) {
> > >                       dev_err(xdev->dev,
> > >                               "missing xlnx,num-fstores property\n");
> > > -                     return err;
> > > +                     goto disable_clks;
> > >               }
> 
> And this
> 
> Regards,
> Swati Agarwal

-- 
~Vinod
