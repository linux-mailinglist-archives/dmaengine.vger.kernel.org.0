Return-Path: <dmaengine+bounces-11222-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xJmiMgpkI2owsQEAu9opvQ
	(envelope-from <dmaengine+bounces-11222-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:04:26 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D29E64BE8C
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:04:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=TT9QC63R;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11222-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11222-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68001301E6E4
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jun 2026 00:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBCD3BB4A;
	Sat,  6 Jun 2026 00:02:22 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96F1CA4E;
	Sat,  6 Jun 2026 00:02:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780704142; cv=none; b=MLzTJqK/8ql3I7zhS9bf/X7+VZHLQMlQ2I3tLite9O58DO5q17vI1MvivKqd7PZQQcroztIR89XtgRwDa3j9z+cbULrDbrGplFQXyUM4k0GndgwHu1+IyuYE8CVBGs1yd3bU3mJ7cjnwYKpIx8QfCCc9O+kFPA77HvbRhkFE53M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780704142; c=relaxed/simple;
	bh=qPK6UugunlFMoeP+8P0TP368mHmANW2O2gkSeilG6ro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Txj7ZirS32cf+x1R+yxFQM+Cey9j/gWcNrf5F6iXnwkXh3DFQpw/2UVIRpFpB8K0VmoVl6DrfMlTiLZl/eh/vyWM/FquVmh0TAYOvGFNOs3Jw3RhQwuZIpsKhebvfMIfD03JRcm5b7OIh9CpJbRwW1hRX6W8iE2MhZZjMby7hGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TT9QC63R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67624C2BCB9;
	Sat,  6 Jun 2026 00:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780704142;
	bh=qPK6UugunlFMoeP+8P0TP368mHmANW2O2gkSeilG6ro=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TT9QC63RcKXz1TtSzUFEyriyQkCtgaSFqRUYqofm1XH7qbUULRutigu+ZIcuVVwKM
	 snu+ur5gEYEgrHZGp6LBcqlBvTW1CQanvnfSH0WPfB/VNPCsBXlCDT2cY/y385nS+7
	 nXB/YjhJ/PT8hwAmLwy8YZFIfWDEDRygP9XJQsLYaCT7JgOgpcrpMT+aKn0e/ko5UD
	 IIYUJDgtzbFbT8Z25y7MD/5DuPxO9bv6CCMY4yjug1AjqioP0072CGttk8MgEo7SCX
	 QtDOMnIXFhDhx1o58KLHFCKhLSiFzIGwoVsjQwiDQiMxsmzRFRNSXnpa0j9rjMXm5p
	 6BMokn8rGlJkg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5409BCD8C81;
	Sat,  6 Jun 2026 00:02:22 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Fri, 05 Jun 2026 19:02:05 -0500
Subject: [PATCH v3 02/23] MAINTAINERS: Add entry for SDXI driver
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-sdxi-base-v3-2-4d38ca2bdffe@amd.com>
References: <20260605-sdxi-base-v3-0-4d38ca2bdffe@amd.com>
In-Reply-To: <20260605-sdxi-base-v3-0-4d38ca2bdffe@amd.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
 David Rientjes <rientjes@google.com>, John.Kariuki@amd.com, 
 Jonathan Cameron <jic23@kernel.org>, Kinsey Ho <kinseyho@google.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 PradeepVineshReddy.Kodamati@amd.com, Shivank Garg <shivankg@amd.com>, 
 Stephen Bates <Stephen.Bates@amd.com>, Tycho Andersen <tycho@kernel.org>, 
 Wei Huang <wei.huang2@amd.com>, Wei Xu <weixugc@google.com>, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Nathan Lynch <nathan.lynch@amd.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780704140; l=957;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=J7ULZm7Owlmcwbz490UgcmZhmtYpI8wOv94ro2VxLk4=;
 b=WY+9ghD8czK1AZnfW98i2DKmNdOXlXJaTHLTMGbV8TXdLxgVU2hnEjgwN18KwehyF1v0a6Rht
 16DdXEBUB8lCRJytULgwXZfqJbXBhTjMipy+VA7o2S0htC4SPtE3ufK
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=PK4ozhq+/z9/2Jl5rgDmvHa9raVomv79qM8p1RAFpEw=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260410 with
 auth_id=728
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11222-lists,dmaengine=lfdr.de,nathan.lynch.amd.com];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:bhelgaas@google.com,m:rientjes@google.com,m:John.Kariuki@amd.com,m:jic23@kernel.org,m:kinseyho@google.com,m:mario.limonciello@amd.com,m:PradeepVineshReddy.Kodamati@amd.com,m:shivankg@amd.com,m:Stephen.Bates@amd.com,m:tycho@kernel.org,m:wei.huang2@amd.com,m:weixugc@google.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nathan.lynch@amd.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[nathan.lynch@amd.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:mid,amd.com:email,amd.com:replyto,vger.kernel.org:from_smtp,snia.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D29E64BE8C

From: Nathan Lynch <nathan.lynch@amd.com>

Add an entry for the SDXI driver to MAINTAINERS. Wei and I will
maintain the driver.

The SDXI specification and other materials may be found at:

  https://www.snia.org/sdxi

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fb1c75afd16..5c6d175a3f42 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24036,6 +24036,13 @@ L:	sdricohcs-devel@lists.sourceforge.net (subscribers-only)
 S:	Maintained
 F:	drivers/mmc/host/sdricoh_cs.c
 
+SDXI (Smart Data Accelerator Interface) DRIVER
+M:	Nathan Lynch <nathan.lynch@amd.com>
+M:	Wei Huang <wei.huang2@amd.com>
+L:	dmaengine@vger.kernel.org
+S:	Supported
+F:	drivers/dma/sdxi/
+
 SECO BOARDS CEC DRIVER
 M:	Ettore Chimenti <ek5.chimenti@gmail.com>
 S:	Maintained

-- 
2.54.0



