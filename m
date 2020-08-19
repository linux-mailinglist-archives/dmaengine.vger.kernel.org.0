Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9337249B83
	for <lists+dmaengine@lfdr.de>; Wed, 19 Aug 2020 13:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgHSLRu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Aug 2020 07:17:50 -0400
Received: from www381.your-server.de ([78.46.137.84]:32772 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbgHSLRi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Aug 2020 07:17:38 -0400
X-Greylist: delayed 536 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Aug 2020 07:17:36 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=PXfvSPFtBMluQAvegskJOAm1wzYdd4jMhbecJAC6wAU=; b=eDfFoTCTutJK03cocRFF/wbbfM
        SByYmpX/VD0vY8KaiLXkjKN7HC8di6RtXVYJlnsS4H1UIPOVMcTo2/trf5pk2FtB5z2JIQBfQ6Klr
        X70rQ8xlemViWOrfZ7GHbh1y1G4bX4MybvPG23VoshRJzO6+YL8gfPUMLyEEkA8AamHFVxegAtRqt
        nxye+EAbYC63R8wim37mjuJYgAjKJlqW4rYVVR6W+8m3R9Rw8UBPXGZwpVOB44UjvnbgN6C+I1nm2
        4HBSIkteQhbk1LfpDech8i9EaYT2AUv/j7vdvDwzNnUP5x/5OjbDh5pCk5ncyfspxe8l6j6ubxv1Z
        RKU9aOZQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1k8M5J-0008CP-SV; Wed, 19 Aug 2020 13:16:49 +0200
Received: from [2001:a61:25dc:8101:9e5c:8eff:fe01:8578]
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1k8M5J-000JL2-LY; Wed, 19 Aug 2020 13:16:49 +0200
Subject: Re: pcm|dmaengine|imx-sdma race condition on i.MX6
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Benjamin Bara - SKIDATA <Benjamin.Bara@skidata.com>,
        Robin Gong <yibin.gong@nxp.com>
Cc:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "timur@kernel.org" <timur@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Richard Leitner - SKIDATA <Richard.Leitner@skidata.com>
References: <20200813112258.GA327172@pcleri>
 <VE1PR04MB6638EE5BDBE2C65FF50B7DB889400@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <61498763c60e488a825e8dd270732b62@skidata.com>
 <16942794-1e03-6da0-b8e5-c82332a217a5@metafoo.de>
Message-ID: <7a16b532-6edd-83b3-6a57-c0b471b9401a@metafoo.de>
Date:   Wed, 19 Aug 2020 13:16:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <16942794-1e03-6da0-b8e5-c82332a217a5@metafoo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/25904/Mon Aug 17 15:02:24 2020)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 8/19/20 1:08 PM, Lars-Peter Clausen wrote:
> On 8/17/20 9:28 AM, Benjamin Bara - SKIDATA wrote:
>> We think this is not an i.MX6-specific problem, but a problem of the 
>> DMAengine usage from the PCM.
>> In case of a XRUN, the DMA channel is never closed but first a 
>> SNDRV_PCM_TRIGGER_STOP next a
>> SNDRV_PCM_TRIGGER_START is triggered.
>> The SNDRV_PCM_TRIGGER_STOP simply executes a 
>> dmaengine_terminate_async() [1]
>> but does not await the termination by calling dmaengine_synchronize(),
>> which is required as stated by the docu [2].
>> Anyways, we are not able to fix it in the pcm_dmaengine layer either 
>> at the end of
>> SNDRV_PCM_TRIGGER_STOP (called from the DMA on complete interrupt 
>> handler)
>> or at the beginning of SNDRV_PCM_TRIGGER_START (called from a PCM 
>> ioctl),
>> since the dmaengine_synchronize() requires a non-atomic context.
>
> I think this might be an sdma specific problem after all. 
> dmaengine_terminate_async() will issue a request to stop the DMA. But 
> it is still safe to issue the next transfer, even without calling 
> dmaengine_synchronize(). The DMA should start the new transfer at its 
> earliest convenience in that case.
>
> dmaegine_synchronize() is so that the consumer has a guarantee that 
> the DMA is finished using the resources (e.g. the memory buffers) 
> associated with the DMA transfer so it can safely free them. 

You can think of dmaengine_terminate_async() and 
dmaengine_issue_pending() as adding operations to a command queue. The 
DMA is responsible that the operations are executed in the same order 
that they were added to the queue and to make sure that their execution 
does not conflict.

dmaegine_synchronize() is for external consumers to wait until all 
operations in the command queue have been completed.

