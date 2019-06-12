Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E04C41B63
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jun 2019 06:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725468AbfFLE44 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Jun 2019 00:56:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:42618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfFLE44 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 12 Jun 2019 00:56:56 -0400
Received: from localhost (unknown [106.200.205.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB45920866;
        Wed, 12 Jun 2019 04:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560315415;
        bh=adJg1xbWRAKbKqUSMO7TLDd2Kv8I4dISJtQHOKqUhSQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gf75MXj+YlLOOMVsdznxZmPc0AMN9WEfpCfGIGlg6hzW8PMotLX6ZHMTsBtC9CGfz
         46ew6Q9+T+zLmNRHNFkW/nyfrvudpN1ohMnvJj5XqorPMFRwYVBondU4ZwBCNdwt/4
         MVJxrGwZBLQeJEZc8ir1GW1QPdVc67N802txCka0=
Date:   Wed, 12 Jun 2019 10:23:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: Re: linux-next: Tree for Jun 11 (drivers/dma/dw-edma/)
Message-ID: <20190612045347.GY9160@vkoul-mobl.Dlink>
References: <20190611192432.1d8f11b2@canb.auug.org.au>
 <ea7fcec3-6a3e-1e02-53aa-f536f784e2c0@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea7fcec3-6a3e-1e02-53aa-f536f784e2c0@infradead.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-06-19, 10:30, Randy Dunlap wrote:
> On 6/11/19 2:24 AM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20190607:
> > 
> 
> on x86_64 or i386:
> 
> when CONFIG_PCI is not set/enabled:
> 
> ../drivers/dma/dw-edma/dw-edma-core.c: In function ‘dw_edma_irq_request’:
> ../drivers/dma/dw-edma/dw-edma-core.c:784:3: error: implicit declaration of function ‘pci_irq_vector’ [-Werror=implicit-function-declaration]
>    err = request_irq(pci_irq_vector(to_pci_dev(dev), 0),
>    ^

Thanks for the report, I am applying the fix YueHaibing with your
reported by.

-- 
~Vinod
