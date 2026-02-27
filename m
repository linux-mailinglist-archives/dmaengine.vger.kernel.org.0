Return-Path: <dmaengine+bounces-9138-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDIDOs3+oGnupAQAu9opvQ
	(envelope-from <dmaengine+bounces-9138-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 27 Feb 2026 03:17:49 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EDB1B1F47
	for <lists+dmaengine@lfdr.de>; Fri, 27 Feb 2026 03:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EBF6F30074B1
	for <lists+dmaengine@lfdr.de>; Fri, 27 Feb 2026 02:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0417F215F5C;
	Fri, 27 Feb 2026 02:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5SPLozK"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59211D416C
	for <dmaengine@vger.kernel.org>; Fri, 27 Feb 2026 02:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772158667; cv=none; b=LuoIhDXX/u1v9gtcl7G+nPood97Y41tH/l02FwdDlaffW/OYR7G7U8UWIfxXlIjVVaOwmjLQgcJq/97Hshckhynu7HkYsbZgZrvkyonIGeBsMNOX9kv5+kirnH5ZuxFECq9M2FlW52t38n+OKWcClfNXb90Wtb6IN1Spc6VgpKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772158667; c=relaxed/simple;
	bh=c9g9k6CutPXZrHh3VoTrEBBv4rAf5Kbh1V/ttfcD7Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fonu9kofNBIC62kEQBN+7tZ9E80mEmSlZQ87i/bNorYnbHPqExi97BdlQWzvvBXs3b2bKwex4m5ucumvKn+quASyCShqdFrc7oSDFFXEkXXyiOGtJKAcfZkkNX5x5/bPnUsEd3BIRZ4pZleZX70p5Wh0gFocAIBN3A5LYdI61vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5SPLozK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ABC9C116C6;
	Fri, 27 Feb 2026 02:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772158667;
	bh=c9g9k6CutPXZrHh3VoTrEBBv4rAf5Kbh1V/ttfcD7Ko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g5SPLozKyf0QcmapZslM6ILpjIB8ajfub957ConG5xag6gTTQXZKSbax3DOwCOQEI
	 8bXUD4M4kKM+COM027O4Xt9fOYj12JX7Nj+qMerIA8rNAFaxZ9VIvrqUPAxvGLQwuy
	 WqW/bcWmB+o7yAlyPTJuqETKSbNnjtoZIOfQaxg5YNXV/Jas3aHoK0JLDF1XSgIVQ9
	 V3iPXZvO1W7dLu9fcfeavLf2F3MIX5dOGSsDnMLHLuiAzQ5+a8tOqbeVoow2NPXlwI
	 s0pIPzobkZurGBcEKHmZjo6leaAbHkyWOlW4lpburrAsdZA3t1EsvYCmCyfHIqL9zf
	 D+egacr8TY48A==
Date: Fri, 27 Feb 2026 07:47:43 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: dmaengine@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 0/5] dma: dma-axi-dmac: Add cyclic transfer support and
 graceful termination
Message-ID: <aaD-xxghRKAhS8Yc@vaman>
References: <20260127-axi-dac-cyclic-support-v1-0-b32daca4b3c7@analog.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260127-axi-dac-cyclic-support-v1-0-b32daca4b3c7@analog.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9138-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,nuno.sa.analog.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 86EDB1B1F47
X-Rspamd-Action: no action

On 27-01-26, 14:28, Nuno Sá via B4 Relay wrote:
> This series adds support for cyclic transfers in the .device_prep_peripheral_dma_vec()
> callback and implements graceful termination of cyclic transfers using the
> DMA_PREP_LOAD_EOT flag. Using DMA_PREP_REPEAT and DMA_PREP_LOAD_EOT is
> based on the discussion in [1].
> 
> Currently, the only way to stop a cyclic transfer is through brute force using
> .device_terminate_all(), which terminates all pending transfers. This series
> introduces a mechanism to gracefully terminate individual cyclic transfers when
> a new transfer flagged with DMA_PREP_LOAD_EOT is queued.
> 
> We need two different approaches:
> 
> 1. Software-managed cyclic transfers: These generate EOT (End-Of-Transfer)
>    interrupts for each cycle. Hence, termination can be handled directly
>    in the interrupt handler when the EOT interrupt fires, making the
>    transition to the next transfer straightforward.
> 
> 2. Hardware-managed cyclic transfers: These are optimized to avoid interrupt
>    overhead by suppressing EOT interrupts. Since there are no EOT interrupts,
>    termination must be detected at SOF (Start-Of-Frame) when new transfers
>    are being considered. The transfer is marked for termination and the
>    hardware is configured to end the current cycle gracefully.
> 
> For HW-managed cyclic mode, the series handles both scatter-gather and non-SG
> variants. With SG support, the last segment flags are modified to trigger EOT.
> Without SG, the CYCLIC flag is cleared to allow natural completion. A workaround
> is included for older IP cores (pre-4.6.a) that can prefetch data incorrectly
> when clearing the CYCLIC flag, requiring a core disable/enable cycle.
> 
> [1]: https://lore.kernel.org/dmaengine/ZhJW9JEqN2wrejvC@matsya/
> 
> ---
> Nuno Sá (5):
>       dmaengine: Document cyclic transfer for dmaengine_prep_peripheral_dma_vec()
>       dma: dma-axi-dmac: add cyclic transfers in .device_prep_peripheral_dma_vec()
>       dma: dma-axi-dmac: add helper for getting next desc
>       dma: dma-axi-dmac: Gracefully terminate SW cyclic transfers
>       dma: dma-axi-dmac: gracefully terminate HW cyclic transfers

Please be consistent in naming, it should dmaengine: dma-axi-dmac: xxx
everywhere!

-- 
~Vinod

