Return-Path: <dmaengine+bounces-9471-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kC7DI+U6uWmKwAEAu9opvQ
	(envelope-from <dmaengine+bounces-9471-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 12:28:37 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BA82A8B0F
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 12:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B6EB307E258
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 11:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AC13AA4FB;
	Tue, 17 Mar 2026 11:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqW110UI"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7EC3932F0;
	Tue, 17 Mar 2026 11:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773746874; cv=none; b=SU3NhTwy3r10VGTkBmr7KgouUDVIqnbVdxttyxx5i8u8DDEfGnoEvcjIXodTlRBmEgtYnb75WJS9H3AL6x4nK7MHLVQq9e70+AOzhi6meaM36kp2WX7GkchFoXPy+bM5phMlFHCb2A9omuz52VXdNvLpHF4FTfVPOchp+Mt29ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773746874; c=relaxed/simple;
	bh=hHykJD+9TL8m1Kg8WRvXe8cTceyGxQGB9+Mf9oqzmBc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=E0LnU+uDCQckEqV2OILEJaet1SOc8IpL8i0Lqe/afhn/1nEll0rtpV8wMZyDUHL/h8TZQ8yge5msW3afzUIO43+fZYa2VepsV9Gx40K1bzDja/TCTpvqOk09l2RHoLTJ9VyR5+kpANIwNWp8pzS942n4fC+g4rW1SMq3/9hHyzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqW110UI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AE2C19425;
	Tue, 17 Mar 2026 11:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773746874;
	bh=hHykJD+9TL8m1Kg8WRvXe8cTceyGxQGB9+Mf9oqzmBc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lqW110UIZjPBkszkgbYhDWH1b/JZ4MAdLYNHiGMbuavTgpclgWbv9hsyPCFaLLu2Q
	 wx9WHo4SRhO90mH5Q0axGI2KgDcbXdY3TgHSIZR9jxqrc+MD7TehSIg21qJmStbluK
	 8cSSeoIUvq/hK+sayuXm3YFHNwZUzBzWGZRuhy78iAuUiQCL6tj02M3z29eNlWiHEG
	 +yXHRPABYgyIgy+Bz4nEunVKsR790eTGW7uuF5yb03ZDwOG/by6lwsLJg5S+WHfDNM
	 1TmVDKEqQlZaBjkctULbFJTgKsQnfci0hThSlebuh1VjmS4lP48jZlTbn6jCYe+2Y+
	 PV9w2A3gteYMQ==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, Marek Vasut <marex@nabladev.com>
Cc: Michal Simek <michal.simek@amd.com>, 
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, 
 Rahul Navale <rahul.navale@ifm.com>, Sasha Levin <sashal@kernel.org>, 
 Suraj Gupta <suraj.gupta2@amd.com>, 
 Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260316222530.163815-1-marex@nabladev.com>
References: <20260316222530.163815-1-marex@nabladev.com>
Subject: Re: [PATCH] dmaengine: xilinx: xilinx_dma: Fix unmasked residue
 subtraction
Message-Id: <177374687115.337094.18303476978785991645.b4-ty@kernel.org>
Date: Tue, 17 Mar 2026 16:57:51 +0530
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9471-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D9BA82A8B0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Mon, 16 Mar 2026 23:25:24 +0100, Marek Vasut wrote:
> The segment .control and .status fields both contain top bits which are
> not part of the buffer size, the buffer size is located only in the bottom
> max_buffer_len bits. To avoid interference from those top bits, mask out
> the size using max_buffer_len first, and only then subtract the values.
> 
> 

Applied, thanks!

[1/1] dmaengine: xilinx: xilinx_dma: Fix unmasked residue subtraction
      commit: c7d812e33f3e8ca0fa9eeabf71d1c7bc3acedc09

Best regards,
-- 
~Vinod



