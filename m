Return-Path: <dmaengine+bounces-9332-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAP2Ob97rmnoFAIAu9opvQ
	(envelope-from <dmaengine+bounces-9332-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 08:50:23 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 990AA235074
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 08:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 176CD3069D45
	for <lists+dmaengine@lfdr.de>; Mon,  9 Mar 2026 07:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBF536A016;
	Mon,  9 Mar 2026 07:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Apu3b/a+"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98D836897D;
	Mon,  9 Mar 2026 07:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773042388; cv=none; b=cvSs2DlA/eG87Um8sa3vNOeXfzA3FXGOSW82N/clQ6cQ4nB78O15IteIkfYF0nHapLzkVHpiFt9PjLz1LqKIVQoqhtzyx8JBsp4xIAT2smQM2dJGQfa63+8/9VqH07B2sQ+Q7Yqzeo6+wSwPcb/EZoSOdaYvmWtUkq/vHblQVB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773042388; c=relaxed/simple;
	bh=iwUlxC4sI4L/1Bt81ev07M3Jllw/0mil1MXgWHdhGwM=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sKTli0gpvPZvQHMHuEsfyvaa2hLWo6wOF9ksWBxHi1tj64oQWqhZQFksgyTIUpaysvR6MhDTR6FV+bIUPNbzLFkO2lXCS1f6pXx0xGSl++mgCh12PupvUQtUJrE6s767qUnYGNEhfmRlUEs8FK4laBRwywLenZzZUpNaP2oRtNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Apu3b/a+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A935C4CEF7;
	Mon,  9 Mar 2026 07:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773042388;
	bh=iwUlxC4sI4L/1Bt81ev07M3Jllw/0mil1MXgWHdhGwM=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=Apu3b/a+dVdHUhfrPdcCVL105BrCwJ+D0wYJTE0ibN2b4+FF61w1wYMIeAAWMdp51
	 sDWOM3d24GXynPma/1wci55PefXmawfiGebrcOZr/VwRQjcWBpS9ua6InwgGzGINwS
	 McntL7v+mrSkhkeRFByTj6qXBjLitr7QZJKcaCyya0XQFmzQNDbs0jfjw2rn6h9V35
	 nFyBqaACd8JcT2baURjT3Jn70nMp/IQVLV2pRwc8dwc4Aer2+hVd3lf3tOIELEHQH0
	 XFd9HYtmufqxdcSOXJaYgmrp7C2GTzcwzu0eyiClPd9DhVlHHCjpgIHEEbSgVY4sns
	 B9BpnJLRfbkPA==
From: Vinod Koul <vkoul@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michal Simek <michal.simek@amd.com>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20251224124531.208682-3-krzysztof.kozlowski@oss.qualcomm.com>
References: <20251224124531.208682-3-krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] dmaengine: axi-dmac: Simplify with scoped for each
 OF child loop
Message-Id: <177304238675.87946.17739384709818604272.b4-ty@kernel.org>
Date: Mon, 09 Mar 2026 08:46:26 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: 990AA235074
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9332-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.945];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


On Wed, 24 Dec 2025 13:45:32 +0100, Krzysztof Kozlowski wrote:
> Use scoped for-each loop when iterating over device nodes to make code a
> bit simpler.
> 
> 

Applied, thanks!

[1/2] dmaengine: axi-dmac: Simplify with scoped for each OF child loop
      (no commit info)
[2/2] dmaengine: xilinx: Simplify with scoped for each OF child loop
      commit: fe8a56f098fb87dd489666d6e9d6498be73a92e6

Best regards,
-- 
~Vinod



