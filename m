Return-Path: <dmaengine+bounces-194-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DF47F5A5A
	for <lists+dmaengine@lfdr.de>; Thu, 23 Nov 2023 09:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B512815F0
	for <lists+dmaengine@lfdr.de>; Thu, 23 Nov 2023 08:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832D518C3C;
	Thu, 23 Nov 2023 08:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQ60Yr4D"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663A818C04
	for <dmaengine@vger.kernel.org>; Thu, 23 Nov 2023 08:46:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530A8C433C7;
	Thu, 23 Nov 2023 08:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700729211;
	bh=Gq20ZxmRSolswgb2G6DXtsmXB3yMAbJOuI31L5TBSvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rQ60Yr4DHag7rgtwu1Xlu4ys4dLSAzfk2xaEutrqND8a7Cfe3F2HaIwRyEzf5V3lH
	 CbdrFnhEu6B+2+P8kB4bcdue0LBn3tl6xlZ+E+0nXAjVf94mMxh+lJuOTwbrj1IRSF
	 irs0N2HnR702RPI5VU6RyAyZibBpqZ7of6MTz8YYJO3o9g9n8dlD7dPPax9iEvUEX5
	 l3JbX4YU3G7gwSELyPj3UGaQmvs52mx39001YLkRS7gSFnA3HDi/Ffi8w47objMAY0
	 rTnT7BjPjP0JcEv6oGcf5j0yTXKVoEUDCIOr0YxcLphcdib5QuNheyVHgoERf2BQfI
	 PUk+uejK9V/fA==
Date: Thu, 23 Nov 2023 14:16:47 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Jai Luthra <j-luthra@ti.com>
Cc: Ronald Wahl <rwahl@gmx.de>, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Ronald Wahl <ronald.wahl@raritan.com>
Subject: Re: [PATCH] dmaengine: ti: k3-psil-am62: Fix SPI PDMA data
Message-ID: <ZV8Rd9XanZEWEYJN@matsya>
References: <20231030190113.16782-1-rwahl@gmx.de>
 <akeklf5f3alqemdlssdgimqqqvkvbtqbbq3pxtsgkykma4fv3o@4op25kcmguja>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akeklf5f3alqemdlssdgimqqqvkvbtqbbq3pxtsgkykma4fv3o@4op25kcmguja>

On 23-11-23, 13:32, Jai Luthra wrote:
> Hi Ronald,
> 
> Thanks for the patch.
> 
> On Oct 30, 2023 at 20:01:13 +0100, Ronald Wahl wrote:
> > AM62x has 3 SPI channels where each channel has 4 TX and 4 RX threads.
> > This also fixes the thread numbers.
> > 
> 
> Please add the Fixes tag so this gets backported to stable
> Fixes: 5ac6bfb58777 ("dmaengine: ti: k3-psil: Add AM62x PSIL and PDMA data")

No need to add and post v2, b4 picks the Fixes tag and applies

-- 
~Vinod

