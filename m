Return-Path: <dmaengine+bounces-7698-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D8ECC48B8
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 18:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65F6F304E546
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 16:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2FD314D2C;
	Tue, 16 Dec 2025 16:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKJ9Batp"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17BE313E02;
	Tue, 16 Dec 2025 16:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765904368; cv=none; b=TJDVWTjKNzEGyzlAG51kNYdOtNgrV7lKbakFMdZx5JWvYP5dmId4Tyr6zUUKmpam9hd3aPmlFt56HMNBjlz88EyRaUNuMx9y6NOfOvUfriMz76Zp3NPJ1ncq0dSOsFi8rVnSUL6edDGa7VruI8PrsVkl5nTX5Si01jXiN1Mq1uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765904368; c=relaxed/simple;
	bh=E2b1QseqTisF5iwWpBtbuAgacFNg+u4tXoabApuiEgc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hDE5Z0BJCEf8ac/+R12Dwha5YRGrxinigHjgtPhFvn01uEGfXADc75NNuWkVfXtRaYCXghnmG9NgiUVlgTvG9adn/TO6N7Avjkuj4gQxi6bTZkCxlUsKEipNBx6YoElXzj/1K7D32mTCLvriMxqfkinQn66VxR28UTA7wHq2zj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKJ9Batp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 936DFC4CEF1;
	Tue, 16 Dec 2025 16:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765904367;
	bh=E2b1QseqTisF5iwWpBtbuAgacFNg+u4tXoabApuiEgc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=EKJ9BatpAOLYo2/apV3uFhZF/WhTJ42t/DexuAFnEDxy0a8LgUCaqvyrzm0TSI4GM
	 s8ibRUY39kCo1TTn5eslRsQZXIVHVXeYzNAn2nQv/3McBFw2GKH5rRMT/sQgflPvqg
	 qx7ntHQ/0t/QF4+er+dQAPzDukFi85zHXFOmbaQUJO04NwmiTKiQtvSG6uqlxgsrWi
	 aVqdh7eA51PA7RgYs53QLGGKf6LLjgTGW0Ty7V+EMwjFrGmz8v6hHpI5yLCkqIGkEj
	 5zZ0v6hvbIfIkr53djvJFeHgOhaF73v3TcEYSGi8h93RXuxTXhGuxNtFXNYwXGu/Nh
	 zPdVC4p78VxLg==
From: Vinod Koul <vkoul@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
In-Reply-To: <20251106-qcom-bam-dma-refactor-v1-0-0e2baaf3d81a@linaro.org>
References: <20251106-qcom-bam-dma-refactor-v1-0-0e2baaf3d81a@linaro.org>
Subject: Re: (subset) [PATCH 0/3] dmengine: qcom: bam_dma: some driver
 refactoring
Message-Id: <176590436523.430148.5029789142471290220.b4-ty@kernel.org>
Date: Tue, 16 Dec 2025 22:29:25 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 06 Nov 2025 16:44:49 +0100, Bartosz Golaszewski wrote:
> Here are some changes I figured would be nice to have while working on
> the BAM locking feature.
> 
> 

Applied, thanks!

[1/3] dmaengine: qcom: bam_dma: order includes alphabetically
      commit: 892f2bb487916cb15432912cd6aae445ab2f48f0
[2/3] dmaengine: qcom: bam_dma: use lock guards
      commit: 20f581834aacd743b3d95bbbb37a802d14cf3690

Best regards,
-- 
~Vinod



