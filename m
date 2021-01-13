Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8D92F5009
	for <lists+dmaengine@lfdr.de>; Wed, 13 Jan 2021 17:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbhAMQdC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Jan 2021 11:33:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:45590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727294AbhAMQdC (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 13 Jan 2021 11:33:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 779692343F;
        Wed, 13 Jan 2021 16:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610555541;
        bh=la66BLnJCwSEyHSEyP8chDhxmNI78Xy0vCsURPhGPNs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dgu//eSAIdBomQ7Xu1PcBcvDe+77xmTGVvR/oSM2VbEa17cHASt1uEeCqpKS/4d0O
         FmgtEnhA2dtz3swrJbPZyOHOQzALd1UusvWVNDS+FgUL5DL6FM0QrCpZXJEuLAobIU
         jwrHIuPRCBHsLIgUH0//BQPLh35EGeA970YLkC67x5zJE8ZVtGG8GDJ1Pv0dL9eRna
         o2qwOvM7yxJMwkzhLaj5Mw+Th+3V/2GPm0TGojhL4dPIrbW/WBaTWEUJKWX8S5rJcF
         kJF5/Hon72otiBnrEz4boG4myxgPXMVasbhjNCHeOJ1N0igemr2r3t+SX2eyGZUj2T
         unG/T3DjtrTsQ==
Date:   Wed, 13 Jan 2021 22:02:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Ferry Toth <ftoth@exalondelft.nl>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] hsu_dma_pci: disable spurious interrupt
Message-ID: <20210113163216.GW2771@vkoul-mobl>
References: <20210112223749.97036-1-ftoth@exalondelft.nl>
 <CAHp75VfLOcMxUCU7urFi0Kz6RS4FNLA2y9T0rK_5Y0g8+UrE0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfLOcMxUCU7urFi0Kz6RS4FNLA2y9T0rK_5Y0g8+UrE0w@mail.gmail.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13-01-21, 15:05, Andy Shevchenko wrote:
> On Wed, Jan 13, 2021 at 5:23 AM Ferry Toth <ftoth@exalondelft.nl> wrote:
> >
> > On Intel Tangier B0 and Anniedale the interrupt line, disregarding
> > to have different numbers, is shared between HSU DMA and UART IPs.
> > Thus on such SoCs we are expecting that IRQ handler is called in
> > UART driver only. hsu_pci_irq was handling the spurious interrupt
> 
> hsu_pci_irq()
> 
> > from HSU DMA by returning immediately. This wastes CPU time and
> > since HSU DMA and HSU UART interrupt occur simultaneously they race
> > to be handled causing delay to the HSU UART interrupt handling.
> > Fix this by disabling the interrupt entirely.
> 
> Title should be "dmaengine: hsu: ..."

Fixed that up while applying, so applied

-- 
~Vinod
