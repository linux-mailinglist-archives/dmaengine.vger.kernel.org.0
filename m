Return-Path: <dmaengine+bounces-3884-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D95079E3B16
	for <lists+dmaengine@lfdr.de>; Wed,  4 Dec 2024 14:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF13F1690E8
	for <lists+dmaengine@lfdr.de>; Wed,  4 Dec 2024 13:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA821BBBEE;
	Wed,  4 Dec 2024 13:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvctxKCu"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5D31CDA01;
	Wed,  4 Dec 2024 13:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733318326; cv=none; b=UiQktVD/zCdI5UM5UHdrcBxcQq3wH9X8CirP7cmF91sn1pushRjdaoW8I9ILpA0dgTuFEWmIWZ/I76Z0QPbYFo52J0Zp11LobohlT2KRLNxOhCft6XSvaFWkjHkbE6+EkDDZzjAn0Cp36v5z3lKx+9WpJekANfJsRjW5SzZdbik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733318326; c=relaxed/simple;
	bh=TAtHKYWCoR1GL0UUMdPzrLKHlmmmfkDHR9X3xB5fKEY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VG6MqZ897/XfCfWHvDrvvZ7UmXaoX+3xkUyUhtYE4TJ0h4OkXDYn1N80S+uiHTXXdyivA2CbwnOx22t+/l3HEvtMKCedaAEg29Llqz977pX24psfY54bMhzS9Pkz4L/Wr0F9KN4CUP+K9jHppNEDaSOwIjbeTs2y+cGfC69R3ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvctxKCu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10ECAC4CED2;
	Wed,  4 Dec 2024 13:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733318325;
	bh=TAtHKYWCoR1GL0UUMdPzrLKHlmmmfkDHR9X3xB5fKEY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nvctxKCum2d6ej0vjNutgyLBtwWMCMMlMaz65XUAQFbiQERaOXEoG+UKzFMK1u5Co
	 1u6YvF1xpCJTtjaSwekhfkL42715ZuX14hzb5g3vEtxnveVP8yhOxE35rVry4mcCsZ
	 pUENYBBZkvHu64x7FDArYYXDvNbooO+gPFjMB6iRsD8jdxruw+2/CzoejqTj6WbaRE
	 y1e+Fl2/4WyDJHnsx9vbEafU29BgphKQ2GiG2V/SGZqyaxdpTIp9MlL5yR6HN1pOJl
	 auik38Q8PpFOfgXc2RaAQA2+q7wja+9nuqUsxJ59bVIQYwMXKjHF+2cW7J/cM8PdEz
	 BGemHxJ885PRQ==
From: Vinod Koul <vkoul@kernel.org>
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241124-admac-power-v1-1-58f2165a4d55@gmail.com>
References: <20241124-admac-power-v1-1-58f2165a4d55@gmail.com>
Subject: Re: [PATCH] dmaengine: apple-admac: Avoid accessing registers in
 probe
Message-Id: <173331832270.673314.2577106831553574713.b4-ty@kernel.org>
Date: Wed, 04 Dec 2024 18:48:42 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sun, 24 Nov 2024 16:48:28 +0100, Sasha Finkelstein wrote:
> The ADMAC attached to the AOP has complex power sequencing, and is
> power gated when the probe callback runs. Move the register reads
> to other functions, where we can guarantee that the hardware is
> switched on.
> 
> 

Applied, thanks!

[1/1] dmaengine: apple-admac: Avoid accessing registers in probe
      commit: 8d55e8a16f019211163f1180fd9f9fbe05901900

Best regards,
-- 
~Vinod



