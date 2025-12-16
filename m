Return-Path: <dmaengine+bounces-7695-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B048FCC485C
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 18:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 165A53062E4F
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 16:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D70321445;
	Tue, 16 Dec 2025 16:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEwThL5t"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B5431B10E;
	Tue, 16 Dec 2025 16:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765904191; cv=none; b=Di16cslB7IszIPZDrmK0q9t/d7vTM11hcWHVwjuXvDD/PwL5JODT0FSGGPq3WQ+7scmcv/iTjBn9lP050kpzHAjJKkrCiXxx15e58E00yKmM7mOaidX8HMCe9IU8l5rAuL1qg/9SSvvo73iykeUqbdSotFqN/ssS5DE79sxp9yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765904191; c=relaxed/simple;
	bh=1i34GAw6Dnc6REDPPQS6hOitzVxy2CneAj8xwMVFty8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YNVh9WCKrL6NxlVys5VwIYwnBno3XIoHXiJaNkwgbpdk2WGJcKXuRaJwX1trW6dhqRMYXqAhiedHDf2M8NbeGs8TxlvCIeGWdUgJ8Xf7IV0LwdoGUe5n7y3VBXiK+PDvLJ7mOrKQiFNZ8BTHM5Em9ZzV3Fz0VYWlDxtBjBq74fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEwThL5t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5BB6C4CEF1;
	Tue, 16 Dec 2025 16:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765904191;
	bh=1i34GAw6Dnc6REDPPQS6hOitzVxy2CneAj8xwMVFty8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZEwThL5tiHRZUzFTHUnBZGSfbrs9w4kAbvGIDNfpbvqyLUSf++7PEvVqsQEDSJy0U
	 RPIh/gqBDRljY0yYKx0gnOypTAlPCDPTkmcQqQHuXoqoKceqMsBoGk6MDx8NPjN2l5
	 dKyIYPyxake2hZFgRrvjtcXcHDTIKJjdaoQIT2ziytZDghbXkqXKIqj28D5zL4iPOE
	 c32crYmyjEHLvnLjtazm+oVS2x4oy5Pc5+Jus+akT+SxqPtep6kqKVpzIdbsdvzqnY
	 JrX8qFXaWj9mC7KTIe4A+am7lJ72CPtrMKXfiJ2UiUYqVxrOnoh6wYI6dk+viKXZYr
	 fUPbspCkPMw1A==
From: Vinod Koul <vkoul@kernel.org>
To: Biju <biju.das.au@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 stable@kernel.org
In-Reply-To: <20251113195052.564338-1-biju.das.jz@bp.renesas.com>
References: <20251113195052.564338-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2] dmaengine: sh: rz-dmac: Fix rz_dmac_terminate_all()
Message-Id: <176590418843.422798.14198311104614997013.b4-ty@kernel.org>
Date: Tue, 16 Dec 2025 22:26:28 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 13 Nov 2025 19:50:48 +0000, Biju wrote:
> After audio full duplex testing, playing the recorded file contains a few
> playback frames from the previous time. The rz_dmac_terminate_all() does
> not reset all the hardware descriptors queued previously, leading to the
> wrong descriptor being picked up during the next DMA transfer. Fix the
> above issue by resetting all the descriptor headers for a channel in
> rz_dmac_terminate_all() as rz_dmac_lmdesc_recycle() points to the proper
> descriptor header filled by the rz_dmac_prepare_descs_for_slave_sg().
> 
> [...]

Applied, thanks!

[1/1] dmaengine: sh: rz-dmac: Fix rz_dmac_terminate_all()
      commit: 747213b08a1ab6a76e3e3b3e7a209cc1d402b5d0

Best regards,
-- 
~Vinod



