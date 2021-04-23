Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB3A36940D
	for <lists+dmaengine@lfdr.de>; Fri, 23 Apr 2021 15:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhDWNvl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 23 Apr 2021 09:51:41 -0400
Received: from www381.your-server.de ([78.46.137.84]:55574 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhDWNvk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 23 Apr 2021 09:51:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=4AIAwecX2RapGXS7Rv2jJCw2iNl4rN/QPj81c/yd3XI=; b=Lt3HWQdThg1ZPhA64Z3fju/GpD
        C5bRECQ/x7KI0b+Ixr2ZxUQbZenqRuYA/VowIf5o9+53fMF7Y7nXohOLRq8gVDoPfKa0RleYlZlPE
        3LgiNvb2xOXRjXCo9VojB5dg/QIP5XngvrcYwrI8Zq/x4xf8i5fucRr+VG24fP9T46cY4RqIooPuM
        6iI4/JBpwudYQpVNgK115h2fhnNeg3pe9AO4zzx6WGBIcQtDAAOVQts+DygHn5Zrp9nTkRaQoJp4V
        41q9VTWg5G3S4cRh+W5bf6OFGdnAmp+z9Wrkj7PfVq0gkXHWAi8lak5uVYKbQiurVia9GiGsjTsA4
        q9njxzoQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lZwCz-000ENm-Nb; Fri, 23 Apr 2021 15:51:01 +0200
Received: from [2001:a61:2a42:9501:9e5c:8eff:fe01:8578]
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lZwCz-0005PG-K3; Fri, 23 Apr 2021 15:51:01 +0200
Subject: Re: [PATCH 0/4] Expand Xilinx CDMA functions
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Adrian Larumbe <adrian.martinezlarumbe@imgtec.com>,
        dmaengine@vger.kernel.org, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org
References: <20210423011913.13122-1-adrian.martinezlarumbe@imgtec.com>
 <c2876f2c-beb2-f159-9b61-d69ae6b8275a@metafoo.de>
 <YILKq+jNZZSs37xa@vkoul-mobl.Dlink>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <bed31611-a084-2a05-f3a3-25585a47be9a@metafoo.de>
Date:   Fri, 23 Apr 2021 15:51:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YILKq+jNZZSs37xa@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26149/Fri Apr 23 13:08:44 2021)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 4/23/21 3:24 PM, Vinod Koul wrote:
> On 23-04-21, 11:17, Lars-Peter Clausen wrote:
>> It seems to me what we are missing from the DMAengine API is the equivalent
>> of device_prep_dma_memcpy() that is able to take SG lists. There is already
>> a memset_sg, it should be possible to add something similar for memcpy.
> You mean something like dmaengine_prep_dma_sg() which was removed?
>
Ah, that's why I could have sworn we already had this!

> static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_sg(
>                 struct dma_chan *chan,
>                 struct scatterlist *dst_sg, unsigned int dst_nents,
>                 struct scatterlist *src_sg, unsigned int src_nents,
>                 unsigned long flags)
>
> The problem with this API is that it would work only when src_sg and
> dst_sg is of similar nature, if not then how should one go about
> copying...should we fill without a care for dst_sg being different than
> src_sg as long as total data to be copied has enough space in dst...
At least for the CDMA the only requirement is that both buffers have the 
same total size.
