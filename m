Return-Path: <dmaengine+bounces-6321-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 617B4B3FB1E
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 11:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 209304E3A68
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 09:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF7D2512E6;
	Tue,  2 Sep 2025 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nc6Iu47/"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FB127D771;
	Tue,  2 Sep 2025 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806589; cv=none; b=sxo8kzbO1s9udpIaIIsKgDrlrKAWu6sfyXr6XOxXsklfdpDRBjRUaUBiBpbWGnW3bTS4uBqgrlpEcDUL35fJHyyaTYssNLIxQZfJnjNcYY5S4oOOhLan88S15jLKvJEkEd5QZJe3GY6bGgYVAnXuOIrX3FM/gOblMmSndJq+Zxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806589; c=relaxed/simple;
	bh=1jKS4By1zFbt5/DIzV37GtLpDQJq1JTL65v6wrQGxmM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aOUdSuggychUUaXXkxPqnu/JYS4p/nVfuuCAQ+zdLxY+4lV+/iI8D0Ht1KRjad2WKHx89UMdVvoPbTb9Z/EuCfRElIUY1NntHxhsqpMDNfo60hPHNdsyHTUbp/Nq/Z8ARbZRPFNwDlOQ7piINGvf7G9blbOkCkJE2dvYsrOJpOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nc6Iu47/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E7BC4CEF5;
	Tue,  2 Sep 2025 09:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756806588;
	bh=1jKS4By1zFbt5/DIzV37GtLpDQJq1JTL65v6wrQGxmM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nc6Iu47/2T+qc5ni+jI5hCGAh4Gh8xiGD4qHHU5j+U+rHScxFKJp3/kfvaCS/xco9
	 K23fa02u4HYziUuXCks5FlPCzyBZn1pgOtgHrrE2oRO5pAt/DDhNxJAXnfzeOFHEoH
	 uNU7YoOvwovwZPlMIffaXru2QcastKhUvRoHoXp+lzCPvqy5lvjJXfcdmT7k0+xi7m
	 HtYBgrCP7y12g1L+J2iVmKKuwatm7GK1o8rPkFvOc5mm1eJtZxhgPX7VK1H1NK2PFT
	 USttPylK9BPGI3DplR7GysPkigNcJJOuHOlyAfAppBnHRJgHZYERSR+d5UUAMa134G
	 7vBHwAc03wjTQ==
From: Vinod Koul <vkoul@kernel.org>
To: Thomas Andreatta <thomasandreatta2000@gmail.com>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 Thomas Andreatta <thomas.andreatta2000@gmail.com>
In-Reply-To: <20250827152442.90962-1-thomas.andreatta2000@gmail.com>
References: <20250827152442.90962-1-thomas.andreatta2000@gmail.com>
Subject: Re: [PATCH] drivers: dma: sh: setup_xref error handling
Message-Id: <175680658687.246694.2120128103746772483.b4-ty@kernel.org>
Date: Tue, 02 Sep 2025 15:19:46 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 27 Aug 2025 17:24:43 +0200, Thomas Andreatta wrote:
> This patch modifies the type of setup_xref from void to int and handles
> errors since the function can fail.
> 
> `setup_xref` now returns the (eventual) error from
> `dmae_set_dmars`|`dmae_set_chcr`, while `shdma_tx_submit` handles the
> result, removing the chunks from the queue and marking PM as idle in
> case of an error.
> 
> [...]

Applied, thanks!

[1/1] drivers: dma: sh: setup_xref error handling
      commit: d9a3e9929452780df16f3414f0d59b5f69d058cf

Best regards,
-- 
~Vinod



