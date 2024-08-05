Return-Path: <dmaengine+bounces-2806-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B448948078
	for <lists+dmaengine@lfdr.de>; Mon,  5 Aug 2024 19:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA182B2303D
	for <lists+dmaengine@lfdr.de>; Mon,  5 Aug 2024 17:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5EE166F2B;
	Mon,  5 Aug 2024 17:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBdt684H"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3477166F26;
	Mon,  5 Aug 2024 17:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722879494; cv=none; b=T1egf/TWwxrgOjq6lvA5/EBiyMI64+MWKXYbNKvH9jtZBvab50k7WMi0SrR3zn6I4eP47wywo02EjF/CUClikLsreubn7tGlttbNrn6v5Imlolo/FgpcclqgN4yplxhUbByuhd9TG/RjAtATvHxjMI+MMB+LSafN5PGVnmirL6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722879494; c=relaxed/simple;
	bh=qyXSg/RNLLhUW34Z+pIyrpvSpc7+K9ig9vr9k3MSS0A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IJvYoX1FRV3Ar/C0JU6i+ii+Q7cCCOqU3nc8puokLlbQNnrqwSWUQ9jE8QmnPw+gW0VrdfD4N/4PohXtRIG8L8VHatGeh+p/93DALxCQt1Z/J3NCWrTQ+Au2HYOAZDNTTBruJa7pNKtHie08d5foxaCP3Bh8qKwBpJOSdRHXN00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBdt684H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52A4C32782;
	Mon,  5 Aug 2024 17:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722879494;
	bh=qyXSg/RNLLhUW34Z+pIyrpvSpc7+K9ig9vr9k3MSS0A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hBdt684H3ytdF5AxgRSLYbAK+N2BgWX28lCOb9HPtO6GEPY2iwlBAKMZB7p5sbKYm
	 IfnGSEVKSNaxJaBRfNfCiVKdpEKq8vn9PiMBpk7+xuqNtFVmWmBmOZtfY5IC3YdNMq
	 qcxZE5GG2+GVaK4ntJ6e23UdV9K5FaaHoQmocH3+yJnQLmCFWKEgfJ4ixyLEdNVEdc
	 mYFDcItOsgo/LEmHu6ZpnzY+kdBhAaXNjqIqEPbDZzqiFyteD1BizWqjtHg8SseD2E
	 Cg7sIU6jmHKZYHu010sAbagA4i+godiqFrAgCYI2We85TODQ7msVjb6+8bnwO/E//X
	 IO+esbYIUxYpQ==
From: Vinod Koul <vkoul@kernel.org>
To: fenghua.yu@intel.com, dave.jiang@intel.com, 
 Chen Ni <nichen@iscas.ac.cn>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240711013436.2655373-1-nichen@iscas.ac.cn>
References: <20240711013436.2655373-1-nichen@iscas.ac.cn>
Subject: Re: [PATCH v2] dmaengine: idxd: Convert comma to semicolon
Message-Id: <172287949257.489137.6426842994757918949.b4-ty@kernel.org>
Date: Mon, 05 Aug 2024 23:08:12 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 11 Jul 2024 09:34:36 +0800, Chen Ni wrote:
> Replace a comma between expression statements by a semicolon for
> more readability.
> 
> 

Applied, thanks!

[1/1] dmaengine: idxd: Convert comma to semicolon
      commit: 8bce5522a13107605709c3b253c09cb1f90850e8

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


