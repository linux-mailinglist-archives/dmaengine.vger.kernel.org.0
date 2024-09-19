Return-Path: <dmaengine+bounces-3187-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C0297C3E4
	for <lists+dmaengine@lfdr.de>; Thu, 19 Sep 2024 07:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC46DB20FFB
	for <lists+dmaengine@lfdr.de>; Thu, 19 Sep 2024 05:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6171A14A96;
	Thu, 19 Sep 2024 05:34:20 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF61566A;
	Thu, 19 Sep 2024 05:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726724060; cv=none; b=uzrjawn+qKmry56exGRitidLa49A1BlUmmOZTcJ0WYCXUVpUxM4fZX5QGUYEiDZrqveXobnakrTGDHHTtz/QyiDj1OQzV8ge2gZTxiXL8VeD5GImuPDZTJi+AjId2jXihzbmbSgeXzZBMPux4x7on4gZ7gdPU2HlqQsZjO7MEzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726724060; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BgZ5dllBe8cJeObHR0Dhli905H8IrRf00dxzytY9K2gxLHAt6jjvH0hoyA9H+FiCQ6HE5xfOnPBDulYG9JRiE6Ohr4Pqn3f/2/naPO1p4JUlsXXRgXfdL2ZW7RDAONaj44XweEx9w/Fn7hiuTJB/ppP86W+2xHajiMa0GS6DRxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9D21E227AA8; Thu, 19 Sep 2024 07:34:06 +0200 (CEST)
Date: Thu, 19 Sep 2024 07:34:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Lizhi Hou <lizhi.hou@amd.com>
Cc: vkol@kernel.org, hch@lst.de, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, nishads@amd.com
Subject: Re: [PATCH V1 1/1] dmaengine: amd: qdma: Remove using the private
 get and set dma_ops APIs
Message-ID: <20240919053406.GA18080@lst.de>
References: <20240918181022.2155715-1-lizhi.hou@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918181022.2155715-1-lizhi.hou@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


