Return-Path: <dmaengine+bounces-4394-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52509A2EFE0
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 15:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53ED11673B7
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 14:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30CA25290D;
	Mon, 10 Feb 2025 14:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWBTBc1i"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40EC1CA84;
	Mon, 10 Feb 2025 14:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739198104; cv=none; b=nux3dTUp44+AIqU8Ffq0J9oypQL4TdTfCROoK6ux/O1IB4qWFD5hOel1pQAEbMQpYVAV3pZjakbBWYhrOVStCDHX2SrjTEKWARD9jKNk2vi04r9lcI0yOJBxgMkp6hJDfBtWTdB0C77nCS+ZY6XzKF+Y+f7ve+XMfHFnaMVNf34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739198104; c=relaxed/simple;
	bh=zQpynmlXcjSakEQiO6kIUD6utbpy9KackAdCD5fnAzc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eOS/oFZNBmZW7zRsLLw1jgoWoysaita4MHg+7thEzU63KpqcLDt/j3B3J779yQ9YF3NsYegMF/9k8DJNS1UxVqQoKmoP3Xp0eKgJImdvMiGURGWNcixbP8WlKHYuoOmpQ+q+xq86K3LQ/EsJFmTQlvwDpZ26xOLZv5f1sV6CIhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWBTBc1i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B71CC4CEDF;
	Mon, 10 Feb 2025 14:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739198104;
	bh=zQpynmlXcjSakEQiO6kIUD6utbpy9KackAdCD5fnAzc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WWBTBc1i/d3GOk/Wg3KbajVPSRaoVBzDiD2xxeD1znpYAMEzEqQ+k/3gBCNGxuXj6
	 EKLnumiZiPatoc7ncnXubM+pPfx+9PWusHs7VHrLUoelwJ4CXNSx8c2T9wTNgLI7oo
	 oquYQlXeqdIvtiIfLvMk9+JpXfugEIFq+yU1Jp8RGCscVg/0BlfDHhoEiqvAr18Ulu
	 QBwd17I1jYUvzYi6Xviy6x9Asbptg62D8z4/8FUx50+rhk7/fqBPoCvsmB4xfQf9Um
	 Bi+WEc/Mq25aKHm61smusgIOjp1yQV/oo9Dyte6j+SS6nIkWBcldsd+44hS0QjXl4K
	 4Ep3f+7EVZppQ==
From: Vinod Koul <vkoul@kernel.org>
To: Serge Semin <fancer.lancer@gmail.com>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Viresh Kumar <vireshk@kernel.org>
In-Reply-To: <20241007150912.2183805-1-andriy.shevchenko@linux.intel.com>
References: <20241007150912.2183805-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] dmaengine: dw: Switch to
 LATE_SIMPLE_DEV_PM_OPS()
Message-Id: <173919810216.71959.13546959155100727373.b4-ty@kernel.org>
Date: Mon, 10 Feb 2025 20:05:02 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 07 Oct 2024 18:09:12 +0300, Andy Shevchenko wrote:
> SET_LATE_SYSTEM_SLEEP_PM_OPS is deprecated, replace it with
> LATE_SYSTEM_SLEEP_PM_OPS() and use pm_sleep_ptr() for setting
> the driver's pm routines. We can now remove the ifdeffery
> in the suspend and resume functions.
> 
> 

Applied, thanks!

[1/1] dmaengine: dw: Switch to LATE_SIMPLE_DEV_PM_OPS()
      commit: 1e137d53e8471b45257d937e9773b61a88807fe7

Best regards,
-- 
~Vinod



