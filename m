Return-Path: <dmaengine+bounces-2131-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 100158CB372
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2024 20:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08B4D1C213FB
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2024 18:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BC114830C;
	Tue, 21 May 2024 18:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="tGl1NN6/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28D621105;
	Tue, 21 May 2024 18:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716315747; cv=none; b=Q8TQpAA7waqMvpKd/46md4KeInYO0QLsakk7QMKvcs+LmnqUhsvdSp8c+vEgj9xaZ3Z4+NDIqm/X6UlG0LoVKdJJH1gMZ6hQNB06tURMqtPZNUIK81US6DS3pdVxC+/n66WKXAZOuC8GkfWEgVnigMGoDfME69Uuxc6WOlSXsnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716315747; c=relaxed/simple;
	bh=c7B+5QE89M7OwcRDj+HTxHq9BmlfVneW2jXpR/gvwOY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=MFZv4zoI0Of0KeEiw0J7Ls00tu/FqlOAJdklmk2u43Xm1+Pov2+Yv+gkd/9/VLAW5GSr8Rn89upHzwolmhsQiOAYMIaDimrDv5vvjs/1vHqWN7/iI79fQF6aJEtjuOF7Z4NAK3JKXAEcnTilqaUuBwrUryFEc147l5hSdSyvLQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=tGl1NN6/; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716315730; x=1716920530; i=markus.elfring@web.de;
	bh=c7B+5QE89M7OwcRDj+HTxHq9BmlfVneW2jXpR/gvwOY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tGl1NN6/+Lj6dQJSjtPeq0ACLT4/0kjhxlv4SAfnJa3HBhGkFsfAyNHPy35D759K
	 t2hnICWy9MMyI5qu3HfgP+1o9NJYRgEk7h88qkgT6rJnhq+hTVMWydWbqeDSz9CRC
	 Gz42JK0yXeTz9rsn4REc5e5rtu/h73k+Mq9EDNPrYLt1FE5l8sfjnD7UrWm9wvPX4
	 hanKeSBR52WrFQrpqzp5up41s/zY6N5ghOe4ufbApJ6VoooeXuYyoup/FwqWPBeUH
	 OMBMPIySMQ7F3pvwzJwCBQM2JGVRo4eSA63GyMh/japHw8xquDTm7NlMJugoTtap8
	 mkAuSeDUBXc9f2NlnA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MECGX-1sHQDn2k21-000t2q; Tue, 21
 May 2024 20:22:10 +0200
Message-ID: <b3c8457b-f652-4f1d-a02f-e5a7325b18bb@web.de>
Date: Tue, 21 May 2024 20:22:09 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
 dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Sriramakrishnan <srk@ti.com>,
 Vinod Koul <vkoul@kernel.org>
References: <8b2e4b7f-50ae-4017-adf2-2e990cd45a25@gmail.com>
Subject: Re: [PATCH] dmaengine: ti: k3-udma-glue: Fix
 of_k3_udma_glue_parse_chn_by_id()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <8b2e4b7f-50ae-4017-adf2-2e990cd45a25@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xogqoaHaSC79ejr9VphriOgXBheNu5oGjdeP3q98+LPbRGOScjb
 ah39vJLunugdbRWObZhqvofD7vWsixMskB+NydYrYJVHWmiVajIflSd//iA6lfQGV90AKfZ
 bYbE0vBWa5Fgh5QLm09sLTGUOedv61U+vsq3bDltG7p16ZtssDOHQb6+hdRTSZyWnaVfLdy
 lR97VyR01Wsxw2gZ79vLg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:F6R05AOwJUs=;1LRb1GC4V/UJeqvCdATt8i1sVfQ
 3CEjC3UO/Gt19d6M+D0Ajh+9Rydx9OjeCUTR7Htg/SenodM0hbQxJd2Kf9LrcOrVziDDUy5YT
 pBNDp889Py+a2Iu9hvrUSMzg9+KDmGCH2Df0v7SqeSmx06IywfSRiBA3uT+pNSJ3Ubz+eMfcQ
 vQ36f3+Dkvy8qqUsKqIzz921KlCHEXt57y5dhtjqxnU4vBqcEGWgFvT1oGTCv/Xu9Yc9WUtxT
 +QQon1stlORYYn1SOzgpQDA+vAqroWGxOTLUlR4jsH2Ojh3Ndy2SORgmzc403UBUT5bLvoYuF
 986F8M9WnKfNgG/EHv5dUYEv6LP7RTXadGujP9sfOI4v8jO9jT0FLg8m3BZxRlkeutFiJSJcQ
 YOBTY6r4IHNkhgdFrMR7pQ3X26qgHmiIi8Zr1JercuuFyLf6QdbmtfyFHXsEHcZBZVlSMz2fj
 MEblPpK/b8VhuIkm4DxIKH7vFegq8Vpt/SB7bVQjT5JfyKIBX+fGRjeqSzHtyNQXaH/UqQYo/
 NQfBYpd9NM/3ot1WLlZRWjwvZU14APMg8zgjeUWyJERpJE/kmNTbPLgfka//tX+LDYSLdyyue
 jUSE1ZEbk3Iv2+CD1sYiit0sJsBEx+jJHtRbAohLiNQX9RYUgGivx5ofJsUcbuRgIhpu5dJfy
 TtQaF9NgtbFZX+n/erzhdK3yjggvYQUebi44IxnBASLi2je3gLcTEe5rUGDIeb+/4t/uQemu0
 UrhYc+gLqjeyGZGAaTadJ2A0MUky80UcshuCtqlEQUu0YSvY21UcI6j1gMhp5Vik7c2sAI+rm
 KD2iO9CagZDxHGuHp4bKLrPmElOhpgLzNvHTmCqDiAZCY=

=E2=80=A6
> > without having incremented its reference at any point. Fix it.
>
> Acked-by: Peter Ujfalusi@gmail.com

Please improve the data representation for this tag.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9#n468

Regards,
Markus

