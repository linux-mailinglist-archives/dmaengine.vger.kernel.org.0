Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE7224C53F
	for <lists+dmaengine@lfdr.de>; Thu, 20 Aug 2020 20:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgHTSXv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Aug 2020 14:23:51 -0400
Received: from www381.your-server.de ([78.46.137.84]:54198 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgHTSXu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Aug 2020 14:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=Pba3wqITnv1HSpWANOUiwdXFXFAyf2fUBM6+eV5vKqA=; b=mccu0oQkjLx5k/gEQ8IzLxYpyX
        h1dzqZiLk5lGWwrDefLML+xi1PbKVHeCS5wmwalrBkanPFJ7s1LLy2WCXjw0HGngC+k9wNOUTVUL7
        hCRZ1nnCa5inJZ0drhD9yckBGW5WtMjfHzT6XyFp/xb4iYmrQlPqjuqdKZZi0jfk7EgyQOLFRvwoL
        1H/Ll+strO7/vg3Shygo90l1iafT5nuCFZZeutaheRVbZjn+iAuB+/GI3iKCy/WbwUy3+nQ41gR/H
        DnLeKokhdtC+5e2nFtVBDJxz65+gTJdJaic0DqE3a4rAL1zNWjV4nHkKN/IHcShx7TFk+sJH9C47x
        ZbXCd42A==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1k8pDt-0005Xe-3p; Thu, 20 Aug 2020 20:23:37 +0200
Received: from [2001:a61:25dc:8101:9e5c:8eff:fe01:8578]
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1k8pDs-000D44-US; Thu, 20 Aug 2020 20:23:36 +0200
Subject: Re: [PATCH] drivers/dma/dma-jz4780: Fix race condition between probe
 and irq handler
To:     Paul Cercueil <paul@crapouillou.net>, madhuparnabhowmik10@gmail.com
Cc:     dan.j.williams@intel.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrianov@ispras.ru, ldv-project@linuxtesting.org
References: <20200816072253.13817-1-madhuparnabhowmik10@gmail.com>
 <ZM2DFQ.KQQJYLJ02WTD3@crapouillou.net>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <e1961c04-e2aa-fe3a-fb84-bb3b33fae5dc@metafoo.de>
Date:   Thu, 20 Aug 2020 20:23:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ZM2DFQ.KQQJYLJ02WTD3@crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/25905/Thu Aug 20 15:09:58 2020)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 8/20/20 1:59 PM, Paul Cercueil wrote:
> Hi,
>
> Le dim. 16 août 2020 à 12:52, madhuparnabhowmik10@gmail.com a écrit :
>> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
>>
>> In probe IRQ is requested before zchan->id is initialized which can be
>> read in the irq handler. Hence, shift request irq and enable clock after
>> other initializations complete. Here, enable clock part is not part of
>> the race, it is just shifted down after request_irq to keep the error
>> path same as before.
>>
>> Found by Linux Driver Verification project (linuxtesting.org).
>>
>> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
>
> I don't think there is a race at all, the interrupt handler won't be 
> called before the DMA is registered.
>
 From a purely formal verification perspective there is a bug. The 
interrupt could fire if i.e. the hardware is buggy or something. In 
general it is a good idea to not request the IRQ until all the resources 
that are used in the interrupt handler are properly set up. Even if you 
know that in practice the interrupt will never fire this early.

