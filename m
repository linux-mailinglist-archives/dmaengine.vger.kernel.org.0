Return-Path: <dmaengine+bounces-1090-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB97861113
	for <lists+dmaengine@lfdr.de>; Fri, 23 Feb 2024 13:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B7971F24377
	for <lists+dmaengine@lfdr.de>; Fri, 23 Feb 2024 12:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1647F7B3F8;
	Fri, 23 Feb 2024 12:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCu97ODa"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BF87AE49;
	Fri, 23 Feb 2024 12:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708690123; cv=none; b=ld/k3iCs+k6Zy5Y7RptwGW2Ny/HCq6aaFbFNe1bnPx/4e2CU9qgu1wYdHAEMXin0lbDQC3hxt+pobdr9RTFKlyrtIudVx16EVC7OtFyhA2Kir95dwr0olWazSUnT0RmZpHWtyJOEyGozxZ/jBYIOuOVRdSEMCiK9V1yZi0IXxaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708690123; c=relaxed/simple;
	bh=8ttei/SoZ4nVVvQG0FmVICpbxRitEdR0Q+N2Zw2f/PY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uLyCrHEZ476b0oUhTxmpfPugPssO6eBx48XPgan1hRD7BDf2v8awHwT/BMH2jDYF9cYr6OzM7QKsw8b38zsJI7Z6ySJuo75b3DtJNJxVBWnrktrPrTAP3SJsE1igd/9gLiJ3LrwbJJpKSiqkqKa5RpNVJOQN3pToPP1SZLiJml4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCu97ODa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 636B0C433F1;
	Fri, 23 Feb 2024 12:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708690122;
	bh=8ttei/SoZ4nVVvQG0FmVICpbxRitEdR0Q+N2Zw2f/PY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OCu97ODaCmU/+YU+2l491jOmBlSEwd7pqD5WLHBdPoIBbF+DiUnkazlSEFnsLK/Ee
	 kU03Z+jzEL7Kk7AETxGvYh6Gf6/tyE2XZm/UhcqrlGsAIHhIaI/Q1MS95KKAENq/FX
	 r4tK0RCTdrmdKxp9cTl2BCeadAgg1e6aQGCEWicaibPeUaTsmfXQgI5qOk+sWouxbJ
	 XKm7+Ocy8HAyBA2l+1viGzDKrU81qQ5gfHUXYt6XOrK430WakZ6yav4OFj7zseg1/v
	 fvfo8LQ8fU05A+yqyYzPld50DjtT71TCNLCyCZL5YPFty5pBnJ1j7DrrghXpVvFDh+
	 gGk3O2tUGnLPw==
From: Vinod Koul <vkoul@kernel.org>
To: Fenghua Yu <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
In-Reply-To: <20240219-device_cleanup-dmaengine-v1-1-9f72f3cf3587@marliere.net>
References: <20240219-device_cleanup-dmaengine-v1-1-9f72f3cf3587@marliere.net>
Subject: Re: [PATCH] dmaengine: idxd: constify the struct device_type usage
Message-Id: <170869012003.529520.17818918877700865555.b4-ty@kernel.org>
Date: Fri, 23 Feb 2024 17:38:40 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Mon, 19 Feb 2024 08:46:56 -0300, Ricardo B. Marliere wrote:
> Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> core can properly handle constant struct device_type. Move the
> dsa_device_type, iax_device_type, idxd_wq_device_type, idxd_cdev_file_type,
> idxd_cdev_device_type and idxd_group_device_type variables to be constant
> structures as well, placing it into read-only memory which can not be
> modified at runtime.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: idxd: constify the struct device_type usage
      commit: 1e0a2852a134833f6827de15cd62ea0ed19f1b60

Best regards,
-- 
~Vinod



