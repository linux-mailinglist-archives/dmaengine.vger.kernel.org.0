Return-Path: <dmaengine+bounces-9686-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eF9CGNcxxmnzHQUAu9opvQ
	(envelope-from <dmaengine+bounces-9686-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 27 Mar 2026 08:29:27 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB74340693
	for <lists+dmaengine@lfdr.de>; Fri, 27 Mar 2026 08:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C262D3038F5B
	for <lists+dmaengine@lfdr.de>; Fri, 27 Mar 2026 07:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155693C8728;
	Fri, 27 Mar 2026 07:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsiRKPQZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203DC3C3BEB;
	Fri, 27 Mar 2026 07:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774596515; cv=none; b=A6noEDOaGs6kfmZ7pcbo4EQ5+TOx3RVlPU/Ulg2ygJo7XDxlg/fZRV8PLlkxfBYaxHqT6wsFpFNTdUzgGjnPMx+rFBjzjU/f+/dMq4p0Rr2Z+Jwq5Brx048rLbRBQAT7fw82kBmQQQWyaoO3TiX8Brm74hsbiCBPybOUItXKSXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774596515; c=relaxed/simple;
	bh=kBoaD+Y3WUsK9eFptmTNmn+4Xv38yoT0ql97BiTIliU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=siuRceRvtGwuGbxMwe9b67jbNpTqaEijLDKpbGyAXeL3gyTvegq+flxPdNlH3TAof9+tPKvYMKtCjqCR1KcUt9qyt2HZG2xLzWXfbeNgLYDStSzaFLS+Th6UokQbLO5wCBXCuMJy7/cit2fV9Abu45lGGgH0EUWqr8Q3QoKUKoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsiRKPQZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127E1C19423;
	Fri, 27 Mar 2026 07:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774596514;
	bh=kBoaD+Y3WUsK9eFptmTNmn+4Xv38yoT0ql97BiTIliU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gsiRKPQZkPr7ICtM79AfrIIH9+ubEj+iignxoxh6euOjXkN7XzFbzfnbXfxO+b3PK
	 DH8sEul55Y8uqWLqwlzlP14b2QXb0mufoujgXaKxEY743M6IVZVF0R/Hk8Z8Z7gUiX
	 n4643OUtJtSTTm3OhngU0doMvovGeb/BJ6DRH/9sldF1R1ftgBYENKg8DjB4tA3q+R
	 toJZBQNHX3llI4iHdYHK7k/VEX1rcq8bCseRat/kuR5ioPMx/uCEK9C2D7Eqyweq8A
	 qJqJeBQ5KMuCtENhlQN2mxIOgDeEMJBewvQp5LH12V8CT7HPHVnf3bvMCQIbYdo53u
	 QDv4NN7VCjM5A==
Date: Fri, 27 Mar 2026 08:28:32 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Guodong Xu <guodong@riscstar.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 1/7] dt-bindings: dmaengine: Add SpacemiT K1 DMA
 request definitions
Message-ID: <20260327-silkworm-of-algebraic-aurora-e9bd1c@quoll>
References: <20260326-k3-pdma-v2-0-ca94ca7bb595@linux.spacemit.com>
 <20260326-k3-pdma-v2-1-ca94ca7bb595@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260326-k3-pdma-v2-1-ca94ca7bb595@linux.spacemit.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9686-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[riscstar.com:email,spacemit.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BDB74340693
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 04:17:16PM +0800, Troy Mitchell wrote:
> From: Guodong Xu <guodong@riscstar.com>
> 
> Add the DMA request numbers for non-secure peripherals of the K1 SoC
> from SpacemiT.
> 
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> ---
>  include/dt-bindings/dma/k1-pdma.h | 56 +++++++++++++++++++++++++++++++++++++++

Also, this is not a separate commit.

Best regards,
Krzysztof


