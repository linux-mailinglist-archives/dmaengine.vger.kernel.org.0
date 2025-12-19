Return-Path: <dmaengine+bounces-7845-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8B1CD11E6
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 18:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C4B53016998
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 17:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D97E29B76F;
	Fri, 19 Dec 2025 17:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="FDQC4EoF"
X-Original-To: dmaengine@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94609285419
	for <dmaengine@vger.kernel.org>; Fri, 19 Dec 2025 17:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766164819; cv=none; b=aAJUwVgRAXsqsWcjo/2pyqP9BoHb12U21EF4vWQQB+EjPQgWPpBEnDjpfSbmP+1V+ZQ18Hb40fDOHVzH2MKk8qXCQ+NChNGdh4SNMiWSO00OHgb5CmNDcyzNyggirDp8YqnOIuxo8GebiVxAUJIW36qBUQhUVjKOYdr7DMwUxyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766164819; c=relaxed/simple;
	bh=5zx+LDrMr8OYC2fwE1pVlgJqAinTL+E3O3To3WRP/wE=;
	h=Message-ID:Date:MIME-Version:From:To:References:Cc:In-Reply-To:
	 Content-Type:Subject; b=XRQtJlP1A+OVdJK6UCoFxZ+Fc/jgkepksgafS+JWvCO8NibagyXcpTiqlb/YNOGfXCIu839MnPp2l5izMGTneI7FAvznZJEj31WXBL+8shGePRbR4/xC+ycQkmd9FY1QG2NbUbFJXjhse0IhHIo8ARdCBomtwm+pfJ5XbId0ams=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=FDQC4EoF; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:Cc:References:To:From:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=SnFXXi5PI7sP3ZagZT0h+bKaY51KSH3It3I1CSWJ6A4=; b=FDQC4EoFmDEHTA/2VQvoxfUoLY
	58YYlihjvgEBjzPUrIzO633mqG1MZmhmMKO1CKvjK5uYmcSXg6P0XuHDsRAcRRfbSCCt87kOm40Sp
	qbKC3SF0wP3w0LSaad5HTFh3+LJS4/l6LuoQwX+VgBKX3xpROKcaCZHb0oLgcdrs1/oGYkkGDKilw
	dvS2h3AvA7UeXMWlIfDeqi2oOoMXYGYoh8p0jOATCeG/xKM0hrNBmfNpa3PdWLL4vH9JmszF7CdaT
	SVQGiUup13H8S6/cFVD7R707b3vkA6qoZ/Fhd89qfLQ78icEmubdf0ged88j2k5TQxsVt3cxK6uCe
	XvScOZEQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1vWe9B-00000006Cg8-3g5o;
	Fri, 19 Dec 2025 10:20:11 -0700
Message-ID: <eeda026b-bfe1-42ba-a062-ca90b5f03ee6@deltatee.com>
Date: Fri, 19 Dec 2025 10:19:55 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Logan Gunthorpe <logang@deltatee.com>
To: Vinod Koul <vkoul@kernel.org>
References: <20251215181649.2605-1-logang@deltatee.com>
 <20251215181649.2605-3-logang@deltatee.com> <aUE7zahyYgsls-Ic@vaman>
Content-Language: en-CA
Cc: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 Kelvin Cao <kelvin.cao@microchip.com>, George Ge <George.Ge@microchip.com>,
 Christoph Hellwig <hch@infradead.org>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Christoph Hellwig <hch@lst.de>
In-Reply-To: <aUE7zahyYgsls-Ic@vaman>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: vkoul@kernel.org, dmaengine@vger.kernel.org, kelvin.cao@microchip.com, George.Ge@microchip.com, hch@infradead.org, christophe.jaillet@wanadoo.fr, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v11 2/3] dmaengine: switchtec-dma: Implement hardware
 initialization and cleanup
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

Hi Vinod,

Thanks for reviewing this. I've queued up a bunch of changes based on
your feedback, but I have some questions and notes.

On 2025-12-16 04:00, Vinod Koul wrote:
>> +	struct switchtec_dma_desc **desc_ring;
> 
> This is bit interesting. Any reason why you choose double pointer here.
> If you take a look at other driver, they follow similar approach but
> dont use double pointer for this.
> 

The ring size has had to be quite large. It is currently set to 32K in
order to be able to get maximum performance in some work loads. While
each element is only 104 bytes, the total array is more than 3MB which
is too much for a single allocation. The PLX dma driver this is based on
does the same thing even though it's queue size is only 2048.
>> +		if (swdma_chan->cq_tail == 0)
>> +			swdma_chan->phase_tag = !swdma_chan->phase_tag;
>> +
>> +		/*  Out of order CE */
>> +		if (se_idx != tail) {
>> +			spin_unlock_bh(&swdma_chan->complete_lock);
>> +			continue;
>> +		}
>> +
>> +		do {
>> +			dma_cookie_complete(&desc->txd);
>> +			dma_descriptor_unmap(&desc->txd);
>> +			dmaengine_desc_get_callback_invoke(&desc->txd, &res);
>> +			desc->txd.callback = NULL;
>> +			desc->txd.callback_result = NULL;
> 
> Not filling results?

I'm not sure the question here. This code calls the callback with the
result and then clears the callback for the next use of the descriptor.

>> +			desc->completed = false;
> 
> ?
> 

The completed flag is used to track which requests in the ring have been
completed. It is set to true when it's completed and then cleared here
when they have been cleaned up again for reuse in a subsequent
transaction. The completions can happen out of order but they are
cleaned up in order before they can be reused.
>> @@ -127,9 +1140,13 @@ static void switchtec_dma_remove(struct pci_dev *pdev)
>>  {
>>  	struct switchtec_dma_dev *swdma_dev = pci_get_drvdata(pdev);
>>  
>> +	switchtec_dma_chans_release(pdev, swdma_dev);
>> +
>>  	rcu_assign_pointer(swdma_dev->pdev, NULL);
>>  	synchronize_rcu();
>>  
>> +	pci_free_irq(pdev, swdma_dev->chan_status_irq, swdma_dev);
>> +
> 
> This is good. But what about the tasklet, that needs to be quiesced too
> 

I'm not sure what you are looking for, I couldn't find any explicit
quiesce function that is commonly used on teardown in other drivers.
Clearing the pdev pointer above and synchronizing the RCU should ensure
there are no other jobs in progress or tasklets running.

Note: I have tested teardown while running dmatest and have not found
any issues.

Logan

