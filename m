Return-Path: <dmaengine+bounces-7667-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B70CC32FA
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 14:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C70873035A27
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 13:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEF2350D7E;
	Tue, 16 Dec 2025 13:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="snNOJVhr"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9593502B6;
	Tue, 16 Dec 2025 13:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765890709; cv=none; b=CWc1XfR3WzsXm+AsC/+/UsySbAGutbxdQAfNegZz8C1qGrpRjAJ8yFcjY1m3/7ZyqdPORYkM1aOh1Si6uSfENY7GXK3eUZAQz6zr4QG9VYghksUYhUT4epUXlyXTz2VzSZn0qnPxoC9IwEkTa+a1zpfbB7DnHnPkPb7EHAZQh8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765890709; c=relaxed/simple;
	bh=Da1yKunK6yDB+R6mPqFK1cShCjePJ/m3utIT45pGxK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzFdIQBdquuI1FkBLl+/t1C5U0sONFZzS0YHXFXWevR6MbVIGDPetLEXoE1BocbM7sHNj7r7SvDx6IT/+GEyQ5dHGH/MSoSqB4niFtufgqQPn0/XsI9nD2sY5kpZGq8PH/9nClEjP3H4U6sQreOFGwbb6mRgfWhmcm/lZJcrXJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=snNOJVhr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541BDC4CEF1;
	Tue, 16 Dec 2025 13:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765890708;
	bh=Da1yKunK6yDB+R6mPqFK1cShCjePJ/m3utIT45pGxK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=snNOJVhrs1y5uRk/+i8bK7uPgOScGa+5PgY81doUZnze2nir4I8i4wM2DlaXkZyUd
	 kirQ4pnG+67UXT5nng66/vqUHNHCuV2roh4WLFlDKF/GYriw81mSeH/xZFo2c+J+dt
	 3LHtUws1t29HzFPQIq8TFB6ZmXmLi6GpvHK19IiteVB1zJa14FL9YKW9N4a3mkFVxQ
	 2N2RzxO8vK3nN0hzJioU1NOk/ucZgB50OkQpBkYg1WD0Bvbvavt5eT3RY7q+gJeuzI
	 nyar/1Z490GUjBedE70DzQn2U8oPnj0rW426tIWnWCVP2A5ZAgDbRpEM6lZwVQhxX4
	 /vrrFgSN80TYw==
Date: Tue, 16 Dec 2025 18:41:44 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Thomas Andreatta <thomasandreatta2000@gmail.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	Olivier Dautricourt <olivierdautricourt@gmail.com>,
	Stefan Roese <sr@denx.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>,
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 0/13] dmaengine: introduce sg_nents_for_dma() and
 convert users
Message-ID: <aUFakHZL8viMN3WR@vaman>
References: <20251124121202.424072-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251124121202.424072-1-andriy.shevchenko@linux.intel.com>

On 24-11-25, 13:09, Andy Shevchenko wrote:
> A handful of the DMAengine drivers use same routine to calculate the number of
> SG entries needed for the given DMA transfer. Provide a common helper for them
> and convert.
> 
> I left the new helper on SG level of API because brief grepping shows potential
> candidates outside of DMA engine, e.g.:
> 
>   drivers/crypto/chelsio/chcr_algo.c:154:  nents += DIV_ROUND_UP(less, entlen);
>   drivers/spi/spi-stm32.c:1495:  /* Count the number of entries needed */
> 
> Changelog v4:
> - fixed compilation errors (Vinod)

:-(

drivers/dma/altera-msgdma.c: In function ‘msgdma_prep_slave_sg’:
drivers/dma/altera-msgdma.c:399:29: error: unused variable ‘sg’ [-Werror=unused-variable]

Clearly your script is not working. I am surprised that you are not able
to compile these changes. Bit disappointed tbh!

-- 
~Vinod

