Return-Path: <dmaengine+bounces-9058-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFh6N23OnmnwXQQAu9opvQ
	(envelope-from <dmaengine+bounces-9058-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 11:26:53 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C99B195BF9
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 11:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA6A03103F89
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 10:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234A5311587;
	Wed, 25 Feb 2026 10:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmItdglR"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0070B3242D8;
	Wed, 25 Feb 2026 10:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772015005; cv=none; b=aLL4y1CcVntQwOdwENiORRDrynxIs5fjdPhkFvpC8329eU3nFlvVJXnKKmeDN4Pp1xo5gwRULZiC519eR2Ppo/2B4x5ad7naOuHTi12vJyywulta1VwjYdjoheLCF7uVcq2Z1vnNGeOi3VkpDrtYLm8LoALKF/BngcJEBABN5SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772015005; c=relaxed/simple;
	bh=N3aUeA28ncvE2kAm7dvD3alfaI2SO/lLeVYKn6UM5Fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xy3MevNpDN5Ilzkmcc6dXn5Q2Sc0dWNShbfAKa2Rq825kjLz9JkHWsUWhF4Jaactj/BMqcEKQXPV9oXXfajwoEEef2KlQPlfn52Tt4aEj4vXk57C2ozBcJW6R8NKOQBRJcyyN4Y1BGM98dh/f6S4E6F/m+wk++5ak1DvIvJtWS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmItdglR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F846C2BC86;
	Wed, 25 Feb 2026 10:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772015004;
	bh=N3aUeA28ncvE2kAm7dvD3alfaI2SO/lLeVYKn6UM5Fk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VmItdglRA+UuO46w5Z5bb11g59x96XQdEjDCaWeRyFRIqTMZ1jynbxhCLgvRD9oMd
	 3X+56hCCDaP1JxuFD4w4hWASY7ARs50gPZZUHprxGSmuoadF45oBgc/y9mFxfNIvm3
	 3zeZGsGDFOa/VJLTYVIwDFMWZPG8RQlN/pb9kPbGdsOCf5jWvFSr9bPs7M1cHwLygS
	 5m150kauZAW57NBAndMa5oKz7rL/m1moqFqpdD3CWEvgcPIcnwmgnLPTKytYLDcCRI
	 CRLRXF8pQNjb8TCPSBrcDXhSl8LoRNumLymVn94UrduysqXPUNE9fjZKb4LUrstrrB
	 RinFbdaYOVJaQ==
Date: Wed, 25 Feb 2026 11:23:21 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Abin Joseph <abin.joseph@amd.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, michal.simek@amd.com, 
	radhey.shyam.pandey@amd.com, git@amd.com, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: dmaengine: xlnx,axi-dma: Convert
 bindings into yaml
Message-ID: <20260225-athletic-bittern-of-beauty-598ec2@quoll>
References: <20260225050521.160724-1-abin.joseph@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260225050521.160724-1-abin.joseph@amd.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9058-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7C99B195BF9
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 10:35:21AM +0530, Abin Joseph wrote:
> Convert the bindings document for Xilinx DMA from txt to yaml.
> No changes to existing binding description.

Subject - not YAML.
See also:
https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

Best regards,
Krzysztof


