Return-Path: <dmaengine+bounces-4690-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A83DA5A5B1
	for <lists+dmaengine@lfdr.de>; Mon, 10 Mar 2025 22:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D14A7A84AD
	for <lists+dmaengine@lfdr.de>; Mon, 10 Mar 2025 21:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78CD1EF396;
	Mon, 10 Mar 2025 21:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGuB4osQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E601EF38D
	for <dmaengine@vger.kernel.org>; Mon, 10 Mar 2025 21:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640819; cv=none; b=QnLzpM1vdjk05QL51wC0eFl7BW8iQluzOrtTQKSxy/8PrNjU6/vn3EU8mCzDduZygWSMlrvR/IjNeJ+W+iaGpiToy9BFj0dy0kJfnVc/3YyDRiedgAsnN2HwbmoPQi9N8vNUjjhe59Gu2KA5P2LDxwR68rcjV7ieddsqu1JhXoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640819; c=relaxed/simple;
	bh=5tYrnSm6W0C8IFj6w1/1neqR26TDGmR4YV+Anvb90Vc=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iHzAc6z3m+heKlCAhNUT95JjErSVshhUP9i+J77PaPgjNkjcGZpk1NnoVHJK7Gz5+rNEGmXQ1YluFto19NmjwFZf7uYTnJlF8qCewwIsbuCGFKIKbjeEoFqloDwWaxSA7sx6RU8FKmTF5ft1ovUeOFK7XwGNjiioil2RJgeHwaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGuB4osQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58FF5C4CEEE;
	Mon, 10 Mar 2025 21:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741640819;
	bh=5tYrnSm6W0C8IFj6w1/1neqR26TDGmR4YV+Anvb90Vc=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=NGuB4osQ+CbfdopL2Fm+GL8ZoOm6DmZoRb8O0zEEPdENo8kbM3v0OHylFcuIcB2d4
	 m3SuBiYY8979ib51d9Ry9q+y8KUJizIU1OSfs/TTg3kuifK3j2ajmRNXRzCXa40Cb2
	 76Ox6eV3ywodptI84DgtEXf1SFe6JHk8Rb/YJVFIYa9O6asomGtInpDWe29mnL5ct3
	 CwzFs0fmNg+P04kIIadwFHDSzJD/yQ7Xsw2L4HatcxCcoUoMjGL+hGhCZu6oJeECOJ
	 pMnJeJtYy9VPfSZfg8AOxPfofgpqb32motKBitxlLiv0bmaoQo8xALJNLz3ZyRBtIy
	 wQrhmwuQCv2rA==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, 
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>
In-Reply-To: <20250203162511.911946-1-Basavaraj.Natikar@amd.com>
References: <20250203162511.911946-1-Basavaraj.Natikar@amd.com>
Subject: Re: [PATCH 0/3] Fixes to the AE4DMA
Message-Id: <174164081795.489187.5457406177952552709.b4-ty@kernel.org>
Date: Tue, 11 Mar 2025 02:36:57 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 03 Feb 2025 21:55:08 +0530, Basavaraj Natikar wrote:
> This patch series include changes for:
> - Removing unused PCI IDs.
> - Use of proper MSI functions.
> - Enhancing and fixing the AE4DMA engine's multi-queue functionality.
> 
> 
> Basavaraj Natikar (3):
>   dmaengine: ae4dma: Remove deprecated PCI IDs
>   dmaengine: ae4dma: Use the MSI count and its corresponding IRQ number
>   dmaengine: ptdma: Utilize the AE4DMA engine's multi-queue
>     functionality
> 
> [...]

Applied, thanks!

[1/3] dmaengine: ae4dma: Remove deprecated PCI IDs
      commit: b87c29c007e80f4737a056b3c5c21b5b5106b7f7
[2/3] dmaengine: ae4dma: Use the MSI count and its corresponding IRQ number
      commit: feba04e6fdf4daccc83fc09d499a3e32c178edb4
[3/3] dmaengine: ptdma: Utilize the AE4DMA engine's multi-queue functionality
      commit: 6565439894570a07b00dba0b739729fe6b56fba4

Best regards,
-- 
~Vinod



