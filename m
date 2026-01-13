Return-Path: <dmaengine+bounces-8243-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6059D1B964
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jan 2026 23:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 69055300DD94
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jan 2026 22:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E05352F86;
	Tue, 13 Jan 2026 22:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="XovDrF4u"
X-Original-To: dmaengine@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D062FCC0E
	for <dmaengine@vger.kernel.org>; Tue, 13 Jan 2026 22:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768343262; cv=none; b=UMoIx2d1UITPJOoQ6qz4lOI0LakMRHEOpyit0YN/AS0QNK2uKR2lPjH8/Bp+PYwAOMGZsPF+CcXZX0j2D8b0FzfnV2SwT4zTH0C5m9gD9fVKopf2xBgSvdknQ1LkZGxxz2O6rGuf0DtU5YGDhHAX1mG07WrIEuLLDDuSMFjGZvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768343262; c=relaxed/simple;
	bh=cA1PH8mnGwdaDv7rbK8KuZgtgiYJdmU+DQzkfYYQxzU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=kdY+jdkWD9CM8JbRSWJyu8HVwecU4jeKMhUhy9iwqPy4NHyFjlV/ggMKa8itp+72McRElGtQ8SIx/xzpImyL2NqFETSe8po+0TdOxeJSIyCPsulqb/VsPm1b9OI9t+1VQO/qjQL0899rf5awGlbNWkxW3/euQr0SqvVuMg5bCJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=XovDrF4u; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=soijWLwxzvdp610iCugN8AbLLyggDKtHD0IksM92Jng=; b=XovDrF4uSHDSnfTElYn/mTD+7Q
	d/K9CPpYj/WY3+n8XHPiHVs9LHHP+IylSM1geZisL1EA+MywFP6BdnrQhxCRzm0p3o6nst4z5t/S6
	GeDMi+/DXkJb35LH/yKo80t6t4rM9SruqZbaD9NZcVibQvl8WIKVCyQgDSWTyO5gtHi/JndmiJT1F
	6OwpEp//W+rm8M/peHWRdw5a8dJ3jjAyEjy2osFzbsacT8hLmDfdy7Zj6Xx3H4FD7f9TIfH/4zuvE
	g+GACix+MfY0xpb1JDXVpjXqRfK6rJV1yR74BGFSJkfhQ5kG46Er1yi9IcNUJ1AGbxVq6S5U5Zn3Z
	nkbIuToA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1vfmrT-00000000lYa-3Ds7;
	Tue, 13 Jan 2026 15:27:40 -0700
Message-ID: <abfe2255-722f-409a-920f-0af179b8293b@deltatee.com>
Date: Tue, 13 Jan 2026 15:27:21 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Frank Li <Frank.li@nxp.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 Kelvin Cao <kelvin.cao@microchip.com>, George Ge <George.Ge@microchip.com>,
 Christoph Hellwig <hch@infradead.org>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Christoph Hellwig <hch@lst.de>
References: <20260112184017.2601-1-logang@deltatee.com>
 <20260112184017.2601-3-logang@deltatee.com>
 <aWVjesSxFp1STEhV@lizhi-Precision-Tower-5810>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <aWVjesSxFp1STEhV@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: Frank.li@nxp.com, dmaengine@vger.kernel.org, vkoul@kernel.org, kelvin.cao@microchip.com, George.Ge@microchip.com, hch@infradead.org, christophe.jaillet@wanadoo.fr, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v12 2/3] dmaengine: switchtec-dma: Implement hardware
 initialization and cleanup
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-01-12 14:11, Frank Li wrote:
> On Mon, Jan 12, 2026 at 11:40:16AM -0700, Logan Gunthorpe wrote:
>> +
>> +	/* the head and tail for both desc_ring and hw_sq */
>> +	int head;
>> +	int tail;
>> +	int phase_tag;
>> +	struct switchtec_dma_hw_se_desc *hw_sq;
>> +	dma_addr_t dma_addr_sq;
> 
> Looks like it is cycle HW descriptors. I found most DMA engine use two
> model, one is link list and other is use cycle buffer. Is possible to
> create common logic for it, so each dma driver just implement hardware
> related part.
> 
> https://lore.kernel.org/imx/aWTyGpGN6WqtVCfN@ryzen/T/#t
> 
> which just abstract eDMA and HDMA, we may extend to more hardware, reduce
> duplicate code.
> 
> There are some race condition need be confided. we needn't dupicate efforts
> to debug these race condition for every hardware.

I'm not following. eDMA at least appears to use vchan and I have pointed
out repeatedly that the vchan layer isn't appropriate for this driver
(or the other PCI based drivers: ioat and plx_dma).

The PCI dma engine drivers all have their own hardware specific queues
that are written to directly on a prep call. All three drivers that do
this are doing entirely hardware specific logic to program the dma
engine in these calls and I don't see how any of it could be combined to
improve the code. Using vchan just means wasting cpu cycles pushing to a
software queue before going to the hardware queue. We'd much rather
write directly into the hardware queue when prepping a job.

>> +struct switchtec_dma_hw_se_desc {
>> +	u8 opc;
>> +	u8 ctrl;
>> +	__le16 tlp_setting;
>> +	__le16 rsvd1;
>> +	__le16 cid;
>> +	__le32 byte_cnt;
>> +	__le32 addr_lo; /* SADDR_LO/WIADDR_LO */
>> +	__le32 addr_hi; /* SADDR_HI/WIADDR_HI */
>> +	__le32 daddr_lo;
>> +	__le32 daddr_hi;
>> +	__le16 dfid;
>> +	__le16 sfid;
>> +};
> 
> suppose need pack(1) and others, which need exactlly match hardware.

The fields in this structure are correctly aligned. There is no need for
marking the structure as packed and that can have a undesirable
performance impact:

"However, again, the compiler is aware of the alignment constraints and
will generate extra instructions to perform the memory access in a way
that does not cause unaligned access. Of course, the extra instructions
obviously cause a loss in performance compared to the non-packed case,
so the packed attribute should only be used when avoiding structure
padding is of importance."[1]

This structure requires no padding and there's no need to avoid padding
with the packed attribute.

Logan

[1] https://docs.kernel.org/core-api/unaligned-memory-access.html




