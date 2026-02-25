Return-Path: <dmaengine+bounces-9071-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QK9kFejbnmltXgQAu9opvQ
	(envelope-from <dmaengine+bounces-9071-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 12:24:24 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DEF19667F
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 12:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1D583138793
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 11:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C923939AB;
	Wed, 25 Feb 2026 11:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvxv9rSH"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E98F34D90E;
	Wed, 25 Feb 2026 11:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772018465; cv=none; b=ZZr8oG7ReED2K6/oqrVDyfUr+mjZfPzUyFW2FC/MriVjp0jh7pZ+pfcGrBOrQeS99OOqJIxHyVyRH0a8zSqAvj9IU0D+2TnowOQh33OMXe8B70lmbcys1IX/srPGc3X1oqdxQGJdSfp01sHDJBSCZVHbVJ3KR1TqZS/EmHiDo9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772018465; c=relaxed/simple;
	bh=AmCYlej32XAQrepiFZ4ECy3MKukyZMvUqQfMMmDgCcU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O/09sUmpqm4i7pCFKUCXQZR6HWaoZbGk6OpVpo0E28FaZrtkWWZKu7rmqaHF/Tt7TPipOo5tRyCp9omZnbY/XSvLiKc94Nu3IyNBYaZkuisYRpUzYKDdnRUMm5ofUSz6QICIzyGDkh3s+11WNairZTqDZaS+3aPlT9Cy1T/tZIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvxv9rSH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42F2C116D0;
	Wed, 25 Feb 2026 11:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772018465;
	bh=AmCYlej32XAQrepiFZ4ECy3MKukyZMvUqQfMMmDgCcU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kvxv9rSHp5M5gZt4yERFo9uosBn6SzL1BPspJGHWfWLHzUrLL1YuSJxaQLcxrAAWw
	 OSYEw8IM4t5Htk9qMeMSemcsI+h0+1Rr1dVkh5qvjhExi4XQ07FH1ZVmgFVYE/IqPG
	 6a7DW83ZE4/0yaCwdY7LqrrmTmnMC/4LobuGsg1LXLZLVabDDN/YofQTQG0eKqs9Gp
	 lQgySBAluAw8RVXhhrm5jYqsTbM76gEoI+s0q+6sPfNEvp2t/1xd9a6pefrfAzJai9
	 j96QJx9AEkj212yPuYbomL/w1tWziCONThj1pr3oN+ggo8gC2Bzw4xw+7RlCg3u9h4
	 vko7W+PocjwfQ==
From: Vinod Koul <vkoul@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260121-idxd-fix-flr-on-kernel-queues-v3-v3-0-7ed70658a9d1@intel.com>
References: <20260121-idxd-fix-flr-on-kernel-queues-v3-v3-0-7ed70658a9d1@intel.com>
Subject: Re: [PATCH v3 00/10] dmaengine: idxd: Memory leak and FLR fixes
Message-Id: <177201846330.86127.3476679815425272928.b4-ty@kernel.org>
Date: Wed, 25 Feb 2026 16:51:03 +0530
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9071-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: A4DEF19667F
X-Rspamd-Action: no action


On Wed, 21 Jan 2026 10:34:26 -0800, Vinicius Costa Gomes wrote:
> During testing some not so happy code paths in a debugging (lockdep,
> kmemleak, etc) kernel, found a few issues.
> 
> No code changes, just rebased against 'dmaengine/next'. The cover
> letter was edited to remove not helpful text.
> 
> Cheers,
> 
> [...]

Applied, thanks!

[01/10] dmaengine: idxd: Fix lockdep warnings when calling idxd_device_config()
        commit: caf91cdf2de8b7134749d32cd4ae5520b108abb7
[02/10] dmaengine: idxd: Fix crash when the event log is disabled
        commit: 52d2edea0d63c935e82631e4b9e4a94eccf97b5b
[03/10] dmaengine: idxd: Fix possible invalid memory access after FLR
        commit: d6077df7b75d26e4edf98983836c05d00ebabd8d
[04/10] dmaengine: idxd: Flush kernel workqueues on Function Level Reset
        commit: f019d7814bceb6d8a017b3e55cb53deb1e6fd36b
[05/10] dmaengine: idxd: Flush all pending descriptors
        commit: 2a93f5747d0eef89a3158c91d185d37d0bca2491
[06/10] dmaengine: idxd: Wait for submitted operations on .device_synchronize()
        commit: 4fd3c4679f4f33873d7cb90b3eb553bea4db1038
[07/10] dmaengine: idxd: Fix not releasing workqueue on .release()
        commit: 3d33de353b1ff9023d5ec73b9becf80ea87af695
[08/10] dmaengine: idxd: Fix memory leak when a wq is reset
        commit: d9cfb5193a047a92a4d3c0e91ea4cc87c8f7c478
[09/10] dmaengine: idxd: Fix freeing the allocated ida too late
        commit: c311f5e9248471a950f0a524c2fd736414d98900
[10/10] dmaengine: idxd: Fix leaking event log memory
        commit: ee66bc29578391c9b48523dc9119af67bd5c7c0f

Best regards,
-- 
~Vinod



