Return-Path: <dmaengine+bounces-7282-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB41EC78EEB
	for <lists+dmaengine@lfdr.de>; Fri, 21 Nov 2025 13:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 0910E28AEE
	for <lists+dmaengine@lfdr.de>; Fri, 21 Nov 2025 12:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A44B34320A;
	Fri, 21 Nov 2025 12:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEBTj8gy"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA9930E855;
	Fri, 21 Nov 2025 12:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763726788; cv=none; b=j300Ymv9YkMFtSwXiepbPiKB9OmUuxdLqGmwRjNOfZF/5G+jqkDOs747O+ymFMHLXeI9B3IkAXNpFA8U7Lob1SbMcisPOE7RKYzQE5gsIszLgr7/AeJmXrNxgNcTB3DTFLPOd9RmnrdDdM/yz7WlJg9A9PcUCkGMafVTx+UDm0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763726788; c=relaxed/simple;
	bh=VqX7+WbzEjRbWfiARZi1O4BEpVb3WUA3Oo+pfFVi0W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DUkivB+67o8wuoUFwODLKTeuxvRoGSjedPgEIDOObvQ2Rjrcas3jbm+6g8jKDtH5MmnjQ8W6hz1zu8L5DgsQP2ExnekrjonXwCShJfGyBKeZ5c/r30j76MgvAYMyoLP/Oph4OYHpREagEEeaQkT6IW11rhgCnvB6R0dJasm+704=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEBTj8gy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C236C4CEF1;
	Fri, 21 Nov 2025 12:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763726787;
	bh=VqX7+WbzEjRbWfiARZi1O4BEpVb3WUA3Oo+pfFVi0W4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XEBTj8gyooZy0CocdtbIgZytL3SxTSMOjNLl/zyKqMnhPb4UuY8BnKRixPJ7g1qnV
	 WJyr0yuf4VbIiRQQhWi9UHYAMNMNuHmlgGXbgldsIxjafyKxMLO8dFMC7E234Cv6i1
	 8xzAVPvTt7dY5BT9xUNzjUf+kmDSJYRo2SdlwlcucSE4E+SP4udWzy7ui7uE+1Htow
	 kiK4BRirtZeytS2Awt9s8v/c/vtOir4GAhWNW9cRtyVJQRVB2QnPcasx3ko3cuicd7
	 flNaoM82MM6mbHlcexrYApURdbArzwqv63fbzV5LF61QmqroYnmKDsiR8ob7UO57XO
	 TJYFAyxkeYngQ==
Date: Fri, 21 Nov 2025 17:36:24 +0530
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
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>,
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 00/13] dmaengine: introduce sg_nents_for_dma() and
 convert users
Message-ID: <aSBVwOs3igPF71DQ@vaman>
References: <20251113151603.3031717-1-andriy.shevchenko@linux.intel.com>
 <aR9otpWZkPZrb9ug@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aR9otpWZkPZrb9ug@smile.fi.intel.com>

On 20-11-25, 21:15, Andy Shevchenko wrote:
> On Thu, Nov 13, 2025 at 04:12:56PM +0100, Andy Shevchenko wrote:
> 
> Vinod, what is your plan on the DMAengine patches? (Asking not only about this series)
> Please, tell if anything needs to be done from my side to help them being pulled.

Sure would appreciate if folks can review, make it easier for me to
pick. Yeah been behind for a bit, picking things now.

Reg this series, looks okay, who would ack patch 1?

-- 
~Vinod

