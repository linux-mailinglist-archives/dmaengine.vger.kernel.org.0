Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3165C6E1BEE
	for <lists+dmaengine@lfdr.de>; Fri, 14 Apr 2023 07:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjDNFuO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 14 Apr 2023 01:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjDNFuM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 14 Apr 2023 01:50:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D9B5248;
        Thu, 13 Apr 2023 22:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zQE4wvka/0/4+o5H/NgW9BNv4wfz/VF5TFtsQx3nNj0=; b=Z6oDvtEguDHwR/dQy8aDqWWDJj
        arrvi3VLc70vB/TwF5o5lbfa1Bjnp0bQqFHWmB9jhZK1HvoDPeDgrnG4wA+zuvffirEHa29KOGeFq
        SrpdgbgFDDDW//yOIWvG7ZdJYGSpYQ5Vw5BQPOdamtBk6dSsO3D5SIMIMK2O4M5BldEtCZ5ub0L3v
        FHnxiG5HVHpzXWGWMbA/3w1I9lMzjI5xEbJfyB86tVxm1LN5aYjMcXcR5fwEiz4+sxFDNNbDpDexg
        Ajw10u3hsmd2ItIGPRkegUG5+1WlMLJVmOkrzPmPxVRrbhJQyBSOSTiUNlLZP7ogfWrlHZFGvlCAr
        gCl7CLDQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pnCJz-008PDG-2v;
        Fri, 14 Apr 2023 05:50:07 +0000
Date:   Thu, 13 Apr 2023 22:50:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kelvin.Cao@microchip.com
Cc:     hch@infradead.org, dmaengine@vger.kernel.org, vkoul@kernel.org,
        George.Ge@microchip.com, linux-kernel@vger.kernel.org,
        logang@deltatee.com
Subject: Re: [PATCH v2 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Message-ID: <ZDjpjzj3xPaeeE1c@infradead.org>
References: <20230403180630.4186061-1-kelvin.cao@microchip.com>
 <20230403180630.4186061-2-kelvin.cao@microchip.com>
 <ZDQ8geSEauTsd2ME@infradead.org>
 <cee60331584b0408f61652376234078d4049359c.camel@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cee60331584b0408f61652376234078d4049359c.camel@microchip.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Apr 13, 2023 at 10:40:41PM +0000, Kelvin.Cao@microchip.com wrote:
> > > Why is the lock needed while reading the status and waiting
> > > for it with long delays?
> There's (low) chance of access to the same ctrl register from other
> paths which might change the value of status in an unexpected way. It
> also prevents the hardware operation from being interrupted until it
> indicates it has finished by a bit set in the status register.

Well, the lock is obviously required to protecte the reads to the
register.  But why do you need to hold the lock over the reads and
the delay?
