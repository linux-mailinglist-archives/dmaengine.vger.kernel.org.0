Return-Path: <dmaengine+bounces-9509-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cN4KHxKNumnSXgIAu9opvQ
	(envelope-from <dmaengine+bounces-9509-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 18 Mar 2026 12:31:30 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 292662BAD43
	for <lists+dmaengine@lfdr.de>; Wed, 18 Mar 2026 12:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAFC2315C7EF
	for <lists+dmaengine@lfdr.de>; Wed, 18 Mar 2026 11:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B973CD8C6;
	Wed, 18 Mar 2026 11:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aizp/nDn"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764FD3CD8B3;
	Wed, 18 Mar 2026 11:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773833262; cv=none; b=nhCh5u6D434Ilwlk9sKNfkJ6ukls+GC2Jn9xEDecViIz46EXV76yEJqlrqA+qHSKPVEUW4y9KJUPpCsJHKGTZotm5LnXuQOZwBXnzW41ST6iX2whtzORQnhsGloypEHuq6bCzrX3aG8yh4rXDBYtC4P+ctOfVOphsR47i2j8ask=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773833262; c=relaxed/simple;
	bh=Xgmj0ENYxt9SaAWEdyGP+9MzNqgFEFkdg1dWBj+Dhao=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qnXguj9KddL+mkdHaxNlRUrEOF9dAIUuApBjg/CdNB2Li9WhOhLHEq8M9QSsvxmFfxaPo0X/pxxBEe4Q3oafuU6vEtyY6gNlCFZroBer9c3tzRZ0lap+rONYBbnNczXPLA38SgsUa6/DJcw1A0xYL3JcyEbGGDGaayg3pd9GG0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aizp/nDn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5D8C19421;
	Wed, 18 Mar 2026 11:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773833261;
	bh=Xgmj0ENYxt9SaAWEdyGP+9MzNqgFEFkdg1dWBj+Dhao=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aizp/nDn6rZ0J/0s44N+8UnQXGAeeoWHeMeM0pUQLaY4ZUsw3rkJBN3D+QNzfMgo0
	 R0emIWcyZ6UuFfKRnWxn8jMfpYGj96b1RgIhw1hfWtpxzx1dAx4GwQz8T2VxnczwCT
	 Rpctj4fmzJrQxWcbqVzqzK6iVr/x0FWMt33ffiprxn3IdBv7LiwHLNh16sDa/Oa4GX
	 Qg7VAr43WbaEe+0V9hiE0HPr4LnWAt+3pjHQu4KyhWfnswvNgOUBf/ELcJtW8puy/3
	 SfDQQf97E6m+yXollhQ8R4JtlmR9bygqvKl/VueUqHv3TwR1JpQvW3cisbV3RPjmOG
	 upwcX5VGopRBg==
From: Vinod Koul <vkoul@kernel.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>, Frank Li <Frank.Li@kernel.org>, 
 dmaengine@vger.kernel.org, Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260317204631.120332-1-colin.i.king@gmail.com>
References: <20260317204631.120332-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] dmaengine: loongson: Fix spelling mistake
 "Looongson" -> "Looogson"
Message-Id: <177383325982.408483.14890778055704333842.b4-ty@kernel.org>
Date: Wed, 18 Mar 2026 16:57:39 +0530
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9509-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[loongson.cn,kernel.org,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 292662BAD43
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, 17 Mar 2026 20:46:31 +0000, Colin Ian King wrote:
> There are a couple of spelling mistakes, one in a comment block and
> one in a module description. Fix them.
> 
> 

Applied, thanks!

[1/1] dmaengine: loongson: Fix spelling mistake "Looongson" -> "Looogson"
      commit: 4a2759a3ae10bb2e6465cfb01c16d0620a1bc7ab

Best regards,
-- 
~Vinod



