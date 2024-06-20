Return-Path: <dmaengine+bounces-2434-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 740999101DC
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2024 12:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CE671F22BEF
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2024 10:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6971AD499;
	Thu, 20 Jun 2024 10:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ELOL7gKQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D991AD484;
	Thu, 20 Jun 2024 10:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718880378; cv=none; b=ZPX5/93XgFRLoffQm+CuYB4zUUnriPXDbiJQqPh8Cfu4Xk+34lLvMycqa1TIHWIzuhvxTLKchkBT5iAH6s1w3KWeizK92nVOUf/kgDAAW18HYsssvqr5tpLuF+HYLiTo0Epg/F/uby0MDV6QCiMj1QKZI703YSBPIAxzlj0TFLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718880378; c=relaxed/simple;
	bh=8awIg/wBCB7FIoVC+vPhOB+vEvEyHOGDIN/RcnR+5Ds=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=s2BiQVccm6qFhzodqL70v8kXIaAZOUm3GcPl2vnUA9xkI2I2ZGMnlv62+EpRaxJLD98eMMTMcWZVUI8nie65SIw32vG+ehSWcKnq87ZBTLycnKMqMOE+d1op0T2kUHcLoMnmBnLf5/me+CxA/VJsgqMR9aZ21etrNjjhoGY8JpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ELOL7gKQ; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718880331; x=1719485131; i=markus.elfring@web.de;
	bh=Li8eiNsap0bizfOQ9HPDPrawZQbmEHLbqYMyIF+i22w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ELOL7gKQIory3FK6VEcJNutrH5YQatKgd7IOgi4QjpkjDHPWbcvc8mTZxbyuitLV
	 VRi6VIbr1f5UFmvi+RVRuW+ASXMM0uDkM7KnfBNKZMNVS+1dS8aPaC4Ib1Xn68zn6
	 rHGn+ISLojVl/UkCSLlDGgT8HDmZwAiAfW1SNXXNRFG/nrrumlUTHCHIUDTKKQeG3
	 piyzDRs1t6hx+x7K0Ef2zgjVUYi0lykbOHnRX1aDC8HUeFuNHSLL1ET7KfvqZPdcS
	 AUynwekgohExYbMLi1a+R7zBNmQC1whsMtj9k2uGvTvLLS9ml0eoLo3Sm7/cPC1Jp
	 ctnWvyyXTIuIUVfJkw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MeUc2-1ssUBS3U8q-00lcXl; Thu, 20
 Jun 2024 12:45:30 +0200
Message-ID: <c25aab0d-48f6-4754-b514-d6caf8d51fd1@web.de>
Date: Thu, 20 Jun 2024 12:45:14 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: lkp@intel.com, Paul Cercueil <paul@crapouillou.net>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Sumit Semwal <sumit.semwal@linaro.org>, Vinod Koul <vkoul@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
 linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Julia Lawall <julia.lawall@inria.fr>, Lee Jones <lee@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>
References: <202406191014.9JAzwRV6-lkp@intel.com>
Subject: Re: [v11 3/7] iio: core: Add new DMABUF interface infrastructure
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <202406191014.9JAzwRV6-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NTRxLCtqL0ApiDn3i1UPRK0ESzMnPEcNQTBlesEZBU9CEYqPi1f
 AGUE0Iqpc83BxVHUG3k89Q5F/8z3etbqR3DfEvcjeL6Lx3pae77qYOIXUgtST37Ab8Do7k/
 wU+c7CnLhk3+TYr1zOspLJGta6mikzAbopzkKmb71FDA4NI3466ErYGosxNpmnHTc9l4MJl
 +CGi0hB0G1QMCNRUrV1Uw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CgG6g3IuUkA=;GjeLuLN4k0zR5HkEhPPDnj3RINq
 /CkwuYA+LrI5aUWTIamlyDVGI2+yh3QArzyJ1np2UYSYrgxICqa8foIibHUj53F84/MrMcLgN
 GFrlIyXRWVkXW9fbV75qNQJodpMS9f6kv/bJ1NGIei4S3ewSiKcHU1jPpTzxbjNQjGBBEumPe
 qAfjWGQherZuLeRpGpQjN/Kgpk+Cr00WMTLsBj7wWqRRR86NsVtzsuvgHSl5brUDWNVp3qGkW
 79/2lncKNGLQ/RXgQTGya5dwEulbNeslrEdSt6qMQMb+Nv9rIR4FWhp0ZGSVNytzEF3wam0sB
 3dVQZsO6RihZ04m5LerPVT+np3V6RDup5Kvm4wcP4Ti6xvI0dtVafefyZELYAcfYD9mdVE8fN
 iqI8Ujalah+CZN5KCorrwfn01U/QdcOsZjQKG5mNVHRJTo6WhLHPap6R1OtSuCQxr7SiHQCHO
 dSoY1BmUgMPnfnglAhaA0xtqFIG1eWrzf0k4Po2ej4e5fTe2J7E3JUVkoUYDNSkfyr2cZAlMk
 LfrwOZ7p3YCbmeCJDEdYAWCwS8Uzd2uasIh+RKhUKsyjiKpt7uAibE4HFl2zl34J71qplTItr
 zw9C2y2fYmdsJShro/sGE4I1fXYUvHpLm2N9g1FUvaxLvECa96Z3wlbFhlDOPcWLUSMYMO1CP
 gngHha2pIf1xmH7Gt3mu1eickL+qEJ3tHc/ZL96Dpm7U4MuTo9Hm5oVgSi8h3ewr3hy1VNBI3
 HJUY4BmHs48k0qNMZ4H8hT34jR1O7Al23WHZaxCNv7QjCPVS/TJY+qfpNBUITcG4Zft10nQJo
 M/UF/zY1FmHRWGS8h3/KE5FpFUG8vYIGB57PgcfYuB3pLVgAGs7J9TIa/s1dsmlMUS

=E2=80=A6
> All errors (new ones prefixed by >>):
>
>>> drivers/iio/industrialio-buffer.c:1715:3: error: cannot jump from this=
 goto statement to its label
>     1715 |                 goto err_dmabuf_unmap_attachment;
=E2=80=A6

Which software design options would you like to try out next
so that such a questionable compilation error message will be avoided fina=
lly?

Regards,
Markus

