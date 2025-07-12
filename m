Return-Path: <dmaengine+bounces-5770-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FE1B02C75
	for <lists+dmaengine@lfdr.de>; Sat, 12 Jul 2025 20:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 782927A9695
	for <lists+dmaengine@lfdr.de>; Sat, 12 Jul 2025 18:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B961F3B85;
	Sat, 12 Jul 2025 18:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="R9idJTMX"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7148415E5D4;
	Sat, 12 Jul 2025 18:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752345924; cv=none; b=l4nYwBEboOIxezxAqF2Sxgow5MnKfyXDJLooLvNuFkbgrnTZAkPgLtpafI7pX9SdPjtqnNBOlQVqUdMwEk5ja3fX2pofTpDWcnZiEllxfNhQQ1FHJlxjaey7cC97U5LPP+WFSTjhr8s3UcP6DmA+IqiQ6/yIDBpwnEtozzYdiFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752345924; c=relaxed/simple;
	bh=U3pm2J+mn/APVgKQP4vS0GxNg3pFfaVK3pN7cIUGWJQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=sXD2W821jXNe6AJ6uinK+cgCUfQ9830Ccogc4VDJUgnRfivQz4UBJ7f4TdV1JbLDNKP0B9d3H51VMiSpsO9PH7wqDACQxh6UQx1Ic6BC1pTlWFdm1HH/4s24LKn/OPsPhxr62ZQD+IxHbmgwX5EYEcjix5gkCOcajJwzDiAmAtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=R9idJTMX; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752345910; x=1752950710; i=markus.elfring@web.de;
	bh=U3pm2J+mn/APVgKQP4vS0GxNg3pFfaVK3pN7cIUGWJQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=R9idJTMXSl57WEa0WXjxzXzhRL2mWCKPQDAb1oIPzThuUKQUUTE79ldJjw1Q1l7z
	 OWO9qh+b3EqAbsA7LiVYvF1GXKp2DfnBjJ/16MaboQlChBqrBI+HaquylmftjHVmL
	 /Qs9Qvqk3K37d0qi06gVl5dETc1NwRoKf15hdDnZo9N1CVu7oJNHesWgbRS1hx7Oi
	 Ad9tcbVhWn9k5p19S+kzHU/aswRKeiJIjegD4LBMS2NOtHEpbySF/Lnvuj7z8twKN
	 HiBMctvzhWq89TMvWOiEGFtdzwXcSjCXv5+MCD5kejO8M7Zk9MSR45eke1Wmxgt9j
	 mf20exQ4MzT/kq39Xg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.234]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N8Voj-1ufFh63DFp-00rONn; Sat, 12
 Jul 2025 20:45:09 +0200
