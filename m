Return-Path: <dmaengine+bounces-4670-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F97A5828A
	for <lists+dmaengine@lfdr.de>; Sun,  9 Mar 2025 10:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 041783AE701
	for <lists+dmaengine@lfdr.de>; Sun,  9 Mar 2025 09:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1812E18CC15;
	Sun,  9 Mar 2025 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="htxjI+im"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A7F13665A;
	Sun,  9 Mar 2025 09:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741511487; cv=none; b=kNg2plslHa7l9MVrUBHRckJTNA8m/msmCtX8S1gc4hnPqXK/Aal065Ob0qtfY1cDjueuZFEFLlrly4G8qMXP6XtxzYpmuyhP7Of+BOKlMUPqTZjzVThP5T3qr2/t1HDCuA9Z8R5Kq4265rTNbaIHvSqi2sTdN7P6BqIm5SyEL8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741511487; c=relaxed/simple;
	bh=x2FOu/NEuxoDkVGrXkaSP5DObgEbImR6WKbHG6zGlH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VIqCNg1YIoWl3XFS6jLmTePfRul45oxGz6GKNWsU2bkiecyfg37BdMI+aNVey3OOnMuPtPgRG2q/Z/qtP80pVwfZyGHKwGQffmoEblQARYEWWbnPmrdFc5gyBgDwWp7Px4XdQYvq7sZLVkDVfOiJzTYTlg0viVcMnla6ju9XQmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=htxjI+im; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741511455; x=1742116255; i=markus.elfring@web.de;
	bh=NNw+IpOz6QFWkFjAytzQgKRkDlBIIWXGBoDjRDdjOOw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=htxjI+imTsbIH7QGW8/cff0en0KghccmAuDm0nSHAYj594nwiuqPbzNoMstcVN4+
	 nZg/8r9GpalH6nHA9N5+fUm/iNa5siZhL6TniqHfeOezYiKqlyFkghWHTmkOTuZbZ
	 clCR3YeoF7JgUNk6p6MsKnhe+RKB/Zmnu4/tRpVhVhSc17fsmhdd+YWRhnku6gbZB
	 8rEp+T35vvTNYYr5bh5sxS4Phms/hZRpXId4aVwAGu8DwzU0mPAyGlrMQa7FEXxHJ
	 Jgdah0Ml/cwE361TUPDg5iSK3/3zMSGsCQJIdqn9FJ1y/FobJd2r7/tgLBhmormLC
	 CyoBJ76jGuxfHELqlg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.26]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MkEhR-1tOUdz3uiv-00ayWF; Sun, 09
 Mar 2025 10:10:54 +0100
Message-ID: <8545206d-4a7d-4e0f-812b-dadf923b5b5c@web.de>
Date: Sun, 9 Mar 2025 10:10:38 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] dmaengine: idxd: fix memory leak in error handling
 path of idxd_setup_wqs()
