Return-Path: <dmaengine+bounces-2033-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 517878C62A8
	for <lists+dmaengine@lfdr.de>; Wed, 15 May 2024 10:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0E971F2106B
	for <lists+dmaengine@lfdr.de>; Wed, 15 May 2024 08:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD2B4C627;
	Wed, 15 May 2024 08:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="iz4yb1kT";
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="gRY85KDA"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.kernel-space.org (mail.kernel-space.org [195.201.34.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3EE495CB;
	Wed, 15 May 2024 08:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.34.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715761109; cv=none; b=M0/5TX4j27zEK5E2kQAd4z0yo4fSizhWnwqUErTAwBqjdcJSWBRNTlulzWCG7zaVhgN/+8T7Om0IvsKlDGIGkRhLrwt9afoPMaKemKzDvWApXbFk3SzCB/zvkLlor5vr5W3Kf6uCGwSouiRvlNfMoK5sunouyWXfBep5awii7xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715761109; c=relaxed/simple;
	bh=DuYzdQ4ozjzwNMHsNhG1o4oV3Dk1UgDXVGvCW21lIrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K0tCnA4kwfIgBXvid4ddZcMO+7hogoZtg5t8yW+ifvl/sIFhWCZI/+WOX1Y2G4YdLlDmEEu0nZF1efl+m1cPzh/OEgSmzD3I8VjWZ4Galbp99C0sRXmnY2jYiyEz8m5LICY5B5ZaJtUaR0Yrxu6QTwQwaXR+yWXoPdJ+EiBGIl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernel-space.org; spf=pass smtp.mailfrom=kernel-space.org; dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b=iz4yb1kT; dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b=gRY85KDA; arc=none smtp.client-ip=195.201.34.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel-space.org
Received: from kernel-space.org (localhost [127.0.0.1])
	by kernel-space.org (OpenSMTPD) with ESMTP id c3490496;
	Wed, 15 May 2024 08:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kernel-space.org; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=s1; bh=sM
	N8lvPPVflPnoZoJveKf8Q1ADo=; b=iz4yb1kT/R5n218pcQTbTv7zNhMJhaIZF2
	Hey1fHzjt0wJQHEfVNCHfYQHc2ZokHQYp/QFKnFRLFxlWQ9rXr3+jzoSChiNGGrJ
	zi3x6vCHegOR/YhX1O14CBoBfVL/UWOWVbajWciUAS38GwITBA76x6dguz95Z5zq
	26y3K8BeI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kernel-space.org; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=s1; b=
	gvbuRt+0x7h/mpjd8uXfXhWtqWk0nTsXE5btV7YKh6sK3otblK47/LkWxVfkFR1v
	qfvn0/G+OrtWp+kvcWPDppR9FEYdzaYl3fwi7Ms+JLMRVNn3UpLFEnBuSOYgNrrM
	Mu8baNBTaoXLsOw8UHhY3tao0xeLBHyuCri7WI6ldG4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
	s=s1; t=1715761023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dxVOup/aVv/MpYJYTFVG9d1ZR33d+RcbxnWYhtAFX2Y=;
	b=gRY85KDAmNWKDoNuYm2yHHGm2JW7H3sZ7khqKkOM3xnsjYzHEjOQSps9dSCXSruOnhBkpv
	MuytPo/DSoDMrEZUe7jSfEdIirpbwwi4INWmZ5i9B9QeNtUf5B40FSce4oaKE7tZ57P+1q
	ChPsBvEZ0gm26ySmPs2gKJYwNKzEZCs=
Received: from [192.168.0.2] (host-79-16-6-145.retail.telecomitalia.it [79.16.6.145])
	by kernel-space.org (OpenSMTPD) with ESMTPSA id 8ac6b507 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 08:17:03 +0000 (UTC)
Message-ID: <04720832-afc4-44a7-be90-22fe582df45c@kernel-space.org>
Date: Wed, 15 May 2024 10:17:41 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] dmaengine: fsl-edma: merge mcf-edma into fsl-edma
 driver
To: Frank Li <Frank.li@nxp.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Vinod Koul <vkoul@kernel.org>,
 "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM"
 <dmaengine@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:FREESCALE eDMA DRIVER" <imx@lists.linux.dev>,
 Greg Ungerer <gerg@linux-m68k.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>
References: <20240509193517.3571694-1-Frank.Li@nxp.com>
 <CAMuHMdVB2PrkxDMoo0y1y6SLj-yuW5o+PJ+sQn2VtB2yrXzkbw@mail.gmail.com>
 <bd538260-2403-4912-961c-549c74aead76@kernel-space.org>
 <ZkOOSRMxX8MAO/3W@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <ZkOOSRMxX8MAO/3W@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 14/05/24 6:16 PM, Frank Li wrote:
> On Tue, May 14, 2024 at 09:57:09AM +0200, Angelo Dureghello wrote:
>> Hi,
>>
>> On 13/05/24 8:12 PM, Geert Uytterhoeven wrote:
>>> CC coldfire
>>>
>>> On Thu, May 9, 2024 at 9:35 PM Frank Li <Frank.Li@nxp.com> wrote:
>>>> MCF eDMA are almost the same as FSL eDMA driver. Previously link to two
>>>> kernel modules, fsl-edma.ko and mcf-edma.ko. These are not problem because
>>>> mcf-edma is for m68k ARCH and FSL eDMA is for arm/arm64 ARCH. But often
>>>> build both at PPC ARCH. It also makes sense to build two drivers at the
>>>> same time. It causes many build warning because share a fsl-edma-common.o.
>>>> such as:
>>>>
>>>>      powerpc64le-linux-ld: warning: orphan section `.stubs' from `drivers/dma/fsl-edma-common.o' being placed in section `.stubs'
>>>>      powerpc64le-linux-ld: warning: orphan section `.stubs' from `drivers/dma/fsl-edma-trace.o' being placed in section `.stubs'
>>>>
>>>> Merge mcf-edma into fsl-edma driver. So use one driver (fsl-edma.ko) for
>>>> MCF and FSL eDMA.
>>>>
>>>> mcf-edma.ko should be replaced by fsl-edma.ko in modules, minimizing user
>>>> space impact because MCF eDMA remains confined to legacy ColdFire mcf5441x
>>>> production and mcf5441x has been in production for at least a decade and
>>>> NXP has long ceased ColdFire development.
>> when i developed mcf-edma, i tried to modify fsl-edma first. Modules are
>> similar but there are various edma IP versions, and i remember minimal
>> differences in the CF version too, some register bits and, of course,
>> endianness.
>>
>> If a merge is possible, welcome, i have here mcf5441x, can give a try to
>> this patch as soon as i can.
> Thanks. I am not sure if recent eDMAv3 and eDMAv5 patch impact mcf5441.
> eDMAv3 is quite big change. If you can test on mcf5441x, can I send to you
> a futher clean up for mcf5441x?


sure


> This patch are just simple glue two
> driver together to avoid a build warning.



>>
>>>> Update Kconfig to make MCF_EDMA as feature of FSL_EDMA and change Makefile
>>>> to link mcl-edma-main.o to fsl-edma.o.
>>>>
>>>> Create a common module init/exit functions, which call original's
>>>> fsl-edma-init[exit]() and mcf-edma-init[exit]().
>>>>
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>> Closes: https://lore.kernel.org/oe-kbuild-all/202405082029.Es9umH7n-lkp@intel.com/
>>>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>>>> ---
>>>>    drivers/dma/Kconfig           |  8 ++++----
>>>>    drivers/dma/Makefile          |  5 ++---
>>>>    drivers/dma/fsl-edma-common.c | 28 ++++++++++++++++++++++++++++
>>>>    drivers/dma/fsl-edma-common.h |  5 +++++
>>>>    drivers/dma/fsl-edma-main.c   |  6 ++----
>>>>    drivers/dma/mcf-edma-main.c   |  6 ++----
>>>>    6 files changed, 43 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
>>>> index 002a5ec806207..45110520f6e68 100644
>>>> --- a/drivers/dma/Kconfig
>>>> +++ b/drivers/dma/Kconfig
>>>> @@ -393,14 +393,14 @@ config LS2X_APB_DMA
>>>>             It does not support memory to memory data transfer.
>>>>
>>>>    config MCF_EDMA
>>>> -       tristate "Freescale eDMA engine support, ColdFire mcf5441x SoCs"
>>>> +       bool "Freescale eDMA engine support, ColdFire mcf5441x SoCs"
>>>>           depends on M5441x || COMPILE_TEST
>>>>           select DMA_ENGINE
>>>>           select DMA_VIRTUAL_CHANNELS
>>>>           help
>>>> -         Support the Freescale ColdFire eDMA engine, 64-channel
>>>> -         implementation that performs complex data transfers with
>>>> -         minimal intervention from a host processor.
>>>> +         Support the Freescale ColdFire eDMA engine in FSL_EDMA driver,
>>>> +         64-channel implementation that performs complex data transfers
>>>> +         with minimal intervention from a host processor.
>>>>             This module can be found on Freescale ColdFire mcf5441x SoCs.
>>>>
>>>>    config MILBEAUT_HDMAC
>>>> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
>>>> index 802ca916f05f5..0000922c7cbfe 100644
>>>> --- a/drivers/dma/Makefile
>>>> +++ b/drivers/dma/Makefile
>>>> @@ -33,11 +33,10 @@ obj-$(CONFIG_DW_EDMA) += dw-edma/
>>>>    obj-$(CONFIG_EP93XX_DMA) += ep93xx_dma.o
>>>>    fsl-edma-trace-$(CONFIG_TRACING) := fsl-edma-trace.o
>>>>    CFLAGS_fsl-edma-trace.o := -I$(src)
>>>> +mcf-edma-main-$(CONFIG_MCF_EDMA) := mcf-edma-main.o
>>>>    obj-$(CONFIG_FSL_DMA) += fsldma.o
>>>> -fsl-edma-objs := fsl-edma-main.o fsl-edma-common.o ${fsl-edma-trace-y}
>>>> +fsl-edma-objs := fsl-edma-main.o fsl-edma-common.o ${fsl-edma-trace-y} ${mcf-edma-main-y}
>>>>    obj-$(CONFIG_FSL_EDMA) += fsl-edma.o
>>>> -mcf-edma-objs := mcf-edma-main.o fsl-edma-common.o ${fsl-edma-trace-y}
>>>> -obj-$(CONFIG_MCF_EDMA) += mcf-edma.o
>>>>    obj-$(CONFIG_FSL_QDMA) += fsl-qdma.o
>>>>    obj-$(CONFIG_FSL_RAID) += fsl_raid.o
>>>>    obj-$(CONFIG_HISI_DMA) += hisi_dma.o
>>>> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
>>>> index 3af4307873157..ac04a2ce4fa1f 100644
>>>> --- a/drivers/dma/fsl-edma-common.c
>>>> +++ b/drivers/dma/fsl-edma-common.c
>>>> @@ -888,4 +888,32 @@ void fsl_edma_setup_regs(struct fsl_edma_engine *edma)
>>>>           }
>>>>    }
>>>>
>>>> +static int __init fsl_edma_common_init(void)
>>>> +{
>>>> +       int ret;
>>>> +
>>>> +       ret = fsl_edma_init();
>>>> +       if (ret)
>>>> +               return ret;
>>>> +
>>>> +#ifdef CONFIG_MCF_EDMA
>>>> +       ret = mcf_edma_init();
>>>> +       if (ret)
>>>> +               return ret;
>>>> +#endif
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +subsys_initcall(fsl_edma_common_init);
>>>> +
>>>> +static void __exit fsl_edma_common_exit(void)
>>>> +{
>>>> +       fsl_edma_exit();
>>>> +
>>>> +#ifdef CONFIG_MCF_EDMA
>>>> +       mcf_edma_exit();
>>>> +#endif
>>>> +}
>>>> +module_exit(fsl_edma_common_exit);
>>>> +
>>>>    MODULE_LICENSE("GPL v2");
>>>> diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
>>>> index ac66222c16040..dfbdcc922ceea 100644
>>>> --- a/drivers/dma/fsl-edma-common.h
>>>> +++ b/drivers/dma/fsl-edma-common.h
>>>> @@ -488,4 +488,9 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan);
>>>>    void fsl_edma_cleanup_vchan(struct dma_device *dmadev);
>>>>    void fsl_edma_setup_regs(struct fsl_edma_engine *edma);
>>>>
>>>> +int __init fsl_edma_init(void);
>>>> +void __exit fsl_edma_exit(void);
>>>> +int __init mcf_edma_init(void);
>>>> +void __exit mcf_edma_exit(void);
>>>> +
>>>>    #endif /* _FSL_EDMA_COMMON_H_ */
>>>> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
>>>> index 391e4f13dfeb0..a1c3c4ed869c5 100644
>>>> --- a/drivers/dma/fsl-edma-main.c
>>>> +++ b/drivers/dma/fsl-edma-main.c
>>>> @@ -724,17 +724,15 @@ static struct platform_driver fsl_edma_driver = {
>>>>           .remove_new     = fsl_edma_remove,
>>>>    };
>>>>
>>>> -static int __init fsl_edma_init(void)
>>>> +int __init fsl_edma_init(void)
>>>>    {
>>>>           return platform_driver_register(&fsl_edma_driver);
>>>>    }
>>>> -subsys_initcall(fsl_edma_init);
>>>>
>>>> -static void __exit fsl_edma_exit(void)
>>>> +void __exit fsl_edma_exit(void)
>>>>    {
>>>>           platform_driver_unregister(&fsl_edma_driver);
>>>>    }
>>>> -module_exit(fsl_edma_exit);
>>>>
>>>>    MODULE_ALIAS("platform:fsl-edma");
>>>>    MODULE_DESCRIPTION("Freescale eDMA engine driver");
>>>> diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
>>>> index 78c606f6d0026..d97991a1e9518 100644
>>>> --- a/drivers/dma/mcf-edma-main.c
>>>> +++ b/drivers/dma/mcf-edma-main.c
>>>> @@ -284,17 +284,15 @@ bool mcf_edma_filter_fn(struct dma_chan *chan, void *param)
>>>>    }
>>>>    EXPORT_SYMBOL(mcf_edma_filter_fn);
>>>>
>>>> -static int __init mcf_edma_init(void)
>>>> +int __init mcf_edma_init(void)
>>>>    {
>>>>           return platform_driver_register(&mcf_edma_driver);
>>>>    }
>>>> -subsys_initcall(mcf_edma_init);
>>>>
>>>> -static void __exit mcf_edma_exit(void)
>>>> +void __exit mcf_edma_exit(void)
>>>>    {
>>>>           platform_driver_unregister(&mcf_edma_driver);
>>>>    }
>>>> -module_exit(mcf_edma_exit);
>>>>
>>>>    MODULE_ALIAS("platform:mcf-edma");
>>>>    MODULE_DESCRIPTION("Freescale eDMA engine driver, ColdFire family");
>>>> --
>>>> 2.34.1
>> Regards,
>> angelo
>>
Regards,
angelo



