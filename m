Return-Path: <dmaengine+bounces-4498-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 640EAA36E8D
	for <lists+dmaengine@lfdr.de>; Sat, 15 Feb 2025 14:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 734F11894768
	for <lists+dmaengine@lfdr.de>; Sat, 15 Feb 2025 13:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1F01C863D;
	Sat, 15 Feb 2025 13:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="VkbBkDYj"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB7B1B4248;
	Sat, 15 Feb 2025 13:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739626503; cv=none; b=hYD+GUdkG3TxLIgFvHarYUaY2Esw6LWIlVp4aAm30K9nnkHs3Mqssq4H+jAdcsJ4sjOGaLD+11Iy3dNV2JhKFvzW2kba95uti98W2spkJs8i+8hWTfxOGkapRjkrNI8c8zHv6qYdOSO4+tY/Z8hHo9gexvN9k0Ga/c+WMpzPOhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739626503; c=relaxed/simple;
	bh=atpaXr4TR2Biw1BzOVCggsfOeAMZ0PotZ4lv/rOgYyE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=tSl5ApEz6v1kT2RMpnAyBWUhOnNNa8mEu2gn1TXd+PqdkXV/hJPRGACnENTnQaY74sN497DLRPLCtxl6cgYWGNWUe5g0GgUW5oGwjrAVv2iksX2G5QDhZvAXwMTCv569crX2PKZ8fWsVmeada/ua3UhtPzhPprPaOQhqUre6jB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=VkbBkDYj; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1739626489; x=1740231289; i=markus.elfring@web.de;
	bh=atpaXr4TR2Biw1BzOVCggsfOeAMZ0PotZ4lv/rOgYyE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VkbBkDYjFKvPhqbQSt1C+X9dpQWlovXE7W3a9zhXEasIhoJw3/KmRJmLrEhRUmM/
	 Up32rUVHx3bEbM3qm+FeRD07faZu3iamE+yM3VRtlfnXK+vlJSS3pasHgW1qQjd5s
	 VPe0RonAW6qV0VFAL84V3Lpq0wIuslf39o+BGtiGE7FWlb22GlP0JaNOrCbqMmWU2
	 OI4/rBiZv3SyUlBrvMxln6eB0jPwZjiHpYRazE3/+WSxPXCpbfW+anY0ayAflz2IC
	 Tm+85iBTnLjvI0bLq+HEO+p5fhy4jpuJHHE7GQrSU5EY7KxPddTS/0y7VVyX95mcG
	 sbpS+6UWrAsD2O9GZw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.21]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MXoYS-1tr5Fd1vq8-00TE0i; Sat, 15
 Feb 2025 14:34:49 +0100
Message-ID: <09329455-a90a-4ff7-8184-31343def027e@web.de>
Date: Sat, 15 Feb 2025 14:34:47 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Shuai Xue <xueshuai@linux.alibaba.com>, dmaengine@vger.kernel.org,
 Dave Jiang <dave.jiang@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Jerry Snitselaar <jsnitsel@redhat.com>
