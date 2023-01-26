Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63BE67D3F8
	for <lists+dmaengine@lfdr.de>; Thu, 26 Jan 2023 19:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjAZST7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Jan 2023 13:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjAZST6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 26 Jan 2023 13:19:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABA96537D;
        Thu, 26 Jan 2023 10:19:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD4086192B;
        Thu, 26 Jan 2023 18:19:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1940C433EF;
        Thu, 26 Jan 2023 18:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674757196;
        bh=Yhgs9+A5wKBzRaMRYNnqazTkLbHVQaZOCExLNcxL1Z8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=giu8wG7//Z59qJSKD1YBAEv0EXlZAK8nbm7JsHXvc72vFpdQKFS7VDbMFPSPxx7gq
         fOteqb4ZulxWqI/5XGZVM3TTizIKH1IeU5pghMxWrp515nS9SZKzAnLoICv5aO9YfU
         CnUakiJS+SgwLhg+M8k/o3CLx64HVURBiN2wsgROAajf0YIJr9uBuaOz20SkChcof3
         +mxOSJ1v2bqPTeASWO0Fx2sRomrTNhrQKhM15SqVppJLGNcZegxCBgvlnJanY1PzFj
         nJN9f16KTBhcA8AfAB+JlPPVOxzfotpx+rNj9Uh3aAvw9tb4hI3dQzr+QjVcX3Bcw5
         /24S6rj1GgYXw==
Date:   Thu, 26 Jan 2023 12:19:54 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        caihuoqing <caihuoqing@baidu.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 24/27] dmaengine: dw-edma: Relax driver config settings
Message-ID: <20230126181954.GA1290077@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126163750.ae6z3pkyd3o32byn@mobilestation>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jan 26, 2023 at 07:37:50PM +0300, Serge Semin wrote:
> On Wed, Jan 25, 2023 at 05:23:57PM -0600, Bjorn Helgaas wrote:

> > It's a pretty trivial update, so I just did it myself.  The result is
> > at https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci/ctrl/dwc&id=ecadcaed4ef7
> > 
> > I split this patch and tweaked some commit messages for consistency
> > (including the "DW eDMA PCIe driver" change above).  "git diff -b"
> > with Lorenzo's current branch (95624672bb3e ("PCI: dwc: Add DW eDMA
> > engine support")) is empty except for a minor comment change.  
> 
> Great! Thanks. Although I've already created v10 beforehand but didn't
> submitted it yet waiting for your response. The split up patches look
> exactly like yours.
> 
> In addition to that since I was going to re-send v10 I also took into
> account your comments regarding the patch:
> [PATCH v9 19/27] dmaengine: dw-edma: Use non-atomic io-64 methods
> Link: https://lore.kernel.org/linux-pci/20230113171409.30470-20-Sergey.Semin@baikalelectronics.ru/
> I've dropped unneeded modification and unpinned another fixes patch
> which turned out to be a part of those modifications. So if you
> re-based your pci/ctrl/dwc branch with that patch replaced with the
> patches attached to this email it would have been great. Otherwise
> it's ok to merge the series as is.
> 
> Note in the attached "non-atomic io-64" patch I've already replaced
> the commit log with the your short version.

Awesome, thanks!  I folded those updates in and updated my branch.

And merged the whole thing into the PCI "next" branch.

Thanks for all your work!

Bjorn
