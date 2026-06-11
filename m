Return-Path: <dmaengine+bounces-11443-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zLRvBu1MKmoAmgMAu9opvQ
	(envelope-from <dmaengine+bounces-11443-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 07:51:41 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAB666EC99
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 07:51:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BU2PR8lh;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11443-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-11443-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C5F5300D1C0
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 05:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D331303A04;
	Thu, 11 Jun 2026 05:51:38 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6733403E4;
	Thu, 11 Jun 2026 05:51:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781157098; cv=none; b=EGG9F3lF2VZIbs5QtfyNa7UPICpnNoKgp8RTXN8Qg69/5FMcxehnzyUbvhpWXlMx6gWlacIO+DWXIzcUEgLLw57WZu9QYTRdfziIiCEShA68M4bkVupl0Um/H9mRlztFUk00yfFWCJ3sGBVmPUB2vQ2o219iBQaz//C+H6ZJG0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781157098; c=relaxed/simple;
	bh=Rb/qUWrXJRMpInmR4X67RVAnFt1nl/S006r5TH3wamM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PYEoLVEGMjIHWxZ5+dvF/c/B18XSfYtKOxM9HS0RYlpbwlpIfiZKaFCnOBJqH9RBMXMWaNlXK3vM6u+qAJLbUD8Kq28rseez5tPvvJPgGBRaqLybjpiuHMvRxRkxyir3NRDrnlFAb0lHYYEQhZMcDNVH4VJsUzMKglgFmbL0gTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BU2PR8lh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF061F00899;
	Thu, 11 Jun 2026 05:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781157096;
	bh=sqxK62LKfv/ElL6iO+sr8Jcv2LCegaunlHS2uE77bKw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=BU2PR8lhDFtObrdPaHJPWX4CVFVPI7PoZ29yw4rL4Ks7Ywo35kF8ZbAe395qBG6mb
	 6WLvuto6sDhNX9ydOXJklbvfwrdT63W1nrfldlfqlQvyZ0KgIHi6efRXIlfEgE6Tly
	 tECe0oHvUsU+WqC/famDeIGxCt3/L6bjP548/9wArubQhR8VLY3wJaztgPbe9tX/X4
	 4RfftrigZnS2qdnNZLpQOIIDYoyr8SlvZ76pSDHY9GqOKAxOdZ84QvMw1nIcaHEgxy
	 dj8EXthVfh+4vfMgRau/GCJIhTMBAVA9JJcuRV4ITIh5h8WRUwo587VwQtxC2cE+Z4
	 oxECcL3sVvI/Q==
From: Vinod Koul <vkoul@kernel.org>
To: mani@kernel.org, Frank.Li@kernel.org, 
 Devendra K Verma <devendra.verma@amd.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 michal.simek@amd.com
In-Reply-To: <20260608102452.3255808-1-devendra.verma@amd.com>
References: <20260608102452.3255808-1-devendra.verma@amd.com>
Subject: Re: [PATCH RESEND v2] dmaengine: dw-edma: Remove
 dw_edma_add_irq_mask()
Message-Id: <178115709406.468137.3949764388151149667.b4-ty@kernel.org>
Date: Thu, 11 Jun 2026 11:21:34 +0530
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:Frank.Li@kernel.org,m:devendra.verma@amd.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michal.simek@amd.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-11443-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AFAB666EC99


On Mon, 08 Jun 2026 15:54:52 +0530, Devendra K Verma wrote:
> Function dw_edma_add_irq_mask() sets the mask of the
> interrupts alloted to read / write channels in a variable.
> The mask set for read / write channels is niether used nor
> this function is called else where, making it redundant.
> The redundant function can be removed safely as it is
> not affecting anything.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: dw-edma: Remove dw_edma_add_irq_mask()
      commit: 57e766bd3ddb2495d80952ad4fc723fb538e1d43

Best regards,
-- 
~Vinod



