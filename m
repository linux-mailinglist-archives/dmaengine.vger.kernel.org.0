Return-Path: <dmaengine+bounces-4720-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5D2A5E3BB
	for <lists+dmaengine@lfdr.de>; Wed, 12 Mar 2025 19:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3F883BBEDD
	for <lists+dmaengine@lfdr.de>; Wed, 12 Mar 2025 18:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB632257430;
	Wed, 12 Mar 2025 18:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b="md0LVs6B"
X-Original-To: dmaengine@vger.kernel.org
Received: from www522.your-server.de (www522.your-server.de [195.201.215.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4089F24EF75;
	Wed, 12 Mar 2025 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.215.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741804578; cv=none; b=lg0TWQ9mOXDxOk755fxRD3FyIhcfzge/xsF4p/uUBRKq7nyoq7dj5g67GmxA9p1SmxcXn42ImW8ITLrwnqFQYn5cl43JY0nrWwJn0EMsfCjw6tiPHFJl8rmZzzXyezvD4DicXHo2YqqMnwbfQNc2PumFP0xgHw86G7tVvcZyLc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741804578; c=relaxed/simple;
	bh=WPLapRmLlq0bAVjXBGfkhZji8UQd/p3AECuU1ohT8Y0=;
	h=Message-Id:Cc:To:From:Date:Subject; b=qDHLG6GExgExjus7eL90VjWUr10k500WRNfB7jY3QVgz0chhF2qPIIYLxi6kW5As1FELYKndUkZN5gxJmZgBH8G5LAG71zmMBHcfSZxq/p9wYGfXl74Kh/x3F/BCb0OgfYThujlpl3nreAYPKJZPimS0PUT7EXVMN7dAgv7qZpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de; spf=pass smtp.mailfrom=folker-schwesinger.de; dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b=md0LVs6B; arc=none smtp.client-ip=195.201.215.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=folker-schwesinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=folker-schwesinger.de; s=default2212; h=Subject:Date:From:To:Cc:Message-Id:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References;
	bh=jK9L1dvLd5m9lPWVnJzTvy05KzJHfRiYwXisKwJCxs4=; b=md0LVs6BQzj1X1zReYSbbEAf3F
	694zkVxIQz469+06JS7no5VO9Xie9h5/g3wgUi4gYLzt0KypJIZQittYRkkEq+jVYHM2aVhUHNiu3
	OkuY+7p+5XznH1qopCzq+h1N+1dbk4T0En1TYn90QGdVKxfOVOUl/h6HePMwJfQazJQqszB/Supj4
	8dT3Y7sJ0iBeyooSjMT1f89XAsLNj1ymYmzRgDUUdapPUS4wPPNG2b8g1ibpcVgMCbhNVUH7XRfAU
	M3rzoCFoTbYX67wwQkwb71cJUvknsIKAzjQDUE1BL2+dauRySCSdQeMG/7EVgY/BoU6uZM8TuaNZX
	k9w1llZA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www522.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1tsQw8-000IGP-0w;
	Wed, 12 Mar 2025 19:36:12 +0100
Received: from [185.209.196.170] (helo=localhost)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1tsQw8-000JzK-14;
	Wed, 12 Mar 2025 19:36:11 +0100
Message-Id: <D8EI6SI5E4PE.3GOBCNHV38K03@folker-schwesinger.de>
Cc: "Kedareswara rao Appana" <appanad@xilinx.com>,
 <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
To: "Vinod Koul" <vkoul@kernel.org>, "Michal Simek" <michal.simek@amd.com>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Manivannan Sadhasivam"
 <manivannan.sadhasivam@linaro.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@linaro.org>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, "Marek Vasut" <marex@denx.de>
From: "Folker Schwesinger" <dev@folker-schwesinger.de>
Date: Wed, 12 Mar 2025 19:36:09 +0100
Subject: [PATCH 0/1] dmaengine: xilinx_dma: Set dma_device.directions
X-Authenticated-Sender: dev@folker-schwesinger.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27575/Wed Mar 12 09:37:42 2025)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>

Currently it is not possible to use the Xilinx DMA driver as a backend
for IIO drivers. Setting up IIO DMA buffers with
devm_iio_dmaengine_buffer_setup() fails because dma_get_slave_caps()
always returns -ENXIO. The reason is that the Xilinx DMA driver does not
set the directions field in struct dma_device, which is checked in
dma_get_slave_caps().

This patch fixes this issue. It basically is a partial resend of this
patch [1], modified to apply on dmaengine->next. It was discussed back
in 2018 in this thread [2].
As I'm quite new to the kernel dev process, I'm not sure if I should
have included any tags to give credit to the original patch author.

[1]: https://patchwork.kernel.org/project/linux-dmaengine/patch/1514961731-1916-2-git-send-email-appanad@xilinx.com/
[2]: https://lore.kernel.org/lkml/20180111062111.GH18649@localhost/T/

Folker Schwesinger (1):
  dmaengine: xilinx_dma: Set dma_device.directions

 drivers/dma/xilinx/xilinx_dma.c | 2 ++
 1 file changed, 2 insertions(+)


base-commit: 6565439894570a07b00dba0b739729fe6b56fba4
-- 
2.48.1

