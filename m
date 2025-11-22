Return-Path: <dmaengine+bounces-7300-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D34FBC7CB67
	for <lists+dmaengine@lfdr.de>; Sat, 22 Nov 2025 10:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 01E8335B391
	for <lists+dmaengine@lfdr.de>; Sat, 22 Nov 2025 09:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79332F5A2B;
	Sat, 22 Nov 2025 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewl+02dp"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4561B4156;
	Sat, 22 Nov 2025 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763803823; cv=none; b=rzJ5e4t5EzecVOJ5enu8TyqQeMmQ31ZlpdWNVXb2FYcupf9mxbk7VIQwR5iEhYpi3yhw9MYt0d82FOiNm842M2kKBZ4w1Wji//2J8yi8EmULkcG5j/dAgZe9pgRq3RxJq0BKTDN2cdB3ry2v65o3fqJ+E9zeondh3niW6tbFC0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763803823; c=relaxed/simple;
	bh=le5Y77ebR39RtnyuXWTiJ0ViKQ0rNkahzXot9h7RudA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=j2vA6ZuWxFpW7f4e73mm10wUhJXyr5ie0F3T2H1ITJ/r0gFp/aqBJibBORyPvsjmyOoSUsMl8FwJYLbCgnagxnlYM/G5p22HprnAK8fudt6Bu4s4uZk2F2HGCl6uhmCUsqkG0veM0n+pxl4biu/k4gaFGAG0V3Xz245uEfSUPi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewl+02dp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C8AC4CEFB;
	Sat, 22 Nov 2025 09:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763803823;
	bh=le5Y77ebR39RtnyuXWTiJ0ViKQ0rNkahzXot9h7RudA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ewl+02dpllftYjjAnJ5wvXFNMUq4QIznzQi5uHGR8J+SnUcWLmWs8UACHdikL+CtH
	 ypq0QnEMblapztwcRcqsnxSrV2V85MFMAG6VKO5Um8YiytJvqcWWjc5kjLtbkYLo/u
	 Hte/KUar8w9bvdyE8ltmRoWnUaz9bq9Jy9y+SKFgeQLdVHOFXRN+AW2BJXC23/IJtF
	 kyHxdLEcsGtA7pcnc8pyK7ERjZ7LpA33z/vh1xiGO9Pn3+JZjVmyI3/+wg+sNoBibt
	 voTEZ5+QKeVEY/HNCd414j5Vz5muxwBhUmV+xsQnoMsnywKvmbFlKAzrPu+3wuI/UD
	 47Cr9lt0iuLiA==
From: Vinod Koul <vkoul@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251120115016.8967-1-johan@kernel.org>
References: <20251120115016.8967-1-johan@kernel.org>
Subject: Re: [PATCH v2] dmaengine: bcm2835: enable compile testing
Message-Id: <176380382198.330370.4162683336228985033.b4-ty@kernel.org>
Date: Sat, 22 Nov 2025 15:00:21 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 20 Nov 2025 12:50:16 +0100, Johan Hovold wrote:
> There seems to be nothing preventing the driver from being compile
> tested so enable that for wider build coverage.
> 
> 

Applied, thanks!

[1/1] dmaengine: bcm2835: enable compile testing
      commit: d3e1935fba8d71ef1889cbc2d6e2447cb829070f

Best regards,
-- 
~Vinod



