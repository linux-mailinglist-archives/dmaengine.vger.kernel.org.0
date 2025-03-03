Return-Path: <dmaengine+bounces-4638-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FD5A4C8A1
	for <lists+dmaengine@lfdr.de>; Mon,  3 Mar 2025 18:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5F2B3A8F58
	for <lists+dmaengine@lfdr.de>; Mon,  3 Mar 2025 16:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC5B237180;
	Mon,  3 Mar 2025 16:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="FDW/YnXM"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952119461;
	Mon,  3 Mar 2025 16:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019802; cv=none; b=A7ETJqIeimuU1lk1KqCUoDKrgM8sTgTFek/w2MnPn0azflpKbrPX/cLcAe9qX7nJAWMNC7O4H5sMq7MpOzSvIM+xVTk1qPVOpRwG1DLUl5VBlWQ4CSB9RSbXQKUZJyU5uIM9B2IOOSSi5Sj7z8xgeU4UVFDE6NdJo+bOzrrs1yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019802; c=relaxed/simple;
	bh=T7DXxiYMICa0Zkod5jD4T6bb3BNFZU3Nt2tolG38QOg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=T+FQYcdC/3ioTfScF0Sw/luOVmH+sp/N+qxIRRxkglEWmX+5Wm0aykJBUGd+1wLtLtctxztR2V8BbVglo0SE2ZVKfldNu/DN8cKalnP+ctGR40/trzxeF4xS5P1XAA+8Zfdxn+uoutaIn2d/WthZ/oRhiI6VB+pkkwO7pDDEruo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=FDW/YnXM; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741019779; x=1741624579; i=markus.elfring@web.de;
	bh=OFQZ49YdvADU6Nc4Pf1BbEN1CX9rshRjpAinWBUXCLg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FDW/YnXM0hAx1ytQKRuVepa4q/Yk1/taEO2v9otzRqw11e6h6fYH1CUSlR+c2fd+
	 XvNV3xOeb40RL03pVe4sb28xZVYspGssu6WnJB0KVBcL5e+9RHepqi4t3GGjqpAax
	 WrJMABHzhJVLOMkbawy4CfRjJqHV1odxf3bT/vomhbjjr1ACGULuxaKTJb1+vVxhC
	 fe4mNvB5/g3q4ugIcsU84RLfXKpsWx6Vvd/p3hCxNmiGQPoKP5bZVj6Swgg0Pqk1f
	 KVzqxb9OfUhuLyEcr4mQ4nVPS26X3L7oAvI+my96l389JZVpCGpaRD0VbeoLX+T1p
	 zim60Xqrt1gan6/kmA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.19]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8T7E-1ttWUt2ZdY-000rld; Mon, 03
 Mar 2025 17:36:19 +0100
Message-ID: <d75665ec-e3e4-4f4f-8096-f81bacd390d1@web.de>
Date: Mon, 3 Mar 2025 17:36:18 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH RESEND] dmaengine: bestcomm: Fix exception handling in
 bcom_task_alloc()
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, dmaengine@vger.kernel.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Grant Likely <grant.likely@secretlab.ca>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sylvain Munaut <tnt@246tNt.com>, Thomas Gleixner <tglx@linutronix.de>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Vinod Koul <vkoul@kernel.org>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <eaa9f90f-c91b-dc87-51a1-d97f99fc5b4b@web.de>
Content-Language: en-GB
In-Reply-To: <eaa9f90f-c91b-dc87-51a1-d97f99fc5b4b@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Lg0A9+SPlbftQZwLLCIf63ojz/imADE3ZJO7xRpovtYdB7DIdrg
 HON6lDfWKOVBBNwbA9b/0O6yuUjCHX5azHxTZ+0GPzP/Aabr+Bxm/Kra5o/I05hzg3HOLlG
 yABF5SkJpsQs/MLEP0Jwa7OHkn/TMY9Nntz+R+VLEeNwfGIspEZNUfMrzykSCce0tf2HAbm
 2iA0gWF8fF6YCEu+qgyag==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pspEfkEslvQ=;TvmhTkW+mvGvRsBBAka4S55Lhvq
 AyoE1Q917+OCUVC2G5g0M//Sz0DOGV9UnUXIt1fX85a90rWmCi4hrvEOq2nY54lN86Ixs/n/d
 R7RV0vKowBqtcPJeUcZyPnP5dJBxwUYFeaLfLNLCjnoUxdhz2g0tvcye9pHo5KyeqdXmOdbaT
 tKCUluofU51Xxv1phRbH86QKqOkg3uBnu3JsL/SyDXImtL71Lo2sAZwwbrG9oZHEMfDjW2B+0
 YM+xBvV2UDWnbOTY9/s2Fl7NZ2bf3fBWXIkjpVWGWUKR1xrgVQYEQlZLtyzuhtALe3s2EruFV
 r1P6PY8N9gTfHcLSJ9YUnkspWaFN+s+Iz7Ybbj3RYwup8uKtsaio238EGPVotVNSssP9Mcvst
 aifwqz1N5/eldTeH+6i67PRIOm1eyoj0qgfDV5i7rpsEc3LCGVMJSs1hhBhSG6KhET3EokgSj
 rCTlTb2WhxKjyf1nGI9tfYf+mKrSPz1BaTAn79ZKFxbAk9JMukgik0aA0Nhehh4K27tz8svRh
 1IEMKr8xi1RjeKBT1nLT65535PAKbCcB5j41UjbtdGZMMZqiAxnsPzQV7j7zt04i2EzSLjNCo
 EL/bGg3ccwCYUSk678vFl7IYzEy76DlWoS9Iz7ACrFAmoSrMO0rNrs8xM1kFCeWSRF+RO8aJP
 4Q+ekGpuP6nnhVtH9ok0m13jYrCTsdiq8ZtaFE7ITJSium6JWgEe7RJfCmklCf7fwGxe08we0
 2LKuf+Va2NhRK+RV4Bl60OP+S9hHORLn2rvWvN3QeK1cHDFVPm8iZpbRmII9c6G13RWh7DVct
 G989Qnk2TeNHkW3evLfJTHIfgoaaQ/Jn3u7j5aPVXSRCQq53qpdfGbAOxY5ZaYS4XXSVowyDe
 MZnOs9Qs2Z3jPmxBIowps8WieZ02hSxAtZWeeXAyLb6L+qNFtJPmjKkYFvR5Z7vuVTyfHZsNH
 Wmyv+6HjFw/kIo37kqwpOXzS7sAlPwj1j7hKB+g9FSTDW5S34nrzyzmHAcQR86icnCBngPkXd
 NfgXkBduQOB8UZP9jEXGmWuJEa9kw17Z0SHcoTLG7tFr4eg+VFM8haf2FnJ0D1EaNf2Z4rC2u
 6Vb47BkstfiYI/sId70+LVK+dn3CdUch/La4ei8exAr/U4Qeb+oWp06zueNZobixXEsjaVB9X
 a4HIDwayi1IzyLW477kWh8WeREm9urV4ywGIY1VvgKfqbdCCvvGRQHiNIDr4bwtd/UThZ0Hec
 ZPBO4eB4sYl2hS/9hLYvnvL/jUJ4endz4+BUyW8a2rJ0+XiKrfgGBrwmVGXGahyBM2rR5Bskh
 oJufOuTqanlDSC4VyI9SDXjp5FDvgmdtACQoVRhWomESz+Py0EZmJ1bd0S3Z6xxMbHpDi45Ej
 091Lt6yCjy84wWnSv+5OrR+T+Cpv5KnDqkr8aH3jEaGbQ2DBh55cyIZSWiDg+7A+1dMyMS+7Z
 ddIZjVu88GvH7IXRpr0j9s1jiRRo=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 18 Mar 2023 14:55:02 +0100

