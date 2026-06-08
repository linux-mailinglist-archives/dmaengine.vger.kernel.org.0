Return-Path: <dmaengine+bounces-11310-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WRfqC7GyJmpdbQIAu9opvQ
	(envelope-from <dmaengine+bounces-11310-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 14:16:49 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 974C96560C2
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 14:16:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=o0xh0eMT;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11310-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11310-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5008F3046CD6
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2026 12:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E5D37646B;
	Mon,  8 Jun 2026 12:13:01 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9103783D1;
	Mon,  8 Jun 2026 12:13:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920781; cv=none; b=L7F9UdvnoiuwvmyPBwMFJSxBEKmqBcRnyRIxrWOTVQyJGEl+NPzYXzEsouz1R2kha/ew1++NjKL5jUhQVBKwvFhpSsvbOIJzep4fIv+V7gADsKF1uDnVgUeIddy6X1F53MVdruk6BfS5qCBLIeKr8+HzAQMAw/G8ua2k/I7+ED4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920781; c=relaxed/simple;
	bh=nwtc3RE8DgAKJOWQ3Uiri7Jsc1kGu1bDeaVVVDoUyL0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MpPlRve1tNZZ5gexml2ikveX/uM6xmtrGn+aRg8QbB7dOFpHGwborVDGEO8pq4yKq/Xn2IvmZaPJfDyvVqzPfooIIeslNugSVt6+1wX5QV1OF1Exgtbbg2QCsddC1tfPgSnCmLnNxNnj5vP6+7CpCP5xwLWMGq60BzAdGT2eexs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0xh0eMT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DBD11F00898;
	Mon,  8 Jun 2026 12:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780920780;
	bh=0vxDtjZ+UU7C96xeFiCYrDD6u0Vo2RHrNSoMOM3Lu/o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=o0xh0eMTMmCg3uethEwOpYv9/tFaCJq9rKJyDVASkH9PaE5KBfFG6ho4GhGUH4lL6
	 VwZWAPlY/JUuTfj+PLYfbwGipWW/P1PRVsW7V/wkF1mZ78w0zhj9VeGK+Jit3Q0HBG
	 w5DqmMFM2aAawIeK45Zcago0EpLvAjr9ow9pYzQU3U2LSMWKust5uIOwBdMncBksmJ
	 QPI2AG3Bshyww4bsCxLRCkr3EtOc+Og9TM5nsIAhWCSqwTLOp12V7CKqKGyR6TDOeY
	 fCntxUvBePr/3fjvPg/cR89UJ5GbyJZqPFyrqc9jI7+uz89wEDkmk5JOXc5Uiiy5iE
	 bsepg9GxgTAiQ==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260531020843.594892-1-rosenp@gmail.com>
References: <20260531020843.594892-1-rosenp@gmail.com>
Subject: Re: [PATCHv3] dmaengine: ste_dma40: turn d40_base phy_chans into a
 flexible array
Message-Id: <178092077785.96550.7037031640195557298.b4-ty@kernel.org>
Date: Mon, 08 Jun 2026 17:42:57 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:rosenp@gmail.com,m:linusw@kernel.org,m:Frank.Li@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11310-lists,dmaengine=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 974C96560C2


On Sat, 30 May 2026 19:08:43 -0700, Rosen Penev wrote:
> Convert the separately-offset phy_chans pointer to a C99 flexible array
> member at the end of struct d40_base, and switch the allocation to
> struct_size(). The log_chans and memcpy_chans slots continue to live
> in the same allocation immediately after phy_chans, indexed via
> base->log_chans. This removes the hand-rolled pointer fixup that
> recomputed phy_chans from base + ALIGN(sizeof(struct d40_base), 4).
> 
> [...]

Applied, thanks!

[1/1] dmaengine: ste_dma40: turn d40_base phy_chans into a flexible array
      commit: cc4fea19daeb0460fe3569e0a2d523f427b2bac1

Best regards,
-- 
~Vinod



