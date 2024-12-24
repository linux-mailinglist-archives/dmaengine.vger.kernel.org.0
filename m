Return-Path: <dmaengine+bounces-4065-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 880079FBC99
	for <lists+dmaengine@lfdr.de>; Tue, 24 Dec 2024 11:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DDF3188134C
	for <lists+dmaengine@lfdr.de>; Tue, 24 Dec 2024 10:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446C91B4132;
	Tue, 24 Dec 2024 10:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ufZAkfal"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A61C156F54;
	Tue, 24 Dec 2024 10:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735036931; cv=none; b=dzqIWaxdhko+zQB9McnnaAbVtDuWQ1+OX+nSid8r0Eb5XYaImsToQCq6zsuAbWB+KOExzoYMI4zR2zWIjMdv3z/YVKyT2xQWq2eGos7+hHz4qvwWG710sUskRY4VTg/U/coBV0fmZit3KhKbKZckgjKv/Xlze1dnJ5RBu0dRY3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735036931; c=relaxed/simple;
	bh=RdJdfS1ajiFjXE0tPe+gF762/Zkdd39q0H5bXVSG9ik=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=a1As0IspvVQCn/BrbH3rl9EWOQ/z49xQ+Cb8U9LIiDw38qvVzrfvF0zRihahS9RkObWntkfm5c/zJ3XxQB5JKtSEPG7QOvyNn7K3NnMQWACGPZr+wiOcPSf6fwh+wQpTvmUX441+I3vX70Vm+lLqX/TTpZ0W3IBIAziy8ag0a+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ufZAkfal; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D48C4CED7;
	Tue, 24 Dec 2024 10:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735036930;
	bh=RdJdfS1ajiFjXE0tPe+gF762/Zkdd39q0H5bXVSG9ik=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ufZAkfalMllKgqHY9NlUglhRZ6iF1QOiwhzMaodbL81pIHomwVhwHk1en1s0gS5L8
	 7efrDwRBmbh317sqXdAd0MPweVdDnrXtIG4HiyK6iLUM2DN8NVEMjxGf4PsNpIqIKM
	 q0Tz4jMPwpaBv6uI2rww/w7JA9pZKk6qo7mEa8HSZClKK56q9R/ySHy1m0Jri3GIvC
	 lKz0Bp6i/65Umg55mnEFjKytrL9K64/5AlrjcrlUJFWKoW94fQOj3hBrvjogklQsZR
	 MloxO7MFudRd9mA5siVLaCVLDXiyD6z3wIkjo4df2ywfeBzVgs5xuuwhgGMEuip33V
	 TOOFc7X4CAIFw==
From: Vinod Koul <vkoul@kernel.org>
To: peter.ujfalusi@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 Vaishnav Achath <vaishnav.a@ti.com>
Cc: linux-kernel@vger.kernel.org, u-kumar1@ti.com, j-choudhary@ti.com, 
 vigneshr@ti.com
In-Reply-To: <20241127101627.617537-1-vaishnav.a@ti.com>
References: <20241127101627.617537-1-vaishnav.a@ti.com>
Subject: Re: [PATCH v3 0/2] Add support for J722S CSI BCDMA
Message-Id: <173503692723.903491.9420395586871455553.b4-ty@kernel.org>
Date: Tue, 24 Dec 2024 16:12:07 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 27 Nov 2024 15:46:25 +0530, Vaishnav Achath wrote:
> This series adds support for CSI Block Copy DMA (BCDMA) instance on J722S,
> the BCDMA instance is similar to other CSI BCDMA found in rest of TI
> devices like J721S2, AM62A. It supports both RX (CSI2RX) and TX (CSITX)
> channels and is identical to J721S2 CSIRX BCDMA but has slight integration
> difference in the PSIL base thread ID which is currently handled in the
> k3-udma driver from the match_data, introduce a new compatible to support
> J722S BCDMA.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: dma: ti: k3-bcdma: Add J722S CSI BCDMA
      commit: 775363772f5e72b984a883e22d510fec5357477a
[2/2] dmaengine: ti: k3-udma: Add support for J722S CSI BCDMA
      commit: d0301fdbb50dfc99215b0f999d4ff7ab0a7675d9

Best regards,
-- 
~Vinod



