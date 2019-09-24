Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62853BD29E
	for <lists+dmaengine@lfdr.de>; Tue, 24 Sep 2019 21:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409920AbfIXT2e (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Sep 2019 15:28:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409918AbfIXT2e (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Sep 2019 15:28:34 -0400
Received: from localhost (unknown [12.206.46.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18522207FD;
        Tue, 24 Sep 2019 19:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569353313;
        bh=KNm17kkxor66VdGhhJBe2OzE01FhjjH4x17NwGXbGgY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p/XrcU1724gDhWdyzGXZav5Hr/kh1vN0DQqFItFYoE3frNSHwNclV1tKyMNhZm591
         q2eJz83yXSm2JOEMGkZwlWcpqYqjcpn2HyoXRrqpO7RZRDp5bG2n5SHvvLvLYlSyOn
         Ds2B0KBDmWdZYwmBpvIb5SmdOFbZk4H/AfihU4/A=
Date:   Tue, 24 Sep 2019 12:27:31 -0700
From:   Vinod Koul <vkoul@kernel.org>
To:     Satendra Singh Thakur <sst2005@gmail.com>
Cc:     dan.j.williams@intel.com, jun.nie@linaro.org, shawnguo@kernel.org,
        agross@kernel.org, sean.wang@mediatek.com, matthias.bgg@gmail.com,
        maxime.ripard@bootlin.com, wens@csie.org, lars@metafoo.de,
        afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, satendrasingh.thakur@hcl.com
Subject: Re: Re: [PATCH 0/9] added helper macros to remove duplicate code
 from probe functions of the platform drivers
Message-ID: <20190924192731.GE3824@vkoul-mobl>
References: <20190918102715.GO4392@vkoul-mobl>
 <2356e29bca5bdfa901534bb32a2782185eb0415f.1568909689.git.sst2005@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2356e29bca5bdfa901534bb32a2782185eb0415f.1568909689.git.sst2005@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-09-19, 20:27, Satendra Singh Thakur wrote:
> On Wed, Sep 18, 2019 at 3:57 PM, Vinod Koul wrote:
> > On 15-09-19, 12:30, Satendra Singh Thakur wrote:
> > > 1. For most of the platform drivers's probe include following steps
> > > 
> > > -memory allocation for driver's private structure
> > > -getting io resources
> > > -io remapping resources
> > > -getting irq number
> > > -registering irq
> > > -setting driver's private data
> > > -getting clock
> > > -preparing and enabling clock
> >
> > And we have perfect set of APIs for these tasks!
> Hi Vinod,
> Thanks for the comments.
> You are right, we already have set of APIs for these tasks.
> The proposed macros combine the very same APIs to remove 
> duplicate/redundant code.
> A new driver author can use these macros to easily write probe 

Nope they can write each APIs, know the exact flow and do it!

> function without having to worry about signatures of internal APIs.
> In the past, people have combined some of them e.g.
> a) clk_prepare_enable combines clk_prepare and clk_enable

As it is clock, it is called in sequence, whereas different drivers may
have different sequencing.

Btw I am not for adding maanged irq functions, they are really not the
correct way to manage!

> b) devm_platform_ioremap_resource combines
> platform_get_resource (for type IORESOURCE_MEM)
> and devm_ioremap_resource
> c) module_platform_driver macro encompasses module_init/exit 
> and driver_register/unregister functions.

All examples you are quoting do a set of functions (clk, resources etc
and not do N things!

> The basic idea is to simplyfy coding.
> > > 2. We have defined a set of macros to combine some or all of
> > > the above mentioned steps. This will remove redundant/duplicate
> > > code in drivers' probe functions of platform drivers.
> > 
> > Why, how does it help and you do realize it also introduces bugs
> This will make probe function shorter by removing repeated code.
> This will also reduce bugs caused due to improper handling
> of failure cases because of these reasons:
> a) If the developer calls each API individualy one might miss
> proper handling of the failure for some API; Whereas the macro
> properly handles failure of each API.
> b) Macros are devres compatible which leaves less room for
> memory leaks.

No we review the code and if we miss we fix later!

> Yes, the macros which enable clock and request irqs
> might cause bugs if they are not used carefully.
> For instance, enabling the clock or requesting the irq
> earlier than actually required. So, the macros with _clk
> and _irq, _all suffix should be used carefully.

Precisely!


> Please let me know if I miss any specific type of bug
> here.
> > 
> > > devm_platform_probe_helper(pdev, priv, clk_name);
> > > devm_platform_probe_helper_clk(pdev, priv, clk_name);
> > > devm_platform_probe_helper_irq(pdev, priv, clk_name,
> > > irq_hndlr, irq_flags, irq_name, irq_devid);
> > > devm_platform_probe_helper_all(pdev, priv, clk_name,
> > > irq_hndlr, irq_flags, irq_name, irq_devid);
> > > devm_platform_probe_helper_all_data(pdev, priv, clk_name,
> > > irq_hndlr, irq_flags, irq_name, irq_devid);
> > > 
> > > 3. Code is made devres compatible (wherever required)
> > > The functions: clk_get, request_irq, kzalloc, platform_get_resource
> > > are replaced with their devm_* counterparts.
> > 
> > We already have devres APIs for people to use!
> Yes, we have devres APIs and many drivers do use them.
> But still there are many which don't use them.
> The proposed macros provides just another way to use devres APIs.
> > > 
> > > 4. Few bugs are also fixed.
> > 
> > Which ones..?
> The bug is that the failure of request_irq 
> is not handled properly in mtk-hsdma.c. This is fixed in patch [5/9].
> https://lkml.org/lkml/2019/9/15/35

Please send the fix individually and I would be glad to review.

-- 
~Vinod
