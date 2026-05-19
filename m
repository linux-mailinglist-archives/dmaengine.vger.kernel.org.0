Return-Path: <dmaengine+bounces-10559-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDw8EMKZDGo6jwUAu9opvQ
	(envelope-from <dmaengine+bounces-10559-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 19:11:30 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C276582DE6
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 19:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FA1E3017277
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 17:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF8B30EF75;
	Tue, 19 May 2026 17:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qyRlrMBO"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C86D2765D7;
	Tue, 19 May 2026 17:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779210405; cv=none; b=RkDHGiBv5RQe1bclR6WYSRtD9p6IFUHM5alBtnG0tOHGCJbkl/7ALNGi3hdUyL3kBar++3jq9i8NW7B73tAXXIs9MiDxI2gySdNcQF2QBO0tnfq5ec1j+RFs3xH5ARu36vRj4ZIqfNeZ2NAwNqI8OGk0xOvkwX656gezd2uKVPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779210405; c=relaxed/simple;
	bh=Mi5fefcgSQTvi9ChCan9hgaXY1JdITu+bouW9m7d4bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFbqqcYOqTKuVWa6QE2bhTHSDlKLeUrvaIcGW6tX0zgrLeCI8MDD2PkvNVsu+bRPNLzPW2vetKLrEKAETtcSFUSBm+cvXuu/8sVC4vs+LU0uPocleEtL5Z5+pMExrrJ4P9S3MuahxQQjBf6t1tuK+7PKXx6zNQ1dqGUYrtXioQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qyRlrMBO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17BEC2BCB3;
	Tue, 19 May 2026 17:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779210404;
	bh=Mi5fefcgSQTvi9ChCan9hgaXY1JdITu+bouW9m7d4bc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qyRlrMBO1sL+WYVfkjgioWKMXBDN59ziCG91KC2k00Snafz1CgyOKwE35FBwT9J5O
	 xhchP6fmchvZjLokeJewszskcJ2fyyPZstJXWt7PlRdHIOrGsGwN0qfX8SxS7hmmSc
	 HXYddniIHpZdyUs6dOMSSFKHq+PnHs1zHqjkM2owzjNYGddKSzLrN9ClF9vvz/e1Ge
	 kxWNN2uAXyTT+04uowQYnaaycsVNeslCXJWz+lZt60XjY6yTmqIJ0DCk6FNvPUlukO
	 II+qsgaM0WAiqC8sOpSoSH932L+UBlTMSBwWRkr+HIzrZlOn4hL2xl3tlsDYd48DaG
	 ToQ1G8V72Z5RA==
Date: Tue, 19 May 2026 22:36:40 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>
Cc: peter.ujfalusi@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, nm@ti.com, ssantosh@kernel.org,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	vigneshr@ti.com, Frank.li@nxp.com, r-sharma3@ti.com,
	gehariprasath@ti.com
Subject: Re: [PATCH v6 00/19] dmaengine: ti: Add support for BCDMA v2 and
 PKTDMA v2
Message-ID: <agyYoLc1yJyI9eDn@vaman>
References: <20260428085202.1724548-1-s-adivi@ti.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428085202.1724548-1-s-adivi@ti.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10559-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org,nxp.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url]
X-Rspamd-Queue-Id: 9C276582DE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 28-04-26, 14:21, Sai Sree Kartheek Adivi wrote:
> This series adds support for the BCDMA_V2 and PKTDMA_V2 which is
> introduced in AM62L.
> 
> The key differences between the existing DMA and DMA V2 are:
> - Absence of TISCI: Instead of configuring via TISCI calls, direct
>   register writes are required.
> - Autopair: There is no longer a need for PSIL pair and instead AUTOPAIR
>   bit needs to set in the RT_CTL register.
> - Static channel mapping: Each channel is mapped to a single peripheral.
> - Direct IRQs: There is no INT-A and interrupt lines from DMA are
>   directly connected to GIC.
> - Remote side configuration handled by DMA. So no need to write to PEER
>   registers to START / STOP / PAUSE / TEARDOWN.
> - Unified Channel Space: Tx and Rx channels share a single register
>   space. Each channel index is specifically fixed in hardware as either
>   Tx or Rx in an interleaved manner.

Please check the commments from Sashiko https://sashiko.dev/#/patchset/20260428085202.1724548-1-s-adivi%40ti.com

-- 
~Vinod

