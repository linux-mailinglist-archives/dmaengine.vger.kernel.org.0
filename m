Return-Path: <dmaengine+bounces-9069-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPmpLLDbnmkTXgQAu9opvQ
	(envelope-from <dmaengine+bounces-9069-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 12:23:28 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 191FF19663D
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 12:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5A7B3061765
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 11:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F90F34D90E;
	Wed, 25 Feb 2026 11:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJLGjn1i"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C364288C3F;
	Wed, 25 Feb 2026 11:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772018460; cv=none; b=BgSVjBa9ewbY/RGda3IksK8PvxvQ/VX/s7eCRUFpdetMxOD2TvEx7xbkB1d+Wf05A7Hi89s3m2t9SS7Ij74vnwu+i1vxi8Hug20ceUngfLsnux+Lb7DCRp+aQVG091walffMphGIqxng6tw6x6WtPCnDyDGBwjduv0iIi2zLl7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772018460; c=relaxed/simple;
	bh=PIWBI9xHwQPeXFfDMuUlC2Tm2esfZZ4bw/oW27XCZXo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=p3+KU2gV2qAksDtw8FzQ7iHJ4Ye6lffSlCOPX/lm09b5vM9t/u+6Ers2QoR6oVZ1pLZun/NMYnrmTfR8MA4JtdnfzCqxILIdYzmcfk0Nx5ku+rKPDjBOAcOd6Enqwt84+Y4fORZd3RI6QqvQuGmrxv7jbwUHlkYQxJklH0+CFVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJLGjn1i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C49C19421;
	Wed, 25 Feb 2026 11:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772018459;
	bh=PIWBI9xHwQPeXFfDMuUlC2Tm2esfZZ4bw/oW27XCZXo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hJLGjn1iIZZYJe2jBxBy8t8RHbdkwCk/4HLJbWFTZDsHETMxFIkvfo9eeG3kr2WxA
	 jfL9sTUhln9geF+wS/pCP9Pm31bV2twRtIQ/ubWb54Mx4IvgiLN/PpghNQPEVH313S
	 5f0jxg7Ixga0zh6tpBac4VFxzYaLnP8xnGAGS4Qm2jP4CFWfRfFfTj2zm3HPZ4SBD6
	 5tsJvN/NDqIoukEMoMnwc0Dd1fyQLyimxtzeVJb6E0sCEigTIPOPfJECMo9ndnRj3e
	 VVWc1Au0nsdNkd4nbw/JHlBB0NpDWJ3ZgS/ippN34mlC+XkkDpC0EwQ7uFASm7sQaR
	 s/f/NEwAO8kkg==
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@nxp.com>, Joy Zou <joy.zou@nxp.com>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20250917-b4-edma-chanconf-v1-1-886486e02e91@nxp.com>
References: <20250917-b4-edma-chanconf-v1-1-886486e02e91@nxp.com>
Subject: Re: [PATCH] dmaengine: fsl-edma: fix channel parameter config for
 fixed channel requests
Message-Id: <177201845784.86127.12049882833167858735.b4-ty@kernel.org>
Date: Wed, 25 Feb 2026 16:50:57 +0530
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9069-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 191FF19663D
X-Rspamd-Action: no action


On Wed, 17 Sep 2025 17:53:42 +0800, Joy Zou wrote:
> Configure only the requested channel when a fixed channel is specified
> to avoid modifying other channels unintentionally.
> 
> Fix parameter configuration when a fixed DMA channel is requested on
> i.MX9 AON domain and i.MX8QM/QXP/DXL platforms. When a client requests
> a fixed channel (e.g., channel 6), the driver traverses channels 0-5
> and may unintentionally modify their configuration if they are unused.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: fsl-edma: fix channel parameter config for fixed channel requests
      commit: 2e7b5cf72e51c9cf9c8b75190189c757df31ddd9

Best regards,
-- 
~Vinod



