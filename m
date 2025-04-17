Return-Path: <dmaengine+bounces-4912-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6F2A9212E
	for <lists+dmaengine@lfdr.de>; Thu, 17 Apr 2025 17:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0731D5A5487
	for <lists+dmaengine@lfdr.de>; Thu, 17 Apr 2025 15:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26E6253B6D;
	Thu, 17 Apr 2025 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ei5U8il0"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D00253B6A;
	Thu, 17 Apr 2025 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744903114; cv=none; b=pHxIVux7Q0hP1URhdW/oyJzhLCH9h2Kk6hiMmbWUJ2NBNOKIpvW5j7DAdNgYdlUcM3xAhEkg8zak85igTo7c0XNlwlivMgktPdM870HaIENVqrhdFLVMaI8uyYwwMOFGrkLuOmfixxfKVVlmOo2gDrnvFRMH07461a6Y+fvmByg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744903114; c=relaxed/simple;
	bh=UuuP4g20z/t5ftBMRSWB0X8ubb330SPW/4gYaEaFvxU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=soiafwYqssIKHG5bEvtiYFSkTvGdoCWiI9ZXYPYXMfOnIcKphOHGkJVhwXAVlQOD/H3YazkmgdXDAT+NHxFZ9ieQ+Qu6742nvCDr5UjkcSk9VVoGOtF5eAgfeuU9cUbA3zwmvm/7fJVNmw3z/6bzDAgcOz0OyNbuidD8FBq1XiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ei5U8il0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A3DC4CEEC;
	Thu, 17 Apr 2025 15:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744903114;
	bh=UuuP4g20z/t5ftBMRSWB0X8ubb330SPW/4gYaEaFvxU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ei5U8il0KSMZaUEY/ocPNMKw8kixUv9JfS2CmIc036GOLty2naWi400R3QNENNqbt
	 G4qhS8MJH3lTFII/Ytnh3/CF4if4AZ66+ruJI6KMBjspXaLnyzNp7fXBGFDoH0nJPp
	 cjrg+lUJaFFQfZTX0NnQ06f9ey5H9SfwCnV/LchMXD10hktpgFnO0tz3MmGUI9NWdJ
	 rObuQwgbVbgNfJmMBScjx/X7twqT8aXvkfrrpM54U/gdU1glb5F1QrVx3DDULmtNjP
	 mt/Sju+x8o99iLb9bNGMVDWdTk9WHdlxwjJCNZKHETl63Gx/ix2n7fcThhVfIxjyO5
	 4tLvYaIiVb8pA==
From: Vinod Koul <vkoul@kernel.org>
To: peter.ujfalusi@gmail.com, grygorii.strashko@ti.com, 
 Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
Cc: vaishnav.a@ti.com, u-kumar1@ti.com, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20250417075521.623651-1-y-abhilashchandra@ti.com>
References: <20250417075521.623651-1-y-abhilashchandra@ti.com>
Subject: Re: [PATCH RESEND] dmaengine: ti: k3-udma: Use cap_mask directly
 from dma_device structure instead of a local copy
Message-Id: <174490311144.238609.16715270633918698511.b4-ty@kernel.org>
Date: Thu, 17 Apr 2025 20:48:31 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 17 Apr 2025 13:25:21 +0530, Yemike Abhilash Chandra wrote:
> Currently, a local dma_cap_mask_t variable is used to store device
> cap_mask within udma_of_xlate(). However, the DMA_PRIVATE flag in
> the device cap_mask can get cleared when the last channel is released.
> This can happen right after storing the cap_mask locally in
> udma_of_xlate(), and subsequent dma_request_channel() can fail due to
> mismatch in the cap_mask. Fix this by removing the local dma_cap_mask_t
> variable and directly using the one from the dma_device structure.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: ti: k3-udma: Use cap_mask directly from dma_device structure instead of a local copy
      commit: 8ca9590c39b69b55a8de63d2b21b0d44f523b43a

Best regards,
-- 
~Vinod



