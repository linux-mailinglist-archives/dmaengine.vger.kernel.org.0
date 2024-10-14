Return-Path: <dmaengine+bounces-3347-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC7399D68D
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2024 20:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57B3E1F23A2F
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2024 18:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F85231C95;
	Mon, 14 Oct 2024 18:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hV0zh66C"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B638219E7ED;
	Mon, 14 Oct 2024 18:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728930771; cv=none; b=iay99XUNeMevYyVPmdw4V/Ki9ki4fs8i0/jBKfzr8yBClpW/ijJUDUgIN39Q+/S00Dpl2cWYUgYWboRG3CaE8w434ZozCBxZhPpE3EnUb/zvn8W553Y8lehsxSJx4vb+eprBakY9KEGsskeABqUomI6vwp9L7KMxqFi1wr8OQ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728930771; c=relaxed/simple;
	bh=sO51GMgByJ6JnVNj3QRFR3sjKRvr2FVJyry1vQaOVME=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Bu2Od2UvuGxqVZ4qdSOSViUCmv6X2f3GJ7itPpH92BtaJU0bB/w2KCl1FQvM0LZRU6aVNreUMYZk0MQWEbFPWXaCzi6gz4Pjv4CUGdJcl6qeyQC1FuIQ8GMz0lCNkrGKsj6xIkpCW5bgy66zdO4Q3skiVhK3bkqfskrS3E116wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hV0zh66C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B8BC4CED0;
	Mon, 14 Oct 2024 18:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728930771;
	bh=sO51GMgByJ6JnVNj3QRFR3sjKRvr2FVJyry1vQaOVME=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hV0zh66CP/cj19SUdCRXg/9zPzd72lgKs8WQyq7JGjgVxaO/RVN7mATm0FziNGj4h
	 9tBDiZgk08ksAfXSIbxLudDD6aY1UvSruJPhJSbc5N7uax2xR3DpRLlHcVLAkcZmd+
	 NWr8lvdcREsPLpfxm8CaR+7kwEOqfcYWsyVF34PciKld7RzYeSgtB8wlBL5KoSN9oP
	 tCF5eDC0uhnlExq6HmPreoG+snj8vBgt7NZGWlttKtBnP/4MksBnugITYpifgLJKou
	 JhccmCB0sJXswkFgOjrj262dbAkkcBL/qMs6grro8zFLNzcP9W271273AeaZl/fHdY
	 aNMD76E6r9y7w==
From: Vinod Koul <vkoul@kernel.org>
To: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dmaengine@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>
In-Reply-To: <20241007150436.2183575-1-andriy.shevchenko@linux.intel.com>
References: <20241007150436.2183575-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 0/3] dmaengine: acpi: devm APIs and other cleanups
Message-Id: <172893076913.76035.9347520801343215565.b4-ty@kernel.org>
Date: Tue, 15 Oct 2024 00:02:49 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 07 Oct 2024 18:03:22 +0300, Andy Shevchenko wrote:
> Here is a set of a few cleanups mostly related to ACPI DMA devm APIs.
> No functional changes intended.
> 
> Andy Shevchenko (3):
>   dmaengine: acpi: Drop unused devm_acpi_dma_controller_free()
>   dmaengine: acpi: Simplify devm_acpi_dma_controller_register()
>   dmaengine: acpi: Clean up headers
> 
> [...]

Applied, thanks!

[1/3] dmaengine: acpi: Drop unused devm_acpi_dma_controller_free()
      commit: 6e3ea06240adfef7b46e2338dd824541c31de06d
[2/3] dmaengine: acpi: Simplify devm_acpi_dma_controller_register()
      commit: c0fecce865535f77e7a8220175b126392dfe99dc
[3/3] dmaengine: acpi: Clean up headers
      commit: 662f045332addc961940e48eb920caa954abbf09

Best regards,
-- 
~Vinod



