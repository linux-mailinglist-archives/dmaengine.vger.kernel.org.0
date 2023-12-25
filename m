Return-Path: <dmaengine+bounces-657-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B2881DFAE
	for <lists+dmaengine@lfdr.de>; Mon, 25 Dec 2023 11:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 517DB281D5C
	for <lists+dmaengine@lfdr.de>; Mon, 25 Dec 2023 10:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060B92E401;
	Mon, 25 Dec 2023 10:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="njxlL7Ss"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138722E41A;
	Mon, 25 Dec 2023 10:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703499619; x=1704104419; i=markus.elfring@web.de;
	bh=BcDjKBOyEaRKAxrqJ8HhD9NG+93EcGaceaR8TsHG4xc=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=njxlL7SsWq3EoKB7t/Stasqu/iiTq+qCDkeVWW0/9HtseAk/GOLk5ethgcI2gcTt
	 B5H0dLfJmNZa9TrD/nGl0zsSLEBuevJ1XHeWDmXl7qHJYbFJXMpU/psZmIbOBcVXK
	 xQgTBdyuajcPq7j5rKQu7AZjKbudA2ipENUZqm2s3f/i6sw59D5TPq/1Hmevvqj15
	 13fcmAFP9ikphFnmWyN5ntPfs0z0w5MNGsI0A12YbrrZkHGM2ZgOy14m5lD1S+c6d
	 cfXx5XIvWcesJ9b1FaNm8Kamh7c1t9avy3NcCOogGx6GjvOnyFjXNAb6t2dNG5fN6
	 x9i4gb4pMI+gj72EiQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MWz8v-1rjzMA2EUD-00XEuK; Mon, 25
 Dec 2023 11:20:19 +0100
Message-ID: <04ced4fa-90b5-4dd7-8f50-2f898b2c0855@web.de>
Date: Mon, 25 Dec 2023 11:20:18 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/3] dmaengine: timb_dma: Improve a size determination in
 td_alloc_init_desc()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: dmaengine@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <ebd531dd-60e3-4ac3-821e-aa9890960283@web.de>
In-Reply-To: <ebd531dd-60e3-4ac3-821e-aa9890960283@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Hj+qur51bNboQvrcogJaAioT17jm3VMz9CFbZ6eqKgDxp9sPq3v
 IV5MHrUZQYKCpcBdE18ug+tw4+ty1LiaE29qw3xnn2FYGrLUa26k3TOgQPDQWkO1u0mtQ0j
 2E72Wh6j/y1CYPwhaYjGTjmjvdcAB8vNwxCKDCkCTuqMy+yW6A22nTZLq8/n2nmoff6ijgv
 2EMq14MgnJDhDnp6sXY0g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EechiKC28UA=;Avaih5tdOdZMgr/C+RawOPJ/OYI
 hYAadsHCz8Zdqx78XOgZrEtDT56dqhsT2AU9NKxcF5+HhzCvnOehzkgLI/JFnOPX2OeiICYMg
 izn2Xhj+qRneoJQ7TbEs6ebZItXTH+SmH8Hzs8qZv1qc/hWk1WmQIjTzN7GSVsj6cWTNuweOi
 8HlhABAvO7XG+Z62u/YSetdFK3fO5VoY+EXaRWPsQtA3dk2VEAxtFd0LK/iRKR4qsb2eRbyd9
 2by6EQc75pvclmCaYge+Hga3wQT8jIua77L7kgJzyeiy3drArTULhzoLz26yfrofUWT3b4x9D
 w+A1B+W0eOV//sUMuNiMz6ZCaKz/xwkHbjpJNH94SlRC+TzjKOS3968VseQjrRemqpzqBdQsS
 QHpqSK0REDz3doOtBwUuvyuL8LItkQNM9FlRAtdRqCBT265AG1UOteUgBraMR4fjHln8S6xN8
 dmN37eRWGmsqUlsWS3Wo1eXV2H2P8keXRmO1OUIk2RJCV2ML7hb9VDARLWF7Gneg3C0/CUcr3
 dsMML2P5nceDpesSCfuYhS+i3guv/NyV7A9IurMEBxgq1jJkpLY1BJbLxK1YGKMnl+szQzFCS
 onzYdHxoCEswNPTEKQZii0/eFkEzxxR1XVYlVu+Y+9MGuNY8Xv1p48hxyPHSCMWTHmk+b+Ot7
 31iXQUuyb1kENTNO4Mls/Vv6rW2X1+hmgI/diazCEDUToODgqExarvjMPX95cTbKV8KnAByfE
 Xp2G3cZ5cc7caLfi6TTtH57b1l51ipCPuchjKppqsO+KoMfcQduv3IDQUAEcbWAMWKtVRURTc
 ylK/bQJ8XKcFDGXgcU7AwQvli1AY0SHAchwNh0sh9vi3zLi/7nOHlFQmK+C9qmAMQkgL5wkRr
 BKvQ8HXlqHaacDoSB2jOM2ZD8EjuVbrg7OKajEQJPGQ8+w3CuVLyaGUNqVcYhId3ObhRI8Kgo
 so3qbT8p6m0SA+mA/B6lR8wAmxk=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 25 Dec 2023 10:50:10 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/dma/timb_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/timb_dma.c b/drivers/dma/timb_dma.c
index abcab0b1ad3b..fc1f67bf9c06 100644
=2D-- a/drivers/dma/timb_dma.c
+++ b/drivers/dma/timb_dma.c
@@ -325,7 +325,7 @@ static struct timb_dma_desc *td_alloc_init_desc(struct=
 timb_dma_chan *td_chan)
 	struct timb_dma_desc *td_desc;
 	int err;

-	td_desc =3D kzalloc(sizeof(struct timb_dma_desc), GFP_KERNEL);
+	td_desc =3D kzalloc(sizeof(*td_desc), GFP_KERNEL);
 	if (!td_desc)
 		return NULL;

=2D-
2.43.0


