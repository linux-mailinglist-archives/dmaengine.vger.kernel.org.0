Return-Path: <dmaengine+bounces-5956-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E76B1BAC9
	for <lists+dmaengine@lfdr.de>; Tue,  5 Aug 2025 21:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E46A1715DB
	for <lists+dmaengine@lfdr.de>; Tue,  5 Aug 2025 19:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DC91AA782;
	Tue,  5 Aug 2025 19:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="MeoYNlOS"
X-Original-To: dmaengine@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F7619D8A3;
	Tue,  5 Aug 2025 19:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754421367; cv=none; b=h24W1ehb6Tkeal+n0FFBablsVU3t8MbjRPTa5LEMOzoA5EnciheHnyeA45+Xug87ZwOqvCugvnYQJk+1i7d72Ao+ml2NK743wy/inUH82orUrBHXxN5VnKBibEj5Bd/V9NJrlc4UGzem8twg+UcwMxD+ZfxmX+op6wKSGrHaWhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754421367; c=relaxed/simple;
	bh=xwia6OeO/4JQtFLmVJFoJpMuJjIy67jNZoj+VZ7nIuA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=npQhUkn20KDRQRXUXyBf3zh/FoUGEk8LDAP9HVDdTFCUkNitmFZ5pEgOOgIxWPyDXzKbuBoWBE3hg3sunvYWvqmFW/hz6wJ4o2xp5Z+q09f45t8BklpQoDoJN38OkAcfpcB6hZA6TFfS7vdrw1FVOEAknpryS4+uWBmQi+5OOUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=MeoYNlOS; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=YWPES1V9Guwwt2NDiElX+KymgJ4GZIsqtRK0GbibDM4=; b=MeoYNlOSX1alFso17GO0h7IPGi
	ZiAF1HBEnwYokESiPiwxVSBCN48XZIHtDDxS5EEf5Pl6IkBXTDhwhcY+VoA0qDatPWo5eHG2N0uU2
	o9OxbynWrY0NQZe2jNFiDQ+BiH8HnNGXc1SJDTBZ+l0xanCpZopVcl5uUiXHbilvruxddlPYuN7sB
	M+A2BKfGJvis+q6cp0XFsiRIPx9Wz8EnJlXbimNjaGWqfvNVMdKGa39UtimsA4337+CSmw96tYzkk
	B+YbPqZPEExWr+hbf+0SFRPsd4KoIua4r3kOyVlxiRGoHvTNsbVzfhBT3somwkcgCgox+CApBO81p
	T8gfGuiA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <logang@deltatee.com>)
	id 1ujN8c-00EVl7-0x;
	Tue, 05 Aug 2025 13:15:56 -0600
Message-ID: <3baed5bf-8fa1-4ef9-8cb1-58145a6dd37c@deltatee.com>
Date: Tue, 5 Aug 2025 13:15:34 -0600
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Vinod Koul <vkoul@kernel.org>, Kelvin Cao <kelvin.cao@microchip.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 George.Ge@microchip.com, christophe.jaillet@wanadoo.fr, hch@infradead.org
References: <20240318163313.236948-1-kelvin.cao@microchip.com>
 <20240318163313.236948-2-kelvin.cao@microchip.com> <ZhKPsKFyaXFliJP4@matsya>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <ZhKPsKFyaXFliJP4@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: vkoul@kernel.org, kelvin.cao@microchip.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, George.Ge@microchip.com, christophe.jaillet@wanadoo.fr, hch@infradead.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v8 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

Hi Vinod,

Kelvin has asked me to take over the upstreaming of the switchtec_dma
driver. It's been over a year since the last posting but we intend on
sending a new version shortly after the merge window. I've fixed a
number of issues and gone through the bulk of the changes requested but
there are two points that I'm going to have to push back on.

This driver shares a lot of similarities with the plx_dma driver I wrote
a few years ago and had similar issues.

On 2024-04-07 06:21, Vinod Koul wrote:
> On 18-03-24, 09:33, Kelvin Cao wrote:
>> +static dma_cookie_t
>> +switchtec_dma_tx_submit(struct dma_async_tx_descriptor *desc)
>> +	__releases(swdma_chan->submit_lock)
>> +{
>> +	struct switchtec_dma_chan *swdma_chan =
>> +		to_switchtec_dma_chan(desc->chan);
>> +	dma_cookie_t cookie;
>> +
>> +	cookie = dma_cookie_assign(desc);
>> +
>> +	spin_unlock_bh(&swdma_chan->submit_lock);
> 
> I was expecting desc to be pushing to pending list?? where is that done

The driver maintains a pending list in DMA coherent memory. The pending
list is written directly in switchtec_dma_prep_desc(). So there's
nothing the hardware needs done when a new operation is submitted to the
queue. When switchtec_dma_issue_pending() is called, the sq_tail pointer
is updated which will signal the hardware to start pulling all the
queued requests. I don't see any other way this could be done in the
dmaengine framework.

> Also consider using virt-dma for desc management, you dont need to
> handle that on your own

I looked into this and a virtual queue does not make sense to me for
this device. The driver maintains it's own queue that hardware reads
directly so there would be no benefit in having another queue that then
needs to be copied to the queue the hardware reads from.

>> +static enum dma_status switchtec_dma_tx_status(struct dma_chan *chan,
>> +					       dma_cookie_t cookie,
>> +					       struct dma_tx_state *txstate)
>> +{
>> +	struct switchtec_dma_chan *swdma_chan = to_switchtec_dma_chan(chan);
>> +	enum dma_status ret;
>> +
>> +	ret = dma_cookie_status(chan, cookie, txstate);
>> +	if (ret == DMA_COMPLETE)
>> +		return ret;
>> +
>> +	switchtec_dma_process_desc(swdma_chan);
> 
> This is *wrong*, you cannot process desc in status API, Please read the
> documentation again and if in doubt pls ask

I don't see any other way to do this. There's no other place to cleanup
the completed descriptors. This is exactly what was done in the plx-dma
driver which copied the IOAT driver that began this pattern. There was
very similar feedback when I submitted the plx-dma driver[1] and I
pointed out there's no other way to do this.

I'll rename the function to make this a little clearer, but I can't see
any other way to implement the driver without doing this.

Thanks,

Logan

[1]
https://lore.kernel.org/all/746371aa-b3f6-aaca-35f2-0f815294dc71@deltatee.com/




