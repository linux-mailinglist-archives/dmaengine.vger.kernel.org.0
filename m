Return-Path: <dmaengine+bounces-6288-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28F5B3B921
	for <lists+dmaengine@lfdr.de>; Fri, 29 Aug 2025 12:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78EB216A249
	for <lists+dmaengine@lfdr.de>; Fri, 29 Aug 2025 10:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDD33093C8;
	Fri, 29 Aug 2025 10:44:30 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177D11A0BD0;
	Fri, 29 Aug 2025 10:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756464270; cv=none; b=BPAmlX6cZBq/kImeuMaYNuUq/dQoB0pu6wSoqYi5cIt0NPn7pb5jY/nQBFpoLycTfoBoi0T+PSj2pWYwZxVyVkYL5OCNhJEstWfXmcqjayDAQCH1PoMHY73N3R9zzQSU9rK0x9IyjpwHAx5LJU2b8DpsEFkOCP4fOU8OKW2dKd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756464270; c=relaxed/simple;
	bh=7al6VARdCJBqhLhxUw7t39dmdFpKaU88KDVc0vncB/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p5dy1a3uSn81CEec00sfrTENgCr02SuZDx33beSJr9FgcZJbjU1Y0Ev60jCL+C32u/70t7W3Dyl9bylJ9wlqvR8xWoOB+71Qvm7GSyDum5Gx8Ft/MyIWXOjG8GXihl/92Is5b+HDu5aHTopRTV7VfAtVqTJ4DjVbzZsfImhEZh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09BEB1758;
	Fri, 29 Aug 2025 03:44:20 -0700 (PDT)
Received: from [10.57.2.173] (unknown [10.57.2.173])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0BB53F694;
	Fri, 29 Aug 2025 03:44:25 -0700 (PDT)
Message-ID: <097a3e2e-202e-4f4c-b981-69156aeca051@arm.com>
Date: Fri, 29 Aug 2025 11:44:23 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] dmaengine: dma350: Fix CH_CTRL_USESRCTRIGIN
 definition
To: Jisheng Zhang <jszhang@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250823154009.25992-1-jszhang@kernel.org>
 <20250823154009.25992-2-jszhang@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250823154009.25992-2-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-08-23 4:39 pm, Jisheng Zhang wrote:
> Per the arm-dma350 TRM, The CH_CTRL_USESRCTRIGIN is BIT(25).

Oops!

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>   drivers/dma/arm-dma350.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/arm-dma350.c b/drivers/dma/arm-dma350.c
> index 9efe2ca7d5ec..bf3962f00650 100644
> --- a/drivers/dma/arm-dma350.c
> +++ b/drivers/dma/arm-dma350.c
> @@ -58,7 +58,7 @@
>   
>   #define CH_CTRL			0x0c
>   #define CH_CTRL_USEDESTRIGIN	BIT(26)
> -#define CH_CTRL_USESRCTRIGIN	BIT(26)
> +#define CH_CTRL_USESRCTRIGIN	BIT(25)
>   #define CH_CTRL_DONETYPE	GENMASK(23, 21)
>   #define CH_CTRL_REGRELOADTYPE	GENMASK(20, 18)
>   #define CH_CTRL_XTYPE		GENMASK(11, 9)


