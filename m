Return-Path: <dmaengine+bounces-7227-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A57B3C651FA
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 17:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C3C0E4F62BF
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 16:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA282C178D;
	Mon, 17 Nov 2025 16:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIs6luad"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6646728DB46;
	Mon, 17 Nov 2025 16:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396226; cv=none; b=pMhlp5UPXj8Ij98QbI/bdRNTJ+noy/lYeviwIbt8xMD2US4XV2d7FagGAKhuoOpHAs6nGFoRhtsxZmdmvZnAp3jGs0mGLVFjblEdDD6NEHQpdYkGOdH0HfediwJu8+Z6pr5Rxq+hHsv698TixTWCbOgYKOzJNXavIzxne0uyEcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396226; c=relaxed/simple;
	bh=Ek+9PlFmKTI3ZkKVsrJWsMbdX4wOK3f36Nr2uQhaJSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SOQWk18dxImYkPbLac97g8fzIc3ciTKkW/aiiSQ6S5wi5mApv4AiCDBuP47srXVLnmwnUvnjMNRGhbqZSA2uYYP4T2Go0pB6E0/jjVc8QRIveML886YVWzaCGY6KlybcCID8t5V/RB0eERtC+5C+DrMcmzQ5mFGg+Yf5/VFEgRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIs6luad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F33E3C113D0;
	Mon, 17 Nov 2025 16:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763396226;
	bh=Ek+9PlFmKTI3ZkKVsrJWsMbdX4wOK3f36Nr2uQhaJSI=;
	h=From:To:Cc:Subject:Date:From;
	b=PIs6luadPYyg+5NWxXnW5weH1wcSuuu6nUvTufj+KyqouJ6r3krW5GvIJP38o55pT
	 1AGunfa5Y3TYrAtzXAEUK+PALE5kjjdEPdFzisHq2H5tOs+OcABzYvmtVObck7FkrP
	 xAQeO9Eh+5AG3QXqs7j3LxqvA7dh5tTMa1gzlDSErZ5zyxXY2zjibhsBGp/3NZnEck
	 fQyCVaZqov/N3NCs5kEwam9ID7PYokcNubnsoGAxw8xvYShxuQq44x3XE8jMFwEMZc
	 DeT1Alhbj06wjtqvQyr+ZIcWzn4168EemL7JLMaE242MReNx4o4fmp+2nobceE4pet
	 uPfeeEBLK9UrQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vL1ua-000000002t6-0Ra0;
	Mon, 17 Nov 2025 17:17:04 +0100
From: Johan Hovold <johan@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/2] dmaengine: at_hdmac: enable compile testing
Date: Mon, 17 Nov 2025 17:16:55 +0100
Message-ID: <20251117161657.11083-1-johan@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There seems to be nothing preventing the driver from being compile
tested so enable that for wider build coverage.

Johan Hovold (2):
  dmaengine: at_hdmac: fix size_t format specifier mismatches
  dmaengine: at_hdmac: enable compile testing

 drivers/dma/Kconfig    | 2 +-
 drivers/dma/at_hdmac.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.51.0


