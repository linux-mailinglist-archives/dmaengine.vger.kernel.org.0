Return-Path: <dmaengine+bounces-2255-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D11E58FB7AD
	for <lists+dmaengine@lfdr.de>; Tue,  4 Jun 2024 17:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D9AE1F2101E
	for <lists+dmaengine@lfdr.de>; Tue,  4 Jun 2024 15:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FFC146D49;
	Tue,  4 Jun 2024 15:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n52OzUXU"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7BB145FED;
	Tue,  4 Jun 2024 15:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717515743; cv=none; b=I1cfbKKlMNwsIA4gzGZ4L5EZquStRpx6AW+lZ10FTQd8vs44pCan633QEKUMOpuD59PgDH+GV2ykR4YrFNJDG5zKxRKCxfuFD2F/cZyVQQaikvJ8lKsOJMXw7lRBCsEb52w2/Hl6fECrzEyHB1LxsP1Gy2cUhinnvVyL1J0Wqyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717515743; c=relaxed/simple;
	bh=jK9R8jn8mv9pJSbolglfsiF5E79LCoItqzaqtWEc/Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfAJSn74HUn3ek3FAlKxSXQIBvlKzOsghnWR6ral5F6Nfte8d2erW1G+qK01POH4hnAqijR4xbcc7EhoIlMY6LFfDeQWN1yoX/nvQoPA1xxGGCr0MLIK+0mW37cSDgAYOSbMyR2ex7qpQWSc5n9Boi2rukUmTNj4B+UMsPsFrwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n52OzUXU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACDC6C2BBFC;
	Tue,  4 Jun 2024 15:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717515742;
	bh=jK9R8jn8mv9pJSbolglfsiF5E79LCoItqzaqtWEc/Nw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n52OzUXUfowEeObzfqYB6G/UcZW5ZY9UbaYByNb2ffa6Cvbv3m/34QOXPFrUEiGw8
	 ZZbR4xS6ilFIcSS84ol1sczwlqBhWX6ezb7FaCs9a8pXh84bnfuv7I70NiGNI0WuKh
	 YJfBt9iTcYEHuf2fjrONoZzAtuympF//UgsbulUY=
Date: Tue, 4 Jun 2024 17:35:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>, Vinod Koul <vkoul@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	dmaengine@vger.kernel.org, imx@lists.linux.dev,
	patchwork-lst@pengutronix.de
Subject: Re: [PATCH 1/2] firmware: add nowarn variant of
 request_firmware_nowait()
Message-ID: <2024060411-cassette-gallstone-6990@gregkh>
References: <20240516102532.213874-1-l.stach@pengutronix.de>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516102532.213874-1-l.stach@pengutronix.de>

On Thu, May 16, 2024 at 12:25:31PM +0200, Lucas Stach wrote:
> Device drivers with optional firmware may still want to use the
> asynchronous firmware loading interface. To avoid printing a
> warning into the kernel log when the optional firmware is
> absent, add a nowarn variant of this interface.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

