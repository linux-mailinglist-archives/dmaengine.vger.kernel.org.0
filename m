Return-Path: <dmaengine+bounces-3177-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BB697AAC4
	for <lists+dmaengine@lfdr.de>; Tue, 17 Sep 2024 06:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 464661F220C2
	for <lists+dmaengine@lfdr.de>; Tue, 17 Sep 2024 04:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110FF2B9B3;
	Tue, 17 Sep 2024 04:39:14 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923682905;
	Tue, 17 Sep 2024 04:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726547954; cv=none; b=MVJNTj2kXbSReVfEGY+2VyD0T+9ERg8a7KrzXxSfoMQxjSmaJM9jvBtoxz8nR4nUyaj4y6+gQkUwStg+DFADegYgJ4ICpjSOx8soUBuiMgkBpSSuYtHj3IprGhxlrJzqgCJ8Wbx7IhuS3AT2lFKVUtXy/nBOzCW4jRtRZAZCkyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726547954; c=relaxed/simple;
	bh=3RN+9abMqEssIEhbwC2cLSfOQF9VAIFFAfRMhKlBG+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLWNWzIoQrHUtWl9DJd6qfLQ+lnDc4lTUwyE9fb+rYHcXCg0p2fOnw6wXe8J59dPBMldVqhn76T/n+sXUAFD+sRHh57+nYQ2PnfR+OTIoCcfR8Ty66hepA8vUdil4IDmnl7p1BytTZ/TVlje9yLzCPn5fsKsTEjojapDBnp5Nzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id ECD07227ACB; Tue, 17 Sep 2024 06:39:06 +0200 (CEST)
Date: Tue, 17 Sep 2024 06:39:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Lizhi Hou <lizhi.hou@amd.com>
Cc: Christoph Hellwig <hch@lst.de>, Vinod Koul <vkoul@kernel.org>,
	Nishad Saraf <nishads@amd.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Please revert the addition of the AMD QDMA driver
Message-ID: <20240917043906.GA910@lst.de>
References: <20240916074051.GA18902@lst.de> <4fe5374e-8eb2-9ff6-e2ea-e55342c59de6@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fe5374e-8eb2-9ff6-e2ea-e55342c59de6@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Sep 16, 2024 at 04:48:59PM -0700, Lizhi Hou wrote:
> Hi Christoph and Vinod,
>
>
> Sorry, I did not know the limitation of get/set_dma_ops.
>
> Instead of reverting the entire driver, is it ok to put a fix on top to 
> address this issue?

Sure, if there is an easy enough and quick fix.


