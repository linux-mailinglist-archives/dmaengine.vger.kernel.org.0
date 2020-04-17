Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409B21ADC7C
	for <lists+dmaengine@lfdr.de>; Fri, 17 Apr 2020 13:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbgDQLuh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Apr 2020 07:50:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730440AbgDQLuh (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 17 Apr 2020 07:50:37 -0400
Received: from localhost (unknown [223.235.195.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A8DD20780;
        Fri, 17 Apr 2020 11:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587124237;
        bh=5UjYdrgjeQ5u3UswjbSXqSXZJqYPM0oJyCxvVK55xTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IrvhpsIh0160xPKGxTyu0dbOsDSt22PdPYnjbMVfrDP50BskHk4nULTsmMBXVXuIS
         CwBG76Bh6NpKaoMlzzM2y7uk+J4ZQryUGRg2t/ydNomFiUiyEBkyrST89YmSV6Qw+q
         QsJdmFunpU5WJInoNEANvFVJe96UbiTz2nMS6sBs=
Date:   Fri, 17 Apr 2020 17:20:30 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Alan Mikhak <alan.mikhak@sifive.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, gustavo.pimentel@synopsys.com,
        dan.j.williams@intel.com, kishon@ti.com, paul.walmsley@sifive.com
Subject: Re: [PATCH v2] dmaengine: dw-edma: Decouple dw-edma-core.c from
 struct pci_dev
Message-ID: <20200417115030.GM72691@vkoul-mobl>
References: <1586971629-30196-1-git-send-email-alan.mikhak@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586971629-30196-1-git-send-email-alan.mikhak@sifive.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-04-20, 10:27, Alan Mikhak wrote:
> From: Alan Mikhak <alan.mikhak@sifive.com>
> 
> Decouple dw-edma-core.c from struct pci_dev as a step toward integration
> of dw-edma with pci-epf-test so the latter can initiate dma operations
> locally from the endpoint side. A barrier to such integration is the
> dependency of dw_edma_probe() and other functions in dw-edma-core.c on
> struct pci_dev.
> 
> The Synopsys DesignWare dw-edma driver was designed to run on host side
> of PCIe link to initiate DMA operations remotely using eDMA channels of
> PCIe controller on the endpoint side. This can be inferred from seeing
> that dw-edma uses struct pci_dev and accesses hardware registers of dma
> channels across the bus using BAR0 and BAR2.
> 
> The ops field of struct dw_edma in dw-edma-core.h is currenty undefined:
> 
> const struct dw_edma_core_ops   *ops;
> 
> However, the kernel builds without failure even when dw-edma driver is
> enabled. Instead of removing the currently undefined and usued ops field,
> define struct dw_edma_core_ops and use the ops field to decouple
> dw-edma-core.c from struct pci_dev.

Applied, thanks

-- 
~Vinod
