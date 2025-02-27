Return-Path: <dmaengine+bounces-4584-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CA8A47CE4
	for <lists+dmaengine@lfdr.de>; Thu, 27 Feb 2025 13:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1735618928C4
	for <lists+dmaengine@lfdr.de>; Thu, 27 Feb 2025 12:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B67242AA5;
	Thu, 27 Feb 2025 12:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyGHEUPd"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0826927005C
	for <dmaengine@vger.kernel.org>; Thu, 27 Feb 2025 12:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658061; cv=none; b=oY7BN1/BgZtcTjIhwbhSP1TF8+ICwseUF+NH+oHDDfNrqXGEG/XNuqSIFuzXZjvPHbyXFqpFSwHbmB2yt3GeDZSqZs7hhfXaui12BVFc8RYG2Lql2n45kVrIBjQ3+5zGdfw4Py6JWH9QYpOD9QEMFddSh5pdi5c7xzlLelUgngQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658061; c=relaxed/simple;
	bh=DcilghX7Y+HrGgkzTIAtQ0rCbPT5/YV6C7nx30r4kWE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YfH9QfX+TIeDzo5SXfT6iCxvld0BqUBA8TkKy8y78lNO/bl/94UoiO4JQxuLTKXhgBIED2JDiNUQVHTBXwm3iZAqV916rwMZAd/d7XN1RBHXSIrH3KL646QPQdJltcY4pi5WjY3zoP33r/us3fZJhcTsafiBA6Z+TgdLHTnOhQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyGHEUPd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1DBC4CEE5;
	Thu, 27 Feb 2025 12:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740658060;
	bh=DcilghX7Y+HrGgkzTIAtQ0rCbPT5/YV6C7nx30r4kWE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cyGHEUPdrJyucAzTTofIphquHOn5vM1cWItJInsXPK4OzvAKSmxBQll+oo/Ggj7+u
	 Da8xYWJqOSCdNrs14p+KY9ZOspizpfipXgTfMsfDOAiobPMVmWDRaDgPEzLga/XhzT
	 DOXwDyOCQekFFRVDMw+mpzz0bpkvZlJ2WqqaFwUSi+4+jSxtrl155RC4KlxVsl054W
	 EES+QI0zh5VwRA/5VFUTWHe5ltl+9RCGewCEIAxvAmRNNBj2gZkjB+kcS0RTVVdoEX
	 22ahhwKZuHpVG5+Ib4Laa0UDAuyyaESgTpJTUHm41Ug4YtjhWzj7E1/LHSUxZ+iGFh
	 xz3dMxauzX0eA==
From: Vinod Koul <vkoul@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Stefan Wahren <wahrenst@gmx.net>
Cc: Lukas Wunner <lukas@wunner.de>, Peter Robinson <pbrobinson@gmail.com>, 
 "Ivan T . Ivanov" <iivanov@suse.de>, linux-arm-kernel@lists.infradead.org, 
 bcm-kernel-feedback-list@broadcom.com, dmaengine@vger.kernel.org, 
 kernel test robot <lkp@intel.com>
In-Reply-To: <20250107144251.101912-1-wahrenst@gmx.net>
References: <20250107144251.101912-1-wahrenst@gmx.net>
Subject: Re: [PATCH] dmaengine: bcm2835-dma: fix warning when CONFIG_PM=n
Message-Id: <174065805671.367410.2787054913133738713.b4-ty@kernel.org>
Date: Thu, 27 Feb 2025 17:37:36 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 07 Jan 2025 15:42:51 +0100, Stefan Wahren wrote:
> The old SET_LATE_SYSTEM_SLEEP_PM_OPS macro cause a build warning
> when CONFIG_PM is disabled:
> 
> warning: 'bcm2835_dma_suspend_late' defined but not used [-Wunused-function]
> 
> Change this to the modern replacement.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: bcm2835-dma: fix warning when CONFIG_PM=n
      commit: 95032938c7c9b2e5ebb69f0ee10ebe340fa3af53

Best regards,
-- 
~Vinod



