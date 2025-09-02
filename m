Return-Path: <dmaengine+bounces-6327-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DD9B3FB38
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 11:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 466AF16E5D2
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 09:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26A52F3C38;
	Tue,  2 Sep 2025 09:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbOy7aGv"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6572F3C2C;
	Tue,  2 Sep 2025 09:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806612; cv=none; b=uxmM/GKg6BNosbkX6yWanqw55M0zwp2Bi3Tq3cIkuEg4GhjB4L7BJmzcC+fyUhdueU4zc1QyziF/vuY31k2hIYwP2lEnFGpncwt3ErDSs9HjqIMRa7cmIxV5LYucCRgpTt7tFP3ElCqW4zOakA5ChC4D+plb4tBOpCP9+/gHu4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806612; c=relaxed/simple;
	bh=OsDuyThZkTpzqoGBCcODTCng/th8ueS3c8m/804jTL8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=L7O0JLwtrYan1anpUUDw6h3FaEIrfxTj3UDc/wxSi7gKwuKUGI2MfCUKTqDFBTcWJZVwNvI3dDCy45LedMiTodnYwgfoxjF6qtHul+DJP+/XE6ac46x8jHbaVgHe6Dj4r3qhzwlDutc/7n2jIVFH3AjdI8H763ikBOQgBbG+FMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbOy7aGv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1E9C4CEF5;
	Tue,  2 Sep 2025 09:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756806612;
	bh=OsDuyThZkTpzqoGBCcODTCng/th8ueS3c8m/804jTL8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nbOy7aGvNuuuJctuSdI5Z/5gsFoJgCvv7Q/BCxSGkXJ7rSEdSkDnWYibjkMW1UjmG
	 Np2QemhsEZfJhfrpJzdCBib6Vkfy6QPThRhN167qHHctwckiIpabYAUBovFqQkMxxT
	 99GqoXuJZMY6lxvdfI+njEFBILdTmK8/W/lAApI05pM2SSZaY+iq867r1TXHOGWxaF
	 X7SnmcWBsrl1MaCZdS1gHdqmDdhr0hrbQoIV4L6vr4SSa1PThb04oZZtpKKNZpxSUc
	 pufbJrUQ57+l5D50joUqpVJLM7V49ozKDJTNxnqJDib2gNbvRhSkoe0dJcvyo+egFY
	 ucy5YyXMVGNIQ==
From: Vinod Koul <vkoul@kernel.org>
To: mani@kernel.org, Devendra K Verma <devverma@amd.com>
Cc: dmaengine@vger.kernel.org, michal.simek@amd.com, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250821121505.318179-1-devverma@amd.com>
References: <20250821121505.318179-1-devverma@amd.com>
Subject: Re: [RESEND PATCH] dmaengine: dw-edma: Set status for
 callback_result
Message-Id: <175680660994.246694.16025926314639794595.b4-ty@kernel.org>
Date: Tue, 02 Sep 2025 15:20:09 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 21 Aug 2025 17:45:05 +0530, Devendra K Verma wrote:
> DMA Engine has support for the callback_result which provides
> the status of the request and the residue. This helps in
> determining the correct status of the request and in
> efficient resource management of the request.
> The 'callback_result' method is preferred over the deprecated
> 'callback' method.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: dw-edma: Set status for callback_result
      commit: 5e742de97c806a4048418237ef1283e7d71eaf4b

Best regards,
-- 
~Vinod



