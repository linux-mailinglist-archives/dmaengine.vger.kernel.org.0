Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375191B1AA6
	for <lists+dmaengine@lfdr.de>; Tue, 21 Apr 2020 02:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgDUA0H (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Apr 2020 20:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726056AbgDUA0H (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Apr 2020 20:26:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305F4C061A0E;
        Mon, 20 Apr 2020 17:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Ls7V5eRm0M7hlg17zUFuXhOBW3Ybwk4LdSmc8ysz8kM=; b=OFlCEJI0Io366vesuYb2P9vhAe
        CkBOcnjzx01Bd7b6WH4cIGinoBL1/Mlt9krJ/lue36AuqKiiHPSKopfmatLmEZRkWI1qqJPBslU+E
        b0S0lQFHewNCz+F9sLER8kUo5xfRFsDALZw7r3OSoEaiS4u6Yo4lolziRvNfcThsjTvkM7gUkiqyi
        A+FhLIljNN9KmGxI3ROqKhu0Z6s1DLpKyKV7ugrSMIUSiQkd+w3cAXPGvsq5YDiuVGeI8D6ETo4Jg
        vm1EXoMJN7PRKp2AP+RG2nCxkMfgBBUykwqmpl1GfcCqPor+hX2fnElpcNRZ1HdTRJETI5tc32Bto
        7TJjtfSA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQgjj-0001U7-Vn; Tue, 21 Apr 2020 00:26:04 +0000
To:     Vinod Koul <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: drivers/dma/iop-adma.c cast build warnings
Message-ID: <5019a2d6-bace-26dc-dda2-c263efc30185@infradead.org>
Date:   Mon, 20 Apr 2020 17:26:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

On i386, when CONFIG_ARCH_DMA_ADDR_T_64BIT=y,
but long and void* are only 32 bits, there are a few build warnings:

  CC [M]  drivers/dma/iop-adma.o
../drivers/dma/iop-adma.c: In function 'iop_adma_alloc_chan_resources':
../drivers/dma/iop-adma.c:448:13: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
   hw_desc = (char *) iop_chan->device->dma_desc_pool;
             ^
../drivers/dma/iop-adma.c:450:4: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    (dma_addr_t) &hw_desc[idx * IOP_ADMA_SLOT_SIZE];
    ^
In file included from ../include/linux/printk.h:328:0,
                 from ../include/linux/kernel.h:15,
                 from ../include/linux/list.h:9,
                 from ../include/linux/module.h:12,
                 from ../drivers/dma/iop-adma.c:13:
../drivers/dma/iop-adma.c: In function 'iop_adma_probe':
../drivers/dma/iop-adma.c:1302:3: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
   (void *) adev->dma_desc_pool);
   ^

This is on linux-next 20200420.

Are DMA addresses for this driver/hw device limited to 32 bits?

thanks.
-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
