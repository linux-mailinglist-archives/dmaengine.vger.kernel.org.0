Return-Path: <dmaengine+bounces-771-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7193183352B
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jan 2024 16:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A72F1C20CEF
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jan 2024 15:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9DA1172C;
	Sat, 20 Jan 2024 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hrn21nIs"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9BB11718;
	Sat, 20 Jan 2024 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705763629; cv=none; b=eTf6i23ZhOJa0GNKGCfmHD84CcxeKUMchum4ElFQdJbtW1NSLoZuTL1eSaNv4agoD0MjhAVtl9vs0Z5de9QJKWxnmggY2reytD/eDEkiaBc6EDOFXcUHAiwlpbQKPSvn0G0Pto4S+mfd/k7i2t3NnjbJZjtmh6mWYuwPZpF45OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705763629; c=relaxed/simple;
	bh=tDtcsSas+PDLrIk9mgYk+I2y/KYhkVWuUsx57hmeacY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilrzJTvr3KeyX9XT5xsE57vx1MKkoG9Rv1Tn1DJwh5vcaP3qWPOE1Z166OlkTUB9keGdMQTMqQ9zqThzr52hYDt1PbpV0jT6S7xbgoGIX7c5g2gE5+duathJDpHCBLkWAdZMea5H7au36R5OIa0eu19/WpD3j90g5a0yFmeVPXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hrn21nIs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFC7C433F1;
	Sat, 20 Jan 2024 15:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705763628;
	bh=tDtcsSas+PDLrIk9mgYk+I2y/KYhkVWuUsx57hmeacY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hrn21nIsE72twsp8uXXpSZ0YVSrrG5bYsylL4VYMe842Y6QZfRo2WZmZ0Zg2FXWGI
	 8wpovYXZdo3eohb2eLp91m0UBFK5H6M8kcVCIe6osgbIU2zVjGb8dPq+Tv5xowwGtl
	 BdYqqwhNi4UD4J1SDwr3EDxDzdVfj/xTgl2BVLgj68eu+Niw1nOXTXOL+BWFovSzNg
	 +63ZI57krazlFOkCFnVy2widkrjJyg4hJ7KbM0Iyh/1gdwbuBdpVmie6ZKOHnF8YzA
	 3JqIHgYodoZb7GFElfEC8P34ytv5SbSllg8QCPSBc8252duNmZYcDxIfs1WlU2GzkT
	 EN/LQ9/oT3NCA==
Date: Sat, 20 Jan 2024 20:43:40 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: =?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, Cai Huoqing <cai.huoqing@linux.dev>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH v6 0/6] Fix support of dw-edma HDMA NATIVE IP in remote
 setup
Message-ID: <20240120151340.GA6371@thinkpad>
References: <20231117-b4-feature_hdma_mainline-v6-0-ebf7aa0e40d7@bootlin.com>
 <20231121062629.GA3315@thinkpad>
 <js3qo4i67tdhbbcopvfaav4c7fzhz4tc2nai45rzfmbpq7l3xa@7ac2colelvnz>
 <20231121120828.GC3315@thinkpad>
 <bqtgnsxqmvndog4jtmyy6lnj2cp4kh7c2lcwmjjqbet53vrhhn@i6fc6vxsvbam>
 <20231122171242.GA266396@thinkpad>
 <20240112111637.01a5ea21@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240112111637.01a5ea21@kmaincent-XPS-13-7390>

On Fri, Jan 12, 2024 at 11:16:37AM +0100, Köry Maincent wrote:
> On Wed, 22 Nov 2023 22:42:42 +0530
> Manivannan Sadhasivam <mani@kernel.org> wrote:
> 
> > > For all of that you'll need to fix the
> > > dw_pcie_edma_find_chip()/dw_pcie_edma_detect() method somehow.
> > > 
> > > Alternatively, to keep things simple you can convert the
> > > dw_pcie_edma_find_chip()/dw_pcie_edma_detect() methods to just relying
> > > on the HDMA settings being fully specified by the low-level drivers.
> > >   
> > 
> > This looks like the best possible solution at the moment. Thanks for the
> > insight!
> > 
> > I will post the patches together with the HDMA enablement ones.
> 
> Hello Manivannan,
> 
> What is the status of this series?
> Do you want to wait for designware-ep.c to be HDMA compatible before merging
> the fixes? Do you expect us to do something? We can't work on the
> designware-ep.c driver as we do not have such hardware.
> Shouldn't fixes be merged as soon as possible?
> 

I've reviewed all the patches, but I do not merge them. It is upto the dmaengine
maintainer (Vinod) to merge the patches. Anyway, we are in v6.8 merge window, so
you can rebase on top of v6.8-rc1 once released and post the patches.

- Mani

> Regards,
> -- 
> Köry Maincent, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com

-- 
மணிவண்ணன் சதாசிவம்

