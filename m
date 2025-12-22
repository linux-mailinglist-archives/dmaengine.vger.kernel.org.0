Return-Path: <dmaengine+bounces-7866-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 573ABCD717A
	for <lists+dmaengine@lfdr.de>; Mon, 22 Dec 2025 21:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2AD8303999C
	for <lists+dmaengine@lfdr.de>; Mon, 22 Dec 2025 20:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8367532ED45;
	Mon, 22 Dec 2025 20:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fN8Q5sLt"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584D631C567;
	Mon, 22 Dec 2025 20:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766435829; cv=none; b=Cy4wwKOkpYjPjYL1pKpycEY1vxxlbPpTuqrZBqgaW0+bn9LcUK5kEinvILJCbcI60aj8hIzf1JgHm+EFr+IAgQeSg+yhl0XDPQZDVHlSxsDPoXRDpvJUb8EWpidFnqF/0EZ1gMbliUZXcyZUjfWU1QCZYL8Gnzj59fhclP6n8uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766435829; c=relaxed/simple;
	bh=T6XsZ646Iu0fYa3ICrNz3rpt/XYIvTnv5bAAxXrneio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P0z+AVtHjMC/thwpqO65Gdg3ANBEevwDtkjLu6HENjNE6DdNRtBTZUx1kWGqGHO256sIg6QNzPTnPcnv1sSKHfL5RBkA3Ke5Rtyjm/xfHQF/F6W3Sbbm5odXm5rgrh/UMgMUNh7HKaY5r6t8IB8juJHFW6wfIRmvdG2XvfdFHm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fN8Q5sLt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25F8C16AAE;
	Mon, 22 Dec 2025 20:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766435828;
	bh=T6XsZ646Iu0fYa3ICrNz3rpt/XYIvTnv5bAAxXrneio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fN8Q5sLt+cJKvG+uO/CqALEKfTJeoPHhqIz6mul4QSklCogKZXaJlN6cUSkn5YLGO
	 1nQ+t+rct86gXmKr3KcLySuEAwOllzbr0/7G4PKHAMAUAE6rjaGvrYzXDyD88qbfQh
	 iz2wqY+edrIZmTw0o3B2Gqvr3kAbiCs36MQeYgB52aEIF5qMLiOlXpYpzbGRcY/YIq
	 mQK+2HdhLDuFhQ5O5R6pw0lN6MrB2VMgxjvQnpamxRzTNequzGWMowRDu86XLtntUt
	 /8JRO6DXKyvyTA56WbO0RXnvYudsoZs+3DSjbRxslvPywCgMvf+R/ozf9A1buiyP1X
	 OOF1DOdZDOy0w==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Brian Norris <briannorris@chromium.org>, Vinod Koul <vkoul@kernel.org>,
 dmaengine@vger.kernel.org
Subject: [PATCH v1 21/23] dmaengine: sh: Discard pm_runtime_put() return value
Date: Mon, 22 Dec 2025 21:33:25 +0100
Message-ID: <9626129.rMLUfLXkoz@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Clobbering an error value to be returned from shdma_tx_submit() with
a pm_runtime_put() return value is not particularly useful, especially
if the latter is 0, so stop doing that.

This will facilitate a planned change of the pm_runtime_put() return
type to void in the future.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This patch is part of a series, but it doesn't depend on anything else
in that series.  The last patch in the series depends on it.

It can be applied by itself and if you decide to do so, please let me
know.

Otherwise, an ACK or equivalent will be appreciated, but also the lack
of specific criticism will be eventually regarded as consent.

---
 drivers/dma/sh/shdma-base.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/dma/sh/shdma-base.c
+++ b/drivers/dma/sh/shdma-base.c
@@ -143,7 +143,7 @@ static dma_cookie_t shdma_tx_submit(stru
 				}
 
 				schan->pm_state = SHDMA_PM_ESTABLISHED;
-				ret = pm_runtime_put(schan->dev);
+				pm_runtime_put(schan->dev);
 
 				spin_unlock_irq(&schan->chan_lock);
 				return ret;