References: <20250215054431.55747-2-xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v2 1/7] dmaengine: idxd: fix memory leak in error handling
 path of idxd_setup_wqs
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250215054431.55747-2-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ngmq4BaPF6er7HYPTcfmC6bU9pMC0bNlwmDZnFiwpYCt/xCSO9C
 5E9CP+Ux9vt6iCY6SexkE0tSKPa+3DfIElnaZ0tAHQE5NnJBy1pS2QQq4WZfC4hC3xdH2Jz
 ZMFyS5M8tAKA4jq0N0aO4+w8/OO/2aEwsHVUnkEftUtysx4nl0Ahr81ZixMaiRdkVAjtIy1
 y+l4dUJcyoZhpI+GlDSzw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QEqApKVhxxw=;ahj0ZN9YftLzjyDqgmZR7mM+CQQ
 s009uMhxL5NLzWwCMgtDQbIYP+hNFSowLlxApBi5umK85W43rNPJ3fg3rkJz9nJUYVF79W1JP
 vR7hj78dRH5LM7F3NU2GaYzzzWVaz1Lj5c2bUAb+2FYJ3KR5VYgqoFvAzqSVdnszPojiyOy0s
 ZS9fNerR6lRkafV2VLFlPNnLTgh3+ySCiN31HplLgbJhtgehncexubjMfF7+y7MbIHWQ2c0XN
 08+kdaOGKHUlbppazQY0L/ILqMg8bMWd2LhKA/7O7xPOQZJx6LbOubAcSe+pPjHO3iGCkO1BN
 +2DRhCA6Qh7xQo18LZ7GmzTKjcsiGrNGH3/PWJ9TIkyZ6Eg77oR4YDH+02mTemeKkl5ae/qCO
 REr1DERT4CdWMeYHAf51rHygIbb/HmOTj6BeefZ/2uV3+7qcqlDKeJGuLoDGMizGhqYbAV1mt
 8w4OEPxMCle+XdxDPgOCIjhRX2CJsMZPLTL9zrxYXeMe1LhSeBYQxbfxSA4JOJByPReNcW05a
 hPEfTeu698rq4o3MRQ28RcxudS4XciMtbJ2UHVr40bpu39VLFgA+CgWp1slLa2hBYvY8fdAsn
 lDjCqpzJZcVReBCsZgxW+yOJbnLzvWkAaAFoUtq/6JXbxa1bYN1V9dnLfKuIAWlejW9Yj5dL9
 EDFXhhZDNRaKt0gmwQnsjbGA/RykQUfCDYkfXceavZ+ax4bAdoA/I4+t96wtkcT2aAANzIeTI
 iLsOZsb1TW0Bgzd12rtSxzGByOZvmzNCfKbFU/M82FJi7yrt+tb0vT5rgmYTwuXFeNKi7prew
 M5P+KoyEE4WhP/bAzp+22N87qQPkWH/OgWYquHMztaQ+273YT50Hkyg38o2LNeLwvY9UySHxi
 v29oAD0ZKzm9yxpliEIrD4HOFvpLB5QInHWKn1yC2cOmf8yGrrp88Sn1Qj2EIAPRBMkw9gaTQ
 z/zbArU2PBxe+3p2BO/BWJThLzWdLOks4QKVeQ2yhxCcIjz/Vr0gT7mR/Qxqy/cMyjypN2Rsw
 FSE8zh5U+rLvpZujbQKZJ8fak5yr0cuHnLiY097+SRpPPD4VVLHXYvOHIPjfp9FXWvrYOA0M6
 jPpgkmoLOOpNIWOgONQ/5vc0ij5jaa4zQQDl5mD8d3L6/FE+tKOZMRcoM8o+uQhdOXUYaxc8i
 u6Je/KCSzPut22JfDRhY0prTx6gnjjdRd6nj8zaQxsVf6hP/ppzCo/aIkAakzLo21s3s0xSgl
 GgbmVJhO62BB+Hvuq8ik59VT4Cm0VA+OZY6v9FTMsf6EGbeRCpKIhjVz57ZLyT0ymxpZW2qDb
 2xLX3EGbz4sHbnI68cOPd+0b81BUiai4dMSgVoskIubD9/Rh9xDl0qB7PSNDOg2Gq6zEOimbR
 w07XbZr5IELnWRq7ovEjbVquj97hCSUkZzrh3UYgSiFFc2IMy+LT7u3+Psmixv4m3/cnvBO/q
 ZHCg33w==

=E2=80=A6
> Fixes: a8563a33a5e2 ("dmanegine: idxd: reformat opcap output to match bi=
tmap_parse() input")
=E2=80=A6

Would other commits be more appropriate for the desired reference
(according to the affected function implementation)?

Examples:
2022-09-29: de5819b994893197c71c86d21af10f85f50d6499 ("dmaengine: idxd: tr=
ack enabled workqueues in bitmap")
2021-04-21: 700af3a0a26cbac87e4a0ae1dfa79597d0056d5f ("dmaengine: idxd: ad=
d 'struct idxd_dev' as wrapper for conf_dev")
2021-04-20: 7c5dd23e57c14cf7177b8a5e0fd08916e0c60005 ("dmaengine: idxd: fi=
x wq conf_dev 'struct device' lifetime")


Regards,
Markus

