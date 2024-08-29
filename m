Return-Path: <dmaengine+bounces-3028-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0395D964CD0
	for <lists+dmaengine@lfdr.de>; Thu, 29 Aug 2024 19:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B537D285AC0
	for <lists+dmaengine@lfdr.de>; Thu, 29 Aug 2024 17:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1FB4DA14;
	Thu, 29 Aug 2024 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLy5r1Dy"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B4B1B86DE;
	Thu, 29 Aug 2024 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724952640; cv=none; b=ZKm2C9FGldcgTk0HnpaSDRLQAlA8q2W/1T/PRrHmx9mybAFum7OCvhvT+NiPZ01OP+3bmRAMQZFIa7ZoSqPvz5Qs3C/Jim2YYi62SbTv1nGGIBLAVKWbHKIV+FLbUmO8+eQTlPd46sNPgw/3g00WrP7QEXtyDRba2n5ihVF1g2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724952640; c=relaxed/simple;
	bh=OZ6ZkvhiFdrcvmITgoIKKLUN0utr6ARrpziiC4LO1+4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GMQdpRnvEmSKUYhC+R1+7sA2ncg4SZhQ80ag3XO1nX8iOP0Dwe+z2QfvSSCLmpW5Z83rhTsC1ztM0bDXwAEfMEONAvixe5R+4Ahw3uK1mNhp1xlE/949DSntCMbm9cvCraZjNc3rC0mZtII/ijl2v/V9dLFMA81+Q7rBpa5gj/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLy5r1Dy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC33C4CEC1;
	Thu, 29 Aug 2024 17:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724952640;
	bh=OZ6ZkvhiFdrcvmITgoIKKLUN0utr6ARrpziiC4LO1+4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iLy5r1Dyi/wWUTVj2xTwV1RLdo9FjPeL0pD6gTcNALdEhM/PeGF0HJj7k5ejwa3ZP
	 18ukKymePaBay04qHQjU0sYJyZveJ6zR813AETz7pkdtnSWMsHp8FkrulxNCo3f7RN
	 tivtj2kSy/jrSeulvZMm20wicmP2wZFPcJj5E1DdIpp1ybNbzNvzyNvTaoslCxhOgS
	 x32TKOeRpQRlxbTdr4/Gzz6OpRLDNn9vlKNkfMx7nANzsQr/V6nrIHO033KIX2AENG
	 Vi8UbO2g5EuDUMyileYHo7A9u30ZLBbyDlnebSLuIKQC7pIIEgjvaaf6Bpw7vFhr4N
	 oS+V07QtB+Arg==
From: Vinod Koul <vkoul@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 Fabio Estevam <festevam@denx.de>
In-Reply-To: <20240806021744.2524233-1-festevam@gmail.com>
References: <20240806021744.2524233-1-festevam@gmail.com>
Subject: Re: [PATCH v2] dmaengine: imx-dma: Remove i.MX21 support
Message-Id: <172495263883.385951.11153953167705825429.b4-ty@kernel.org>
Date: Thu, 29 Aug 2024 23:00:38 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 05 Aug 2024 23:17:44 -0300, Fabio Estevam wrote:
> i.MX21 support has been removed since commit 4b563a066611 ("ARM: imx:
> Remove imx21 support").
> 
> Remove the i.MX21 support inside the imx-dma driver.
> 
> 

Applied, thanks!

[1/1] dmaengine: imx-dma: Remove i.MX21 support
      commit: 39dc2a4929f7be748b37a5070f41afe7bcb60706

Best regards,
-- 
~Vinod



