Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB81F3D427
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2019 19:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406251AbfFKRa0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Jun 2019 13:30:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60314 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406168AbfFKRaZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 11 Jun 2019 13:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KVff8ujhhzIM9/Rf41ny12vawiOo83leAxlWlDnKaf4=; b=gyOasmZ/F0HZECqkoy5+GjAOi
        Y0tHGeatESToTSog6M1o7FlSA+etDaEl8Y/ryWxRH3/nOwMDyu4jQFcx94wtl/+qmLQubmh6E7jUj
        Y+WsXaN2i9nj+qb2TxDnN+kVYuOO4NJhaiCebBhaQwCGWp5WiVdw+YQ8V9SW90ysKKClQpnZLYvFN
        6WgAS30R0rDquuPWKDA1bKgpok9Q09iJlnKlNUR6cGmjK0yGslUs8petRsW1+h5FeRfIKv1C991do
        fh8nlAm2btMa6MYhCFEfQn2eC5IzeYcVGxB/Ez+TpF7c0MQfjgkGVwk+p85/q8GOf0aLtnEjJiFtH
        rMya4LiRw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hakbG-00089n-Li; Tue, 11 Jun 2019 17:30:22 +0000
Subject: Re: linux-next: Tree for Jun 11 (drivers/dma/dw-edma/)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
References: <20190611192432.1d8f11b2@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ea7fcec3-6a3e-1e02-53aa-f536f784e2c0@infradead.org>
Date:   Tue, 11 Jun 2019 10:30:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190611192432.1d8f11b2@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 6/11/19 2:24 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20190607:
> 

on x86_64 or i386:

when CONFIG_PCI is not set/enabled:

../drivers/dma/dw-edma/dw-edma-core.c: In function ‘dw_edma_irq_request’:
../drivers/dma/dw-edma/dw-edma-core.c:784:3: error: implicit declaration of function ‘pci_irq_vector’ [-Werror=implicit-function-declaration]
   err = request_irq(pci_irq_vector(to_pci_dev(dev), 0),
   ^



-- 
~Randy
