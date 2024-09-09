Return-Path: <dmaengine+bounces-3125-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FA5971E96
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 18:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 306142841AD
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 16:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA64F21364;
	Mon,  9 Sep 2024 16:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljIimPuB"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E81125A9
	for <dmaengine@vger.kernel.org>; Mon,  9 Sep 2024 16:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725897651; cv=none; b=cZcKf9sIuDaucUox/XPkA79ip1ht9GXPT3itC8WM4i0KpqZBl5X5s/68qD6t6/6S7XTr4BnngzG0aEoZoRw7B6O8JN5qJifmvIBj3N6yCSTpsVdtSI2+XAdZ5YASOkjcoO/jxmkelKWs5JF1bCQznCnKJPpiOE2EKjYUfXb91+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725897651; c=relaxed/simple;
	bh=9l/WdTpYA1Ng0wklEwfqBXcOX1h6NX+3KMEZu47gvOo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Gs/aHW3ztZtgOrFRKnU3RyjMfUeE0nXInrkvCtVMN51AwKPRNuhzHM0bz5s19Gt/qNPTj8sk1Shp2d9stniXN6BMOhaaur6ZA62zfrm3nTUOqSrnFe/cH6GrFbjyseCl9861/lEvkPoruvijx5LQIK0Tc/iKZRxtKlNZw0vd5LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljIimPuB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518A6C4CEC5;
	Mon,  9 Sep 2024 16:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725897651;
	bh=9l/WdTpYA1Ng0wklEwfqBXcOX1h6NX+3KMEZu47gvOo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ljIimPuBuO3gcpfqSKplLRdlpSF2P0QV+VRus3a8SyYPlO4W6W47+9uMakbTcWEHH
	 DgfQ8dgBQ06V0OL1AVCP5Hv8d3/RD22ivXhTKs/xJQJ/iGp+yBvvzPHnQ+vL89cdIl
	 +7XpvgTIg6cHF20/Ax793rpAGLl4uPQORF0VQw7xug0nPh/SCdHHaDaHf0j6b8TxfX
	 CgUEzbhste1BcCAzn8FF1DsO0vnEh8dfYxRIzUlOJdyr/6Qy0hBueMHs3FlnbY3Rvz
	 LD3eOc/I3bYFKq2lpjEOg/Vqj1qQkdoQaXHJcP03m/XX9y/h//eHn896vD1/Czqg78
	 rX1fyqhTtXm6g==
Date: Mon, 9 Sep 2024 11:00:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Raju.Rangoju@amd.com,
	Frank.li@nxp.com, pstanner@redhat.com
Subject: Re: [PATCH v6 1/6] dmaengine: Move AMD DMA driver to separate
 directory
Message-ID: <20240909160049.GA531275@bhelgaas>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909123941.794563-2-Basavaraj.Natikar@amd.com>

On Mon, Sep 09, 2024 at 06:09:36PM +0530, Basavaraj Natikar wrote:
> Currently, AMD PTDMA driver is single DMA driver supported and newer AMD
> platforms supports newer DMA engine. Hence move the current drivers to
> separate directory. This would also mean the newer driver submissions to
> AMD DMA driver in the future will also land in AMD specific directory.

Since you're adding a second AMD DMA driver, the one-line git history
will be more useful if you mention in the subject line that this patch
moves the "PTDMA" driver specifically.

Bjorn

