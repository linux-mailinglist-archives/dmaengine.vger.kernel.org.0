Return-Path: <dmaengine+bounces-1024-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4722857C5B
	for <lists+dmaengine@lfdr.de>; Fri, 16 Feb 2024 13:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69D59B20FFD
	for <lists+dmaengine@lfdr.de>; Fri, 16 Feb 2024 12:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01D677F2C;
	Fri, 16 Feb 2024 12:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzoo9Idw"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7815C42058;
	Fri, 16 Feb 2024 12:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708085540; cv=none; b=kZIOAp1lC86CrT2dN1cnhUvZeeXui5mnjOmvVt11SDEsw6HL02lxEpXvnRhXTBWhX7PTId+gzyAj7zTFCM3Zm9gWa75WP9vJLM9K2tFheWJFhaOZ9CUnwE2a0C8owvpBaKW46638F0f0pXl95hvzjMj/oU2CLY/Ht4DCHdXpX8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708085540; c=relaxed/simple;
	bh=t8kROlBZmJZfjhkfRWSdWmMld9gpi3U8ivE9FyVW+ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkhk9M+tZpW2xNJL27lPXqqtcvzI2tv4sGYm7FnfcjnCAIWJMTykb9zut6MpYuuye+m5QT0sJZ2CI4NmpYsabmI3ut3wFmPItTVjM9nMbfY5eiy0tk+XpeNeNyocTDYepuz1/Is+0m3VDWUnllIt0IoNPE0a4I8nfJHrJRiPffE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzoo9Idw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3A4C433F1;
	Fri, 16 Feb 2024 12:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708085540;
	bh=t8kROlBZmJZfjhkfRWSdWmMld9gpi3U8ivE9FyVW+ok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bzoo9IdwqOP8ZRyKRTNeqqzcRHhZc1rSfsZcfCfjvl0c8kElgq2+1JX4WAyqPD+/a
	 ehQmOf8grmrwVDFCSakH7EZQa9evaYrY4v5EiYKbq1HhGJ2wjXRRbzUwGy02kuDTDk
	 QzSwXlEawcMIzhLp9Q8Y+FnMeEYPHPJ/mobrN5Y5pWPu4C+w9VtUSGkZ/tMgv9zW3U
	 pskDxny2iYgGEiooKF00NfX0Sk2Kh4Vit1VcwnFj5nq7+6Uig+fw7M5AGenXZeodcM
	 dnIWgVXr2EoNspUXOD7rxRR1+Tbq7S4Emo9IJbkRTgOkRkIfAEYath3trs2ZtTvBTq
	 1uw+lf+D4GSUw==
Date: Fri, 16 Feb 2024 17:42:15 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Kelvin Cao <kelvin.cao@microchip.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, logang@deltatee.com,
	George.Ge@microchip.com, christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v7 0/1] Switchtec Switch DMA Engine Driver
Message-ID: <Zc9RH1kV0ILtzEpa@matsya>
References: <20231011220009.206201-1-kelvin.cao@microchip.com>
 <ZcsButDIoe0AjiuD@infradead.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcsButDIoe0AjiuD@infradead.org>

On 12-02-24, 21:44, Christoph Hellwig wrote:
> On Wed, Oct 11, 2023 at 03:00:08PM -0700, Kelvin Cao wrote:
> > Hi,
> >  
> > This is v7 of the Switchtec Switch DMA Engine Driver, incorporating
> > changes for the v2/v3/v4/v5/v6 review comments.
> 
> DMA engine maintainers: what is blocking the mege of this driver?

This seems to have missed, can you please rebase and repost for review


-- 
~Vinod

