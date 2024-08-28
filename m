Return-Path: <dmaengine+bounces-2992-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B07C5962FA5
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2024 20:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23D1EB22038
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2024 18:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234691AB523;
	Wed, 28 Aug 2024 18:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGyX+ymc"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3901AB517;
	Wed, 28 Aug 2024 18:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869019; cv=none; b=JpXVmRVzLFfzhZpYEhVD5fvKhoB/zEz2j8a4AgMnCVy9JeVVEmOQfhdYNr3GArWcfnlYwWaf4L1NrKhMnTnyzS93W2lAUelV+8jyJAhu/hA+pkauDq4eryjFA/atpXO8NwIW+pD+AntJq95PYsu4M2doJPQcosjyH45+8KsIdcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869019; c=relaxed/simple;
	bh=McxCXy34gJ6a21hz5CnZrWfF0kK4YJv7aUT7vOnDuP0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=f8pjujVXhFLcghxAIV4qKHLWmjKgusSAYrjHZiD4prPg1RgbINHgz4kcK9LtlM7+7ByP+w48Gszr8eYkQwZMIv+Sqvgfshm9717LM4kYSmRorViqCDqnHOgdf/v8E6cdDvgfbZGgxor3XM7yfa6hKRqCC7eLhcF13Iaig+nq8Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGyX+ymc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B2FC4CEC1;
	Wed, 28 Aug 2024 18:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724869018;
	bh=McxCXy34gJ6a21hz5CnZrWfF0kK4YJv7aUT7vOnDuP0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bGyX+ymcf8U/Eu4WqUs8yPtf8zEbDpDJcjPtLbxQribBCahPCHik+p7zOrjuVp5LS
	 7cPGoZDtVOdqAXy4HAS1NBlPm9vbUdF4fKPm7aAK2rAbZGUuVHI94dKux25XHd+3Cr
	 gVVJ3hviKe7dkz1/Vzv0VL4zQK4x8tw6vkiCCwfJcKAoiu93ryV365H0AM+E0gpLxd
	 gcUZsNmQLE+1xVGlq88mwMSDRh8daZJIkxFVn9TDw3a23VZ4vqYpwYQOFrdyC1mWSd
	 MT5yO2b+CgonJ9ZlvYFGw9B6hcKze88CNGVjWZ9L+U3BJsbEZqzdJ99aGWFckRnjS0
	 mtPxMs3X2+OWg==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Lizhi Hou <lizhi.hou@amd.com>
Cc: nishad.saraf@amd.com, sonal.santan@amd.com, max.zhen@amd.com
In-Reply-To: <20240819211948.688786-1-lizhi.hou@amd.com>
References: <20240819211948.688786-1-lizhi.hou@amd.com>
Subject: Re: [RESEND PATCH V12 0/1] AMD QDMA driver
Message-Id: <172486901670.320468.6645988022948729696.b4-ty@kernel.org>
Date: Wed, 28 Aug 2024 23:46:56 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 19 Aug 2024 14:19:47 -0700, Lizhi Hou wrote:
> The QDMA subsystem is used in conjunction with the PCI Express IP block
> to provide high performance data transfer between host memory and the
> card's DMA subsystem.
> 
>             +-------+       +-------+       +-----------+
>    PCIe     |       |       |       |       |           |
>    Tx/Rx    |       |       |       |  AXI  |           |
>  <=======>  | PCIE  | <===> | QDMA  | <====>| User Logic|
>             |       |       |       |       |           |
>             +-------+       +-------+       +-----------+
> 
> [...]

Applied, thanks!

[1/1] dmaengine: amd: qdma: Add AMD QDMA driver
      commit: 73d5fc92a11cacb73a1aac0b5793c47e48c5b537

Best regards,
-- 
~Vinod



