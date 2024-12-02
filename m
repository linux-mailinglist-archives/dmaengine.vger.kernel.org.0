Return-Path: <dmaengine+bounces-3864-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 383C39E09FF
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 18:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 064F9161347
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 17:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4431DE3D1;
	Mon,  2 Dec 2024 17:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMXHoOP7"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D1F1DD0F6
	for <dmaengine@vger.kernel.org>; Mon,  2 Dec 2024 17:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733160688; cv=none; b=hnrG3bm//TID6zm8z95ux6uSvw9dDEw/jX3hXRVVPLG04YPhEcmn71LbYt/N7CEryDLoxVfmCsdLApofwX6gH/PJUjetgHa8Czhd6VgJaCTZcEPRbALs8gH0S3fJ693z0mPUM5WCEZajBjsLpC3IHjJxrLQT8jHS8bAnoWUyUYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733160688; c=relaxed/simple;
	bh=N19Gf2OWoGif7rwizn3AGrUg7u0dM8WwQ5vvdiJuFvM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=a6ubMfnq1gBUD1HYi2uJLszo+Cbko+zjRxaOKVkS3bLlpd5Jxf5s7hltnJg/MndvnJRMh16eDobm1d6WJVHQRZ4BlfmLQ+J96X//mXMapyIufcL/0hYw6JP2abMSpDVvpkdPlFJeR7LOVvNejuONgWZyyLWf+DsEjfRTTO3ZJaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMXHoOP7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8CB0C4CED6;
	Mon,  2 Dec 2024 17:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733160686;
	bh=N19Gf2OWoGif7rwizn3AGrUg7u0dM8WwQ5vvdiJuFvM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fMXHoOP7CbLHOK8b9sB+aC5BwZdKHdsNzN3NEQUhf4CN5kDALM8lSmLebWO9sT/hn
	 05AkmzvyZ8s8Ja/DaC3l4jCRbpOnTr3qe2aYeXr0p3L2Ga2BMFHrTQ1LZOIa8lzNRj
	 gCtebNB+3Cs7vqToz7C5InyMy/1DKdHJkZGmV/ST6ZVdK/B9NRNXHqESylpVVyCw8U
	 ftzgcZEzQy/qcFuyJcpsChQhZTnbHXVfH7xH1GB7MPe3OOqPSDBCZGdyK/QmHDJTP5
	 VJsff/+b7Orqi6tVhDS4NHqmUUYQ21x1JQYZr1xjkNKNgcx3YOHPac5z+aEv9vzJjI
	 SuHobT8bvuSgw==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, 
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: Raju.Rangoju@amd.com, Frank.li@nxp.com, helgaas@kernel.org, 
 pstanner@redhat.com
In-Reply-To: <20241025095931.726018-1-Basavaraj.Natikar@amd.com>
References: <20241025095931.726018-1-Basavaraj.Natikar@amd.com>
Subject: Re: [PATCH v8 0/6] Add support of AMD AE4DMA DMA Engine
Message-Id: <173316068444.538095.16880946325745057056.b4-ty@kernel.org>
Date: Mon, 02 Dec 2024 23:01:24 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 25 Oct 2024 15:29:25 +0530, Basavaraj Natikar wrote:
> AMD AE4DMA Controller is a multi-queue DMA controller. Its design differs
> significantly from PTDMA controller, although some functionalities
> overlap. All functionalities similar to PTDMA are extended and merged
> within PTDMA code to support both PTDMA and AE4DMA for code reuse. A new
> AE4DMA driver directory is created to house unique AE4DMA code, ensuring
> efficient handling of AE4DMA functionalities.
> 
> [...]

Applied, thanks!

[1/6] dmaengine: Move AMD PTDMA driver to amd directory
      commit: e01ee7c660752923b2d0881fb20045ce79677258
[2/6] dmaengine: ae4dma: Add AMD ae4dma controller driver
      commit: 90a30e268d9bd29dac63fece0509f9f8d4835d57
[3/6] dmaengine: ptdma: Extend ptdma to support multi-channel and version
      commit: 69a47b16a51b3a52b808823f667248715ecef8c9
[4/6] dmaengine: ae4dma: Register AE4DMA using pt_dmaengine_register
      commit: 98f5a44326229d3fa33db0adb3d15bdbccb59bf5
[5/6] dmaengine: ptdma: Extend ptdma-debugfs to support multi-queue
      commit: b10b278ea003f4ca0ac81950c109ba154b84745e
[6/6] dmaengine: ae4dma: Register debugfs using ptdma_debugfs_setup
      commit: a2d09455b27b64ff6afe409fc87f0418adf2d3fe

Best regards,
-- 
~Vinod



