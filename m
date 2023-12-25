Return-Path: <dmaengine+bounces-655-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 946D481DFA3
	for <lists+dmaengine@lfdr.de>; Mon, 25 Dec 2023 11:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E88EEB20EF9
	for <lists+dmaengine@lfdr.de>; Mon, 25 Dec 2023 10:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3579C1EB34;
	Mon, 25 Dec 2023 10:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="myxSzruO"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5541D683;
	Mon, 25 Dec 2023 10:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703499345; x=1704104145; i=markus.elfring@web.de;
	bh=CX4XrVdpP/rmSF+luv1fR+SLA7jv9GtKDnHAzolDcMM=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=myxSzruOU3vRfAN2O6LiFDuj/unESZEhd6nw9RiCoQHUh4YNrvrINKLm/m5xmqk7
	 QaDwSDv8umiBs3JDwot7/NmLhhR+1gsaR8L5cgfJU9locZlmfYmwEhk1IE+RPfLp6
	 UuUsmMEywkwTBL3H2ZU5xD+rJWtMK4RQxp4cuBKMN/fOZ5BbB4JL4gaMI0Z6OaXrU
	 Kh6twsT7jugcLn2GXfU8nnKn6kjKUSXiDsWajce25VD6ss6TPVupq3vnZwZMr9SIM
	 ESfLgOGQo6MZlqrThqNSRoSYmnqK6Flc6P/49wV0xk7LojDXqmsG4DMiDK7Juzbxc
	 YZqQ6p9vHlSet0t+zg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N62yi-1rBCht0oHI-016ZhP; Mon, 25
 Dec 2023 11:15:45 +0100
Message-ID: <ebd531dd-60e3-4ac3-821e-aa9890960283@web.de>
Date: Mon, 25 Dec 2023 11:15:35 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: dmaengine@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 0/3] dmaengine: timb_dma: Adjustments for td_alloc_init_desc()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y/FD+iSa3EBExn1MYsUggKexGMnSjtrzkFIyPzLSRPcOsGI39BZ
 h1wWI7EqwreaymNkj43eUPt/hWzowCNY3bcwjmEZS5iGcDQAMv3P1/KR4fMNVZVnwHs5607
 3FNQcSEPwWrG+mfQxUfJGVDm2RhAZgRt15l+tDo1skSdq1WxN1L30zI6+Nfg9OoYm+Bd9T8
 ARmk6FBOzzhxzM+Mz6QFA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WWz7nW/Kxd4=;+P83b+SGk4yHHw1fHMJC69ld+qk
 yP4wwQ/ti30/QOf2fgSggNHMgr04+lhbRxnawNXcU5eWbazkDcYS5tPXS6ttFxncOzRoWmUkl
 1rbylmlpTihS0Q9ObcYYVHN+gUw+Oe8nnu1OnFCx8CcTkb0AzKMzoOQyA8UfGiOUPQJxikl/K
 NgYIbSv0WYhuMimgEiF64wPL22pGs7L6gQvJgCGahclYBiGfdVPXr90dHPjMmujf+7tnrLkUJ
 4l5XrR1a/vDhT0Ymc2XWGG6Onbyp+3eNyXYS7CsE6m3S9QVGlzakuZGz+Q0kB04aiOzBz3ROf
 ZJGae30e8H74zj7ffU1mQ01V5VcSWN++XupKlg52AqaR2RzPnGFuN+MM1UeGQf5am3g97t+1l
 I5QfxWRCgPvc5nYuz9VGoMNP75FbqeNYO2Ji6MeBCx/CRfIs/ZrND6U4FAwU+ATxr4EHn7ARi
 MAWLhMAtdpXmhn0hgfCc2uYdGFbOo20bOThpCxy23TfQ3RuzZMIj5PfTzd9lhk/0sLF95ShrC
 5ILOQiu88lRzDwoO1E6aYkSGLc7/jmm5udfAIbZJJu8aEUUtE+UdlMVowk7+h9G9a7QoiRY72
 s20OiAZLBLS/84dYDzqOp9fhM5b9BngAn1D84RMrZZe44RJanNEE+fTlgCMYP8DAY8rV8ilhB
 +gYkBCc8PvFhtm7qjWB6hXhTLNuLVe+NK02idUdEiEieAcjJCJZTwyXOghuogwO19e6o4MjTK
 5OZ501FpAK51lgdsqzo7KQYLRf0kjTiMhAAZ1sUp/KVyCuWUcuYknXm3hL70QMOU3QY7m1Vae
 CyaNlA7yi5SUTs7XIEY87K6gxkNrLINVS5A3zGnIlyLpmVXOG/vLlJOjuNv+Mf3EdB342mFdR
 IpN1cU/bkyommLkmXvifUxeneiAGj8b8j209zNKT9mPOTuSYWL5PrRMkRXVUaPvhoDYrpEL7m
 x/ONIuFbGZwS+COAphUKuOt2sCg=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 25 Dec 2023 11:05:45 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Return directly after a failed kzalloc()
  Improve a size determination
  One function call less after error detection

 drivers/dma/timb_dma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

=2D-
2.43.0


