Return-Path: <dmaengine+bounces-7299-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CF16BC7CB64
	for <lists+dmaengine@lfdr.de>; Sat, 22 Nov 2025 10:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5A0AE35B1EA
	for <lists+dmaengine@lfdr.de>; Sat, 22 Nov 2025 09:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74592F5A18;
	Sat, 22 Nov 2025 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqPT0eUR"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4D62F5474;
	Sat, 22 Nov 2025 09:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763803823; cv=none; b=dg4gKTlHN67QCwy6zi4sl3yyVZr9oOG05qokpMjGEy4NUV2P9Kz4y03b2o+VUQfiIruHBbPCswYdX1s7atYEReYk/4RDUTtp8cx9Ps/iVcLtsEZQkB5imlkM8ZjcUauBcS3p7ucjAWhkl/zr4F7Lvo79E5qvlDhRSolw1z3Knuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763803823; c=relaxed/simple;
	bh=bgqeVmFwquEdzx/+UAZWdEVedVcxqk6WFQnieq/ExE8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TvCevGAMu2VIzbDpKFYjPNl2mzzMqhVySsdPq0MdaYUB1lwf18hnUTz+5wFmbHeNW31k6unBssHeu2sE4gEwwhmTu6FC+RQBjBJYwzlQ/KKokr6rcDnKbx5H3SAHn+TV1H5X2YkMieVF28hpceliH/QhvRLspVXfS623VQFPtP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqPT0eUR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA0DC4CEF5;
	Sat, 22 Nov 2025 09:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763803821;
	bh=bgqeVmFwquEdzx/+UAZWdEVedVcxqk6WFQnieq/ExE8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=EqPT0eURQTZSptIly9yz5Opuly5/189Bx7GTY4kADr3XYi5rQ7izeMGTkmCFRbyqJ
	 fWKoOYRcvema+jB1AmSrJuNNI0hapYHLvgw7pMVtQIY8YPnzYhtDU5eoqtBO8w5EE/
	 vV0GDulI7m44VM/JKKRtELdCUtSZB6hRCqfFU4DCyKNMmnbHO3v/Epk403K3y7lIFG
	 FlRMKMSvsAcfNz5MNITHoeDfqNNXbM4Go18H1UzPhCRxxQ4k21S3R+EsSs0TVzTtLS
	 1ElZQpmdfUGMSstxex5gM6zrrXzsh1Ry6wchBfo9XOI8zZEfzrfLfkEDltxU/blyfe
	 8YPZu81U6qqUA==
From: Vinod Koul <vkoul@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Viresh Kumar <vireshk@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Frank Li <Frank.Li@nxp.com>, Laxman Dewangan <ldewangan@nvidia.com>, 
 Jon Hunter <jonathanh@nvidia.com>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251120114524.8431-1-johan@kernel.org>
References: <20251120114524.8431-1-johan@kernel.org>
Subject: Re: [PATCH 0/9] dmaengine: drop unused module aliases
Message-Id: <176380381899.330370.14109908642480701750.b4-ty@kernel.org>
Date: Sat, 22 Nov 2025 15:00:18 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 20 Nov 2025 12:45:15 +0100, Johan Hovold wrote:
> When fixing some device leaks in the dmaengine drivers I noticed that
> some them have unused module platform module aliases that can be
> removed.
> 
> Included is also a related clean up.
> 
> Johan
> 
> [...]

Applied, thanks!

[1/9] dmaengine: bcm2835: drop unused module alias
      commit: bfab38bee5652f335c5d693d54eb61bc25850518
[2/9] dmaengine: dw: drop unused module alias
      commit: 660c40702d9073035c61a9573b299481b9c7f3cd
[3/9] dmaengine: fsl-edma: drop unused module alias
      commit: 03adb0eb0ed64a1e13e04c0fb57a073896efe6ca
[4/9] dmaengine: fsl-qdma: drop unused module alias
      commit: 9180a66fb43214ae02311176e43eec361ff80d67
[5/9] dmaengine: k3dma: drop unused module alias
      commit: 73b77c3d80031b4636a24912962ffeb295438b0a
[6/9] dmaengine: mmp_tdma: drop unused module alias
      commit: 73391fecf23860804bceb6670cef74a3626ecf92
[7/9] dmaengine: mmp_tdma: drop unnecessary OF node check in remove
      commit: 3b7b0bbdcba984287225bb373e52845c23dadb93
[8/9] dmaengine: sprd: drop unused module alias
      commit: 1911f507a54b42bd01ae30590c06d8140beee424
[9/9] dmaengine: tegra210-adma: drop unused module alias
      commit: e0aef2a5c33680bbd332e5b5f64afc8dde8d46f6

Best regards,
-- 
~Vinod



