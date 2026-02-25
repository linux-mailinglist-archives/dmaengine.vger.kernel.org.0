Return-Path: <dmaengine+bounces-9075-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELukJgbcnmkTXgQAu9opvQ
	(envelope-from <dmaengine+bounces-9075-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 12:24:54 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E24E1966B1
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 12:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 330633077F24
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 11:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100B7393DF4;
	Wed, 25 Feb 2026 11:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMDNcp35"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E065D392C31;
	Wed, 25 Feb 2026 11:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772018644; cv=none; b=tUeO+3th07e4PYnPaHBtTA2vUm80AnOGm21ZUo8xcQfrXhXK0lkoK+x47kGRMdNqGhErQ1n15laZChzlGbwrq8+6C6ivYierdRU2KuU3/Rb+xP7KZ8B+rELO13ktVRpgbomVUABBgTXSS+POL4OnN1FK81U9aTsXfKwzdmnDsMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772018644; c=relaxed/simple;
	bh=jSczoSALkEfviEOFlNuY2BWP6opjhQVAmR/wSSbgbXA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qT1adB77jszwlgwDovqb1pamtb0wro56i4tUp+5ouEQlc3oXATu6ly9MDUB7F0BppZhx8TuY2GGDHNuFSRDDRl+2FEN6y0Me9x97lmeGND338wH6TKyPjhnl7VVAErPkcrV4AYuj3+remu/5GoxlKY5yQaoMN/yieU7FEIWrjhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMDNcp35; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035ECC2BC86;
	Wed, 25 Feb 2026 11:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772018643;
	bh=jSczoSALkEfviEOFlNuY2BWP6opjhQVAmR/wSSbgbXA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MMDNcp35PyIZHa/T7kY59xi37MBZamkDY4l7byRJ6k9wIcDZYTJwaiRSsaE0NhHC2
	 kV5UGRqYEjy6bMLxuupB5epEh1/3o5Qdr1gQZiFK/i/ubrziSdXWwlnw3DLPI5LeRN
	 ks8ILCazpiorBCt4ySxW4SWxHdi3jdorKOsFbXKUREBY66izZsmWGyp30Ni/2IMs7C
	 a5H1dpOfP2QQJc6+eqWEm8DuvXACRz9MDAiK3THLT4abUWzhhgc5vVOosfvxQ0Ufn+
	 hC5wvYpxZmoAme2O7Bw8AB2mRWWWwWDKAIakFkf36DdeosCuiIb4N13cAmGu634Blh
	 OXs9n/p4MfyuA==
From: Vinod Koul <vkoul@kernel.org>
To: mani@kernel.org, Frank.Li@kernel.org, Koichiro Den <den@valinux.co.jp>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260215152216.3393561-1-den@valinux.co.jp>
References: <20260215152216.3393561-1-den@valinux.co.jp>
Subject: Re: [PATCH 0/2] dmaengine: dw-edma: Interrupt-emulation doorbell
 support
Message-Id: <177201864163.93331.15342236938596497444.b4-ty@kernel.org>
Date: Wed, 25 Feb 2026 16:54:01 +0530
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9075-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0E24E1966B1
X-Rspamd-Action: no action


On Mon, 16 Feb 2026 00:22:14 +0900, Koichiro Den wrote:
> Some DesignWare eDMA instances support "interrupt emulation", where a
> software write can assert the IRQ line without setting the normal
> DONE/ABORT status bits.
> 
> In the current mainline, on implementations that support interrupt
> emulation, writing once to DMA_{WRITE,READ}_INT_STATUS_OFF is sufficient
> to leave the level-triggered IRQ line asserted. Since the shared dw-edma
> IRQ handlers only look at DONE/ABORT bits and do not perform any
> deassertion sequence for interrupt emulation, the IRQ remains asserted
> and is eventually disabled by the generic IRQ layer:
> 
> [...]

Applied, thanks!

[1/2] dmaengine: dw-edma: Add interrupt-emulation hooks
      commit: 2e8726879559144b4582fa059780e452b3a1ad41
[2/2] dmaengine: dw-edma: Add virtual IRQ for interrupt-emulation doorbells
      commit: d9d5e1bdd18074ea27985c777ddc3a8a0b007468

Best regards,
-- 
~Vinod



