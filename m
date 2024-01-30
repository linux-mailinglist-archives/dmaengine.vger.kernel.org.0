Return-Path: <dmaengine+bounces-905-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA990842B5D
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 19:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C6D4B23D7A
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 18:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451F314E2D8;
	Tue, 30 Jan 2024 18:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="paUzmvVL"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B53D86AD7;
	Tue, 30 Jan 2024 18:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706637611; cv=none; b=dt6IPSWF2Z7jiohIlPq7kBOZvrtti1uMTb8ewtHdOndY04Bdk7BihvsTKiC7bx9ifzMb80wQNP/PJjkvlOXPVcxUTcuS+jl1aLdtXBh7BHVF8IzdDIdX9ARlifum5QvwMh3rNw9GC+pv7AYcNB8SHUW3QhHXtmYeGr4fDreU790=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706637611; c=relaxed/simple;
	bh=Leq+aBcecMtjaU8wcgnaTXc3I/FzMFtv8L5SuzFFELQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tthwtz9ztMa1BLGnrjqX9PIzDbUXAn1d+o2kBMyGOq7BrItIobVg53DhAJnrjtXLuunl8VU9RfPBRGYBAgyMnvF2o53ugkkzD/IrzeGaeMZ7f+wHKY4uR8qSWwq8RmHlv9ZjUsX1e4HONmxnvz7LFhLFt93b2Q4lDNh7jK5zOUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=paUzmvVL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B83C433C7;
	Tue, 30 Jan 2024 18:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706637609;
	bh=Leq+aBcecMtjaU8wcgnaTXc3I/FzMFtv8L5SuzFFELQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=paUzmvVLfZOfghJHlUBgAPUByfg0YZeRwarVpJfH2+pVJOACdO9crnXtEgZnKiETs
	 iTELXp5pLtub7qUSlJU2bXCEr9nMps8mEUph78TptJiouJq4fevg3Lq94ga67mgJsk
	 QiJRTsrb6kOh74dD/+Cq98cO3dQv01yBT+iKQZsbkvTfBc3yOdkZLoKQxIYNWcYsSv
	 QBJ3YMUMNphLMzWyVDgnOgJKW2n4nhcMwOd2pHmVyIhttYZFBtmy7Z8j+X9/aynEug
	 PtftQSk30Or1ePBlG5XwZ5Id15mxdoCWq95q3PeyQ5RnrMAIF5EpSioMpYGuMVHf+/
	 nh3xIEi4BaDJQ==
Date: Tue, 30 Jan 2024 12:00:07 -0600
From: Rob Herring <robh@kernel.org>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: vkoul@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, michal.simek@amd.com,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	git@amd.com, Abin Joseph <abin.joseph@amd.com>
Subject: Re: [PATCH] dt-bindings: dmaengine: xilinx_dma: Remove DMA client
 binding
Message-ID: <20240130180007.GA2062314-robh@kernel.org>
References: <1705650270-503536-1-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1705650270-503536-1-git-send-email-radhey.shyam.pandey@amd.com>

On Fri, Jan 19, 2024 at 01:14:30PM +0530, Radhey Shyam Pandey wrote:
> From: Abin Joseph <abin.joseph@amd.com>
> 
> It is not required to document dma consumer binding and its
> example inside dma producer binding, so remove it.
> 
> Signed-off-by: Abin Joseph <abin.joseph@amd.com>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---
> I am working on txt to yaml binding conversion and will send out
> as followup patch.

It is fine to just drop this in the conversion, but either way.

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  .../bindings/dma/xilinx/xilinx_dma.txt        | 23 -------------------
>  1 file changed, 23 deletions(-)

