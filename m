Return-Path: <dmaengine+bounces-1030-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F05857CB1
	for <lists+dmaengine@lfdr.de>; Fri, 16 Feb 2024 13:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48EF71F22ED4
	for <lists+dmaengine@lfdr.de>; Fri, 16 Feb 2024 12:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC1D129A69;
	Fri, 16 Feb 2024 12:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSljmYpH"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07731129A64;
	Fri, 16 Feb 2024 12:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708086904; cv=none; b=bWcZLOEcbYJGMyvf6+w4UDWakayaHTQQEhoOBQ3W3j4VbSy+HrFP4unXZmxp1bugdEaTfzzElwVMhJeGhyUgmNtbU9OfuCu0sJuClB8QmF+SxXGoln6l8SmEwLk5Z0dNabcHXKOU/dX4d84kkmgD/F8E4RGihQOi/qocwrld09o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708086904; c=relaxed/simple;
	bh=f9p3vuSDaNnDZUBZxZEDy6+wZqVBMar8YgtJYLvVCdY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Df3F/2G9s/b8Xa4gg9teS9Ls6c4ylZlr4lqLWK0EvEe2eL4+zMo/PRpJj3aAG2ghNAZkVnIcTYlRludMgF4co2A9A68JAL1/dEPGO5MshC6sV4nptga4485mVzxV/wkR/05PbqiwzePELIYpEPnTu/y1JlSiEqcdu3+4lD24/T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSljmYpH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683D1C433F1;
	Fri, 16 Feb 2024 12:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708086903;
	bh=f9p3vuSDaNnDZUBZxZEDy6+wZqVBMar8YgtJYLvVCdY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kSljmYpH9Kg2JosIDJdxZoN4kJYhfq8yu29SWWtsoWozeQ9M4n8HAAdcNtXuNnoFR
	 ZrhbAf96iAbIHRKPh0mc1zvYUbP7LyI2Cr++jp71UPsk4+jjSUDv4RRwctU4p7+M5z
	 0ZAdxQXMQpmwGDF3L6Bgt3nIN0/UqM0BzJyJy7uAYSaxj8f1MomoKkhmWiHLK67vQb
	 1NPZwtp/FCMThwO2IBjmvcQ4D5a8h+YJ4O7IFYJkXGPFW8IRB+HfAOvxHczC3AUpHB
	 Mq4OXNSIbgD7S1yKqnlu9bomgEendjff84v0VRaKEIDGOANIqxfhT6qrubifRjxABu
	 U3HY3HwRgO1Pw==
From: Vinod Koul <vkoul@kernel.org>
To: Fenghua Yu <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
In-Reply-To: <20240213-bus_cleanup-idxd-v1-1-c3e703675387@marliere.net>
References: <20240213-bus_cleanup-idxd-v1-1-c3e703675387@marliere.net>
Subject: Re: [PATCH] dmaengine: idxd: make dsa_bus_type const
Message-Id: <170808690093.369652.14612734405908397819.b4-ty@kernel.org>
Date: Fri, 16 Feb 2024 18:05:00 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Tue, 13 Feb 2024 11:43:15 -0300, Ricardo B. Marliere wrote:
> Since commit d492cc2573a0 ("driver core: device.h: make struct
> bus_type a const *"), the driver core can properly handle constant
> struct bus_type, move the dsa_bus_type variable to be a constant
> structure as well, placing it into read-only memory which can not be
> modified at runtime.
> 
> 
> [...]

Applied, thanks!

[1/1] dmaengine: idxd: make dsa_bus_type const
      commit: cf497f3585f944ff42cc2c84453569f37a1bd6b9

Best regards,
-- 
~Vinod



