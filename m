Return-Path: <dmaengine+bounces-8815-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Hf1JTtth2lVXwQAu9opvQ
	(envelope-from <dmaengine+bounces-8815-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 07 Feb 2026 17:50:03 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 277F01068F0
	for <lists+dmaengine@lfdr.de>; Sat, 07 Feb 2026 17:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85D793018BD7
	for <lists+dmaengine@lfdr.de>; Sat,  7 Feb 2026 16:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AF0337686;
	Sat,  7 Feb 2026 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUMX4Ayx"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705F72367D1;
	Sat,  7 Feb 2026 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770482998; cv=none; b=iNvN89XI4kFRKYgFfq2NfJLQrS9/wxIQH4PTs5l6Wvx+iq1ZHV3QCHv6pzi2PHy3ssgY7X5qDOd296AmRQitzAUJBvJbozPeDdtkna177UDzFHTakCHV+tGEbOHBn2ULwIzEnWfHiCeOHQfP7dJSGTQxwnXUsD2vKAw7jcvlwRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770482998; c=relaxed/simple;
	bh=cMrd0H0Y8lTk1Uw39PbbAGK2uNp3ZjB9nex83KwWNYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCd9IOtsdPfOT4wUG9+m1q6YSOT2kGsWV19rPU9PABXVZS3QUEcRwdgHQUKdHOQv1hG0Tv4e6T6BVt9kmz3dtxlIQuDRoHVAi1wK5fzBkJ/E4Lj1yw4BLdEgmsupZ0ibcclMac1JhIneyxuQZqaOvk4YeJpPzPh/1CJzvSswhUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUMX4Ayx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2EFCC116D0;
	Sat,  7 Feb 2026 16:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770482998;
	bh=cMrd0H0Y8lTk1Uw39PbbAGK2uNp3ZjB9nex83KwWNYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NUMX4AyxGjqx9ekuxGKmNTYcOnGPH6zQpM7e5kC+q/d4f6iBMzl/78bJDJhMisIGb
	 0G0vATjZQ0p5h+3TpK3HOBRpWiT57gVGqHS+dZtiJp9YPfkG/eoy0MFM8XDdSoDwNk
	 AyYseCtYsmv33JP5am7AHdZr1vaynYkxhOBnVVsSZFAKEZNIvuRgxo41aDy7zYI/uo
	 eYYu8ux8kgWjQuUjekL8uwRPnnHZlNCR+frE9q8p0e+6tfHaY6+A7VB0V4WmiNSOPw
	 zR86XiTH8kA6RRBVum8VuXb2ngMj9Q3p3Xwf58+7E1hQPWQboBnsZlxIJhomI5Cj8T
	 OMshkvP39FJMQ==
Date: Sat, 7 Feb 2026 06:49:56 -1000
From: Tejun Heo <tj@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Pat Somaru <patso@likewhatevs.io>, Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma: plx_dma: Convert from tasklet to BH workqueue
Message-ID: <aYdtNHiE2wGp55cZ@slm.duckdns.org>
References: <20260206090058.1127675-1-patso@likewhatevs.io>
 <829601a5-f39e-43a1-bec5-80195a8833da@deltatee.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <829601a5-f39e-43a1-bec5-80195a8833da@deltatee.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8815-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,likewhatevs.io:email]
X-Rspamd-Queue-Id: 277F01068F0
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 11:43:59AM -0700, Logan Gunthorpe wrote:
> > Signed-off-by: Pat Somaru <patso@likewhatevs.io>
> 
> Looks good to me, thanks!
> 
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

How do you want to route the patch? I can take it through the wq tree if
that's preferable.

Thanks.

-- 
tejun

