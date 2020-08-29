Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616542568F8
	for <lists+dmaengine@lfdr.de>; Sat, 29 Aug 2020 18:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbgH2QBY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 29 Aug 2020 12:01:24 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:50538 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728373AbgH2P6z (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 29 Aug 2020 11:58:55 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Bf1NS3lsKz9v7Dc;
        Sat, 29 Aug 2020 17:58:48 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id AZI3cKIA-s-O; Sat, 29 Aug 2020 17:58:48 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Bf1NS1r4Pz9v7Db;
        Sat, 29 Aug 2020 17:58:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EECD58B7B5;
        Sat, 29 Aug 2020 17:58:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id qSw0-iSMqS91; Sat, 29 Aug 2020 17:58:49 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 29E728B767;
        Sat, 29 Aug 2020 17:58:49 +0200 (CEST)
Subject: Re: [PATCH] fsldma: fsl_ioread64*() do not need lower_32_bits()
To:     Guenter Roeck <linux@roeck-us.net>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Joerg Roedel <joerg.roedel@amd.com>,
        linuxppc-dev@lists.ozlabs.org, Li Yang <leoyang.li@nxp.com>,
        Zhang Wei <zw@zh-kernel.org>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
References: <20200829150551.GA27225@roeck-us.net>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <dc4491f8-f74c-c3c4-82c4-3986c5352205@csgroup.eu>
Date:   Sat, 29 Aug 2020 17:58:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200829150551.GA27225@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



Le 29/08/2020 à 17:05, Guenter Roeck a écrit :
> On Sat, Aug 29, 2020 at 02:45:38PM +0200, Luc Van Oostenryck wrote:
>> For ppc32, the functions fsl_ioread64() & fsl_ioread64be()
>> use lower_32_bits() as a fancy way to cast the pointer to u32
>> in order to do non-atomic 64-bit IO.
>>
>> But the pointer is already 32-bit, so simply cast the pointer to u32.
>>
>> This fixes a compile error introduced by
>>     ef91bb196b0d ("kernel.h: Silence sparse warning in lower_32_bits")
>>
>> Fixes: ef91bb196b0db1013ef8705367bc2d7944ef696b
> 
> checkpatch complains about this and prefers
> 
> Fixes: ef91bb196b0d ("kernel.h: Silence sparse warning in lower_32_bits")

Checkpatch also complains about spacing:

CHECK:SPACING: No space is necessary after a cast
#39: FILE: drivers/dma/fsldma.h:208:
+	u32 fsl_addr = (u32) addr;

CHECK:SPACING: No space is necessary after a cast
#48: FILE: drivers/dma/fsldma.h:222:
+	u32 fsl_addr = (u32) addr;

total: 0 errors, 0 warnings, 2 checks, 16 lines checked

Christophe

> 
> Otherwise
> 
> Tested-by: Guenter Roeck <linux@roeck-us.net>
> 
>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>> Cc: Li Yang <leoyang.li@nxp.com>
>> Cc: Zhang Wei <zw@zh-kernel.org>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Vinod Koul <vkoul@kernel.org>
>> Cc: Herbert Xu <herbert@gondor.apana.org.au>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: dmaengine@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
>> ---
>>   drivers/dma/fsldma.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/dma/fsldma.h b/drivers/dma/fsldma.h
>> index 56f18ae99233..6f6fa7641fa2 100644
>> --- a/drivers/dma/fsldma.h
>> +++ b/drivers/dma/fsldma.h
>> @@ -205,7 +205,7 @@ struct fsldma_chan {
>>   #else
>>   static u64 fsl_ioread64(const u64 __iomem *addr)
>>   {
>> -	u32 fsl_addr = lower_32_bits(addr);
>> +	u32 fsl_addr = (u32) addr;
>>   	u64 fsl_addr_hi = (u64)in_le32((u32 *)(fsl_addr + 1)) << 32;
>>   
>>   	return fsl_addr_hi | in_le32((u32 *)fsl_addr);
>> @@ -219,7 +219,7 @@ static void fsl_iowrite64(u64 val, u64 __iomem *addr)
>>   
>>   static u64 fsl_ioread64be(const u64 __iomem *addr)
>>   {
>> -	u32 fsl_addr = lower_32_bits(addr);
>> +	u32 fsl_addr = (u32) addr;
>>   	u64 fsl_addr_hi = (u64)in_be32((u32 *)fsl_addr) << 32;
>>   
>>   	return fsl_addr_hi | in_be32((u32 *)(fsl_addr + 1));
>> -- 
>> 2.28.0
>>
