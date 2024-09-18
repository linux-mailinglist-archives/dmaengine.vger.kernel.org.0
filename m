Return-Path: <dmaengine+bounces-3181-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D5197BC07
	for <lists+dmaengine@lfdr.de>; Wed, 18 Sep 2024 14:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 150161F23635
	for <lists+dmaengine@lfdr.de>; Wed, 18 Sep 2024 12:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03910189BA0;
	Wed, 18 Sep 2024 12:13:09 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEBA3C3C;
	Wed, 18 Sep 2024 12:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726661588; cv=none; b=RYQjuJUZ+CRM1Jw69MPWKhRYIdtYzNwa2oEii279RzK/Q6FBYPCGeec0BYEef+yG2Rc8GI4+8wKPxVXDl/3blIwTpFPapaQa8IkfvxDWkrE3lNdXHN0ZGaTDOT38HdNTNGa3Nk3WeEzFwwJeiZk2KplOUZg0d8gosvayd/tMULY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726661588; c=relaxed/simple;
	bh=6mNkX2BO5HmD+Wh550qHDCnw8Vy7LUpxsUlxOJUTjWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYSL8gStjvyzXE35ufzPkP9UjOqVBPRqSRJO3bDN1ynuGg3OVACWvYFqEKQDJmp3AB8uI8YoQsJCoqJ+kS+OewAPOuORRNTn49aaHjXkBhvnlVBBt+dcPVrv1/qngpjmjhKWWq4PH/zeryAdX3qzF3ZBRmr6+Zke+CoLm6xFQ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E88F2227AAD; Wed, 18 Sep 2024 14:13:02 +0200 (CEST)
Date: Wed, 18 Sep 2024 14:13:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Lizhi Hou <lizhi.hou@amd.com>
Cc: vkol@kernel.org, hch@lst.de, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, nishads@amd.com
Subject: Re: [PATCH 1/1] dmaengine: amd: qdma: Remove using the private get
 and set dma_ops APIs
Message-ID: <20240918121302.GB21062@lst.de>
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

Btw, this file should also drop the include of <linux/dma-map-ops.h>,
which is clearly marked as not for driver use.


