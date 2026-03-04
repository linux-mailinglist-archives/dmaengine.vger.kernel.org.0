Return-Path: <dmaengine+bounces-9232-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFp6C0Dgp2lnkgAAu9opvQ
	(envelope-from <dmaengine+bounces-9232-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 08:33:20 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 304FB1FBA00
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 08:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 614473023AA5
	for <lists+dmaengine@lfdr.de>; Wed,  4 Mar 2026 07:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71685369999;
	Wed,  4 Mar 2026 07:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOMSWQIr"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8C0308F1D;
	Wed,  4 Mar 2026 07:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772609593; cv=none; b=PI3gEb/MXYiRZcWr6hH/u8SCZhobn/ywajfmJSTlKfcxipI+UgwqPE9Bd+fs9XAAl/GEX3k0ZOG6yDVJU0qh+yfxTgJCj8TBvjpEJJ5lr5PxRmwzqQ+9tkGBMbvTm/+Bk6/b35bSOx7tfz9QK3LitlY9dT2Y6dtQWpHzXOoWBpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772609593; c=relaxed/simple;
	bh=8l87FG3GfJ8GOGQId/6eYI/ACFLADMHOJZvD/ixFexk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQ7yKWnvBX40ruIb2v9K6RUPgPI69OVJIIZmiINwZXY/rJiWDQHCDUPRwLEl7V2stt3keON/j0NcdZYQFSIVCHYZ0kjiNmpQqVRlOQtYFg05Ny+/NibYCFcqwp8404Hv3hdezzO0ybkof3FJy2ZH0JEGLCMBtC6pFSHcHm9SFyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOMSWQIr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4817EC19423;
	Wed,  4 Mar 2026 07:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772609592;
	bh=8l87FG3GfJ8GOGQId/6eYI/ACFLADMHOJZvD/ixFexk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HOMSWQIrUCrYfDhcT1LekIwNg0z7E1jHDc7bo6lVsZ2I8YneR/S/G/tKdCXEXGs0Q
	 XfKKNVNqODC2qSDdytIoSSm98eG3ZlePGTPyNOYbIOZi42mHHw/CJqcmbZ28t6I+pG
	 hajkmVxa969r5CkWKo0YNEKvY2b9xJTL+tAJzvv6WxiR+veQ3fKbn8nJwh74P2UEAK
	 CWSSAjy1aFLISt7ZMQfQHcIRzEmLk9YaPDFtQC+DZPbgtM16IKeb7A6ZzmHpdD4AAZ
	 yShTiebgwMWI753LCzzb/m3a+H7AzAIRrL33TzVFGW2sjxwcoBR97qWEeCTASw/AVW
	 oRjZB4mbAQLLw==
Date: Wed, 4 Mar 2026 08:33:10 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: dma: Add Amlogic A9 SoC DMA
Message-ID: <20260304-uptight-rugged-badger-c40d0d@quoll>
References: <20260304-amlogic-dma-v5-0-aa453d14fd43@amlogic.com>
 <20260304-amlogic-dma-v5-1-aa453d14fd43@amlogic.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260304-amlogic-dma-v5-1-aa453d14fd43@amlogic.com>
X-Rspamd-Queue-Id: 304FB1FBA00
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9232-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 06:14:12AM +0000, Xianwei Zhao wrote:
> Add documentation describing the Amlogic A9 SoC DMA. And add
> the properties specific values defines into a new include file.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  .../devicetree/bindings/dma/amlogic,a9-dma.yaml    | 65 ++++++++++++++++++++++
>  include/dt-bindings/dma/amlogic,a9-dma.h           |  8 +++
>  2 files changed, 73 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


