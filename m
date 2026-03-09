Return-Path: <dmaengine+bounces-9334-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HM0Ne96rmnoFAIAu9opvQ
	(envelope-from <dmaengine+bounces-9334-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 08:46:55 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE87234F85
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 08:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F9D33014762
	for <lists+dmaengine@lfdr.de>; Mon,  9 Mar 2026 07:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C540836A01B;
	Mon,  9 Mar 2026 07:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEOk1D4C"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32D5369997
	for <dmaengine@vger.kernel.org>; Mon,  9 Mar 2026 07:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773042392; cv=none; b=VKl85rAt4/yWjJeSca4mXvDouj9z+D70mHGulJ2F8+1++jmW228ETsSZBuChFsIqJAjDeYWnCfKC/XNio2z1KQ2rq9hHo3I2+EhndtSNBb1iNDoxm3mdjZ2hcd2mg/q9rUf1t32Dl+bIVxAFYXXbAl5n9wvqj4w6kdDxMwH/bUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773042392; c=relaxed/simple;
	bh=Ng7uC+b01KOLwR8VWeW1Rl2fjYOWa0hHhzIpkkIH++c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pwRk9iVoDPi0FOsFqfqfP46YCtCgLMXkvqfv9L/kIIetPNyfoXZ8PkMEcQc8WVPjtuyYdJbUu07Veznx5jepIdG+ET3euTRLB1LGSApmumqkeOeE9/fLVO9Yj7oHOqJnaHiekGjoYwI03kLuEapQTanb1RhcryhsQkNOPzXqR2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEOk1D4C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B16FC19423;
	Mon,  9 Mar 2026 07:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773042392;
	bh=Ng7uC+b01KOLwR8VWeW1Rl2fjYOWa0hHhzIpkkIH++c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GEOk1D4C17JI5dfTBrdn9Hd8at0aWZToQFmo6w2XoUiHB1QuA1XKyYskJRTB+c56X
	 1G46BoDLIgirCbBouiuEHYEEtt+ygo3pyKD1ysKsXOBkbx3niMwcQcjwoNPOb2AD9u
	 72lxp+pdqE0j1G3whHsfTT+CexwSeCMTYSAUhirCzIzOV9tGezAX4zL14JgnCl9Lem
	 h7sfz/+wMEe4TIM3NAgvyAnpNtHZexEFrNtoxMUtEsuMXk2BcNV+stX90i83FB5L1f
	 nWAel4/vUKxbJhWc9MWoYYSWE+AqY0Fmvc8gB3W6judPJEmICr1sGMwfF1rvTi+YWA
	 58W/8VXKI8mLg==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20260303-axi-dac-cyclic-support-v2-0-0db27b4be95a@analog.com>
References: <20260303-axi-dac-cyclic-support-v2-0-0db27b4be95a@analog.com>
Subject: Re: [PATCH v2 0/5] dmaengine: dma-axi-dmac: Add cyclic transfer
 support and graceful termination
Message-Id: <177304239096.87946.15531982345548560058.b4-ty@kernel.org>
Date: Mon, 09 Mar 2026 08:46:30 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: 4CE87234F85
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-9334-lists,dmaengine=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.945];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action


On Tue, 03 Mar 2026 10:24:59 +0000, Nuno Sá wrote:
> This series adds support for cyclic transfers in the .device_prep_peripheral_dma_vec()
> callback and implements graceful termination of cyclic transfers using the
> DMA_PREP_LOAD_EOT flag. Using DMA_PREP_REPEAT and DMA_PREP_LOAD_EOT is
> based on the discussion in [1].
> 
> Currently, the only way to stop a cyclic transfer is through brute force using
> .device_terminate_all(), which terminates all pending transfers. This series
> introduces a mechanism to gracefully terminate individual cyclic transfers when
> a new transfer flagged with DMA_PREP_LOAD_EOT is queued.
> 
> [...]

Applied, thanks!

[1/5] dmaengine: Document cyclic transfer for dmaengine_prep_peripheral_dma_vec()
      commit: 5f88899ec7531e1680b1003f32584d7da5922902
[2/5] dmaengine: dma-axi-dmac: Add cyclic transfers in .device_prep_peripheral_dma_vec()
      commit: ac85913ab71e0de9827b7f8f7fccb9f20943c02f
[3/5] dmaengine: dma-axi-dmac: Add helper for getting next desc
      commit: c60990ba1fb2a6c1ff2789e610aa130f3047a2ff
[4/5] dmaengine: dma-axi-dmac: Gracefully terminate SW cyclic transfers
      commit: ca3bf200dea50fada92ec371e9e294b18a589676
[5/5] dmaengine: dma-axi-dmac: Gracefully terminate HW cyclic transfers
      commit: f1d201e7e4e7646e55ce4946f0adec4b035ffb4b

Best regards,
-- 
~Vinod



