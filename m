Return-Path: <dmaengine+bounces-9344-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKzrF9KurmkSHwIAu9opvQ
	(envelope-from <dmaengine+bounces-9344-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 12:28:18 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD546237ED8
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 12:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF47230713C4
	for <lists+dmaengine@lfdr.de>; Mon,  9 Mar 2026 11:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4F73939CC;
	Mon,  9 Mar 2026 11:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ek8j+14D"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB867376489;
	Mon,  9 Mar 2026 11:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773055477; cv=none; b=VFtkC+3oZ6cjh/sKDn0t84r6j9xjpkB4pjSDbyhTeqZ+PMzwcjvhWv61bp5ispZpnLiddmd1Kf6laG6YvF7QaE0QtSod0fHpUtEkgm+deO4GpuPQtmTUkkk2abeWWuHN8IhYaXplWvKz2shGl02e6PTQS8OIgDufONYRyeDfXAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773055477; c=relaxed/simple;
	bh=YYv8pxQgJWca6hIYn2qoRloJNcRUEr26iVA0OhWlEEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGpO90StvNO3Ur9VoqzB4h4ERDRl+/Iy2Uak/F7H5w/mWUpI9sveI0gb74l77PGublNRX2jr31gITW3teVNn2hueG5QYYDJoFmzqsZwtSsFI9RgLBDhVnM/HpVa4dG4bP3Q3i+O6B95ZINucL0Nzww2L5wfgZlz+TKmCjN9GsGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ek8j+14D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1C7C4CEF7;
	Mon,  9 Mar 2026 11:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773055477;
	bh=YYv8pxQgJWca6hIYn2qoRloJNcRUEr26iVA0OhWlEEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ek8j+14DBss9fXPiAu8OxWzu0+bXUde8LQHxeNu1XsLSpI57NHxBrbBf6TuhcAPJG
	 VGXkG3+Wznf6rvjZc10maDN1a6E/4jw2tNcyYE4Er2sdAR7t9o2AUzEk8u2cx6Ingz
	 pqQWurAnto6paHxQwAx8MK7WMwWmWLxGZ8B2PqfvATJ5tTGFPa1pXwP2Z0IR/QFY0N
	 00xfsKPz1j7IMexA0AF0k/Uub0o28L1zebCSImOefV3D2Xn0mRLyYeCwBZSBmu/Ix9
	 0FI9Xh7PHai8UGfwCp6+Cir7g+O2gcnVJ8AcsZjXstY7Tzpcd3K9ny6DS7IfuWqlMe
	 wWKaNLMbmzQmg==
Date: Mon, 9 Mar 2026 12:24:33 +0100
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/6] dmaengine: Add common dma_slave_config and split it
 into src and dst parts
Message-ID: <aa6t8QrrlearBOXI@vaman>
References: <20260114-dma_common_config-v1-0-64feb836ff04@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114-dma_common_config-v1-0-64feb836ff04@nxp.com>
X-Rspamd-Queue-Id: BD546237ED8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-9344-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.972];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 14-01-26, 12:12, Frank Li wrote:
> Many DMA engine drivers store a dma_slave_config per channel. Propagate
> this configuration into struct dma_chan to avoid duplicating the same
> code in each driver.
> 
> Much of dma_slave_config is identical for source and destination. Split
> the configuration into src and dst groups and use a union to preserve
> backward compatibility. This reduces the need for drivers to repeatedly
> check the DMA transfer direction.

The reason why we had both the src/dstn sides was intended method to
allow upport ofr device to device dma. Some interest was shown for that
at that time.
I dont think we have such a user even now...


-- 
~Vinod

