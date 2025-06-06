Return-Path: <dmaengine+bounces-5314-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D99AACFAF8
	for <lists+dmaengine@lfdr.de>; Fri,  6 Jun 2025 03:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998641897543
	for <lists+dmaengine@lfdr.de>; Fri,  6 Jun 2025 01:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D80D199E9D;
	Fri,  6 Jun 2025 01:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRe0gSRC"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F7218DB35;
	Fri,  6 Jun 2025 01:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749175096; cv=none; b=MjC65Rp5+DcfL/26Vanp8hTimaFL+RbzlZ5xkMpzquJh4+p9g53a9ooJ5DET6chY0xe4xGFh0DgwSYaQHlMcln+d77aXvRixU/KZJ15GV3E33KKKgAJqRviDFJsCFArADhZzm0cF5R225yeQvzO1c3vtGGzKXkR2O0tEGbyXlC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749175096; c=relaxed/simple;
	bh=fvsp6DDJ+BH8dacb9TxLXhMPsKVSddPeCO2+15MLg9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKb+EbuRRI1xaffOZvY1noOaN51rYg0SCkItjTCWi9nlvcbMT8mitnSxaD+M9w24UhWwKJFoX3SSyd4PbefKpD/p5dyPwBtTmyKUbHcUBD8MHedJUTIYqXxTJUlDFIH8CgcKWS/Ug5U2M0tR/a7E9Wy3o6zlR7+CiDNivFRXn+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRe0gSRC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EAEC4CEE7;
	Fri,  6 Jun 2025 01:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749175095;
	bh=fvsp6DDJ+BH8dacb9TxLXhMPsKVSddPeCO2+15MLg9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kRe0gSRCrelrgyp/mZuwyHPtd576I4agx8Rx9Sd0KQbMsGAKpIbHks6XBQ1DlQUO7
	 mFDVWzsAM5sonZ8lokEYrcc3fTwOzmbDVSqzNzxDz68Q97jkqPt6lLXE0B4yYY9/r1
	 Qob2pqjedfVLUtLPoYxR7m8pDMxAGrKdZ/vmfPnPAqKrsTwb5ndTxPoFZTqhn82VVY
	 qiLzXxY+edKgEryT3IMtE2G7o1wVt3HmdCRWh4aUhFy9lDHeeLnt4dvYN9rRrbnXjD
	 vhiEpUPtcT86Kbu4OipTEfk8WJQaaJmn/V2+Dy+NzsfcJgPiNMjgI+xlhYtSyAQfgm
	 R33dD9bNRu0Cw==
Date: Thu, 5 Jun 2025 20:58:13 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	linux-clk@vger.kernel.org, linux-phy@lists.infradead.org,
	Michael Turquette <mturquette@baylibre.com>,
	Vladimir Zapolskiy <vz@mleia.com>, Vinod Koul <vkoul@kernel.org>,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	Lee Jones <lee@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [PATCH 1/1] dt-bindings: mfd: convert lpc1850-creg-clk.txt
 pc1850-dmamux.txt phy-lpc18xx-usb-otg.txt to yaml format
Message-ID: <174917509146.3764775.13664776739323351967.robh@kernel.org>
References: <20250602143612.943516-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602143612.943516-1-Frank.Li@nxp.com>


On Mon, 02 Jun 2025 10:36:10 -0400, Frank Li wrote:
> Combine lpc1850-creg-clk.txt pc1850-dmamux.txt and phy-lpc18xx-usb-otg.txt
> to one mfd yaml file.
> 
> Additional changes:
> - remove label in example.
> - remove dmamux consumer in example.
> - remove clock consumer in example.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/clock/lpc1850-creg-clk.txt       |  52 ------
>  .../bindings/dma/lpc1850-dmamux.txt           |  54 -------
>  .../bindings/mfd/nxp,lpc1850-creg.yaml        | 148 ++++++++++++++++++
>  .../bindings/phy/phy-lpc18xx-usb-otg.txt      |  26 ---
>  4 files changed, 148 insertions(+), 132 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/lpc1850-creg-clk.txt
>  delete mode 100644 Documentation/devicetree/bindings/dma/lpc1850-dmamux.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/nxp,lpc1850-creg.yaml
>  delete mode 100644 Documentation/devicetree/bindings/phy/phy-lpc18xx-usb-otg.txt
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


