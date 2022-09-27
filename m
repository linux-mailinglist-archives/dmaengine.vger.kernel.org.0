Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A785EC9E6
	for <lists+dmaengine@lfdr.de>; Tue, 27 Sep 2022 18:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbiI0Qrs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Sep 2022 12:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbiI0Qr0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 27 Sep 2022 12:47:26 -0400
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9EF3EB6570;
        Tue, 27 Sep 2022 09:46:12 -0700 (PDT)
Received: from [192.168.4.25] (unknown [62.77.71.229])
        by mx.gpxsee.org (Postfix) with ESMTPSA id 28C3A46FC;
        Tue, 27 Sep 2022 18:46:10 +0200 (CEST)
Message-ID: <c0430eb7-d607-acfd-201a-db56db982309@gpxsee.org>
Date:   Tue, 27 Sep 2022 18:46:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH V4 XDMA 2/2] dmaengine: xilinx: xdma: Add user logic
 interrupt support
Content-Language: en-US
To:     Lizhi Hou <lizhi.hou@amd.com>, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com
Cc:     max.zhen@amd.com, sonal.santan@amd.com, larry.liu@amd.com,
        brian.xu@amd.com
References: <1663871905-60498-1-git-send-email-lizhi.hou@amd.com>
 <1663871905-60498-3-git-send-email-lizhi.hou@amd.com>
 <a2b5c35d-ced2-ff83-c550-4bbf29973b80@gpxsee.org>
 <64388266-1707-ee20-c3ab-edb67ada68dc@amd.com>
From:   =?UTF-8?Q?Martin_T=c5=afma?= <tumic@gpxsee.org>
In-Reply-To: <64388266-1707-ee20-c3ab-edb67ada68dc@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27. 09. 22 18:28, Lizhi Hou wrote:

> Okay, I got the point. How about changing request/remove APIs to 
> enable/disable APIs as below
> 
>       xdma_enable_user_irq(struct platform_device *pdev, u32 
> user_irq_index, u32 *irq)
> 
>              user_irq_index: user logic interrupt wire index. (XDMA 
> driver determines how system IRQs are mapped to DMA channels and user 
> logic wires)
> 
>              irq: IRQ number returned for registering interrupt handler 
> (request_irq()) or passing to existing platform driver.
> 
>      xdma_disable_user_irq(struct platform_device *pdev, u32 
> user_irq_index)
> 
> Does this make sense to you?
> 

I think even the "irq" parameter in the enable function is surplus as 
the parent driver (the driver of the actual PCIe card) knows* what PCI 
irq he has to allocate without XDMA providing the number.

xdma_enable_user_irq(struct platform_device *pdev, u32 user_irq_index);
xdma_disable_user_irq(struct platform_device *pdev, u32 user_irq_index);

should be all that is needed.

M.

* something like:
pci_irq_vector((pdev), PCI_BAR_ID) + NUM_C2H_CHANNELS + NUM_H2C_CHANNELS
can be used from the PCIe driver
