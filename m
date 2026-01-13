Return-Path: <dmaengine+bounces-8240-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E4CD1B7A6
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jan 2026 22:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1F5F30321FF
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jan 2026 21:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255912FD689;
	Tue, 13 Jan 2026 21:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="L+DlIAHy"
X-Original-To: dmaengine@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E462A1B3925
	for <dmaengine@vger.kernel.org>; Tue, 13 Jan 2026 21:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768341061; cv=none; b=FCLnhthuYywYwxHeQj03gFggbczbhFt3DH2M9TQo4zs2/ORWMiMPolANCpmqfkx+uix2UNl6FLuRj0ufUhNRaIctoq4ccp/3JAWx42s0GiuzbZ8NWBCLwrAgn3CPoZSSbmyiuYuxdVQAlL3Xie9/5u6hEoQ0zw1iz/MrI98sthg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768341061; c=relaxed/simple;
	bh=bZ5yPXKgVjQL3w5OjF647g3SN5anFDCMGIi5g2VPqfc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=OpVIsz83n7yeYSx/908a8LS3AdEfAtxEfM48Zuajh5Cf4mfoxRWW3p4ZUJcnkWk1d9+Yis2nPU2bLaM5gO9EEt4SkJNdzmPBeBpWddzQBifnJ59u+6cdkyIGd/9ITmwVmqokJuVoys6dnpA0bYN9uaETPDpGAOr5kQl87SbckMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=L+DlIAHy; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=jpciuWWgd4qqhrU9xUV5knCs4vuCtXSAiI7pDrD9U2k=; b=L+DlIAHyRAvOkEV2GsbSCMG+WI
	NLYxjaKUorHfmrLnZ3gSStEzGpSjtBGw5OAHlxBRLaCWqnPKahDdqdBu2lXLjxOcN42UEWBIc0ryS
	S8avbZqRrbau0GS/4JQ4y9uTrq+TM/9MsqXmI65dINQ3zMmt7P5haXxILLTf++hzd3lJpNF7vO3e3
	9ZYqqyAKCW5ypTgS2eREfWBksVvmOGIGfCTX9l2pPkBecf8wzuVZKgj+oGbco1cl7SwFDDrfgjI4d
	frkUkgPzs+96pbsQ61T0QP3fyfsLGgX05ZgSXZs7lrQbnMsyh/k4+mAcrQX/QOx/RWcP8RMyFjo+s
	prOUWTIA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1vfmHy-00000000l4K-2a2Y;
	Tue, 13 Jan 2026 14:50:59 -0700
Message-ID: <c6735012-041c-4b4b-a3fc-0fdf466af4e5@deltatee.com>
Date: Tue, 13 Jan 2026 14:50:54 -0700
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
 <aWVX4bltwS8I7oos@lizhi-Precision-Tower-5810>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <aWVX4bltwS8I7oos@lizhi-Precision-Tower-5810>
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



On 2026-01-12 13:21, Frank Li wrote:
> On Mon, Jan 12, 2026 at 11:40:17AM -0700, Logan Gunthorpe wrote:
>> +static void switchtec_dma_issue_pending(struct dma_chan *chan)
>> +{
>> +	struct switchtec_dma_chan *swdma_chan =
>> +		container_of(chan, struct switchtec_dma_chan, dma_chan);
>> +	struct switchtec_dma_dev *swdma_dev = swdma_chan->swdma_dev;
>> +
>> +	/*
>> +	 * Ensure the desc updates are visible before starting the
>> +	 * DMA engine.
>> +	 */
>> +	wmb();
> 
> Are you sure need wmb() here?  suppose writew() already include dma_wmb().

Yes, I believe you are correct. Though, I'm honestly not 100% sure about
it. We'll remove the call and try to test it as best as possible.

Thanks,

Logan

