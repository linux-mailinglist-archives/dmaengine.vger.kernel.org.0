Return-Path: <dmaengine+bounces-2935-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A0095C774
	for <lists+dmaengine@lfdr.de>; Fri, 23 Aug 2024 10:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8423E1F25CA6
	for <lists+dmaengine@lfdr.de>; Fri, 23 Aug 2024 08:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764F514036E;
	Fri, 23 Aug 2024 08:07:45 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6D8143C69;
	Fri, 23 Aug 2024 08:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724400465; cv=none; b=Hmk8YMOUCc5N+BoOffrlF2FFI2K+uPkGIiA82IQM9jJNyuY3eFm4hSHicwdKtEReb0k/I8jhTV+18GvYmovk4lYPDlBC7SU+lR+U0jdP8swbjrXY6SwdUphwVEEWlwuP/Je831woJfb0ybbYQ2TxKGXkKMDzur+b6POhdPvqhGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724400465; c=relaxed/simple;
	bh=xAwEj7T9cFwyzRy+L1L41oaRAznEc3IrveUhJdtE9y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLWGpazzH12rQPDaA0TgHQPX3HC7BL8/5kFv4Dmt+cP9K7LjO6j16/YMfiuwo91CFpJQCy5yC0XLtSDasPe63MX2KLXu/hNryxVGXEfp0nmdGcx2iro4zHt4BtygYdQTfO9wSv5Z39zCswkfPSMb6+ohu+dao4m05Gjrn29pHGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9C3F9227A87; Fri, 23 Aug 2024 10:07:36 +0200 (CEST)
Date: Fri, 23 Aug 2024 10:07:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian Lamparter <chunkeey@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>,
	LEROY Christophe <christophe.leroy2@cs-soprasteria.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Stan Johnson <userm57@yahoo.com>,
	Finn Thain <fthain@linux-m68k.org>, Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org
Subject: Re: [PATCH v2] powerpc: warn on emulation of dcbz instruction in
 kernel mode
Message-ID: <20240823080736.GA3068@lst.de>
References: <2e3acfe63d289c6fba366e16973c9ab8369e8b75.1631803922.git.christophe.leroy@csgroup.eu> <17fa6450-6613-4c34-804b-e47246e7b39c@isd.uni-stuttgart.de> <9dbf73fe-a459-4956-8dbc-e919d9728f5e@cs-soprasteria.com> <20240822053238.GA2028@lst.de> <e6acf664-5ebd-4273-9330-cbec283ede23@cs-soprasteria.com> <20240822071443.GA6395@lst.de> <b039012c-1b04-40cb-a760-b1ef942fe23c@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b039012c-1b04-40cb-a760-b1ef942fe23c@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

dma_alloc_from_pool is the allocator used when the caller can't
sleep, and as that is reusing memory it really has to call memset
or a memset-like function on the already uncached memory
unfortunately.  The dma engine operation that is doing this allocation
is documented as not being able to sleep, which is a bit unfortunate
as the storage driver above it could sleep just fine.

Adding the dmaengine maintainer and list if there is a way to pass a gfp
flag or some other indicator that the implementations can sleep,
which would avoid the need to use the not very scalable dma pool,
and thus also the need to memset on uncached memory.


