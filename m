Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092174105F3
	for <lists+dmaengine@lfdr.de>; Sat, 18 Sep 2021 12:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235290AbhIRKnC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 18 Sep 2021 06:43:02 -0400
Received: from mout.gmx.net ([212.227.17.21]:54145 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234492AbhIRKnA (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 18 Sep 2021 06:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631961675;
        bh=BJyBSDq1vg3gPl9/hHfnt695lOw4ev4/ffazgBhzBCo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=IWcS6flJU9YNVYC5w3ByxN1KoStXSdVm6i5CtSFHFdWCCgTnH7yoJfqru5xpUWXu5
         qTg+2IMMYt0RYJYBmNbGJRfltyIfIp/IUxyb0yl0varXaWI3bsCLwWJHN3IE0eXuva
         FewU0JazI3EOavR0MDfpD/WEw3UqLvmrQAxlqQqk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MgvvJ-1n5rPj33NN-00hLOQ; Sat, 18 Sep 2021 12:41:14 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Len Baker <len.baker@gmx.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: pxa_dma: Prefer struct_size over open coded arithmetic
Date:   Sat, 18 Sep 2021 12:40:55 +0200
Message-Id: <20210918104055.8444-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aKPT9HrV3eSSCxGAWSMTQvGr3LwrGp+4r78lkLF0wZ5cm0aCXXV
 BfIzMcoW1vr0AKTwLukCf06hSyzSTMz6szYRSIPD35P8rT4enLt8b2/BLW3q0WS41glkBr5
 uWcmGw1zyHl/dOpiVa7rfJEfqe1J3qC95XlbpWRlc1L/nDk/fd5v2agCvzVzuumbAsQyVUm
 McKq8WoZ7IENYoVL3sO9Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:T7anHeQreg8=:mOX+MzsS6IIrLyXa8GTyoy
 r9uR+sNSkSKsUmKGYrbBiGJjcsRjkLFth7/BZkvIHtb8JJYr0+CTtB80TgMnrvcdg/T5OPS1h
 xnsCwADCVoWeX8/VG+jtGSBFZxrxor23gNS+voSYxtid7C9u5lrZ+ujxWKABSXMdjBIl2NdmW
 bY9uyVl5wvdoXOJHyXZPz4ivGWWxKshJ0Ctd/7tPjL2E+RcKc9otm1wAO1Emv3DqUFuKmsM/f
 hYCUyqAqYCDWbhPpjVQYTED4ZZk+qLWAiHjwZJlNM8enxK3H6+X3R5cH3ClupkT9Hwb8Z9sL3
 qD55ABaLvqqNc2BpDncYTNPNItdMRJHhQc3YxLLdoIkUOqF8+qiON0XwPnklgR3noVOcV4/i+
 o21Fs8QbNyW2HTM5fXfJfhIqrwd3YjQTW4VVQq8COIssSAtdz1uXi09H8cfdsXCwnka0wqKyq
 92LHoVbpOguxcFDTEgYl88SsZ9M6wAjbDl0JMm+oXZyrZws/RmtF2Pk/LTvnCwoRM5q5zV/7b
 rbB/N1s3ngVnvb7P1u4gArr/CtOUkMnWjYvzHSG0UTS7PXPuUGGZtR44jr936cH5ct1GO3wOQ
 mHqdgclGgCFuflhDgpdr3Mon8xPfAd1GUj4m64xmaJ7enSldZmMhraQhxuGNG1bhzGbEDHdkY
 792qzcFZCyt/af+4+WVUrycpKDfHAlblzdjowPPvysO4Z5lXJWatopbRn2BUoolr1Yt8XeJmZ
 BbSOFmPtjYMaKDpRBFd6wXxqk7BFLQuCB6lZPKlGYPI1MT23T7Q4DLGI+hpRnZl13Kf0r+CGE
 2Myx7EA2O8a0yd2LMh3lLKLFzongDWFEIujeHLmGMPOC/+MHtPt+hdl/lKczhwPWyQn/uFP1O
 3WGnvpbs0u3geBJV9mfQ+P2FU/zq7F9wvG72dZeJNYQihTYdrsqIs1u1WuGwpMZlkx06xQuit
 dtTSDAlWH/jJVwIllBevHz1DPjPebW7T+FmnQWu8SRxzbAMscnmWFLt5MPSBDFpDCaLg9A17O
 pqFb53rnfwYRDgnsZKTEg4nNymuZK+R/MWIgZyImTyK7WFTsLtfGBSy/mCLrZiXdxD43RBmu4
 mO080zyroYDgp8=
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

So, use the struct_size() helper to do the arithmetic instead of the
argument "size + count * size" in the kzalloc() function.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#open-co=
ded-arithmetic-in-allocator-arguments

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
 drivers/dma/pxa_dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index 4a2a796e348c..52d04641e361 100644
=2D-- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -742,8 +742,7 @@ pxad_alloc_desc(struct pxad_chan *chan, unsigned int n=
b_hw_desc)
 	dma_addr_t dma;
 	int i;

-	sw_desc =3D kzalloc(sizeof(*sw_desc) +
-			  nb_hw_desc * sizeof(struct pxad_desc_hw *),
+	sw_desc =3D kzalloc(struct_size(sw_desc, hw_desc, nb_hw_desc),
 			  GFP_NOWAIT);
 	if (!sw_desc)
 		return NULL;
=2D-
2.25.1

