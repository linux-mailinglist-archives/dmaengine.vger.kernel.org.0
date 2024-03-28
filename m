Return-Path: <dmaengine+bounces-1603-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBF888F8E7
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 08:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 615EE1C24A5F
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 07:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2314C62E;
	Thu, 28 Mar 2024 07:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzXDtiMj"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9089239FC6;
	Thu, 28 Mar 2024 07:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711611581; cv=none; b=rqebFjur6WY3i1w+4ONm0eFPym8dDM8JEcMkCGh2zJAWPwz4uyliAiwx+xEcifH+yFfmhGPJ0KhBcMSMUCqQ58yeVceckqyn3qakPi3QzudCcIzKieKZZyVODC65WjYmAPXGvVFp2arQWt3DWyPrL0m811hxCPQhZzB9DPlb5Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711611581; c=relaxed/simple;
	bh=j2fecunGf2z206NzbuhZVhae6PguWXtF1jN4ko+Qk6A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=I+EJ+EX/vV3ZwHu/K0+At/DjsAfwX+yZSnu1AgubKZvkM1gIc44lR1rHeUEBsQIGgv1s2WZRa572AjyWJQMSRfg1TzwEWPCV/eL8JTKQjYsGu+SC+BI2XYCkwbPxKbXjQ09YqYyfBBbALMErv2EazJy7W0Ybd5hWGqAt2euJiFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzXDtiMj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF47C433C7;
	Thu, 28 Mar 2024 07:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711611581;
	bh=j2fecunGf2z206NzbuhZVhae6PguWXtF1jN4ko+Qk6A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mzXDtiMjwTUnjifYo0LhCLPcO+1bwT0CitQmJUs/rFiAbkNL6H2YmohGRnS/lSeaf
	 sDrUPbms3pcO6baStESjextCTz7lHVTPPofrdOVek9lOO/feshIw6YkqYWYVI+CJlC
	 sQc6Qs2fMEe/yrog4CthJix+Tftiu6gqmIXlTDIGn6ZPJcTtGC4qaa7+OJ2kb9VKcO
	 lNDBFH70yy/a+NeI9ebAL2HoWdgAbqzpO8MddZiiiELpJVeWPWE58t2ysgMo++e2Ci
	 hyO19+NUTMTr9JW86vEE1aW1wK3APPWHMbyeIP5vPzQL2qYRg+mMI8SMVUJKYXzj89
	 awTZf6QtkShjw==
From: Vinod Koul <vkoul@kernel.org>
To: =?utf-8?q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Randy Dunlap <rdunlap@infradead.org>, Rob Herring <robh@kernel.org>, 
 Zhang Jianhua <chris.zjh@huawei.com>, dmaengine@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-actions@lists.infradead.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
In-Reply-To: <20240322132116.906475-1-arnd@kernel.org>
References: <20240322132116.906475-1-arnd@kernel.org>
Subject: Re: [PATCH] dmaengine: owl: fix register access functions
Message-Id: <171161157512.113367.10881464487051334801.b4-ty@kernel.org>
Date: Thu, 28 Mar 2024 13:09:35 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Fri, 22 Mar 2024 14:21:07 +0100, Arnd Bergmann wrote:
> When building with 'make W=1', clang notices that the computed register
> values are never actually written back but instead the wrong variable
> is set:
> 
> drivers/dma/owl-dma.c:244:6: error: variable 'regval' set but not used [-Werror,-Wunused-but-set-variable]
>   244 |         u32 regval;
>       |             ^
> drivers/dma/owl-dma.c:268:6: error: variable 'regval' set but not used [-Werror,-Wunused-but-set-variable]
>   268 |         u32 regval;
>       |             ^
> 
> [...]

Applied, thanks!

[1/1] dmaengine: owl: fix register access functions
      commit: 43c633ef93a5d293c96ebcedb40130df13128428

Best regards,
-- 
~Vinod



