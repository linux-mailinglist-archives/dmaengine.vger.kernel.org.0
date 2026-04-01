Return-Path: <dmaengine+bounces-9793-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAdKHmy+zGmYWQYAu9opvQ
	(envelope-from <dmaengine+bounces-9793-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Apr 2026 08:42:52 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65514375539
	for <lists+dmaengine@lfdr.de>; Wed, 01 Apr 2026 08:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0AE3D302D880
	for <lists+dmaengine@lfdr.de>; Wed,  1 Apr 2026 06:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582EF339856;
	Wed,  1 Apr 2026 06:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JsTNp39g"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3242A245008;
	Wed,  1 Apr 2026 06:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775025754; cv=none; b=liNw+QFpBA3HFygK8SQ/Vk1CY//eI8ZBHENImBtL7sEGGmxcn/wSb56lguk8YoxNhDtmpIGmffx+zg6rIO/7bxXwxtk9PpkjMvk60sXoVOElqoBalnmMtK91p9s+xm2TK4BUq7hRGO0sFgY6Ao2Xz+q0/8Cj//A04n+xbfPb36o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775025754; c=relaxed/simple;
	bh=3lkikTg0z/4Lxu0Fwa2UNf6cezlmSQAqwLsxdRmUJr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lolLjfjdH3+RDL30j4dcePnyQKiyGYu4Opa2kaOgT3wbFaP64bRh72XWBXUoozTZTDJE9gV428iMEQmgbfAAAGYbz1H0BdLH8mapZ0GxSstcnQg3m+3unk45v1rl0vEYAf3LQSm3i3tVhfRpR2GUajJTSmF7zk6bGABcmTvGL+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JsTNp39g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57830C4CEF7;
	Wed,  1 Apr 2026 06:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775025753;
	bh=3lkikTg0z/4Lxu0Fwa2UNf6cezlmSQAqwLsxdRmUJr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JsTNp39g251oXeS4gtkL0tH8DetAp58TB++OCi4jNnWvlZaPXq/eVaXhoKofg120X
	 3pUcw7O0PxNOGnCchQGQyyh3iY0JM9AymG9fIJJF8FkLGAgnX3ROen+77G0TpYR2A6
	 MnVZ+Q+cSF46ex7fatmkjDVf6cCVlnOW+OW4H6QNvQDGohPOIowCqVByRQp61roDMi
	 +aJaws0OtKH3nRnpyNO7UT4OsmXAMYQlzSjOH4/TUSA7YYfJ6pzgk6aCa2tBA+99cE
	 bvO8djuMySzY9+nTh3nzvMu59XRU9/WMp4Df5V/SNB2KGgtfMc7IWt76lIeGEkGdgN
	 9+fGN2VuOgGoQ==
Date: Wed, 1 Apr 2026 08:42:31 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, Guodong Xu <guodong@riscstar.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 1/5] dt-bindings: dmaengine: Add SpacemiT K3 DMA
 compatible string
Message-ID: <20260401-divergent-magenta-dalmatian-3c6c3e@quoll>
References: <20260331-k3-pdma-v3-0-a4e60dd8b4b3@linux.spacemit.com>
 <20260331-k3-pdma-v3-1-a4e60dd8b4b3@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260331-k3-pdma-v3-1-a4e60dd8b4b3@linux.spacemit.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9793-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bootlin.com:url]
X-Rspamd-Queue-Id: 65514375539
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 04:27:04PM +0800, Troy Mitchell wrote:
> From: Guodong Xu <guodong@riscstar.com>
> 
> Add the "spacemit,k3-pdma" compatible string for the SpacemiT K3 SoC.
> 
> While the K3 PDMA IP reuses most of the design found on the earlier K1 SoC,
> a new compatible string is required due to the following hardware differences:

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597

> 
> - Variable extended DRCMR base: The DRCMR (DMA Request/Command Register) base
>   address for extended DMA request numbers (>= 64) differs from the K1
>   implementation, requiring different driver ops.

Please do not mention drivers.

> - Memory addressing capabilities: Unlike the K1 SoC, which had memory addressing
>   limitations (e.g., restricted to the 0-4GB space) and required a dedicated
>   dma-bus with dma-ranges to restrict memory allocations, the K3 DMA masters
>   possess full memory addressing capabilities.

Programming interface is still compatible, regardless of memory
addressing limitations, so that is rather incorrect reason.

Best regards,
Krzysztof


