Return-Path: <dmaengine+bounces-3856-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 896AA9E0B00
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 19:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1FBEB2BBC3
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 17:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F4E1D61A2;
	Mon,  2 Dec 2024 17:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDeJOblT"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DCC15FD01;
	Mon,  2 Dec 2024 17:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733160645; cv=none; b=jnHSM6hxZxn+Ff1PV4oVC9jIuKxVWfvtaDqx4Conpd97MwXdx1dJCUonpEyOhM1XNpmA+zxlOfx9DRi1M77wJOCgqUzaOYTAFs7WLIkqP7IUnQCg2GLbKekXve885p9qLJwkVzVigbo6TjT7K0ERgHuVZ33KP/vKeQClmhJFdiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733160645; c=relaxed/simple;
	bh=2sI4NWDo1unfh0oSPY9l/XTTvoBr8ZTZvHDGO1dZdUk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WQgmfI+Zf0VUjZ1J5szttTPLIaTpHBdiwIh7J5tC9D1FJXlqwbODn/K8geAHo4v4Z8G8XPtXlOGeXX06pLG+T1Dgq2Ar1bHsEkBa3R72jV4yDfrJ+a9Fh/wgRZ4dcAB6WIwVWB51nLPTKhmrLsDyYh2PHNgkyMkQBOX9rvcQRg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDeJOblT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93BC0C4CED1;
	Mon,  2 Dec 2024 17:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733160644;
	bh=2sI4NWDo1unfh0oSPY9l/XTTvoBr8ZTZvHDGO1dZdUk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BDeJOblT2iNfZWfGnG8gMJuTMWmxtRXSH71lDjfic5AZACJMeHvodlAKDIOOhLuMN
	 hvtXrWTB+itzKdnTV4pe6oAYv8+med5Jp7O2gCQ/IrJPLB/teqPYUEHnq6zv6Dit9q
	 nWI9cD9OfOnEns2uJ/HXjnH2NtwHzsBzJNgE3YIGa1rg4CadIOrtC1QYVJDXgzKL7i
	 ZrVO1oGM+Qib7Q2h9Y92MAgxKkC+5zrhWCWRFzUKyHiZo3itRF7IcQwH3Aqds4cySF
	 wxEaijkTU2JLsg/heyLtFaxC6ibP/SnONtxILhavTzD+9PckKjcCS+k8puxs2KOQaY
	 WqQRMe7kJOc3A==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Viresh Kumar <vireshk@kernel.org>, stable@vger.kernel.org, 
 Ferry Toth <fntoth@gmail.com>
In-Reply-To: <20241104095142.157925-1-andriy.shevchenko@linux.intel.com>
References: <20241104095142.157925-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 1/1] dmaengine: dw: Select only supported masters
 for ACPI devices
Message-Id: <173316064213.537992.6375063758006475146.b4-ty@kernel.org>
Date: Mon, 02 Dec 2024 23:00:42 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 04 Nov 2024 11:50:50 +0200, Andy Shevchenko wrote:
> The recently submitted fix-commit revealed a problem in the iDMA 32-bit
> platform code. Even though the controller supported only a single master
> the dw_dma_acpi_filter() method hard-coded two master interfaces with IDs
> 0 and 1. As a result the sanity check implemented in the commit
> b336268dde75 ("dmaengine: dw: Add peripheral bus width verification")
> got incorrect interface data width and thus prevented the client drivers
> from configuring the DMA-channel with the EINVAL error returned. E.g.,
> the next error was printed for the PXA2xx SPI controller driver trying
> to configure the requested channels:
> 
> [...]

Applied, thanks!

[1/1] dmaengine: dw: Select only supported masters for ACPI devices
      commit: f0e870a0e9c5521f2952ea9f3ea9d3d122631a89

Best regards,
-- 
~Vinod



