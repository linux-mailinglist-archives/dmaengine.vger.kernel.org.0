Return-Path: <dmaengine+bounces-9467-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4E84Fek0uWnpugEAu9opvQ
	(envelope-from <dmaengine+bounces-9467-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 12:03:05 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C95112A86B6
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 12:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF8183046D88
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 11:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3040376BEF;
	Tue, 17 Mar 2026 11:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGutQs/0"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803C432FA2A;
	Tue, 17 Mar 2026 11:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773745382; cv=none; b=Gk62eJLXMmZ1Q4m/3mglxQ0XvNEk8gmKPJN+WJ4+a+x0QUb4picJDFLGzwTiC1uuzYbH0OhApS6L/HmU65HmSdrnoYmMdn2Oq5NpRm898cjviRDoZT9uDUJEamntGt7XxYX8wWpmnamfIF+6VHsdtn4qU3XxBGC5v2rRwkRRo4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773745382; c=relaxed/simple;
	bh=6Q4DtysOUCijP5PtUtDJatVKUrrtCLdMe+bG7uK0AAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/tk71ueDuR8AyrRo3kpH9rYRw08nqxdtM+EnVkgL33K13lRA6qvqhpfVFzicO2GIj7QxVdayqMXA/Q2r24mU4pu0d35yppg1phZ3AfMSxJOL45HcFZ+yMOfKihLbxpdN66KjkEr4MhqGOABAX+RGEB2z2YFoPHIADrZGAUKU8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGutQs/0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62326C4CEF7;
	Tue, 17 Mar 2026 11:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773745382;
	bh=6Q4DtysOUCijP5PtUtDJatVKUrrtCLdMe+bG7uK0AAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fGutQs/04uCQ0xXFxUhiO6NI/WZgFG56+ABNMGEgqTGFr3BrRJbZ3njtbxdqO5fQk
	 sS6PB1KKiLPA4m1xfMKc58qQ2QntwexKFN2FWvgrwwxzkNDO/7nIxZGp9GYnsCPPYy
	 9AoRH2m9Kkg8XqK2W7gapkE0l2UzbeAGoyopZulsgxlw241gyMOp8TSSocN98m7eDN
	 uUmnkIP78b6OUVd5tz7/+P3jP8PQa9ARbvOs3sSLlhNdrwX+Z/+MXhY80nGYdBKG36
	 5d2j6rAT8Wod6FMzZBarJomb5qQNb+dJYLw6vPk5sTFugUM9m5qbgXppi5IrLLirCv
	 aD/gHqLJJYsnA==
Date: Tue, 17 Mar 2026 16:32:58 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Devendra K Verma <devendra.verma@amd.com>
Cc: bhelgaas@google.com, mani@kernel.org, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com
Subject: Re: [PATCH v13 0/2] Add AMD MDB Endpoint and non-LL mode Support
Message-ID: <abk04pkF4mOR0rKP@vaman>
References: <20260311111834.3750297-1-devendra.verma@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311111834.3750297-1-devendra.verma@amd.com>
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
	TAGGED_FROM(0.00)[bounces-9467-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C95112A86B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 11-03-26, 16:48, Devendra K Verma wrote:
> This series of patch support the following:
> 
>  - AMD MDB Endpoint Support, as part of this patch following are
>    added:
>    o AMD supported device ID and vendor ID (Xilinx)
>    o AMD MDB specific driver data
>    o AMD specific VSEC capabilities to retrieve the base of
>      phys address of MDB side DDR
>    o Logic to assign the offsets to LL and data blocks if
>      more number of channels are enabled than configured
>      in the given pci_data struct.
> 
>  - Addition of non-LL mode
>    o The IP supported non-LL mode functions
>    o Flexibility to choose non-LL mode via dma_slave_config
>      param peripheral_config, by the client for all the vendors
>      using HDMA IP.
>    o Allow IP utilization if LL mode is not available

There is trailing whitespace in patch2 and even then it fails for me on
dmaengine/next. Please rebase and resend

-- 
~Vinod

