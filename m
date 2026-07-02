Return-Path: <dmaengine+bounces-11985-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gxXqJuyNRmr7YQsAu9opvQ
	(envelope-from <dmaengine+bounces-11985-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 18:12:28 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E7E6F9FFD
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 18:12:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YVjNS9G9;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11985-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11985-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2B573118E23
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 16:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E35F31715D;
	Thu,  2 Jul 2026 16:03:50 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6278D3161A4;
	Thu,  2 Jul 2026 16:03:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783008230; cv=none; b=QusDJFiD6/o/lC8dHw0l3KFN55/n/7iS5P+hUdVnPU67bIOs5dXMsmBB3j6zBxchxkhgYLbEhwAVa2ZPa/TtPTIkMJirTBlGQxAYbdqVimhVffMsssUijaFrIryc2Tc6uKNxABgh5PsBFmapyQWSbTBYWJP7gggq+YTBsh5I/64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783008230; c=relaxed/simple;
	bh=JYg5ysdWFhPiKG5oQW3/CJhMcQ8XRUuITz8PCAg+EWw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aw3ty3uMEFWFpgKH04zYWd2PeOsjQjEJIHY6htI6wLRdf1TlS96WcKT/CuPWa3kZ/hT3h2Sbk/sUvx4OQa161HxRCALVg/okKhVgZqp3b90NF0Sm4Zx3rVcnh9N9y+1ZORdx5gNI/1TMYr8dqVOszj0gtTxRp8MUgxwQi2nTRjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVjNS9G9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADFB71F00A3A;
	Thu,  2 Jul 2026 16:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783008229;
	bh=UtNd6BSHdRaL0Wa1rIKAQuRLmED7YnoMHeDT0+9L1os=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=YVjNS9G9IcSAAFNX7IuV/uQMIz74W5Vz5r3Ondup6k/Ze9BrwqgCXPAJE0/Whc5Bd
	 oc0DhkAPFmuwawqja0ZY9D2/nW/3FLynz8BBGDnP3SfzV+OQ61/4POGaYdfxW21aFt
	 ru27hIJ5csE+s2Uv+FvarXZP/yvBYUFED2E/1O0SeK014fZ99f8b7a0rK3FWe7XTTq
	 tbazRlxXn4wCTb9RJA8Dol2r+qpTGNkThydlUkP/9/oejjfh6R2xlFJp8b+cbX58WH
	 1hcDep6PFJgKFiZcBYQHZuMG5JW9GxJgrlncXGfMut0v+uFVgw967kRf0NcSQBUZFA
	 VFEENUyobEmVA==
From: Vinod Koul <vkoul@kernel.org>
To: Frank.Li@kernel.org, michal.simek@amd.com, abin.joseph@amd.com, 
 kees@kernel.org, ptsm@linux.microsoft.com, sakari.ailus@linux.intel.com, 
 radhey.shyam.pandey@amd.com, u.kleine-koenig@pengutronix.de, 
 Golla Nagendra <nagendra.golla@amd.com>
Cc: git@amd.com, dmaengine@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260630064844.705173-1-nagendra.golla@amd.com>
References: <20260630064844.705173-1-nagendra.golla@amd.com>
Subject: Re: [PATCH 0/2] dmaengine: zynqmp_dma: fix race between runtime PM
 and device removal
Message-Id: <178300822534.756665.17882853364669506909.b4-ty@kernel.org>
Date: Thu, 02 Jul 2026 21:33:45 +0530
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
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@kernel.org,m:michal.simek@amd.com,m:abin.joseph@amd.com,m:kees@kernel.org,m:ptsm@linux.microsoft.com,m:sakari.ailus@linux.intel.com,m:radhey.shyam.pandey@amd.com,m:u.kleine-koenig@pengutronix.de,m:nagendra.golla@amd.com,m:git@amd.com,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-11985-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 06E7E6F9FFD


On Tue, 30 Jun 2026 12:18:42 +0530, Golla Nagendra wrote:
> This patch series addresses two issues in the zynqmp_dma_remove() function:
> 
> 1. Fix the race condition between runtime PM and device removal where
>    pm_runtime_disable() was called after the power state check, leaving
>    a window for the runtime PM framework to change state unexpectedly.
> 
> 2. Update the stale kernel doc comment that still references a return
>    value after the function was converted to return void.
> 
> [...]

Applied, thanks!

[1/2] dmaengine: zynqmp_dma: fix race between runtime PM and device removal
      commit: 516ba2d8b7aac4238f9fcbd58579c43c71b9b695
[2/2] dmaengine: zynqmp_dma: fix kernel doc for zynqmp_dma_remove()
      commit: f7e89cba18a1ca6462712ae459a88dd40537b693

Best regards,
-- 
~Vinod



