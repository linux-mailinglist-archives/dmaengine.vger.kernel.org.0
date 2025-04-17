Return-Path: <dmaengine+bounces-4916-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E111AA92133
	for <lists+dmaengine@lfdr.de>; Thu, 17 Apr 2025 17:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F22E7A5952
	for <lists+dmaengine@lfdr.de>; Thu, 17 Apr 2025 15:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926E925334A;
	Thu, 17 Apr 2025 15:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0QzjTbV"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E349253F3B
	for <dmaengine@vger.kernel.org>; Thu, 17 Apr 2025 15:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744903133; cv=none; b=YQxKtGUL4PmEiUQBjZeKMR7SpPpOomauKfyk4wZi8z2h3AzOvEvO3Yda1/QtSjgi8wY7FTv/sq+FOO8LbbYRDIxT+AaaKVDulEYltpkWYLpmAtwoE5KGRGnFvEuZeSxAe0d82jQqqYOxbad6O5TysEme+8pg2o4+mufDzY4h0ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744903133; c=relaxed/simple;
	bh=WPJ5t440FCFjkOmrLoMu0Nkxq9gxCd0wbnYIq6mNJoM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=i0WBK+bL63HCqZKqVmTBYsPP9SZhq/+LQE/XWHLSP2RLJVPHlnsSMNRUuwy/U0YJcEU/zpCXsqQZt1LtwrTDxFzwKa0QD2umCCkfsibK3ovZzhuSZM377W3elVK3Y6jka/CqGAWlQNQ9W4QktGNlvb3WBQl8UFJ9AbAr+tgWJdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0QzjTbV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200C6C4CEE4;
	Thu, 17 Apr 2025 15:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744903133;
	bh=WPJ5t440FCFjkOmrLoMu0Nkxq9gxCd0wbnYIq6mNJoM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=V0QzjTbV3MUOoU0Oah4Q6GMSDmxFNd+j3umaAKyLwI6bjhNzS5HdatIqDHiGWSZ/P
	 hmH+WQrh53czQTMk6sUZB7scHvYZjLS4RGwCX46nBL/1jfbUpl6quhmLgDpN+O8cH/
	 APT1sCmgt+Slry7mHKUGKmFNQ4J7ByvIGso5hZpXaOjI1pRLr928z3nUvCRWDRT1bY
	 83W8saxB2+yQDF/blWYPD/QWavBM/qfU3Qb0UCkUx3MNXdtRXLijQZ1CrfZoBhRZef
	 M5UtHgic6C3P5TNoFR5OLCkVemuYV7ezMNcKRdXlB6yqpZJTlepl33Go69rg2xCI+H
	 i5ydfTYxmM/YA==
From: Vinod Koul <vkoul@kernel.org>
To: Ludovic Desroches <ludovic.desroches@microchip.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org
In-Reply-To: <20250410065804.3676582-1-sakari.ailus@linux.intel.com>
References: <20250410065804.3676582-1-sakari.ailus@linux.intel.com>
Subject: Re: [PATCH 1/1] dmaengine: at_xdmac: Use pm_runtime_put_noidle()
 with many usage_counts
Message-Id: <174490313175.238725.14166684249182201848.b4-ty@kernel.org>
Date: Thu, 17 Apr 2025 20:48:51 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 10 Apr 2025 09:58:04 +0300, Sakari Ailus wrote:
> We're holding more than one Runtime PM usage_counts in
> at_xdmac_device_terminate_all(). This makes pm_runtime_mark_last_busy()
> redundant and pm_runtime_put_autosuspend() misleading. Drop
> pm_runtime_mark_last_busy() and use pm_runtime_put_noidle() to decrement
> the usage_count, except in the case it may be the last.
> 
> 
> [...]

Applied, thanks!

[1/1] dmaengine: at_xdmac: Use pm_runtime_put_noidle() with many usage_counts
      commit: 99b201481f3fe44eac5cc05238a715b05bca4df5

Best regards,
-- 
~Vinod



