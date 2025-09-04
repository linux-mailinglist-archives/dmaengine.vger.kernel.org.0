Return-Path: <dmaengine+bounces-6384-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F32B4407E
	for <lists+dmaengine@lfdr.de>; Thu,  4 Sep 2025 17:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79B041C8656C
	for <lists+dmaengine@lfdr.de>; Thu,  4 Sep 2025 15:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D771CEAB2;
	Thu,  4 Sep 2025 15:25:17 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D13F244690;
	Thu,  4 Sep 2025 15:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756999517; cv=none; b=DgKbvjzMqFhcyo7m/mZQRE4YK1Gx9iQ4isp1oT2TCt5C2688hAJK+T6NcA7I3tkkdIYpo/XCGZF/afjl0EwurgI7IOWDn8UGQN81Y7DTu8xMG2tcS6mNvubY4HnxAZq7MWy+Iy2abowNkpc5QPNz/uRnWRKRPwKN9pJXDhJ4fu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756999517; c=relaxed/simple;
	bh=3iDrMsVPCaS6Cdt6sVWWXrL6f6NZFjdw4rl0TbUaCUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VtmTbiG+ndi5Nq3kAlG2xIdWxU4MiUm0Gu7vZBEb5mzdZHTuVcMxqQoz6PDP/T8sdXm0SnPlhTQ9U+yYTRt3q3OAfs07pTEy+2Qx9I3aIcIoLk5ATGy8/N2GRwb8vClkTXcQJN3tGfqU/pGrzZ+idBmXtp3/AEecxhJ0pQ/oCdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD61EC4CEF0;
	Thu,  4 Sep 2025 15:25:15 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Vinod Koul <vkoul@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: dmaengine@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] dmaengine: rcar-dmac: PM-related cleanups
Date: Thu,  4 Sep 2025 17:25:08 +0200
Message-ID: <cover.1756999325.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi all,

This patch series contains various cleanups related to power management
for the Renesas R-Car DMAC driver.
ARM64 platforms.

This has been tested on R-Car Gen2, Gen3, and Gen4.

Thanks for your comments!

Geert Uytterhoeven (2):
  dmaengine: rcar-dmac: Remove dummy Runtime PM callback
  dmaengine: rcar-dmac: Convert to NOIRQ_SYSTEM_SLEEP/RUNTIME_PM_OPS()

 drivers/dma/sh/rcar-dmac.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

-- 
2.43.0

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

