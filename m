Return-Path: <dmaengine+bounces-5633-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C63AE9D57
	for <lists+dmaengine@lfdr.de>; Thu, 26 Jun 2025 14:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C10F1C2621C
	for <lists+dmaengine@lfdr.de>; Thu, 26 Jun 2025 12:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A3054673;
	Thu, 26 Jun 2025 12:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxxS9XvU"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4583595C;
	Thu, 26 Jun 2025 12:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750940372; cv=none; b=O5N5m4/GUqsgK7s6P5I4CYd6s+6odFwXsxo+vfFm8PFv+DSlqZ+SQN5js3HsZy2e4AGwdfwmoeab4ocukIbZm2QUZkCzHrSrvEd8QafBEqTrZWTRtjpaDKmC0PxcX8DpNvUfIxOisF8FE5K1oM2jqaor5AgmkGez5Zmn9oJ6hWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750940372; c=relaxed/simple;
	bh=mLbLjTFgE9PkBVKwP4YFWFFMW2e1uyxtG2hFyx7CYF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SxleBSNMrxMv3oF6gUEh3CgBOjC7XH5H6BJ72sUCszaBRiWHaux4gzjCnF8vx3UA9Avvmkk/8QQt+JXAWP2yMkGZ0X1cMadoXxzv3mrASgrm7D3roiC6cBB8AVScl7MQ8Q4Nd/YeE6aW+Y2xMmp8ecbV13BPvEo0zeetGHCK9TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxxS9XvU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E24C4CEEB;
	Thu, 26 Jun 2025 12:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750940371;
	bh=mLbLjTFgE9PkBVKwP4YFWFFMW2e1uyxtG2hFyx7CYF0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oxxS9XvUGvtX92eZPuUsrgrHfDUGsOp/Dr3Ezs+d7LtQjR/n/2DsWPNKi0PoPmglq
	 afTsQ927N6s1LyY5pUn42guebH4fykoiQ3rmV/sEZl5U305BBlCEi/bPYVyI7jrlmp
	 xK1E8ppVYzfdVWtKrb3mgsrcQ+uyHrEYHSYYICsgxsLe+GGSHHhN5PqcqHV6Z6uWsc
	 Q11Uv/8mzVD2kgmZjOhCI+sHyri8oIyv4RG24MHpYGd9QMNV1kVewVjY4ufyhPN1pg
	 NhPf8b27ofykI9lTivdK7rRnIhL0YDrCFPeLwl/oY1NgU5vqdXUoyKarEe/DUz3Fsb
	 qGyAta6mwgiRw==
Message-ID: <e3ac4f22-e19c-407f-a448-c54b2ca34428@kernel.org>
Date: Thu, 26 Jun 2025 07:19:28 -0500
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] dt-bindings: dma: snps,dw-axi-dmac: Add iommus
 dma-coherent and dma-addressable-bits property
To: adrianhoyin.ng@altera.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, Eugeniy.Paltsev@synopsys.com, vkoul@kernel.org,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Cc: Matthew Gerlach <matthew.gerlach@altrera.com>
References: <cover.1750084527.git.adrianhoyin.ng@altera.com>
 <144d2070c7b2f69f034b6f16bc938a538afa9f15.1750084527.git.adrianhoyin.ng@altera.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <144d2070c7b2f69f034b6f16bc938a538afa9f15.1750084527.git.adrianhoyin.ng@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/16/25 09:40, adrianhoyin.ng@altera.com wrote:
> From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
> 
> Intel Agilex5 address bus only supports up to 40 bits. Add
> dma-addressable-bits property to allow configuration of number of dma
> addressable bits.Add iommu property for SMMU support. Add dma-coherent
> property for cache coherent support.
> 
> Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
> Reviewed-by: Matthew Gerlach <matthew.gerlach@altrera.com>
> 

Add a '---' above to signify the version history..

Applies to all of your patches.

Dinh

