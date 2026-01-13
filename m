Return-Path: <dmaengine+bounces-8241-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7EED1B7FA
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jan 2026 22:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 012D1303256F
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jan 2026 21:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A35A274B37;
	Tue, 13 Jan 2026 21:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="WA35RUZS"
X-Original-To: dmaengine@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AE631B808
	for <dmaengine@vger.kernel.org>; Tue, 13 Jan 2026 21:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768341510; cv=none; b=iLwnLJUOfDherJ9xtnNHHE1c0MjNCddFP3LK7IQab3ftxTSzcjbHK4xzD1l5Vsl98qGhPQ6drXk886+qw66+4kApFUq6BvGro5LUZk3h26eYlD6snA43xiDZiaHDzim2oW59Kzv4s2Y7g5dT2lBzDAbNiYY/XuOrvfldhr2HhkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768341510; c=relaxed/simple;
	bh=zehE3nwQ3Z4LyNacAnFl5NT7xOYmIRaiuqO0kLYFeNU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=t7pyBsJnvJ7a7oOLI38bmZ7kxarhYZhRI4dyN1rBS0d6AwBT1z01rxFlX8ZtOFh60yq2EHH+qMacJib+AzvSZ0npdsd7nh4EU5QNv8zPrF57LML2E7eR3be08ZXezaEgHQQtLxgJyTDHJYVjpjpXvZaeTZMFUtKREhcoFG1Wa6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=WA35RUZS; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=ha8TY8wBNd2qQq2CWlQu8OAiKSVy9jLNbsy/+li/kpE=; b=WA35RUZSsWZCFgHeT2wrk9BeHC
	xb2NsL7lZyhCugvq9mrgX1fPoAMUz8sa9mZ2TLXVXeZT3Isu8ssuoNB9c3tkzriGEwJYWaFAlDeYI
	nK3kxkz3uYL24+CALujpOLAJFYzU//1eOiaqNYU4CbOfeYA+Aspir2fExiiupvZkwCTkTulxjt2e4
	uLBJ1obxmCT/Kff49wNg3+TM6vRX0WMUWx3XL9vFZRaCsb2ILcv5o3CZox2a5xjLuH12gdArAjC2C
	Tizexj/5AOPhtNBXZdIzOF1SpKKFRwz2+xtcDNQ/Y/LG7v9DxcAYUYKvI4bBYQrTFRj8lDT8X8rSv
	cESp0Oyg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1vfmPD-00000000l6N-10Sg;
	Tue, 13 Jan 2026 14:58:27 -0700
Message-ID: <f0611171-1f26-47dc-b40c-f49105c4a864@deltatee.com>
Date: Tue, 13 Jan 2026 14:58:26 -0700
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
 <20260112184017.2601-4-logang@deltatee.com>
 <aWVhOZnWUhIBbI+I@lizhi-Precision-Tower-5810>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <aWVhOZnWUhIBbI+I@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: Frank.li@nxp.com, dmaengine@vger.kernel.org, vkoul@kernel.org, kelvin.cao@microchip.com, George.Ge@microchip.com, hch@infradead.org, christophe.jaillet@wanadoo.fr, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v12 3/3] dmaengine: switchtec-dma: Implement descriptor
 submission
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-01-12 14:01, Frank Li wrote:
> On Mon, Jan 12, 2026 at 11:40:17AM -0700, Logan Gunthorpe wrote:
>> +	desc->completed = false;
>> +	desc->hw->opc = SWITCHTEC_DMA_OPC_MEMCPY;
>> +	desc->hw->addr_lo = cpu_to_le32(lower_32_bits(dma_src));
>> +	desc->hw->addr_hi = cpu_to_le32(upper_32_bits(dma_src));
>> +	desc->hw->daddr_lo = cpu_to_le32(lower_32_bits(dma_dst));
>> +	desc->hw->daddr_hi = cpu_to_le32(upper_32_bits(dma_dst));
>> +	desc->hw->byte_cnt = cpu_to_le32(len);
>> +	desc->hw->tlp_setting = 0;
>> +	desc->hw->dfid = cpu_to_le16(dst_fid);
>> +	desc->hw->sfid = cpu_to_le16(src_fid);
>> +	swdma_chan->cid &= SWITCHTEC_SE_CID_MASK;
>> +	desc->hw->cid = cpu_to_le16(swdma_chan->cid++);
> 
> Any field indicate hw ready for DMA? what happen if DMA engine read it
> but sofware still have not update all data yet.

There's no field indicating it is ready with this hardware. The hardware
will only start reading from the queue when the head pointer is written
to the sq_tail register. The hardware will not read from any descriptors
before that occurs.

Logan


