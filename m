Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8C05AC5AB
	for <lists+dmaengine@lfdr.de>; Sun,  4 Sep 2022 19:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbiIDRWG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 4 Sep 2022 13:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbiIDRWG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 4 Sep 2022 13:22:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82721303CF;
        Sun,  4 Sep 2022 10:22:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E6AD60F77;
        Sun,  4 Sep 2022 17:22:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DAFC433D6;
        Sun,  4 Sep 2022 17:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662312124;
        bh=HMQgwDI76WiAFBkZo0CkfR6wG07owwAMh5ZHn7lvDs8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TADRxJARSNjw7GHmC/HOUdV2x5cVOPjHku2DpmPgcT7NReGRss4e/8CVt56COZWHl
         OswpMkT6TsLHm+Yki7JBhBUTscWas+zQ9LV7WAX+lO6KfhYrpMZNffY3Pv5LIPCTdB
         n100n1yc5u3qQbH6/DILkk5c2mjmkbCxrPVHFEUSQIo591GcemRzYVWSIZZDf3RLTm
         oFIDay+4ySsqI3iAHUVlJHyWM0oZDFEAZFHjhm6jUJsryC4Ujq2nWeyOh3Zra+31VX
         vfrtxOYaebv7uKWty5fGOLo+r+/p3FnzQV/kJDslZ8W6lRHbQPMce8Iq4duUgtPQbW
         fTGQQyWD3vKHA==
Date:   Sun, 4 Sep 2022 22:51:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     gustavo.pimentel@synopsys.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>,
        Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH] dmaengine: dw-edma: Remove runtime PM support
Message-ID: <YxTet82IgKtQ+q9q@matsya>
References: <20220512083612.122824-1-manivannan.sadhasivam@linaro.org>
 <20220819084018.GC215264@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819084018.GC215264@thinkpad>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-08-22, 14:10, Manivannan Sadhasivam wrote:
> On Thu, May 12, 2022 at 02:06:12PM +0530, Manivannan Sadhasivam wrote:
> > Currently, the dw-edma driver enables the runtime_pm for parent device
> > (chip->dev) and increments/decrements the refcount during alloc/free
> > chan resources callbacks.
> > 
> > This leads to a problem when the eDMA driver has been probed, but the
> > channels were not used. This scenario can happen when the DW PCIe driver
> > probes eDMA driver successfully, but the PCI EPF driver decides not to
> > use eDMA channels and use iATU instead for PCI transfers.
> > 
> > In this case, the underlying device would be runtime suspended due to
> > pm_runtime_enable() in dw_edma_probe() and the PCI EPF driver would have
> > no knowledge of it.
> > 
> > Ideally, the eDMA driver should not be the one doing the runtime PM of
> > the parent device. The responsibility should instead belong to the client
> > drivers like PCI EPF.
> > 
> > So let's remove the runtime PM support from eDMA driver.
> > 
> > Cc: Serge Semin <fancer.lancer@gmail.com>
> > Cc: Frank Li <Frank.Li@nxp.com>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Looks like this one missed 6.0. Vinod, can you please merge this now?

This fails for me, can you pls rebase and resend

-- 
~Vinod
