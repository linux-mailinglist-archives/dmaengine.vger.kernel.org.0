Return-Path: <dmaengine+bounces-1081-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1B5860AFA
	for <lists+dmaengine@lfdr.de>; Fri, 23 Feb 2024 07:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 137F21F249CE
	for <lists+dmaengine@lfdr.de>; Fri, 23 Feb 2024 06:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EB612B98;
	Fri, 23 Feb 2024 06:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgRqckuH"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD0F12B68;
	Fri, 23 Feb 2024 06:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708671134; cv=none; b=QBHMdEmTpYv4wTuFIxP1QbQz9+4xXEJkPUwvz3Vp+CrPOqj1txPtJZPpT+oNDSXT086qT+GijETSRGd9T4mnydiKgoSB4w+ULKG07Cks2JuSZ1DAmX4yREndljKSfO+xRHdOVHoOhbyE13L3ZNvQzx8l/0fMT9lAGtKS+7OFHOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708671134; c=relaxed/simple;
	bh=PD7fumnCozoMq2DQsY+y9uUvvocD8d5Y6Kd1TmUZGME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dw6wYSOSZNv9NmwGcjm2zrx4RvTgGhvXPtoy3Co8AEzqSFXtZ3tXfyWen++oLFUeLiS1gvBiFLCpNMvj1ixPB105x0ogfEUXqPORuiFha+vYuBRir6EqrXLww+3M5GitOrHXoKRM4W2gBxDw54WlYYfm04WVsL3lEpX5T5lNARY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgRqckuH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B55C433F1;
	Fri, 23 Feb 2024 06:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708671133;
	bh=PD7fumnCozoMq2DQsY+y9uUvvocD8d5Y6Kd1TmUZGME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PgRqckuHHpeG6b/y+o1PlCuXDpjKutm2i7hjezlMXMLPBb4fBDGxRoOSNKJHhc8pE
	 OxBj9vmBbGXqqVb5ZcyIHLvTL2ICq2QGj40anvgA8T11EbYQfYxjLDfIOhy50t3JMI
	 Mm0y4D6JhnVTx3iq0aB6Z6Zf3n5RombqXY77ubmVYR7t2wTkZKJ/yBO+2naiOXMZYW
	 jFIjOmwmh4ifN+ZhZqzBDtOG/ieym/d7W8QeHMBAFq/M7fgIGnyqDg+ezEk/4AMDZU
	 jrzktN9+DJDPhD2hLFa3YhCZ+1wMDIAtsxd1laZGv148Gr+FTna61ctdu88J7TZ6tW
	 sXM897v+vajJQ==
Date: Fri, 23 Feb 2024 12:22:08 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" <dmaengine@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dmaengine: fsl-qdma: add __iomem and struct in
 union to fix sparse warning
Message-ID: <ZdhAmICEsIxtJYFI@matsya>
References: <20240219155939.611237-1-Frank.Li@nxp.com>
 <ZddTmwh82K6biJSx@matsya>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZddTmwh82K6biJSx@matsya>

On 22-02-24, 19:30, Vinod Koul wrote:
> On 19-02-24, 10:59, Frank Li wrote:
> > Fix below sparse warnings.
> 
> This does not apply for me, can you rebase

Nevermind I had issues in my local branch, this works

-- 
~Vinod

