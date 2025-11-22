Return-Path: <dmaengine+bounces-7295-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0081C7CB27
	for <lists+dmaengine@lfdr.de>; Sat, 22 Nov 2025 10:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 639313A870C
	for <lists+dmaengine@lfdr.de>; Sat, 22 Nov 2025 09:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAB1239E75;
	Sat, 22 Nov 2025 09:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKW+XDaU"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC6538D;
	Sat, 22 Nov 2025 09:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763802611; cv=none; b=Cd/wQhwHp1Ro9EcnBeDT3JEjJ/q0h7Fr+/KMlQvlepg++tu2Z9K9C5a3VfH0RA7SEMIWlD0h64W/SYrbZg3VMSN1iUZlgJ1/lq24XystgHLAp48iJ7rQzzEBVMelNOE1yI87Dii2IfOw0q2mEBx2AhwbPS92X/qdCPTKUJx79Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763802611; c=relaxed/simple;
	bh=mKnLZC0ZGptlCt5ADyOBy/adTiKiRqlt0ecsMA/ZiFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DeEJPn2fzaXm821sMjW/cOoxxotpKYmrSDl5MPlYl8WukFFI2vbY4rNRUE5RZrpw2sKlU2/sxwXOxrVxgf8HshPVyJrag7F+ReQ0oeyh9xy/+tJjMRncw7KQtxxiD0DFfH619DyAwWyHZZBh9vNhue03GNsFDTkavMt7aRmYsjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKW+XDaU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C833C4CEF5;
	Sat, 22 Nov 2025 09:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763802608;
	bh=mKnLZC0ZGptlCt5ADyOBy/adTiKiRqlt0ecsMA/ZiFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tKW+XDaU6Sx5e7uKABIr9GYnenWmFlsMCLQhcTQIrzYKLzwt+/GkwjTQHlseUo2SJ
	 PhCbq//qrsGkAkGgAbCyocMV6DDAv8e6/eR2L2Q6yYpuV0Vog7fI3nvwKMQTw4847m
	 PCYINEU4nKlZS2IJ+ZbGKQkPbCfQyQCkuL8RcTLz2enl6mFD7jZl8JlBV2rsBssPXl
	 xwJkzgANWr1ZvG8PSDog0bfxvqkzCSTaJgMsjpUueyWXvoxNaUqfCCYyRQIR8x7dHh
	 Wp5SCPJQNYCGAqJQbi3/ySVD0AULz71WP1sRvL3kuV2w/TnArwLnB2aVi8gZILC4MG
	 t64c4mkEbAvGg==
Date: Sat, 22 Nov 2025 14:40:04 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 3/3] dmaengine: qcom: bam_dma: convert tasklet to a
 workqueue
Message-ID: <aSF97DVdACd7h-LI@vaman>
References: <20251106-qcom-bam-dma-refactor-v1-0-0e2baaf3d81a@linaro.org>
 <20251106-qcom-bam-dma-refactor-v1-3-0e2baaf3d81a@linaro.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106-qcom-bam-dma-refactor-v1-3-0e2baaf3d81a@linaro.org>

On 06-11-25, 16:44, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> There is nothing in the interrupt handling that requires us to run in
> atomic context so convert the tasklet to a workqueue.

The reason dmaengine drivers use tasklets is higher priority to handle
dma interrupts... This is by design for this subsystem.

There was an attempt in past to do conversion away from tasklets [1]:
We need something similar apprach here. I can queue up first two though

1: https://lore.kernel.org/all/20240327160314.9982-1-apais@linux.microsoft.com/
-- 
~Vinod

