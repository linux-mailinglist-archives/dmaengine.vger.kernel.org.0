Return-Path: <dmaengine+bounces-8649-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODscG/upf2n6vQIAu9opvQ
	(envelope-from <dmaengine+bounces-8649-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 01 Feb 2026 20:31:07 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67187C7139
	for <lists+dmaengine@lfdr.de>; Sun, 01 Feb 2026 20:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BDC8E3001382
	for <lists+dmaengine@lfdr.de>; Sun,  1 Feb 2026 19:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EF6283CB1;
	Sun,  1 Feb 2026 19:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhCIKTRM"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4261ACED5;
	Sun,  1 Feb 2026 19:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769974262; cv=none; b=tFrdDzuNc+DvvWgafsE4Smp6Fr0neV165ZCR/YJSm6OgSfuywjPuHj5jo8JjmcmiknwJsoJk2S00Xz+Foz2Lt7/20B5BW/2KR55ex2O0cPfGQNT5L3oHnXZS2+Idg7nbLhqthlq3Sle1LMTt0qPKeOah2q+nrWsoOrxwj32t5Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769974262; c=relaxed/simple;
	bh=/urQmFdCDUf+tZGDThKL0m9msVTzm4Zp2SVbKmDZ/70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPvx+qgB7UpmbQaUoteubWvr7LoKgpSWLSS55/EfMqDri3wMEeQR0Tnhya2UOqhHcfhXR83upZ0yGsW6hTElfXXrzUJrTmGrp9GcNwb5XKdEzAOKvmkpVTw/D4g9OuyZbEG3pDxrt1iw7KjOecl9Z0No0LYj8LpplnhPkOP2zFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhCIKTRM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C0CC4CEF7;
	Sun,  1 Feb 2026 19:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769974261;
	bh=/urQmFdCDUf+tZGDThKL0m9msVTzm4Zp2SVbKmDZ/70=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LhCIKTRM9HBanieN4TkDbSqAbvoHXkeASeqD3PzplZx9e9mer1VU7azEU7Dw2TAbg
	 krF3idhabE1Hmeb2R1isNtxMID6tx+1zQVFYIaJeywxsK0QtFfFu9VfmsafI6Iul4w
	 OISo5U7BVcjbjvX0622By7cwUi8FI7CDks/rW4yhqEMaOPdR2SvTLDkw9xYWvrz0BP
	 BFCvJIhGvHERwiGT60lxizGoVF19GJARZqx1oqsrcTpJUskdKNSnH2HVvbQx/TTFuF
	 hX0NWFwBbrBfT/yqSrY73awns4j265d5xf2M0cQ111NWprzHqrCS90z8RLu8OfYunN
	 6D4xepmi5ZjJg==
Message-ID: <f5183a72-6ea4-4d68-b136-f6d83a36493d@kernel.org>
Date: Sun, 1 Feb 2026 13:30:59 -0600
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: dma: snps,dw-axi-dmac: add dma-coherent
 property
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: Eugeniy.Paltsev@synopsys.com, vkoul@kernel.org,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
 Rob Herring <robh@kernel.org>
References: <20260131172856.29227-1-dinguyen@kernel.org>
 <20260131-subtly-education-e13320fe0486@spud>
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20260131-subtly-education-e13320fe0486@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8649-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dinguyen@kernel.org,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[altera.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 67187C7139
X-Rspamd-Action: no action



On 1/31/26 14:27, Conor Dooley wrote:
> On Sat, Jan 31, 2026 at 11:28:56AM -0600, Dinh Nguyen wrote:
>> From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
>>
>> The Synopsys DesignWare AXI DMA Controller on Agilex5, the controller
>> operates on a cache-coherent AXI interface, where DMA transactions are
>> automatically kept coherent with the CPU caches. In previous generations
>> SoC (Stratix10 and Agilex) the interconnect was non-coherent, hence there
>> is no need for dma-coherent property to be presence. In Agilex 5, the
>> architecture has changed. It  introduced a coherent interconnect that
>> supports cache-coherent DMA.
>>
>> Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> 
> Why does this v1 have an ack?
> 

I respun this patch based on the dmaengine tree so that the dma engine 
maintainer can take it. I had originally applied it to my tree, but 
avoid potential merge conflicts, I'm going to submit it through dma. 
This patch is the same as this[1].

Sorry for any confusion.

Dinh
[1] 
https://lore.kernel.org/linux-devicetree/176488420978.2206697.11201292177123636920.robh@kernel.org/

