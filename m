Return-Path: <dmaengine+bounces-5644-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94289AEAA05
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jun 2025 00:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EF677A4C8A
	for <lists+dmaengine@lfdr.de>; Thu, 26 Jun 2025 22:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7E52367B0;
	Thu, 26 Jun 2025 22:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYksLS88"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD5123505E;
	Thu, 26 Jun 2025 22:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750978091; cv=none; b=P9yveNaNqzKrd6DyRW36BWWxScJHRiT94ogT7mYAaKi9gnhXX+qOQx/PU462ZmjDEAxwDnugcmzL8SmIs1g3DSbu9AAuj2ibi90fQsfQ5nYc6xtALvBoWDij9StcUc4wAvfMnpEkzW0drlIZPaZVT+eMvuZOal3hzG3+NiDEfdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750978091; c=relaxed/simple;
	bh=hSygeHkDhS+YkJFMpecHyCBgLpOxEv9yB8zO6lSVNG8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AOwzXp0SrtNkFd0yw1kukL9iBkTHl+6YmxCPLYvlWxHGAi5eH66Iiq/fVCLoT9dKooySYbhcyb6b2dvo7ByauopHHUTFzneNVNVM3vJvMEimy4iqENZhGXH4zqw07DwkTeaMzOkX26AleoAtRNsv3zJaDSuFTATAhcVhifFSg0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYksLS88; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C47C4CEEF;
	Thu, 26 Jun 2025 22:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750978091;
	bh=hSygeHkDhS+YkJFMpecHyCBgLpOxEv9yB8zO6lSVNG8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jYksLS88uoW5ZfxZ8y0tPu47NMYfPfULNP4b0L19nolyKzHxwuHVf0T43PhlKI1az
	 QqSFU/9HiGg1YJX5EDjy8CNvhS+/6gr6NL35JniUooivJI0MOiA+44dJFp7UY0zX85
	 DiIF40YnSD0+4odO2tt4F4zfp+fegfxKwaJ5mIEBz+yr6LfoRQDVrnVex4DAUiyOdZ
	 +7WIEj8UbsnuYAi6GucZLcVVZ0drTWV1xGGPfh5q5B+4Wxwo0JOt6jss8rSF/W55sz
	 aJq7I+ZaLdQ4VpK1AYLBWhR2AATtLxATdWFQ2T5/UU5mfJLXhpUUArFOTBtjXknSx3
	 BS8cMDzCWsxNg==
From: Vinod Koul <vkoul@kernel.org>
To: dave.jiang@intel.com, vinicius.gomes@intel.com, fenghuay@nvidia.com, 
 Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250521231331.889204-1-anil.s.keshavamurthy@intel.com>
References: <20250521231331.889204-1-anil.s.keshavamurthy@intel.com>
Subject: Re: [PATCH] dmaengine: idxd: Fix warning for deadcode.deadstore
Message-Id: <175097809088.79884.9986625120938692414.b4-ty@kernel.org>
Date: Thu, 26 Jun 2025 15:48:10 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 21 May 2025 19:13:31 -0400, Anil S Keshavamurthy wrote:
> Deletes the  second initialization as the value stored to 'dev' during
> its initialization (struct device *dev = &idxd->pdev->dev;) is
> sufficient.
> 
> ../drivers/dma/idxd/init.c:988:17: warning: Value stored to 'dev' during
> its initialization is never read [deadcode.DeadStores]
>   988 |         struct device *dev = &idxd->pdev->dev;
>       |                        ^~~   ~~~~~~~~~~~~~~~~
> 
> [...]

Applied, thanks!

[1/1] dmaengine: idxd: Fix warning for deadcode.deadstore
      commit: 8c2442663f683f4fabadb3c491821169da6c89a8

Best regards,
-- 
~Vinod



