Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 230D8249BD5
	for <lists+dmaengine@lfdr.de>; Wed, 19 Aug 2020 13:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgHSLbd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Aug 2020 07:31:33 -0400
Received: from www381.your-server.de ([78.46.137.84]:55420 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbgHSLb1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Aug 2020 07:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=Yizu0B+kldphRZQIsd5F3k8rBmn/SxqZl5tpjkKKWuU=; b=V9m5ZcC+q6oJS018Hh+tssQ+Vg
        ZvJc6AT32vijPRa8TOeZ5l1EEeGNXvnp2gcM2kiKaf+/GKuCPcSzAdD8UiHZQb0J9J9mnZSsh5naR
        CyfJOIqVcbanGG5qBTTJQghzBVsHA9/yiWDivmVsjq/2hSK7QGtgsjVyd6qtQgvaWkSbydYT25p7o
        e9I5uZx4NIQR+WppTKQJzq9tR2vUFvFMQKG5cTJOBarH5oBA3MiGykeh9YiUXGYO7+jGTgSepyche
        YUE6jKt/4qsj6KbMUlJTEZBmxMjGGkWsG9oPMfVlzIjJDK6GAs5ZYleLgXs6K+Ln4tfLu6/rKRvrP
        qGVNvJ5g==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1k8LxG-0007cU-PW; Wed, 19 Aug 2020 13:08:31 +0200
Received: from [2001:a61:25dc:8101:9e5c:8eff:fe01:8578]
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1k8LxG-0009JP-HA; Wed, 19 Aug 2020 13:08:30 +0200
Subject: Re: pcm|dmaengine|imx-sdma race condition on i.MX6
To:     Benjamin Bara - SKIDATA <Benjamin.Bara@skidata.com>,
        Robin Gong <yibin.gong@nxp.com>
Cc:     "timur@kernel.org" <timur@kernel.org>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Richard Leitner - SKIDATA <Richard.Leitner@skidata.com>
References: <20200813112258.GA327172@pcleri>
 <VE1PR04MB6638EE5BDBE2C65FF50B7DB889400@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <61498763c60e488a825e8dd270732b62@skidata.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <16942794-1e03-6da0-b8e5-c82332a217a5@metafoo.de>
Date:   Wed, 19 Aug 2020 13:08:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <61498763c60e488a825e8dd270732b62@skidata.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/25904/Mon Aug 17 15:02:24 2020)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 8/17/20 9:28 AM, Benjamin Bara - SKIDATA wrote:
> We think this is not an i.MX6-specific problem, but a problem of the DMAengine usage from the PCM.
> In case of a XRUN, the DMA channel is never closed but first a SNDRV_PCM_TRIGGER_STOP next a
> SNDRV_PCM_TRIGGER_START is triggered.
> The SNDRV_PCM_TRIGGER_STOP simply executes a dmaengine_terminate_async() [1]
> but does not await the termination by calling dmaengine_synchronize(),
> which is required as stated by the docu [2].
> Anyways, we are not able to fix it in the pcm_dmaengine layer either at the end of
> SNDRV_PCM_TRIGGER_STOP (called from the DMA on complete interrupt handler)
> or at the beginning of SNDRV_PCM_TRIGGER_START (called from a PCM ioctl),
> since the dmaengine_synchronize() requires a non-atomic context.

I think this might be an sdma specific problem after all. 
dmaengine_terminate_async() will issue a request to stop the DMA. But it 
is still safe to issue the next transfer, even without calling 
dmaengine_synchronize(). The DMA should start the new transfer at its 
earliest convenience in that case.

dmaegine_synchronize() is so that the consumer has a guarantee that the 
DMA is finished using the resources (e.g. the memory buffers) associated 
with the DMA transfer so it can safely free them.

>
> Based on my understanding, most of the DMA implementations don't even implement device_synchronize
> and if they do, it might not really be necessary since the terminate_all operation is synchron.
There are a lot of buggy DMAengine drivers :) Pretty much all of them 
need device_synchronize() to get this right.
>
> With the i.MX6, it looks a bit different:
> Since [4], the terminate_all operation really schedules a worker which waits the required ~1ms and
> then does the context freeing.
> Now, the ioctl(SNDRV_PCM_IOCTL_PREPARE) and the following ioctl(SNDRV_PCM_IOCTL_READI_FRAMES),
> which are called from US to handle/recover from a XRUN, are in a race with the terminate_worker.
> If the terminate_worker finishes earlier, everything is fine.
> Otherwise, the sdma_prep_dma_cyclic() is called, sets up everything and
> as soon as it is scheduled out to wait for data, the terminate_worker is scheduled and kills it.
> In this case, we wait in [5] until the timeout is reached and return with -EIO.
>
> Based on our understanding, there exist two different fixing approaches:
> We thought that the pcm_dmaengine should handle this by either synchronizing the DMA on a trigger or
> terminating it synchronously.
> However, as we are in an atomic context, we either have to give up the atomic context of the PCM
> to finish the termination or we have to design a synchronous terminate variant which is callable
> from an atomic context.
>
> For the first option, which is potentially more performant, we have to leave the atomic PCM context
> and we are not sure if we are allowed to.
> For the second option, we would have to divide the dma_device terminate_all into an atomic sync and
> an async one, which would align with the dmaengine API, giving it the option to ensure termination
> in an atomic context.
> Based on my understanding, most of them are synchronous anyways, for the currently async ones we
> would have to implement busy waits.
> However, with this approach, we reach the WARN_ON [6] inside of an atomic context,
> indicating we might not do the right thing.

I don't know how feasible this is to implement in the SDMA dmaengine 
driver. But I think what is should do is to have some flag to indicate 
if a terminate is in progress. If a new transfer is issued while 
terminate is in progress the transfer should go on a list. Once 
terminate finishes it should check the list and start the transfer if 
there are any on the list.

- Lars

