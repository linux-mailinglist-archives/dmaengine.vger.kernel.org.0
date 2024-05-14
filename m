Return-Path: <dmaengine+bounces-2029-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EEE8C4D6F
	for <lists+dmaengine@lfdr.de>; Tue, 14 May 2024 10:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5A5BB20CC7
	for <lists+dmaengine@lfdr.de>; Tue, 14 May 2024 08:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6972F17996;
	Tue, 14 May 2024 08:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="0LsLUgiA";
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="x9uFUQS4"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.kernel-space.org (mail.kernel-space.org [195.201.34.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1D617C77;
	Tue, 14 May 2024 08:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.34.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715673869; cv=none; b=FnjzPxDxBYhli2hPsNIAxfurlMy5Wz4Gf+YaXibWcJ9yfuTMvfOXwh5DI1UJbcIX+P5XNGJw9oDHu+4QZs8bbN4IQyg1uzKIErbt2u5PKG9nwQAYxmddKVlWs4ZPCjG2tSmlrfBiiM5SmoOQCy73o3UUM5BtVzFmJQN6tTV+JUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715673869; c=relaxed/simple;
	bh=MnavwG4xDe+bT4+m8GUFgKzjxbVWJw55qnBENhgJS0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qQE8OibYSkUed8nyuzauQWYW/8GI0hEr/0DwgODilpzbqirHtHL1W55kRSRyDWAb+QIi1N+U7xEHjgj2yXTSmDRRNKd6epXhjQLbHIh1KlfwHphqrs6GIwKOWErP7E4wS70Me80FrykgKT3lhPUI7ZygLPsWE5wvb1tJSlVhzhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernel-space.org; spf=pass smtp.mailfrom=kernel-space.org; dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b=0LsLUgiA; dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b=x9uFUQS4; arc=none smtp.client-ip=195.201.34.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel-space.org
Received: from kernel-space.org (localhost [127.0.0.1])
	by kernel-space.org (OpenSMTPD) with ESMTP id 4843119d;
	Tue, 14 May 2024 07:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kernel-space.org; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=s1; bh=ca
	B5PwAVnllql880/2faREzf2Ig=; b=0LsLUgiAZbsT7UjlYhX67sWHogfPBaoFAV
	VKo6wbZyR1SAtA+ecojae0TgNq1Vmroif1x5M1p4Bz0ZcxCmR7npQqcsumsjQMqy
	FAtWqZUYOlGZGD4R4HJlRW73a5B2xd4zxtXBnwwirTJJnWUXqUmqkLnLqJPBtEQA
	jrbCEwprc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kernel-space.org; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=s1; b=
	afULTwWiVL1PXZxYXhzIFxGe9Q4UA8RjXOAi+kLxw5+uZmq7WGvaVB5rpZr6nTHb
	iSLejFPX1x+YIHqsFVI+fabNOdkQUNKNK8ScnGTthRASLod3uDYAu8tzLVpMQuKV
	Pj4X5Bbwh21k5CnAfvkjRazh7Am7UzfQ2jEPveoiTrw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
	s=s1; t=1715673395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cVfJiralSHBKIpiyuDV08+v4xxv00fj5z+EYp8KEzMQ=;
	b=x9uFUQS4YkhuSngcZiX5OrkWmQ4LWw3Cly9Yhsir+BX0rxEfMm0vTdFL0LwRWaoTpBcyMP
	skgLMtymBLzgHo6SDLYMDG4K4XsAJ/3CKLzAAAcaz0nzxC/kdVAf52wRqDxlTxBjSfaV9t
	Z8uY3yr835+iEhfcqOTnqREVOFXG+n8=
Received: from [192.168.0.2] (host-79-16-6-145.retail.telecomitalia.it [79.16.6.145])
	by kernel-space.org (OpenSMTPD) with ESMTPSA id 5a079902 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 May 2024 07:56:35 +0000 (UTC)
Message-ID: <bd538260-2403-4912-961c-549c74aead76@kernel-space.org>
Date: Tue, 14 May 2024 09:57:09 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] dmaengine: fsl-edma: merge mcf-edma into fsl-edma
 driver
To: Geert Uytterhoeven <geert@linux-m68k.org>, Frank Li <Frank.Li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>,
 "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM"
 <dmaengine@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:FREESCALE eDMA DRIVER" <imx@lists.linux.dev>,
 Greg Ungerer <gerg@linux-m68k.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>
References: <20240509193517.3571694-1-Frank.Li@nxp.com>
 <CAMuHMdVB2PrkxDMoo0y1y6SLj-yuW5o+PJ+sQn2VtB2yrXzkbw@mail.gmail.com>
Content-Language: en-US
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <CAMuHMdVB2PrkxDMoo0y1y6SLj-yuW5o+PJ+sQn2VtB2yrXzkbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 13/05/24 8:12 PM, Geert Uytterhoeven wrote:
> CC coldfire
>
> On Thu, May 9, 2024 at 9:35 PM Frank Li <Frank.Li@nxp.com> wrote:
>> MCF eDMA are almost the same as FSL eDMA driver. Previously link to two
>> kernel modules, fsl-edma.ko and mcf-edma.ko. These are not problem because
>> mcf-edma is for m68k ARCH and FSL eDMA is for arm/arm64 ARCH. But often
>> build both at PPC ARCH. It also makes sense to build two drivers at the
>> same time. It causes many build warning because share a fsl-edma-common.o.
>> such as:
>>
>>     powerpc64le-linux-ld: warning: orphan section `.stubs' from `drivers/dma/fsl-edma-common.o' being placed in section `.stubs'
>>     powerpc64le-linux-ld: warning: orphan section `.stubs' from `drivers/dma/fsl-edma-trace.o' being placed in section `.stubs'
>>
>> Merge mcf-edma into fsl-edma driver. So use one driver (fsl-edma.ko) for
>> MCF and FSL eDMA.
>>
>> mcf-edma.ko should be replaced by fsl-edma.ko in modules, minimizing user
>> space impact because MCF eDMA remains confined to legacy ColdFire mcf5441x
>> production and mcf5441x has been in production for at least a decade and
>> NXP has long ceased ColdFire development.

when i developed mcf-edma, i tried to modify fsl-edma first. Modules are
similar but there are various edma IP versions, and i remember minimal
differences in the CF version too, some register bits and, of course,
endianness.

If a merge is possible, welcome, i have here mcf5441x, can give a try to
this patch as soon as i can.


>> Update Kconfig to make MCF_EDMA as feature of FSL_EDMA and change Makefile
>> to link mcl-edma-main.o to fsl-edma.o.
>>
>> Create a common module init/exit functions, which call original's
>> fsl-edma-init[exit]() and mcf-edma-init[exit]().
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202405082029.Es9umH7n-lkp@intel.com/
>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>> ---
>>   drivers/dma/Kconfig           |  8 ++++----
>>   drivers/dma/Makefile          |  5 ++---
>>   drivers/dma/fsl-edma-common.c | 28 ++++++++++++++++++++++++++++
>>   drivers/dma/fsl-edma-common.h |  5 +++++
>>   drivers/dma/fsl-edma-main.c   |  6 ++----
>>   drivers/dma/mcf-edma-main.c   |  6 ++----
>>   6 files changed, 43 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
>> index 002a5ec806207..45110520f6e68 100644
>> --- a/drivers/dma/Kconfig
>> +++ b/drivers/dma/Kconfig
>> @@ -393,14 +393,14 @@ config LS2X_APB_DMA
>>            It does not support memory to memory data transfer.
>>
>>   config MCF_EDMA
>> -       tristate "Freescale eDMA engine support, ColdFire mcf5441x SoCs"
>> +       bool "Freescale eDMA engine support, ColdFire mcf5441x SoCs"
>>          depends on M5441x || COMPILE_TEST
>>          select DMA_ENGINE
>>          select DMA_VIRTUAL_CHANNELS
>>          help
>> -         Support the Freescale ColdFire eDMA engine, 64-channel
>> -         implementation that performs complex data transfers with
>> -         minimal intervention from a host processor.
>> +         Support the Freescale ColdFire eDMA engine in FSL_EDMA driver,
>> +         64-channel implementation that performs complex data transfers
>> +         with minimal intervention from a host processor.
>>            This module can be found on Freescale ColdFire mcf5441x SoCs.
>>
>>   config MILBEAUT_HDMAC
>> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
>> index 802ca916f05f5..0000922c7cbfe 100644
>> --- a/drivers/dma/Makefile
>> +++ b/drivers/dma/Makefile
>> @@ -33,11 +33,10 @@ obj-$(CONFIG_DW_EDMA) += dw-edma/
>>   obj-$(CONFIG_EP93XX_DMA) += ep93xx_dma.o
>>   fsl-edma-trace-$(CONFIG_TRACING) := fsl-edma-trace.o
>>   CFLAGS_fsl-edma-trace.o := -I$(src)
>> +mcf-edma-main-$(CONFIG_MCF_EDMA) := mcf-edma-main.o
>>   obj-$(CONFIG_FSL_DMA) += fsldma.o
>> -fsl-edma-objs := fsl-edma-main.o fsl-edma-common.o ${fsl-edma-trace-y}
>> +fsl-edma-objs := fsl-edma-main.o fsl-edma-common.o ${fsl-edma-trace-y} ${mcf-edma-main-y}
>>   obj-$(CONFIG_FSL_EDMA) += fsl-edma.o
>> -mcf-edma-objs := mcf-edma-main.o fsl-edma-common.o ${fsl-edma-trace-y}
>> -obj-$(CONFIG_MCF_EDMA) += mcf-edma.o
>>   obj-$(CONFIG_FSL_QDMA) += fsl-qdma.o
>>   obj-$(CONFIG_FSL_RAID) += fsl_raid.o
>>   obj-$(CONFIG_HISI_DMA) += hisi_dma.o
>> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
>> index 3af4307873157..ac04a2ce4fa1f 100644
>> --- a/drivers/dma/fsl-edma-common.c
>> +++ b/drivers/dma/fsl-edma-common.c
>> @@ -888,4 +888,32 @@ void fsl_edma_setup_regs(struct fsl_edma_engine *edma)
>>          }
>>   }
>>
>> +static int __init fsl_edma_common_init(void)
>> +{
>> +       int ret;
>> +
>> +       ret = fsl_edma_init();
>> +       if (ret)
>> +               return ret;
>> +
>> +#ifdef CONFIG_MCF_EDMA
>> +       ret = mcf_edma_init();
>> +       if (ret)
>> +               return ret;
>> +#endif
>> +       return 0;
>> +}
>> +
>> +subsys_initcall(fsl_edma_common_init);
>> +
>> +static void __exit fsl_edma_common_exit(void)
>> +{
>> +       fsl_edma_exit();
>> +
>> +#ifdef CONFIG_MCF_EDMA
>> +       mcf_edma_exit();
>> +#endif
>> +}
>> +module_exit(fsl_edma_common_exit);
>> +
>>   MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
>> index ac66222c16040..dfbdcc922ceea 100644
>> --- a/drivers/dma/fsl-edma-common.h
>> +++ b/drivers/dma/fsl-edma-common.h
>> @@ -488,4 +488,9 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan);
>>   void fsl_edma_cleanup_vchan(struct dma_device *dmadev);
>>   void fsl_edma_setup_regs(struct fsl_edma_engine *edma);
>>
>> +int __init fsl_edma_init(void);
>> +void __exit fsl_edma_exit(void);
>> +int __init mcf_edma_init(void);
>> +void __exit mcf_edma_exit(void);
>> +
>>   #endif /* _FSL_EDMA_COMMON_H_ */
>> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
>> index 391e4f13dfeb0..a1c3c4ed869c5 100644
>> --- a/drivers/dma/fsl-edma-main.c
>> +++ b/drivers/dma/fsl-edma-main.c
>> @@ -724,17 +724,15 @@ static struct platform_driver fsl_edma_driver = {
>>          .remove_new     = fsl_edma_remove,
>>   };
>>
>> -static int __init fsl_edma_init(void)
>> +int __init fsl_edma_init(void)
>>   {
>>          return platform_driver_register(&fsl_edma_driver);
>>   }
>> -subsys_initcall(fsl_edma_init);
>>
>> -static void __exit fsl_edma_exit(void)
>> +void __exit fsl_edma_exit(void)
>>   {
>>          platform_driver_unregister(&fsl_edma_driver);
>>   }
>> -module_exit(fsl_edma_exit);
>>
>>   MODULE_ALIAS("platform:fsl-edma");
>>   MODULE_DESCRIPTION("Freescale eDMA engine driver");
>> diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
>> index 78c606f6d0026..d97991a1e9518 100644
>> --- a/drivers/dma/mcf-edma-main.c
>> +++ b/drivers/dma/mcf-edma-main.c
>> @@ -284,17 +284,15 @@ bool mcf_edma_filter_fn(struct dma_chan *chan, void *param)
>>   }
>>   EXPORT_SYMBOL(mcf_edma_filter_fn);
>>
>> -static int __init mcf_edma_init(void)
>> +int __init mcf_edma_init(void)
>>   {
>>          return platform_driver_register(&mcf_edma_driver);
>>   }
>> -subsys_initcall(mcf_edma_init);
>>
>> -static void __exit mcf_edma_exit(void)
>> +void __exit mcf_edma_exit(void)
>>   {
>>          platform_driver_unregister(&mcf_edma_driver);
>>   }
>> -module_exit(mcf_edma_exit);
>>
>>   MODULE_ALIAS("platform:mcf-edma");
>>   MODULE_DESCRIPTION("Freescale eDMA engine driver, ColdFire family");
>> --
>> 2.34.1

Regards,
angelo



