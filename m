Return-Path: <dmaengine+bounces-1956-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9148B1D9D
	for <lists+dmaengine@lfdr.de>; Thu, 25 Apr 2024 11:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B08C51F21785
	for <lists+dmaengine@lfdr.de>; Thu, 25 Apr 2024 09:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACD785261;
	Thu, 25 Apr 2024 09:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvKF1S/6"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847D38286B;
	Thu, 25 Apr 2024 09:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714036641; cv=none; b=CyhWXy35/V6nVj0J1cEC4ADeEaoYu9dwKvF0K7GdEBxQd2oJep3NCpFtNPYv1jXzkRQ8DdalwoDqN6SdtsMXbgaqSnSr8dksxltPgcr3vOeWtCQPjanZpHhZkvDb28fVhg2G/iHQQY3qwpVy2pIXna2XOaMxj90MOYbucbP3Gec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714036641; c=relaxed/simple;
	bh=RGX/DdMGDDuE1tp0jOp+5wSbZExkujiXoie6YdJkOD0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RlgMhGEKwVMMT+ne8RJEa9cLBk74uES5857833YYd2oZZLrEoTnqUm2CWNcgnSyM1GybPDlmtOQliKylP1g4pe4ZpOzSTEfMPes1rjjelBEsuR7losFMNRNe07pDOUTvbTto+4K50qRTolz5zrN2Sr+9okZAO2+/SZhQVhXS24o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvKF1S/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE121C113CC;
	Thu, 25 Apr 2024 09:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714036641;
	bh=RGX/DdMGDDuE1tp0jOp+5wSbZExkujiXoie6YdJkOD0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AvKF1S/6gtoXUv4PzyxQ1C0WVOiwNUK1Eb5Si8BYXRGF1imdQBhKFABUvFUmhIrNv
	 o/OuEsamc7+qsQZ9Mg6bwdMmHiGJ5wcbDUKc9AvbS4Rvp+zN4cDKFg6V1Mg6HO502a
	 dpcZpo9gDBqoMjb+YGczYw7K3cRZKpIUxcAehedpPGHYLv8ppEK94XkbclXImpR9Yn
	 SZCQe2tG3+VcnVecgnjn+CXNijE3K/me3z5FIfHjrrgiZeqOveoTMru61nA5+yMA9f
	 MkvP/24IjTELCl23B+xMxgRTyu5dos3NrrhDvEjBsYhrE5wykJMIins1XqRQD+1Tuu
	 Rdec9whJVAW+g==
From: Vinod Koul <vkoul@kernel.org>
To: Sinan Kaya <okaya@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240423161413.481670-1-robh@kernel.org>
References: <20240423161413.481670-1-robh@kernel.org>
Subject: Re: [PATCH 1/2] dmaengine: qcom: Drop hidma DT support
Message-Id: <171403663749.79852.6031928118459897049.b4-ty@kernel.org>
Date: Thu, 25 Apr 2024 14:47:17 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 23 Apr 2024 11:14:11 -0500, Rob Herring (Arm) wrote:
> The DT support in hidma has been broken since commit 37fa4905d22a
> ("dmaengine: qcom_hidma: simplify DT resource parsing") in 2018. The
> issue is the of_address_to_resource() calls bail out on success rather
> than failure. This driver is for a defunct QCom server platform where
> DT use was limited to start with. As it seems no one has noticed the
> breakage, just remove the DT support altogether.
> 
> [...]

Applied, thanks!

[1/2] dmaengine: qcom: Drop hidma DT support
      commit: d100ffe5048ef10065a2dac426d27dc458d9a94a
[2/2] dt-bindings: dma: Drop unused QCom hidma binding
      commit: e83cd59df0959bd9fbec76b7cff0b717ff8bc16f

Best regards,
-- 
~Vinod



