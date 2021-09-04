Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5BCE400BBB
	for <lists+dmaengine@lfdr.de>; Sat,  4 Sep 2021 16:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbhIDO7r (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 4 Sep 2021 10:59:47 -0400
Received: from mout.gmx.net ([212.227.15.18]:44473 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230514AbhIDO7q (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 4 Sep 2021 10:59:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630767520;
        bh=kHtuAbYiiBfGxvhY45tuo5q2d2Qu8ss/9ZK1wHJ1PWA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Wj532fDDWd7ji7XrN17RIRGtf/MgSvCBh+8fW7803p2BqmLxsR8MYSTobDjCbVd3U
         wmaVGPvjLCN6kC20IJ/GbQgXzF4q4QZ7Q2GMGqj1y7Rmdj+bPFg2B5PPrZJTIP6Gl2
         n9OPlXux4V2tKE2JNAP9TOpQI2PhM5KN+cBv/hZ0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MybKp-1nBtic3Mq5-00yzDG; Sat, 04 Sep 2021 16:58:39 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Len Baker <len.baker@gmx.com>, Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: milbeaut-hdmac: Prefer kcalloc over open coded arithmetic
Date:   Sat,  4 Sep 2021 16:58:13 +0200
Message-Id: <20210904145813.5161-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NSQFmTYhh/v2YneA2W5Ogc8MRxblor3ZiAgHPc+Z3Fg9SuI3aN8
 /+x7hJn+9pOrlLQfyzRLGYbnCoaTk0GppfuHyJwHf8q4sbq1c5HITIzK7E9+NoRAl9izBhF
 JMTQ830MDv6lRKX8j3lRT+heSk9Wdy+Vl8va/12qCess5IkxRQaQBZiqrsWE/pZNZ5oxTC/
 sOe6BHT4QTXqbs47F1ruw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qex0b/X3PnI=:hitT94Zrb/n84OxuD0tlVr
 MxRw+2EmoU5WK0rtdpk+rJRlA+Tpk4h124IU4P9YBdaXi5Q/vNHG6ecGn3rNlFlDYqkZnsItD
 FNwXE2IVeIRXtsOJ+Uhacr5NGv7MdK8HKQ2DmZ1w1s5oc9pB0Gv3QlGEevl+NEoycWh1eKcV1
 dSBfLTRh3VTa7Lz0R5ozdVKCfFSnrMSXT4JyIfdquH/dCqEBhJXevDPT5E83VO9hQlVYQCpvD
 A+p9qVKuIgWfFyqRQ0GcdoItFZXxciKPbMHEr5OsTgqbVvYHPUZ/Y9A0W6wpp0UHkChwmWgWV
 o2Sw4u4jiovfqIDxe9OKOYSNbwAi4+yZyq4fRb2GUboJqjU1Z2lltIsPYljXzdERlfCEpfF2A
 JS7c33WMd8/vmE23E2mySnJO9Yh214wVM20NU4bgGnvlGB1CKF2HeerdDDce92ATEN0oJHNZL
 CeuO/3ziMBrmQ8l9+N94RAKDi4HQfOXjtaKHc6bPbevh18bEOegnd6HJ8jHdvhT255cwcq2kT
 nEqhH8wlIj4CD/ucfc8QhGcp76yjwF4EMDwP5qfVbEII3f9stXeyWZaajPko/G/rTHNyGz/cE
 fzrRFYWRE/V8avPkUb75hExN17ZSzOafax+Cy9dUtgUX+CiOJ7xS45MZR8BkBZxtZHLV8nvcf
 Aw387J0v5PhTIjNgpMH6OuTKuGsxnl5F7NjhA3ekxbER6IQGQOfhrfu7zG0MCEOP2xmYu+3rp
 UaHhGIoFCXl6Qhf+4j+bpua0PKIb7hS2wTcEFZd0O0I6902VPOHSk1ioB23vU0ueWDNrJf4Dt
 2VWWaq3574Jm1hpdBJ1YN9ager1hT2x05NlyWaUq6Z5+Eocn+/i+SlLwOn6isFS6rAj2wAo9G
 Y4ygFOrA3sGzAtYX0Kirq3dXhe3hueTVjokP1BUeyy2u7UCtkKzVbnhpdNXlCgy1sP6Sj9ynI
 qSPJ7COsJzyOKeD6dFyl7w+ebmwBnCbFbe96me1x3o4xZStvddcbXsob/AjP0lTBjPETUUjgE
 h6wIbQ/9mRjTu0k/ccY9OwmkxUbX/P25hRmCuN2n4vN6oKG3jREztQPgDvlGdEjMXLyjRG62f
 HUTtinN2SjgaL/EWm40Rhy6WVoKvEGq8xiMR3F4iGbVvoVD3PQ3qL1aXw==
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

As noted in the "Deprecated Interfaces, Language Features, Attributes,
and Conventions" documentation [1], size calculations (especially
multiplication) should not be performed in memory allocator (or similar)
function arguments due to the risk of them overflowing. This could lead
to values wrapping around and a smaller allocation being made than the
caller was expecting. Using those allocations could lead to linear
overflows of heap memory and other misbehaviors.

So, use the purpose specific kcalloc() function instead of the argument
size * count in the kzalloc() function.

[1] https://www.kernel.org/doc/html/v5.14/process/deprecated.html#open-cod=
ed-arithmetic-in-allocator-arguments

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
 drivers/dma/milbeaut-hdmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/milbeaut-hdmac.c b/drivers/dma/milbeaut-hdmac.c
index a8cfb59f6efe..1b0a95892627 100644
=2D-- a/drivers/dma/milbeaut-hdmac.c
+++ b/drivers/dma/milbeaut-hdmac.c
@@ -269,7 +269,7 @@ milbeaut_hdmac_prep_slave_sg(struct dma_chan *chan, st=
ruct scatterlist *sgl,
 	if (!md)
 		return NULL;

-	md->sgl =3D kzalloc(sizeof(*sgl) * sg_len, GFP_NOWAIT);
+	md->sgl =3D kcalloc(sg_len, sizeof(*sgl), GFP_NOWAIT);
 	if (!md->sgl) {
 		kfree(md);
 		return NULL;
=2D-
2.25.1

