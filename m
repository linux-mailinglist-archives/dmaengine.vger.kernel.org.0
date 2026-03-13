Return-Path: <dmaengine+bounces-9426-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFzoLlArtGkQiQAAu9opvQ
	(envelope-from <dmaengine+bounces-9426-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 13 Mar 2026 16:20:48 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C18285D1F
	for <lists+dmaengine@lfdr.de>; Fri, 13 Mar 2026 16:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82275306EE09
	for <lists+dmaengine@lfdr.de>; Fri, 13 Mar 2026 15:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53ADE38F651;
	Fri, 13 Mar 2026 15:16:59 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005C036BCEB;
	Fri, 13 Mar 2026 15:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773415019; cv=none; b=MCaynpOp5JJcFa6B+CAleNA92LaNoyQ0EKGm71cSv9qwpART9S5CQ5paozFVPFimQRIojaBr/t7JqtH5VFbFkwsHe1ZhFJznPO39kpdBbpfskdnV9iUPXEVkYyrtQtE/Cmt/epAwswlwhlvSBgf/mgQxvXwSPrqMmzGcjavsjNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773415019; c=relaxed/simple;
	bh=rWUAFdCY1qSF25VmcrlVfATp53b/4xR4POxQnrPcejM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kMJYCggIkoq5LSvRAsLfFOKYN6dr3L4kqDIdi1jZFklzuVxQIzWchHuiZBSR9n9/UOHZQQ+f3vgWA0Sv1RHWEO/JsIK9EZKAFmq+4vc7AswJHX+FmeCvhoxfCBMbjTxnd7xllOMaU+UkFziKbdbJGaSKPA0b0tJJF0r/pNArZRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30BC0165C;
	Fri, 13 Mar 2026 08:16:50 -0700 (PDT)
Received: from [10.57.59.200] (unknown [10.57.59.200])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 064863F73B;
	Fri, 13 Mar 2026 08:16:53 -0700 (PDT)
Message-ID: <ab632240-f4eb-4bcc-8170-2a9a024c1ce7@arm.com>
Date: Fri, 13 Mar 2026 15:16:50 +0000
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dmaengine: Add multi-buffer support in single DMA
 transfer
To: Sumit Kumar <sumit.kumar@oss.qualcomm.com>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Veerabhadrarao Badiganti <veerabhadrarao.badiganti@oss.qualcomm.com>,
 Subramanian Ananthanarayanan
 <subramanian.ananthanarayanan@oss.qualcomm.com>,
 Akhil Vinod <akhil.vinod@oss.qualcomm.com>,
 Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-pci@vger.kernel.org, mhi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org
References: <20260313-dma_multi_sg-v1-0-8fabb0d1a759@oss.qualcomm.com>
 <20260313-dma_multi_sg-v1-1-8fabb0d1a759@oss.qualcomm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260313-dma_multi_sg-v1-1-8fabb0d1a759@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9426-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robin.murphy@arm.com,dmaengine@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.947];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 69C18285D1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-13 6:49 am, Sumit Kumar wrote:
> Add dmaengine_prep_batch_sg API for batching multiple independent buffers
> in a single DMA transaction. Each scatter-gather entry specifies both
> source and destination addresses. This allows multiple non-contiguous
> memory regions to be transferred in a single DMA transaction instead of
> separate operations, significantly reducing submission overhead and
> interrupt overhead.
> 
> Extends struct scatterlist with optional dma_dst_address field
> and implements support in dw-edma driver.

[...]
> diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
> index 29f6ceb98d74b118d08b6a3d4eb7f62dcde0495d..20b65ffcd5e2a65ec5026a29344caf6baa09700b 100644
> --- a/include/linux/scatterlist.h
> +++ b/include/linux/scatterlist.h
> @@ -19,6 +19,9 @@ struct scatterlist {
>   #ifdef CONFIG_NEED_SG_DMA_FLAGS
>   	unsigned int    dma_flags;
>   #endif
> +#ifdef CONFIG_NEED_SG_DMA_DST_ADDR
> +	dma_addr_t	dma_dst_address;
> +#endif

Eww, no, what does this even mean? Is the regular dma_addr somehow 
implicitly a "source" now? How could the single piece of memory 
represented by page_link/offset/length have two different DMA addresses? 
How are both the DMA mapping code and users supposed to know which one 
is relevant in any particular situation?

If you want to bring back DMA_MEMCPY_SG yet again, and you have an 
actual user this time, then do that (although by now it most likely 
wants to be a dma_vec version). Don't do whatever this is...

If you want to batch multiple 
dmaengine_slave_config()/dma_prep_slave_single() operations into some 
many-to-many variant of dmaengine_prep_peripheral_dma_vec(), then surely 
that requires actual batching of the config part as well - e.g. passing 
an explicit vector of distinct dma_slave_configs corresponding to each 
individual dma_vec - in order to be able to work correctly in general?

Thanks,
Robin.

>   };
>   
>   /*
> @@ -36,6 +39,10 @@ struct scatterlist {
>   #define sg_dma_len(sg)		((sg)->length)
>   #endif
>   
> +#ifdef CONFIG_NEED_SG_DMA_DST_ADDR
> +#define sg_dma_dst_address(sg)	((sg)->dma_dst_address)
> +#endif
> +
>   struct sg_table {
>   	struct scatterlist *sgl;	/* the list */
>   	unsigned int nents;		/* number of mapped entries */
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index 31cfdb6b4bc3e33c239111955d97b3ec160baafa..3539b5b1efe27be7ccbfebb358dbb9cad2868f11 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -32,6 +32,9 @@ config NEED_SG_DMA_LENGTH
>   config NEED_DMA_MAP_STATE
>   	bool
>   
> +config NEED_SG_DMA_DST_ADDR
> +	bool
> +
>   config ARCH_DMA_ADDR_T_64BIT
>   	def_bool 64BIT || PHYS_ADDR_T_64BIT
>   
> 


