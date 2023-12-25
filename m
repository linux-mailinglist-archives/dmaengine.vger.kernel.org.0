Return-Path: <dmaengine+bounces-658-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C520981DFB3
	for <lists+dmaengine@lfdr.de>; Mon, 25 Dec 2023 11:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE3901C218DC
	for <lists+dmaengine@lfdr.de>; Mon, 25 Dec 2023 10:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9BA2E401;
	Mon, 25 Dec 2023 10:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="oEszm892"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A69935EF3;
	Mon, 25 Dec 2023 10:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703499745; x=1704104545; i=markus.elfring@web.de;
	bh=ehzvFIgSeJSu3nZAjymVW905vwyKajE8awgJ7Isa/V4=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=oEszm8925iw94XfHKFlwJrQA3oD8t9iCFVEqmEKTAJn/d1LpUVHuRzeCtKqRSVop
	 IDnFqQMAvI3kAaIOoVEmlDgOQyaAmlFWJNLZeLXGI6sb7sQE+j/OExm3fpVb1ygIb
	 rmJGL0JuqwYEE1i4bmUKtlrlrSjEPZ2Jo+n/3pu7+TkKggu0n2qWDDWPDM+yGgEo8
	 K3dfYiV+T0Sa+s9ZA0887eMXL5SeQhF8jDos9A0bvHGW/9lk/8pywFlVdLcfHuf3/
	 7ZlhgUL3tXfdcibkx0FY/Q025QRi3yaR8qPwVJK8ix3kO1zBKdvmnM65ZWtXVfSeQ
	 1hbRuY2FnOyb0KmseA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MeDQZ-1qk1702OPf-00auKj; Mon, 25
 Dec 2023 11:22:25 +0100
Message-ID: <3184e80d-9056-4a0f-b0c0-8c1fefa62196@web.de>
Date: Mon, 25 Dec 2023 11:22:24 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 3/3] dmaengine: timb_dma: One function call less in
 td_alloc_init_desc() after error detection
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: dmaengine@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <ebd531dd-60e3-4ac3-821e-aa9890960283@web.de>
In-Reply-To: <ebd531dd-60e3-4ac3-821e-aa9890960283@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Rl1oMsp960JeDUAqYdAIMvOPYzMZfHe1CPjrgQS8GX9vY8IVCkF
 CO9ZPyUVlIUdzV1NfxsNHpGudjLmqX5lzPWD7LxC6H1HFeQ3L4oqImoT3Y/gWNHLFu5dyKz
 3oYYWmS3TF5mA57xcx4hY8VEcZaVyew4VcCz1/Nu/QTUUZ3KIYkbZE4P1MywpCwQzl2BmU7
 6wCx9mmTI5E005sLqqBXA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DM+q4z1Nt9I=;Yiy9v3GEYKJ7vkCTt0gbBFxvhr6
 QQmXDJcB9xFHFIV/evpPM9LazU4h7+QdcqGygL7EizOHIuTT1vdcmXN5tzm502oFecGQzM/hM
 27qsHBQR0sC6JnWnYUacaNYqdAVyidi7gG9vz38XV8PdrWvhFhnwtJVTkwVj59DLenAdPcrZt
 FgbvJ1spHeU9GQwE9PW84AhL6MjzinuMmWc2awjrhIcCWscB9lN2BMgTmacJtFOrHAbydXwIR
 PsF6/hQCrpFpBbetPGX8VdiLlDL/yb7IPr4Mqn7xBkVMQLrudPY635aAOSpm4tDyw/tU6PSMM
 z8kVNLlZRjXuYAe1PVx126xa8FchFE1tHGfhwByiJY66g+HzNbBPNyAbbqc9PqUJt6b/7cBNH
 VzPHmAoPLAQSAUhEP3Ye856LSNHveP6PdzT/mstARIomDHwKl3buDlKmwfa3ZwLt5Ot8PEA6K
 IxUyXxQJ/QP4Lm1jhCYDG0ew6a6/3jVMockeFZtQO5iPAMZI2L4b5kTW25QI24+ppXdNdXXIB
 164iSOVFSGTKFa97n5+ASz35gV+FkVtHDwnPZMn6tCvUW0DjvXqE+tscu8bKHmuql72hfFAu2
 /XWy/thQlMekjkNHpTdRhg4fqsQbkloBawkz70Hu3XivxMkbruJ63qWqYx66SPDoRFdHsQSHN
 e0QlVCxY9NmYA8rNFg7Qcf/XRdWtteakBztpRv0S+EjY9QtB9ynoXM5VJfCYVNmuUJyggfZER
 f2T2c/xAy4ptlWk6mdLAOxc3/jjZ6AjuXp12ukm6O9vrmjF0Ihc4mqTU3MTl7IAWOHPV53I77
 3bJg7CTTQqYaKHLvK3cpDgxmVrbO0tCPEzH+9woWVn/0lAs7+9Vtpcku4G4yUUzP/XWomgsd6
 6dBojfTz18rfvRP4+nffu5WWSMUf9eTSy9RxuxaPL+Dc/PRhupM5f99a46u9SK704wTtFDd07
 xA/PZJj6AbZw62+6YvDgBaexhdU=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 25 Dec 2023 10:55:52 +0100

The kfree() function was called in one case by the
td_alloc_init_desc() function during error handling
even if the passed data structure member contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus use another label.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/dma/timb_dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/timb_dma.c b/drivers/dma/timb_dma.c
index fc1f67bf9c06..831c67af0237 100644
=2D-- a/drivers/dma/timb_dma.c
+++ b/drivers/dma/timb_dma.c
@@ -333,7 +333,7 @@ static struct timb_dma_desc *td_alloc_init_desc(struct=
 timb_dma_chan *td_chan)

 	td_desc->desc_list =3D kzalloc(td_desc->desc_list_len, GFP_KERNEL);
 	if (!td_desc->desc_list)
-		goto err;
+		goto free_td_desc;

 	dma_async_tx_descriptor_init(&td_desc->txd, chan);
 	td_desc->txd.tx_submit =3D td_tx_submit;
@@ -351,4 +351,5 @@ static struct timb_dma_desc *td_alloc_init_desc(struct=
 timb_dma_chan *td_chan)
 	return td_desc;
 err:
 	kfree(td_desc->desc_list);
+free_td_desc:
 	kfree(td_desc);
=2D-
2.43.0


