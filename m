Return-Path: <dmaengine+bounces-9345-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKsgAPOyrmkSHwIAu9opvQ
	(envelope-from <dmaengine+bounces-9345-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 12:45:55 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B92DA2381EE
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 12:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB964303EFC2
	for <lists+dmaengine@lfdr.de>; Mon,  9 Mar 2026 11:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660343A4F36;
	Mon,  9 Mar 2026 11:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llbsDlps"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414B53A4F28;
	Mon,  9 Mar 2026 11:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773056502; cv=none; b=dBl6cX5PVPBIvoDZZgrroL0g3skUcmQGgGdBcdKkSjJnsGfKD0Yyr4V/aIwyQ4R0gnu1EwTODGqJYQSVUtbuVxNjWWTD7/yZDnklJh8x3SdkkeoY+0W4+BhZb0QV26v4we2uQHgPt/2YVPtZs80N+46+vI8jyp3AZyC8kKLLnrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773056502; c=relaxed/simple;
	bh=RxWsCee+ZoiR0GYYb2EJoVKT0M/8XIcfta/6B0inB1Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IytiuHV4BeVlRoAKi4/+8Whv0NA/cQ8dwbznqfkGIryZh+f/sWeFFUkN4KZh6+WalYAxRO+UQoBD3q2S18BQn87PO91Z9MKfQsXIGyuvMG4AZY53QC3v4oNfrREdUY0t62N53JXhlbDfPELFtwFlSEyTXKL6h7dI6jUMK8UW4T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llbsDlps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F58C4CEF7;
	Mon,  9 Mar 2026 11:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773056502;
	bh=RxWsCee+ZoiR0GYYb2EJoVKT0M/8XIcfta/6B0inB1Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=llbsDlpsSEsEyFVLHHSLt0Fh6pbwzuusbkBxTky+Gv88z9TSgtVilx9rjDN77D7WN
	 OXc5AXi03L3C2gpskdFgVdOx2JOmMF/VOtb4rhkkrFpmHdIkHiKsgtsOrnOqUQ/BFM
	 dMpZcP6P9HNk6U7Uh6866DT19TXyVoSCIFSoq4NcIOWdg/65oRtma+k9S2aeeMbtUd
	 T32NwvweUOx8SOUMNdnXkAD2JtBIywy6wF3ftO6ybFIgz5YuxUkQJeRsxfnPxfgDfH
	 9/ruTeGsEsDmYpWuFTF7ZUnnxN0+u36WHFmzXqFcZRdbKIJ3UWcWH3SKg5DO7djec/
	 KIfZxnrRo0HCQ==
From: Vinod Koul <vkoul@kernel.org>
To: vinicius.gomes@intel.com, dave.jiang@intel.com, 
 Tuo Li <islituo@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260106032428.162445-1-islituo@gmail.com>
References: <20260106032428.162445-1-islituo@gmail.com>
Subject: Re: [PATCH] dmaengine: idxd: fix possible wrong descriptor
 completion in llist_abort_desc()
Message-Id: <177305650060.108803.7377537408886763261.b4-ty@kernel.org>
Date: Mon, 09 Mar 2026 12:41:40 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: B92DA2381EE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[intel.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9345-lists,dmaengine=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.937];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action


On Tue, 06 Jan 2026 11:24:28 +0800, Tuo Li wrote:
> At the end of this function, d is the traversal cursor of flist, but the
> code completes found instead. This can lead to issues such as NULL pointer
> dereferences, double completion, or descriptor leaks.
> 
> Fix this by completing d instead of found in the final
> list_for_each_entry_safe() loop.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: idxd: fix possible wrong descriptor completion in llist_abort_desc()
      commit: e1c9866173c5f8521f2d0768547a01508cb9ff27

Best regards,
-- 
~Vinod



