Return-Path: <dmaengine+bounces-6318-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BA2B3FA97
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 11:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C82D01793F9
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 09:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F4B2EBBA1;
	Tue,  2 Sep 2025 09:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1UeoGD3"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F361C261B9E;
	Tue,  2 Sep 2025 09:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756805743; cv=none; b=dcBex9XEH+ovISFcesdu7L/rYnMJJLMrHa5jSh6ky3T9OKc0CHcOM61Klq6jfgb3H5zrSmHw/Eyc2l/xNM/6exox2ZhZ/q5tYL12z9F8ojJZdT0igz2rkNIL5RARVBl0ATORx8gtkmKqDBmPxTZRFPXeMgJvHii+Js0reN7IVSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756805743; c=relaxed/simple;
	bh=Z6MQ2+Hj1R2NgrTfi5K+CitKP9vd0FeECmG12wIOSck=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rspvEC/Nf+1XZuqulBlc3cyMQFujYBL8MxGMGuct4Hf2+vn4SBEsYaXPUK+K49AW/h2cTnz8MKIDTFM1mIHBaw8KlEC5CliFhA1oZARtmuCZAdalzpAwKR0eOW2qOufvwLewXieAz1+gpakeVi7rYonEwkAmyCsrPgJlyjnWKDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1UeoGD3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B532AC4CEF5;
	Tue,  2 Sep 2025 09:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756805742;
	bh=Z6MQ2+Hj1R2NgrTfi5K+CitKP9vd0FeECmG12wIOSck=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=P1UeoGD3wQL+8GBnio/eRz4f3/3jAaB1rzcuekwWak2K6vBLKHs1o3Yng6e5gWUvB
	 uZMe9Ak/3lzZoTRr7hAFac4k3bQ0+Q7m4aeEN88h0Xc7wQ2uyMtrFHbfcSzeHclooz
	 h3JY/uvzDgB9Tp61pJeqINoUKPj0o47CeacZYidp++CCwydT1yAb2Vo8TS20zuK9CD
	 OtKy5DpF0sla5kD6KXcNrF0IkGbtu2oOosBOlHQiN4vcVq2hDbNS+YQ1XPESuCpOeh
	 66VlcKtuc1uGyDL/PVHatCjKt3PldRRy5rnGE2AQVHh1zrVNq0PyMW/BPEemApjKVe
	 zb2djyUq3xZbw==
From: Vinod Koul <vkoul@kernel.org>
To: Viresh Kumar <vireshk@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Miaoqian Lin <linmq006@gmail.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20250902090358.2423285-1-linmq006@gmail.com>
References: <20250902090358.2423285-1-linmq006@gmail.com>
Subject: Re: [PATCH] dmaengine: dw: dmamux: Fix device reference leak in
 rzn1_dmamux_route_allocate
Message-Id: <175680573925.233989.1750978267485242901.b4-ty@kernel.org>
Date: Tue, 02 Sep 2025 15:05:39 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 02 Sep 2025 17:03:58 +0800, Miaoqian Lin wrote:
> The reference taken by of_find_device_by_node()
> must be released when not needed anymore.
> Add missing put_device() call to fix device reference leaks.
> 
> 

Applied, thanks!

[1/1] dmaengine: dw: dmamux: Fix device reference leak in rzn1_dmamux_route_allocate
      commit: aa2e1e4563d3ab689ffa86ca1412ecbf9fd3b308

Best regards,
-- 
~Vinod



