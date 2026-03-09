Return-Path: <dmaengine+bounces-9333-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHdmCNd7rmnoFAIAu9opvQ
	(envelope-from <dmaengine+bounces-9333-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 08:50:47 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 749D7235098
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 08:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A3583071F2A
	for <lists+dmaengine@lfdr.de>; Mon,  9 Mar 2026 07:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F810369985;
	Mon,  9 Mar 2026 07:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jY2DlUgf"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C093CA4E;
	Mon,  9 Mar 2026 07:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773042391; cv=none; b=sY7zoCVgPVh3J+WCKik7b0PVy+d+zNWZGIQnhSdsipObC304ut+r1KbIf0OMwluGI/3aDxufEjv5OkPFkS/qzw8jL94Hn+Tw1T3pmw7aHHTGnwbylhRt3+wdkPQB/kC9/HfGP8Sq9DRH+u75uhx2Iui1d6LKJcVqudtSRD8iWEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773042391; c=relaxed/simple;
	bh=X1/rMEiePIu8PUsFff5idBuBsrpjAv8rJihzmnySnZg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=i8rYj6+OmUNc1LJGpQMkoKEQe8E6JcMRHVudh+SJo6IdHMYfomi9WHwRxyUJPNpra3vOzmWUhGeBWilFCbUMQ3Kf/1XxVZ8P/NgAR1qTCKpfF2fVnYgYkK5ZweEwDPAOmrft/JCpggXHt5uoUFtDe6q5ahrHPyCv0PRU/no1ywU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jY2DlUgf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7B6C2BCB1;
	Mon,  9 Mar 2026 07:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773042390;
	bh=X1/rMEiePIu8PUsFff5idBuBsrpjAv8rJihzmnySnZg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jY2DlUgfWjHff400Jv0A3G7AnTQUwF+I3mBSwuWi/2dzMd2lEJjSES9mydRh4GKmM
	 FVFwuooA1oxoC+3zh0x2XzT0mRRTnv3neMP3s2d0GWOIGNzwEm3xpBc0IfEpRc3wr3
	 au8rpaoQMvg+PtdKMwCH1eEd8yWkthhb857DKYoywSi4CbCeEgZ/Vrr7xbjF8LfrQw
	 EHoIIXQ+BWJ0nFVDeot8w/FGWxGY0YG838cTb8Fpi46KU+OCCD69iEdRkFjdYSLbeQ
	 KTrVBRRBuOcCretl+w42TPyMlWejlKT7NBCSSi5VGrg/OlGLBmU2RlzOgkeAkWyQxF
	 SaPjWive9VGEQ==
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dave Jiang <dave.jiang@intel.com>, Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20260304-sysfs-const-ioat-v2-0-b9b82651219b@weissschuh.net>
References: <20260304-sysfs-const-ioat-v2-0-b9b82651219b@weissschuh.net>
Subject: Re: [PATCH v2 0/4] dmaengine: ioatdma: some sysfs cleanups and
 constifications
Message-Id: <177304238892.87946.4896869592596606871.b4-ty@kernel.org>
Date: Mon, 09 Mar 2026 08:46:28 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: 749D7235098
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9333-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.940];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


On Wed, 04 Mar 2026 22:44:36 +0100, Thomas Weißschuh wrote:
> Reduce the visibility of some symbols and make some structures readonly.
> 
> 

Applied, thanks!

[1/4] dmaengine: ioatdma: make some sysfs structures static
      commit: 0124b354a4dbea1f924adb2355db21d29bd2a5fd
[2/4] dmaengine: ioatdma: move sysfs entry definition out of header
      commit: bc94ca718f85f1caa40bea31ea63b52278d9d0cb
[3/4] dmaengine: ioatdma: make ioat_ktype const
      commit: 81ca3ad09ba7296daa798b4950097af1591b2809
[4/4] dmaengine: ioatdma: make sysfs attributes const
      commit: 28c829977f4072b23f2fd8d341c2795eec0d5bcb

Best regards,
-- 
~Vinod



