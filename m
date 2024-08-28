Return-Path: <dmaengine+bounces-2990-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4313B962F9E
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2024 20:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01001285FA4
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2024 18:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0F31A7AE3;
	Wed, 28 Aug 2024 18:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+KkCymX"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F260A1A76CD;
	Wed, 28 Aug 2024 18:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869014; cv=none; b=eVhyKrverFHWkRceJTLB13iHEmiyCxYZaMakxMs0pQnSdpIDv7CiB9lxXB2ZSFRvs32RHmUIFNw1jOyagkjccvVv+s7RCA8AfZvXQB5rXsxGaDogFiyDRMZFIPuOkEBjgu8cVzZHnVksMQmgOVhVJfjDoJdUhr4JBgR14oCi8ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869014; c=relaxed/simple;
	bh=hplis3gYskb0eduBPuIJXJwII1zf5os5QAY6s5xn1A8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=efzSj0q1Gnr/SYtqZ7g89ZQ6kcXwwFuqSBVlvOWwNyLZAizK6YrOY1J393aOZkpYMyZy78bWQadj+IUz87tZJm6CXWj3KEbEoXP01AVlUm6X7unlJunYCOZBLLKzF3zuk+NIa+dAtJuY26PSkt1ONU5GMffQ4pBrW/YNCJVkqWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+KkCymX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6758CC4CEC1;
	Wed, 28 Aug 2024 18:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724869013;
	bh=hplis3gYskb0eduBPuIJXJwII1zf5os5QAY6s5xn1A8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=A+KkCymXKIYbr9uesQjruvWQvEvkWp6wVPz8QDOQMZuTKEBe9ybU6FtJ0jFYFjuNw
	 NbQnmpsJg69LZxFnAwiNbTEkOcrd05wRbp3EBPwVGpMtCsNnmX8/BSXJYlO7CMFHbp
	 27dMov5vSf9Hpkm5DWSc3setEqSxEB3Wboy9qCvTYPFNbGqejE1BqSMH0qU1mOvl6h
	 ns9XU1EjBrGbAO3jymJNsd5jj4JhIcoI27ALWsS2VFFXfWT72MKaec6NVOc+uqiyXb
	 JbGhnCGNHfbYq8BhvIpuXb+G1mgfRPArLLnwYxCTzXKnaD3Aswndd0NvpiVi6Ftbio
	 A/GQ/B4xM0LZw==
From: Vinod Koul <vkoul@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 dmaengine@vger.kernel.org
In-Reply-To: <532e7e2816ccf226f3ab1fa76ec7873bc09299d0.1724258714.git.christophe.jaillet@wanadoo.fr>
References: <532e7e2816ccf226f3ab1fa76ec7873bc09299d0.1724258714.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] dma: ipu: Remove include/linux/dma/ipu-dma.h
Message-Id: <172486901204.320468.809772765527210614.b4-ty@kernel.org>
Date: Wed, 28 Aug 2024 23:46:52 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 21 Aug 2024 18:46:33 +0200, Christophe JAILLET wrote:
> When this file was renamed in commit b8a6d9980f75 ("dma: ipu: rename
> mach/ipu.h to include/linux/dma/ipu-dma.h"), 4 .c files have been modified
> accordingly:
> 
>   drivers/dma/ipu/ipu_idmac.c
>   drivers/dma/ipu/ipu_irq.c
>   --> removed in commit f1de55ff7c70 ("dmaengine: ipu: Remove the driver")
>       in 2023-08
> 
> [...]

Applied, thanks!

[1/1] dma: ipu: Remove include/linux/dma/ipu-dma.h
      commit: 654beb75ca95240c00c78be0bbc2ea66a125a997

Best regards,
-- 
~Vinod



