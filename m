Return-Path: <dmaengine+bounces-9347-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MArXLwazrmkSHwIAu9opvQ
	(envelope-from <dmaengine+bounces-9347-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 12:46:14 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5CC23820A
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 12:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E552301BDCF
	for <lists+dmaengine@lfdr.de>; Mon,  9 Mar 2026 11:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF4E3A6EE4;
	Mon,  9 Mar 2026 11:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFgUomhz"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A963A4525;
	Mon,  9 Mar 2026 11:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773056767; cv=none; b=jFgawD++MYcWpVPWayp+vYCti9eLs/Emv1mCEmAxt6ikLMXQc/3p0elHh0aOMBBqPnPxY76kn9zNaJH8egCZdl0RcTCs/t3XQlxDBe45qFFXRKGjQy60PIzvLejYKNieUXpnDq/RBcv59Qjg70e7CRZNql/GEmNCS2UmmGPyF7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773056767; c=relaxed/simple;
	bh=OFaoYkaIS2OUPZTnhJvnVH45ZPvyME10c7jysg+0Lqw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=umADiMuRNn/ZBlUoQMFoVAsqbbEp8yGFl3rkycOIleBhEVDOpIUlcJdNOcr3f29v1Paz42DbPeWiKjagHGlBYqju+XCKIgZA+dyi3VuguMhSszu7HdyB0XA/6TEppWEO/RZemalW0pTMlX3Xym+xPFWjYYtbxjcwl8g8XSrtjxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFgUomhz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D90C2BC86;
	Mon,  9 Mar 2026 11:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773056766;
	bh=OFaoYkaIS2OUPZTnhJvnVH45ZPvyME10c7jysg+0Lqw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jFgUomhzQqjG5UMQFH3E6sAG/T9ZXlFQIvH7NZXVZIp6KqO0SJBmfDn0nqmWa2U+o
	 Z5A6+lnGE67YF/LT7oZ06wAzZydFya5zKOaF2HfI1qIckl+WGP2NfkDHcXczjqRBkk
	 +MiOSk4da5dt6YVGPUGq9JAyhxKyv/6Db8RZ4CsL6x/oy6phCtXcQcbf4E75/EjdUx
	 HmG3r+vvSwc99OAlft1bqnOWViuDkns6cFBwF4QiV3MW6XXC9xnTI17sfJn5s/5sCi
	 JNA8tXeOnW6v3Feh3UGX66tyEPYRoRWjmjlaAw4RzjRl6xT/5r3WBNYB/ckC9Upb9q
	 HN7iLGbMnqdFg==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Johan Hovold <johan@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>, 
 Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
In-Reply-To: <20260105114445.878262-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260105114445.878262-1-cosmin-gabriel.tanislav.xa@renesas.com>
Subject: Re: [PATCH v4 0/4] Add DMA support for RZ/T2H and RZ/N2H
Message-Id: <177305676317.117444.8305717666981280954.b4-ty@kernel.org>
Date: Mon, 09 Mar 2026 12:46:03 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: 6A5CC23820A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,glider.be,gmail.com,renesas.com,bp.renesas.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9347-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.919];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt,renesas];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action


On Mon, 05 Jan 2026 13:44:41 +0200, Cosmin Tanislav wrote:
> The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have three
> DMAC instances. Compared to the previously supported RZ/V2H, these SoCs
> are missing the error interrupt line and the reset lines, and they use
> a different ICU IP.
> 
> V4:
>  * drop device tree patches already queued up by Geert
>  * pick up Geert's Reviewed-by
>  * dma_req_no_default -> default_dma_req_no
>  * register_dma_req -> icu_register_dma_req
>  * rz_dmac_common_info -> rz_dmac_generic_info
> 
> [...]

Applied, thanks!

[1/4] dmaengine: sh: rz_dmac: make error interrupt optional
      commit: b34f3fcae72a0afdd1a966fd68309b461bf678e6
[2/4] dmaengine: sh: rz_dmac: make register_dma_req() chip-specific
      commit: bbb8b402d798f9f211376cee3d649d64dfc17880
[3/4] dt-bindings: dma: renesas,rz-dmac: document RZ/{T2H,N2H}
      commit: 40dd470a95c0674515ca606757ffe174bd7d3f90
[4/4] dmaengine: sh: rz_dmac: add RZ/{T2H,N2H} support
      commit: c03d8b5462bcb0022f9477d09eb37dae66c3a769

Best regards,
-- 
~Vinod



