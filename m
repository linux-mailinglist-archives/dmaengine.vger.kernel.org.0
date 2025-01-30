Return-Path: <dmaengine+bounces-4239-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 059A7A237BB
	for <lists+dmaengine@lfdr.de>; Fri, 31 Jan 2025 00:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59828162F18
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2025 23:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561811BD9E3;
	Thu, 30 Jan 2025 23:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERqVUCNt"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BA519DF99;
	Thu, 30 Jan 2025 23:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738279207; cv=none; b=pXmTs5kYsN79N++7qLvMrXSD08mN2cGaVdQjHMvrA6vaUMWEkMIknJmDPoejBYvhpXUdzVfhmVIa3wAH5p2dAEVO7hEEJIZjsgjHYj8yeomDyh7KVCaiLSv84sk+nEIQIV0WZrgERWXzHxToEwTWvmvLrk5F1Ssh+pnJnAyWMOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738279207; c=relaxed/simple;
	bh=KpU19pPWgjFCuwWnk0SmFXgxBVKLllJYcw36Fo9osrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLdRYk+NQvjgv+Vqpa9N5igQIVUj7PjDYmqHqi8oM7a+uZOSKGld4PILlhjnEHPtsuPiwsaxjrwMCtkbdE7U9DPgCLgxG+t9M6WozVKPHM2QMJq+KT8CzI864fiy1qbaMMYHy9vZRGJn+PTdQ3XhhoqW9iNXeZVVvdLhoINkz6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERqVUCNt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DBEC4CED2;
	Thu, 30 Jan 2025 23:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738279205;
	bh=KpU19pPWgjFCuwWnk0SmFXgxBVKLllJYcw36Fo9osrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ERqVUCNtbs+MzLdhNdvgBbEjriNPD+yPZlBdTguGqhpz6nhLt0Q1qEpzAz1NpSC+U
	 UJRC4z+qMWIPBsk+AkOOIm8AAYpM0t2iMy1oWJ3OisQC2mXpY2wDDNo7yMV5e5te0d
	 qjeh/puZLvAbfjwaYR+VQcPxIdPfDGSMakwFr6s5tWOGEYAvliMRWa3/burDmWPvc7
	 aWJsFVAKeOPJP3JgMiUv3mLaItpjObrdvpYggJrl1DzHKdWgxWFIST81ZsBDj5ZBo1
	 W7KIlck3OGfLXlCXHkzatU6xx1VGcNbZ0Nmx360SlZWcm1LWhyjcrTQcRMDnsD7Y7D
	 NJYRI+1Iq4ldg==
Date: Thu, 30 Jan 2025 17:20:04 -0600
From: Rob Herring <robh@kernel.org>
To: Florent Tomasin <florent.tomasin@arm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	"T . J . Mercier" <tjmercier@google.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Yong Wu <yong.wu@mediatek.com>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, nd@arm.com,
	Akash Goel <akash.goel@arm.com>
Subject: Re: [RFC PATCH 1/5] dt-bindings: dma: Add CMA Heap bindings
Message-ID: <20250130232004.GA1818629-robh@kernel.org>
References: <cover.1738228114.git.florent.tomasin@arm.com>
 <771534be8dfa2a3bdc3876502752f518224b9298.1738228114.git.florent.tomasin@arm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <771534be8dfa2a3bdc3876502752f518224b9298.1738228114.git.florent.tomasin@arm.com>

On Thu, Jan 30, 2025 at 01:08:57PM +0000, Florent Tomasin wrote:
> Introduce a CMA Heap dt-binding allowing custom
> CMA heap registrations.
> 
> * Note to the reviewers:
> The patch was used for the development of the protected mode
> feature in Panthor CSF kernel driver and is not initially thought
> to land in the Linux kernel. It is mostly relevant if someone
> wants to reproduce the environment of testing. Please, raise
> interest if you think the patch has value in the Linux kernel.

Why would panthor need CMA, it has an MMU.

In any case, I agree with Maxime that this is redundant.

Rob


