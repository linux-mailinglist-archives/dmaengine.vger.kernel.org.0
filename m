Return-Path: <dmaengine+bounces-1618-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B07A8900FA
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 14:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD52296199
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 13:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691B48060B;
	Thu, 28 Mar 2024 13:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAUKbykl"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D6B39FD4
	for <dmaengine@vger.kernel.org>; Thu, 28 Mar 2024 13:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634332; cv=none; b=osCFbmRjsdJFAGjADC/15P2RKqmbSJnLVJOEvAZckLzBiihjfguq0x1X6rDfpUMy70iOk7UQUOcKtkyEUF1dlsrp6xk6SeUE43HXf2QST/AMnhRnfzACCwTgJVUUla/MHqeuupAh4mi9+f96N3W34XS424OTC2ugulk15MAPuxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634332; c=relaxed/simple;
	bh=m0ql8MFfa+1VMdbESosL+rnjy6vxsXVOUNl8/db4URE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hc1z+2vtD87692epuCHDY3QvpbqNUSDXlnsNrtLidWFQrOSQiS5z+HojX4DWLacYgN0jJ4CuoLThmxPghT2dm9REDqEGUD17HzI4WoSzgbrPkSHvAYvqpDmX13MABsIExV0u5PUZqfIZ8Tius9b/MNAbaAGWif4mIUGLhZoVL+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAUKbykl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8649C433C7;
	Thu, 28 Mar 2024 13:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711634331;
	bh=m0ql8MFfa+1VMdbESosL+rnjy6vxsXVOUNl8/db4URE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=iAUKbykldJNAMi8kIfRwfCHpHWSZ3HEA3CLnGJlk0pCPvoqVWS5+h2LFf0pV7kax5
	 ifEqrRC3EB6L+70uPooRGt1/d1RRCVVmYH8kn47Bpm4iOzDTFwYRZZi7XZi9Q6TAOZ
	 yTRbWCL0QQ6wllhCZnEz0OA78UTeyEc07sZ+Pc/8O5ln++U157CaH9NXz7PEe+NUJV
	 NTeYBb4psTsqYysbGZUG/UmEKWt0Owz5uh1iPGSkIqwPlN7W4kkzZZO5tFy0lIT2H6
	 BECDTAejYt3mBVuphfPFqI3Sq3LHeX3McHcUv4cZqPyUy+Fzfg3JY+XVCLCzQ+EN/v
	 XEl/S60mGIYgg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAAACD1283;
	Thu, 28 Mar 2024 13:58:51 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH RESEND v3 0/2] dmaengine: axi-dmac: move to device managed
 probe
Date: Thu, 28 Mar 2024 14:58:49 +0100
Message-Id: <20240328-axi-dmac-devm-probe-v3-0-523c0176df70@analog.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJl3BWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYyML3cSKTN2U3MRk3ZTUslzdgqL8pFTdJBMT41TLlFTL5DRDJaDOgqL
 UtMwKsKnRSkGuwa5+LkqxtbUAm41oy20AAAA=
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 stable@kernel.org, Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711634330; l=934;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=m0ql8MFfa+1VMdbESosL+rnjy6vxsXVOUNl8/db4URE=;
 b=ei4DCpTy3lc2ngzogdcWrECGRv9vuGjJVr3hDLguDWWPZ11s+wcxFrMXuYOmuqPfbVAAyu7gD
 Fc4E02yhy0jB/b6xwjQ71/KkUBBZm1QOEy9mNdX14QOMt4ynKpWTQXj
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

Added a new patch so we can easily backport a possible race in the
unbind path.

Vinod, I'm just resending these patches again (as merge window is now
over. I applied and compiled them on top of the next branch. Tip in:

8b7149803af17 ("MAINTAINERS: Drop Gustavo Pimentel as EDMA Reviewer")

---
Changes in v3:
- Patch 1
  * New patch.
- Patch 2
  * Updated commit message (request_irq() is no longer moved).
- Link to v2: https://lore.kernel.org/r/20240219-axi-dmac-devm-probe-v2-1-1a6737294f69@analog.com

---
Nuno Sa (2):
      dmaengine: axi-dmac: fix possible race in remove()
      dmaengine: axi-dmac: move to device managed probe

 drivers/dma/dma-axi-dmac.c | 78 ++++++++++++++++++++--------------------------
 1 file changed, 34 insertions(+), 44 deletions(-)
---
base-commit: 8b7149803af174f3184d97c779faa1c7608da5af
change-id: 20240328-axi-dmac-devm-probe-b443e9de9cf1
--

Thanks!
- Nuno Sá



