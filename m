Return-Path: <dmaengine+bounces-2689-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C39930547
	for <lists+dmaengine@lfdr.de>; Sat, 13 Jul 2024 12:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2937E1F21853
	for <lists+dmaengine@lfdr.de>; Sat, 13 Jul 2024 10:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45C76EB55;
	Sat, 13 Jul 2024 10:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ZP3nL2AY"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6E042049;
	Sat, 13 Jul 2024 10:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720868122; cv=none; b=I3SvIsI03/6nyYIjiJukFILLdaOzDRBHbTZcA3Tt/lByuCeHrcyKfod+exG2DvqjbocwfHi4j53gMe6fHZ+AL5eZar9rt2UjTz7dSwa1YLO82djP30yeHESCdWjoRMXRGWHypl/9FNsu30sMjODOCHhXUMDgvK0ny/ZtS3oQWzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720868122; c=relaxed/simple;
	bh=Mdx3w8q7KQJYWfl/irAVZ9IeK4hNn9RgGyBFy7QYeBw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=owQ6BSu705s/5XVk93brnGTJ48YSYbAocv9HhAg8C7JIeD2vacL8CD2OZJiLJEr21QtZKoRDPyyM2TrOo969coNNKEU0B/TzPaihF0daXRCkgsCCkLVEzG3AEyGFKTDeGYQP8ru1HbFbnXYPnJ2I4N275//YlYLRqMNub28bPGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ZP3nL2AY; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720868110; x=1721472910; i=markus.elfring@web.de;
	bh=DhTEpLlivlrGpySqjjeN3M7w54ILJzJ9uQo+GK+NNOc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZP3nL2AYNbd5aQpzH8CWfqsWkXs1NppBIXKq3o38WV1s4DrtFovJUy4N3+WeQTqf
	 iA2QxhIGH9SOYNjotkXOHGH+Fbr8MUzHUOhH7jw6rBS0V7sZtkv3zDAsKRhVW9Hch
	 vB9YE9ulbmOerKLZWXfMSmwWmcaS0H4eXADIYd5F0UB/163m1eKq4fQk/G26fCN+h
	 Uxq1ARFy9uABb6yZp50rNIqtCMy3pqXBOiRn05iccTDhhb2fcHWnYVWN1YwjhQwje
	 M6fsvZU1gUvMe80jl1I1SdG23MkTwbsnQoOEVuLW8Nu8Re8qfJC4R4e5U9lnWBmWw
	 juW17I1net9lTQcZ1w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTvw0-1ssP1z3dac-00TlLs; Sat, 13
 Jul 2024 12:55:09 +0200
Message-ID: <2f694a65-218a-48cc-b0e6-fcca6aaf646f@web.de>
Date: Sat, 13 Jul 2024 12:55:09 +0200
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
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] dmaengine: Use seq_putc() in two functions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nWYO7sFfEEhfpedzY7Hgh1tN+t2UM9S+7icVE7Z25wrlc7ESInb
 LzUo48B+8mole+wVkYI0ACBVcCxhBfU/u2I2qVeCNXBe75jrwx+tkOvWEOSaQEQyG6lZtR6
 vXP51rV3nPOK542cxmy29oYtS2hNKY2x1MiaUNY+1N12ro7ZJl50q/90tNFj6zme2n4D7C+
 LdYL1xDNB4PpMJ1BQpW/w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JovllL977LQ=;VfNe0dWfllFPTCFnmjmqvPsXhlt
 tLpHkmnr1SH3dkc69gJeadpIT2GmrolXGjGJIDBZG8dGuel8d2YR6umuCbKUgwPjBMwimzAZS
 cLoDhfCZNgBSltJi/ODFGiPPQq1Da9pEeTEljolR1r1Rr2my+23Bv/vKNlLjFtL6RVfLRTbs2
 HXpsPT43C7smrluMJ6SddneW2rX0p82fvNuE7eyuI/dBET5duHIxSCvAS8PyTdD3DtAUhd3L3
 xdhvQX04gfV0EocyuxX9bzLYZfEDfvyNHOXH/FOyEh1Ha5cYIF6Yzy4bxUF39O/C0GsgBW6Hf
 F3LLRKYus5mvxqgacESpw3OA92OuSASg5fdG2sGUropu8pZFgeHlCcIssxDUdf210Jh2I5d1f
 /diDkFHwLQyJw8Wrg+QCixSRVhWc8dsIqk3HGWn9XwbHN0dZxDfBadoKfYWIJZuux+v7lvw5N
 Ll/W9TQKAKk5OMljhPYttJ2I94tzbg4J/dslzNRg08kEqes8z9a1rCXtHKP13mAXiSGWTZ9my
 WiKYb6ptD+j/op5XIj1vQ39FkwXqUsHl2L594EOSbcYH6vMI1YSI2EWvylGuZ8YS6/W6aJ+ZI
 QJy9rplSz5dUgQRh5jPqtEilO6rRz2a+nmNeEi24YlRkfUVKlZc80QOyCehB/EUZBfqrLp1Vk
 00eXEb1J2/5Bm2MRWnm34jCOABR3+kOqC7FQHOOGJEGKqwKv9SPXjaNAtpH0lO2rJWb2wXrKd
 bTE4wzIS3BvtYYS+Gxt9SBhVa1TtxkAGek8jaT5ozfOEk+o8VIPMBAecutvpBA9BIZKyNRvqt
 bDmz2HPApnZN3No40oRfvRsA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 13 Jul 2024 12:30:30 +0200

Single characters (line breaks) should be put into a sequence.
Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/dma/dmaengine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index c380a4dda77a..d098de909b1e 100644
=2D-- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -94,7 +94,7 @@ static void dmaengine_dbg_summary_show(struct seq_file *=
s,
 				seq_printf(s, " (via router: %s)\n",
 					dev_name(chan->router->dev));
 			else
-				seq_puts(s, "\n");
+				seq_putc(s, '\n');
 		}
 	}
 }
@@ -115,7 +115,7 @@ static int dmaengine_summary_show(struct seq_file *s, =
void *data)
 			dmaengine_dbg_summary_show(s, dma_dev);

 		if (!list_is_last(&dma_dev->global_node, &dma_device_list))
-			seq_puts(s, "\n");
+			seq_putc(s, '\n');
 	}
 	mutex_unlock(&dma_list_mutex);

=2D-
2.45.2


