Return-Path: <dmaengine+bounces-7255-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7F0C73CB3
	for <lists+dmaengine@lfdr.de>; Thu, 20 Nov 2025 12:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 45C223429DB
	for <lists+dmaengine@lfdr.de>; Thu, 20 Nov 2025 11:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3C32D0C63;
	Thu, 20 Nov 2025 11:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZB1TBi1c"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45C123504B;
	Thu, 20 Nov 2025 11:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763639159; cv=none; b=Qgnaz/+UWj8gHqxozg842LUVQFRzHibqh36WzfGbji/tZ3K1E2yo7jLmgCqM/YjLWAz8ubDc/IHuAcBdvlSj/bX8kgM9nP3QZMgL9Xz2+U1ljmWbiSSRL19e5M0/k3LJwgRcRXsQa8inN/Y9FjECd12LLMucYFjLRlAKgQwkcFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763639159; c=relaxed/simple;
	bh=bgPgs3/lv3iZ8eRLcF0yKWLEvUeR9mFnsVha+WkGpys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ni5orqEUWJbAz23jKfEXaNg3H/ie32c1FI95wB9cl1Te9ITtrdaR4TQvP35A6qXyBwoWo4UKuzt41bgjDsWvwupnnMVwF7qpbbbMmgQRsOsAUkKSd00gbcr3v/GGmk/WT2JhwMONFJNJkw5hjpx+/CZwWnZ72EUNZOjkZG5EP18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZB1TBi1c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A1DC4CEF1;
	Thu, 20 Nov 2025 11:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763639159;
	bh=bgPgs3/lv3iZ8eRLcF0yKWLEvUeR9mFnsVha+WkGpys=;
	h=From:To:Cc:Subject:Date:From;
	b=ZB1TBi1cCdAv3k9DHhoIoTrvZ8f0YiiTl4S85UtTp6W8tg7LkbA8E+I0614szbRSU
	 JuvERzHYgd2rCNiivZaGlsSX0yHmCmZ3nbCZ6e+3ZB1olJH7U0q1hm1cMFj0xsPWK4
	 fqvJVVCHUaAAkd7VpnOJwmy/t0LmvaSMsXgd7I4dsHbZ079nDtwM9lAamgJUKyQKTe
	 e9MTQ/rFgpYPrPM/RVAUePmU5chK5QJtbom/EEMYhAxKbBdCMc/FYbOdrB0s6HppD+
	 ggvPyeVd/WhH1SKfhd8iLEP2uizdbYsu3B/wZ/aG2IZL583JJ8KZGACnxeOLOrQa9d
	 hFDXtQKKSZ50w==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vM36s-000000002Cu-2Q2k;
	Thu, 20 Nov 2025 12:45:59 +0100
From: Johan Hovold <johan@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Frank Li <Frank.Li@nxp.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/9] dmaengine: drop unused module aliases
Date: Thu, 20 Nov 2025 12:45:15 +0100
Message-ID: <20251120114524.8431-1-johan@kernel.org>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When fixing some device leaks in the dmaengine drivers I noticed that
some them have unused module platform module aliases that can be
removed.

Included is also a related clean up.

Johan


Johan Hovold (9):
  dmaengine: bcm2835: drop unused module alias
  dmaengine: dw: drop unused module alias
  dmaengine: fsl-edma: drop unused module alias
  dmaengine: fsl-qdma: drop unused module alias
  dmaengine: k3dma: drop unused module alias
  dmaengine: mmp_tdma: drop unused module alias
  dmaengine: mmp_tdma: drop unnecessary OF node check in remove
  dmaengine: sprd: drop unused module alias
  dmaengine: tegra210-adma: drop unused module alias

 drivers/dma/bcm2835-dma.c   | 1 -
 drivers/dma/dw/platform.c   | 5 +----
 drivers/dma/fsl-edma-main.c | 1 -
 drivers/dma/fsl-qdma.c      | 1 -
 drivers/dma/k3dma.c         | 1 -
 drivers/dma/mmp_tdma.c      | 4 +---
 drivers/dma/sprd-dma.c      | 1 -
 drivers/dma/tegra210-adma.c | 1 -
 8 files changed, 2 insertions(+), 13 deletions(-)

-- 
2.51.2


