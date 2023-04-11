Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B060F6DDFE7
	for <lists+dmaengine@lfdr.de>; Tue, 11 Apr 2023 17:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjDKPrV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Apr 2023 11:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjDKPrU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 11 Apr 2023 11:47:20 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8E0173A;
        Tue, 11 Apr 2023 08:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:References:Cc:To:From:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=nWOSvYPI8zO7ZAkdm762g5PDgIPDFk/cAnxhVGSLo2k=; b=syEx1H15VEk8bLhBYcF461EYZf
        1/zzgxbl8dXIvgP55XZSoVPv9MLD6X6hXUVZWcwXBpinZ2GhUZvg6YQJ5ZKMk1YgvhnWkgFMpRNcf
        1tmUv+g4P1Gjpv9MpDfXcyBVznardKYgNFHwl1DsrhkS8yC67Nzf9esufmTqF3amwtTGkvnncaC5K
        LN8uHxa4Y33huH91pFZ6IpDizx1zdLJnze9AuBp8SkuqHV1dy0VWgBlmJQaoPpNuV+1/dxREwJJl5
        uutzHbpb4NdrGJY1+6wls1BfmMbtGBtKzbla+hO9KjKF6dxL2Y/B5eUVsJ0zRjtQMX8IbQ3V9eVdq
        aCkOkKFQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1pmGDC-006ARM-LU; Tue, 11 Apr 2023 09:47:15 -0600
Message-ID: <500092fe-71cc-b07c-fe6d-396a580c8252@deltatee.com>
Date:   Tue, 11 Apr 2023 09:47:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From:   Logan Gunthorpe <logang@deltatee.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Kelvin Cao <kelvin.cao@microchip.com>
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, george.ge@microchip.com
References: <20230403180630.4186061-1-kelvin.cao@microchip.com>
 <20230403180630.4186061-2-kelvin.cao@microchip.com>
 <ZDQ8geSEauTsd2ME@infradead.org>
Content-Language: en-CA
In-Reply-To: <ZDQ8geSEauTsd2ME@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: hch@infradead.org, kelvin.cao@microchip.com, vkoul@kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, george.ge@microchip.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
Subject: Re: [PATCH v2 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 2023-04-10 10:42, Christoph Hellwig wrote:
> On Mon, Apr 03, 2023 at 11:06:28AM -0700, Kelvin Cao wrote:
>> +#define HALT_RETRY 100
>> +static int halt_channel(struct switchtec_dma_chan *swdma_chan)
>> +{
>> +	u32 status;
>> +	struct chan_hw_regs __iomem *chan_hw = swdma_chan->mmio_chan_hw;
>> +	int retry = HALT_RETRY;
>> +	struct pci_dev *pdev;
>> +	int ret;
>> +
>> +	rcu_read_lock();
>> +	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
>> +	if (!pdev) {
>> +		ret = -ENODEV;
>> +		goto unlock_and_exit;
>> +	}
> 
> This whole RCU critical section around every access to ->pdev scheme
> looks a bit bothersome to me.  This means that all the low-level
> PCI ops are done in RCU critical section.  Is this something you
> came up with or is it copied from other drivers?

I suspect they copied it from plx_dma driver that I wrote ;(, though
that driver uses rcu_dereference a bit more sparingly (only on stop,
issue_pending and when allocating and freeing a channel).

> Normally we'd do an unregistration from the dmaengine subsystem
> first, which might do a RCU synchronization at a high level,
> and then we're sure that none of the methods gets called again
> on the unregistered device.
> 
> Can't this driver (and the dmaengine core) support an operation
> mode where you set a shutdown flag at the beginning 

The dmaengine code didn't support hot unplug at all. I believe most
drivers are likely to crash if this happens. When I wrote the plx-dma
engine, I had to make a bunch of changes to dmaengine just so the
framework didn't crash when I tested this. The framework is pretty thin,
so there's not much to synchronize on to indicate other threads are not
in the middle of issuing new IO when a flag is set.

>> +	tasklet_schedule(&swdma_dev->chan_status_task);
> 
> What speaks against simply using threaded irqs here instead of the
> tasklets?

Almost all the dmaengine drivers use tasklets. I don't know if this is
the best approach, but my understanding was that it was due to needing
low latency in processing the completed descriptors, otherwise it can be
hard to reach the full bandwidth of the dma engine.

Logan