The label =E2=80=9Cerror=E2=80=9D was used to jump to another pointer chec=
k despite of
the detail in the implementation of the function =E2=80=9Cbcom_task_alloc=
=E2=80=9D
that it was determined already that the corresponding variable
contained a null pointer (because of a failed memory allocation).

1. Use more appropriate labels instead.

2. Reorder jump targets at the end.

3. Omit a questionable call of the function =E2=80=9Cbcom_sram_free=E2=80=
=9D

4. Delete an extra pointer check which became unnecessary
   with this refactoring.


This issue was detected by using the Coccinelle software.

Fixes: 2f9ea1bde0d1 ("[POWERPC] bestcomm: core bestcomm support for Freesc=
ale MPC5200")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/dma/bestcomm/bestcomm.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/bestcomm/bestcomm.c b/drivers/dma/bestcomm/bestco=
mm.c
index eabbcfcaa7cb..7d6a92d34871 100644
=2D-- a/drivers/dma/bestcomm/bestcomm.c
+++ b/drivers/dma/bestcomm/bestcomm.c
@@ -72,7 +72,7 @@ bcom_task_alloc(int bd_count, int bd_size, int priv_size=
)
 	/* Allocate our structure */
 	tsk =3D kzalloc(sizeof(struct bcom_task) + priv_size, GFP_KERNEL);
 	if (!tsk)
-		goto error;
+		goto reset_stop;

 	tsk->tasknum =3D tasknum;
 	if (priv_size)
@@ -81,18 +81,18 @@ bcom_task_alloc(int bd_count, int bd_size, int priv_si=
ze)
 	/* Get IRQ of that task */
 	tsk->irq =3D irq_of_parse_and_map(bcom_eng->ofnode, tsk->tasknum);
 	if (!tsk->irq)
-		goto error;
+		goto free_task;

 	/* Init the BDs, if needed */
 	if (bd_count) {
 		tsk->cookie =3D kmalloc_array(bd_count, sizeof(void *),
 					    GFP_KERNEL);
 		if (!tsk->cookie)
-			goto error;
+			goto dispose_mapping;

 		tsk->bd =3D bcom_sram_alloc(bd_count * bd_size, 4, &tsk->bd_pa);
 		if (!tsk->bd)
-			goto error;
+			goto free_cookie;
 		memset_io(tsk->bd, 0x00, bd_count * bd_size);

 		tsk->num_bd =3D bd_count;
@@ -101,15 +101,13 @@ bcom_task_alloc(int bd_count, int bd_size, int priv_=
size)

 	return tsk;

-error:
-	if (tsk) {
-		if (tsk->irq)
-			irq_dispose_mapping(tsk->irq);
-		bcom_sram_free(tsk->bd);
-		kfree(tsk->cookie);
-		kfree(tsk);
-	}
-
+free_cookie:
+	kfree(tsk->cookie);
+dispose_mapping:
+	irq_dispose_mapping(tsk->irq);
+free_task:
+	kfree(tsk);
+reset_stop:
 	bcom_eng->tdt[tasknum].stop =3D 0;

 	return NULL;
=2D-
2.40.0


