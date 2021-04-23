Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44452368F42
	for <lists+dmaengine@lfdr.de>; Fri, 23 Apr 2021 11:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241184AbhDWJRk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 23 Apr 2021 05:17:40 -0400
Received: from www381.your-server.de ([78.46.137.84]:36402 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbhDWJRj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 23 Apr 2021 05:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=qmJuVL1g1fr6E+1DBr4ModYROBnWkR5AVIB0dNXvjLU=; b=H86hoizZbarzr5rlz5jW2Ly0ei
        HKrApdYU4iWdKst6BansFhuH/MGqKcBqm/8QfeqRrz2nh+knwaDEfh9ZD+soRnHGUG6HNzPbjTnp0
        a2cwJzzi+PA1hAQ0vUJZGN9glwuiUm9glGAJAKrx3b2bejpE0NSZqBy0gRG+Ze+ejd3bOjFBI9kht
        HPMZruz6bvKVS46hwe2fzdvDfZRsAQRe7JvQNxR1JyIXE4nAuILAXAbnQQabNtOJUUOd4xfcnVEHT
        tu+VKFqlmwJZCHQlYUNDSNqPRQfyxr2uZ02XtWUTOJ9GfRlAD0PVJMHwZ5rKsfDuPrd4TgBDZFsVQ
        163Zsu/Q==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lZrvp-00042h-1i; Fri, 23 Apr 2021 11:17:01 +0200
Received: from [2001:a61:2a42:9501:9e5c:8eff:fe01:8578]
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lZrvo-00044m-UK; Fri, 23 Apr 2021 11:17:00 +0200
Subject: Re: [PATCH 0/4] Expand Xilinx CDMA functions
To:     Adrian Larumbe <adrian.martinezlarumbe@imgtec.com>,
        vkoul@kernel.org, dmaengine@vger.kernel.org
Cc:     michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org
References: <20210423011913.13122-1-adrian.martinezlarumbe@imgtec.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <c2876f2c-beb2-f159-9b61-d69ae6b8275a@metafoo.de>
Date:   Fri, 23 Apr 2021 11:17:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210423011913.13122-1-adrian.martinezlarumbe@imgtec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26148/Thu Apr 22 13:06:46 2021)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 4/23/21 3:19 AM, Adrian Larumbe wrote:
> Recently at Imgtec we had to provide GLES API buffers with DMA transfer
> capabilities to device memory. We had access to a Xilinx CDMA IP module,
> but even though the hardware supports scatter-gather operations,
> the driver did not. This patch series' goal is to extend the driver
> to support SG transfers on CDMA devices.

Hi,

Thanks for the patch series. From an implementation point of view this 
looks good. But I'm a bit concerned about dmaengine API compliance.

The device_config() and device_prep_slave_sg() APIs are meant for 
memory-to-device or device-to-memory transfers. This means the device 
address is fixed and usually maps to a FIFO in the device.

What you are implementing is memory-to-memory, which means addresses are 
incremented on both sides of transfer. And this works if you know what 
you are doing, e.g. you know that you are using a specific dmaengine 
driver that implements the dmaengine API in a way that does not comply 
with the specification. But it breaks for generic dmaengine API clients 
that expect compliant behavior. And it is the reason why we have an API 
in the first place, to get consistent behavior. If you have to know 
about the driver specific semantics you might as well just bypass the 
framework and use driver specific functions.

And the CDMA seems to support the dmaengine API intended behavior 
through what it calls the keyhole feature where the address is not 
incremented. And if somebody wanted to use that feature they wouldn't be 
able to add support for it because it will break your usage of the 
prep_slave_sg() API.

It seems to me what we are missing from the DMAengine API is the 
equivalent of device_prep_dma_memcpy() that is able to take SG lists. 
There is already a memset_sg, it should be possible to add something 
similar for memcpy.

  - Lars



