Return-Path: <dmaengine+bounces-11073-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMKhLss6HGq1LgkAu9opvQ
	(envelope-from <dmaengine+bounces-11073-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 31 May 2026 15:42:35 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC75616668
	for <lists+dmaengine@lfdr.de>; Sun, 31 May 2026 15:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2AEE300C260
	for <lists+dmaengine@lfdr.de>; Sun, 31 May 2026 13:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C902D7DEA;
	Sun, 31 May 2026 13:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXsRDvi/"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F5629ACDD;
	Sun, 31 May 2026 13:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780234952; cv=none; b=sw70o3c+/JpwWSSiAwaz5FIxNr7s5QA6LosJny5DkJnbozp6mV0B6x7fRIuyQAgPZ2SorbVIajigHgCnBPMwHNRBVTwvB660hHzKS+L2ZFv5VBV0tArtGt5qNNvF7qQsCh6VY2LCtCeLo7k1Too1mfOEuDnYxjAyJyof7/gDKk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780234952; c=relaxed/simple;
	bh=zR05hWiH8Rlw66oNAUtRAX4ISbevpkF+05gVF+o8TOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pgBCByvc0ilfWLdJO+o8Ygi5J6KtJ4f59ta5WgfetYhhemA/qzMDenQTpyLzSsmspEavEZE8kyfnvVk57GPom+EPQuVmmKxIE3F/YJJgVuCAwkz+kfEGWEEPXln63YEhzBoUvF9c6BoH2moYTTERen1PC7nUpa6NyXG203zchrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXsRDvi/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292F41F00893;
	Sun, 31 May 2026 13:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780234951;
	bh=dSjHAroP5+L4GQyBa+FNhJO3ihTn8ULsRc3iTGS7mDA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cXsRDvi/iiCxcm/KxbaJf9zvaok8JsIXFHPo0E7kunRCe3kAoGRmggGMBZhV3+J1M
	 aBtew1idHllMUPngx2cKEvhiUqvyMeJvHto5gwOoIy/NM/J6qCviVP+j8mT9/+esaI
	 I19uZ/k1Qk8zp/neDywXwiSTtYAHgdjDrteA2ukGXtYtf1sGIPhgtOx5onzx0vbRGu
	 uRtxcrgygRELyKumKRmwQIZP03gzFGUarcsHAB8nVrjXyp8Eb1DizwAdhr3mtefN8L
	 /g/YB8P4e8WgBkLOzO5H4SsGU9/4mlGAA0uXE+ts7cKNJeMh2//ZoZD5qsNEF4pUL0
	 fdr2Fo8BEoOzA==
Message-ID: <2b532d56-dce4-4f6d-84e0-2fd87d5494f8@kernel.org>
Date: Sun, 31 May 2026 23:42:26 +1000
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 4/4] m68k: coldfire: fix non-standard readX()/writeX()
 functions
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-m68k@lists.linux-m68k.org,
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-can@vger.kernel.org, linux-spi@vger.kernel.org,
 Vladimir Oltean <olteanv@gmail.com>, Christoph Hellwig <hch@lst.de>
References: <20260506142644.3234270-2-gerg@kernel.org>
 <20260506142644.3234270-8-gerg@kernel.org>
 <40aefc39-bd98-460d-8aa7-5dd79f562e0d@app.fastmail.com>
 <fdd6fc14-f607-4186-8db4-25de973ac322@kernel.org>
 <CALSJ-wCrNDv3N2Kdo0uoXsKGtp0GthJRBeYTNQA1gGE2akUWFg@mail.gmail.com>
 <9391b782-7727-47fa-ac37-05cd50821d35@app.fastmail.com>
 <CALSJ-wBRmUpjz-_ehZ0U0Gu+fPqRUeAn47E0_pwpXQa0tCNzVA@mail.gmail.com>
 <CALSJ-wCuZs9cBJsuOOYMEYM6xOXZbdOm_pr=70d3HRYYSYJ0KA@mail.gmail.com>
 <CALSJ-wDm8NoB8mF3KSx49XMSWz1vjwFhSmgJZWq8pN2pCf12mw@mail.gmail.com>
 <CALSJ-wDY_8SMAvKT0L6wMbH1=w5pZNmV=xyeX1REb=BMRZWj-g@mail.gmail.com>
