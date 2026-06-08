Return-Path: <dmaengine+bounces-11316-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KOaPLECzJmqJbQIAu9opvQ
	(envelope-from <dmaengine+bounces-11316-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 14:19:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DB9656120
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 14:19:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=b7dSrJAS;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11316-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11316-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8CBFC3073495
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2026 12:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710FE37A496;
	Mon,  8 Jun 2026 12:13:17 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CA537B3FE;
	Mon,  8 Jun 2026 12:13:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920797; cv=none; b=V2xKwGX/XRyuSYVKGrIke5DIiBf5orP52FaKGxz6KHGiZmOBXAFLMAQfh+WBu6xlsUP7Oa0BC23xhQn5COvljXlanq7VW9JJHoTotLxkzgRMz5B+XnFBOBweBd+nVYhy7anr1QAxIGk/vRjYkFHUNhPV7b+ahRFK3dGVzrda0/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920797; c=relaxed/simple;
	bh=L+zr77B027OHlzOwUjS9LRDnJMeSuc4x34wWiodYnRA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BY6VlzTqBzoLBtG4Fbuno4KTIhwOKXCEVMzyACSAq7M13ZaAvntjKifyCHzG35doI9JSULwR4IM9akd+uteE2DzcRq3rLxerhBNQHxTpTY9uw4iF0ztVfFmXQSmCSd46YXH850bcXQC7IPGX9+cjb3aS7vTrjSh9gomzI107f+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7dSrJAS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A0E1F00898;
	Mon,  8 Jun 2026 12:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780920796;
	bh=9nvjedUpTUX47NUQgMQks1dJGD4zXZNRmKkqCVNTyb4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=b7dSrJASSbMXmLXFUuDpjV5mh5hGSDL0FqlbLGdOHUznaljCvXT3dIphbTDpkUyon
	 hC9KoKnOZtFtGDzRAAwnYlOWSahreRNUffg/CQWCCWdwZbNaY3oo9wN3EzSDWujZTG
	 Wk3gO4py4c4AMxNQ7ELNIfhCvaCsj7ptt0hU2K8tzvMNQEBBDtGC3boHIWx1/hf72s
	 WLe/ZxNdScMmDcJfHpgdbzJk8RnC+D/Eor0/rPUPv8aVQSxYGhbEkJmH0SGTQ/yBE/
	 RLn6cQaMCfCF083dx2Y+/iLA3CawU+Uck7xZhaD/D2eEBjtDZpfxkfqvRLJtxL4sgh
	 x+S2+PQ4cx6BQ==
From: Vinod Koul <vkoul@kernel.org>
To: tglx@kernel.org, John Madieu <john.madieu.xa@bp.renesas.com>
Cc: Frank.Li@kernel.org, claudiu.beznea.uj@bp.renesas.com, 
 biju.das.jz@bp.renesas.com, geert+renesas@glider.be, 
 cosmin-gabriel.tanislav.xa@renesas.com, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, john.madieu@gmail.com
In-Reply-To: <20260525110750.4020112-1-john.madieu.xa@bp.renesas.com>
References: <20260525110750.4020112-1-john.madieu.xa@bp.renesas.com>
Subject: Re: [PATCH v4 0/2] Add DMA ACK signal routing for RZ/V2H family
Message-Id: <178092079307.96550.9925462090761726451.b4-ty@kernel.org>
Date: Mon, 08 Jun 2026 17:43:13 +0530
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,bp.renesas.com,glider.be,renesas.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-11316-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:tglx@kernel.org,m:john.madieu.xa@bp.renesas.com,m:Frank.Li@kernel.org,m:claudiu.beznea.uj@bp.renesas.com,m:biju.das.jz@bp.renesas.com,m:geert+renesas@glider.be,m:cosmin-gabriel.tanislav.xa@renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:john.madieu@gmail.com,m:geert@glider.be,m:johnmadieu@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 56DB9656120


On Mon, 25 May 2026 11:07:48 +0000, John Madieu wrote:
> Some peripherals on RZ/V2H, RZ/V2N, and RZ/G3E SoCs require explicit
> DMA ACK signal routing through the ICU for level-based DMA handshaking.
> 
> Rather than encoding the ACK signal number as a second DMA specifier
> cell, derive it in-driver from the MID/RID request number using
> arithmetic formulas based on ICU Table 4.6-28 (3 linear peripheral
> groups). It must also be noted that DMA ack register is located in
> the ICU block
> 
> [...]

Applied, thanks!

[1/2] irqchip/renesas-rzv2h: Add DMA ACK signal routing support
      commit: 5d596b9139f59ce412f41283baadaf809936eaf4
[2/2] dma: sh: rz-dmac: Add DMA ACK signal routing support
      commit: c0a207898fca8cbb4fad0da1e950d477b6afbf64

Best regards,
-- 
~Vinod



