Return-Path: <dmaengine+bounces-4379-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 422C6A2EAFD
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 12:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BA087A1C0F
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 11:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFE31DED6B;
	Mon, 10 Feb 2025 11:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUwg/hZ4"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994441CD208;
	Mon, 10 Feb 2025 11:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739186618; cv=none; b=K4HmyCmpPfosFBee0EmFMD2F6HswYtP3ST+POpEB86uW7PJTEcT8ZozKeWz/6dKpUS+P7SAsO+cZa3g9gsqIjX7+ojxUpVFshDEgKnbl5N9S7mhsd42KYp55Nce0BRnxwWcwDCPaCJ7sfBCCcyxJFwbXeV9QZzcuHWU+Z8WmUyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739186618; c=relaxed/simple;
	bh=Ss0VZ01xT2A7uKNNNMGNFZ3kAt/J7/1E6lUcUsfMt1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2IxL/wPPXz4MPlVX6j7Fn/+s92htJYmPZ9oly12VoRXV1Pv5aioFiTgRnayRXGejL8aFQITuPanQaiGRAgAoY8tf6IaEZwu6GK4QDli1usA3hKiGqrquQo6bSliweMyMARvdHoVQWoDwwJ6b2HnYmE6tNhEwFFP7IsiydvJUlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUwg/hZ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E4EC4CED1;
	Mon, 10 Feb 2025 11:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739186618;
	bh=Ss0VZ01xT2A7uKNNNMGNFZ3kAt/J7/1E6lUcUsfMt1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nUwg/hZ4j4VqfkdW2z+DzOsoGadv71DLbwv2LOXYSMyBdgvs0sge884QBXc+8RGaV
	 l45UumlTyfuS6iVNdjHeRk9aPdJiSuLWZBbup37aQLUiulotHVlSQee8C4f9z6vldL
	 fJIplFTNqPDtGSoTy8jBuSM5JLYvA8AH4K/RfymXV7seneBh9I01qrTQ5CreS6BvLS
	 N3zovYs+S8nBpkzI+xEKhuPpo6kJ/Jozhe0/2hzZAGgGm54IYvAWIZDVazn0qccnJt
	 u/FeTICzwEDfYHQB120f6oJK9veIqDP8UUEAmn2vAEYdZMh5F8hs7Id0afHY3so1R/
	 kam7p/dX0U/+A==
Date: Mon, 10 Feb 2025 16:53:34 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Mohan Kumar D <mkumard@nvidia.com>
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com,
	dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4 1/2] dmaengine: tegra210-adma: Fix build error due to
 64-by-32 division
Message-ID: <Z6nhtrs1rYXcQOBl@vaman>
References: <20250205033131.3920801-1-mkumard@nvidia.com>
 <20250205033131.3920801-2-mkumard@nvidia.com>
 <Z6ncuLHotCAw61b5@vaman>
 <2d190825-5284-4ac6-9735-051849bc9bb6@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d190825-5284-4ac6-9735-051849bc9bb6@nvidia.com>

On 10-02-25, 16:45, Mohan Kumar D wrote:
> 
> On 10-02-2025 16:32, Vinod Koul wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > Hi Mohan,
> > 
> > On 05-02-25, 09:01, Mohan Kumar D wrote:
> > > Kernel test robot reported the build errors on 32-bit platforms due to
> > > plain 64-by-32 division. Following build erros were reported.
> > Patch should describe the change! Please revise subject to describe that
> > and not fix build error... This can come in changelog and below para is
> > apt
> Sure, Will update the subject and resend the updated patch

Please collect the acks as well

-- 
~Vinod

