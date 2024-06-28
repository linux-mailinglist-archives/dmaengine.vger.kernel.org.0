Return-Path: <dmaengine+bounces-2588-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3DD91BC3C
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2024 12:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9538D1F2426E
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2024 10:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C7F15573A;
	Fri, 28 Jun 2024 10:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDCMYE5k"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D087315572C;
	Fri, 28 Jun 2024 10:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719569414; cv=none; b=u+yWp/TQi+8FWnC0eUE3vByM9p4C239g8q2BB/1avRNodxd49sRUEgZx65s6ST91tyJpMd2GyyX+f/DnGkqG66m4kz6ZwUQg9PLNj3z2v6vF4T4d8SqiRM8j2VnX87vYBNHfelFm37Ayn/a/5ibxtMwl55mRAdjF5Dc+epINGZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719569414; c=relaxed/simple;
	bh=x8Dod9ADC0lzmSMEOj5E68yh6qlToG4f0eMj6Kyp824=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pu8Aax/Vli0gVC3Llo2T85iJv3d/GAC7sKriUS5tUJBU6W1va0np23bMOXz8OQEunYnwGHMu+9aP4Z9JFWFqWagKmN2kp+Avfxq1Ww/B+s8Ue0Cb2gLszNTDya5ccMhXDQohGP7VAqqayrGYqBPH6BGwTdUUToEuZJMN0KyCT4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDCMYE5k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26CB5C32781;
	Fri, 28 Jun 2024 10:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719569414;
	bh=x8Dod9ADC0lzmSMEOj5E68yh6qlToG4f0eMj6Kyp824=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YDCMYE5kOwtDXczHjKFb+oWCMDF7AMy+Yh/o1AIKa6XlQhcAyiIJQ48SttrVI8GAO
	 xP4F6Bf7bGXOv/Bx/V5kcoRp43kIXddNvb3oO46XmHfSXkisvIZehUCFslj888WdIC
	 agsu+v5fODNhro5vvmNFye5agj8SRTpA9fU7XCezi7dXk/wvizSBBzWH44iezBz1m+
	 sFDk6VOPjIrnCu1YdESG2b3gyHoGoapZY0SeFBDgVIP2YSRy94N0kohzns161ghIAv
	 O76allHL1fkZ52J445IFbf3SD1tJfWTQh8EjN3Rb9h9ci1YZ9AOIYwoUBGHCTEumdC
	 l30NnKxCbkoCg==
From: Vinod Koul <vkoul@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <20240615-md-arm-drivers-dma-ti-v1-1-496d243158dd@quicinc.com>
References: <20240615-md-arm-drivers-dma-ti-v1-1-496d243158dd@quicinc.com>
Subject: Re: [PATCH] dmaengine: ti: cppi41: add missing
 MODULE_DESCRIPTION() macro
Message-Id: <171956941266.519169.12450021532572657287.b4-ty@kernel.org>
Date: Fri, 28 Jun 2024 15:40:12 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Sat, 15 Jun 2024 22:51:47 -0700, Jeff Johnson wrote:
> With ARCH=arm, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/ti/cppi41.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> 

Applied, thanks!

[1/1] dmaengine: ti: cppi41: add missing MODULE_DESCRIPTION() macro
      commit: 6c026a3e4ecf68616c6ea0beb0d7a3462ae6f843

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


