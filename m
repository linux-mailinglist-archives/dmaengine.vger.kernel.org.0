Return-Path: <dmaengine+bounces-9339-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPmtEBt8rmnoFAIAu9opvQ
	(envelope-from <dmaengine+bounces-9339-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 08:51:55 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEFE2350DE
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 08:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BB463087E35
	for <lists+dmaengine@lfdr.de>; Mon,  9 Mar 2026 07:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68EB36AB54;
	Mon,  9 Mar 2026 07:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aF9OrJtC"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A8636BCC3
	for <dmaengine@vger.kernel.org>; Mon,  9 Mar 2026 07:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773042401; cv=none; b=rfhrDhpDA3whC8b880HakfrLNgCsNp7kT0Ot5prn7xECIpXWjXaUxF5fKb4Ji3jriFzGMo6KjeZwAShYuxFHXR9RUeArjpqFMA2hGnmUYFWs/47dRtAIFQvsIMXMWj9sUwS78w8cj+G+Gk7Sszj/Zag6mtyGxyb9KaLMwYEJkF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773042401; c=relaxed/simple;
	bh=jCkmSwHTUIHXewAEgBSmJOigS29+4b2q/NJmdI1AotY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WbINVapwerM+XwBH+dMdr2eXoiibBxi2IFfMv1ywXMq3jWpnoSEh5vFSwDfhvlWo4CJN3yfvRzxsFJ5vVTDw734oaTpdWhAdffXPEAqZCRuzWgxPs83hF66UaKw7KDSKYA+NjmYf8cRmXqUyJ4+g3nL9P0pVX2TrskT8XF1Pqvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aF9OrJtC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FC6C2BCB7;
	Mon,  9 Mar 2026 07:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773042401;
	bh=jCkmSwHTUIHXewAEgBSmJOigS29+4b2q/NJmdI1AotY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aF9OrJtCTPYzWHs1zyaR7wZeyJIa7zMwA+2hCfuP9D83tJNCst+z22jLGuPu2ywMV
	 cS5uBBD10yf4fmH4W3xNShrkpSzTJ7gVRddZaNtZQzce1/zwoAE4SiAlShqlnKOVrT
	 Bz6Ywu9jHS0lIJ838CR7eyel7/GwOsg4JHiBBuTuz11Edp+ZdYOSxUoETt+XMGcOpS
	 bi1Xd7lSt/SRm8jjtVY9dO1tEV34wZLNhCLIhDG6fKGbrui4fAsqla0XuKDYiFU0Sn
	 obnjDioFOJ/fQW2zk9O8I344oMG/Z+Dt2MdEmRz/DGgyltx6/b82enOQOAHuMMQkTL
	 qt0gz7Y7sM6IQ==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.Li@kernel.org>
In-Reply-To: <20260227022905.233721-1-vkoul@kernel.org>
References: <20260227022905.233721-1-vkoul@kernel.org>
Subject: Re: [PATCH] dmaengine: xilinx: Update kernel-doc comments
Message-Id: <177304240024.87946.3593205371074892767.b4-ty@kernel.org>
Date: Mon, 09 Mar 2026 08:46:40 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: CBEFE2350DE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9339-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.947];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


On Fri, 27 Feb 2026 07:59:05 +0530, Vinod Koul wrote:
> Two members of struct xdma_desc_block are not descibed leading to
> warnings, document them.
> 
> Warning: drivers/dma/xilinx/xdma.c:75 struct member 'last_interrupt' not described in 'xdma_chan'
> Warning: drivers/dma/xilinx/xdma.c:75 struct member 'stop_requested' not described in 'xdma_chan'
> 
> 
> [...]

Applied, thanks!

[1/1] dmaengine: xilinx: Update kernel-doc comments
      commit: 65ca1121f7be4cc0391f6d80fa87eac6f7d847a5

Best regards,
-- 
~Vinod



