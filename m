Return-Path: <dmaengine+bounces-11980-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id giNCBXqFRmomXwsAu9opvQ
	(envelope-from <dmaengine+bounces-11980-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 17:36:26 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CC46B6F97DC
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 17:36:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YQPj9UK2;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11980-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-11980-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 34326306B1F0
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 15:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC31B433E9C;
	Thu,  2 Jul 2026 15:32:16 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A628A37A84E;
	Thu,  2 Jul 2026 15:32:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783006336; cv=none; b=tPmM7UyUXLI86UwXlU6QSejvxkktvNWxKA7TULe9CY61I6AxF7uhTp2mprTtQr6F2RG/1uIb49QMXt/XHjN/lbl9XHFTf75X4T1hqQAQtzNA/sG+Fso/TUzpg/SLSPmQ/SaWw1eCqAEHiBuNANgKAUBiZeoIvrLqjgP0nQxeSxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783006336; c=relaxed/simple;
	bh=+cGn/g6vlxxoicm4aGN5PKiJ90qLv0h1llZMltqCYuk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pMTH6d7wOsylRnozQ8j9Sn95IPss4027tzHXDVr2dHd31vpBBi1qW1BqVQmh/kvdoEZh3gpCRr3JHP4HWs2x51u8OYWQlhgkBQnORfcSeoo7qtUwhJYVzU/hqcfojGAJkLDJMtFbWDnd/gjkBziKmaPsnYL+ydVTV3a0ShmEkfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQPj9UK2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E981F000E9;
	Thu,  2 Jul 2026 15:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783006335;
	bh=SkFOU4Oyw7LYLPAfVqtgnDjfsTBzuUdC4zo1Q4spOx4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=YQPj9UK2pOkhB8RDcHuXW0QbDJbhBpl/OLo4rsgcb7PkoDO1QJXiMLqtfE0SUVv40
	 UL6BVRrDxAk0o5MMoG8xnQ/0Qlm7wbShq2PhJ7b1qaw89ETLwZJzqUkywna8Q9EHrD
	 9S8z7to74FPFl9x5bh6IpH1Cu4JIB7B+3+g4TUbj9CL+75ISLidqWEAYl3t5sR4sLE
	 3JF1+8M+mojiCWWqRaXyMlAqloQq5Bfou/qbyZ1YDUraPuAG8C1803p49UY9EGZUtN
	 HZs43qOxi30mrWhxd9XxjK0rx/6KPyQlL8rIUu8f7INKqrwRt6irAhL00rE+HqB6Ql
	 Bq3vxONR02d6A==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, 
 Jon Hunter <jonathanh@nvidia.com>, Frank Li <Frank.Li@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260609212531.22044-1-rosenp@gmail.com>
References: <20260609212531.22044-1-rosenp@gmail.com>
Subject: Re: [PATCHv4] dmaengine: tegra210-adma: use platform to ioremap
Message-Id: <178300633253.735405.8595624907524864073.b4-ty@kernel.org>
Date: Thu, 02 Jul 2026 21:02:12 +0530
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
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:rosenp@gmail.com,m:ldewangan@nvidia.com,m:jonathanh@nvidia.com,m:Frank.Li@kernel.org,m:thierry.reding@kernel.org,m:linux-tegra@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11980-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CC46B6F97DC


On Tue, 09 Jun 2026 14:25:31 -0700, Rosen Penev wrote:
> Simpler to call devm_platform_ioremap_resource() as it returns multiple
> error messages for whichever part fails.
> 
> 

Applied, thanks!

[1/1] dmaengine: tegra210-adma: use platform to ioremap
      commit: 95cf38ae309f21b651fb7b8afe267eb3c84017a3

Best regards,
-- 
~Vinod



