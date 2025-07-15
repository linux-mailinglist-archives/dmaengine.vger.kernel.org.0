Return-Path: <dmaengine+bounces-5822-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 916A8B04F75
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jul 2025 05:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C60D95624C9
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jul 2025 03:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1892D29DB;
	Tue, 15 Jul 2025 03:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcY3U8Hx"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E522D239D;
	Tue, 15 Jul 2025 03:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752551136; cv=none; b=nKo+i3RiaDKFN2dTGfisTfRXnZyDtZivvYaRzmrbRSuf93ovHQipItUrC9xgoVb8TFoYqlznQ+oxQhxfxrmu2BrsSNgZK8QwT4YloeQv0NffpI9Wg36mzY3smJaJ4XzElWFHBztRsRgSzlwIPrmTgkNb2RW5GYEPvoSjZ2qPjDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752551136; c=relaxed/simple;
	bh=elGNN/7GREr5t/sTwb+Cm6955F1QyvllRbGLbNSu6vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mh+DD+ssXRVnK3FQm524Xfsc8pZg0IHL6DHjg+wB70zDmoM1VZvJdCFwm3LSg2falzHqTs9Lvf4w09/wJORo/Dq3IjigCu1uyw34avyfbe+1G+HTTBUAeEx5KLQ0vRMI4MUTApiVpS9CTNfp1tsXrDluZzgH/jxn0RHLAOrEJQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcY3U8Hx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9F2C4CEE3;
	Tue, 15 Jul 2025 03:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752551134;
	bh=elGNN/7GREr5t/sTwb+Cm6955F1QyvllRbGLbNSu6vA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jcY3U8Hxj+NyN3DitDeH/2XPSk2vRa49Q01aMRN9C/L4A1tTY96j8+Vf1I78Yfghu
	 D8y5521xRvUwssBl9afbadX+xI0UdBW0amxz7p3HpOPzn5d5Yomuwm0ed9UHFXnxCp
	 JK/t/oec1rZhd2uDWJPogmwIk6oNe/mfOQ6fpfa8q53PHMQZ09K/Uj47DGZa+wrlU0
	 XUqbyB0aBbK6sS2Xn+PvSWIFkxkfRZpSooexnkQAR5ZqLmYb1CHDfK88nu8u+7WA8q
	 9qq9BZZkdQZdzJzno2R4SuOY2E+Wu0VDH3vBLYYq2DxcMbzgL0hbbgib2q7frsK0Co
	 MT+60iMC4rb+w==
Date: Mon, 14 Jul 2025 22:45:33 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Guodong Xu <guodong@riscstar.com>
Cc: dmaengine@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Alex Elder <elder@riscstar.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Yixun Lan <dlan@gentoo.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Conor Dooley <conor+dt@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>,
	Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, spacemit@lists.linux.dev,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Subject: Re: [PATCH v3 1/8] dt-bindings: dma: Add SpacemiT K1 PDMA controller
Message-ID: <175255113305.1485.18050987625765048681.robh@kernel.org>
References: <20250714-working_dma_0701_v2-v3-0-8b0f5cd71595@riscstar.com>
 <20250714-working_dma_0701_v2-v3-1-8b0f5cd71595@riscstar.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714-working_dma_0701_v2-v3-1-8b0f5cd71595@riscstar.com>


On Mon, 14 Jul 2025 17:39:28 +0800, Guodong Xu wrote:
> Add device tree binding documentation for the SpacemiT K1 PDMA
> controller.
> 
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> ---
> v3: New patch.
> ---
>  .../devicetree/bindings/dma/spacemit,k1-pdma.yaml  | 68 ++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


