Return-Path: <dmaengine+bounces-9073-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBh/H6TcnmkTXgQAu9opvQ
	(envelope-from <dmaengine+bounces-9073-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 12:27:32 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C97A2196769
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 12:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A65643037E42
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 11:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FB5392C31;
	Wed, 25 Feb 2026 11:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8BgkpFf"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E608D342C9E;
	Wed, 25 Feb 2026 11:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772018640; cv=none; b=lwVG3/EUZ4lW/P/jx5lZBONsAuX0UnBV2aKyvdGzpsMTri1UNjzpZpo2efyfGsWwxz1w8jjdq3wYzNIFVuk27Cv2x5eMRakT9qqPCppKIfj86z+R6Bs7+ELXqIs66g5EdhX4tetnlK3mUc+ArtSiPztDAc4Tymz05aXlUWbY2mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772018640; c=relaxed/simple;
	bh=0xLzX36zRnWwlogWpkEJgvlKwLz7OftOtsX/zZ1Yi/A=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ojBkW00dSrxYwR6Oehr/PZ/feC9Yt1j25BCGdtIxLB+0pWm8+kcN5whY/zf69CCQwIo9lCS8qtHJ9SLtqSE8CnDaSI7ZzEPbADdXUEHXspz7gIxEAA4/oA0fMTR7pHI7PyqUVgj1OiNwKnC1G1Jx19KxCbuhOayM2PInZKSXEGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8BgkpFf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BEE6C116D0;
	Wed, 25 Feb 2026 11:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772018639;
	bh=0xLzX36zRnWwlogWpkEJgvlKwLz7OftOtsX/zZ1Yi/A=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=N8BgkpFfupY6lcKiHJ6NFYM2E4EU1L60Z5XVRV4Guwyv3VZdB3GXr2XM6xRkTtAq9
	 2IuEX/ovNE1u7f+1j+Pv0jCIKirBpe7Bd40n3ALPz43KZqJZ85jotKW1bR8bJAaxvb
	 3/Aa3hdlODy8V0JmRaKvt30jaAn+0MPA7abG7ni5009jBan+OGP40sOGS/o7VoQc+I
	 fChlTz2iIs2O7Bhyg+gMO1pzzsJ01l5zztySPkLqO5EcnV/8GHuCAHVQazpc4eXtD/
	 pJpOvG7sGSl+VaV2N/dUWkBbg03Hw5ZFSSque3oRAbFNEyIG9uyVH3BbD6J4a9jNiS
	 ciSkDmxh3qaHQ==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20251110085349.3414507-1-andriy.shevchenko@linux.intel.com>
References: <20251110085349.3414507-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 0/3] dmaengine: A little cleanup and refactoring
Message-Id: <177201863825.93331.10006318479586947991.b4-ty@kernel.org>
Date: Wed, 25 Feb 2026 16:53:58 +0530
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9073-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C97A2196769
X-Rspamd-Action: no action


On Mon, 10 Nov 2025 09:47:42 +0100, Andy Shevchenko wrote:
> This just a set of small almost ad-hoc cleanups and refactoring.
> Nothing special and nothing that changes behaviour.
> 
> Changelog v2:
> - dropped not very good (and not compilable) change (LKP)
> 
> Andy Shevchenko (3):
>   dmaengine: Refactor devm_dma_request_chan() for readability
>   dmaengine: Use device_match_of_node() helper
>   dmaengine: Sort headers alphabetically
> 
> [...]

Applied, thanks!

[1/3] dmaengine: Refactor devm_dma_request_chan() for readability
      commit: 4dd56ef8a26190f1735de9dddb854f175adbc6cd
[2/3] dmaengine: Use device_match_of_node() helper
      commit: db4709e19ba3d50ceeba9e01db373f672698ff1f
[3/3] dmaengine: Sort headers alphabetically
      commit: 9a07b4bb2c6019a8c585f48ee9b87fc843840e6e

Best regards,
-- 
~Vinod