Content-Language: en-US
From: Greg Ungerer <gerg@kernel.org>
In-Reply-To: <CALSJ-wDY_8SMAvKT0L6wMbH1=w5pZNmV=xyeX1REb=BMRZWj-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux-m68k.org,vger.kernel.org,gmail.com,lst.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11073-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gerg@kernel.org,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux-m68k.org:email]
X-Rspamd-Queue-Id: 3CC75616668
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Angelo,

(Adding Christoph to CC list)

On 25/5/26 07:34, Angelo Dureghello wrote:
> On Sun, May 24, 2026 at 02:17:07PM -0700, Angelo Dureghello wrote:
>> Hi All,
>>
>> On Sun, May 17, 2026 at 03:41:31PM -0700, Angelo Dureghello wrote:
>>> Hi,
>>>
>>> On Sun, May 17, 2026 at 03:04:23PM -0700, Angelo Dureghello wrote:
>>>> Hi Arnd,
>>>>
>>>> On Sun, May 17, 2026 at 10:08:22PM +0200, Arnd Bergmann wrote:
>>>>> On Sun, May 17, 2026, at 21:43, Angelo Dureghello wrote:
>>>>>> On Thu, May 07, 2026 at 10:43:01PM +1000, Greg Ungerer wrote:
>>>>>>> On 7/5/26 05:12, Arnd Bergmann wrote:
>>>>>>>> On Wed, May 6, 2026, at 16:26, Greg Ungerer wrote:
>>>>>>
>>>>>> [    2.270000] fsl-dspi fsl-dspi.0: Not able to get desc for DMA xfer
>>>>>> [    2.280000] fsl-dspi fsl-dspi.0: DMA transfer failed
>>>>>> [    2.280000] spi_master spi0: failed to transfer one message from queue
>>>>>> [    2.290000] spi_master spi0: noqueue transfer failed
>>>>>> [    2.290000] spi-nor spi0.1: probe with driver spi-nor failed with error -5
>>>>>>
>>>
>>> About this issue, it fails on dma_pool_alloc(), so tomorrow will check,
>>> i probably lost some dma config option.
>>>
>>
>> so i worked on this open issue above:
>>
>> - moved to master and rebased,
>> - crated a wip/edma branch,
>> - bisected and found the offending commit, before this, mcf-edma driver
>>    and connected spi-fsl-dspi (using edma) was both working correctly.
>>
>> 7a360df941a4bd60847208de59f1ac8b166265a2 is the first bad commit
>> commit 7a360df941a4bd60847208de59f1ac8b166265a2 (HEAD)
>> Author: Christoph Hellwig <hch@lst.de>
>> Date:   Thu Oct 12 09:52:27 2023 +0200
>>
>>      m68k: don't provide arch_dma_alloc for nommu/coldfire
>>
>>      Coldfire cores configured with a data cache can't provide coherent
>>      DMA allocations at all.
>>
>>      Instead of returning non-coherent kernel memory in this case,
>>      return NULL and fail the allocation.
>>
>>      The only driver that used to rely on the previous behavior (fec) has
>>      been switched to use non-coherent allocations for this case recently.
>>
>>      Signed-off-by: Christoph Hellwig <hch@lst.de>
>>      Reviewed-by: Greg Ungerer <gerg@linux-m68k.org>
>>      Tested-by: Greg Ungerer <gerg@linux-m68k.org>
>>
>>   arch/m68k/Kconfig      |  1 -
>>   arch/m68k/kernel/dma.c | 23 -----------------------
>>   2 files changed, 24 deletions(-)
>>
>> So i can try next week a patch for edma looking what has been done
>> in fec, and since i am probably the only with mcf54415, will test it
>> here.
>>
> 
> Looking into this better, looks like the above commit was meant for the
> majority on non-mmu ColdFire. I think mcf5441x and some other with mmu
> enabled can flag pages as "page cache disabled".

