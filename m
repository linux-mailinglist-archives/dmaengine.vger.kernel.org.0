Return-Path: <dmaengine+bounces-3881-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 557C99E3A59
	for <lists+dmaengine@lfdr.de>; Wed,  4 Dec 2024 13:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9587B33708
	for <lists+dmaengine@lfdr.de>; Wed,  4 Dec 2024 12:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9E11B983E;
	Wed,  4 Dec 2024 12:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6THXQOc"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB2F2500CE;
	Wed,  4 Dec 2024 12:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316443; cv=none; b=tYGSsCZt4dv9JIXzeFBVDLqeaSp1e1+IH6POQrIxEkHmZAyI9b0+omethPz1Wu93DOxCPQW6WCHss76DjdpKIycsy0IwRyxA8FDl8dy6pqTFIRMrTsLcmawjLv2fKjXHfE/0YfqG6OomWe8ST9b8/egxPS9rqFUSE2K5DPZ09CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316443; c=relaxed/simple;
	bh=d4jhyyKwOpDC7EBPZIjD1O4xNyxg8HfvCdqe4g79zlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPwabGivIQGWwZwRkbi4wBLn6EHPhLXeZQ/YTb9E9ScvTq4CBJgR8vRnw1UC2oqG29VQRU/B8QiOVIqE1SxaYF4xGAe567ZmQkMlRA4d0pisPzmNUgIWN8MVQ4ggeEjKuuaRH8ZMtRXjtNcP6bR2EZkL9gZ3iSSSU8oCO+Y53d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6THXQOc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CF7C4CED1;
	Wed,  4 Dec 2024 12:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733316442;
	bh=d4jhyyKwOpDC7EBPZIjD1O4xNyxg8HfvCdqe4g79zlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F6THXQOc42q+Fv4axUQcVqJvS38+Flfr7RGKcYYTh94VsAjgIyEl6OT4b0BLA9QPR
	 KNY1hJj38fo4NirTp6hu8YVAjqrG3Vr0rbTaK+XrIg+yhd9XNP0PyGaUpoHui0vg4B
	 mk/ZzwpTHpk/2cFuAeAUwAoMo330KL5xRQq6OvTOzgjsWEIy5i82rHcL4o7QfGe1E/
	 an3j6ndeSvNn2xdn0BUGBPAI9KmBAdcbvQsjFPgCFVxMhtdoiY4pMiZvybI9VslJz9
	 /OX7FI5Ym2rHAJ1mBAeXAIJId4uHxOOv0kbUIo7qJbtvxaVQ2AR9FYJhmM2dKsT7Hk
	 nUSjw5pyxzpMw==
Date: Wed, 4 Dec 2024 18:17:19 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: Frank Li <frank.li@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"open list:FREESCALE eDMA DRIVER" <imx@lists.linux.dev>,
	"open list:FREESCALE eDMA DRIVER" <dmaengine@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 2/2] dmaengine: fsl-edma: free irq correctly in remove
 path
Message-ID: <Z1BPV4fV8gOikmDF@vaman>
References: <20241115105629.748390-1-peng.fan@oss.nxp.com>
 <20241115105629.748390-2-peng.fan@oss.nxp.com>
 <Zzdk5qcUyhNhRZSR@lizhi-Precision-Tower-5810>
 <DB9PR04MB8461407FB15C100903EFEFB988262@DB9PR04MB8461.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9PR04MB8461407FB15C100903EFEFB988262@DB9PR04MB8461.eurprd04.prod.outlook.com>

On 17-11-24, 11:07, Peng Fan wrote:
> > Subject: Re: [PATCH V3 2/2] dmaengine: fsl-edma: free irq correctly in
> > remove path
> > 
> > On Fri, Nov 15, 2024 at 06:56:29PM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > To i.MX9, there is no valid fsl_edma->txirq/errirq, so add a check in
> > > fsl_edma_irq_exit to avoid issues. Otherwise there will be kernel
> > dump:
> > 
> > Nik:
> > 
> > Add fsl_edma->txirq/errirq check to avoid below warning because no
> > errirq at i.MX9 platform.
> > 
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> 
> Thanks, since this is minor commit update. Not sure Vinok could help
> to update, or need me to update and send v4.

Not sure about Vinok :-) but I would prefer an updated patch

-- 
~Vinod

