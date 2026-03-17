Return-Path: <dmaengine+bounces-9472-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNvvFgE7uWmKwAEAu9opvQ
	(envelope-from <dmaengine+bounces-9472-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 12:29:05 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C882A8B74
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 12:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A4F430A0013
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 11:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6273AB280;
	Tue, 17 Mar 2026 11:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6zhV+nW"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087163AA510;
	Tue, 17 Mar 2026 11:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773746877; cv=none; b=lxuKzeFKBOsQS9eGF3UVW3sPMoF2VAqgo32/c4lF4VLch5Psk5rzD9GhtIxpsuhkga6qlopCqI+6mjEsHzbRzaavxtVjHssqCYxL9T/+oeHRWxPscgS1HZkHa/bkcjPZda49IfZe+8KLJI/ZONQtJ8BVMu0DqzMjfTSwibgoZco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773746877; c=relaxed/simple;
	bh=mpYHC4wU3qrnV+HjBcRQYWYiODu50oiRnnFlM8r8a+w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VhXaJQUEtafkkh1WWXzMmAeW5+NXsV2AcsrbPIEPXDbpKhg+TI6yiTYYKFqrkeeNzfnuJRaq50gTJXMlIvnTso1z0+evyadjrenXFC7WGngxmACWyMfczODzv2BrJo6iKmnLwCNLppfSE950vT/j5SIyF/FtJOJSYd7FOtp1Dk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6zhV+nW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18A5C19425;
	Tue, 17 Mar 2026 11:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773746876;
	bh=mpYHC4wU3qrnV+HjBcRQYWYiODu50oiRnnFlM8r8a+w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=s6zhV+nW5bvq9foYc1GnDgnUk5Yvu//WGAWengYH/ZKXf9SlP9cY4RYBN1F7CAIwx
	 ioDfSnQQc3aH5a8P2P0zovfm2Ywy+ijK5jqYV69KikH5yIXFhAV59Qe4w3neAE+P4g
	 s1kFrgs0AP1aK4yxxSFmKwONyfk8PEQPpOfuuaAKCSz81VjETMCU9Ze3X/xw16npG/
	 GskneFVwyblNE7LCt7ql00iJV07WyfQRQdTDyln5ipvkMTNdJxf/0bUT0ZjC/NUs4R
	 TIlei5algTssuND3bVuWYRT5ncDhbAkcyKf/AU2wOoHEu0ve70ats+9koAs4ex7x8y
	 OYO47Crh/XCxg==
From: Vinod Koul <vkoul@kernel.org>
To: Michal Simek <michal.simek@amd.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Vishal Sagar <vishal.sagar@amd.com>, 
 Suraj Gupta <Suraj.Gupta2@amd.com>
In-Reply-To: <20260311-xilinx-dma-fix-v2-1-a725abb66e3c@ideasonboard.com>
References: <20260311-xilinx-dma-fix-v2-1-a725abb66e3c@ideasonboard.com>
Subject: Re: [PATCH v2] dmaengine: xilinx_dma: Fix reset related timeout
 with two-channel AXIDMA
Message-Id: <177374687441.337094.12896533285530975701.b4-ty@kernel.org>
Date: Tue, 17 Mar 2026 16:57:54 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9472-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B0C882A8B74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Wed, 11 Mar 2026 07:34:46 +0200, Tomi Valkeinen wrote:
> A single AXIDMA controller can have one or two channels. When it has two
> channels, the reset for both are tied together: resetting one channel
> resets the other as well. This creates a problem where resetting one
> channel will reset the registers for both channels, including clearing
> interrupt enable bits for the other channel, which can then lead  to
> timeouts as the driver is waiting for an interrupt which never comes.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: xilinx_dma: Fix reset related timeout with two-channel AXIDMA
      commit: a17ce4bc6f4f9acf77ba416c36791a15602e53aa

Best regards,
-- 
~Vinod