Message-ID: <33fe23d5-c76f-4f1c-bb84-c7071310ccc3@web.de>
Date: Sat, 12 Jul 2025 20:45:08 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhang Shurong <zhang_shurong@foxmail.com>, dmaengine@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Vinod Koul <vkoul@kernel.org>, Yan Zhen <yanzhen@vivo.com>
References: <tencent_891450514525826E2E6AD3B6ECC0B83C7209@qq.com>
Subject: Re: [PATCH] dmaengine: usb-dmac: Fix PM usage counter imbalance
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <tencent_891450514525826E2E6AD3B6ECC0B83C7209@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rf/FJ6YHvdfdlPTwHcGZasnhyCEtNGq+8mJ48qXsvEfJuQKrRT6
 BOqyFfOVoxEfdG5JPyrpem1BPzRSb+bj1tMKi6+uFCZhq/yMnCseeueKjwBInmGgv/vt3Rf
 QfWkPHngSwmHh9bD0zqSMQmPsGdngI8yj7owPGyuTek6Z9QuFELxIQFFE2/DS0um27wQ5rN
 ugdm4VLgXpQ3KX7Pi1GZw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ceg6tfI+eh8=;mPOvHYavKlQCmfPpjaOMY/iw65N
 btGBP7ikQ20gnONl10YbUtOPqdwvzt46fRd5aPt2OCIKwAMV1FPB25AaeL8aVd+mJPvvH4VhX
 pAC4bBmlx8tr/p+bvBprCbV5uL30ElkD/uqmmGVPq90sR3p8Ij6MPpQatSUqzTqsnZIpwfxEz
 2M9dtcHsXkQmn7HTVuOUuZCVXMxO9R+vTGbQnh+tJIlZCg82ReJ0nO2kD7asvq1GD+55qfqM5
 FRIMlqCpR4x6Fgvr1aibIZgQyQQEv/phwNGE1rnwZd0Qxc/UtbzVtkHLgY3aJrg0gNXpjtyNB
 gOCotvvibuZgnU+2GB+xkBK86z2Kv1UZfzoKE/QzXjckWRKAGK8rMTp0soce+6fWn+Ue5HXvo
 hkrhMILHIZdi8gGd7qqrnlJFLUpQOhqJmJp9E/qJXHGqynkkeOVnRLEWCyp5fLTgfIHLFWNri
 mYpNgYO+9vxYrnpgdb1UoQvg4witipiuodhfU+vU0E4GJHJ604Y3LcDamQoSowDr5z29BO2xi
 EIwD9PmSPVmVIS79vgpSrORPFrahi+NLVpfTJkNaJ2YWQlYAjN/BI1j3E2MhoUQsNuTXhAxUG
 B80Q5qDyBhfWD7AP0cKqTjZ5goWehf80LxCDxee4B+/XdACMi9+W8SIywWjMT6ksp+EgE2o+I
 yePajdsAawTBHAXbglXAnnzuo2oS2pBojIPgXN3scLwB0Dj5a1Yn7fr7Ol2R4L44j+rgzhMH2
 unCYTOXwVJLaRZ+8aco3AdRI8PNFnxgrN+3CCftKGMHFYbPtVOyhgjGYdgixKHWzSv5wqltrW
 SeqDEaZco2OA3DWStdUdCAT+s7vQ55jJNOeFNb4DcVajYmhlmXxoOIaLTLA1PuQPgRga1V2JN
 BBaiAm394oTahlSRspQ0+BpK35/828kktY2yTaszuNupaqkYaJwYppzsdy3sqxjRzQafYR4Bz
 IsksesBoB+brDAeJ8HRwx+tGC7p0zFnOG+Vu0LNAqVv4f7lfeilcr82bN3YCmckBuiK9yRDip
 Ds2q8/cgZ/V9Sw2olrl5pPeKpKiFD5NCngxHHMhCGEbHqTEC+bRIG/utZUQK5UuIhHXHkX7Cv
 aW0oJGPVJyBVkNdfSaz/rCQDI6kpSys+iDF4hooO2WNlCTx7y7ky/DHXeyCLDJM0pQ4lUJNjG
 N0ZDKCUpFZ3+euTd0D+bIu1ph8JFMftKCHeyDT49Ya0ZEYr0r5SrmkSZMgBRKsoGhjU6IyENZ
 /AZkYrcIyeOWQ+7Jr8wFPz0jZwCRTWRiVrgBjGDdOxGQOrSQ43Lgeb1+yUM04XD8E9EFsC+7u
 knbx1l6uwrA357T1YDUvKc225z2DubDzu3K2n19/qUAjsrLrW0Tq/KMeYm5NK2Uo3ZKnyNTsx
 o0CIB7UicTU5DBb91RfvH5wYMeCyJEPsfjrXsjSzMcruOvAnO16GoH3gDnPcFwRit7ma/8Nyc
 wpW8HIorbZa95qDemAiJEA7PDdvzED29zVQzjDmgrKJ1TTz1328Cp+gKKmJ7YmtUct/u1k38U
 0Zw7Y7YPR4L1wFVMMS6ITW301oFOi8HhCh0as4rf4y02A2PzRJmbRDhCZaieaGfK/NkmtMaCA
 iS8drTKq+36fLAIzxfT8clJ5PbNETEJopkcmyuEnsEZLIoB10qW74dlGrzT/lzOXwth0a9Hr7
 QM6TRfdUA+7XL1KYENu7IdfY7892iDNu5mvkUE/3jZsJAjrO7InBd7Z1chLUp6opVSHhMu2qy
 gTdxbcrCHO1Nk341Surwqu2yW2x3Ij2Cjg0I62zh5sT3XEDo8wHrzm9gGKF2Sdpzd9LZxu7pD
 Sn9oN9ssKDWn84eqS/EdFUph+Bc5rLLaZBmu7c5cG14Ufd47Mxzt+GNfPAcBpWYJdB04DoBNX
 5SKZdFkIVHsEAJlDqs2YeAS9+7Hi6KdHEZT6SeNEWUhcUUOvvc1gzTvY7x4MpLyLtt5LDEF81
 dhbHMq9f8KXAkv+7q59JBMgzoowpvaJHeoy08993WZPIrodw7FziaSn7flK/82Ks3Aekxoq/D
 9kR8UIIEW0kK/HukZBwf/o984AJ/0vWiK7TobGiYActz9brAadwArlrhnNYmqGi//O7x4HZmH
 VgNSjq0nMR+E8vohQDbmieKqGDQI0cMqaotBE/jSfnvEhSZJTnJrk4wa4VmG6/S402KbZK84d
 /ndnxtZmxw1nrWUtVJ4f9J+zw1iBi7DbVDrizj5NYKH11Fe5Ij7ev2CBaU/1x5NXkbt8en5R3
 jNhMD8cbzQTG0Efnucf9dHpB/o4HDqgmnz+Zgi5rWw5zogNSDCtr26ZnYO/3FuFRpCmfdSpqW
 PMXah2ExXm+kbFT69iwua+wIOodPC5DzHbbqfth3WqrekHytdKo/mVDWjXzAbxKIT4+6lDy5b
 jJTUCrLLjOtd2x2VjCPdvaJaYawVMOuupMAqkxYSSJm787KQQd479LAZ+O3kJ/9mxXG+V26AU
 yyrIQO/8EIIaSItUMpBzxP7uYY9r12PJ6MeXLXoHfZIvnko+oO5c1nIfFeNHsPTNenTYQrywi
 vlVRGNKoBtXJu5bo2IPlJUVM1aeJnMfJAZA5ZSbWNfiGpYyYp5az69NE76+jROFh52n27vFSz
 cXaUfWU9QlZxYY7sqOyV5SL9jduaOq9bvNMssp9dNbu4P3DfUvmFzfE5jJ/r8bJFZiitxjsb7
 r/+ZQq+xqIODVIVdVvi0bgKT27r2sgB5kPyhFwW3dADvTGnF2m1fdw6yHblJho7IiSqA75tiT
 5UVuD4sMCpN91XOT7QRSStmejylXHEN8RY5Bf3YRANvzJQJYntZ4Wi3tTMjejA9DfVczWdKJP
 bpwCDQQ2Y+DiBG8i9kiKyH8sKXmNVHjJvltgJmxXgEpBEidrojpIyHtq8bHxQSk3zO/iWZwKB
 ngKR+8xnm1qvoX5vU9ljO9LLnrJdsAu1uQ873ypRC37cKAtjsTAKH8acXV9bwU48Rzo/VsWWY
 P9Lw3RXRpaeJx66EdaoO4YEBWisam6OsO/oFD39yEd9zJoQHMcvWxeZdb4Yp20pABorW29A7z
 YifA94KljeNw7pkhkkZFm94lGAtvTWhUGgoqRPM7EFkG1jhwbu6GvN82wPERIeMd8ovBxpxDD
 aNOevJxirG+pvdFTY1MUToNuNZzvztX+E04dlC394tMn9bqKZN2UDRcZjKBDN1VCvtJ1/Cv8h
 +PrpO3cmJuhVanPRggeFBB6lG0Eza6xZO7fewYtzmnuC3+6YpgH2ouFyhyXqtJ8dRRAhclAav
 eb3dTMzEwm35dgVVuQSROUUzR4IrInTFgs/XB2gZ6Dv+f/1pBcsWz4SxiyKKQZb8J6ASoboti
 mSZTME3MoOCue2vOS2A7Xg3vbM91hC46feOYm0X+gPiFPCkLYbU/fWigxo0D4yKRKrXGh6qKY
 hHAUGPFrJOHLaKrGyQzromL9H+vuvPTAHT8aSpPk7uMiN7JWjTQObk8g64uD1zFLMl8UFEPZj
 +jfinbhYQRbpsSOdBHI4E665LMwZD3ABnMBHnRVy3NBYXWn3ksF6o4X5skf1e53gdiPE5aMOj
 gJTjPWpwsy1Z5xCMuCTb+vi3BlM2fu1mheqxfzJlyXlC

=E2=80=A6
> result in reference leak here. We fix it by replacing
> it with pm_runtime_resume_and_get to keep usage counter
> balanced.

You may occasionally put more than 55 characters into text lines
of such a change description.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.16-rc5#n94

Regards,
Markus

