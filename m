Return-Path: <dmaengine+bounces-2200-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D0B8D28B3
	for <lists+dmaengine@lfdr.de>; Wed, 29 May 2024 01:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C7351F27628
	for <lists+dmaengine@lfdr.de>; Tue, 28 May 2024 23:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F58313EFEC;
	Tue, 28 May 2024 23:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fcJg28Qh"
X-Original-To: dmaengine@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C18F13EFE5;
	Tue, 28 May 2024 23:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716938713; cv=none; b=sFiPRHQqWR5CvZ5CwMa1spUf5JsNAP1Umicfj7W8ljl78mOcHKKvptwiAjYqIERS6bUssh9CltQW0zVAopQZrI6h4RzybZL9lpehoYca2clumIJfKEM+ZGUINgevPbZ1Rdu4/yPjakgn74DPieyrg+qzWs6hzXyyQfdQwpGtCGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716938713; c=relaxed/simple;
	bh=RKM8YxwIozVksT7s1GYF8b7LsRPAn1SHg7ofWklLQTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFQVrP68wxN8KAgnCnaK9I4EAPrzAXrbEMdKtX6k5/0k+LgtLX4OIT9hv3TA1UUHQSMs8jeC4zDfFTfCHIFbrHPzNyyjGbtn4E7KpVPcmOpkQ3cdSw/s/a15ThH+CxWZ9c8SODhrdAi6fS4/XWA8I8NAhzFigvUe5Otk8flv6Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fcJg28Qh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xKQszk2stwu9ufhOKWwKaa2+c/hpMjQ6jZbBPsIUpHQ=; b=fcJg28QhmPv5kImsjo5YqgHgZr
	Jin4C6+t9vU6KOMcD02No7MWi8aBwsofPvVC+BRFkJWL60DVdcpaUnp2gNcZ/uEJa8e7PiF+fZ9NR
	qyW9XfTXkAnwTqPEdKq8L4s3DVrp1BBK39Fkj6Zz03F9qK++uqF2PECpOEhfwThY5ZpbN5WEnp1/a
	wut8vSOfRjnmGzjdAED0F/GP7VpCpuC02EKlOgbbRSoQrTD+OzVb2H4ENv6mZ3I+IONSMggbw6HKV
	secXGvVRBtyH41iuSUGJD0viiE2qSA7DegrSq84mICoZ41+YF62zejKWbg+vBtWsuA+Sao8zActl8
	JmmauCpw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sC6Bq-00000002Jrp-29hd;
	Tue, 28 May 2024 23:25:10 +0000
Date: Tue, 28 May 2024 16:25:10 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Russ Weight <russ.weight@linux.dev>, Vinod Koul <vkoul@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	dmaengine@vger.kernel.org, imx@lists.linux.dev,
	patchwork-lst@pengutronix.de
Subject: Re: [PATCH 1/2] firmware: add nowarn variant of
 request_firmware_nowait()
Message-ID: <ZlZn1hMUscURcnUL@bombadil.infradead.org>
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
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Thu, May 16, 2024 at 12:25:31PM +0200, Lucas Stach wrote:
> Device drivers with optional firmware may still want to use the
> asynchronous firmware loading interface. To avoid printing a
> warning into the kernel log when the optional firmware is
> absent, add a nowarn variant of this interface.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

