Return-Path: <dmaengine+bounces-837-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A861383EECC
	for <lists+dmaengine@lfdr.de>; Sat, 27 Jan 2024 17:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DC7F1C20E00
	for <lists+dmaengine@lfdr.de>; Sat, 27 Jan 2024 16:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304712C6AA;
	Sat, 27 Jan 2024 16:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHE4GT14"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2819286AE;
	Sat, 27 Jan 2024 16:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706374261; cv=none; b=aQC5L4BTrwcHxBAg7TiGp2u/wC1JIiV1CSC/+G5tbhW7BBDdMIHFG+rO1CHvAkfPnoOWzzerCF76B9k0rfGKv5tgNYAEG1cq1hxqjUMoTtECh/S5+m2gty3i3AxgDaygJ/hQuzErqV3E4CW8NhHp368z4plh6Sc0iPHPIWN5YZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706374261; c=relaxed/simple;
	bh=QP+swmkCdNQGO0Nmh/aIJ91HocN7GAu5e8lfaOWVe1c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lZ22m3UiLlvUh+rfVEJmU2axVZpkyj+zOcHUMPFQZb0NDLK6F1Cxfp5GG1RLv1ssxQaG2IJzN1PuI1C220B1YrWfRH7C5jfCRAUjCBu1q/le7XYbQTxYJ7dKbyLNfZxGtqjx3bnRJ0eKeKf87T5moWK9I0hidJpW0N1h5CcYB6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHE4GT14; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7BFC433F1;
	Sat, 27 Jan 2024 16:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706374260;
	bh=QP+swmkCdNQGO0Nmh/aIJ91HocN7GAu5e8lfaOWVe1c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kHE4GT14qyZ9I0dPf3JZXSf2KWCeckxoGqODmilUYb+pouIkOG0PYuxUTRvH5IKL/
	 8027UCs0RkMLDqypr8Xez1mHrPzUpaYqXdIBwlJIVmSLOEYJwOHHl2kNuK6G1K4Cse
	 gqN+/rdjyKsk/3+BPoMGzF/E9cmtxQkF1zcMmaz10JrLPFLtHbbc1ksahSgc+PY4Va
	 fVlv5Kbkq5xj9XOnO1ErYaT0nLxkh/na/nVHByuhTxQp/bWM8P/cf7Usxpyzhuxrar
	 11GV3LsFzScBDF4TtjuAK1EHyNaYfrGvDpvsLd692/hySSUirAFWN3Nn7aD1CMlPH8
	 Rgo7n1lSqppsw==
Date: Sat, 27 Jan 2024 16:50:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Sumit Semwal
 <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Vinod Koul <vkoul@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Nuno =?UTF-8?B?U8Oh?=
 <noname.nuno@gmail.com>, Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v5 5/8] iio: core: Add new DMABUF interface
 infrastructure
Message-ID: <20240127165044.22f1b329@jic23-huawei>
In-Reply-To: <ee5d7bb2fb3e74e8fc621d745b23d1858e1f0c3c.camel@crapouillou.net>
References: <20231219175009.65482-1-paul@crapouillou.net>
	<20231219175009.65482-6-paul@crapouillou.net>
	<20231221120624.7bcdc302@jic23-huawei>
	<ee5d7bb2fb3e74e8fc621d745b23d1858e1f0c3c.camel@crapouillou.net>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> > > +	iio_buffer_dmabuf_put(attach);
> > > +
> > > +out_dmabuf_put:
> > > +	dma_buf_put(dmabuf);  
> > As below. Feels like a __free(dma_buf_put) bit of magic would be a
> > nice to have.  
> 
> I'm working on the patches right now, just one quick question.
> 
> Having a __free(dma_buf_put) requires that dma_buf_put is first
> "registered" as a freeing function using DEFINE_FREE() in <linux/dma-
> buf.h>, which has not been done yet.  
> 
> That would mean carrying a dma-buf specific patch in your tree, are you
> OK with that?
Needs an ACK from appropriate maintainer, but otherwise I'm fine doing
so.  Alternative is to circle back to this later after this code is upstream.

> 
> Cheers,
> -Paul

> 


