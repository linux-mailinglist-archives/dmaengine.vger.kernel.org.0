Return-Path: <dmaengine+bounces-11317-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HXYTFjqyJmo6bQIAu9opvQ
	(envelope-from <dmaengine+bounces-11317-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 14:14:50 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8B7656066
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 14:14:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=h4gXuBVM;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11317-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-11317-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8E60130280D2
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2026 12:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8B837AA82;
	Mon,  8 Jun 2026 12:13:20 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C0537DABD;
	Mon,  8 Jun 2026 12:13:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920799; cv=none; b=d0pDMb52Ae5j+asiJzY+uX9LdDtNyhnvOppr1q3jRj1JkNpphRRIowIY6Z6VhoTkPTsplX1gUwtScnmXDJ8cg2kBwCPWPAL28F9fC9rq/JeDWBg4LJ/zJR6Cl3qORjmYS9VaVzStNkqt0yM0mgOOSxU6TgNMLtHLUzQMckYybAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920799; c=relaxed/simple;
	bh=GYOFshXSQ2rXp7L0Bti4gLR0Q8s6aqYfAMiRNc7lE+g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YKKQ8uK+/884WcqihnqoRW1EwUUiyKuJ+Q6nkhtpxguMrV3S9Yj9Zf+OcHZpbXQSvgLWWSd48jv1RiVfz59mujW3ppAocjGn8HYdWJWMiHDghFVN0N38PNw6wzLXLFt+psR4J/1nC8kAI6+NMY8/YjBWdg8M+sykFHsP8PLrYbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4gXuBVM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0895D1F00893;
	Mon,  8 Jun 2026 12:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780920798;
	bh=Iydd94isOhUeQpr5j0eFZ1PK9qHVg+SrEz2KxmyD7qE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=h4gXuBVM060nEkQrSm8GnwkG61zbsEpNPfJwvo36tRxEE7PDajQlkcVXA1Em351KJ
	 k12kE6/eiV+H+7ApNOApDWfNl70PUUujowp3ddK/8Lmr8eRTfqSISsDO/qHpz0QwKf
	 7DXFm/oRsr94Z/cA/bTQhPaOkWYlq56XJ5I/kCWc0hDCiC4BdDb+YIc+HpmnlsDpoU
	 aKGfVQiRkG3G4xGtTfzdQBNakGTettJGipCTBt9uCQLFYlYlXTMS8hdfCnBwA3elYW
	 DUcB6Lxg0KHvc+Ps+AqiLSmcN6IS+/cW/c4IYI9oh1nuVb46ogPQWtJp47eeAqqPMQ
	 /YmhlB5kQi5Qg==
From: Vinod Koul <vkoul@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
 Koichiro Den <den@valinux.co.jp>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260521142153.2957432-1-den@valinux.co.jp>
References: <20260521142153.2957432-1-den@valinux.co.jp>
Subject: Re: (subset) [PATCH 0/4] dmaengine: dw-edma: Fix probe paths and
 register races
Message-Id: <178092079664.96550.12858701594139945991.b4-ty@kernel.org>
Date: Mon, 08 Jun 2026 17:43:16 +0530
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:Frank.Li@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:den@valinux.co.jp,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-11317-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E8B7656066


On Thu, 21 May 2026 23:21:49 +0900, Koichiro Den wrote:
> This series fixes pre-existing dw-edma issues flagged by Sashiko in:
> https://lore.kernel.org/dmaengine/20260521063115.2842238-1-den@valinux.co.jp/
> 
> Note: Patch 4 was based on a patch Frank posted in January:
>       https://lore.kernel.org/dmaengine/20260109-edma_ll-v2-1-5c0b27b2c664@nxp.com/
>       Since it has not been merged, I included it here. Frank, please let me
>       know if you prefer a different handling.
> 
> [...]

Applied, thanks!

[2/4] dmaengine: dw-edma-pcie: Reject devices without driver data
      commit: 11d7cfe0c119691b2dafbb699bbca90258c678aa
[4/4] dmaengine: dw-edma: Add spinlock to protect DONE_INT_MASK and ABORT_INT_MASK
      commit: 8ffba0171c6bbce5f093c6dba5a02c0805b31203

Best regards,
-- 
~Vinod



