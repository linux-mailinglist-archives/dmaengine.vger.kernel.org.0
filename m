Return-Path: <dmaengine+bounces-9336-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePRPKut7rmnoFAIAu9opvQ
	(envelope-from <dmaengine+bounces-9336-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 08:51:07 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5262350AD
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 08:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F1E53075FB1
	for <lists+dmaengine@lfdr.de>; Mon,  9 Mar 2026 07:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF2F369972;
	Mon,  9 Mar 2026 07:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6u0Ja0L"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC7D366DAE;
	Mon,  9 Mar 2026 07:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773042396; cv=none; b=RrjaaE1XMEvDiHgJTIbUjd8QJVt0ms096OSdWBqG9ovAIjBNjfNLwDJB+xrpgocVbLWqNAdLDjLoGjtzwZjWuiHhTxCm3/g+08+n/AmIn8IcZo5odaD/cfx2EUHlGqClxImH6zJO+6Lt7QMnE2tFOFHOClGEJcKtzuKPoc2VtQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773042396; c=relaxed/simple;
	bh=m2SaN8A3RBM347mWSKYqqP47NQYZJFN9mp10kpsr5Wc=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BGNrtpORuh3sXx7foOkIbYIU/l/7b+t1rsLXiv/JJTYHcUm+XasB7B6MsYoF7gsipkziKc2AksU2zONAmhfWzkqh8lkCeD618fEvfXdfkqSRtDx/6um1l5dJP2wleSrt6e4hDQIijYgcmWjmDodLkmiaysJN8Yif8aUQE1P5OxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6u0Ja0L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09CDC19423;
	Mon,  9 Mar 2026 07:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773042396;
	bh=m2SaN8A3RBM347mWSKYqqP47NQYZJFN9mp10kpsr5Wc=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=T6u0Ja0LOm5BruFmSmhMWpl73E6wPIrs9hXGnngAVnXQjSMXDyQ44RvhwljprHLqS
	 cOp1qVK8cUtBdy4LH0YC7XANGzzQfkXL36QuNaRGhXgjNw+rma3pjqFrdQqVxHYE5y
	 Am6x8g4tOnhC7JlXZZ2AfV8pimTQGvVaJ0JWhhBJ6b4mtKr0uz3XLmeiLAGI1pOcpi
	 xNxyAV40QJJAhF8CwXJAK0x3yYJlQkCX28ylqVMuF8T2vS5PSi+5YwxzkECnLkbdYB
	 LMFv7jv7gx34CucrV65voQFmb0g3u2RpC7rrkTl24NMlpebu4t7nqR6taCsOTOe6js
	 d3C6qWtefwyUg==
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@kernel.org>, Michal Simek <michal.simek@amd.com>, 
 dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260301142158.90319-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260301142158.90319-2-krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH RESEND] dmaengine: xilinx: Simplify with scoped for
 each OF child loop
Message-Id: <177304239444.87946.18235295282294405962.b4-ty@kernel.org>
Date: Mon, 09 Mar 2026 08:46:34 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: 3F5262350AD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9336-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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


On Sun, 01 Mar 2026 15:21:59 +0100, Krzysztof Kozlowski wrote:
> Use scoped for-each loop when iterating over device nodes to make code a
> bit simpler.
> 
> 

Applied, thanks!

[1/1] dmaengine: xilinx: Simplify with scoped for each OF child loop
      commit: fe8a56f098fb87dd489666d6e9d6498be73a92e6

Best regards,
-- 
~Vinod