To: Shuai Xue <xueshuai@linux.alibaba.com>, dmaengine@vger.kernel.org,
 Dave Jiang <dave.jiang@intel.com>, Fenghua Yu <fenghuay@nvidia.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20250309062058.58910-1-xueshuai@linux.alibaba.com>
 <20250309062058.58910-2-xueshuai@linux.alibaba.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250309062058.58910-2-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NDfhp9xDAjhXIW48oUhsX5EZ/dMGLjtrOrNECUeNnWudo7qoykv
 nWr/F6lOSxOXOLCPMh3Er6DnrF4odOoaokRszeh9uU0TJZKrKFJzt88+PspG/+5nttSiFTF
 op8mt/PGonYalAZS971hDKBfLXHR2MRirAmMKM6vO8tPNcHha2+EfyEu0wCLF1N/i9SstSK
 gkkarvLgTv63zq75mNbDA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:h7zrdXulUqw=;x/qIdJKV62xiP3MzcL8gxyvIUal
 eVF2ibsi5YKn4No8JLkdXz7rmbH1k8vku+8S5hdlhbmT9lCP7u7msUCEPRNqB4bIlQ6EdUCWG
 mqK8UHgJwIHGC2fEwI64X2KdIsjDvNWMl609005Dpw+DomrH9++dUBWSNhJ4iOFOpsnXA79Kv
 vPrKen95R5PSvxDFeqd/a3Jjmep7k5l3DB7kc9mnPpFcLLFuDL3mIOPkYI6OueX2rnKzL6Eoq
 gfAS/WnABBgJNTeaD7uaglA56oQdGaFJcfmHK9yWTI60UIP2L5cAcC3kd2rDF8KMt8ff2f2ie
 9dGovVniy6Adj7z2e7nwQTWtFzf5IeoK31LC6vuh77TGTxCZL0J/WLPHNk7olGP6bzQjno9sV
 at+YweYAs+9A6mEstDS4Gx1LY2aAvgrhU0cmNOGXcubbQvg98JuVB8+Ib5dlRXn2aei8TVpCg
 yvZQx/mrb9FK5cN6zMo1cBsxPXawJXsaMRpK8B8UKrw1TT7oiv9VLTa1ugdDQrLUU7qlrekNr
 P8vNxuX4AN06FwuH22UEk7QuFhw0BL284sMdxQt/mfezFpIET982psQ4Hoa4G1Na2fPuLg1/v
 K4i1MeYSuFmY5Y3x24dHGzFzDBSLoSHdIn/LHjSMfD+r1tLEi2fMhwyEPP7fWSXB1Bf6nc7Zs
 RK5fTtdyz5HtwUCjAgxn3IJh2gKpDzZsWcNQWK21p4njPdulMmirjULky8gGSllrvOKPxbAry
 /TaqEfKcPbTSSxH5ptR45k4Xo2ZsJ0MXLUgVkqA4ziPh3Ss9YAqur/oNzkhh1MsoW5AAGeK70
 ELz034CRhwbVSSa9093Z/KowW7kGtwOHn/EN6mbo/K3IC5Gg4EP2W6+tOx/NP1so1y3FGxs/d
 bfvSBiq89hLCF2agZ0MYdWYjqJHgRXAQvLCfdE17OXg2HAweunycTmUBpJhj7z0m3LXNwO8rv
 jgrz0TTHq+eVZqvm5I2sekPeY/oEEqgC+8WM5zCLPUaWr5xpeRoG5iABN22N6KJmzM+LflMnm
 wEnE5EwC21DRoywuq9r5Lu9F2VkUeQMgK8efG211pHAFaGrJj3aTrcS3T5tG9VdCOPYA5NyJr
 of7FiRFpBbu3/8pJ2Ybz5DmDg7K8f+5I/jkPn5N+1LV/Eg6IPicVWJBgri7xLNM1fxbNc+XCM
 kjKxLQKDif/AO6f2fgQ9IBexkc3c+OJ7UhEVTz/G+JAlZMddajYTNMbbOjGYzuoZ5DNoDmngj
 rZfv3+OmDpAgE6q95+z2pjIS5r2qKbb1ZswXbluVd4GPa6l2SEvaOFOl+CZjQ4cB72Hp+zuZa
 q3T/Zly43hppIkcSOSMv3PQD+6MY80eE6qMEOPU9QUGxB6kF/OSEKbuC0fuFnpWyR6X9gvssh
 4B6VWPsjixMdrlUXirAxYqw0+5Uas5ko8RRmTsc0pI+j5wXWbwofyqfP758LZk+tQIRkWWdEX
 2P1pLw1Pycj++udyOqPnACDDuIqI=

=E2=80=A6
> +++ b/drivers/dma/idxd/init.c
=E2=80=A6
> @@ -203,7 +201,6 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>  		wq->enqcmds_retries =3D IDXD_ENQCMDS_RETRIES;
>  		wq->wqcfg =3D kzalloc_node(idxd->wqcfg_size, GFP_KERNEL, dev_to_node(=
dev));
>  		if (!wq->wqcfg) {
> -			put_device(conf_dev);
>  			rc =3D -ENOMEM;
>  			goto err;
>  		}

I suggest to move such an error code assignment also to the end of this fu=
nction implementation.

Regards,
Markus

