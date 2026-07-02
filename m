Return-Path: <dmaengine+bounces-11973-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yXcrJbyERmrzXgsAu9opvQ
	(envelope-from <dmaengine+bounces-11973-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 17:33:16 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE28B6F9749
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 17:33:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=U+PA7oFs;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11973-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11973-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5F05303902B
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 15:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F19381EB6;
	Thu,  2 Jul 2026 15:25:37 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B14381EBB;
	Thu,  2 Jul 2026 15:25:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783005936; cv=none; b=BVTHv3iJ2iCBXD4GAazQisyxrJQn0MqNYNQY7mD3a4IDBYeyDV2OKUfhR5NQe+Wq6vHhoecPcT2pmy8EDDabxKiOuxoesXz8BmG3x2VWqo2/gpXONPFm+cKdPm7UZPnjUfCGB69mtG+2ildzwBOMMP97MNLvUlRK5rSVvhCN7JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783005936; c=relaxed/simple;
	bh=9ASYut8spl8Qh5bkDmz43zcuqk6gnLCBKl9uOQJUUlk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IpkUdANj44Pc5ZEgBuhdQxLyPquTvZvTjYOcaHUe+e2FwCDqJ6ax8wlR0ofLA3LQo/xTk+Skjd2QMZdEFCoUrS+P2Vl8Bm81RB2muz+MeKcvy1CkLwi0BZPZ1MNj8O/uaitjKA/mCba3z3eGyrtSjkVrPy7mfYkHg1oU0F0tSWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+PA7oFs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7AAA1F000E9;
	Thu,  2 Jul 2026 15:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783005935;
	bh=MQ3Zpmn1pEDWxOx53vrT67yC5ECrhggWbRLJkRY00HE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=U+PA7oFs+IkYnmoxk+J/iLXdAMHlMXEsW4Gd92G91MPLp5V12xocqub70AzVtss1M
	 aS0AgTQfcUI5AWkuW4rcdG8j0pZS0paIo/c+J1SWVlrfxLDCCRYwo7ajp2iTzjFjD1
	 Qbh0oLq8qwTsYOFDpoPoFyMPLSJ55GiriAp8c2AS97vpzuR9VYXNNNY+hEGIFoLC+6
	 wOAl8UeIiX5p5YgFqJLJs7hzjXsszx9m9HleK3jycgfbOtTDuV9dGihGpm2LeHg+ZI
	 1LPI1rVwUHOMM8V48LlxeVIcvAmicUHIAm55uRt53oZG6IlsEJLgZpYjkt0cu5kekD
	 Tlf+4CzVl4sug==
From: Vinod Koul <vkoul@kernel.org>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
 Yuho Choi <dbgh9129@gmail.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Frank Li <Frank.Li@kernel.org>, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260525141550.1385581-1-dbgh9129@gmail.com>
References: <20260525141550.1385581-1-dbgh9129@gmail.com>
Subject: Re: [PATCH v3] dmaengine: idxd: fix fdev setup failure cleanup in
 idxd_cdev_open()
Message-Id: <178300593357.726714.5435920347978099252.b4-ty@kernel.org>
Date: Thu, 02 Jul 2026 20:55:33 +0530
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:vinicius.gomes@intel.com,m:dbgh9129@gmail.com,m:dave.jiang@intel.com,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[intel.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11973-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DE28B6F9749


On Mon, 25 May 2026 10:15:50 -0400, Yuho Choi wrote:
> The failed_dev_add and failed_dev_name paths drop the file-device
> reference while wq->wq_lock is still held. If put_device(fdev) drops the
> last reference, idxd_file_dev_release() runs synchronously and tries to
> take wq->wq_lock again, deadlocking.
> 
> Those paths also fall through into the later ctx cleanup labels even
> though idxd_file_dev_release() owns that cleanup and frees ctx. This can
> make idxd_xa_pasid_remove(ctx) and kfree(ctx) operate on a freed context.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: idxd: fix fdev setup failure cleanup in idxd_cdev_open()
      commit: ee1d7274102285d78a53161fc705a8d8cd40b066

Best regards,
-- 
~Vinod



