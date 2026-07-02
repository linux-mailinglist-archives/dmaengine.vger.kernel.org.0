Return-Path: <dmaengine+bounces-11972-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KrUKK52GRmqBXwsAu9opvQ
	(envelope-from <dmaengine+bounces-11972-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 17:41:17 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A21156F98E1
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 17:41:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=K0PhNZuh;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11972-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11972-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 63A2F30786F8
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 15:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58F7381EAF;
	Thu,  2 Jul 2026 15:25:34 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA719381EA5;
	Thu,  2 Jul 2026 15:25:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783005934; cv=none; b=Q/fQoi2LrE8kBIaEUyiUuJSFnUfdpMsXx9vD3am/uIRd3H8idtWHAYiXSQh+cQ1nPYEla8xVMi1vxkhjlM8hUgCfwkwm/A7tzOx9cVB3hK3mmC9pyFoPJvLJ3m9en3rXAa5GcbzDqQ1a4jlOgTt4lmsiZaoJ4CegIjbW6a1bUFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783005934; c=relaxed/simple;
	bh=xj5s7WY+QLQUy8AfL07dCQIIJdpNmdH1DCaF0zyc43w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mDwONwJmtcLqNE2ybdPzSHcUWJs+ypYQXIIqZZW1ROK4hDrk2gtrfPHSv1sBz/ZppL5zgfT9VJ2F/hInV02Eb2enPOZtNnd53tiwlaeC3QYX4FQGdZsAbhOkv1MYjEq6fWqK5C19PBYNfm0iXgkm46KP7Zk+DkXGc8WBfq+2Dxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0PhNZuh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2C31F00A3A;
	Thu,  2 Jul 2026 15:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783005933;
	bh=BkCp8+eEHAV99V9AXfR1dKbJ9C/llthtkDgqG+qt64g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=K0PhNZuhHvIhoOs32p/Oy3Y7LIfLGgkVvqa/UucJXeFRPCqNqLLXoXGz7dI3sVPF8
	 1+tTZLC3F1Ffmq70iL9fG61hi3N1NFE0GBlrtujfxGoIu3QsBwhfXcNDfj/zhE+Pea
	 R8fI3rhp0cY4UC/MpskNGv2JfNX2FQGCLd9CvHV8b/4RpIKmqZ/ZPhD++2dHt6ZxEY
	 BK/Wtw6njP0x5NV4jlOyJFvB4471EzWAKGssnX8pqc81j6iLv5brtEkt2xJpzddD+E
	 vP4y2NYpPQpATIcHYqug+e5JGpey8X+ZPphYuiqxBWKXihMSZoMWn/AIcaIMZaGnaF
	 JEh4esO3lNhiQ==
From: Vinod Koul <vkoul@kernel.org>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
 Yuho Choi <dbgh9129@gmail.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Frank Li <Frank.Li@kernel.org>, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260415205452.67155-1-dbgh9129@gmail.com>
References: <20260415205452.67155-1-dbgh9129@gmail.com>
Subject: Re: [PATCH v1] dmaengine: idxd: fix double free of wq, engine, and
 group structs
Message-Id: <178300593132.726714.650968686982910854.b4-ty@kernel.org>
Date: Thu, 02 Jul 2026 20:55:31 +0530
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[intel.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vinicius.gomes@intel.com,m:dbgh9129@gmail.com,m:dave.jiang@intel.com,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11972-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A21156F98E1


On Wed, 15 Apr 2026 16:54:52 -0400, Yuho Choi wrote:
> The release callbacks for wq, engine, and group devices
> (idxd_conf_wq_release, idxd_conf_engine_release,
> idxd_conf_group_release) each call kfree() on the enclosing struct.
> The setup error paths and cleanup functions also call kfree()
> explicitly after put_device(), producing a double free whenever
> put_device() drops the reference count to zero and fires the release.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: idxd: fix double free of wq, engine, and group structs
      commit: ec2d428b2e32dd157de8f86a86dd85c5b2c8f45c

Best regards,
-- 
~Vinod



