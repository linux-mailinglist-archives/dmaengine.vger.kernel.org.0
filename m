Return-Path: <dmaengine+bounces-4515-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D547A399B0
	for <lists+dmaengine@lfdr.de>; Tue, 18 Feb 2025 11:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A4016A5A9
	for <lists+dmaengine@lfdr.de>; Tue, 18 Feb 2025 10:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC4323770D;
	Tue, 18 Feb 2025 10:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGdJ0xWo"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3476822D7B1;
	Tue, 18 Feb 2025 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739876079; cv=none; b=CAPoGX0nttFuclGDQaeW7Kjqgk1TZcKkd6P0EkQpeJFQuP7KjvQldRp45xz87dSvTLyj1evOMjQUXCjArwtV0PI/unP5Rv48n5v6o86kES+juAot1UDeohDXGzkN0KtCJPd/kct3BG9+yqNCr0OBTUHs/lmEKrAX+eJLAPVocTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739876079; c=relaxed/simple;
	bh=RdaxUeKvZh5sL0uJ9BtFySXbqU59fk3zLkq47gAsBp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGNLHsEKg1XeUDBwxLbFtr8hWw/NF+mQgB4oqcu12Kg/0Jb6u9oMMSGvlPa40KmL1fUoF1hSrN4YCEtdYjjssnVgXK68NMWCXP/RvTuGzNWNmpLBKgNOECczyK4J+JKsPE71Pu5+/kgWx73N6cjnJ1vLAVoBs0HV7XrnZhqHVn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGdJ0xWo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED8EC4CEE2;
	Tue, 18 Feb 2025 10:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739876078;
	bh=RdaxUeKvZh5sL0uJ9BtFySXbqU59fk3zLkq47gAsBp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NGdJ0xWorHM+qXxP6z1rSeaxtuPdGwDGjNbPbIrWqn2LZYrgAwf7tfZPrZJfTUp2k
	 HAQMk4W5ei9khWJkMH+utPXmDd1oRqzwdKNh9yBkDxqo1Kwqm7JawToKHk8S3bNLF5
	 QMihBcdYKQBetKQdUBAtsQ1mDQE0HTxkQv5d2v8ZgI2LSYNRcy31utnMKWhBXPPncG
	 ypCuFYUO6ZlKV2AfP3Yxt9Fl9YLBOWK9PtChtQ2AxuKkBcc6dZu/LME9uclFbq9nbh
	 a0BqbTtPB8mlohh/4vGAClo6rDyAh9d1d6UUrjKeY+V9JAqdWuFSvfb13pdTSf+qOJ
	 NQ9zKlK53hOGw==
Date: Tue, 18 Feb 2025 16:24:35 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
	git@xilinx.com, Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Conor Dooley <conor+dt@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Harini Katakam <harini.katakam@amd.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Mark Brown <broonie@kernel.org>,
	Michael Tretter <m.tretter@pengutronix.de>,
	Michael Turquette <mturquette@baylibre.com>,
	Mubin Sayyed <mubin.sayyed@amd.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Niklas Cassel <cassel@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" <dmaengine@vger.kernel.org>,
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
	"open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" <linux-ide@vger.kernel.org>,
	"open list:XILINX AMS DRIVER" <linux-iio@vger.kernel.org>,
	"open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
	"open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: xilinx: Deprecate header with firmware
 constants
Message-ID: <Z7Rm6/DYM67QbXvT@vaman>
References: <cover.1738600745.git.michal.simek@amd.com>
 <2a6f0229522327939e6893565e540b75f854a37b.1738600745.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a6f0229522327939e6893565e540b75f854a37b.1738600745.git.michal.simek@amd.com>

On 03-02-25, 17:39, Michal Simek wrote:
> Firmware contants do not fit the purpose of bindings because they are not
> independent IDs for abstractions. They are more or less just contants which
> better to wire via header with DT which is using it.
> That's why add deprecated message to dt binding header and also update
> existing dt bindings not to use macros from the header  and replace them by
> it's value. Actually value is not relevant because it is only example.
> 
> The similar changes have been done by commit 9d9292576810 ("dt-bindings:
> pinctrl: samsung: deprecate header with register constants").
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>  Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml  | 4 +---
>  .../bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml           | 3 +--

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod

