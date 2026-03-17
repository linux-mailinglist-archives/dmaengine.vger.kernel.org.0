Return-Path: <dmaengine+bounces-9473-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBCzLl07uWmvwAEAu9opvQ
	(envelope-from <dmaengine+bounces-9473-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 12:30:37 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C1F2A8C1B
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 12:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AA97305C4BD
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 11:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF84C2D9796;
	Tue, 17 Mar 2026 11:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrjSU1Cv"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92A53AC0F2;
	Tue, 17 Mar 2026 11:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773746900; cv=none; b=oPblUWsYCjsLoTelQrX8tsvDyNJcvH2Q3wjhai61WSdgJRK19hpBOBfHTDpOJnhMzojFXAnfT88Jd8FumAG62rwsRAYdoHaCDZqY7bOAMSHTI3DwpzUyZq3ddDqKD2vHU2PwOpY5r36Wr4G2Yl2C6G5eyfol3oAvMldypEEtbXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773746900; c=relaxed/simple;
	bh=gm69WwfLinaSeTV9M1kqb/vW93ky016wsJtLqMkXY14=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iQ4CmeW1EyP9Koq+/yBocObp62U1CZKDLlja7wq8b7yafCpdikvPwVF2erer/9tokqat+cO2TcTOe9aWKeumBMNrgo7rGSbuRWlvTfyWz2ZnW+Wc2hWwnFBIfi/EdfHzYGDZHHb8UxJ3wf34zoI0Oc+3WAq9Az5/bqfrFE0jC0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrjSU1Cv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 266E7C2BCAF;
	Tue, 17 Mar 2026 11:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773746900;
	bh=gm69WwfLinaSeTV9M1kqb/vW93ky016wsJtLqMkXY14=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LrjSU1CvYOKRvG3xCJd+idsKAB5bJI6C//Mn7neCCxyOcPccFgMpG9We40H4mFTDI
	 ltuGOQJvzxBoqBeHAs3GCD7jqf5yh40aIWDXZRggnqfjChsg0zBCc9RKoj006keS97
	 62ifl1xm6WTsdEiZA4+/VUaryfCSxyqjFMRFrkI++ROzqGlYlQgwCgw5rCpSzwwrwH
	 sVS7r8DtvYuSyHEnrChu5Borwd6oIc1l/OGwyGIE1fNEHni629coMIWZZY7VX6xCF7
	 8UySbhejpwk7CRDL08HyrZFkfpOLh4dBZQBzjOK95lHNHsNVAUVQLS40aW/Vr/WLsP
	 atGBb6HHARlcg==
From: Vinod Koul <vkoul@kernel.org>
To: Frank.Li@kernel.org, geert+renesas@glider.be, 
 biju.das.jz@bp.renesas.com, john.madieu.xa@bp.renesas.com, 
 prabhakar.mahadev-lad.rj@bp.renesas.com, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20260316133252.240348-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260316133252.240348-1-claudiu.beznea.uj@bp.renesas.com>
Subject: Re: (subset) [PATCH v10 0/8] dmaengine: sh: rz-dmac: Add tx_status
 and pause/resume support
Message-Id: <177374689778.337210.8395550725111879630.b4-ty@kernel.org>
Date: Tue, 17 Mar 2026 16:58:17 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9473-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 19C1F2A8C1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Mon, 16 Mar 2026 15:32:44 +0200, Claudiu Beznea wrote:
> Series adds tx_status and pause/resume support for the rz-dmac driver.
> Along with it were added fixes and improvements identified while working
> on the above mentioned enhancements.
> 
> Previous versions were addressed by Biju. The previous versions were
> posted here:
> 
> [...]

Applied, thanks!

[3/8] dmaengine: sh: rz-dmac: Drop read of CHCTRL register
      commit: be342fb7f2bb5f641419fef3109eaffd469b0d44
[4/8] dmaengine: sh: rz-dmac: Drop goto instruction and label
      commit: 7badd294fc82629378b153327c57b8ba453688c7
[5/8] dmaengine: sh: rz-dmac: Drop unnecessary local_irq_save() call
      commit: be25945d0ca3ac736c448b530c47e854c82a0343
[6/8] dmaengine: sh: rz-dmac: Use rz_lmdesc_setup() to invalidate descriptors
      commit: bfaa60be647842cece968769f208e57fa5dee594
[7/8] dmaengine: sh: rz-dmac: Add device_tx_status() callback
      commit: 21323b118c16d287355e6497e1098ce1ca348bd6
[8/8] dmaengine: sh: rz-dmac: Add device_{pause,resume}() callbacks
      commit: 44f991bd6e01bb6a3f78da98eafa6d2a72819a2f

Best regards,
-- 
~Vinod



