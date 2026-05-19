Return-Path: <dmaengine+bounces-10564-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WK2mAwKhDGq8jwUAu9opvQ
	(envelope-from <dmaengine+bounces-10564-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 19:42:26 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1A05833F7
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 19:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18B0E306F02F
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 17:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0573438A3;
	Tue, 19 May 2026 17:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsPMgnku"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F0E343894;
	Tue, 19 May 2026 17:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779212454; cv=none; b=mbHugfWYn7/OBloehHMbKGfOEoaxPMYJm1kDd/KxZtgBd5Qhuh0N245UFMNT92ppLALkIcJO7yB04GvkAPWdzL/WUZYWIvmfqsIDz1FfXNJXYkDn8eY4LN5o1PazBDvoV6YSPpq6Wj5dsA7ENdTiIaAIIREE84WCFo63pCWhg7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779212454; c=relaxed/simple;
	bh=AvGnWQwn3+7/CykX7PGFPD87Hn27WmsYM8LaCcXaYoE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iI98BKS8JksY6hJqYNV0Gl7uOQIzvH4OI17RiNl4NqeEaqLvyQX8bGZjht5XumX5KN7MFx834cSvHcYJURWn4tBQj+4H/lBNzpm2PGwS+9nro1y2ugYWC1qwu8ZaExTKR78Jmzgs8GcPLUYvv/wGVPP/i7ZQOak50z7YLwruQoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsPMgnku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1651C2BCB3;
	Tue, 19 May 2026 17:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779212454;
	bh=AvGnWQwn3+7/CykX7PGFPD87Hn27WmsYM8LaCcXaYoE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hsPMgnkuKZ7M28pQxBK3zufolowLcOEtn7JMIAiJy8GdUewfsLvRQULgFRTbvB5/2
	 37vR3kKy9u303/QX3RoybZ6pVgVQ3zTpfxyfqe9N5n09IcGqHKrHIr368B8lwlz2Fi
	 328vHAjndylLAUUxPbYPZhhD63c7V/W22c5RbutWe3MIUKp9i4VVWYFmIjGW36sOqv
	 5f4+brc1icnqSeoyMNA5rY2YR7IlioRHBv4RsTgMKYpU+4gciUKIiAyTG/hC4I9FTO
	 7jdWHe1DcmTA/Q2frxxt1IChOH6+9c4Eh/UpZwdqpJRduXknky32i+8PcQF0PtbpB6
	 T0vs+QVmI+xZA==
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260515-eliza-gpi-dma-v2-1-1255b43d5ca9@oss.qualcomm.com>
References: <20260515-eliza-gpi-dma-v2-1-1255b43d5ca9@oss.qualcomm.com>
Subject: Re: [PATCH v2] dt-bindings: dma: qcom,gpi: Document the Eliza GPI
 DMA engine
Message-Id: <177921245049.339411.6679441832968153093.b4-ty@kernel.org>
Date: Tue, 19 May 2026 23:10:50 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10564-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CF1A05833F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Fri, 15 May 2026 14:39:36 +0300, Abel Vesa wrote:
> Document the GPI DMA engine found on the Eliza SoC.
> 
> It is fully compatible with the GPI DMA engine found on SM6350,
> thus using qcom,sm6350-gpi-dma as fallback compatible.
> 
> 

Applied, thanks!

[1/1] dt-bindings: dma: qcom,gpi: Document the Eliza GPI DMA engine
      commit: 33a6c96b31035fccf6968e2d35e3b727cd42580b

Best regards,
-- 
~Vinod



