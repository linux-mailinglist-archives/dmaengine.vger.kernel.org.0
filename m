Return-Path: <dmaengine+bounces-9137-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPp3E4v+oGmqowQAu9opvQ
	(envelope-from <dmaengine+bounces-9137-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 27 Feb 2026 03:16:43 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DB01B1EFE
	for <lists+dmaengine@lfdr.de>; Fri, 27 Feb 2026 03:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 724EB303DADA
	for <lists+dmaengine@lfdr.de>; Fri, 27 Feb 2026 02:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69D3286D4D;
	Fri, 27 Feb 2026 02:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItgQo1lw"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC74258CDC;
	Fri, 27 Feb 2026 02:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772158598; cv=none; b=KGCF493IeQRR53Po1ftwsA6TB0A0vOFYb/6yL6FQ1lA5uDP7B5XGe+Z23V4CTxPlu36KPT5cNGayLlASOA72rDQDqnqTdL5+pavJX39YwE4q1STQ7QneXZUEFt1273Ib1JqMq4lxH98BW6dnpIadNiSarcF/2kVY4A9BTW4SAuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772158598; c=relaxed/simple;
	bh=ee9EbKwmHw9ebTlHpkhD7HSrZHZy0nwPHkdHF2tATUM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kW7Z2efC8ynHNLfibfEfYPF6RlUitDLttCaYEURCXep66SrNlyP80Eog35wFhuBgr62fJVvOX2B48v5IPH8tV+nY9gDKwC7h9ZlMVBZ7VzCT/e9rrfp4/eQpIBe0MSxVAT6LGG4qDTrZ8mV38yKuTf5pBc7IDndgOp6xt5yzW7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItgQo1lw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C203CC116C6;
	Fri, 27 Feb 2026 02:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772158598;
	bh=ee9EbKwmHw9ebTlHpkhD7HSrZHZy0nwPHkdHF2tATUM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ItgQo1lwhbdoqPV6W/sxNmeDjiIaJTAkSarnBTGPzDNc+2jgt4nbauKxFfuSKWDYH
	 pL7QDpk9iyMhyFCRxtNjJ/zP/TvRfHb2OdD0qcJ/1JAzTnoOgfNM3xCzFPctgqGwue
	 L8+SF2tT4H4eSpNtXpXxMU+bNRLD8Xzl8iqinjLMVRSr6S2sp3byQHRmnwYTo7KUW7
	 kmxxHfvkZ3RRZsdbIMYRs/dCHkhHXH9zyAQon5ITiUQydqzoRNYCeoxvlXHUk5yYy7
	 X7vTarw54Qlr+6m2JWENoD2RHHLghgCEYb4W2z0Cp3dLAHPMAw4JY/hy0PYdUilYqE
	 dQ6wXqZ4vr0zg==
From: Vinod Koul <vkoul@kernel.org>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Frank Li <Frank.Li@nxp.com>, imx@lists.linux.dev, 
 dmaengine@vger.kernel.org
In-Reply-To: <20260226051220.548566-1-rdunlap@infradead.org>
References: <20260226051220.548566-1-rdunlap@infradead.org>
Subject: Re: [PATCH] dmaengine: fsl-edma: fix all kernel-doc warnings
Message-Id: <177215859616.232003.14692353574886302614.b4-ty@kernel.org>
Date: Fri, 27 Feb 2026 07:46:36 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9137-lists,dmaengine=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 94DB01B1EFE
X-Rspamd-Action: no action


On Wed, 25 Feb 2026 21:12:20 -0800, Randy Dunlap wrote:
> Use the correct kernel-doc format and struct member names to eliminate
> these kernel-doc warnings:
> 
> Warning: include/linux/platform_data/dma-mcf-edma.h:35 struct member
>  'dma_channels' not described in 'mcf_edma_platform_data'
> Warning: include/linux/platform_data/dma-mcf-edma.h:35 struct member
>  'slave_map' not described in 'mcf_edma_platform_data'
> Warning: include/linux/platform_data/dma-mcf-edma.h:35 struct member
>  'slavecnt' not described in 'mcf_edma_platform_data'
> 
> [...]

Applied, thanks!

[1/1] dmaengine: fsl-edma: fix all kernel-doc warnings
      commit: c8e9b1d9febc83ee94944695a07cfd40a1b29743

Best regards,
-- 
~Vinod



