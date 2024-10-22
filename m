Return-Path: <dmaengine+bounces-3406-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A729A989C
	for <lists+dmaengine@lfdr.de>; Tue, 22 Oct 2024 07:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24ABC1F23337
	for <lists+dmaengine@lfdr.de>; Tue, 22 Oct 2024 05:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E1F1591E8;
	Tue, 22 Oct 2024 05:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKyWFXEq"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48FE15853C;
	Tue, 22 Oct 2024 05:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729575196; cv=none; b=KUP4yqtaVElmpx/UVg/giBiMOjJ5I0Ie0NUZGJ+fIxB7uheij2nVzOYvyikGaqov7i2uh9Q3NxlkkI7nFPPRRV6eutc+wAo0klU8mRR4d20ir3HNPzxLXorMF3ybPlUJUjkF/QhVn8R5lijRKPWIoMHKdNXfRSmv7oE2UMvplaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729575196; c=relaxed/simple;
	bh=wRkfQUF2ISla4/Dyh3GWD4MTMdKciArME+XeWmLBnpQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hg8pmbN1MfgRQO7Q3ypYmRhHPEtnuZblY0JULeHFQ9e3MRedJSa50/RXX86TLLgtWAPlXjbEqHakki8YU2XiRAi22TWMX65bCTAxi0dUqP6cQd1G0vIofg0JiBULnWMo/nwsS3XQuH+Ey7wUb0WkoIr2Q8BcZ2rHYXzuk3pBuHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKyWFXEq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB6BC4CEC7;
	Tue, 22 Oct 2024 05:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729575196;
	bh=wRkfQUF2ISla4/Dyh3GWD4MTMdKciArME+XeWmLBnpQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GKyWFXEqXZ8HPbfwlVVPDgtak0z+GYw+i8o5UPFLoCAM9YYsVpfSh8ft16pfu0+UL
	 2kMwzFjATiwOF8q5HMPpAjtY5ild2BXbqbkUi7SBN5CdnngzYwxC1n8ds0s/9p509k
	 eIUsWTblf1voDnVnj5VLUKVNLPuTikU3xtJCv7aWfGarEMbZYD4tUtDncVoxm3SY5m
	 INJ8t29nK+PeZPKX57w5Jg4UqfzeTWKIfE/MZZKw8KRcM5DD/FY16utZHAldJzqHFv
	 DZe0ASFdupGSrAY6sCkYflhlTSgi4/sgXvOjApg8JXA73jM11huBCpWlvZTQIaXPY/
	 8E8w6vnvs+S4Q==
From: Vinod Koul <vkoul@kernel.org>
To: Binbin Zhou <zhoubb.aaron@gmail.com>, dmaengine@vger.kernel.org, 
 Huacai Chen <chenhuacai@kernel.org>, Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>, 
 loongarch@lists.linux.dev
In-Reply-To: <20240924064241.2414629-1-zhoubinbin@loongson.cn>
References: <20240924064241.2414629-1-zhoubinbin@loongson.cn>
Subject: Re: [PATCH] dmaengine: loongson2-apb: Rename the prefix ls2x to
 loongson2
Message-Id: <172957519493.489113.13854321742926152016.b4-ty@kernel.org>
Date: Tue, 22 Oct 2024 11:03:14 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 24 Sep 2024 14:42:41 +0800, Binbin Zhou wrote:
> Since commit e06c43231214 ("dmaengine: Loongson1: Add Loongson-1 APB DMA
> driver"), the Loongson-1 dma controller was added.
> 
> Unfortunately their naming has not been standardized, as CPUs belonging
> to the same Loongson family, we expect to standardize the naming for
> ease of understanding.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: loongson2-apb: Rename the prefix ls2x to loongson2
      commit: 73d03c615b9d2d05991691c1f877241105450cfe

Best regards,
-- 
~Vinod



