Return-Path: <dmaengine+bounces-2154-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E33238CE884
	for <lists+dmaengine@lfdr.de>; Fri, 24 May 2024 18:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D351B210BC
	for <lists+dmaengine@lfdr.de>; Fri, 24 May 2024 16:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A09A12E1E5;
	Fri, 24 May 2024 16:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZZ65Bep8"
X-Original-To: dmaengine@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD9E12E1CD;
	Fri, 24 May 2024 16:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716567255; cv=none; b=Hc2G1eGlXFjGFAYF2Rc/EWnLvEo4WuC9fMHuEpUewUZvf2+9HYA0t4J64NB71JMnnJecNEQpVqlI1qp9QfeH5JKzCWW7DtQPDxO+bCoAehSGg9NZMOXIm2iFWYglX21HOMhCho1aSV2dkB9pkN+xSRPL/QIoJViYTR79rodLVBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716567255; c=relaxed/simple;
	bh=BdoTvVOPkbsKys5oa+9xW3Y4PkStppmaGSySwGyNJM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ruAUP2lcDhEnD/UiiLYNy264xWghO9I2QSHf/EUtxeSSJK+48mVwJNjP1wSfwbicJGIVWo9tluVUPHb/kWtGNgq+gGYzx3pIsl3GuhooKfZy66fVAO07L4jn2kOzm7LrHDi2k+eQr55LFnyHVjuUL3dC3gBgbwBFKIVLIEJ3qvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZZ65Bep8; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay3-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::223])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id C8A4EC4F66;
	Fri, 24 May 2024 16:13:26 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1F40F60004;
	Fri, 24 May 2024 16:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716567198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Huh/X722SjDzCcdLJbM0TZp8RM43bnA8UHc9vCXTgrM=;
	b=ZZ65Bep8ZewGVgSU2IYuGeNI6iiP7/oPRLfjS9R7MpDNReqJPUgEvK/AiqJWgNegf/jZaf
	cfgDw9w/ZRvW5ukDCxGVsPhW5VVTzBMYiAzesSmnfVHjc4bk1RDSJUpKTYDNv64UMBpXdC
	bDIh61f4XcA/I6Y5LMRSdIe0sF7yloozN894wqQhgy/qKz3hc7N9w09joZWyG+3t7CYT3L
	RHII0ZI262dwnefTs+6QZmLHuAimleAhSqtotwHTHMn6bxkjJoyzT1enFrfD8WhEThzo8B
	EP1S89F5uqjrUASgIx6WBndJrxcA1C/oUCF5p24cXP+lk8WaQd+Lwg4Dy+TNaQ==
Date: Fri, 24 May 2024 18:13:16 +0200
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Mark Brown <broonie@kernel.org>, linux-sound@vger.kernel.org,
	dmaengine@vger.kernel.org, alsa-devel@alsa-project.org,
	miquel.raynal@bootlin.com, perex@perex.cz, tiwai@suse.com,
	lars@metafoo.de, lgirdwood@gmail.com
Subject: Re: DMA Transfer Synchronization Issue in Out-of-Tree Sound Card
 Driver
Message-ID: <ZlC8nG0Vzxg9HFT2@localhost.localdomain>
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>,
	Mark Brown <broonie@kernel.org>, linux-sound@vger.kernel.org,
	dmaengine@vger.kernel.org, alsa-devel@alsa-project.org,
	miquel.raynal@bootlin.com, perex@perex.cz, tiwai@suse.com,
	lars@metafoo.de, lgirdwood@gmail.com
References: <Zkxb0FTzW6wlnYYO@localhost.localdomain>
 <6e01c13f-2bc1-4e08-b50e-9f1307bda92d@sirena.org.uk>
 <87msoiz94h.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87msoiz94h.wl-tiwai@suse.de>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 22/05/24 - 07:52, Takashi Iwai a écrit :
> On Tue, 21 May 2024 20:32:59 +0200,
> Mark Brown wrote:
> > 
> > On Tue, May 21, 2024 at 10:31:12AM +0200, Louis Chauvet wrote:
> > 
> > > To address this DMA issue, I have created a patch [1] that guarantees the 
> > > completion of the DMA transfer upon the return of xdma_synchronize. This 
> > > means xdma_synchronize now sleeps, but looking at other drivers around it 
> > > appears expected to be able to do so.
> > 
> > You need to set the nonatomic flag for the PCM to allow this, the
> > default is that triggers run in atomic context.
> 
> Right, that's a most straightforward solution.  It implies that the
> period updates must be in non-atomic, i.e. use a threaded irq handler
> in most cases.
> 
> If the synchronization is needed for assuring the hardware stop, there
> is an alternative with PCM sync_stop callback, too.  The callback is
> called at each time after a stream gets stopped before the next action
> (that is, either prepare, hw_params or close).  It's only for
> stopping, and there is no similar way for sync of a stream start,
> though.
> 
> 
> thanks,
> 
> Takashi
> 

Hi!

Thank you for your prompt responses!

I have currently implemented the solution with sync_stop, as it is 
precisely what I need to do, and it works perfectly.

As I may need to backport this driver up to 4.19, sync_stop was not yet 
available, so I will look into the threaded IRQ solution, which sounds 
promising.

Thank you both very much!

Best regards,
Louis Chauvet

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

