Return-Path: <dmaengine+bounces-2153-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F048CE57C
	for <lists+dmaengine@lfdr.de>; Fri, 24 May 2024 14:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A36CE1C20FA6
	for <lists+dmaengine@lfdr.de>; Fri, 24 May 2024 12:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB83A8614D;
	Fri, 24 May 2024 12:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="FLV3Q36v";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="wbJr74Oh"
X-Original-To: dmaengine@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF2885640;
	Fri, 24 May 2024 12:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.207.88.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716554874; cv=none; b=eVJtwgVe1BAfBZR0sAgVEb+OhwD2yLPt8xbDacnPJUk6B5Wxuq9fYWG+t8h/1PNbHErqFc31wNKuhVQzjbGcmjJqlUSXRpi0YB/6fM+dsy2VWsbZgNgcJIEbLxDjVt5knm0ePwJfkCAn40EG6SOkKMR8yyiu+eSnfzBAA7JwD5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716554874; c=relaxed/simple;
	bh=h18j4zkIKC8Gg9g6TPvXqT4oSF72Fked5LqoJ2Yo3q0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pXA5M9fFfip+l3CqHnNIXcadTRTSHRTbCAqlclJMEyEbr6aHdNWkql36mncotLNinfBedqQx2CA9SUBwQVv/WC86AEbpWnfpQoYVbzFuO7PqQsUfJQDX4ov20nB95R9qP+BwdkapOsEe3ok6FmWOaYvJM321mgc+fv0CixMwXOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com; spf=pass smtp.mailfrom=yadro.com; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=FLV3Q36v; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=wbJr74Oh; arc=none smtp.client-ip=89.207.88.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com B1B02C0003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1716554861; bh=6XZhfA6k2ccaT2wZhfi+aUaDsmTZthBxNMxn3o6ZTpI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
	b=FLV3Q36vidSlXCdrMhbSpuxOWvzvoFS5iFWDS+oVXMUX8f4c8C3t8IQ5SbLdI+WaF
	 pMn/HDhBIK8Mo0G6LpZbgjpbQ26ivDzZerIUcUk6OULzFz8vkwNn4F92CYwiCXeGld
	 zJudRh2/WhU7zeGhbAwgitvx7Q8zuTIZFAm9FMPExYTg9NWyIbVSbA/M8CQyvSFtt5
	 g3BjZLe8ZPMCMp+07wCAS2ZqmefxfFgABu9KtmtuaTZ4ah3ZTlM5eI+80POoUHekva
	 MNsNIqnhbW9zHpcyRgvgMp9hbhBlUseotnyNk8G0eFdEF621EFO3jmovF2Ww4VGNnL
	 PJDerpL6Ga/DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1716554861; bh=6XZhfA6k2ccaT2wZhfi+aUaDsmTZthBxNMxn3o6ZTpI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
	b=wbJr74Oh8pn+xkhwuC62IHSeOC0eg6G5lYEFhTA3wWS6F86xg9JyiFMA87TpsKEQn
	 ICoIQpwgQypan2RT3ZgF/ABQZt2q3qfqnxVn1Yeua9jWSo417az6kw6k8953DurWVy
	 K/pSO+eaJ25/2E4v7mDfAeClYEkn7j8/LS27Ny2wh90WpNoBJfm1gv5LMAjcuv+2LN
	 Ad6hoRBI2JwIKdGiGpbVyLkE7Y4F87iTJpmnnS9zNmKTQpzOcCEaJyty5Nbm9grCVm
	 d7NS5KrTKcmcAcYWu9MYvuP3iEqakPsm1kWrWcHgeyOdIlDY85DGIti5DwbRWcdig9
	 LdgefoIS4IezA==
From: Nikita Shubin <n.shubin@yadro.com>
To: Markus Elfring <Markus.Elfring@web.de>
CC: LKML <linux-kernel@vger.kernel.org>, Andy Shevchenko
	<andy.shevchenko@gmail.com>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, "Logan
 Gunthorpe" <logang@deltatee.com>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 2/3] dmaengine: ioatdma: Fix error path in
 ioat3_dma_probe()
Thread-Topic: [PATCH 2/3] dmaengine: ioatdma: Fix error path in
 ioat3_dma_probe()
Thread-Index: AQHarcSgbAqef+G6mEmMgJhAnE2IlLGmGlCAgAA6ygw=
Date: Fri, 24 May 2024 12:47:40 +0000
Message-ID: <377b635e07164fd0ad5e176561450922@yadro.com>
References: <20240524-ioatdma-fixes-v1-2-b785f1f7accc@yadro.com>,<48e4d18b-cef8-444e-8638-25b9c6fcaa40@web.de>
In-Reply-To: <48e4d18b-cef8-444e-8638-25b9c6fcaa40@web.de>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

>> pcie_capability_read/write_word() failes.
>                                    call failed?

Indeed - thank you.=

