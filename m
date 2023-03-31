Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3C76D16D8
	for <lists+dmaengine@lfdr.de>; Fri, 31 Mar 2023 07:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjCaFjP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Mar 2023 01:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCaFjO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Mar 2023 01:39:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB771165F;
        Thu, 30 Mar 2023 22:39:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3E1DB82BBF;
        Fri, 31 Mar 2023 05:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14755C433D2;
        Fri, 31 Mar 2023 05:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680241144;
        bh=RaxOmDnV17uzrPhgXJeKsuN/oSdrW0+Jw7YKYzsy6Kk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aO1fswx90sOS8FTXRoScvoQjtO+Bqvy/lmaGcRk0w93FRUwofux+6XSUSMBrU4KQF
         OuCbLvSndWB37fWqyS+8j67J+Tz8i8sdBNXteTxaDG1FPeQKWx3yexDY98wDPS2odv
         RwiAx3V0HONe45JRUWotEmnpjPFhndOAtFpQQiTlEhqJDQANIn0h1kgHcF+Cew6WHT
         igokLN0v5tne8BS11Eus1dSwBsvgVBwyOwI5etu8fqKbRpZYc8ev09gFwTv1SbB7FL
         kOlb7apU2B9kF/PjjtySsgCKJxpHOzp2gwI97Y9qy5g/Cg8nuSVRRbXIxF0fPm3mhP
         Zs7InFKtu2tDA==
Date:   Fri, 31 Mar 2023 11:08:50 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH 00/11] Introduce a test for continuous transfer
Message-ID: <20230331053850.GE4973@thinkpad>
References: <20230317113238.142970-1-mie@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230317113238.142970-1-mie@igel.co.jp>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Mar 17, 2023 at 08:32:27PM +0900, Shunsuke Mie wrote:
> This patchset introduces testing through continuous transfer to the PCI
> endpoint tests. The purpose is to find bugs that may exist in the endpoint
> controller driver. This changes able to find bugs in the DW EDMA driver and
> this patchset includes the fix.
> 
> This bug does not appear in the current tests because these synchronize to
> finish with every data transfer. However, the problem occurs with
> continuous DMA issuances. The continuous transfers are required to get high
> throughput and low latency. Therefore, the added tests will enable
> realistic transfer testing.
> 
> This patchset is divided into three parts:
> - Remove duplicated definitions and improve some code [1-6/11]
> - Add continuous transfer tests [7-9/11]
> - Fix for the DW EDMA driver bug [10,11/11]
> 
> This patchset has beed tested on RCar Spidar that has dw pci edma chip.
> 

If you want maintainers to review the patches separately, please remove the RFC
tag. Unless you are looking for some overall feedback about the approach.

But we are in the process of migrating the existing test under tools to
Kselftest framework [1]. Until then, we cannot accept patches improving the
existing test code. So please respin the patches on top of the Kselftest patch
once it got posted. It's already due for some time :/

Also the subject should mention "PCI endpoint".

- Mani

[1] https://lore.kernel.org/all/20221007053934.5188-1-aman1.gupta@samsung.com/

> Shunsuke Mie (11):
>   misc: pci_endpoint_test: Aggregate irq_type checking
>   misc: pci_endpoint_test: Remove an unused variable
>   pci: endpoint: function/pci-epf-test: Unify a range of time
>     measurement
>   PCI: endpoint: functions/pci-epf-test: Move common difinitions to
>     header file
>   MAINTAINERS: Add a header file for pci-epf-test
>   misc: pci_endpoint_test: Use a common header file between endpoint
>     driver
>   PCI: endpoint: functions/pci-epf-test: Extend the test for continuous
>     transfers
>   misc: pci_endpoint_test: Support a test of continuous transfer
>   tools: PCI: Add 'C' option to support continuous transfer
>   dmaengine: dw-edma: Fix to change for continuous transfer
>   dmaengine: dw-edma: Fix to enable to issue dma request on DMA
>     processing
> 
>  MAINTAINERS                                   |   1 +
>  drivers/dma/dw-edma/dw-edma-core.c            |  30 ++-
>  drivers/misc/pci_endpoint_test.c              | 132 ++++--------
>  drivers/pci/endpoint/functions/pci-epf-test.c | 199 ++++++++----------
>  include/linux/pci-epf-test.h                  |  67 ++++++
>  include/uapi/linux/pcitest.h                  |   1 +
>  tools/pci/pcitest.c                           |  13 +-
>  7 files changed, 231 insertions(+), 212 deletions(-)
>  create mode 100644 include/linux/pci-epf-test.h
> 
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
