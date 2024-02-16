Return-Path: <dmaengine+bounces-1028-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5CF857CAD
	for <lists+dmaengine@lfdr.de>; Fri, 16 Feb 2024 13:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FDC11C2274F
	for <lists+dmaengine@lfdr.de>; Fri, 16 Feb 2024 12:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFD8126F2E;
	Fri, 16 Feb 2024 12:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhz4PpPV"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5623778B66;
	Fri, 16 Feb 2024 12:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708086891; cv=none; b=fhjzUKqjEReaYqBCpap0/LhCro34zrSyYKvpMhHtY88opNgQxrzknG2dycImKi8jZSmhrGDhNSeWl5traSJo5ToWSm86ZmdJwLLrf1Fz83xxqvFAdd0a0f4t0bp47EBmPNg3UmcLNf8T1rnA3nYeVXEp6oDtmOMRV4WF/7zfwTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708086891; c=relaxed/simple;
	bh=9IWnQCphSFE25vnBopHpLmYSYg2m3v56/19BI2qavUQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aeSvbXk3rk+Mhg/yjOXKQrN8kLa/IAy7HY4ZIEbrGgiEsCFHSGFuh/OlFcJbdnws7qZfOivn23W162cZw0j5kZFLFw+ej0SAaf/RSi5hx9bvXbGqqtCWfVKnQlqAXC1UFzGccc0/rRx/VWfnjcgmGCEv9jFiGGZs5L1fpQEylFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhz4PpPV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26F9C433F1;
	Fri, 16 Feb 2024 12:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708086891;
	bh=9IWnQCphSFE25vnBopHpLmYSYg2m3v56/19BI2qavUQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nhz4PpPVIq6oYVeaO2v1+VK7w+TFCHxqQjLImPKISP9mMYUQTFaTm9vDHz2t/zn4B
	 hD84oBl3a2IG+N+7z/eD1tpT+acgu+HmBzL5+fuq9u28DWeoiZO6mOOjin35fHGNPn
	 u1jPZxPI68bvt6oxm0u49IyDbu2DsjpVcUpZx9+19Pw4m9o+od9Zb/aushz//l66Q+
	 2spi50tiL3IfeiqL2WYw6sk4K67BCPQCECnc58OU/WQ/lFOTjmJC90j0T5YCEaDI2k
	 eAl15lkvqo7+dAzZu+y/iTHU3W4hU3vnOcx7UfyN41FWFnwdYzc6UKna2qB0d5bPan
	 RU9j8G423QG4g==
From: Vinod Koul <vkoul@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20240215024931.1739621-1-fenghua.yu@intel.com>
References: <20240215024931.1739621-1-fenghua.yu@intel.com>
Subject: Re: [PATCH v2] dmaengine: idxd: Remove shadow Event Log head
 stored in idxd
Message-Id: <170808688943.369567.17829414999470359009.b4-ty@kernel.org>
Date: Fri, 16 Feb 2024 18:04:49 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Wed, 14 Feb 2024 18:49:31 -0800, Fenghua Yu wrote:
> head is defined in idxd->evl as a shadow of head in the EVLSTATUS register.
> There are two issues related to the shadow head:
> 
> 1. Mismatch between the shadow head and the state of the EVLSTATUS
>    register:
>    If Event Log is supported, upon completion of the Enable Device command,
>    the Event Log head in the variable idxd->evl->head should be cleared to
>    match the state of the EVLSTATUS register. But the variable is not reset
>    currently, leading mismatch between the variable and the register state.
>    The mismatch causes incorrect processing of Event Log entries.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: idxd: Remove shadow Event Log head stored in idxd
      commit: ecec7c9f29a7114a3e23a14020b1149ea7dffb4f

Best regards,
-- 
~Vinod



