Return-Path: <dmaengine+bounces-5164-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A23A5AB6EC0
	for <lists+dmaengine@lfdr.de>; Wed, 14 May 2025 17:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4263D4C4921
	for <lists+dmaengine@lfdr.de>; Wed, 14 May 2025 15:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0531DB128;
	Wed, 14 May 2025 15:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOGk7Ick"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29901DAC92;
	Wed, 14 May 2025 15:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747234977; cv=none; b=XU6lx0Y3VGd2DCnxosMJuryyhx6sI+JQfPusgwnxNgRwp/aZyx7nSBoZ+brZATgC6lksphhScsJCo9oo5oBzdZYvz/Xaoe8l0WOyEGD4OX3/bf6aIKN8IOSbSKV1ryUGAtR2XrAoM6G+5Yronl6bxBSjyv3af1RyTU4zb42Qhqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747234977; c=relaxed/simple;
	bh=YIBrPvNT4ff4M4RrrZoQ6xF9GUrPItTAW+82LY1RaXA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mU17CzPwD21TkCuPz33asaE3HS2/Ra6a2nHRAEvIzEZU+l0WRooBYrAShN/Laj3jTLfXFzWkGCHZV+whuw4LVOyptA7mhRq57QSkxV41a5NvS6Puf7wT6qZ1ZOguaXmPwt79yD1EmAohfOJ7EhW6w9WkMlaEoIvUE17HgbNkuEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOGk7Ick; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58C5C4CEED;
	Wed, 14 May 2025 15:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747234977;
	bh=YIBrPvNT4ff4M4RrrZoQ6xF9GUrPItTAW+82LY1RaXA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MOGk7IckmQrGXfOghZRLx12bIC+Df40khql7C6Vr7bWMmKEBwbj3O5vzOl5hCprUf
	 uVu2tW3so2AjfdL6B2PNMtN55pc8fTGkwfuNmlre/r5WM2o6tJHK6JORFTzygHvVe/
	 fS2yGGH77RxdZwOkyct8X0cft6jGezsvnoEbSQMWMizXTBsLMQVFMjTKu64l6DuKJD
	 WVsMph6aZua0GeUeJ9hDT37It3OKMrxYCu4aHm3OzB/A/8+RKKazgkddZP9yTpe95c
	 qpqYOM5opVoOFRbv2kpbiwOa1b1RxuJOWZRh2aWTvoqCu/gI16sAWStI9LPSEcmL8B
	 b02WR7vy7kkrA==
From: Vinod Koul <vkoul@kernel.org>
To: Devendra K Verma <devverma@amd.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 manivannan.sadhasivam@linaro.org, michal.simek@amd.com
In-Reply-To: <20250513070314.577823-1-devverma@amd.com>
References: <20250513070314.577823-1-devverma@amd.com>
Subject: Re: [RESEND PATCH v2] dmaengine: dw-edma: Add HDMA NATIVE map
 check
Message-Id: <174723497560.115803.1645439579357389274.b4-ty@kernel.org>
Date: Wed, 14 May 2025 16:02:55 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 13 May 2025 12:33:14 +0530, Devendra K Verma wrote:
> The HDMA IP supports the HDMA_NATIVE map format as part of Vendor-Specific
> Extended Capability. Added the check for HDMA_NATIVE map format.
> The check for map format enables the IP specific function invocation
> during the DMA ops.
> 
> 

Applied, thanks!

[1/1] dmaengine: dw-edma: Add HDMA NATIVE map check
      commit: d7130902abb40e96f1ff486b9d143c006bf553e0

Best regards,
-- 
~Vinod



