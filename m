Return-Path: <dmaengine+bounces-2801-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB36948069
	for <lists+dmaengine@lfdr.de>; Mon,  5 Aug 2024 19:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B957281B3C
	for <lists+dmaengine@lfdr.de>; Mon,  5 Aug 2024 17:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CBA1607AB;
	Mon,  5 Aug 2024 17:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHZoSXni"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BE016078B;
	Mon,  5 Aug 2024 17:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722879462; cv=none; b=TlJAZEP+dwEiZOVm41lw/6gYdRiutyLDbGume/Pv3YgfrKXKECUPpDIi2Qt8UasFZPQYSkQIgt/mEt/H+25ntntCIQeneZ1PtbTYzpwbqX/zobAjqQZ7WjeBlv/ppSUdTXJMDUxM9DtJ00dVPX478e2VX7qqENi8JQOwvEzSFx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722879462; c=relaxed/simple;
	bh=yLtzr2aO7AIP8QNz0+jEnlkif5Dk0bYNnqY88BQdzZY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Euzl4Q48N7FnUV96xU8fAnqRdopWemHzL3QRQN3B5dUzRpf/Vk3f/fR8LE/PNUqWtReskLzAYbb4OXeFrBLbppLAVEGcXLqKF3VrXockJJ7yvPgvpqZIi8YEQ7MwW76Vv1tRAn4lhF8jYnp+HyQXh+DfWy5YPVZKUO9/Uq6Za+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHZoSXni; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF73C4AF0B;
	Mon,  5 Aug 2024 17:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722879462;
	bh=yLtzr2aO7AIP8QNz0+jEnlkif5Dk0bYNnqY88BQdzZY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FHZoSXniW16ujqNvuDOM9bnp281xjMPHgRQQ4wxLXs4yg2y3tv9DOa+zHwm91IJ0u
	 clRjcbGwDjJgLjRk2nj0XMJFijp0v9jIf+A2fYFkd56v59/rPwArqHYszAJHVPTszL
	 MaCRqLCner6vZQTIMdOVqcoxrNqmrlzjzEF9cP+zop4owOV55u7rmslAGoMMQgVX2N
	 bXxAVokQzj3kHdc992vQttMgZX+p8lTXQBHigL72EUaU+5Gaeek0jfZ2201SoIVaUc
	 hFOQvYpV/9Q5zFnIGOC1U2wZU+taB5ikp8Pr4mSpJz3reJD4dGb9/HygqaaBTheMx6
	 H4DDYrqlqgrDQ==
From: Vinod Koul <vkoul@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, Kees Cook <kees@kernel.org>
Cc: dmaengine@vger.kernel.org, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20240716215702.work.802-kees@kernel.org>
References: <20240716215702.work.802-kees@kernel.org>
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Initialize sglen after
 allocation
Message-Id: <172287946012.489034.4427112322587922034.b4-ty@kernel.org>
Date: Mon, 05 Aug 2024 23:07:40 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 16 Jul 2024 14:57:06 -0700, Kees Cook wrote:
> With the new __counted_by annocation, the "sglen" struct member must
> be set before accessing the "sg" array. This initialization was done in
> other places where a new struct omap_desc is allocated, but these cases
> were missed. Set "sglen" after allocation.
> 
> 

Applied, thanks!

[1/1] dmaengine: ti: omap-dma: Initialize sglen after allocation
      commit: 5e5c793c7fc47219998465361d94510fdf55d83f

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


