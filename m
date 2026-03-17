Return-Path: <dmaengine+bounces-9466-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKutNdIyuWnsuQEAu9opvQ
	(envelope-from <dmaengine+bounces-9466-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 11:54:10 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCF22A84D7
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 11:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1A7A3048EF6
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 10:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D25372ED8;
	Tue, 17 Mar 2026 10:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIRi4GRD"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F103036F409;
	Tue, 17 Mar 2026 10:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773744845; cv=none; b=NMrmd42Y75iS+JWW4W3plRJBfuUrbOjhl7wJ1e6tFXzfyrjLrCYdmefcPYO4X1dVOfB7DZqLouYS1CMlxT5RcHCy4jNWh4TFkqoeTpZF9mP2bFG8kJWtmBMpyKmwkR9+f4b5sUnNolP6KYjFUVWwd+NqKvOQ1KkoIx4Ol1apiHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773744845; c=relaxed/simple;
	bh=DuQCBEOmmBF6B5LP0Nv10h8KXlh7YJZD1iVQVy7vzTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBBPbW3H2E1GUCm6DA0haYsv2FZlFBLR/AnpL7nF2WWe4u1IlnIgKl62QUtLcAmqHhrmTFLqf1cCqyOfyma+u6RYAXa2nov7PBdsR6pAah7I+aytbvCKuLbsjgWrqreYOq/2TSUFCKkg3OfKKZhoujsjLHuPdiaefGDHlKAbFeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIRi4GRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F021CC4CEF7;
	Tue, 17 Mar 2026 10:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773744844;
	bh=DuQCBEOmmBF6B5LP0Nv10h8KXlh7YJZD1iVQVy7vzTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QIRi4GRDpfc3Zk8Pp+i8sH5HzuCSgJ4kZPb2MRhXU/VZDHkr785/sFCaWEdDVJQrF
	 WgdLcztVjm8/Cie/tj0N6WqRbJtz9L1jvztzVzGLlzYMDBhB65oj5K7GAPKBBtQgjm
	 07nX7g+ahq2/6/jal+mxGd2fqS9Uq8K49CDzgS6nlQlDQY4oF0oaxc453KIB/cmVqZ
	 lz86r+7kctbckyO9wXT5LduslAKPWCuqHlZxkAcpGAHw+iOvUdVNVZXcvtdYUGC7Ll
	 dgdzjDRmDO9eBOu/BsLkCWKq3BRcU2JP+GgET6mF6cAbWYkN2lLzUgr622GB8OiURK
	 B0U8Rf2lMk+vg==
Date: Tue, 17 Mar 2026 16:24:00 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Veerabhadrarao Badiganti <veerabhadrarao.badiganti@oss.qualcomm.com>,
	Subramanian Ananthanarayanan <subramanian.ananthanarayanan@oss.qualcomm.com>,
	Akhil Vinod <akhil.vinod@oss.qualcomm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/3] dmaengine: Add multi-buffer support in single DMA
 transfer
Message-ID: <abkyyBxSnwZWAt4-@vaman>
References: <20260313-dma_multi_sg-v1-0-8fabb0d1a759@oss.qualcomm.com>
 <20260313-dma_multi_sg-v1-1-8fabb0d1a759@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313-dma_multi_sg-v1-1-8fabb0d1a759@oss.qualcomm.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9466-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4BCF22A84D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 13-03-26, 12:19, Sumit Kumar wrote:
> Add dmaengine_prep_batch_sg API for batching multiple independent buffers
> in a single DMA transaction. Each scatter-gather entry specifies both
> source and destination addresses. This allows multiple non-contiguous

Looks like you want to bring back dmaengine_prep_dma_sg() see commit c678fa66341c

> memory regions to be transferred in a single DMA transaction instead of
> separate operations, significantly reducing submission overhead and
> interrupt overhead.
> 
> Extends struct scatterlist with optional dma_dst_address field
> and implements support in dw-edma driver.

If this is memcpy why are you talking about dma_dst_address which is a
slave field?

-- 
~Vinod

