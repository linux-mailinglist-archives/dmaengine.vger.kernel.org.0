Return-Path: <dmaengine+bounces-1471-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A27F9886D9F
	for <lists+dmaengine@lfdr.de>; Fri, 22 Mar 2024 14:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 411E21F25CE2
	for <lists+dmaengine@lfdr.de>; Fri, 22 Mar 2024 13:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB3646452;
	Fri, 22 Mar 2024 13:36:42 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16EA45BFF;
	Fri, 22 Mar 2024 13:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711114602; cv=none; b=OzJJUva6nsHjri6Yr4LnNsiyGNIgqCVA0jmjDrR5yTAlSNkOi2SbJFkVb9zuUm5sMcVJfzkE0b6qIVVvXqMSGbnbw270areGXxyBPfFNQFWjWpf0ZgW8TLvjcERv4xzx0gUAxHLb1e6SZ3YuDaze4Cux//RmW8DFlwM1tuhtIE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711114602; c=relaxed/simple;
	bh=qn+E2wYjJfNHPhIQlSnI5xtESAViWEOYAofY4YkCvnQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Jw5KUk4XCzJmo+BMYF7dFG2YEWLcua5gHt+0pusFrdmLOlBaghhBcDQptfmGyaSqIAfqqcRs0J0g+qd/LD6jUVxM+hMnvrulNomPZfoBmFrPzBU0n4vPM/6hGp1dIV+wkQLJesNTNYcUz0+82ixB8nctZwdlGJM8V3c7pChWorE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com; spf=pass smtp.mailfrom=korsgaard.com; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korsgaard.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C978C1C0005;
	Fri, 22 Mar 2024 13:36:29 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.96)
	(envelope-from <peter@korsgaard.com>)
	id 1rnf4P-005ytU-0d;
	Fri, 22 Mar 2024 14:36:29 +0100
From: Peter Korsgaard <peter@korsgaard.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>,  Andreas =?utf-8?Q?F=C3=A4rber?=
 <afaerber@suse.de>,
  Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,  Nathan
 Chancellor <nathan@kernel.org>,  Arnd Bergmann <arnd@arndb.de>,  Nick
 Desaulniers <ndesaulniers@google.com>,  Bill Wendling <morbo@google.com>,
  Justin Stitt <justinstitt@google.com>,  Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>,  Randy Dunlap <rdunlap@infradead.org>,
  Rob Herring <robh@kernel.org>,  Zhang Jianhua <chris.zjh@huawei.com>,
  dmaengine@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-actions@lists.infradead.org,  linux-kernel@vger.kernel.org,
  llvm@lists.linux.dev
Subject: Re: [PATCH] dmaengine: owl: fix register access functions
References: <20240322132116.906475-1-arnd@kernel.org>
Date: Fri, 22 Mar 2024 14:36:29 +0100
In-Reply-To: <20240322132116.906475-1-arnd@kernel.org> (Arnd Bergmann's
	message of "Fri, 22 Mar 2024 14:21:07 +0100")
Message-ID: <87o7b62xsy.fsf@48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: peter@korsgaard.com

>>>>> "Arnd" == Arnd Bergmann <arnd@kernel.org> writes:

 > From: Arnd Bergmann <arnd@arndb.de>
 > When building with 'make W=1', clang notices that the computed register
 > values are never actually written back but instead the wrong variable
 > is set:

 > drivers/dma/owl-dma.c:244:6: error: variable 'regval' set but not used [-Werror,-Wunused-but-set-variable]
 >   244 |         u32 regval;
 >       |             ^
 > drivers/dma/owl-dma.c:268:6: error: variable 'regval' set but not used [-Werror,-Wunused-but-set-variable]
 >   268 |         u32 regval;
 >       |             ^

 > Change these to what was most likely intended.

 > Fixes: 47e20577c24d ("dmaengine: Add Actions Semi Owl family S900 DMA driver")
 > Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Good catch!

Reviewed-by: Peter Korsgaard <peter@korsgaard.com>

-- 
Bye, Peter Korsgaard

