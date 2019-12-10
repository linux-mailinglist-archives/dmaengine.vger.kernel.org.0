Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77375118F5C
	for <lists+dmaengine@lfdr.de>; Tue, 10 Dec 2019 18:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfLJRz1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Dec 2019 12:55:27 -0500
Received: from ale.deltatee.com ([207.54.116.67]:38276 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727259AbfLJRz1 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 10 Dec 2019 12:55:27 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1iejjI-0006rj-HL; Tue, 10 Dec 2019 10:55:25 -0700
To:     Jiasen Lin <linjiasen@hygon.cn>, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Kit Chow <kchow@gigaio.com>
References: <20191210002437.2907-1-logang@deltatee.com>
 <20191210002437.2907-5-logang@deltatee.com>
 <eb5603ae-d884-ea13-7f7a-4d578e4fa6ee@hygon.cn>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <23d2c1a3-54fa-db6c-32ee-312a667ac0c9@deltatee.com>
Date:   Tue, 10 Dec 2019 10:55:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <eb5603ae-d884-ea13-7f7a-4d578e4fa6ee@hygon.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: kchow@gigaio.com, dan.j.williams@intel.com, vkoul@kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linjiasen@hygon.cn
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH v2 4/5] dmaengine: plx-dma: Implement hardware
 initialization and cleanup
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 2019-12-09 11:49 p.m., Jiasen Lin wrote:
> Integrated DMA engine of PEX87xx series switch support various
> interrupts. According to my personal experience, I suggest that
> enable error interrupt, invalid decscriptor interrupt, abort done
> interrupt, graceful puse done interrupt, and
> immediate pasue done interrupt by write  DMA Channel x Interrupt
> Control/Status register.

Well, that depends on what we want to do with these interrupts:

1) We shouldn't need to handle the error/invalid descriptor interrupt.
We instead just see that a specific descriptor failed (in the usual way)
and handle it accordingly. (Though this isn't really documented well).
An invalid descriptor should really never happen unless we have a driver
bug. I suppose I could print an error message if either occur.

2) We never send an abort or immediate pause to the device, so neither
interrupt can ever fire. So there's nothing to do if they do fire and
thus no sense enabling them.

3) We do send a graceful pause to the device on teardown but prefer to
poll for the end of the pause instead of adding the extra complexity to
waiting for an interrupt. So no need for the interrupt.

Logan



> 
> Thanks,
> Jiasen Lin
> 
>>   	kref_init(&plxdev->ref);
>>   	INIT_WORK(&plxdev->release_work, plx_dma_release_work);
>> +	spin_lock_init(&plxdev->ring_lock);
>> +	tasklet_init(&plxdev->desc_task, plx_dma_desc_task,
>> +		     (unsigned long)plxdev);
>>   
>> +	RCU_INIT_POINTER(plxdev->pdev, pdev);
>>   	plxdev->bar = pcim_iomap_table(pdev)[0];
>>   
>>   	dma = &plxdev->dma_dev;
>> @@ -169,6 +501,16 @@ static void plx_dma_remove(struct pci_dev *pdev)
>>   
>>   	free_irq(pci_irq_vector(pdev, 0),  plxdev);
>>   
>> +	rcu_assign_pointer(plxdev->pdev, NULL);
>> +	synchronize_rcu();
>> +
>> +	spin_lock_bh(&plxdev->ring_lock);
>> +	plxdev->ring_active = false;
>> +	spin_unlock_bh(&plxdev->ring_lock);
>> +
>> +	__plx_dma_stop(plxdev);
>> +	plx_dma_abort_desc(plxdev);
>> +
>>   	plxdev->bar = NULL;
>>   	plx_dma_put(plxdev);
>>   
>>