I don't think that is right. The way the underlying data cache is setup for
MMU ColdFire (via the ACR/CACR registers) means that individual pages cannot
be marked as non-cached. So coherent memory allocations are not possible -
at least the way things are today.

It would be possible to set aside a chunk of RAM at kernel startup time
to use as a pool for coherent allocations (since it could be marked as
non-cached via the ACR/CACR registers), but there is no code to support doing
that today.

Regards
Greg


> So i would re-enabled that code only for such mmu families.
> 
> Please let me know if i am correct.
> Thanks.
> 
>>>>>> DSPI is using edma, i will try to understand where the issue is asap.
>>>>>>
>>>>>> About how it works:
>>>>>> - for accesses to edma module (IP) mmio registers, must be native
>>>>>> big_endian, so using the "be" suffix in "mcf"_edma looks ok for me.
>>>>>
>>>>> The twist here is that with the way that readl() is defined on
>>>>> coldfire as a non-swapping operation, and the generic
>>>>> definition assuming the opposite in
>>>>>
>>>>> static inline u32 ioread32be(const void __iomem *addr)
>>>>> {
>>>>>          return swab32(readl(addr));
>>>>> }
>>>>>
>>>>> the function called ioread32be() actually tries to access
>>>>> the registers as little-endian. I can see two possible ways
>>>>> we got here, but don't know which one is currect:
>>>>>
>>>>> a) the device actually has little-endian registers (like it
>>>>>     does on i.MX, but unlike all other coldfire devices), and
>>>>>     you just never noticed because using ioread32be() worked
>>>>>     as you expected.
>>>>>
>>>>> b) you tested the driver using an ioread32be() definition that
>>>>>     did not have a byteswap and it correctly accessed big-endian
>>>>>     registers at the time, but the version in mainline today does
>>>>>     not.
>>>>
>>>> Ok. The ioread32be now works properly since i had applied Greg patches.
>>>> I generated an error in _probe on edma channel 2, reading status reg.
>>>> looks consistent:
>>>>
>>>> 	iowrite16(2121, regs->erqh);
>>>> 	iowrite8(0x77, regs->serq);
>>>> 	iowrite8(0x12, regs->ssrt);
>>>> 	
>>>> 	u32 status = ioread32be(regs->es);
>>>> 	printk("%s() status: %04x\n", __func__, status);
>>>>
>>>> [    0.140000] mcf_edma_probe() entering
>>>> [    0.140000] mcf_edma_probe(): allocating data
>>>> [    0.140000] mcf_edma_probe() status: 800012f8
>>>>
>>>> If i am not loosing myself in this r/w labyrinth, the path should be:
>>>>
>>>> 1) Greg removed coldfire readl/writel, leaving now the standard LE r/w,
>>>> 2) So the ioread32be swaps the standard LE read giving BE.
>>>>
>>>> Am i correct ?
>>>>
>>>>
>>>>>
>>>>>> - for accessing the "tcd" memory structure, that must be, from what i
>>>>>> remember, anyway in little endian, independently from the cpu core
>>>>>> endiannes, this is the reason that big_endian flag is needed, it is
>>>>>> used for tcd area accesses, so the IP module was built.
>>>>>> The tcd area may be similar to pci accesses (see mcf54415 RM 19.4.16).
>>>>>
>>>>> edma_read_tcdreg() calls into edma_readl(), which is the same function
>>>>> that is used for normal register access, so from what I can tell,
>>>>> they always use the same endianess here.
>>>>>
>>>>
>>>> If edma_readl was using
>>>>
>>>>          if (edma->big_endian)
>>>>                  val = ioread32be(addr);
>>>>
>>>> and never changed, without Greg patch, it was likely returning little
>>>> endian for coldfire and correct LE for other arch ? :)
>>>>
>>>> I remember something about tcd area was coded LE, but will investigate
>>>> better, now i am over midnight.
>>>>
>>>> Regards,
>>>> angelo
>>>>
>>>>>        Arnd
>>>
>>> Regards,
>>> angelo
>>
>> Regards,
>> angelo
> 
> Regards,
> angelo


