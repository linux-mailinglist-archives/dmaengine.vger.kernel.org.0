Return-Path: <dmaengine+bounces-9306-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFdKAHkGq2kMZgEAu9opvQ
	(envelope-from <dmaengine+bounces-9306-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Mar 2026 17:53:13 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D87BD22581C
	for <lists+dmaengine@lfdr.de>; Fri, 06 Mar 2026 17:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C21E43013ED0
	for <lists+dmaengine@lfdr.de>; Fri,  6 Mar 2026 16:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C623D393DC0;
	Fri,  6 Mar 2026 16:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="IqXjRLoe"
X-Original-To: dmaengine@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7223336C0AA
	for <dmaengine@vger.kernel.org>; Fri,  6 Mar 2026 16:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772815989; cv=none; b=JJ1mHpMDPV3brFpBJjfOHsekDUj8rxZNEegleFAGozlhF3CAWsD1TIGLNh4UhZTEj+DpEf5oqNHPOS5AtvoKOryhbTLeHeDFTuMrWEYJJWSOnHY1VNFRdOOQhKwRS3X3LS+l/Oi2VfylVPNA1ew6P6F3uBvGBYwZX0VgJKWO2g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772815989; c=relaxed/simple;
	bh=gOFPOVXqdPkrEjEuW1Rcx1widNmcj4PNheF5WuxvuFo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=LF4FwSGUYg4Jw7DrQLnB8WpV2DhEa3PcmYWh4sv9+a0mbVoI5WFHP8yR1eV8Hv/oLWtgdx4SQpCSO5OXT0cKvXfDCYS6G/xS9bU8rjBdNTD0zkak5h2h5NqWLvw8chAqx+GgZLMm3UdRbQlm4p4JWYi7CmUw/FAV7l2M0U/iTyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=IqXjRLoe; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=6VEQC78tBMT7pMqo+ViBSxvXJoXfzUNFtfoWMNjAYFM=; b=IqXjRLoeN7Tbu1zMiv5JyipzPa
	lKpGSf+ZWWKaPu6Ncv95I6/AKJ1E8U6XU/dHZXSWsKG8cn/MFt4uN1YGWEkQCA1t/HdmxqALfeT3M
	+wFqy/SaotqAYOFUkLDzGTCr7D+OfmKssoFBheQfuzER0ZJj/2V/XpomEICF1fvO9UDm+YJUjn68f
	xnd8NHRQ1c1JmZunhX+oSiXjKkmoR46azgYO/hN3yUw7nFCGCQvNlCCjk+Kev4228AJneR/ljL7al
	cyhEN7RaFqLcSAuJqPFW0qMQd/Zn39KJKlK2lDoBPKu3/282+rOuT5ntc6kqbB6w+OH931a7fAUtC
	nnY89nnQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1vyYQ9-000000089Ej-0pI6;
	Fri, 06 Mar 2026 09:53:01 -0700
Message-ID: <da2dd099-0851-478c-8ace-0cd78e5b4550@deltatee.com>
Date: Fri, 6 Mar 2026 09:52:35 -0700
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
References: <20260302210419.3656-1-logang@deltatee.com>
 <20260302210419.3656-4-logang@deltatee.com>
 <aaheutOqxlP50v0U@lizhi-Precision-Tower-5810>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <aaheutOqxlP50v0U@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: Frank.li@nxp.com, dmaengine@vger.kernel.org, vkoul@kernel.org, kelvin.cao@microchip.com, George.Ge@microchip.com, hch@infradead.org, christophe.jaillet@wanadoo.fr, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v14 3/3] dmaengine: switchtec-dma: Implement descriptor
 submission
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-Rspamd-Queue-Id: D87BD22581C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[deltatee.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[deltatee.com:s=20200525];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,microchip.com,infradead.org,wanadoo.fr,lst.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9306-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[deltatee.com:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.970];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[logang@deltatee.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 2026-03-04 09:32, Frank Li wrote:
> On Mon, Mar 02, 2026 at 02:04:19PM -0700, Logan Gunthorpe wrote:
>> +static struct dma_async_tx_descriptor *
>> +switchtec_dma_prep_desc(struct dma_chan *c, u16 dst_fid, dma_addr_t dma_dst,
>> +			u16 src_fid, dma_addr_t dma_src, u64 data,
>> +			size_t len, unsigned long flags)
>> +	__acquires(swdma_chan->submit_lock)
>> +{
>> +	struct switchtec_dma_chan *swdma_chan =
>> +		container_of(c, struct switchtec_dma_chan, dma_chan);
>> +	struct switchtec_dma_desc *desc;
>> +	int head, tail;
>> +
>> +	spin_lock_bh(&swdma_chan->submit_lock);
> 
> Actually this try to force prep_desc() and submit() call sequence.
> 
> 1 tx1 = prep_desc()
> 2 tx2 = prep_desc()
> 
> submit(tx1)
> submit(tx2)
> 
> It will wait at 2.
> 
> Most dma consumer is that prep_desc() then submit(). If mantainer vnod think
> it is okay, I am fine.  But I thinks

Yeah, dma engine is commonly used this way. Multiple drivers already
take a lock in prep() and release it in submit(). This is required for
drivers that are filling a hardware queue and then informing hardware
the descriptor is ready on submit. Another thread cannot also add to the
hardware queue if there's something waiting to be submitted.

It's wrong for consumers of the API to call prep twice before calling
submit. If two threads are submitting there is no deadlock seeing
there's only one lock.

Logan

