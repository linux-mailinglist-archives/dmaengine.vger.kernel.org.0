Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3974C2406
	for <lists+dmaengine@lfdr.de>; Thu, 24 Feb 2022 07:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiBXG0d (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Feb 2022 01:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiBXG0c (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Feb 2022 01:26:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29E6269AB4;
        Wed, 23 Feb 2022 22:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0xdJtLbIyGaTkVrOoFrs1oCqE4SKHuV2ypN1+yGx8FU=; b=plqHsoA9r6qv2vcyoZWmADrMG/
        5OPFbItTU7dR/wJsGyZ44TU7xCGfQQi8sj15lLsmxdJKWXugYw9BJI825zqqtRxeT2vsvlVL1+L+4
        Z4s86+FCMNrdAqVn80iGGZAgP1Tib8fDL9OlFVl6nNO623T8ympgHtoeQ8BY5GKQooyK/3WKhc0OJ
        RZfyDYV0j3SviZJjYHW+23G9QvaHR2MEStY2hyxNGAakVOAap9o8FDNl4jQHwk6i6bgcOGcNyf81N
        7qkWtXciB2p6k8Q5Hv/7mbngKMtgV1QAQWdv1kadJpK9io105nqZXvfHdj7kmdHBz/G8wD2sYCdtb
        3ygJbvwQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nN7Yy-00H1v4-7V; Thu, 24 Feb 2022 06:25:16 +0000
Date:   Wed, 23 Feb 2022 22:25:16 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Christoph Hellwig <hch@infradead.org>, arnd@arndb.de,
        akpm@linux-foundation.org, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, davem@davemloft.net, airlied@linux.ie,
        vkoul@kernel.org, hao.wu@intel.com, trix@redhat.com,
        mdf@kernel.org, yilun.xu@intel.com, awalls@md.metrocast.net,
        mchehab@kernel.org, sathya.prakash@broadcom.com,
        sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com, mporter@kernel.crashing.org,
        alex.bou9@gmail.com, bhelgaas@google.com,
        linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-media@vger.kernel.org,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 00/16] Remove usage of the deprecated "pci-dma-compat.h"
 API
Message-ID: <YhckzJp5/x9zW4uQ@infradead.org>
References: <cover.1641500561.git.christophe.jaillet@wanadoo.fr>
 <YhXmQwvjMFPQFPUr@infradead.org>
 <ddf6010e-417d-8da7-8e11-1b4a55f92fff@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddf6010e-417d-8da7-8e11-1b4a55f92fff@wanadoo.fr>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Feb 23, 2022 at 09:26:56PM +0100, Christophe JAILLET wrote:
> Patch 01, 04, 05, 06, 08, 09 have not reached -next yet.
> They all still apply cleanly.
> 
> 04 has been picked it up for inclusion in the media subsystem for 5.18.
> The other ones all have 1 or more Reviewed-by:/Acked-by: tags.
> 
> Patch 16 must be resubmitted to add "#include <linux/dma-mapping.h>" in
> order not to break builds.

So how about this:  I'll pick up 1, 5,6,8 and 9 for the dma-mapping
tree.  After -rc1 when presumably all other patches have reached
mainline your resubmit one with the added include and we finish this
off?

Thanks a lot for all your work already!
