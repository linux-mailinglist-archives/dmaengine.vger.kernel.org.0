Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A64531E7B
	for <lists+dmaengine@lfdr.de>; Tue, 24 May 2022 00:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiEWWSr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 May 2022 18:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbiEWWSq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 23 May 2022 18:18:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E24C85ED2;
        Mon, 23 May 2022 15:18:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2F0861535;
        Mon, 23 May 2022 22:18:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88EEC385AA;
        Mon, 23 May 2022 22:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653344324;
        bh=OoXINZSQl6EbZURKBKfqOcvW2hdxyutlb8MGNVyn164=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZpxCWf78gy6bCcXq4yRxvDTaYM+43RHJQqfoT7nwEDW9KWSWCJMXRTmZ3Tznkd4Zy
         lrmwuTB3MQqe1/sVjbPY/mkj8QxvwTawbyb4Jj9UTiQfItfIwgGtYXRJ5dllxJoTON
         nfQh16iTTrndcgNjGavpC5f4BKsH4ZPWqP7Kmv8D8EvZC+pwyhOLmT/KHIsI1XZd6P
         tnhml8/DE16ivAl13oJZs2aMMZ7iiipeD33U98MnZT9+q1mSkvvNoe2eAZEKzDDG5w
         gM5Z/BBjuERzfKNXv0FEzs7qloGjWzhwFaSybklxUoVNnShgz4aVfgbFY3gKCHBfU+
         7VDGZNuan8wAQ==
Date:   Mon, 23 May 2022 17:18:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zhi Li <lznuaa@gmail.com>
Cc:     Frank Li <Frank.Li@nxp.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        hongxing.zhu@nxp.com, Lucas Stach <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        dmaengine@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v11 8/8] PCI: endpoint: Enable DMA tests for endpoints
 with DMA capabilities
Message-ID: <20220523221842.GA221538@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHrpEqSuojypCKdueN-G9c=GQ0zHnPqLb3S6e28V8cchA=qyfA@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, May 23, 2022 at 02:19:34PM -0500, Zhi Li wrote:

> Bjorn:  Are you satisfied with the below message?  I will fix the
> other code in the next version.

Looks good, minor questions and tweaks below:

> Some PCI Endpoint controllers integrate an eDMA (embedded DMA).
> The eDMA controller issues a single bus command per data transfer.

Still not sure why this sentence is here.  Is it something the patch
relies on?  Why does it matter how many bus commands there are?

> eDMA can bypass the outbound memory address translation unit to
> access all RC memory space.
> 
> Add eDMA support for pci-epf-test.
> 
> EPF test can use, depending on HW availability, eDMA or general system
> DMA controllers to perform DMA. The test probes the EPF DMA channel
> capabilities.

  Depending on HW availability, the EPF test can use either eDMA or
  general system DMA controllers to perform DMA. The test tries to use
  eDMA first and falls back to general system DMA controllers if
  there's no eDMA.

> Separate dma_chan to dma_chan_tx and dma_chan_rx. Search eDMA channel
> firstly, then search memory to memory DMA channel if eDMA does not exist.
> If general memory to memory channels are used, dma_chan_rx = dma_chan_tx.

  Search for an eDMA channel first, then search for a memory-to-memory
  DMA channel ...

> Add dma_addr_t dma_remote in pci_epf_test_data_transfer()
> because eDMA uses remote RC physical address directly.
> 
> Add enum dma_transfer_direction dir in pci_epf_test_data_transfer()
> because eDMA chooses the correct RX/TX channel by dir.
> 
> The overall steps are
> 
> 1. Execute dma_request_channel() and filter function to find correct
> eDMA RX and TX Channel. If a channel does not exist, fallback to try to
> allocate general memory to memory DMA channel.
> 2. Execute dmaengine_slave_config() to configure remote side physical
> address.
> 3. Execute dmaengine_prep_slave_single() to create transfer descriptor.
> 4. Execute tx_submit().
> 5. Execute dma_async_issue_pending()
