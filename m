Return-Path: <dmaengine+bounces-3180-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D454E97B766
	for <lists+dmaengine@lfdr.de>; Wed, 18 Sep 2024 07:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F57DB27B97
	for <lists+dmaengine@lfdr.de>; Wed, 18 Sep 2024 05:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1783B13A3EC;
	Wed, 18 Sep 2024 05:22:34 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8325613792B;
	Wed, 18 Sep 2024 05:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726636954; cv=none; b=gkuaAxf3Iqg5V3rykmFcrlL/sQosqxLPDPqprAuFRsKJY1TpgrnOVFkCHN8gw/895Mdih5oaYBLx5SkLbzuFSdOycgpxOQ0KN715mtYLbJSyc+jrz1QaLyMt3Tw79j9Z+WkHPbSebCWTTGB/fb1EANRrs/uij1O2sArB3C/+VAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726636954; c=relaxed/simple;
	bh=O9D+abRsVOL06/TXyEWQHDA+B9N9Oi4o2O6IDGpO8gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QoIh2cvipAk3BRVhe3taWHxJ7m9BnLlLxNorbvyxnJPY9RxAUtMjkAW6Mxk9P1x5znkOoMNOETYmAn7rpluwjeuRyEOSRn17nDBqhxD7uyWj+jmXcklMj13+Q+1237jSiHXP7Ndb7Bq3F2HXnFdW00cNfSh/eo73X7gYbcPhBDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AB657227A88; Wed, 18 Sep 2024 07:22:28 +0200 (CEST)
Date: Wed, 18 Sep 2024 07:22:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Lizhi Hou <lizhi.hou@amd.com>
Cc: vkol@kernel.org, hch@lst.de, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, nishads@amd.com
Subject: Re: [PATCH 1/1] dmaengine: amd: qdma: Remove using the private get
 and set dma_ops APIs
Message-ID: <20240918052228.GA31381@lst.de>
References: <20240917161740.2111871-1-lizhi.hou@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917161740.2111871-1-lizhi.hou@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Sep 17, 2024 at 09:17:40AM -0700, Lizhi Hou wrote:
> The get_dma_ops and set_dma_ops APIs were never for driver to use. Remove
> these calls from QDMA driver. Instead, pass the DMA device pointer from the
> qdma_platdata structure.
> 
> Fixes: 73d5fc92a11c ("dmaengine: amd: qdma: Add AMD QDMA driver")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>

From the DMA point of view this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


