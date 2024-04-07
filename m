Return-Path: <dmaengine+bounces-1774-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A07E589B30F
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 18:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B20E283BB6
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 16:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2963C68C;
	Sun,  7 Apr 2024 16:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZ5KRPHH"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E5F3F9D2;
	Sun,  7 Apr 2024 16:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712507951; cv=none; b=ZZvscEHmqKSwo5R62HxRRc+C9q2eaDfEoaImR+kibydowrxjtSuaysCCXE4uPHA/r3oj8UEUQW9qyDlLAqCucQr7B+eR+bdGXveUIKzUfszeq/Qe9C3fa6GgWBgItjz4S2JSW9Y7JpEt8h884TB2fwxQ6de+7FxeVPQb/FXcvq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712507951; c=relaxed/simple;
	bh=OTmsimQJwp7aDqopRUkhzqXDLl0VnyoKAPtMX+wk7vg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qUe8ZWDwPxvlryQX4VCjTkLStZh41GiBhZSW/8hog5z+dfSgZId4ulYT4gSNek6N6jxyfTwPoWS8NBqby9W7vwqT0veaygklJow6W/xQOqWFeNYvhGWiDmO6e9U+lCCMQiWpWpFVJXp40whJbhvhAWUGAVBh4ffqmUOs2eKux2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZ5KRPHH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F345C433F1;
	Sun,  7 Apr 2024 16:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712507949;
	bh=OTmsimQJwp7aDqopRUkhzqXDLl0VnyoKAPtMX+wk7vg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GZ5KRPHHDq4gJhIPL58t/oLTlxjm8qJ7ce2ITyGMz44i5CunDqCso6+Yd0VgEBBqB
	 rp3ZRt7sc17sHlrkTof92WlAklQTEp6PZeuhMnJmnThjifb2XxuIZgBjH82dz7bW/1
	 VVX9Nx0AEKK3wEOOzcoVb+bTow/BKgugJi75fWCV+i3yd7vt3eJUEEfh/k+rXHDoP7
	 iQiwIdC/Zv7Y6xcVS3MUx99RQrkT8v0Zu55DTzwvLyV+SSNwxj8K23zqA/FX+vUUGq
	 qFgrRShJou80QA0gBQtiRa/X2ef+4wo6e8lZHOu98Rzm9KoY4Mzxwc9MgD4vCLtWWI
	 6z8ts0aOv6Gjw==
From: Vinod Koul <vkoul@kernel.org>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, Nicolin Chen <b42378@freescale.com>, 
 Shengjiu Wang <shengjiu.wang@nxp.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, Vipul Kumar <vipul_kumar@mentor.com>, 
 Srikanth Krishnakar <Srikanth_Krishnakar@mentor.com>, 
 Robin Gong <yibin.gong@nxp.com>, Iuliana Prodan <iuliana.prodan@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>
In-Reply-To: <20240329-sdma_upstream-v4-0-daeb3067dea7@nxp.com>
References: <20240329-sdma_upstream-v4-0-daeb3067dea7@nxp.com>
Subject: Re: [PATCH v4 0/5] dmaengine: fsl-sdma: Some improvement for
 fsl-sdma
Message-Id: <171250794199.435322.8811454483252846455.b4-ty@kernel.org>
Date: Sun, 07 Apr 2024 22:09:01 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Fri, 29 Mar 2024 10:34:40 -0400, Frank Li wrote:
> To: Vinod Koul <vkoul@kernel.org>
> To: Shawn Guo <shawnguo@kernel.org>
> To: Sascha Hauer <s.hauer@pengutronix.de>
> To: Pengutronix Kernel Team <kernel@pengutronix.de>
> To: Fabio Estevam <festevam@gmail.com>
> To: NXP Linux Team <linux-imx@nxp.com>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: Joy Zou <joy.zou@nxp.com>
> Cc: dmaengine@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: imx@lists.linux.dev
> 
> [...]

Applied, thanks!

[1/5] dmaengine: imx-sdma: Support allocate memory from internal SRAM (iram)
      commit: 802ef223101fec83d92e045f89000b228904a580
[2/5] dmaengine: imx-sdma: Support 24bit/3bytes for sg mode
      commit: 288109387becd8abadca5c063c70a07ae0dd7716
[3/5] dmaengine: imx-sdma: support dual fifo for DEV_TO_DEV
      commit: a20f10d6accb9f5096fa7a7296e5ae34f4562440
[4/5] dt-bindings: fsl-imx-sdma: Add I2C peripheral types ID
      (no commit info)
[5/5] dmaengine: imx-sdma: Add i2c dma support
      (no commit info)

Best regards,
-- 
~Vinod



