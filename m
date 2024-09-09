Return-Path: <dmaengine+bounces-3126-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3891A971EBC
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 18:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 636C11C222AD
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 16:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488C33D38E;
	Mon,  9 Sep 2024 16:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l66tPyZo"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D771BC40
	for <dmaengine@vger.kernel.org>; Mon,  9 Sep 2024 16:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725898049; cv=none; b=sB1zNWax8DEmN/5EAK9+Ll1ThBae1GuDtvTc6wbKR3pzyfyjEcwav++puGRO8JsOSpav1U6wk7VZrHfxiX1uPSSXN8JYNOChpR7RmVGYnmSpHj9YXMe+Uuje0wU+vH0KOQFoZr7/4kgxTiU0rH1iHdteWJmcE6bkgkvHP06in6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725898049; c=relaxed/simple;
	bh=wWw5X1YRkYTQbwPlhEAN3Vb7D2tsUzM5fNA7hQRKkBI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lGHSGTkDPNeqVf5Cf/a2UJW5lAADDoo7NQ0Ez5e3Be4lY7icD2m61KHemf7KofxVl2ZMd1kXnX4IV/4P7gTCjCqpHdfqnk2cXWdpxVLKVu5i8muhVeotGRnXe0Ab/DcMrBNfinpqUK6MsLw7pLKICA7r1D3nv/9I6SFs46CzOec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l66tPyZo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D76C4CEC5;
	Mon,  9 Sep 2024 16:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725898048;
	bh=wWw5X1YRkYTQbwPlhEAN3Vb7D2tsUzM5fNA7hQRKkBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=l66tPyZopdrLX88zE50I7FQezA3bD2/b7ADtqejoDuhxQavg/GPHGJycHUplCOe8n
	 QsGzjxRLXZNjlawFzcYSEd6cILAyJdqlzoBnOzq7wtDWhAUmAWr4ZnavtBDQtAT6zE
	 Mm4+VZ7ExFLpg7dasGrdpRuoHBCYoWG29nGvllj3ThZAg2tU/yfkXZ6lPv5uegFzCW
	 nSxAH8dIfpcsSTwjO5TdIYXOnNlBoYnOXar+WyqC7v0ZarhvNsp2UH2R4sfJqf7PZ3
	 ZwAD5b8eKfJzrSw2RVMqaQ8QIrAsfdBW9IEgZ1kSWPJcOpR/1zDDFzmt44LufUziYR
	 Um73MAckMp46A==
Date: Mon, 9 Sep 2024 11:07:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Raju.Rangoju@amd.com,
	Frank.li@nxp.com, pstanner@redhat.com
Subject: Re: [PATCH v6 2/6] dmaengine: ae4dma: Add AMD ae4dma controller
 driver
Message-ID: <20240909160726.GA531636@bhelgaas>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909123941.794563-3-Basavaraj.Natikar@amd.com>

On Mon, Sep 09, 2024 at 06:09:37PM +0530, Basavaraj Natikar wrote:
> Add support for AMD AE4DMA controller. It performs high-bandwidth
> memory to memory and IO copy operation. Device commands are managed
> via a circular queue of 'descriptors', each of which specifies source
> and destination addresses for copying a single buffer of data.
> 
> Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
> Reviewed-by: Philipp Stanner <pstanner@redhat.com>
> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> ---
>  MAINTAINERS                         |   6 +
>  drivers/dma/amd/Kconfig             |   1 +
>  drivers/dma/amd/Makefile            |   1 +
>  drivers/dma/amd/ae4dma/Kconfig      |  14 ++
>  drivers/dma/amd/ae4dma/Makefile     |  10 ++
>  drivers/dma/amd/ae4dma/ae4dma-dev.c | 198 ++++++++++++++++++++++++++++
>  drivers/dma/amd/ae4dma/ae4dma-pci.c | 157 ++++++++++++++++++++++
>  drivers/dma/amd/ae4dma/ae4dma.h     |  95 +++++++++++++

Just kibbitzing here since I don't maintain anything in this area, but
IMO there's no benefit to splitting this into three tiny files.  It
would be easier to read the driver if everything were in a single
ae4dma.c file.

Bjorn

