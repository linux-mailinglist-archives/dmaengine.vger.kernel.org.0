Return-Path: <dmaengine+bounces-5165-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F8DAB6ECA
	for <lists+dmaengine@lfdr.de>; Wed, 14 May 2025 17:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5240D8C1A91
	for <lists+dmaengine@lfdr.de>; Wed, 14 May 2025 15:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D2C1FECBD;
	Wed, 14 May 2025 15:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTb7jo6w"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26691DED5D;
	Wed, 14 May 2025 15:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747234980; cv=none; b=iQOZT2UU9PLJu8lyx1FlhV9cz4Jsthaw/fMZUuT9PaBiIgMyB6B356D6blUtBNEIYXMvyCuNkwoCM1JvYs/mkdccmYAnqiR7hQt+FEJouzm2c4oGxRBrZwEnkytPciiwZHtxmPb2CtX68UuPHMSzYeMuPIAdMnV/DDkKLh9J4uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747234980; c=relaxed/simple;
	bh=15Etcu4xfg85YZbJ8Ox9B4ke3VtIDNM5//5H62ElP5Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=srVrsI+Zt9QmDxZxnnGVHMNDU+5KHhMcXIqZPkLHXpA69VbUumU7guX8ItSjra7FVrpZmkfeRXh04P3ZqAyzD67fd+T1Nfie69BMd8u3Oy6fhmrj8KxoKZXGMHcQ2H++hsiJKy/xqyAYZEwBFrcKdf+/07eviNgLnoZ4o3oiqR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTb7jo6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB8AC4CEE3;
	Wed, 14 May 2025 15:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747234980;
	bh=15Etcu4xfg85YZbJ8Ox9B4ke3VtIDNM5//5H62ElP5Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=UTb7jo6w30T8CfHLjPZc3AtxTyqT+WAeYMjDfjy9sbvmeAy4/uN2vH2W6hR79Q6af
	 fJMnFMQz5JyUfVmi6JMHBTTK+d9LDhPxuY3hlp27QlnorQYH2/a0G70IPGeA09sSuv
	 eU2gChFMELFg06Br5BPHfk4osa7O9X4sN6lrB8w4MyuTBrJnEB1ywTiNbmzVsSncsU
	 E4mdRpTEoC1/AqsNS4QuT8t5vBTgbZd5zBltT1efs+jaZfi9yiA+b5JYNIfrLLiqiH
	 E70up5Ri8Jlzj9DvRXn7LCZkk5Q/PBHkakRUVGH7oXWtosZJKRUdLfNk4fs9DYWS2u
	 XN/dcfhPtvFXA==
From: Vinod Koul <vkoul@kernel.org>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 "Sheetal ." <sheetal@nvidia.com>
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, ldewangan@nvidia.com, 
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250512050010.1025259-1-sheetal@nvidia.com>
References: <20250512050010.1025259-1-sheetal@nvidia.com>
Subject: Re: [PATCH v2 0/2] Add Tegra264 support in ADMA driver
Message-Id: <174723497746.115803.4058332926629460459.b4-ty@kernel.org>
Date: Wed, 14 May 2025 16:02:57 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 12 May 2025 05:00:08 +0000, Sheetal . wrote:
> The patch series includes the necessary changes to enable
> support for the Tegra264 platforms in ADMA drivers.
> 
> Changelog
> =========
> 
> v1 -> v2:
> ---------
>  - Patch 1/2: Update commit message and Tegra264 bindings properly.
>  - Patch 2/2: No header update.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: Document Tegra264 ADMA support
      commit: b81cd165e4a5599bd96c11adf40872fcbc5fa54f
[2/2] dmaengine: tegra210-adma: Add Tegra264 support
      commit: 21e12738779f74d9ae63faa995f5743656eadc07

Best regards,
-- 
~Vinod



