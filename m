Return-Path: <dmaengine+bounces-5522-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6C3ADDAB1
	for <lists+dmaengine@lfdr.de>; Tue, 17 Jun 2025 19:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA1121887ED8
	for <lists+dmaengine@lfdr.de>; Tue, 17 Jun 2025 17:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502F928505F;
	Tue, 17 Jun 2025 17:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFyj07kM"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC51235067;
	Tue, 17 Jun 2025 17:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750181395; cv=none; b=pzAofXeMJs7sIjPfbYio+FleaV9g1WLozJqwlZhuCKzKmTKU6LZWvDo5NsTq6hRFujnCuasggzFKZGUe1I9mjcTJVI7k6+lvkXIUudExwPrtCLKzv7Fa5XbfJwDoyQ+m7N54I3GKsuwuc9lD/b5FSdMH0onkCf8pDbu9ps5/cHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750181395; c=relaxed/simple;
	bh=kP7DtPobetpD8bDkvcYCTMcEVbz+KzFg7wDQrlKUqKQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gG3JOqUKsRqZPgIce0sE4jatazc2eCteq4IvnEL+oIajikzZvjASLTyTcYq8OFy0Zuvh3SeaP56+71P5GDWBoj82b72Ycbwlqq5RO/8wH5sZVQdzgH+XsR1Rx/1UO7TFsfHE6u/CLHkEeADFdDCW0aMzh3kIVwXYuqfJ8BbBNHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFyj07kM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE75AC4CEE3;
	Tue, 17 Jun 2025 17:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750181394;
	bh=kP7DtPobetpD8bDkvcYCTMcEVbz+KzFg7wDQrlKUqKQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nFyj07kMSeHI22kL0ri0CoBmyqpg+75j55Xz+grZh1JBQ0M8Nw93ijsbWsLg201cm
	 CTDpDR3MGpekcIM0ol1iK9alHd28sFBTJmLsdmNAssAbMYx2083F2kWC3EY6A65ie0
	 QtGJHodFUApA6ak8u/529aLXDPefdcLRKpPlG28GNoBXOkDx/AJY2Fh5/ZXpdl8qcp
	 TblkEjEulg5TKI9aC9N86NuIvYEHSjkI/pO4rxNy7EgV+v+O4cHkBrpV0HMm9YAQhg
	 0U30SvS6CIcL1pjjdEj1rva/4ErLB5psnbCL5tfH1JqhkrHWayRQVVeZrk9azFM9ZO
	 YS3kPy4ZB4tog==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Inochi Amaoto <inochiama@gmail.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Yixun Lan <dlan@gentoo.org>, 
 Longbin Li <looong.bin@gmail.com>
In-Reply-To: <20250611081000.1187374-1-inochiama@gmail.com>
References: <20250611081000.1187374-1-inochiama@gmail.com>
Subject: Re: [PATCH v14 0/2] riscv: sophgo: add dmamux support for Sophgo
 CV1800/SG2000 SoCs
Message-Id: <175018139039.182101.4835726385229916529.b4-ty@kernel.org>
Date: Tue, 17 Jun 2025 22:59:50 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 11 Jun 2025 16:09:57 +0800, Inochi Amaoto wrote:
> As the syscon device of CV1800 have a usb phy subdevices. The
> binding of the syscon can not be complete without the usb phy
> is finished. As a result, the binding of syscon is removed
> and will be evolved in its original series after the usb phy
> binding is fully explored.
> 
> Changed from v13:
> 1. rebase to v6.16-rc1
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: dmaengine: Add dma multiplexer for CV18XX/SG200X series SoC
      commit: 994b5709f9f83c48f607e9a52912c912b8149421
[2/2] dmaengine: add driver for Sophgo CV18XX/SG200X dmamux
      commit: db7d07b5add4d839df74adab9940cf9da488313f

Best regards,
-- 
~Vinod



