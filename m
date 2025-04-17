Return-Path: <dmaengine+bounces-4910-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1178A92129
	for <lists+dmaengine@lfdr.de>; Thu, 17 Apr 2025 17:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19F703B4468
	for <lists+dmaengine@lfdr.de>; Thu, 17 Apr 2025 15:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF95250C0D;
	Thu, 17 Apr 2025 15:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnALV8g+"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C595513B284;
	Thu, 17 Apr 2025 15:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744903109; cv=none; b=hNq2Hnh0QaW57yL/GODUC4wg7YzFrzz8HQ4bwIA3V1JFn6qW/Tyb/O70YI5BXauppzJsmTU5EYsfkNiLLNsCf+NWcsSNDctNnJSAobrisdsyQRSXbc6IGPfT3QtsASJ/7MjT4YwcmXGPHwhb4LEWjCppJrxQ1agSBPVhk/DMfR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744903109; c=relaxed/simple;
	bh=9xbu6E/U6HUbkBFAwogCVcgb21ggpZRFCP7r2JkLozQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CAtJKz8kC9jdXPS1dDfHKPkbtSzT6gT22f3b0fFRPqEiCfyBmd/M2g+xeF7EaZKbKdTldD633C3HMmLa4FsNgohti/PxXoNIbY2ntY9kZczHxsEWawdunUydfr8H9AR8y07xydjaTfRRIIJhO1TwGlJ4AGbl/d+bNYbXoEgNWcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnALV8g+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDFE9C4CEE4;
	Thu, 17 Apr 2025 15:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744903109;
	bh=9xbu6E/U6HUbkBFAwogCVcgb21ggpZRFCP7r2JkLozQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dnALV8g+98scmC+MRQCl3LSxHNSi0iLze1U+d4aY3kuR5gTE2Grjrjkc3UXDT+22r
	 +C70ux/D77/k9v4dJaGWo2rVmossDVD0OlgaRoX+UtPSzeTBUKB3/ykC2zeSTSfABE
	 POwu4WjDh0EZgBskMtDysU92K4EU5dz8YzdD9UxJHHI4yFrxWM3F/5PTzZTPKbnmem
	 CIJ2HOPoMxKPO6BMmHIO3TnHcEAWzPmApeiBXg6DxCSDpdokcBKNYlWF00f2oiW1ED
	 eLQNyPgSU60nsCOFh0qK58qFT6LS8JWjqQy+RRoeYI+ufA2RpKw2Fer5Zoqw2UY8GP
	 Wq3KAYsdWBktg==
From: Vinod Koul <vkoul@kernel.org>
To: vinicius.gomes@intel.com, dave.jiang@intel.com, 
 Purva Yeshi <purvayeshi550@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250410110216.21592-1-purvayeshi550@gmail.com>
References: <20250410110216.21592-1-purvayeshi550@gmail.com>
Subject: Re: [PATCH] dma: idxd: cdev: Fix uninitialized use of sva in
 idxd_cdev_open
Message-Id: <174490310744.238609.16595322952378683226.b4-ty@kernel.org>
Date: Thu, 17 Apr 2025 20:48:27 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 10 Apr 2025 16:32:16 +0530, Purva Yeshi wrote:
> Fix Smatch-detected issue:
> drivers/dma/idxd/cdev.c:321 idxd_cdev_open() error:
> uninitialized symbol 'sva'.
> 
> 'sva' pointer may be used uninitialized in error handling paths.
> Specifically, if PASID support is enabled and iommu_sva_bind_device()
> returns an error, the code jumps to the cleanup label and attempts to
> call iommu_sva_unbind_device(sva) without ensuring that sva was
> successfully assigned. This triggers a Smatch warning about an
> uninitialized symbol.
> 
> [...]

Applied, thanks!

[1/1] dma: idxd: cdev: Fix uninitialized use of sva in idxd_cdev_open
      commit: 97994333de2b8062d2df4e6ce0dc65c2dc0f40dc

Best regards,
-- 
~Vinod



