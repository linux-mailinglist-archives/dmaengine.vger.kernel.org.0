Return-Path: <dmaengine+bounces-9335-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHGbBPd6rmndFAIAu9opvQ
	(envelope-from <dmaengine+bounces-9335-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 08:47:03 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B70DE234F8C
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 08:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 111B4302C761
	for <lists+dmaengine@lfdr.de>; Mon,  9 Mar 2026 07:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6986E36A01B;
	Mon,  9 Mar 2026 07:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3veRzR+"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4749236997D
	for <dmaengine@vger.kernel.org>; Mon,  9 Mar 2026 07:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773042394; cv=none; b=Y5x6uo2fJ4eJKhZPS+rWHGlXldRwmlXbYqvm60gcyS+++Ych+CBvKh5Rn5HCxrlKLc32edFjEABUrCECZVPNc61kBNXIq9FpFsiYM0nbMznE2cp5UclFwnE1bOubLj+YT4++YlVx4P2jyAotYf8mof2j2KtYaLzUCx4bZOb9cMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773042394; c=relaxed/simple;
	bh=SCIZl1Nx3WI7nZ4zRZqNNM53eFK+Vp48iJcdHuu6Mfg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AHuCwx0sP5W0fL2JNkoeDBrVtiCTV7h/l3B8qVADw5oUbcprsEOoRYkM5KdnP3DMP8FLmA9WxL01KjeRtULg102XnI0eKO9HJN4vkspPkK94nAwNRgEKhgJ3LQOry9G2EMxsAAilHVQd5yTrwjCz46wbYsRXNK62xfgLjX1KIM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3veRzR+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2479C2BCB3;
	Mon,  9 Mar 2026 07:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773042394;
	bh=SCIZl1Nx3WI7nZ4zRZqNNM53eFK+Vp48iJcdHuu6Mfg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=L3veRzR++yejZmJoh+SoxJoXBbCUEgR6KHsO3n3vsPyRqyNbTcg9YDhmwZliM0dGN
	 2ioA8spIPU+eO7AGCt24R1GezWXlQM5s3Wa2nr5P6Tq9wzoKR3wr2j1B4qKWGo0mpb
	 T7HT/eVEAG0o3J1YaNPax7s/K8Y72VsLorMbJcv5ebMqzBGqLzHDh3TKI2RJtjjD6x
	 iPopZ9e9/YGrmEpiIO3MLgbbJ4tz0wXrYGEGzSgxlyqM7yEzyFKQ0ishV1fn5Jy75Q
	 7IZBc+iGXbkzEjamT0TWEHZl7t2ih0R59BY1zK+QHeItoZgSeMQgVyDvNOLwCEocO4
	 +KEIhtdH7LcFQ==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>
Cc: Kelvin Cao <kelvin.cao@microchip.com>, 
 George Ge <George.Ge@microchip.com>, Christoph Hellwig <hch@infradead.org>, 
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20260302210419.3656-1-logang@deltatee.com>
References: <20260302210419.3656-1-logang@deltatee.com>
Subject: Re: [PATCH v14 0/3] Switchtec Switch DMA Engine Driver
Message-Id: <177304239251.87946.4543423653866080296.b4-ty@kernel.org>
Date: Mon, 09 Mar 2026 08:46:32 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: B70DE234F8C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9335-lists,dmaengine=lfdr.de];
	FREEMAIL_CC(0.00)[microchip.com,infradead.org,wanadoo.fr];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.975];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Action: no action


On Mon, 02 Mar 2026 14:04:16 -0700, Logan Gunthorpe wrote:
> This is v14 of the Switchtec Switch DMA Engine Driver.
> 
> The patchset has been rebased on v7.0-rc2.
> 
> We've addressed a number of issues pointed out by Vinod.
> We continue to push back on processing completions from the hardware
> in switchtec_dma_tx_status() seeing this is the only place to handle
> the completions if interrupts are disabled. A comment was added to
> the code to clarify this point.
> 
> [...]

Applied, thanks!

[1/3] dmaengine: switchtec-dma: Introduce Switchtec DMA engine skeleton
      commit: d9587042b50f69d35a6e05c1b7fc9092e26625a6
[2/3] dmaengine: switchtec-dma: Implement hardware initialization and cleanup
      commit: 30eba9df76adf1294e88214dbf9cea402fa7af37
[3/3] dmaengine: switchtec-dma: Implement descriptor submission
      commit: 3af11daeaeaa6f62494c7cb07265928162b440ab

Best regards,
-- 
~Vinod



