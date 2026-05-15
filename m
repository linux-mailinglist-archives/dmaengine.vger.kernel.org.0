Return-Path: <dmaengine+bounces-10479-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGmhH0vlBmoHowIAu9opvQ
	(envelope-from <dmaengine+bounces-10479-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 15 May 2026 11:20:11 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C5C54C48C
	for <lists+dmaengine@lfdr.de>; Fri, 15 May 2026 11:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 99D89303790C
	for <lists+dmaengine@lfdr.de>; Fri, 15 May 2026 09:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F1B42B726;
	Fri, 15 May 2026 09:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+iEryPv"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA52428492;
	Fri, 15 May 2026 09:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778836192; cv=none; b=m6nvRzELFgDH95YcCaprmcIxpImi6BmenUKZaSC3Bbcoy3plGFBbIo0XzUjoGQsYYPa2y39DKbcYpCVfmmGPoAxvPmDTzwIVwUisCcefGZw4tCFC3gel0wLLzIJVlz4FCxA29fd40QhlaFIF7TbiSr1A5Ro+kuPsAMvfH03UONU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778836192; c=relaxed/simple;
	bh=7Otnj66pXZvejvjAfMIR6De6yZwNt+3b0JjPCBiM2as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxQgC2vbWAkaBzb9/N8Jnk9fBpOlZijAgLihiepEP1ONUjmEWbFEMGbEUOKTgmBhuE2Rxxvog3OhXHEGjvOtwVPm2lNT9Y+87nkDNSQVTN5hxA8jWdEXxht3fiFZAD9avEozuMzHtfsqlg9JiFEyUZDoCANP4nqnyhtYpspoeEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+iEryPv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD269C2BCB8;
	Fri, 15 May 2026 09:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778836192;
	bh=7Otnj66pXZvejvjAfMIR6De6yZwNt+3b0JjPCBiM2as=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D+iEryPvk+jgMDe576jJyTU0j8ZVUKyZQt6jpn1HVjYquLPvQC6mRRs1a/lyysNNw
	 9PPe1k2JriOlmuygfSFBj2uumRtOOShYPoDjA/8QGNGABQhGe/icFKASH25PeBaXiA
	 ayzL0SUBM/or8UYkkjdtGMtMTwwxnEYKoNu9zlbJ0uMobZ5kEW+BirETUwKMl2mRtw
	 j5o4TxQwnaFO/BQw5Zz/wLPx+P/GlIjECn9hUp2CMG5AfwnG2UXdmjZYKWYK7D9ODA
	 GbhsHaGIciMFHKJj5QWGzU41N29agB/zORftbJaBu/Ol1Rt5Lru6u9KUiXvK8Z2x6N
	 RXxheGVkSh/iQ==
Date: Fri, 15 May 2026 11:09:49 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: qcom,gpi: Document the Eliza GPI DMA
 engine
Message-ID: <20260515-charming-rhino-of-inquire-67edb5@quoll>
References: <20260513-eliza-gpi-dma-v1-1-d8e37f026c36@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260513-eliza-gpi-dma-v1-1-d8e37f026c36@oss.qualcomm.com>
X-Rspamd-Queue-Id: 25C5C54C48C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10479-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,dmaengine@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 03:10:02PM +0300, Abel Vesa wrote:
> Document the GPI DMA engine on the Eliza SoC.

... compatible with SM6350. Or something similar explaining the
compatibility. 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


